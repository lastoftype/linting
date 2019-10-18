PATH := ./node_modules/.bin:./bin:$(PATH)
SHELL := env PATH=$(PATH) /bin/bash
UNAME := $(shell uname)

RED=\e[31m
GREEN=\033[92m
RESET=\x1b[0m
UNDERLINE=\x1b[4m

TS_GLOB="src/**/*.ts{,x}"
SCSS_GLOB="src/**/*.scss"
PRETTIER_GLOB="src/**/*.{ts,tsx,json,scss,js}"

.PHONY: submodules git-hooks configure build\
	lint lint-ts lint-css lint-prettier lint-write\

git-hooks:
	@cp .git-hooks/* .git/hooks/

lint-ts:
	@echo -e "\n${UNDERLINE}‣ Linting with tslint...${RESET} (Linter 1 of 3)"
	@./node_modules/.bin/tslint --project tsconfig.json ${TS_GLOB}
	@echo -e "${GREEN}✓ Files successfully linted with tslint\033[0m\n"

lint-css:
	@echo -e "${UNDERLINE}‣ Linting scss with stylelint...${RESET} (Linter 2 of 3)"
	@./node_modules/.bin/stylelint ${SCSS_GLOB} --config .stylelintrc.json
	@echo -e "${GREEN}✓ Files successfully linted with stylelint\033[0m"

lint-prettier:
	@echo -e "\n${UNDERLINE}‣ Linting scss, json, ts, tsx with prettier...${RESET} (Linter 3 of 3)"
	@./node_modules/.bin/prettier check --config .prettierrc.json -l ${PRETTIER_GLOB} > .lint-prettier-errors || true
	@if [[ -s .lint-prettier-errors ]]; then \
		printf "${RED}✖ Files contain prettier linting errors${RESET}" && \
		printf "\n" && \
		cat .lint-prettier-errors && \
		rm .lint-prettier-errors && \
		printf "\n" && \
		exit 1;\
	else \
		rm .lint-prettier-errors && \
		echo -e "${GREEN}✓ Files successfully linted with prettier\033[0m\n";\
	fi

lint-prettier-write:
	@./node_modules/.bin/prettier/ --config .prettierrc.json --write ${PRETTIER_GLOB}

lint-stylelint-write:
	@./node_modules/.bin/stylelint ${SCSS_GLOB} --config .stylelintrc --fix

lint: lint-ts lint-css lint-prettier

lint-write: lint-stylelint-write lint-prettier-write
