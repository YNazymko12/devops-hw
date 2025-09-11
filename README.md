# Домашнє завдання до теми «Вивчення Helm»

## Опис

У цьому проєкті реалізовано інфраструктуру для запуску Django-застосунку в
Kubernetes.  
Використовуються **Terraform** для створення ресурсів в AWS та **Helm** для
деплойменту застосунку.

## Виконані кроки

### 1. Створення Kubernetes-кластера (EKS)

- За допомогою Terraform у вже існуючій VPC створено кластер Kubernetes (EKS).
- Налаштовано доступ до кластера через `kubectl`.

### 2. Elastic Container Registry (ECR)

- Terraform створює ECR-репозиторій.
- Django Docker-образ завантажено в ECR за допомогою AWS CLI:

```bash
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
docker build -t django-app .
docker tag django-app:latest <account_id>.dkr.ecr.<region>.amazonaws.com/django-app:latest
docker push <account_id>.dkr.ecr.<region>.amazonaws.com/django-app:latest
```

### 3. Helm-чарт

У каталозі `charts/django-app/` реалізовано:

- **Deployment** — запускає контейнер із образом із ECR, підключає `ConfigMap`
  через `envFrom`.
- **Service** — типу `LoadBalancer` для зовнішнього доступу.
- **HPA** — масштабує від 2 до 6 подів при CPU > 70%.
- **ConfigMap** — з усіма змінними середовища (перенесеними з попереднього
  завдання).
- **values.yaml** — містить параметри образу, сервісу, autoscaler та
  конфігурації.

---

### 4. Деплоймент застосунку

```bash
helm install django-app ./charts/django-app
```

## Результат

![Results](./assets/terraform.png) ![Results](./assets/docker.png)
![Results](./assets/ecr.png) ![Results](./assets/eks.png)
![Results](./assets/terminal.png)
