pipeline
{
  //https://www.jenkins.io/doc/book/pipeline/syntax/
  agent any
  options
  {
    skipDefaultCheckout()
  }

  parameters
  {
    choice(name: 'environment', choices: ['dev', 'test', 'impl', 'prod'], description: 'Environment to run on')
    string(name: 'tagSearchingFor', defaultValue: '', description: 'Tag to search for')
  }

  stages
  {
    stage('Checkout SCM')
    {
      steps
      {
				checkout scm
      }
    }
    stage('Scan')
    {
      steps
      {
        script
        {
          timeout (time: 30, unit: 'SECONDS')
          {
            echo "=========== Scan Stage ==========="

            //Use string from user to search for tags
            //log searches just the commit logs
            //--pretty is the format of the output
            //-1 only searches the last commit
            //To make more precise, add -w to grep
            //To make case insensitive, add -i to grep
            //https://stackoverflow.com/a/38783622
            //git log --grep="#" -w --pretty="%h" --name-only --no-commit-id
            //git log --grep="#" --pretty="%h" --name-only --no-commit-id
            //git log --oneline | grep -w "#6"
            TAG_FOUND = sh (
            script: "git log -1 --pretty=%B | grep '${tagSearchingFor}'",
            returnStatus: true
            ) == 0
            echo "Tag Found: ${TAG_FOUND}"

            //If the release tag is not found, run this until found
            while(!TAG_FOUND)
            {
              echo "Release tag: ${tagSearchingFor} not found"

              //If not found, notify user and prompt for new string
              def userInput = input(id: 'tagSearch', message: 'Tag not found',
                parameters: [
                  string(
                    defaultValue: 'Release Tag',
                    description: 'Tag to search for',
                    name: 'Release')
                  ])
              tagSearchingFor = userInput
              //if the userInput is found, exit loop
              TAG_FOUND = sh (
                script: "git log -1 --pretty=%B | grep '${userInput}'",
                returnStatus: true
              ) == 0
              echo "Tag Found: ${TAG_FOUND}"
            }
          }
        }
      }
    }
    stage('Build')
    {
      steps
      {
      script
      {
        echo "=========== Build Stage ==========="
        //Code tagged with the search string or associated with the release is
        //gathered and placed on the Linux server into three directories -
        // (on server or on S3 or
        //in a Github/Release Repository to be determined) they are being picked
        //from. This should be configurable ideally using a YAML config file –
        //mapping all SQL folders to one of these three folders.)
        HASH_FOUND = sh (
          script: "git log --pretty=oneline | grep '${tagSearchingFor}'",
          returnStatus: true
        ) == 0
        echo "Tag Found: ${TAG_FOUND}"
      }
      }
    }
    stage('Post Build Test')
    {
      steps
      {
        echo "=========== Post Build Test Stage ==========="
        //Scan the code using Fortify/SonarQube and provide notification (log
        //and email) of any vulnerability and code quality issues which can be
        //sent to team distribution list. (Not clear if this step should be
        //done on the scripts or in the database).
      }
    }
    stage('Deploy')
    {
      steps
      {
        echo "=========== Deploy Stage ==========="
        //Use SQLPlus plugin to deploy to the test
        //database and schema as per the config files specified in the Notes
        //section below.

        //Collect all the responses from the compilation effort and log them to
        //the /release/logs folder and email them to a distribution list.

        //Copy all the Shell scripts to the exact location they need to be – to
        //complete the Linux Shell script deployment.

        //Notify on distribution list if there are any compilation or
        //execution issues.

        //If this is a more appropriate place for Fortify/SonarQube scanning –
        //then include here instead of in Build phase
      }
    }
    stage('Post Deploy Test')
    {
      steps
      {
        echo "=========== Post Deploy Test Stage ==========="
        //Use SQLPlus to call a SQL Procedure in the
        //target database with parameters (one of them release string – others
        //to be defined). team to code this in PL/SQL. The procedure will
        //run some scripts on the database side and provide outputs.

        //These outputs should be logged, they be visible in console output and
        //emailed to a distribution list.

        //Above cycle to continue till all issues are resolved and build is
        //ready for production deployment. So while the release will be
        //XXX_24.3 the last two digits in XXX_24.3.XX will signify the build
        //number i.e. if this cycle had to be repeated thrice to fix issues,
        //include enhancements the build will be 03 and so the entire release
        //will be XXX_24.3.03. The folder structure can be determined.
      }
    }
    stage('Gate Review')
    {
      steps
      {
        echo "=========== Gate Review Stage ==========="
        //Oracle DBA to perform spot checks the release artifacts

        //Linux System Admin to perform spot checks on the release artifacts

        //This step will be manual initially to identify any issues which can be
        //automated or fixed as part of the process.

        //The Release Manager approves the latest build of the release using a
        //drop box/check box with Submit and a confirmation question “Are you
        //sure you want to approve this build?”
        input("Are you sure you want to approve this?")
      }
    }
    stage('Release')
    {
      steps
      {
        echo "=========== Release Stage ==========="
        //On clicking of the release button, obtain the latest build from the
        //release artifacts from the “Approved” build above.

        //Using SQLPlus plugin, first deploy the

        //Next step is moving the shell scripts to required folders on the
        //target server.

        //Scan deployed code using Fortify and SonarQube
      }
    }
  }
}
