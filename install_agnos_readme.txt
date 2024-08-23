1) Create user agnos
2) sudo apt install docker.io mc docker-compose-v2
3) sudo usermod -a -G docker agnos
4) sudo su agnos
5) Test: docker run hello-world
6) mkdir Agnos
7) cd Agnos
8) mkdir Data
9) mkdir Data/Cubes
10) mkdir Data/Keycloak
11) mkdir ../log
12) git clone https://github.com/ruzsaz/AgnosRunner.git
13) edit file: ~/Agnos/AgnosRunner/environment.txt:
    CUBES_DIR=/home/agnos/Agnos/Data/Cubes
    REPORTS_DIR=/home/agnos/Agnos/Data/Cubes
    KEYCLOAK_DATABASE_DIR=/home/agnos/Agnos/Data/Keycloak/
    KEYCLOAK_PUBLIC_IP=https://emk.semmelweis.hu/a_keyclock
    KEYCLOAK_ADMIN_PASSWORD=admin235711131719
    KEYCLOAK_PROXY_MODE=edge
    REPORTSERVER_PUBLIC_IP=https://emk.semmelweis.hu/a_report
    AGNOS_PUBLIC_IP=https://emk.semmelweis.hu/agnos
    REPORTMANAGER_PUBLIC_IP=https://emk.semmelweis.hu/AgnosReportManager
    REPORTMANAGER_INSIDE_IP=http://10.98.200.95:9092/AgnosReportManager
14) edit file: ~/Agnos/AgnosRunner/Logging/environment.txt
    LOG_FILES_DIRECTORY=/home/agnos/log
15) Copy cubes, reports to ~/Agnos/Data/Cubes
16) Run:
    ~/Agnos/AgnosRunner/start.sh
    ~/Agnos/AgnosRunner/Logging/start.sh
17) AutoLogProcess?