
backup=~/job08/Backup

mkdir -p "$backup"


nombre_connexions=$(grep -P "logind.*walidsaad" /var/log/auth.log | wc -l)

date=$(date +"%d-%m-%Y-%H:%M")

fichier="$backup/number_connection-$date.txt"


echo "$nombre_connexions" > "$fichier"


tar -czf "$backup/number_connection-$date.tar" "number_connection-$date.txt" "$backup"

