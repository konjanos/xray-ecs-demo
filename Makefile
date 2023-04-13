ecr: container
	ecs-cli push xray-ecs-demo

container:
	docker build -t xray-ecs-demo .

setup:
	sudo curl -Lo /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
	sudo chmod +x /usr/local/bin/ecs-cli

set_env:
	export TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
	export REGION=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s 169.254.169.254/latest/meta-data/placement/region)
	export ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
