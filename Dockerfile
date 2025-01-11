FROM ubuntu:24.04

RUN apt update && apt upgrade -y &&apt install -y \
clang-format clang-tidy \
clang-tools clang clangd libc++-dev \
libc++1 libc++abi-dev libc++abi1 \
libclang-dev libclang1 liblldb-dev \
libllvm-ocaml-dev libomp-dev libomp5 \
lld lldb llvm-dev llvm-runtime \
llvm python3-clang \
protobuf-compiler libprotobuf-dev \
htop btop iotop iftop net-tools wget \
curl git build-essential libssl-dev pkg-config
RUN apt clean -y && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash astrix

WORKDIR /git
RUN wget https://sh.rustup.rs -O rustup-init.sh && chown -R astrix:astrix /git && chmod +x ./rustup-init.sh
USER astrix
RUN  ./rustup-init.sh -y
RUN echo 'source "$HOME/.cargo/env"' >> ~/.bashrc && echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc &&\
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.profile
RUN . "$HOME/.cargo/env" && cargo install wasm-pack && . "$HOME/.cargo/env" rustup target add wasm32-unknown-unknown

#RUN git clone https://github.com/astrix-network/astrix-node
RUN wget https://github.com/astrix-network/astrix-node/archive/refs/tags/v0.14.1.tar.gz -O astrix-node.tar.gz && tar -xvf astrix-node.tar.gz && mv astrix-node-0.14.1 astrix-node && rm astrix-node.tar.gz

WORKDIR /git/astrix-node
RUN cd wallet/wasm/web && . "$HOME/.cargo/env" && cargo install basic-http-server && . "$HOME/.cargo/env" && cd wallet && cd wasm && ./build-web

EXPOSE 4000
EXPOSE 34150
EXPOSE 17110
EXPOSE 36150
EXPOSE 34551

USER root
RUN mkdir /home/astrix/.astrix-node && chown astrix:astrix /home/astrix/.astrix-node
VOLUME /home/astrix/.astrix-node
COPY start.sh /start.sh
RUN chmod +x /start.sh && chown astrix:astrix /start.sh

USER astrix
ENTRYPOINT [ "/start.sh" ]