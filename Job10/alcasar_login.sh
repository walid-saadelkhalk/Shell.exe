if [ $# -ne 2 ]; then
    echo "Usage: $0 username password"
    exit 1
fi

url="https://alcasar.laplateforme.io/intercept.php?res=logoff&uamip=10.10.0.1&uamport=3990&challenge=f946d45fd86ff5fb1eb07b6937b94bf1&called=68-05-CA-3A-2E-49&mac=B4-8C-9D-E7-65-7D&ip=10.10.2.30&nasid=alcasar.laplateforme.io&sessionid=16958291840000016d&ssl=https%3a%2f%2f1.0.0.1%3a3991%2f&userurl=http%3a%2f%2fneverssl.com%2f&md=779A38EEB0F82ED365B6C52C48687E11"


username="walid.saad-el-khalid@laplateforme.io"
password="SYoccMwwade13+"

curl -d "username=$username & password=$password" -X POST "$url"

if [ $? -eq 0 ];
then
        echo "Connexion réussie"

else
        echo "Échec de la connexion"

fi
