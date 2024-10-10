# Astrix Node Docker

This repository contains the necessary steps to run an Astrix Node using Docker. The node is currently in a static state, but more configuration options will be added over time as the development progresses. It has also the web wallet in it.

## Requirements

- [Docker](https://www.docker.com/)
- At least 5 GB of disk space (And growing)

## Quickstart

To quickly spin up an Astrix Node, you can use the following Docker command:

```bash
docker run -p 4000:4000 \
           -p 34150:34150 \
           -p 17110:17110 \
           -p 36150:36150 \
           -p 34551:34551 \
           -v astrix:/home/astrix/.astrix-node \
           casraw/astrix-node-docker:main
```

### Ports Explanation

- **4000**: http connections
- **34150**: gRPC connections
- **17110**: wRPC Borsh connections
- **36150**: wRPC JSON connections
- **34551**: listen for connections

### Persistent Data

To keep your node's data persistent across container restarts, a Docker volume is used: `astrix:/home/astrix/.astrix-node`.

## Donations

If you'd like to support the development of **this Docker project**, donations are welcome! Note that these donations go towards **supporting the Docker setup** and **not the main Astrix network development**.

**Docker Project Donation Address**:  
`astrix:qpu0jzy4njzu7ym6h8hhwakjwnrjx5wjnwqu25qgm7u0zhtvf4epk6h8mjfq5`

If you would like to support the **main Astrix network development**, you can donate to:  
**Main Astrix Network Donation Address**:  
`astrix:qqjzemurre653qvkxehfk4x2ngvdnzfusnyr85y8hu04gvq4jcv8q53frrp42`

## Links

- **Original Astrix Project**: [Astrix Network on GitHub](https://github.com/astrix-network)
- **Astrix Network Website**: [astrix-network.com](https://astrix-network.com/)
- **This Docker Project**: [Astrix Node Docker on GitHub](https://github.com/Casraw/astrix-node-docker)
- **Docker Hub Image**: [Astrix Node Docker on Docker Hub](https://hub.docker.com/repository/docker/casraw/astrix-node-docker/general)

### Development Status

This project is under active development. While the current configuration is static, more customizable options will be added in future updates.
Also maybe build a Kubernetes Deployment lets see.

Stay tuned for further improvements!

## Contributing

Contributions, bug reports, and suggestions are welcome! Feel free to open an issue or submit a pull request.
