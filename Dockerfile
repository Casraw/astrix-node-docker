FROM ubuntu:rolling

RUN apt update && apt upgrade -y
RUN apt install -y curl git build-essential libssl-dev pkg-config
RUN apt install -y protobuf-compiler libprotobuf-dev 
RUN apt install -y clang-format clang-tidy \
clang-tools clang clangd libc++-dev \
libc++1 libc++abi-dev libc++abi1 \
libclang-dev libclang1 liblldb-dev \
libllvm-ocaml-dev libomp-dev libomp5 \
lld lldb llvm-dev llvm-runtime \
llvm python3-clang \
htop btop iotop iftop net-tools

WORKDIR /git
COPY rustup-init.sh ./rustup-init.sh
RUN chmod +x ./rustup-init.sh && ./rustup-init.sh -y
RUN echo 'source "$HOME/.cargo/env"' >> ~/.bashrc
RUN echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc &&\
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.profile
RUN . "$HOME/.cargo/env" && cargo install wasm-pack
RUN . "$HOME/.cargo/env" rustup target add wasm32-unknown-unknown

RUN git clone https://github.com/astrix-network/astrix-node

WORKDIR /git/astrix-node
RUN cd wallet/wasm/web && . "$HOME/.cargo/env" && cargo install basic-http-server
RUN . "$HOME/.cargo/env" && cd wallet && cd wasm && ./build-web


EXPOSE 4000
EXPOSE 34150
EXPOSE 17110
EXPOSE 36150
EXPOSE 34551

COPY start.sh /start.sh
RUN chmod +x /start.sh

RUN apt clean -y && rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/start.sh" ]