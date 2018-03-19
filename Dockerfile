FROM ubuntu:latest
ARG username="user"
ARG password="${username}"

RUN \
	apt-get clean && \
	apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y \
		libqt5gui5 \
		libqt5core5a \
		libqt5dbus5 \
		qttools5-dev \
		qttools5-dev-tools \
		libprotobuf-dev \
		protobuf-compiler \
		wget \
		sudo \
		gnupg2 
RUN \
	useradd \
		--create-home \
		--groups \
			sudo \
		"${username}" && \
	echo "${username}:${password}" | chpasswd
RUN \
	cd /opt && \
	wget https://bitcoin.org/bin/bitcoin-core-0.15.1/bitcoin-0.15.1-x86_64-linux-gnu.tar.gz && \
	wget https://bitcoin.org/bin/bitcoin-core-0.15.1/SHA256SUMS.asc && \
	gpg2 --keyserver pool.sks-keyservers.net --recv-keys 0x90C8019E36C2E964 && \
	sha256sum --check SHA256SUMS.asc || echo ignore && \
	gpg2 --verify SHA256SUMS.asc || echo ignore && \
	rm -f *.asc
RUN \
	cd /opt && \
	tar -xzvf bitcoin*.tar.gz && \
	rm -f bitcoin*.tar.gz

USER "${username}"
EXPOSE 8333
CMD /opt/bitcoin-0.15.1/bin/bitcoin-qt -prune=550
