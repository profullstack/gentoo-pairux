# PairUX Gentoo Overlay

Gentoo overlay for [PairUX](https://pairux.com) - Collaborative screen sharing with remote control.

## Installation

### Using eselect-repository (recommended)

```bash
# Install eselect-repository if not already installed
sudo emerge app-eselect/eselect-repository

# Add the overlay
sudo eselect repository add pairux git https://github.com/profullstack/gentoo-pairux.git

# Sync the overlay
sudo emaint sync -r pairux

# Install PairUX
sudo emerge net-misc/pairux-bin
```

### Using layman (deprecated)

```bash
# Add overlay
sudo layman -o https://raw.githubusercontent.com/profullstack/gentoo-pairux/master/repositories.xml -f -a pairux

# Install
sudo emerge net-misc/pairux-bin
```

## Package Info

- **Category:** net-misc
- **Package:** pairux-bin
- **Version:** 0.3.1
- **License:** MIT

## Uninstall

```bash
sudo emerge --unmerge net-misc/pairux-bin
sudo eselect repository remove pairux
```

## License

MIT
