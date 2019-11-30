FROM alpine

MAINTAINER chd1998

RUN echo "http://mirrors.ustc.edu.cn/alpine/latest-stable/main/" > /etc/apk/repositories \
		&& apk update \
#		&& apk add --no-cache bash bash-doc bash-completion \
#		&& /bin/bash \
#		&& rm -rf /var/cache/apk/* \
		&& apk add --no-cache wget curl git \
		&& apk add --no-cache asciidoc bash bc binutils bzip2 cdrkit coreutils diffutils findutils flex g++ gawk gcc gettext git grep intltool libxslt linux-headers make ncurses-dev patch perl python2-dev python3-dev tar unzip  util-linux wget zlib-dev \
#    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && cd /root/ \
		&& git clone https://github.com/coolsnowwolf/lede \	
		&& cd ./lede/ \
#		&& cp ./updatelean.sh . \
#		&& cp ./getlean.sh . \
#		&& git checkout 2915c44 \
		&& echo " " >> .gitignore \
		&& echo "/package/lean/luci-app-ssr-plus" >> .gitignore \
#		&& git checkout -b tmp \
#  	&& git rm --cached package/lean/luci-app-ssr-plus -r \
#    && git checkout master \
		&& git pull \
		&& ./scripts/feeds update -a \
		&& ./scripts/feeds install -a 
		
#ENV LANG en_US.utf8

WORKDIR /root/lede

COPY updatelean.sh /root/lede/
COPY getlean.sh /root/lede/

RUN chmod +x /root/lede/updatelean.sh \
    && chmod +x /root/lede/getlean.sh

ENV FORCE_UNSAFE_CONFIGURE=1

CMD ["/bin/bash"]