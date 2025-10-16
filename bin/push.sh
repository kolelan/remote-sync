#!/bin/bash

# Скрипт для пуша изменений в оба репозитория: origin и verse

echo "Публикуем изменения в origin..."
git push origin main

echo "Публикуем изменения в verse..."
git push vers main

echo "Синхронизация завершена."