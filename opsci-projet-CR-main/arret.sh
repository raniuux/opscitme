#!/bin/bash

echo "=== Arret du Projet OPSCI ==="

echo "1. Arret des producers et consumers Kafka..."
docker-compose -f docker-compose_2.yml down

echo "2. Arret de Strapi et PostgreSQL..."
docker-compose -f docker-compose_1.yml down

echo "=== Tous les services arretés ==="


