CHART_NAME ?= olm
CHART_VERSION ?= 1.0.0
# TARGET_IMAGE_REPO ?= ccr.ccs.tencentyun.com/tke-market
TARGET_IMAGE_REPO ?= blackholex
##@ General

help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Build

.PHONY: build-chart
build-chart: ## Build helm chart package
	helm package olm

.PHONY: lint-chart
lint-chart: ## Verify chart lint error
	helm lint $(CHART_NAME)-$(CHART_VERSION).tgz

##@ Development

.PHONY: install-chart
install-chart: build-chart lint-chart ## Install chart for dev test
	helm install $(CHART_NAME) $(CHART_NAME)-$(CHART_VERSION).tgz -n kube-system --debug

.PHONY: check-installed
check-installed: ## Check installed chart
	helm list -n kube-system
	kubectl get deploy,po -n operator-lifecycle-manager
	kubectl get csv -n operator-lifecycle-manager
	kubectl get og -n operator-lifecycle-manager
	kubectl get og -n operators

.PHONY: uninstall-chart
uninstall-chart: ## Uninstall chart for dev test
	helm uninstall $(CHART_NAME) -n kube-system --debug


##@ Release

.PHONY: push-images
push-images: ## Push olm related images to repo
	docker pull quay.io/operator-framework/olm@sha256:de396b540b82219812061d0d753440d5655250c621c753ed1dc67d6154741607
	docker pull quay.io/operator-framework/configmap-operator-registry:latest
	docker pull bitnami/kubectl:latest
	docker tag quay.io/operator-framework/olm@sha256:de396b540b82219812061d0d753440d5655250c621c753ed1dc67d6154741607 ${TARGET_IMAGE_REPO}/olm:0.17.0
	docker tag quay.io/operator-framework/configmap-operator-registry:latest ${TARGET_IMAGE_REPO}/configmap-operator-registry:0.17.0
	docker tag bitnami/kubectl:latest ${TARGET_IMAGE_REPO}/kubectl:0.17.0
	docker push ${TARGET_IMAGE_REPO}/olm:0.17.0
	docker push ${TARGET_IMAGE_REPO}/configmap-operator-registry:0.17.0
	docker push ${TARGET_IMAGE_REPO}/kubectl:0.17.0
