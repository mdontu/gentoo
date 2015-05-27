inherit linux-mod eutils git-2

DESCRIPTION="Driver for the rtl8192du wireless chipset"
HOMEPAGE="https://github.com/lwfinger/rtl8192du"
SRC_URI=""
EGIT_REPO_URI="https://github.com/lwfinger/rtl8192du.git"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND="net-wireless/wireless-tools"
SLOT="0"

MODULE_NAMES="8192du(net:)"
CONFIG_CHECK="CRYPTO CRYPTO_ARC4 CRC32"
BUILD_TARGETS="all"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KSRC=${KV_OUT_DIR}"
}

src_install() {
	linux-mod_src_install

	dodoc README.md
}
