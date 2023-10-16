#!/bin/bash

FILE_CSV="/mnt/c/Users/walid/OneDrive/Bureau/loading-work/job09/Shell_Userlist.csv"
LOG_FILE="/mnt/c/Users/walid/OneDrive/Bureau/loading-work/job09/accessrights.log"

log_message() {
    echo "[$(date)] - $1" | tee -a $LOG_FILE
}

log_message "Démarrage du script."

# Vérification de l'existence du fichier
if [ ! -f "$FILE_CSV" ]; then
    log_message "Erreur: Fichier $FILE_CSV non trouvé!"
    exit 1
fi

log_message "Lecture du fichier CSV."

# Parcourir le fichier CSV et créer des utilisateurs
while IFS=, read -r id nom prenom password role
do

log_message "Ligne parsée - Id: $id, Nom: $nom, Prenom: $prenom, Role: $role, Mdp: $password"

role=$(echo "$role" | tr -d '\r')

	# Ignorer la ligne d'en-tête

    if [ "$id" != "id" ]; then
        # Vérifier si l'utilisateur existe déjà
        if id "$nom" &>/dev/null; then
            log_message "L'utilisateur $nom existe déjà."
        else
            # Créer l'utilisateur
            sudo useradd -m -s /bin/bash "$nom"
	    
            echo "$prenom a été mis à jour en super utilisateur et ajouté au groupe sudo."
        
            echo "$prenom ne sera pas mis à jour en super utilisateur."
           
            # Assigner le mot de passe à l'utilisateur
            echo "$nom:$password" | sudo chpasswd
           
            # Définir le commentaire de l'utilisateur pour inclure son nom complet
            sudo usermod -c "$prenom $nom" "$nom"
	 fi
            # Vérifier le rôle et peut-être l'attribuer à un groupe spécifique
            if [ "$role" == "Admin" ]; then
                sudo usermod -aG sudo "$nom"
		echo "réussite"
	    else
		echo "echec"
	    fi

            log_message "Utilisateur $nom créé."

    fi
done < "$FILE_CSV"

log_message "Fin du script."
