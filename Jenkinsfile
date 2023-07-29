pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin "$(aws ecr describe-repositories --region eu-central-1 --repository-names flask --query 'repositories[0].repositoryUri' --output text)"
                docker build -t flask:v1 Flask-app
            }
        }

        stage('Push') {
            steps {
                aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin "$(aws ecr describe-repositories --region eu-central-1 --repository-names flask --query 'repositories[0].repositoryUri' --output text)"
                docker tag flask:v1 $(aws ecr describe-repositories --repository-names flask --query 'repositories[0].repositoryUri' --output text --region eu-central-1):latest
            }
        }

        stage('Deploy') {
            steps {        
            }
        }

    }
}
