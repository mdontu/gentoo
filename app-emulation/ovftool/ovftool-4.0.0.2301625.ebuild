# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-vix/vmware-vix-1.11.4.744019.ebuild,v 1.2 2012/10/29 14:51:08 flameeyes Exp $

EAPI="4"

inherit eutils versionator vmware-bundle

MY_PN="VMware-ovftool"
MY_PV="$(replace_version_separator 3 - $PV)"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="OVF Tool for Linux"
HOMEPAGE="https://www.vmware.com/support/developer/ovf/"
SRC_URI="
	x86? ( ${MY_P}-lin.i386.bundle )
	amd64? ( ${MY_P}-lin.x86_64.bundle )
	"

LICENSE="vmware"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="doc"
RESTRICT="fetch mirror strip"

# vmware-workstation should not use virtual/libc as this is a
# precompiled binary package thats linked to glibc.
RDEPEND="
	dev-libs/glib:2
	dev-libs/libxml2
	dev-libs/openssl
	net-misc/curl
	sys-libs/glibc
	sys-libs/zlib
	!app-emulation/vmware-vix"

S=${WORKDIR}
VM_INSTALL_DIR="/opt/vmware"

pkg_nofetch() {
	local bundle

	if use x86; then
		bundle="${MY_P}-lin.i386.bundle"
	elif use amd64; then
		bundle="${MY_P}-lin.x86_64.bundle"
	fi

	einfo "Please download ${bundle}"
	einfo "from ${HOMEPAGE}"
	einfo "and place it in ${DISTDIR}"
}

src_unpack() {
	local component; for component in \
		vmware-ovftool
	do
		vmware-bundle_extract-bundle-component "${DISTDIR}/${A}" "${component}" "${S}"
	done
}

src_install() {
	# install the libraries
	insinto "${VM_INSTALL_DIR}"/lib/vmware-ovftool
	doins -r *

	# fix the permissions
	fperms 0755 "${VM_INSTALL_DIR}"/lib/vmware-ovftool/ovftool.bin
	fperms 0755 "${VM_INSTALL_DIR}"/lib/vmware-ovftool/ovftool

	# create ovftool symlink
	dosym "${VM_INSTALL_DIR}"/lib/vmware-ovftool/ovftool "${VM_INSTALL_DIR}"/bin/ovftool

	# create the environment
	local envd="${T}/90${PN}"
	cat > "${envd}" <<-EOF
		PATH='${VM_INSTALL_DIR}/bin'
		ROOTPATH='${VM_INSTALL_DIR}/bin'
	EOF
	doenvd "${envd}"
}

pkg_postinst() {
	ewarn "/etc/env.d was updated. Please run:"
	ewarn "env-update && source /etc/profile"
}
