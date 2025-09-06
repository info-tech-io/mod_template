# 📚 InfoTech.io Module Template

Этот шаблон помогает быстро создать новый образовательный модуль для платформы InfoTech.io.

## 🚀 Быстрый старт

### 1. Создание модуля из шаблона

1. Нажмите кнопку **"Use this template"** → **"Create a new repository"**
2. Укажите название: `mod_[название-модуля]` (например: `mod_docker_basics`)
3. Выберите организацию `info-tech-io`
4. Создайте репозиторий

### 2. Настройка шаблона

**Замените следующие placeholders в файлах:**

| Placeholder | Описание | Пример |
|-------------|----------|--------|
| `{{MODULE_NAME}}` | Системное имя модуля | `docker_basics` |
| `{{REPO_NAME}}` | Имя репозитория | `mod_docker_basics` |
| `{{MODULE_TITLE}}` | Человекочитаемое название | `Docker для начинающих` |
| `{{MODULE_DESCRIPTION}}` | Описание курса | `Изучите основы контейнеризации...` |
| `{{MODULE_BANNER}}` | Баннер или изображение | `Banner` или `![Docker](/images/docker-banner.png)` |

**Файлы для редактирования:**
- `.github/workflows/notify-hub.yml`
- `content/_index.md`
- `content/intro/_index.md`
- `content/tests/_index.md`
- `content/tests/quiz-01.json`

### 3. Настройка GitHub Secrets

В Settings → Secrets and variables → Actions добавьте:

- `PAT_TOKEN` - Personal Access Token с правами `repo` и `workflow`

### 4. Регистрация в платформе

Добавьте свой модуль в файл `modules.json` репозитория `infotecha`:

```json
"{{MODULE_NAME}}": {
  "title": "{{MODULE_TITLE}}",
  "description": "{{MODULE_DESCRIPTION}}",
  "subdomain": "{{MODULE_NAME}}",
  "repository": "{{REPO_NAME}}",
  "status": "active",
  "language": "ru",
  "difficulty": "beginner",
  "duration": "4-6 часов",
  "last_updated": "2025-09-06T12:00:00Z"
}
```

## 📁 Структура модуля

```
mod_template/
├── .github/workflows/
│   └── notify-hub.yml          # CI/CD автоматизация
├── content/
│   ├── _index.md              # Главная страница модуля
│   ├── intro/                 # Введение в курс
│   │   └── _index.md
│   ├── topic-01/              # Тема 1: Основы
│   │   └── _index.md
│   ├── topic-02/              # Тема 2: Продвинутые возможности
│   │   └── _index.md
│   └── tests/                 # Проверочные тесты
│       ├── _index.md
│       └── quiz-01.json       # Quiz Engine тест
├── static/
│   └── images/                # Изображения и медиа
├── LICENSE                    # Лицензия MIT
├── README.md                  # Этот файл
└── .gitignore                # Игнорируемые файлы
```

## ✍️ Создание контента

### Добавление новых тем

1. Создайте папку `content/topic-N/`
2. Добавьте файл `_index.md` с содержанием темы
3. Установите правильный `weight = N0` для сортировки

### Создание уроков

Внутри темы создавайте файлы уроков:
```
topic-01/
├── _index.md              # Обзор темы
├── урок-1-введение.md     # Урок 1
├── урок-2-практика.md     # Урок 2
└── урок-3-задания.md      # Урок 3
```

### Работа с Quiz Engine

Редактируйте файл `content/tests/quiz-01.json`:

- `title` - название теста
- `description` - описание теста  
- `questions` - массив вопросов
- `passing_score` - проходной балл (в процентах)

**Типы вопросов:**
- `multiple-choice` - выбор одного правильного ответа
- `true-false` - правда/ложь

### Использование shortcodes

В Markdown можно использовать специальные shortcodes:

```markdown
{{< callout "info" >}}
Информационное сообщение
{{< /callout >}}

{{< button "/next-page/" >}}Текст кнопки{{< /button >}}

{{< block "grid-2" >}}
{{< column >}}Левая колонка{{< /column >}}
{{< column >}}Правая колонка{{< /column >}}
{{< /block >}}

{{< quiz "quiz-01.json" >}}
```

## 🔄 CI/CD Автоматизация

При каждом изменении в папке `content/`:

1. **Notify Hub** - отправляет уведомление в центральный репозиторий
2. **Module Updated** - обновляет реестр модулей (`modules.json`)
3. **Build Module** - собирает сайт с помощью Hugo
4. **Deploy** - развертывает на production сервер `https://{{MODULE_NAME}}.infotecha.ru`

## 📋 Checklist создания модуля

- [ ] Создан репозиторий из template
- [ ] Заменены все placeholders
- [ ] Настроен GitHub Secret `PAT_TOKEN`  
- [ ] Модуль добавлен в `modules.json`
- [ ] Написан контент для всех тем
- [ ] Созданы проверочные тесты
- [ ] Проверена работа CI/CD
- [ ] Модуль доступен на поддомене

## 🆘 Troubleshooting

### Workflow падает с ошибкой

1. Проверьте наличие `PAT_TOKEN` в Secrets
2. Убедитесь, что заменили `{{MODULE_NAME}}` и `{{REPO_NAME}}`
3. Проверьте корректность JSON в quiz файлах

### Модуль не появляется на сайте

1. Проверьте, добавлен ли модуль в `modules.json`
2. Убедитесь, что Build Module workflow завершился успешно
3. Проверьте статус DNS и SSL сертификатов

### Quiz не работает

1. Проверьте синтаксис JSON в quiz файле
2. Убедитесь, что Quiz Engine подключен в теме Hugo
3. Проверьте, что вопросы имеют корректную структуру

## 📞 Поддержка

- 📧 Вопросы по template: создайте Issue в этом репозитории
- 🔧 Техническая поддержка: обратитесь к администратору платформы
- 📚 Документация: [docs.infotecha.ru](https://docs.infotecha.ru)

---

**Создано для платформы InfoTech.io** 🚀