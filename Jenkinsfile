pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: jenkins-kaniko
spec:
  serviceAccountName: jenkins-sa
  containers:
    - name: kaniko
      image: gcr.io/kaniko-project/executor:v1.16.0-debug
      imagePullPolicy: Always
      command:
        - sleep
      args:
        - 99d
    - name: git
      image: alpine/git
      command:
        - sleep
      args:
        - 99d
"""
    }
  }

  environment {
    ECR_REGISTRY = "844446096849.dkr.ecr.eu-central-1.amazonaws.com"
    IMAGE_NAME   = "lesson-5-ecr"
    IMAGE_TAG    = "latest"

    REPO_URL     = "https://github.com/YNazymko12/devops-hw.git"
    APP_BRANCH   = "lesson-4"
    CHART_BRANCH = "lesson-7"
    CHART_PATH   = "lesson-7/charts/django-app"
    COMMIT_EMAIL = "jenkins@localhost"
    COMMIT_NAME  = "jenkins"
  }

  stages {
    stage('Checkout app code (lesson-4)') {
      steps {
        container('git') {
          sh '''
            set -eux
            rm -rf app-src
            git clone --depth 1 --branch "$APP_BRANCH" "$REPO_URL" app-src
            test -f app-src/django/Dockerfile
          '''
        }
      }
    }

    stage('Build & Push Docker Image') {
      steps {
        container('kaniko') {
          withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: 'aws-creds',
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
          ]]) {
            withEnv(["AWS_DEFAULT_REGION=${AWS_REGION}"]) {
              sh '''
                set -eux
                /kaniko/executor \
                  --context `pwd`/app-src/django \
                  --dockerfile `pwd`/app-src/django/Dockerfile \
                  --destination=$ECR_REGISTRY/$IMAGE_NAME:$IMAGE_TAG \
                  --cache=true
              '''
            }
          }
        }
      }
    }

  } 
} 