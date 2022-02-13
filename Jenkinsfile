def imageName = 'oleksiihead/films-parser'

node('workers'){
    stage('Checkout SCM'){
        checkout scm
    }

    stage('Quality Tests') {
        def imageTest = docker.build("${imageName}-test", "-f Dockerfile.test .")
        imageTest.inside{
            sh 'golint'
        }
    }
}
