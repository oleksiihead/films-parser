def imageName = 'oleksiihead/films-parser'

node('workers'){
    stage('Checkout SCM'){
        checkout scm
    }

    def imageTest = docker.build("${imageName}-test", "-f Dockerfile.test .")

    stage('Pre-integration Tests') {
        parallel(
            'Quality Tests': {
                imageTest.inside {
                    sh 'golint'
                }
            },
            'Unit Tests': {
                imageTest.inside('-u root:root'){
                    sh 'go test'
                }
            },
            'Security Tests': {
                imageTest.inside('-u root:root'){
                    sh 'nancy Gopkg.lock'
                }
            }
        )
    }
}
