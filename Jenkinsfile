pipeline {
    agent any
    environment{
        image_name=aws ecr describe-repositories --repository-names flask --query 'repositories[0].repositoryUri' --output text --region eu-central-1
    }
    stages {
        stage("Build") {
            steps {
                sh '''
                docker image ls
                '''
            }
        }

        }
    }
}
