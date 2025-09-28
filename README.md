# SSH/RDP credential dumping (using pamspy)

1. git clone https://github.com/retalieight/docker-credentialdumper.git
2. cd docker-credentialdumper
3. docker build -t retali8/credentialdumper:latest .
4. docker run --privileged -d --name credentialdumper --restart=unless-stopped -p 22:22 -p 3389:3389 retali8/credentialdumper
5. docker logs credentialdumper -f
