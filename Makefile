DEFAULT_GOAL := help
SHELL := /usr/bin/env bash

help:
	@echo "$$(tput bold)Commands:$$(tput sgr0)";echo;
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort | awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s%s\n", $$1, $$2}'

format:
	@find ./app -name "*.hs" -exec ormolu -i {} +

