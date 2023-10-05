#!/bin/bash

set -e

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
	echo "Not running as root"
	exit
fi

echo Setting this VM up as a self-hosted GitHub Runner...

while [[ "$#" -gt 0 ]]
  do
    case $1 in
      -r|--repo) Repo="$2"; shift;;
      -v|--version) Version="$2"; shift;;
      -t|--token) Token="$2"; shift;;
	  -u|--user) RunnerUser="$2"; shift;;
    esac
    shift
done

DIR=/home/$RunnerUser
cd $DIR

echo Downloading GitHub Runner installer...
curl -o actions-runner-linux-x64-$Version.tar.gz -L https://github.com/actions/runner/releases/download/v$Version/actions-runner-linux-x64-$Version.tar.gz

echo Installing Runner as a service...
tar xzf ./actions-runner-linux-x64-$Version.tar.gz
chown -R $RunnerUser:$RunnerUser /home/$RunnerUser
runuser -u $RunnerUser -- ./config.sh --url $Repo --token $Token
./svc.sh install $RunnerUser
./svc.sh start $RunnerUser

echo Finished setting up GitHub Runner
