Отлично! Добавим **команду для скачивания скрипта через консоль** с помощью `curl` или `wget`, чтобы пользователь мог легко установить его в любой проект.

---

## ✅ Шаг 2: Скачайте скрипт `push.sh`

```bash
mkdir -p bin
```

Теперь вы можете скачать скрипт напрямую из терминала, используя `curl` или `wget`.

---

### 🖥️ Скачать с помощью `curl` (рекомендуется)

```bash
curl -fsSL https://raw.githubusercontent.com/kolelan/remote-sync/main/bin/push.sh > bin/push.sh
```

---

### 🖥️ Скачать с помощью `wget`

```bash
wget -qO bin/push.sh https://raw.githubusercontent.com/kolelan/remote-sync/main/bin/push.sh
```

---

## ✅ Шаг 3: Сделайте скрипт исполняемым

```bash
chmod +x bin/push.sh
```

---

## ✅ Шаг 4: Добавьте нужные удалённые репозитории

Пример:

```bash
git remote add origin https://github.com/ваш_логин/ваш_репозиторий.git
git remote add verse https://gitverse.org/ваш_логин/ваш_репозиторий.git
```

---

## ▶️ Шаг 5: Запустите скрипт

```bash
./bin/push.sh
```

---

## ✅ Пример использования с `curl` в одном шаге

Вы можете объединить всё в одну команду:

```bash
mkdir -p bin && \
curl -fsSL https://raw.githubusercontent.com/ваш_логин/ваш-репозиторий/main/bin/push.sh > bin/push.sh && \
chmod +x bin/push.sh
```

После этого просто запускайте:

```bash
./bin/push.sh
```
