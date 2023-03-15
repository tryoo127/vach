#wget https://github.com/${GitUser}/
GitUser="tryoo127"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "\e[32mloading...\e[0m"
clear
# Valid Script
VALIDITY () {
    today=`date -d "0 days" +"%Y-%m-%d"`
    Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}')
    if [[ $today < $Exp1 ]]; then
    echo -e "\e[32mYOUR SCRIPT ACTIVE..\e[0m"
    else
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m";
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    exit 0
fi
}
IZIN=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | awk '{print $5}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "\e[32mPermission Accepted...\e[0m"
VALIDITY
else
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
exit 0
fi
echo -e "\e[32mloading...\e[0m"
clear
IP=$(wget -qO- icanhazip.com);
date=$(date +"%Y-%m-%d")
clear
echo " Enter Your Email To Receive Message"
read -rp " Email: " -e email
sleep 1
echo Directory Created
mkdir /root/backup
sleep 1
echo Start Backup
clear
cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp -r /usr/local/etc/xray backup/xray
cp -r /home/vps/public_html backup/public_html
cd /root
zip -r Backup-$date.zip backup > /dev/null 2>&1
rclone copy /root/Backup-$date.zip dr:backup/
url=$(rclone link dr:backup/Backup-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Link Backup   : $link
Date Backup   : $date
==================================
" | mail -s "VPS Backup Data | $date" $email
rm -rf /root/backup
rm -r /root/Backup-$date.zip
clear
echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Link Backup   : $link
Date Backup   : $date
==================================
"
echo -e "\e[0;37m Backup Done!"
echo ""
echo -e "\e[0;37m Please Copy & Save The Link"
echo ""
read -sp " Press ENTER to go back"
echo ""
menu