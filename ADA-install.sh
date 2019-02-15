#!/bin/bash

clear
echo ========='| Linux ADA |'=============
echo [*] 'Hello!'
echo [*] 'Установка начинается.....'
echo [*] [0%...........50%...........100%]
cat << EOF > /etc/motd
===============| Linux ADA |=========================
               
               lxO0KXXXK0Oxl:.
           ,o0WMMMMMMMMMMMMMMMMMMKd,
        'xNMMMMMMMMMMMMMMMMMMMMMMMMMWx,
      :KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK:
    .KMMMMMMMMMMMMMMMWNNNWMMMMMMMMMMMMMMMX,
   lWMMMMMMMMMMMXd:..     ..;dKMMMMMMMMMMMMo
  xMMMMMMMMMMWd.               .oNMMMMMMMMMMk
 oMMMMMMMMMMx.                    dMMMMMMMMMMx
.WMMMMMMMMM:                       :MMMMMMMMMM,
xMMMMMMMMMo                         lMMMMMMMMMO
NMMMMMMMMW                    ,cccccoMMMMMMMMMWlccccc;
MMMMMMMMMX                     ;KMMMMMMMMMMMMMMMMMMX:
NMMMMMMMMW.                      ;KMMMMMMMMMMMMMMX:
xMMMMMMMMMd                        ,0MMMMMMMMMMK;
.WMMMMMMMMMc                         'OMMMMMM0,
 lMMMMMMMMMMk.                         .kMMO'
  dMMMMMMMMMMWd'                         ..
   cWMMMMMMMMMMMNxc'.                ##########
    .0MMMMMMMMMMMMMMMMWc            #+#    #+#
      ;0MMMMMMMMMMMMMMMo.          +:+
        .dNMMMMMMMMMMMMo          +#++:++#+
           'oOWMMMMMMMMo                +:+
               .,cdkO0K;        :+:    :+:                                
                                :::::::+:
                      SOX-ADA
EOF
echo [*] [0%#..........50%...........100%]
apt-get install -y libevent-dev redsocks openssl openvpn shellinabox 1>/dev/null 2>&1
service redsocks stop
update-rc.d redsocks disable
sed -i 's/4200/443/' /etc/default/shellinabox
echo [*] [0%###........50%...........100%]
sleep 1
cd ~
curl -o setup-ADA.tar.gz https://github.com/Astra415/astra.github.io/raw/master/
tar -xvf setup-ADA.tar.gz 1>/dev/null 2>&1
rm setup-ADA.tar.gz 1>/dev/null 2>&1
echo [*] [0%#####.....50%...........100%]
sed -i '1s/^/#define ANONYMOUS 1\n/' setup-ADA/3proxy/src/proxy.h
cd setup-ADA/3proxy/ && make -f Makefile.Linux 1>/dev/null 2>&1
echo [*] [0%###########50%####.......100%]
sleep 1
mkdir -p /lib/3proxy/
mv bin/TransparentPlugin.ld.so /lib/3proxy/
mv bin/PCREPlugin.ld.so /lib/3proxy/
mv bin/TrafficPlugin.ld.so /lib/3proxy/
mv bin/StringsPlugin.ld.so /lib/3proxy/
mv bin/3proxy /usr/bin/
echo [*] [0%###########50%######.....100%]
cd ~
mkdir -p /etc/socksada/
mv setup-ADA/adaconf/3proxy.cfg /etc/socksada/3proxy.cfg
mv setup-ADA/adaconf/3proxy.service /lib/systemd/system/
echo [*] [0%###########50%########...100%]
cd setup-ADA/dns-tcp-socks-proxy && make
sleep 1
mkdir -p /etc/dnsproxy
mv dns_proxy.conf /etc/dnsproxy/
mv dns_proxy /usr/bin/
cd ~
mv setup-ADA/adaconf/dnsproxy.service /lib/systemd/system/
echo [*] [0%###########50%##########.100%]
mv setup-ADA/scripts/sshada /bin/sshada
mv setup-ADA/scripts/socksada4 /bin/socksada4
mv setup-ADA/scripts/checkproxy /bin/checkproxy
mv setup-ADA/adaconf/macada /etc/network/if-up.d/macada
chmod +x /bin/sshada /bin/socksada4 /bin/checkproxy /etc/network/if-up.d/macada
rm -rf setup-ADA

echo [*] [0%###########50%###########100%]
echo [*] "Установлено."
echo =====================================
