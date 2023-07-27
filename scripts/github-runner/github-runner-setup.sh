echo Setting this VM up as a self-hosted GitHub Runner...

while [[ "$#" -gt 0 ]]
  do
    case $1 in
      -r|--repo) Repo="$2"; shift;;
      -d|--directory) Directory="$2"; shift;;
      -version|--version) Version="$2"; shift;;
      -token|--token) Token="$2"; shift;;
    esac
    shift
done

echo Creating directory $Directory...
mkdir -p $Directory
cd $Directory

echo Downloading GitHub Runner installer...
curl -o actions-runner-linux-x64-$Version.tar.gz -L https://github.com/actions/runner/releases/download/v$Version/actions-runner-linux-x64-$Version.tar.gz

echo Installing Runner...
tar xzf ./actions-runner-linux-x64-$Version.tar.gz
./config.sh --url $Repo --token $Token
sudo ./svc.sh install root
sudo ./svc.sh start root
cd ..

echo Finished setting up GitHub Runner
