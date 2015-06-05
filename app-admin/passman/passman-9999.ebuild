EAPI=5

inherit eutils git-r3 qmake-utils

DESCRIPTION="Simple and efficient password manager"
HOMEPAGE="https://github.com/ileonte/passman"
EGIT_REPO_URI="https://github.com/ileonte/passman.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kde"

RDEPEND="
	dev-qt/qtgui:5
	kde? (
		dev-qt/qtcore:4
		kde-apps/kwalletd:4
	)
"

DEPEND="${RDEPEND}"

src_configure() {
	eqmake5 DEFINES+=WALLET_PLUGIN_DIR=\\\\\\\"/usr/$(get_libdir)/passman\\\\\\\" DEFINES+=QT_NO_DEBUG_OUTPUT
	if use kde; then
		cd wallets
		eqmake4 CONFIG+=kwallet4
	fi
}

src_compile() {
	if use kde; then
		emake -C wallets
	fi
	emake
}

src_install() {
	dobin passman
	if use kde; then
		insinto /usr/$(get_libdir)/passman
		doins wallets/libwallet_kw4.so
	fi
}
