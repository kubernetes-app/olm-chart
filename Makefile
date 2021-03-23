
##@ General

help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Build

.PHONY: build-chart
build-chart: ## Build helm chart package
	helm package olm-chart

.PHONY: lint-chart
lint-chart: ## Verify chart lint error
	helm lint olm-chart-0.0.1.tgz

##@ Development

.PHONY: install-chart
install-chart: ## Install chart for dev test
	helm install olm-chart olm-chart-0.0.1.tgz -n kube-system 
