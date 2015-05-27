# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils gnome2-utils unpacker

DESCRIPTION="Steam Content Distribution Application from Valve"
HOMEPAGE="http://www.steampowered.com"
SRC_URI="http://repo.steampowered.com/steam/archive/precise/steam_latest.deb"

LICENSE="Valve"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

pkg_preinst ()
{
	gnome2_icon_savelist
}

pkg_postinst ()
{
	gnome2_icon_cache_update
}

pkg_postrm ()
{
	gnome2_icon_cache_update
}

src_install ()
{
	rm -rf etc/apt
	cp -pPR etc lib usr "${D}"
}
