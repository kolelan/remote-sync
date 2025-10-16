#!/bin/bash

# Константа — ветка по умолчанию
BRANCH_DEFAULT="main"

# Если передан аргумент — используем его, иначе — значение по умолчанию
BRANCH=${1:-$BRANCH_DEFAULT}

echo "=== Синхронизация репозиториев ==="
echo "Используем ветку: $BRANCH"

# Получаем список всех удалённых репозиториев
REPOS=$(git remote)

SUCCESS_COUNT=0
FAILED_COUNT=0

for REMOTE in $REPOS; do
    echo ""
    echo "Пушим в репозиторий $REMOTE на ветку $BRANCH..."

    # Проверяем доступность репозитория
    if ! git ls-remote "$REMOTE" &> /dev/null; then
        echo "❌ Репозиторий $REMOTE недоступен. Пропускаем..."
        ((FAILED_COUNT++))
        continue
    fi

    # Выполняем пуш
    if git push "$REMOTE" "$BRANCH"; then
        echo "✅ Успешно отправлено в $REMOTE"
        ((SUCCESS_COUNT++))
    else
        echo "❌ Ошибка при пуш в $REMOTE"
        ((FAILED_COUNT++))
    fi
done

echo ""
echo "📊 Статистика:"
echo "✅ Успешно: $SUCCESS_COUNT репозиториев"
echo "❌ Неудачно: $FAILED_COUNT репозиториев"
echo "=== Синхронизация завершена ==="