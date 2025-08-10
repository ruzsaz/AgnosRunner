-- Check before install ----------------------------------------------------------------

1) Be sure docker is installed. If not, install it.
    (ubuntu): sudo apt install docker.io docker-compose-v2

2) Docker uses 172.0.0.0/8 networks. If it conflicts with real IPs, change it:
Edit file /etc/docker/daemon.json, like this:
{
  "bip": "192.168.99.1/24",
  "default-address-pools": [
    {
      "base": "10.0.0.0/8",
      "size": 24
    }
  ]
}

-- Install & run agnos -----------------------------------------------------------------

1) Create user agnos, and add it to group 'docker'.
    sudo useradd -G docker agnos

2) For logging, add user agnos to the group :1000 (logstash guid inside the container). Create the group if it doesn't exist
    sudo usermod -aG 1000 agnos

3) Be agnos
    sudo su agnos

4) Test if everything is ok:
    docker run hello-world

5) Create some necessary directories to store the log files, data cubes
    mkdir ~/Agnos ~/Agnos/Data ~/Agnos/Data/Cubes ~/Agnos/Data/Maps ~/Agnos/Data/Dictionaries ~/Agnos/Data/Keycloak ~/log

6) Enable full rights on the dirs (docker's inside user id is different from the outside uuid)
    chmod -R 777 /home/agnos/Agnos/Data; chmod -R 777 /home/agnos/log

7) Go to the Agnos dir, and clone the install script from the github repo
    cd Agnos
    git clone https://github.com/ruzsaz/AgnosRunner.git
If git refuses to connect (hostile firewall-rules in effect), do either of this:
- download/clone the package to somewhere else, and copy it to /home/agnos/Agnos/AgnosRunner/
- or use the provided install package to extract and copy the same files there.

8) edit file: ~/Agnos/AgnosRunner/environment.txt, most settings are ok, but, check these:
    CUBES_DIR=~/Agnos/Data/Cubes
    REPORTS_DIR=~/Agnos/Data/Cubes
    KEYCLOAK_DATABASE_DIR=~/Agnos/Data/Keycloak/
    KEYCLOAK_PUBLIC_IP=(public IP reachable from outside, like https://emk.semmelweis.hu/a_keyclock)
    KEYCLOAK_ADMIN_PASSWORD=(use secret password)
    KEYCLOAK_PROXY_MODE=edge
    REPORTSERVER_PUBLIC_IP=(public IP reachable from outside, like https://emk.semmelweis.hu/a_report)

    CUBES_MEMORY_LIMIT=(Memory in gigabytes to store data cubes, advised: 10)
    CUBESERVER_XMX=(Should be more than the previous, java heap size, advised: 14G)
		(Agnos will use 2x this for the cube server processes)
    AGNOS_PUBLIC_IP=(public IP reachable from outside, like https://emk.semmelweis.hu/agnos)
    REPORTMANAGER_PUBLIC_IP=(public IP reachable from outside, like https://emk.semmelweis.hu/AgnosReportManager)
    REPORTMANAGER_INSIDE_IP=(local IP, reachable from local environment, like http://172.16.61.199:9092/AgnosReportManager)

9) Copy cubes, reports, maps, keywords to ~/Agnos/Data/.. directories
from the provided install package to the file system.

10) Run:
    ~/Agnos/AgnosRunner/start.sh

11) Optional: test running services
Agnos frontend (long html page expected):
    curl localhost:8080
Keycloak (html login page expected):
    curl localhost:8082/auth/
ReportManager (400 Bad Request expected):
    wget localhost:9092/AgnosReportManager
ReportServer (json answer expected):
    curl localhost:9091/ars/reports

12) Configure keycloak to use the euripid identity provider:
Enter the keycloak admin gui, using admin user, and the provided password.

Make these settings there:

Keycloak -> AgnosRealm -> Identity Providers : add EuripidIdentityProvider, and set trust email: true

Keycloak -> AgnosRealm -> Realm Settings -> User Registration -> Default Roles: make default this two roles: public, agnosuser

Keycloak -> AgnosRealm -> Authentication -> Required Actions : Update profile: off

Keycloak -> AgnosRealm -> Authentication -> Flows:
    - copy "Browser flow" as "Browser flow for Euripid"
    - edit "Browser flow for Euripid"
        - Identity provider redirector: settings -> default identity provider: set to EuripidIdentityProvider's alias name
        - Browser for Euripid forms: disabled
    - Browser for Euripid: Bind to Browser flow

(Do not have any report with "public" access role to skip the requirement to press the "Login" button.)

-- For logging ----------------------------------------------------------------------

13) edit file: ~/Agnos/AgnosRunner/Logging/environment.txt
    LOG_FILES_DIRECTORY=~/log

14) Run:
    ~/Agnos/AgnosRunner/Logging/start.sh

---------------------------------------------------------------------------------

Scripts in the AgnosRunner directory:

dockerBuildAll.sh: to build docker containers from source (not required to run Agnos)
dockerPushAll.sh: push the containers to the central repo (not required to run Agnos)
mvnCleanInstallAll.sh: translates the java source to binary (not required to run Agnos)

reinstall_frontend.sh: downloads and starts the frontend docker container from the central repo
reinstall_new.sh: downloads and reinstalls all updated containers from the central repo

start.sh: downloads and starts all containers from the central repo
stop.sh: stops all docker containers