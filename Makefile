DEPLOYMENT_BUCKET_NAME := desole-packaging
DEPLOYMENT_KEY := $(shell echo sox-$$RANDOM.zip)
STACK_NAME := sox-lambda-layer

clean: 
	rm -rf build

build/layer.zip: vendor/bin/sox
	mkdir -p build
	cd vendor && zip -yr ../build/layer.zip bin

# cloudformation has no support for packaging layers yet, so need to do this manually
#
build/output.yml: build/layer.zip cloudformation/template.yml
	aws s3 cp build/layer.zip s3://$(DEPLOYMENT_BUCKET_NAME)/$(DEPLOYMENT_KEY)
	sed "s:DEPLOYMENT_BUCKET_NAME:$(DEPLOYMENT_BUCKET_NAME):;s:DEPLOYMENT_KEY:$(DEPLOYMENT_KEY):" cloudformation/template.yml > build/output.yml

deploy: build/output.yml
	aws cloudformation deploy --template-file build/output.yml --stack-name $(STACK_NAME)
	aws cloudformation describe-stacks --stack-name $(STACK_NAME) --query Stacks[].Outputs[].OutputValue --output text

