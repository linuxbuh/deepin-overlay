# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="Deepin desktop environment - Dock module"
HOMEPAGE="https://github.com/linuxdeepin/dde-dock"
SRC_URI="https://community-packages.deepin.com/deepin/pool/main/d/${PN}/${PN}_${PV}+c3.orig.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtsvg:5
		 dev-qt/qtx11extras:5
		 >=dde-base/deepin-menu-5.0.1
		 >=dde-base/dde-daemon-5.9.5
		 >=dde-base/dde-network-utils-5.0.4
		 >=dde-base/dde-qt5integration-5.1.0
		 app-accessibility/onboard
       	 >=dde-base/dtkwidget-5.1.2:=
	     "
DEPEND="${RDEPEND}
		virtual/pkgconfig
		x11-libs/xcb-util-image
		x11-libs/libxcb
		x11-libs/xcb-util-wm
		x11-libs/libXtst
		>=dde-base/dde-qt-dbus-factory-5.0.16
		x11-libs/gsettings-qt
		dev-libs/libdbusmenu-qt
	    "

S="${WORKDIR}/${P}+c3"

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|lib/|${LIBDIR}/|g" plugins/*/CMakeLists.txt
	sed -i "s|/usr/lib/|/usr/${LIBDIR}/|g" \
		frame/controller/dockpluginscontroller.cpp \
		plugins/tray/system-trays/systemtrayscontroller.cpp || die

	cmake-utils_src_prepare
}

