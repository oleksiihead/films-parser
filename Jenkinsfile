//def imageName = 'oleksiihead/films-parser'
//
//node('workers'){
//    stage('Checkout SCM'){
//        checkout scm
//    }
//
//    def imageTest = docker.build("${imageName}-test", "-f Dockerfile.test .")
//
//    stage('Pre-integration Tests') {
//        parallel(
//            'Quality Tests': {
//                imageTest.inside {
//                    sh 'golint'
//                }
//            },
//            'Unit Tests': {
//                imageTest.inside('-u root:root'){
//                    sh 'go test'
//                }
//            },
//            'Security Tests': {
//                imageTest.inside('-u root:root'){
//                    sh 'nancy Gopkg.lock'
//                }
//            }
//        )
//    }
//}
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
            sh 'nancy /go/src/github/oleksiihead/films-parser/Gopkg.lock'
        }
    }
}
