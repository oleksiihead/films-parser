def imageName = 'oleksiihead/films-parser'

node('workers'){
    stage('Checkout SCM'){
        checkout scm
    }

    def imageTest = docker.build("${imageName}-test", "-f Dockerfile.test .")

    stage('Quality Tests') {
        imageTest.inside{
            sh 'golint'
        }
    }

    stage('Unit Tests') {
        //imageTest.inside{
        imageTest.inside('-u root:root'){
            sh 'go test'
        }
    }

    stage('Security Tests') {
        imageTest.inside('-u root:root'){
            sh 'nancy /go/src/github/oleksiihead/films-parser/Gopkc.lock'
        }
    }
}
