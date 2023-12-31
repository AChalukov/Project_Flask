pipeline {
    agent any
    stages {
        stage("Build") {
            steps {
                sh '''
                aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin "$(aws ecr describe-repositories --region eu-central-1 --repository-names flask --query 'repositories[0].repositoryUri' --output text)"
                docker build -t flask:v1 .
                '''
            }
        }

        stage("Push") {
            steps {
                sh '''
                docker tag flask:v1 $(aws ecr describe-repositories --repository-names flask --query 'repositories[0].repositoryUri' --output text --region eu-central-1):latest
                docker push $(aws ecr describe-repositories --repository-names flask --query 'repositories[0].repositoryUri' --output text --region eu-central-1):latest
                '''
            }
        }

        stage("Inject credentials") {
            steps {
                sh '''
                kubectl create secret docker-registry regcred  --docker-server=$(aws sts get-caller-identity --query 'Account' --output text).dkr.ecr.eu-central-1.amazonaws.com  --docker-username=AWS --docker-password=$(aws ecr get-login-password --region eu-central-1)
                '''
            }
        }

        stage("Deploy") {
            steps {
                sh '''
                helm upgrade flask helm/ --install --wait --atomic
                '''
            }            
        }
    }
}
