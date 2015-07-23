EAPI=5

inherit eutils git-r3 scons-utils

DESCRIPTION="Simple XMPP IM client"
HOMEPAGE="http://swift.im/"
EGIT_REPO_URI="git://swift.im/swift"
EGIT_COMMIT="swift-3.0beta2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-qt/qtgui:4"
DEPEND="${RDEPEND}"

src_compile() {
	escons Swift
}

src_install() {
	escons SWIFT_INSTALLDIR="${D}" "${D}"
}
