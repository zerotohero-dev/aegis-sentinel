#
# .-'_.---._'-.
# ||####|(__)||   Protect your secrets, protect your business.
#   \\()|##//       Secure your sensitive data with Aegis.
#    \\ |#//                    <aegis.ist>
#     .\_/.
#

# builder image
FROM golang:1.20.1-alpine3.17 as builder
RUN mkdir /build
COPY cmd /build/cmd
COPY vendor /build/vendor
COPY internal /build/internal
COPY busywait /build/busywait
COPY go.mod /build/go.mod
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux go build -mod vendor -a -o aegis ./cmd/main.go
RUN CGO_ENABLED=0 GOOS=linux go build -mod vendor -a -o sloth ./busywait/main.go

# for debug: FROM alpine:3.17.0
FROM gcr.io/distroless/static-debian11

LABEL "maintainers"="Volkan Özçelik <volkan@aegis.ist>"
LABEL "version"="1.3.0"
LABEL "website"="https://aegis.ist/"
LABEL "repo"="https://github.com/zerotohero-dev/aegis-sentinel"
LABEL "documentation"="https://aegis.ist/docs/"
LABEL "contact"="https://aegis.ist/contact/"
LABEL "community"="https://aegis.ist/contact/#community"
LABEL "changelog"="https://aegis.ist/changelog"

# Copy the required binaries
COPY --from=builder /build/aegis /bin/aegis
COPY --from=builder /build/sloth /bin/sloth

ENV HOSTNAME sentinel

# Prevent root access.
ENV USER nobody
USER nobody

# Keep the container alive.
ENTRYPOINT ["/bin/sloth"]
CMD [""]
