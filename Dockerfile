FROM scratch
#https://downloads.openwrt.org/releases/24.10.4/targets/armsr/armv8/openwrt-24.10.4-armsr-armv8-rootfs.tar.gz⁠
ADD openwrt-24.10.4-armsr-armv8-rootfs.tar.gz /
COPY network /etc/config/network
COPY firewall /etc/config/firewall
RUN mkdir /var/lock && chmod 777 /var/lock && mkdir /var/run
RUN chmod 777 /var/run
RUN touch /var/lock/procd_firewall.lock && chmod +x /var/lock/procd_firewall.lock
RUN touch /etc/rc.local && chmod +r /etc/rc.local
RUN touch /etc/board.json && chmod +x /etc/board.json
RUN chmod 640 /etc/config/network && chmod 640 /etc/config/firewall
RUN opkg update && opkg list-upgradable | cut -f 1 -d ' ' | xargs -r opkg upgrade && 
opkg install ubusd libubus bash curl openssh-server rpcd-mod-file uhttpd-mod-ubus 
nano luci luci-ssl luci-theme-material luci-app-filemanager luci-app-commands luci-app-ttyd 
luci-app-statistics attendedsysupgrade-common luci-app-attendedsysupgrade 
rpcd-mod-rpcsys collectd-mod-interface collectd-mod-memory collectd-mod-cpu
RUN /etc/init.d/sshd enable
#https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-linux-aarch64.tgz⁠
COPY ookla-speedtest-1.2.0-linux-aarch64.tgz /tmp
RUN tar -xvzf /tmp/ookla-speedtest-1.2.0-linux-aarch64.tgz -C /usr/bin
RUN chmod +x /usr/bin/speedtest
RUN rm -rf /tmp/ookla-speedtest*
EXPOSE 22/tcp 53/tcp 80/tcp 443/tcp
#Optional expose
#EXPOSE 53/udp
ENTRYPOINT ["/sbin/init"]
#CMD ["/bin/bash"]
