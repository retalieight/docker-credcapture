# SSH/RDP credential dumping (using pamspy)

I run this on a VPS I hardly use just for fun and to build my own username and password wordlists. This will dump the credentials used to attempt to authenticate in plaintext using pamspy. I changed my own SSH port to something non-standard such as port 23 (telnet) and do not use port 3389 (RDP) for anything anyway.

## Instructions

1. Clone the repository:

```
git clone https://github.com/retalieight/docker-credentialdumper.git
```

2. Change to the repository directory:

```
cd docker-credentialdumper
```

3. Build the Docker image using:

```
docker build -t retali8/credentialdumper:latest .
```

4. Run the Docker container:

```
docker run --privileged -d --name credentialdumper --restart=unless-stopped -p 22:22 -p 3389:3389 retali8/credentialdumper
```

5. Watch the Docker container logs to see what credentials are dumped:

```
docker logs credentialdumper -f
```

## Dump the credentials

```
docker logs credentialdumper | grep -E '^[0-9]+\s+' | sed -e 's/\s//g' -e 's/\xC2\xA0//g' | awk -F\| '{print $2 "," $3 ":" $4}'
```
