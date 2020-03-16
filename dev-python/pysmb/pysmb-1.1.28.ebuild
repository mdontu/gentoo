# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{6,7} )
inherit distutils-r1 versionator

MY_P="rel-$(replace_all_version_separators '-')"

DESCRIPTION="A pure Python implementation of the client-side SMB/CIFS protocol"
HOMEPAGE="https://miketeo.net/wp/index.php/projects/pysmb"
SRC_URI="https://github.com/miketeo/pysmb/archive/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/pyasn1[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

S="${WORKDIR}"/${PN}-${MY_P}
