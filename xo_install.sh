#!/bin/bash

xo_branch="stable"
xo_server="https://github.com/vatesfr/xo-server"
xo_web="https://github.com/vatesfr/xo-web"
n_repo="https://raw.githubusercontent.com/visionmedia/n/master/bin/n"
yarn_repo="deb https://dl.yarnpkg.com/debian/ stable main"
node_source="https://deb.nodesource.com/setup_8.x"
yarn_gpg="https://dl.yarnpkg.com/debian/pubkey.gpg"
n_location="/usr/local/bin/n"
xo_server_dir="/opt/xo-server"
xo_web_dir="/opt/xo-web"
systemd_service_dir="/lib/systemd/system"
xo_service="xo-server.service"

#Install node and yarn
cd /opt

/usr/bin/curl -sL $node_source | sudo -E bash -
/usr/bin/curl -sS $yarn_gpg | sudo apt-key add -
echo "$yarn_repo" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo /usr/bin/apt-get update
sudo /usr/bin/apt-get install --yes nodejs yarn

#Install n
/usr/bin/curl -o $n_location $n_repo
sudo /bin/chmod +x $n_location
sudo /usr/local/bin/n stable

#Install XO dependencies
sudo /usr/bin/apt-get install --yes build-essential redis-server libpng-dev git python-minimal libvhdi-utils nfs-common

/usr/bin/git clone -b $xo_branch $xo_server
/usr/bin/git clone -b $xo_branch $xo_web
#cd $xo_server_dir
#/usr/bin/yarn 
#/usr/bin/yarn build
#sudo cp sample.config.yaml .xo-server.yaml
#sudo sed -i "s|#'/': '/path/to/xo-web/dist/'|'/': '/opt/xo-web/dist'|" .xo-server.yaml
#cd $xo_web_dir
#/usr/bin/yarn 
#/usr/bin/yarn build

#if [[ ! -e $systemd_service_dir/$xo_service ]] ; then

#/bin/cat << EOF >> $systemd_service_dir/$xo_service
## systemd service for XO-Server.

#[Unit]
#Description= XO Server
#After=network-online.target

#[Service]
#WorkingDirectory=/opt/xo-server/
#ExecStart=/usr/local/bin/node ./bin/xo-server
#Restart=always
#SyslogIdentifier=xo-server

#[Install]
#WantedBy=multi-user.target
#EOF
#fi

#sudo /bin/chmod +x $systemd_service_dir/$xo_service
#sudo /bin/systemctl enable $xo_service
#sudo /bin/systemctl start $xo_service
