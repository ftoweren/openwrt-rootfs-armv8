# Openwrt-24.10.4 | SSH | Luci | Ookla Speedtest

_general info:_

- Openwrt-24.10.4 (linux/aarch64) from locally, downloaded from:
```
https://downloads.openwrt.org/releases/24.10.4/targets/armsr/armv8/openwrt-24.10.4-armsr-armv8-rootfs.tar.gz
```
- Luci with Material theme, no password root login, access from exposed port http
- Removed Firewall Zone
- Lan act as WAN
- Ookla Speedtest (CLI):
```
https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-linux-aarch64.tgz
```
- Active SSH (no password for first login)
- Expose ssh 22 (8822:22), DNS 53 (8853:53), http 80 (8880:80), https 443 (8843:443)
- Built and tested on ARM64 device (ZTE B860H v.2) with Armbian Community v25.11 running:
```
https://github.com/armbian/community/releases/download/25.11.0-trunk.472/Armbian_community_25.11.0-trunk.472_Aml-s9xx-box_trixie_current_6.12.57_minimal.img.xz
```

---

## Quick Start

### Pull Image
```bash
docker pull ftoweren/openwrt-rootfs-armv8
```

### Run Container
```bash
docker run -itd -p 8822:22 -p 8853:53 -p 8880:80 -p 8843:443 --name openwrt-armv8 --privileged --cap-add NET_ADMIN --cap-add NET_RAW ftoweren/openwrt-rootfs-armv8
```

### Post-Installation Management
Change Container Root Password (if needed):
```bash
docker exec -it openwrt-armv8 passwd
```
---

## Build from Source

### Build Docker Image
```
docker build --no-cache -f path/Dockerfile -t openwrt-rootfs-armv8 .
```
