EAPI=5

inherit eutils

DESCRIPTION="Firmware Updater"
HOMEPAGE="https://github.com/rhinstaller/fwupdate"
SRC_URI="https://github.com/rhinstaller/fwupdate/releases/download/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-crypt/pesign"

PATCHES=( "${FILESDIR}/${PN}-disable-pesign.patch" )

src_prepare()
{
	epatch "${FILESDIR}/${PN}-disable-pesign.patch"
}

src_compile()
{
	emake GNUEFIDIR="/usr/$(get_libdir)"
}
