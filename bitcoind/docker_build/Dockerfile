FROM debian:trixie-slim


ARG USERNAME=bitcoin
ARG USER_UID=101
ARG USER_GID=$USER_UID
ARG TARGETARCH TARGETOS
ARG BITCOIN_VERSION=30.2
ENV BITCOIN_VERaSION=$BITCOIN_VERSION
ENV WLADIMIRVDL_PGP_KEY=71A3B16735405025D447E8F274810B012346C9A6
ENV ACHOW_PGP_KEY=152812300785C96444D3334D17565732E08E5E41
ARG TOR_USER=tor
ARG TOR_GROUP=tor
ARG TOR_GID=102
ARG TOR_UID=102


WORKDIR /opt

# Create the user
RUN groupadd --system --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} \
        --home-dir /home/${USERNAME} \
        --gid ${USER_GID} \
        ${USERNAME} \
        ; \
        cp -R /etc/skel /home/${USERNAME} \
        && chown 101:101 /home/${USERNAME} \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME} \
    && savedAptMark="$savedAptMark sudo"

RUN groupadd --system --gid ${TOR_GID} ${TOR_USER} \
    && useradd --uid ${TOR_UID} \
    --home-dir /home/${TOR_USER} \
    --gid ${TOR_GID} \
    ${TOR_USER} \
    ; \
    cp -R /etc/skel /home/${TOR_USER} \
    && chown ${TOR_UID}:${TOR_GID} /home/${TOR_USER} \
#
# [Optional] Add sudo support. Omit if you don't need to install software after connecting.
  && apt-get update \
  && apt-get install -y sudo \
  && echo ${TOR_USER} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${TOR_USER} \
  && chmod 0440 /etc/sudoers.d/${TOR_USER} \
  && savedAptMark="$savedAptMark sudo"

RUN apt update \
  && apt install -qfy ca-certificates gnupg bash wget tor vim

RUN if [ "${TARGETARCH}" = "arm64" ]; then \
  wget https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-aarch64-linux-gnu.tar.gz; \
  else \
  wget https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz; \
  fi \
  && wget https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/SHA256SUMS.asc \
  && wget https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/SHA256SUMS

RUN gpg --keyserver hkps://keys.openpgp.org --recv-keys ${WLADIMIRVDL_PGP_KEY} ${ACHOW_PGP_KEY} \
  && csplit -ksz SHA256SUMS.asc  /-----BEGIN/ '{*}' \
  && for i in xx*; do gpg --verify $i SHA256SUMS && break; done \
  && if [ "${TARGETARCH}" = "arm64" ]; then \
    grep bitcoin-${BITCOIN_VERSION}-aarch64-linux-gnu.tar.gz SHA256SUMS | sha256sum -c; \
  else \
    grep bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz SHA256SUMS | sha256sum -c; \
  fi

RUN mkdir -p bitcoin /home/${USERNAME}/.bitcoin \
  && if [ "${TARGETARCH}" = "arm64" ]; then \
    tar xzvf bitcoin-${BITCOIN_VERSION}-aarch64-linux-gnu.tar.gz --strip-components=1 -C bitcoin; \
  else \
    tar xzvf bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz --strip-components=1 -C bitcoin; \
  fi \
	&& mv bitcoin/bin/* /usr/local/bin/ \
  && mv bitcoin/lib/* /usr/local/lib/ || true \
  && mv bitcoin/include/* /usr/local/include/ || true \
  && mv bitcoin/share/* /usr/local/share/

RUN apt clean && apt autoclean

USER root

RUN set -eux; \
    chown -R 102:102 /var/lib/tor \
    && chown -R tor:tor /var/lib/tor \
    && find /var/lib/tor -type d -exec chmod 700 {} \; \
    && find /var/lib/tor -type f -exec chmod 600 {} \;

COPY docker_entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker_entrypoint.sh"]


