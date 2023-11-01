This repository contains several scripts for provisioning a Linux virtual machine to host a Pimcore solution.

## Docker setup
The `docker` directory contains a script that will install Docker, add the current user to the Docker group, and install a daily cron job that will prune unused Docker images. Navigate to this directory and run `./docker-setup.sh`. Note that after adding yourself to the Docker group, you will need to refresh your shell session (e.g. logout and log back in).

## NGINX setup
The `nginx` directory contains a setup for a Dockerized NGINX webserver. Prior to setting this up, ensure that any other webservers on the VM are disabled - for example, to disable an existing NGINX installation, run `sudo systemctl disable nginx`. It may then be prudent to copy/move the contents of `nginx` into `/etc/nginx`. Navigate into the directory and run `docker compose up -d` to setup the webserver.

### Certificates
The `volumes` section of the `docker-compose.yml` file contains a mapping of the `certs` folder into the `/etc/nginx/certs` folder inside the container. HTTPS certificate files can be placed here, and will automatically be associated with the domain(s) of your Pimcore app. If your certificate files are kept in a specific directory (or multiple directories) elsewhere on the VM, this mapping can be modified.
 
## GitHub Actions Runner
The `github-actions-runner` directory contains two scripts for setting up this VM as a self-hosted GitHub Actions Runner. Follow these steps:
1. Navigate into the directory.
2. Run `./runner-user-setup.sh` to set up a dedicated Linux user under which the Runner service will run.
3. In a browser, navigate to https://github.com/<your-org>/<your-repo>/settings/actions/runners, click "New self-hosted runner", select "Linux", and copy the "token" value in the "Configure" section. 
4. Navigate to https://github.com/actions/runner/releases and note the latest release number
5. Run `./runner-setup.sh --repo https://github.com/<your-org>/<your-repo> --version <GitHub Actions Runner latest release number> --token <your copied token> --user github` to set up the VM as a self-hosted runner. By default, the script will install the service into the home directory of the `github` user created in step 2.

## Pimcore
The `pimcore` directory contains a script for finalizing the setting up of the VM for hosting Pimcore. It will create a `pimcore` user with a given UID/GID, and will create some external networks which are necessary in order to facilitate blue-green (no downtime) deployments via Docker Compose.
