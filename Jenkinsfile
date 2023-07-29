pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh '''
                ls
                docker build -t flask:v1 Flask-app .
                '''            
            }
        }
    }
}
