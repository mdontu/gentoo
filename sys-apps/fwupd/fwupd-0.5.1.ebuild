EAPI=5

inherit autotools eutils

DESCRIPTION="A simple daemon to allow session software to update firmware"
HOMEPAGE="https://github.com/hughsie/fwupd.git"
SRC_URI="https://github.com/hughsie/fwupd/archive/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="colorhug introspection uefi"

RDEPEND=">=dev-libs/glib-2.45.8:2
         >=net-libs/libsoup-2.51.92"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable colorhug) \
		$(use_enable introspection) \
		$(use_enable uefi)
}
