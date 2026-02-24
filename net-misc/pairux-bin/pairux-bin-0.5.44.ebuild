# Copyright 2024 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Collaborative screen sharing with remote control"
HOMEPAGE="https://pairux.com"
SRC_URI="https://github.com/profullstack/pairux.com/releases/download/v${PV}/PairUX-${PV}-x86_64.AppImage -> ${P}.AppImage"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/nss
	media-libs/alsa-lib
	sys-apps/fuse:0
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	x11-libs/libXtst
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

QA_PREBUILT="opt/pairux/*"

src_unpack() {
	cp "${DISTDIR}/${P}.AppImage" "${S}/" || die
}

src_install() {
	# Install AppImage
	insinto /opt/pairux
	doins "${P}.AppImage"
	fperms 0755 "/opt/pairux/${P}.AppImage"

	# Create wrapper script
	dobin "${FILESDIR}/pairux"

	# Install desktop file
	insinto /usr/share/applications
	doins "${FILESDIR}/pairux.desktop"

	# Extract and install icon
	"${S}/${P}.AppImage" --appimage-extract usr/share/icons/hicolor/512x512/apps/*.png 2>/dev/null || true
	if [[ -f squashfs-root/usr/share/icons/hicolor/512x512/apps/*.png ]]; then
		insinto /usr/share/pixmaps
		newins squashfs-root/usr/share/icons/hicolor/512x512/apps/*.png pairux.png
	fi
	rm -rf squashfs-root
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
