workflow "Build and Push for Master" {
  on = "push"
  resolves = ["Push Latest"]
}

workflow "Build and Push for Branches" {
  on = "push"
  resolves = ["Push Branch"]
}

action "Build Image" {
  needs = []
  uses = "actions/docker/cli@master"
  args = "build -t wine-coolq ."
}

action "Login Registry" {
  uses = "actions/docker/login@master"
  needs = []
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Tag Image" {
  uses = "actions/docker/tag@master"
  needs = ["Build Image"]
  args = "wine-coolq coolq/wine-coolq --env"
}

action "Filter Master Branch" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Filter Non-master Branch" {
  uses = "actions/bin/filter@master"
  args = "not branch master"
}

action "Filter Release" {
  uses = "actions/bin/filter@master"
  args = "tag 'v*'"
}

action "Push Latest" {
  uses = "actions/docker/cli@master"
  needs = ["Filter Master Branch", "Tag Image", "Login Registry"]
  args = "push coolq/wine-coolq:latest"
}

action "Push Branch" {
  uses = "actions/docker/cli@master"
  needs = ["Filter Non-master Branch", "Tag Image", "Login Registry"]
  args = "push coolq/wine-coolq:$IMAGE_REF"
}
