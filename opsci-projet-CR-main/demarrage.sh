#!/bin/bash

echo "=== Demarrage du Projet OPSCI  ==="
echo "1. Creation du network (si cela n'existe pas)..."
docker network create Strapi || true

echo "2. Demarrage Strapi et PostgreSQL"
docker-compose -f docker-compose_1.yml up -d

echo "3. Attente pour l'initialisation de Strapi"
sleep 20

echo "4. Demarrage des Producers et Consumers de Kafka"
docker-compose -f docker-compose_2.yml up -d

echo "=== L'infrastructure est démarrée ==="
echo "• Strapi Admin: http://localhost:1337/admin"
echo "• React Frontend: http://localhost:5174"
echo ""
echo "Vous pouvez visualiser les logs avec:"
echo "  docker logs -f product_consumer"
echo "  docker logs -f event_consumer"
echo "  docker logs -f stock_consumer"

