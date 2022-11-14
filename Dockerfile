FROM rust:1.72.1 as builder

RUN git clone https://github.com/agersant/polaris.git /build
WORKDIR /build

RUN RUSTFLAGS="-C target-feature=-crt-static" cargo build --release

FROM ubuntu:22.04

ENV POLARIS_DB="/var/lib/polaris/polaris.db"

WORKDIR /app

RUN apt-get update && apt-get install --no-install-recommends -y \
  unzip \
  wget \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN wget --progress=dot:giga https://github.com/agersant/polaris-web/releases/latest/download/web.zip && unzip web && rm web.zip
COPY --from=builder /build/target/release/polaris .
COPY run.sh .

RUN chmod +x ./polaris /app/run.sh
EXPOSE 5050

CMD [ "/app/run.sh" ]


