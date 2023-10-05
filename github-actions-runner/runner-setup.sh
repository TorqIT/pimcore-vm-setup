echo Setting this VM up as a self-hosted GitHub Runner...

while [[ "$#" -gt 0 ]]
  do
    case $1 in
      -r|--repo) Repo="$2"; shift;;
      -version|--version) Version="$2"; shift;;
      -token|--token) Token="$2"; shift;;
    esac
    shift
done

DIR=/home/$USER
cd $DIR

echo Downloading GitHub Runner installer...
curl -o actions-runner-linux-x64-$Version.tar.gz -L https://github.com/actions/runner/releases/download/v$Version/actions-runner-linux-x64-$Version.tar.gz

echo Installing Runner as a service...
tar xzf ./actions-runner-linux-x64-$Version.tar.gz
./config.sh --url $Repo --token $Token
./svc.sh install $USER
./svc.sh start $USER

echo Finished setting up GitHub Runner
