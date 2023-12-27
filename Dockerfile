FROM --platform=linux/amd64 ubuntu

# System configuration
RUN echo "* hard nproc 262144" >> /etc/security/limits.conf
RUN echo "* soft nproc 262144" >> /etc/security/limits.conf
RUN echo "* hard nofile 262144" >> /etc/security/limits.conf
RUN echo "* soft nofile 262144" >> /etc/security/limits.conf
RUN echo "fs.file-max=262144" >>  /etc/sysctl.conf

# Read here why UID 10001: https://github.com/hexops/dockerfile/blob/main/README.md#do-not-use-a-uid-below-10000
ARG UID=10001
ARG USER_NAME=zetachain
ARG NODE_NAME=epicode

ENV ZETA_HOME=/home/${USER_NAME}

RUN useradd -rm -d ${ZETA_HOME} -s /bin/bash -g root -G sudo -u ${UID} ${USER_NAME}

RUN mkdir -p ${ZETA_HOME}/.zetacored/bin
RUN mkdir -p ${ZETA_HOME}/.zetacored/config
RUN chown -R ${USER_NAME} ${ZETA_HOME}/.zetacored

ADD --chown=${USER_NAME}:${USER_NAME} https://github.com/zeta-chain/node/releases/download/v11.0.0/zetacored-linux-amd64 /usr/local/bin/zetacored
RUN chmod +x /usr/local/bin/zetacored

ADD --chown=${USER_NAME}:${USER_NAME} https://raw.githubusercontent.com/zeta-chain/network-athens3/main/network_files/config/app.toml /home/zetachain/.zetacored/config/app.toml
ADD --chown=${USER_NAME}:${USER_NAME} https://raw.githubusercontent.com/zeta-chain/network-athens3/main/network_files/config/client.toml /home/zetachain/.zetacored/config/client.toml
ADD --chown=${USER_NAME}:${USER_NAME} https://raw.githubusercontent.com/zeta-chain/network-athens3/main/network_files/config/config.toml /home/zetachain/.zetacored/config/config.toml
ADD --chown=${USER_NAME}:${USER_NAME} https://raw.githubusercontent.com/zeta-chain/network-athens3/main/network_files/config/genesis.json /home/zetachain/.zetacored/config/genesis.jsonxit

USER ${USER_NAME}

ENTRYPOINT [ "/bin/bash" ]
