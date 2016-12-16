Teamcity agent client based on jetbrains/teamcity-minimal-agent, with rbenv and the build-essential package installed.

First, because only rbenv is installed and no ruby version, add as first step in your build job:
```bash
cat .ruby-version| xargs rbenv install ; gem install bundler
```
Then:
```bash
docker run -it -e SERVER_URL=http://localhost:8111 -e AGENT_NAME="Ruby build agent" --name teamcity_rbenv_agent kangou/docker-teamcity-agent-rbenv
```
