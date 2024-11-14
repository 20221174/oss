node {
	def app
	stage('Clone repository') {
		git 'https://github.com/20221174/oss'
	}
	stage('Build image') {
		app = docker.build("20221174/oss")
	}
	stage('Push image') {
		docker.withRegistry('https://registry.hub.docker.com', '20221174') {
			app.push("${env.BUILD_NUMBER}")
			app.push("latest")
		}
	}
}
