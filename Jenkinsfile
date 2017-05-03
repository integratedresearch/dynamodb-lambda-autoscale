def err

node ('docker') {

  def lambda_node_image = docker.image('irlagrange/node4.3.2-sls1.x')
  lambda_node_image.pull()
  lambda_node_image.inside {
    try {
      stage 'Initial setup'
        checkout scm
    }
    catch (caughtError) {
      err = caughtError
      currentBuild.result = "Failure"

      stage 'Email'
        lib.sendBuildNotification("Failed: UCR ${aws_stage} stage", aws_stage)
    }
    finally {

      // delete the workspace.
      step([$class: 'WsCleanup'])

      // Must re-throw exception to propagate error
      if (err) {
        throw err
      }
    }
  }
}