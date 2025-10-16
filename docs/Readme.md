Отлично! Вот **готовая и структурированная инструкция**, которую можно использовать в `README.md` или как отдельный гайд, чтобы помочь другим пользователям **скачать и установить скрипт `bin/push.sh`** в любой их проект.

---

## 📥 Как быстро добавить `bin/push.sh` в ваш проект

### ✅ Шаг 1: Создайте папку `bin` в корне вашего проекта

Если папки `bin` ещё нет — создайте её:

```bash
mkdir -p bin
```

---

### ✅ Шаг 2: Скачайте скрипт `push.sh`

Скопируйте содержимое ниже в файл `bin/push.sh`:

```bash
#!/bin/bash

# Получаем текущую ветку
CURRENT_BRANCH=$(git branch --show-current)

# Запрашиваем ветку
read -p "Введите имя ветки для пуша (Enter = $CURRENT_BRANCH): " BRANCH
BRANCH=${BRANCH:-$CURRENT_BRANCH}

echo ""
echo "Выбрана ветка: $BRANCH"

# Получаем список удалённых репозиториев
REPOS=($(git remote))
REPO_COUNT=${#REPOS[@]}

if [ "$REPO_COUNT" -eq 0 ]; then
    echo "Нет удалённых репозиториев."
    exit 1
fi

# Выводим список репозиториев
echo "Доступные репозитории:"
for i in "${!REPOS[@]}"; do
    echo "$((i+1)) - ${REPOS[$i]}"
done

# Запрашиваем выбор
read -p "Выберите репозиторий по номеру (Enter = все): " CHOICE

# Проверяем, был ли введён номер
if [[ "$CHOICE" =~ ^[0-9]+$ && "$CHOICE" -ge 1 && "$CHOICE" -le "$REPO_COUNT" ]]; then
    SELECTED_REPO="${REPOS[$((CHOICE-1))]}"
    echo ""
    echo "Пушим только в репозиторий: $SELECTED_REPO"
    REMOTES_TO_PUSH=("$SELECTED_REPO")
else
    echo ""
    echo "Пушим во все репозитории:"
    REMOTES_TO_PUSH=("${REPOS[@]}")
fi

SUCCESS_COUNT=0
FAILED_COUNT=0

for REMOTE in "${REMOTES_TO_PUSH[@]}"; do
    echo "Пушим в $REMOTE на ветку $BRANCH..."

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
```

---

### ✅ Шаг 3: Сделайте скрипт исполняемым

```bash
chmod +x bin/push.sh
```

---

### ✅ Шаг 4: Добавьте нужные удалённые репозитории

Пример:

```bash
git remote add origin https://github.com/ваш_логин/ваш_репозиторий.git
git remote add verse https://gitverse.org/ваш_логин/ваш_репозиторий.git
```

---

### ▶️ Шаг 5: Запустите скрипт

```bash
./bin/push.sh
```

---

## 🧪 Пример работы

```
Введите имя ветки для пуша (Enter = main): 

Выбрана ветка: main

Доступные репозитории:
1 - origin
2 - verse
Выберите репозиторий по номеру (Enter = все): 1

Пушим только в репозиторий: origin

Пушим в origin на ветку main...
✅ Успешно отправлено в origin

📊 Статистика:
✅ Успешно: 1 репозиториев
❌ Неудачно: 0 репозиториев
=== Синхронизация завершена ===
```

---

## 🧩 Что делает скрипт?

- Автоматически получает список удалённых репозиториев.
- Интерактивно запрашивает ветку и репозиторий.
- Проверяет доступность каждого репозитория.
- Выполняет `git push`.
- Логирует успех/ошибки.
- Выводит статистику.

---

## 🧾 Дополнительно

Если вы хотите использовать этот скрипт часто — вы можете:

- Добавить его как **submodule** из своего репозитория.
- Создать алиас в `.bashrc` или `.zshrc`:

```bash
alias push-all='./bin/push.sh'
```

---

## 🧼 Поддерживаемые платформы

- Linux
- macOS
- Windows (через WSL или PowerShell)

---

