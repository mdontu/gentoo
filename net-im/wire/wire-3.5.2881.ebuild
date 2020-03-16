EAPI=6

inherit fdo-mime gnome2-utils unpacker versionator

DESCRIPTION="Wire Messenger"
HOMEPAGE="https://wire.com/"
KEYWORDS="~amd64"
SRC_URI="https://wire-app.wire.com/linux/debian/pool/main/wire_${PV}_amd64.deb"
SLOT="0"
LICENSE=""
S="${WORKDIR}"

src_install() {
	exeinto /opt/Wire
	exeopts -m0755
	doexe "${S}/opt/Wire/wire-desktop"
	fperms 0755 /opt/Wire/wire-desktop

	insinto /opt
	doins -r "${S}/opt/Wire"

	insinto /usr
	doins -r "${S}/usr/share"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
 	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
