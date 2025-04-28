# Projet OPSCI : Infrastructure complète avec objets connectés et architecture événementielle

## Vue d'ensemble

Ce projet met en œuvre une architecture complète pour une plateforme de gestion de produits intégrant :
- Une base de données PostgreSQL pour le stockage persistant des données
- Un CMS Strapi pour la gestion des produits
- Une infrastructure événementielle Kafka pour le traitement des données en temps réel
- Un frontend React (optionnel) pour visualiser les données

Le système utilise une architecture orientée événements pour gérer les données des produits, les événements et les mises à jour des stocks en temps réel.

## Structure du projet

\`\`\`
|── product-producer-master
├── data/                   # Fichiers CSV pour les données d'exemple
│   ├── events.csv          # Données d'événements
│   ├── products.csv        # Données de produits
│   └── stocks.csv          # Données de mise à jour des stocks
├── docker-compose_1.yml    # Infrastructure de base (Strapi, PostgreSQL, Kafka, Zookeeper)
├── docker-compose_2.yml    # Producteurs et consommateurs Kafka
├── .env                    # Variables d'environnement pour les connexions Strapi et Kafka
├── demarrage.sh            # Script de démarrage
└── arret.sh                # Script d'arrêt
\`\`\`

## Prérequis

- Docker et Docker Compose
- Un environnement de type Unix (Linux, macOS)

## Pour commencer

### 1. Cloner le dépôt

```bash
git clone https://github.com/ccaglaa/opsci-projet-CR.git
cd opsci-project
```

### 2. Configurer l'environnement 

Créez un fichier .env avec la configuration nécessaire :

bashcat > .env << EOF
STRAPI_URL=http://strapi:1337
STRAPI_TOKEN=votre-token-api
EOF
Vous devrez mettre à jour le STRAPI_TOKEN après avoir configuré Strapi.

### 3. Démarrer l'infrastructure

Exécutez le script de démarrage :


\`\`\`bash
./demarrage.sh
\`\`\`

Cela va :

- Créer le réseau Docker nécessaire
- Démarrer PostgreSQL, Strapi, Zookeeper et Kafka
- Attendre l'initialisation des services
- Démarrer les producteurs et consommateurs Kafka

### 4. Configuration initiale de Strapi

Après avoir démarré les services, accédez au panneau d'administration Strapi à l'adresse http://localhost:1337/admin

1. Créez un compte administrateur
2. Configurez les collections suivantes :
   - Collection **Product** avec les champs:
     - name (short text)
     - description (long text)
     - stock_available (integer, default 0)
     - barcode (short text)
     - status (enumeration: safe|danger|empty)
   - Collection **Event** avec las champs:
     - value (string)
     - metadata (JSON)

3. Générez un token API :
   - Allez dans Paramètres → Utilisateurs et autorisations → Rôles
   - Cliquez sur "Authentifié"
   - Enable permissions for product and event collections
   - Créez un token API
   - Copiez ce token dans votre fichier  \`.env\`

4. Redémarrez les producteurs et consommateurs Kafka :
\`\`\`bash
docker-compose -f docker-compose_2.yml down
docker-compose -f docker-compose_2.yml up -d
\`\`\`

### 5. Vérifier la configuration

Les producteurs liront les données des fichiers CSV et les enverront à Kafka. Les consommateurs récupéreront ensuite ces données et les stockeront dans Strapi.

Vous pouvez vérifier cela en :
Consultant les logs : docker logs -f product_consumer
Regardant dans le panneau d'administration Strapi pour voir les produits et événements créés

### 6. Arrêter l'infrastructure

Pour arrêter tous les services, exécutez :

\`\`\`bash
./arret.sh
\`\`\`

## Détails de l'architecture

### Flux de données

1. Les producteurs lisent les fichiers CSV et envoient les données aux topics Kafka :

- product_producer → topic product
- event_producer → topic event
- stock_producer → topic stock


2. Les consommateurs lisent depuis les topics Kafka et mettent à jour Strapi :

- product_consumer crée des produits dans Strapi
- event_consumer crée des événements dans Strapi
- stock_consumer met à jour les niveaux de stock des produits

### Réseaux

Tous les services sont connectés au même réseau Docker (Strapi), ce qui leur permet de communiquer entre eux en utilisant les noms des conteneurs comme noms d'hôtes.

### COLLABORATEURS

KOPRULU Çagla, 21203337
MOSBAH Rania
