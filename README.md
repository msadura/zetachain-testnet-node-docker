
## Official documentation

[Running a full node](https://www.zetachain.com/docs/validators/running-a-full-node/)

This docker container does env setup mentioned in official documentation.

## Running container

Build container from dockerfile:

`docker build -t zetacontainer .`

Run the container:

`docker run -ti --rm zetacontainer`

# Running node from container

Container has `zetacored` command installed and configured for testnet. Start node with command:

`zetacored start --home /home/zetachain/.zetacored/ --log_format json  --log_level info --moniker <YOUR_NODE_NAME_HERE>`