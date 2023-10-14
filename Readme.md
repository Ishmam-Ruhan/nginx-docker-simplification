### Json To Config File Map and Docker Compose Execution Flow

#### ★ Json To Config File Map
![Json to Config File Map](./json_to_configuration.png)

#### ★ Docker Compose Execution Flow
![Docker Compose Execution Flow](./docker_execution_flow.png)

#### ★ What to do after adding new config json file inside config/ directory?
Just run: `./refresh.sh`

Note: before running `./refresh.sh` we have to make sure this file has execution permission or not. We can set execution permission by running command `chmod +x refresh.sh`