# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
WANT_AUTOCONF="2.1"

inherit eutils autotools toolchain-funcs mozconfig-3 fdo-mime

DESCRIPTION="Cross-platform instant messenging client based on XULRunner and libpurple"
HOMEPAGE="http://www.instantbird.com/"
SRC_URI="http://www.${PN}.com/downloads/${PV}/${P}.src.tgz"

S="${WORKDIR}/${P}-src"

LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bindist avahi gconf system-cairo"

RESTRICT="primaryuri"

RDEPEND="dev-libs/libxml2
	x11-libs/libXt
	>=media-libs/libpng-1.5.11[apng]
	net-misc/curl
	media-libs/mesa
	>=dev-libs/nspr-4.9.2
	>=dev-libs/nss-3.13.2
	>=sys-libs/zlib-1.2.3
	>=x11-libs/pango-1.14.0
	>=x11-libs/pixman-0.19.2
	app-arch/bzip2
	virtual/libffi
	system-cairo? ( >=x11-libs/cairo-1.12[X] )
	avahi? ( net-dns/avahi )
	system-sqlite? ( >=dev-db/sqlite-3.7.13[fts3,secure-delete,threadsafe,unlock-notify,debug=] )
	gconf? ( >=gnome-base/gconf-1.2.1:2 )"

DEPEND=">=dev-lang/yasm-1.1
	virtual/pkgconfig"

MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
IB_OBJDIR="obj-instantbird"

#TODO: implicit (eclass) svg dependency

pkg_setup() {
	moz_pkgsetup

	if ! use bindist ; then
		elog "You are enabling official branding. You may not redistribute this build"
		elog "to any users on your network or the internet. Doing so puts yourself into"
		elog "a legal problem with Mozilla Foundation"
		elog "You can disable it by emerging ${PN} _with_ the bindist USE-flag"
		elog
	fi
}

src_prepare() {
	#epatch "${FILESDIR}/${P}-system-cairo-1.10.patch"
	epatch_user
	eautoreconf
	# Ensure we run eautoreconf in mozilla to regenerate configure
	cd "${S}"/mozilla
	eautoconf

	cd "${S}"
	[[ -e mozconfig ]] && rm mozconfig
}

configure_ib_debug() {
	if use debug ; then
		mozconfig_annotate 'debug' --disable-optimize
		mozconfig_annotate 'debug' --disable-jemalloc
		mozconfig_annotate 'debug' --enable-valgrind
	else
		mozconfig_annotate '-debug' --enable-optimize
	fi
}

src_configure() {
	local eb='added by ebuild'
	MEXTENSIONS="default"

	mozconfig_init
	mozconfig_config
	mozconfig_annotate "$eb" --enable-application="${PN}"
	mozconfig_annotate "$eb" --prefix="${EPREFIX}"/usr
	mozconfig_annotate "$eb" --libdir="${EPREFIX}"/usr/$(get_libdir)
	mozconfig_annotate "$eb" --with-default-mozilla-five-home="${EPREFIX}${MOZILLA_FIVE_HOME}"
	mozconfig_annotate "$eb" --enable-extensions="${MEXTENSIONS}"

	mozconfig_annotate "$eb" --with-system-png
	mozconfig_annotate "$eb" --with-system-bz2
	mozconfig_annotate "$eb" --enable-system-ffi
	mozconfig_annotate "$eb" --enable-system-pixman
	mozconfig_annotate "$eb" --enable-ogg

	mozconfig_use_enable system-sqlite
	mozconfig_use_enable gconf
	mozconfig_use_enable avahi bonjour

	configure_ib_debug
	echo "mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/../${IB_OBJDIR}" >> .mozconfig
	use native-cairo && sed -i '/ac_add_options\s\{1,\}--enable-system-cairo/d' .mozconfig
	mozconfig_final

	if [[ $(gcc-major-version) -lt 4 ]]; then
		append-cxxflags -fno-stack-protector
	elif [[ $(gcc-major-version) -gt 4 || $(gcc-minor-version) -gt 3 ]]; then
		append-flags -mno-avx
	fi
}

src_compile() {
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	MOZ_MAKE_FLAGS="${MAKEOPTS}" \
	emake -f client.mk build
}

src_install() {
	emake DESTDIR="${D}" -f client.mk install

	newicon "${S}"/instantbird/branding/release/mozicon128.png ${PN}.png
	make_desktop_entry ${PN} "Instantbird Messenger" ${PN}
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}
