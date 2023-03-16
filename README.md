#TP2

2. Compléter le Dockerfile afin de builder correctement l’application contenu dans src/
	a. Une option de npm vous permet de n’installer que ce qui est nécessaire. Quelle est cette option ? Quelle bonne pratique Docker permet t-elle de respecter ?

- Les options npm pour installer uniquement les dépendances requises sont --prod ou -p et évitent d'installer les dépendances de développement.
- Docker recommande de séparer les images prod et dev pour éviter d'installer des dépendances de dev dans l'image prod et de réduire la taille de l'image. 

3. A l’aide de la commande docker build, créer l’image tp2

```
docker build -f Dockerfile -t tp2 .
```

4. Compléter le fichier docker-compose.yml afin d’éxécuter tp2 avec sa base de données

.env :
```
NODE_ENV=production

MYSQL_DATABASE=tp2
MYSQL_USER=root
MYSQL_PASSWORD=root
```