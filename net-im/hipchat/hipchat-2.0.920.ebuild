# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit rpm

RPM_P="${P}-1"

DESCRIPTION="HipChat XMPP client"
HOMEPAGE="https://www.hipchat.com"
SRC_URI="http://downloads.hipchat.com/linux/yum/x86_64/${RPM_P}.x86_64.rpm"

LICENSE="Atlassian"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack () {
	rpm_src_unpack
}

src_install () {
	cp -pPR * "${D}"
}
