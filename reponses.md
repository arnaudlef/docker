5.a. Récupérer l’image sur le Docker Hub

docker pull nginx
Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:aa0afebbb3cfa473099a62c4b32e9b3fb73ed23f2a75a65ce1d4b4f55a5c2ef2
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest

b. Vérifier que cette image est présente en local

docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
nginx         latest    904b8cb13b93   7 days ago      142MB
ubuntu        latest    74f2314a03de   7 days ago      77.8MB
hello-world   latest    feb5d9fea6a5   17 months ago   13.3kB

c. Créer un fichier index.html simple

/

d. Démarrer un conteneur et servir la page html créée précédemment à l’aide d’un volume (option -v de docker run)

docker run -d -p 80:80 -v ~/html:/usr/share/nginx/html nginx
16bd823f1bbec8d5e0b30237f17063d26b2e7e1df8ea7c8b3d17613efac91c72

e. Supprimer le conteneur précédent et arriver au même résultat que précédemment à l’aide de la commande docker cp

docker stop nostalgic_buck
docker rm nostalgic_buck
docker run -p 80:80 -d nginx
cp index.html e12:/usr/share/nginx/html

6.a. A l’aide d’un Dockerfile, créer une image (commande docker build)

docker build -t my_tp1 .
[+] Building 0.2s (7/7) FINISHED
 => [internal] load build definition from Dockerfile                                                               0.0s
 => => transferring dockerfile: 106B                                                                               0.0s
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => [internal] load metadata for docker.io/library/nginx:latest                                                    0.0s
 => [internal] load build context                                                                                  0.1s
 => => transferring context: 219B                                                                                  0.0s
 => [1/2] FROM docker.io/library/nginx:latest                                                                      0.1s
 => [2/2] COPY ./html/index.html /usr/share/nginx/html                                                             0.0s
 => exporting to image                                                                                             0.0s
 => => exporting layers                                                                                            0.0s
 => => writing image sha256:15c6147a24640d20e6d8aa01c390604b73a26a865b9b4776abf68e0aaea2ab4e                       0.0s
 => => naming to docker.io/library/my_tp1

b. Exécuter cette nouvelle image de manière à servir la page html (commande docker run)

docker run -d -p 80:80 my_tp1
f2968898482d810be1d06cea805e3c0db264a6bb4f3936f34bd35b804c7a1676

c. Quelles différences observez-vous entre les procédures 5. et 6. ? Avantages et inconvénients de l’une et de l’autre méthode ? (Mettre en relation ce qui est observé avec ce qui a été présenté pendant le cours)

La procédure 5 utilise une image venant de Docker Hub et la modifie pour servir une page HTML tandis que la procédure 6 crée une nouvelle image à partir d'un Dockerfile.
l'avantage de la procédure 5 est que c'est plus rapide et simple mais moins personnalisable tandis que la procédure 6 est plus flexible et offre plus de stabilité et de personnalisation mais demande plus de connaissances.

7.a. Récupérer les images mysql:5.7 et phpmyadmin/phpmyadmin depuis le Docker Hub

docker pull mysql:5.7
docker pull phpmyadmin/phpmyadmin

b. Exécuter deux conteneurs à partir des images et ajouter une table ainsi que quelques enregistrements dans la base de données à l’aide de phpmyadmin

docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:5.7
docker run --name phpmyadmin-container --link mysql-container:db -p 8080:80 -d phpmyadmin/phpmyadmin

8.  Faire la même chose que précédemment en utilisant un fichier docker-compose.yml

docker compose up -d

a. Qu’apporte le fichier docker-compose par rapport aux commandes docker run ? Pourquoi est-il intéressant ?

Cela permet de lancer plusieurs containeurs en même temps. C'est intéressant car cela rend l'utilisation des variables d'environnement plus simple.

b. Quel moyen permet de configurer (premier utilisateur, première base de données, mot de passe root, …) facilement le conteneur mysql au lancement ?

Il s'agit de l'utilisation des variables d'environnement.

9.a. A l’aide de docker-compose et de l’image praqma/network-multitool disponible sur le Docker Hub créer 3 services (web, app et db) et 2 réseaux (frontend et backend).
Les services web et db ne devront pas pouvoir effectuer de ping de l’un vers l’autre

docker compose up -d
docker exec -it docker-web-1 //bin/bash
bash-5.1# ping docker-app-1
PING docker-app-1 (172.19.0.2) 56(84) bytes of data.
64 bytes from docker-app-1.docker_frontend (172.19.0.2): icmp_seq=1 ttl=64 time=1.54 ms
64 bytes from docker-app-1.docker_frontend (172.19.0.2): icmp_seq=2 ttl=64 time=0.062 ms
64 bytes from docker-app-1.docker_frontend (172.19.0.2): icmp_seq=3 ttl=64 time=0.063 ms
^C
--- docker-app-1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2069ms
rtt min/avg/max/mdev = 0.062/0.556/1.544/0.698 ms
bash-5.1# ping docker-db-1
ping: docker-db-1: Try again

b. Quelles lignes du résultat de la commande docker inspect justifient ce comportement ?

Il s'agit de la ligne contenant l'adresse IP du conteneur, docker-web-1 et docker-bd-1 ne peuvent pas dialoguer puisque l'un est sur 172.18.x.x et l'autre sur 172.19.x.x

c. Dans quelle situation réelles (avec quelles images) pourrait-on avoir cette configuration réseau ? Dans quel but ?

Cette situation peut arriver dans le cas ou nous avons une appli web, une base de données et une api, il ne faut pas que l'appli web puisse communiquer avec la base sans passer par l'api.