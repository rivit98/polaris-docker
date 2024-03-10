FROM rust:1.76.0 as builder

RUN git clone https://github.com/agersant/polaris.git /build
WORKDIR /build
RUN RUSTFLAGS="-C target-feature=-crt-static" cargo build --release

FROM alpine:latest as web-dl
RUN apk add --no-cache wget unzip ca-certificates
WORKDIR /app

RUN wget --progress=dot:giga https://github.com/agersant/polaris-web/releases/latest/download/web.zip \
  && unzip web \
  && rm web.zip

FROM ubuntu:22.04 as runner
WORKDIR /app
ENV POLARIS_DB="/var/lib/polaris/polaris.db"

COPY --from=builder /build/target/release/polaris .
COPY --from=web-dl /app/* ./web
COPY run.sh .

RUN chmod +x ./polaris /app/run.sh
CMD [ "/app/run.sh" ]


