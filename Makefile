.PHONY: setup docs format test lint linuxmain autocorrect clean test build run

APP="Trollbox"

# Apple
ifeq ($(shell uname),Darwin)
	PLATFORM=apple
	XCPRETTY_STATUS=$(shell xcpretty -v &>/dev/null; echo $$?)
	ifeq ($(XCPRETTY_STATUS),0)
		XCPRETTY=xcpretty
	else
		XCPRETTY=cat
	endif
endif

install_deps:
	swift package resolve
ifneq ($(XCPRETTY_STATUS),0)
	@echo "xcpretty not found: Run \`gem install xcpretty\` for nicer xcodebuild output.\n"
endif

clean:
	rm -rf .build Package.resolved

test: clean install_deps
	set -o pipefail && swift test | $(XCPRETTY)

build: clean install_deps
	set -o pipefail && swift build | $(XCPRETTY)

lint:
	swiftlint

run:
	./.build/debug/trollbox-cli

autocorrect:
	swiftlint autocorrect

linuxmain:
	swift test --generate-linuxmain

format:
	swiftformat .
