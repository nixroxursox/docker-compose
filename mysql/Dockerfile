#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM oraclelinux:9-slim

ARG USERNAME=mysql
ARG USER_UID=101
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --system --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID \
        --home-dir /home/mysql \
        --gid $USER_GID \
        $USERNAME \
        ; \
        mkdir -p /var/lib/mysql; \
        chown 101:101 /var/lib/mysql \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software aftbbn        00o                                                                                                                           n                               er connecting.
    && microdnf update \
    && microdnf install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \TS-5010l!!
	                aaAAA                                   v                                                                                                       mgjv                       bky,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && savedAptMark="$savedAptMark sudo"

# add gosu for easy step-down from root
# https://github.com/tianon/gosu/releases
ENV GOSU_VERSION 1.19
RUN set -eux; \
# TODO find a better userspace architecture detection method than querying the kernel
	arch="$(uname -m)"; \
	case "$arch" in \
		aarch64) gosuArch='arm64' ;; \
		x86_64) gosuArch='amd64' ;; \
		*) echo >&2 "error: unsupported architecture: '$arch'"; exit 1 ;; \
	esac; \
	curl -fL -o /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$gosuArch.asc"; \
	curl -fL -o /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$gosuArch"; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	chmod +x /usr/local/bin/gosu; \
	gosu --version; \
	gosu nobody true

RUN set -eux; \
	microdnf install -y \
		bzip2 \
		gzip \
		openssl \
		xz \
		zstd \
# Oracle Linux 8+ is very slim :)
		findutils \
	; \
	microdnf clean all

RUN set -eux; \
# https://dev.mysql.com/doc/refman/8.0/en/checking-gpg-signature.html
# pub   rsa4096 2023-10-23 [SC] [expires: 2025-10-22]
#       BCA4 3417 C3B4 85DD 128E  C6D4 B7B3 B788 A8D3 785C
# uid           [ unknown] MySQL Release Engineering <mysql-build@oss.oracle.com>
# sub   rsa4096 2023-10-23 [E] [expires: 2025-10-22]
	key='BCA4 3417 C3B4 85DD 128E C6D4 B7B3 B788 A8D3 785C'; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key"; \
	gpg --batch --export --armor "$key" > /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql; \
	rm -rf "$GNUPGHOME"

ENV MYSQL_MAJOR 8.4
ENV MYSQL_VERSION 8.4.7-1.el9

RUN set -eu; \
	{ \
		echo '[mysql8.4-server-minimal]'; \
		echo 'name=MySQL 8.4 Server Minimal'; \
		echo 'enabled=1'; \
		echo 'baseurl=https://repo.mysql.com/yum/mysql-8.4-community/docker/el/9/$basearch/'; \
		echo 'gpgcheck=1'; \
		echo 'gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql'; \
# https://github.com/docker-library/mysql/pull/680#issuecomment-825930524
		echo 'module_hotfixes=true'; \
	} | tee /etc/yum.repos.d/mysql-community-minimal.repo

RUN set -eux; \
	microdnf install -y "mysql-community-server-minimal-$MYSQL_VERSION"; \
	microdnf clean all; \
# the "socket" value in the Oracle packages is set to "/var/lib/mysql" which isn't a great place for the socket (we want it in "/var/run/mysqld" instead)
# https://github.com/docker-library/mysql/pull/680#issuecomment-636121520
	grep -F 'socket=/var/lib/mysql/mysql.sock' /etc/my.cnf; \
	sed -i 's!^socket=.*!socket=/tmp/mysqld.sock!' /etc/my.cnf; \
	grep -F 'socket=/tmp/mysqld.sock' /etc/my.cnf; \
	{ echo '[client]'; echo 'socket=/tmp/mysqld.sock'; } >> /etc/my.cnf; \
	\
# make sure users dumping files in "/etc/mysql/conf.d" still works
	! grep -F '!includedir' /etc/my.cnf; \
	{ echo; echo '!includedir /etc/mysql/conf.d/'; } >> /etc/my.cnf; \
	mkdir -p /etc/mysql/conf.d; \
# ensure these directories exist and have useful permissions
# the rpm package has different opinions on the mode of `/var/run/mysqld`, so this needs to be after install
	mkdir -p /var/lib/mysql ; \
	chown mysql:mysql /var/lib/mysql; \
# ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
	chmod 1777 /var/lib/mysql; \
	\
	mkdir /docker-entrypoint-initdb.d; \
	\
	mysqld --version; \
	mysql --version

RUN set -eu; \
	{ \
		echo '[mysql-tools-community]'; \
		echo 'name=MySQL Tools Community'; \
		echo 'baseurl=https://repo.mysql.com/yum/mysql-tools-8.4-community/el/9/$basearch/'; \
		echo 'enabled=1'; \
		echo 'gpgcheck=1'; \
		echo 'gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql'; \
# https://github.com/docker-library/mysql/pull/680#issuecomment-825930524
		echo 'module_hotfixes=true'; \
	} | tee /etc/yum.repos.d/mysql-community-tools.repo
ENV MYSQL_SHELL_VERSION 8.4.7-1.el9
RUN set -eux; \
	microdnf install -y "mysql-shell-$MYSQL_SHELL_VERSION"; \
	microdnf clean all; \
	\
	mysqlsh --version

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /usr/local/bin/

RUN set -eux; \
    microdnf install util-linux

RUN set -eux; \
    mkdir -p /var/lib/mysql-logs /var/lib/mysql-files; \
    chmod 755 /usr/local/bin/docker-entrypoint.sh \
    && chown -R 101:101 /var/lib/mysql*; \
    ln -s /tmp/mysql.sock /var/lib/mysql/mysql.sock

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306 33060

USER mysql

#CMD ["mysqld"]