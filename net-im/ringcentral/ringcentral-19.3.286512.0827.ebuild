EAPI=6

inherit fdo-mime gnome2-utils unpacker versionator

DESCRIPTION="Video Conferencing and Web Conferencing Service"
HOMEPAGE="https://www.ringcentral.com/"
KEYWORDS="~amd64"
SRC_URI="https://ringcentral.zoom.us/client/latest/${PN}_amd64.deb -> ${PN}_${PV}_amd64.deb"
SLOT="0"
LICENSE=""
S="${WORKDIR}"

src_prepare() {
	rm ${S}/_gpgbuilder
	default
}

src_install() {
	insinto /opt

	doins -r opt/ringcentral

	exeinto /opt/ringcentral

	doexe opt/ringcentral/RingcentralLauncher
	doexe opt/ringcentral/QtWebEngineProcess
	doexe opt/ringcentral/qtdiag
	doexe opt/ringcentral/ringcentral
	doexe opt/ringcentral/ringcentral.sh
	doexe opt/ringcentral/ringcentrallinux
	doexe opt/ringcentral/zopen

	dosym /opt/ringcentral/RingcentralLauncher /usr/bin/ringcentral

	insinto /usr
	doins -r usr/share
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
