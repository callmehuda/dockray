FROM ubuntu:latest
LABEL maintainer="Callmehuda <mafatikhul.huda118@smk.belajar.id>"

WORKDIR /root
COPY xray.sh /root/xray.sh
COPY config.json /etc/xray/config.json
RUN set -ex \
	&& apt-get update \
	&& apt-get install -y bash curl fish tzdata ca-certificates openssl wget \
	&& mkdir -p /var/log/xray /usr/share/xray \
	&& chmod +x /root/xray.sh \
	&& /root/xray.sh \
	&& rm -fv /root/xray.sh \
	&& wget -O /usr/share/xray/geosite.dat https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/geosite.dat \
	&& wget -O /usr/share/xray/geoip.dat https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/geoip.dat

VOLUME /etc/xray
ENV TZ=Asia/Singapore
CMD [ "/usr/bin/xray", "-config", "/etc/xray/config.json" ]
