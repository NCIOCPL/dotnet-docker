# Jenkins Setup Script
This is a single, easily configured script, for creating/updating more complex Jenkins jobs.

## Pre-requisites
* [Jenkins](https://jenkins.io/)
* [Job DSL Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Job+DSL+Plugin)
* [Git Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin)
* [Credentials Binding Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Credentials+Binding+Plugin) (Included w/ Jenkins'
    recommended plugins)
* [EnvInject Plugin](https://wiki.jenkins-ci.org/display/JENKINS/EnvInject+Plugin)
* [GitHub Release Tool](https://github.com/aktau/github-release/)

## Files
* **setup.job** - Job definition file, written in the [Job DSL](https://wiki.jenkins-ci.org/display/JENKINS/Job+DSL+Plugin).
    This is the "Seed Job" responsible for installing the other jobs in Jenkins.
* **build.sh** (In tools/build) - The shell script responsible for performing the work needed for a specific task.

## Installing the seed job.
1. Create a new FreeStyle job.
2. In the General section:
    * Specify a project name.
3. In the "Source Code Management" section:
  1. Select "Git"
  2. Specify the GitHub project (e.g. [https://github.com/NCIOCPL/sitewide-search-api](https://github.com/NCIOCPL/sitewide-search-api)).
  3. Verify the value for "Branch Specifier"
3. In the Build section:
  1. Click the "Add build step" button.
  2. Select "Process Job DSLs."
  3. Verify that "Look on Filesystem" is selected.
  4. For "DSL Scripts," specify "tools/jenkins/setup.job" (the actual script file will be downloaded automatically)
4. Click the "Save" button.

## Docker Credentials
The "build" task pushes the built images to a central Docker repository. This requires a set of credentials be set up in Jenkins.

1. Login to the Jenkins server.
2. In the main project folder (e.g. dotnet-images), click "Credentials."
3. Click the "global" store (the linked word in any of the displayed lists).
4. Click "Add Credentials" on the menu.
5. Fill out the form:
    * **Kind:** select "Username with password"
    * **Username:** The user name for the build process to login to the Docker repository.
    * **Username:** The corresponding password for the Docker repository.
    * **ID:** "NCIOCPL-Docker-User" (Must be this exact string, this value is used for identifying the key).
6. Click "OK"
