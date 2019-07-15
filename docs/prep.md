# Demo Preparation

## Prerequisites

Before you are able to create this demo:
  - You must have an AWS account with a working Route 53 domain setup.
  - Your AWS account must have sufficient rights to create gateways, routes, subnets, network acls, key pairs, security groups, and ec2 instances.
  - You must also have a valid Ansible Tower license.

The demo scripts will handle the rest.

## Administration Scripts

The following scripts are included in the `/app` directory in the container. They should be used for administering the demo environment.

  - `connect.sh` - Bash script that will open an SSH session to the specified host. Usage: `./connect.sh [tower|rhel-0|rhel-1|rhel-2|win-0|win-1|win-2]`
  - `deploy.yml` - Ansible Playbook to deploy and configure the demo environment.
  - `destroy.yml` - Ansible Playbook to cleanly remove the demo environment from AWS.
  - `shutdown.yml` - Ansible Playbook to shutdown all the hosts in the environment. This will not remove them from AWS.
  - `startup.yml` - Ansible Playbook to startup all the hosts in the environment.

## Procedure

Use the following steps to create and prepare the demo environment.

1. Pull the latest container image, and create a local directory that will be used for storing your demo's configuration and setup data.

```bash
docker pull rmkraus/demo-ansible-windows:latest
mkdir demo-data
```

2. Launch the container interactively to get the demo control prompt.

```bash
docker run \
    --mount type=bind,src=/full/path/to/demo-data,dst=/data \
    --name demo \
    -it rmkraus/demo-ansible-windows:latest

# after exit, the container can be restarted with
docker start -i demo
```

3. The container will populate the data directory with a skeleton configuration and initialize the internal Terraform database. Update the `/date/config.sh` and `/data/tower-license.txt` files with the data for your demo.

4. Create the demo environment using the deploy playbook. This will take some time as all the infrastructure is created.

```bash
./deploy.yml
```

5. RDP into windows nodes and:
  1. change their Administrator password
  2. Setup WinRDP with demo script from Ansible project

6. Setup Windows Machine credential in Tower
