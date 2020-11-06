# docker-teamcity-agent-rbenv

TeamCity agent client based on [jetbrains/teamcity-agent](https://hub.docker.com/r/jetbrains/teamcity-agent/), with rbenv and the build-essential package installed.

This is the agent we use to build and test all the Ruby code TeamCity looks after.
If you want to add packages to it, tweak the list following the `DEBIAN_FRONTENT` bit in the Dockerfile.

# Setup

First, because only rbenv is installed and no ruby version, add as first step in your build job(s):
```bash
cat .ruby-version| xargs rbenv install ; gem install bundler
```

# Standard builds
```bash
docker volume create --name teamcity_agent_rbenv_conf
docker run \
  -e SERVER_URL=http://localhost:8111 \
  -e AGENT_NAME="Ruby build agent" \
  -v teamcity_agent_rbenv_conf:/data/teamcity_agent/conf \
  --name teamcity_rbenv_agent \
  kangou/docker-teamcity-agent-rbenv
```

# Rails tests
1. Change the .env file values at will
2. Configure your config/database.yml:
```yaml
test:
  adapter: postgresql
  encoding: utf8
  database: <%= ENV['POSTGRES_DB'] %>
  username: <%= ENV['POSTGRES_USER'] %>
  password: <%= ENV['POSTGRES_PASSWORD'] %>
  host: db
  port: 5432
```
3. Launch the containers:
```bash
docker-compose up
```
