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