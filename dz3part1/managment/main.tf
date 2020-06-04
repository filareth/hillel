resource "aws_iam_user" "developer-test" {
  name = "developer-test"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}
