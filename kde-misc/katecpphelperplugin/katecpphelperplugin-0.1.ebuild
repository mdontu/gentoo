EAPI=5

inherit kde4-base git-2

DESCRIPTION="Kate C++ helper plugin"
HOMEPAGE="http://zaufi.github.io/kate-cpp-helper-plugin.html"
EGIT_REPO_URI="https://github.com/zaufi/kate-cpp-helper-plugin.git"

LICENSE="GPL-3+"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	dev-libs/boost
	dev-libs/xapian
	sys-devel/clang
"
RDEPEND="
	$(add_kdebase_dep kate)
"
