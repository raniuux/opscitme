# OPSCI - Projet CR (Kafka, Strapi, MQTT)

Bienvenue dans le projet OPSCI-CR ! Ce projet consiste à construire un système de communication entre des producteurs et consommateurs d'événements via **Kafka** et **MQTT**, en intégrant **Strapi** comme backend de stockage.

---

## Prérequis

- Docker
- Docker Compose
- Node.js (facultatif pour développement local)
- Accès à un dépôt Git (GitHub, GitLab, etc.)

## Architecture

- **Kafka** : Middleware de message
- **Zookeeper** : Coordination de Kafka
- **Mosquitto** : Serveur MQTT
- **mqtt-kafka-connector** : Pont MQTT -> Kafka
- **Producers** (produits, stocks, événements) : Envoient des messages
- **Consumers** : Lisent les messages et créent des entrées dans Strapi
- **Strapi** : Backend headless CMS (externe)

## Démarrage du projet

### 1. Cloner le projet

```bash
git clone https://github.com/votre-utilisateur/votre-repo.git
cd votre-repo
```

### 2. Remplir les fichiers d'environnement

Créer un fichier `.env` à la racine :

```bash
STRAPI_URL=http://host.docker.internal:1337
STRAPI_TOKEN=VotreTokenStrapi
BROKER_1=kafka:9092
BROKER_2=kafka:9092
BROKER_3=kafka:9092
KAFKA_TOPIC=stock
MQTT_TOPIC=topic
MQTT_ENDPOINT=ws://localhost:1883
```

### 3. Lancer Docker Compose

```bash
docker compose up --build
```

### 4. Accéder aux services

- Kafka : `localhost:9092`
- Mosquitto : `localhost:1883`
- Strapi : `http://localhost:1337`

## Structure du projet

```
.
├── docker-compose.yml
├── .env
├── .gitignore
├── data/
│   ├── products.csv
│   ├── events.csv
│   └── stocks.csv
├── product-producer-master/
│   └── Dockerfile
├── README.md
...
```

## Notes importantes

- Le **Strapi** n'est pas dans Docker ici. Vous devez donc utiliser `host.docker.internal` pour y accéder depuis vos conteneurs.
- Assurez-vous que **Strapi est démarré** avant vos conteneurs consumers/producers.
- Les fichiers `.csv` doivent être bien formatés.

## Pour contribuer

1. Forkez le repo
2. Créez une branche

```bash
git checkout -b feature/amélioration
```

3. Committez vos modifications

```bash
git commit -m "feat: ajout d'un nouveau producer"
```

4. Pushez

```bash
git push origin feature/amélioration
```

5. Créez une Pull Request

## Auteur
Rania Mosbah 21204630 Cagla Koprulu 21203337

## License

Ce projet est sous licence MIT.

