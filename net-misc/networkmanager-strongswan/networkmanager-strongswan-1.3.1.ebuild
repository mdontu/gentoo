# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils versionator

# NetworkManager likes itself with capital letters
MY_P=${P/networkmanager/NetworkManager}
MYPV_MINOR=$(get_version_component_range 1-2)

DESCRIPTION="NetworkManager StrongSwan plugin."
HOMEPAGE="http://www.strongswan.org/"
SRC_URI="http://download.strongswan.org/NetworkManager/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=net-misc/networkmanager-0.7
	>=net-misc/strongswan-4.3.3[networkmanager]
	gnome-base/libgnomeui"

DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_configure() {
	ECONF="--disable-more-warnings \
	       --with-charon=/usr/libexec/ipsec/charon-nm"

	econf ${ECONF}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc NEWS || die "dodoc failed"
}
