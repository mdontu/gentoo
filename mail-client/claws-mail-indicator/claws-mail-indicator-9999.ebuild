EAPI=5

inherit eutils git-r3

DESCRIPTION="Claws Mail notification plugin using libappindicator"
HOMEPAGE="https://github.com/ileonte/claws-mail-indicator"
EGIT_REPO_URI="https://github.com/ileonte/claws-mail-indicator.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 -x86"

RDEPEND="
	dev-libs/libappindicator
	mail-client/claws-mail
"
DEPEND="${RDEPEND}"

src_compile() {
	emake
}

src_install() {
	dodir /usr/$(get_libdir)/claws-mail/plugins
	cp "${S}/build/lib/indicator.so" "${D}/usr/$(get_libdir)/claws-mail/plugins"
}
