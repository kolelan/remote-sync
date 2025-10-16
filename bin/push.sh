#!/bin/bash

# Константа — ветка по умолчанию
BRANCH_DEFAULT="main"

# Если передан аргумент — используем его, иначе — значение по умолчанию
BRANCH=${1:-$BRANCH_DEFAULT}

echo "Публикуем изменения в origin на ветку $BRANCH..."
git push origin "$BRANCH"

echo "Публикуем изменения в verse на ветку $BRANCH..."
git push verse "$BRANCH"

echo "Синхронизация завершена."