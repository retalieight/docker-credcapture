# SSH credential capturing in plaintext (pamspy docker container)

1. git clone https://github.com/retalieight/docker-credcapture.git
2. cd docker-credcapture
3. docker build -t retali8/credcapture:latest .
4. docker run --privileged -d --name credcapture --restart=unless-stopped -p 22:22 retali8/credcapture
5. docker logs credcapture -f
