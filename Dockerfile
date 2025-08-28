FROM rust:1.72 as builder
WORKDIR /app
COPY . .
RUN cargo build --release

FROM debian:buster-slim
COPY --from=builder /app/target/release/hello_backend /usr/local/bin/hello_backend
EXPOSE 8080
CMD ["hello_backend"]
