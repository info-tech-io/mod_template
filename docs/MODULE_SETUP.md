# Настройка module.json для нового модуля

## Инструкции по созданию модуля

При создании нового образовательного модуля для платформы ИНФОТЕКА необходимо заполнить файл `module.json` в корневой директории репозитория.

## Пошаговая инструкция

### 1. Скопируйте template

```bash
# Клонируйте mod_template
git clone https://github.com/info-tech-io/mod_template.git mod_your_module_name

# Перейдите в директорию
cd mod_your_module_name

# Обновите remote origin
git remote set-url origin https://github.com/info-tech-io/mod_your_module_name.git
```

### 2. Заполните module.json

Откройте файл `module.json` и замените все placeholder значения:

#### Базовая информация

```json
{
  "name": "your-module-name",           // ЗАМЕНИТЕ: Имя модуля (kebab-case)
  "title": "Название Вашего Модуля",    // ЗАМЕНИТЕ: Читаемое название
  "description": "Подробное описание модуля...", // ЗАМЕНИТЕ: Описание 20-500 символов
  "version": "0.1.0"                    // ОСТАВЬТЕ: Начальная версия
}
```

#### Конфигурация развертывания

```json
{
  "deployment": {
    "subdomain": "your-module-name",    // ЗАМЕНИТЕ: Должно совпадать с name
    "repository": "mod_your_module_name", // ЗАМЕНИТЕ: Имя репозитория
    "build_system": "hugo-base"         // ОСТАВЬТЕ: Пока используем hugo-base
  }
}
```

#### Метаданные

```json
{
  "metadata": {
    "author": "Ваше Имя",               // ЗАМЕНИТЕ: Автор модуля
    "difficulty": "beginner",           // ВЫБЕРИТЕ: beginner/intermediate/advanced/expert
    "estimated_time": "20 hours",       // ЗАМЕНИТЕ: Оценочное время изучения
    "tags": ["tag1", "tag2", "tag3"]    // ЗАМЕНИТЕ: 1-10 тегов описывающих модуль
  }
}
```

#### URL-адреса

```json
{
  "urls": {
    "production": "https://your-module-name.infotecha.ru",
    "repository": "https://github.com/info-tech-io/mod_your_module_name",
    "issues": "https://github.com/info-tech-io/mod_your_module_name/issues"
  }
}
```

#### Статус

```json
{
  "status": {
    "lifecycle": "development",         // ОСТАВЬТЕ: Начальный статус
    "last_updated": "2025-09-20",      // ЗАМЕНИТЕ: Текущая дата
    "content_complete": false,          // ОСТАВЬТЕ: false для нового модуля
    "testing_complete": false,          // ОСТАВЬТЕ: false для нового модуля
    "review_complete": false            // ОСТАВЬТЕ: false для нового модуля
  }
}
```

### 3. Примеры заполнения

#### Модуль по Python для начинающих:

```json
{
  "schema_version": "1.0",
  "name": "python-basics",
  "title": "Основы Python",
  "description": "Введение в программирование на языке Python для начинающих разработчиков",
  "version": "0.1.0",
  "type": "educational",

  "deployment": {
    "subdomain": "python-basics",
    "repository": "mod_python_basics",
    "build_system": "hugo-base"
  },

  "hugo_config": {
    "template": "default",
    "theme": "compose",
    "components": ["quiz-engine"],
    "hugo_version": "0.148.0"
  },

  "metadata": {
    "author": "Иван Петров",
    "maintainer": "info-tech-io",
    "license": "MIT",
    "difficulty": "beginner",
    "estimated_time": "30 hours",
    "language": "ru",
    "tags": ["python", "programming", "beginner", "fundamentals"]
  },

  "urls": {
    "production": "https://python-basics.infotecha.ru",
    "repository": "https://github.com/info-tech-io/mod_python_basics",
    "issues": "https://github.com/info-tech-io/mod_python_basics/issues"
  },

  "status": {
    "lifecycle": "development",
    "last_updated": "2025-09-20",
    "content_complete": false,
    "testing_complete": false,
    "review_complete": false
  }
}
```

#### Модуль по Docker для продвинутых:

```json
{
  "schema_version": "1.0",
  "name": "docker-advanced",
  "title": "Продвинутый Docker",
  "description": "Углубленное изучение Docker: оркестрация, безопасность, оптимизация производительности",
  "version": "0.1.0",
  "type": "educational",

  "deployment": {
    "subdomain": "docker-advanced",
    "repository": "mod_docker_advanced",
    "build_system": "hugo-base"
  },

  "hugo_config": {
    "template": "default",
    "theme": "compose",
    "components": ["quiz-engine"],
    "hugo_version": "0.148.0"
  },

  "metadata": {
    "author": "Анна Сидорова",
    "maintainer": "info-tech-io",
    "license": "MIT",
    "difficulty": "advanced",
    "estimated_time": "50 hours",
    "language": "ru",
    "tags": ["docker", "containers", "devops", "orchestration", "advanced"]
  },

  "urls": {
    "production": "https://docker-advanced.infotecha.ru",
    "repository": "https://github.com/info-tech-io/mod_docker_advanced",
    "issues": "https://github.com/info-tech-io/mod_docker_advanced/issues"
  },

  "status": {
    "lifecycle": "development",
    "last_updated": "2025-09-20",
    "content_complete": false,
    "testing_complete": false,
    "review_complete": false
  }
}
```

### 4. Валидация

После заполнения обязательно проверьте корректность:

```bash
# Из репозитория infotecha
node scripts/validate-module.js path/to/your/module.json

# Или для удаленной валидации
node scripts/validate-module.js --url https://raw.githubusercontent.com/info-tech-io/mod_your_module/main/module.json
```

### 5. Важные правила

#### Соглашения по именованию:
- **name**: kebab-case (только строчные буквы, цифры, дефисы)
- **repository**: snake_case с префиксом mod_
- **subdomain**: должен совпадать с name
- **tags**: kebab-case, 2-30 символов каждый

#### Обязательные поля:
- Все поля, отмеченные как "required" в JSON Schema
- Минимум 1 тег, максимум 10
- description: 20-500 символов
- estimated_time: формат "N hours/days/weeks"

#### Рекомендации:
- Указывайте license (рекомендуется MIT)
- Добавляйте 3-5 тегов для лучшей категоризации
- Используйте понятные описания на русском языке
- Обновляйте last_updated при изменениях

### 6. Статусы lifecycle

- **development**: Модуль в разработке
- **beta**: Готов для тестирования
- **stable**: Готов для production
- **maintenance**: Только исправления ошибок
- **deprecated**: Устаревший, не рекомендуется

### 7. Уровни сложности

- **beginner**: Для начинающих, без предварительного опыта
- **intermediate**: Требует базовых знаний в области
- **advanced**: Для опытных пользователей
- **expert**: Экспертный уровень, глубокие знания

### 8. Автоматическое обнаружение

После создания module.json и push в репозиторий:

1. Модуль автоматически обнаруживается системой сканирования
2. Информация добавляется в каталог платформы
3. Модуль становится доступен для сборки и развертывания

### 9. Получение помощи

- Документация JSON Schema: `/docs/MODULE_JSON_SPEC.md` в репозитории infotecha
- Вопросы и Issues: https://github.com/info-tech-io/infotecha/issues
- Примеры: Посмотрите на существующие модули mod_linux_*

---

**Важно**: После создания module.json не забудьте обновить README.md модуля и заполнить директорию content/ образовательными материалами!