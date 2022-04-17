#!/bin/bash

echo "Making sure user is not root"
is_user_root () { [ "$(id -u)" -eq 0 ]; }
if is_user_root; then
  echo "Do not run as root"
  exit 1
else
  echo "Not root; good to go"
fi

sudo apt update && sudo apt upgrade -y

sudo apt install -y libssl-dev jq ruby-full libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev libffi-dev python3 python2 python3-pip git nmap default-jre netcat curl


#install go
GOPATH=/usr/local/go/bin

echo "Checking if go is installed"
if [ -d $GOPATH ]; then
  echo "Go is installed"
  sleep 1

elif [[ -z "$GOPATH" ]]; then
  echo "go is not installed, would you like to install?"
  PS3="Please select an option (use numbers) "
  choices=("yes" "no")
  select choice in "${choices[@]}"; do
    case $choice in
      yes)
            echo "Installing Go"
            cd ~/Downloads
            wget https://go.dev/dl/go1.18.1.linux-amd64.tar.gz
            sudo tar -C /usr/local -xzf go1.18.1.linux-amd64.tar.gz
            export PATH="$PATH:$HOME/go/bin" >> ~/.bashrc
            export PATH="$PATH:/usr/local/go/bin" >> ~/.bashrc
            source ~/.bashrc
            sleep 1
            break
            ;;
      no)
            echo "Please install go and rerun this script"
            echo "Aborting install"
            exit 1
            ;;
  esac
done
fi


#Don't forget AWS creds
echo "Don't forget to set up AWS credentials"
sudo apt install -y awscli

#install chromium
echo "Installing Chromium"
sudo snap install chromium
echo "Done"

#JSParser
echo "Installing JSParser"
cd /opt
sudo git clone https://github.com/nahamsec/JSParser.git
cd /opt/JSParser
sudo python3 setup.py install
echo "Done"

#Sublist3r
cd /opt
echo "Installing Sublist3r"
sudo git clone https://github.com/aboul3la/Sublist3r.git
cd /opt/Sublist3r
pip install -r requirements.txt
cd /opt
echo "Done"

#teh_s3_bucketeers
cd /opt
echo "Installing teh_s3_bucketeers"
sudo git clone https://github.com/tomdev/teh_s3_bucketeers.git
echo "Done"

#wpscan
cd /opt
echo "Installing wpscan"
sudo git clone https://github.com/wpscanteam/wpscan.git
cd /opt/wpscan
sudo gem install bundler && sudo bundle install --local
cd /opt
echo "Done"

#dirsearch
cd /opt
echo "Installing dirsearch"
sudo git clone https://github.com/maurosoria/dirsearch.git
echo "Done"

#lazys3
cd /opt
echo "Installing lazys3"
sudo git clone https://github.com/nahamsec/lazys3.git
echo "Done"

#virtual host discovery
cd /opt
echo "Installing virtual host discovery"
sudo git clone https://github.com/jobertabma/virtual-host-discovery.git
echo "Done"

#sqlmap
cd /opt
echo "Installing sqlmap"
sudo git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
echo "Done"

#knock.py
cd /opt
echo "Installing Knock.py"
sudo git clone https://github.com/guelfoweb/knock.git
echo "Done"

#massdns
cd /opt
echo "Installing massdns"
sudo git clone https://github.com/blechschmidt/massdns.git
cd /opt/massdns
sudo make
cd /opt
echo "Done"

#asnlookup
cd /opt
echo "installing asnlookup"
sudo git clone https://github.com/yassineaboukir/asnlookup.git
cd /opt/asnlookup
pip install -r requirements.txt
cd /opt
echo "Done"

#httprobe
echo "Installing httprobe"
go install github.com/tomnomnom/httprobe@latest
echo "Done"

#install aquatone
cd ~/Downloads
wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip
unzip ~/Downloads/aquatone_linux_amd64_1.7.0.zip
mv ~/Downloads/aquatone ~/go/bin
rm ~/Downloads/aquatone_linux_amd64_1.7.0.zip
rm ~/Downloads/LICENSE.txt
echo "Done"

#unfurl
echo "Installing unfurl"
go install github.com/tomnomnom/unfurl@latest
echo "Done"

#waybackurls
echo "Installing waybackurls"
go install github.com/tomnomnom/waybackurls@latest
echo "Done"

#crtndstry
cd /opt
echo "Installing crtndstry"
sudo git clone https://github.com/nahamsec/crtndstry.git
echo "Done"

#seclists
echo "Installing Seclists"
mkdir ~/Documents/wordlists
cd ~/Documents/wordlists
git clone https://github.com/danielmiessler/SecLists.git
cd ~/Documents/wordlists/SecLists/Discovery/DNS
echo "Cleaning dns-jhaddix.txt so it doesn't break massdns"
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd /opt
echo "Done"

#JohntheRipper
echo "Installing John the Ripper"
sudo apt -y install yasm pkg-config libgmp-dev libpcap-dev libbz2-dev
cd /opt
sudo mkdir /opt/johntheripper
cd /opt/johntheripper
sudo git clone https://github.com/openwall/john -b bleeding-jumbo john
cd /opt/johntheripper/john/src
sudo ./configure && sudo make -s clean && sudo make -sj4
sudo ln -sf /opt/johntheripper/john/run/john /usr/bin/john
echo "Done"

#ffuf
echo "Installing ffuf"
go install github.com/ffuf/ffuf@latest
echo "Done"

#gobuster
echo "Installing Gobuster"
go install github.com/OJ/gobuster/v3@latest
echo "Done"

#feroxbuster
echo "Installing Feroxbuster"
cd /opt
sudo curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/master/install-nix.sh | sudo bash
echo "Done"

#searchsploit
echo "Installing searchsploit"
sudo git clone https://github.com/offensive-security/exploitdb.git /opt/exploitdb
sudo ln -sf /opt/exploitdb/searchsploit /usr/local/bin/searchsploit
echo "Done"

#impacket
echo "Installing impacket"
python3 -m pip install impacket
cd /opt
sudo git clone https://github.com/SecureAuthCorp/impacket
echo "Done"

#metasploit
echo "Installing the Metasploit Framework"
cd ~/Downloads
sudo curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
sudo chmod 755 ~/Downloads/msfinstall
sudo ~/Downloads/msfinstall
sudo ln -sf /opt/metasploit-framework/bin/msfconsole /usr/bin/msfconsole
rm ~/Downloads/msfinstall
echo "Done"

#hydra
echo "Downloading Hydra"
cd ~/Downloads
wget https://github.com/vanhauser-thc/thc-hydra/archive/refs/tags/v9.3.tar.gz
sudo tar -C /opt -xzf ~/Downloads/v9.3.tar.gz
cd /opt/thc-hydra-9.3
sudo ./configure && sudo make && sudo make install
cd /opt
echo "Done"

#zaproxy
cd ~/Downloads
echo "Getting Owasp-Zap installer"
wget https://github.com/zaproxy/zaproxy/releases/download/v2.11.1/ZAP_2_11_1_unix.sh
sudo chmod 755 ~/Downloads/ZAP_2_11_1_unix.sh
echo "Installing Owasp Zap"
sudo ~/Downloads/ZAP_2_11_1_unix.sh
rm ~/Downloads/ZAP_2_11_1_unix.sh
echo "Done"

echo -e "\n\n\n\n\n\n\n\n\n\n\nDone! All tools are set up in either ~/go/bin or in your /opt folder"
echo "nmap, searchsploit, netcat, John the Ripper, Metasploit, and Hydra are already in bin and can be called anywere"
echo "aws credintials can be setup in ~/.aws"
