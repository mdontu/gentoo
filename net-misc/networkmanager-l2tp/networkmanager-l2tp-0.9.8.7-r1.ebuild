# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
GCONF_DEBUG="no"
GNOME_ORG_MODULE="NetworkManager-${PN##*-}"

inherit gnome2 autotools

DESCRIPTION="NetworkManager L2TP plugin"
HOMEPAGE="https://github.com/seriyps/NetworkManager-l2tp"
SRC_URI="https://github.com/seriyps/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

RDEPEND="
	>=net-misc/networkmanager-0.9.6
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/glib-2.32:2
	net-dialup/ppp:=
	net-dialup/pptpclient
	gtk? (
		app-crypt/libsecret
		>=gnome-extra/nm-applet-0.9.9.0
		>=x11-libs/gtk+-3.4:3
	)
	net-dialup/xl2tpd
"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	virtual/pkgconfig
	gtk? (
		gnome-base/libgnome-keyring
	)
"

S="${WORKDIR}/NetworkManager-l2tp-${PV}"

src_prepare() {
	eautoreconf
}

src_configure() {
	local myconf
	# Same hack as net-dialup/pptpd to get proper plugin dir for ppp, bug #519986
	local PPPD_VER=`best_version net-dialup/ppp`
	PPPD_VER=${PPPD_VER#*/*-} #reduce it to ${PV}-${PR}
	PPPD_VER=${PPPD_VER%%[_-]*} # main version without beta/pre/patch/revision
	myconf="${myconf} --with-pppd-plugin-dir=/usr/$(get_libdir)/pppd/${PPPD_VER}"

	gnome2_src_configure \
		--disable-more-warnings \
		--disable-static \
		--with-dist-version=Gentoo \
		$(use_with gtk gnome) \
		${myconf}
}
