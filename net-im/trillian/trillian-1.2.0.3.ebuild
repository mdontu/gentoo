# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit rpm

RPM_P="${P}-1"

DESCRIPTION="Trillian IM client"
HOMEPAGE="https://www.trillian.im"
SRC_URI="https://www.trillian.im/get/linux/1.2/${RPM_P}.fc19.x86_64.rpm"

LICENSE="Trillian"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack () {
	rpm_src_unpack
}

src_install () {
	cp -pPR * "${D}"
}
