EAPI=5

inherit autotools eutils git-2

DESCRIPTION="iucode-tool for converting between firmware formats"
HOMEPAGE="https://gitorious.org/iucode-tool"
EGIT_REPO_URI="https://gitorious.org/iucode-tool/iucode-tool.git"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"

src_prepare()
{
        eautoreconf
        default
}
