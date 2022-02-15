def imageName = "oleksiihead/films-parser:${BUILD_ID}"
//def registry = 'https://registry.smiichuk.click'

node('workers'){
    stage('Checkout'){
        checkout scm
    }

    def imageTest= docker.build("${imageName}-test", "-f Dockerfile.test .")

    stage('Pre-integration Tests'){
        parallel(
            'Quality Tests': {
                imageTest.inside{
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
                    sh 'nancy sleuth -p /go/src/github/mlabouardy/movies-parser/Gopkg.lock'
                }
            }
        )
    }

    stage('Build'){
        docker.build(imageName)
    }

//     stage('Push'){
//         docker.withRegistry(registry, 'registry') {
//             docker.image(imageName).push(commitID())
//
//             if (env.BRANCH_NAME == 'develop') {
//                 docker.image(imageName).push('develop')
//             }
//         }
//     }
}

def commitID() {
    sh 'git rev-parse HEAD > .git/commitID'
    def commitID = readFile('.git/commitID').trim()
    sh 'rm .git/commitID'
    commitID
}