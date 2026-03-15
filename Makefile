JELLY     := $(HOME)/bin/jelly
SHORTCUTS := /usr/bin/shortcuts
BUILD     := build
UNSIGNED  := build/unsigned

# Derive shortcut name from FILE (e.g. utilities/flashlight-blink.jelly → flashlight-blink)
NAME = $(notdir $(basename $(FILE)))

.PHONY: build sign deploy decompile build-all help

help:
	@echo "Usage: make <target> FILE=<path/to/file.jelly>"
	@echo ""
	@echo "Targets:"
	@echo "  build       Compile a .jelly file to an unsigned .shortcut"
	@echo "  sign        Sign a compiled .shortcut for device import"
	@echo "  deploy      build + sign + open  (full pipeline)"
	@echo "  decompile   Decode a .shortcut to JSON  (FILE=path/to/file.shortcut)"
	@echo "  build-all   Compile and sign every .jelly file in the repo"
	@echo ""
	@echo "Pre-flight: 'shortcuts list' must return your library (requires iCloud login)."

## Compile a single .jelly file to build/unsigned/
build: _require-file _mkdirs
	$(JELLY) $(FILE) --export --out $(UNSIGNED)/$(NAME).shortcut
	@echo "Compiled: $(UNSIGNED)/$(NAME).shortcut"

## Sign a compiled shortcut so it can be imported on any Apple device
sign: _require-file _preflight
	$(SHORTCUTS) sign --mode anyone \
		--input  $(UNSIGNED)/$(NAME).shortcut \
		--output $(BUILD)/$(NAME).shortcut
	@echo "Signed:   $(BUILD)/$(NAME).shortcut"

## Full pipeline: compile → sign → open import dialog
deploy: build sign
	open $(BUILD)/$(NAME).shortcut
	@echo "Opened:   $(BUILD)/$(NAME).shortcut"

## Decode a binary .shortcut plist to JSON for inspection
## Usage: make decompile FILE=path/to/file.shortcut
decompile: _require-file
	@shortcut_name=$(notdir $(basename $(FILE))); \
	plutil -convert json $(FILE) -o /tmp/$$shortcut_name.json && \
	echo "Decoded:  /tmp/$$shortcut_name.json"

## Compile and sign all .jelly files in the repo
build-all: _mkdirs _preflight
	@find . -name '*.jelly' \
		-not -path './.git/*' \
		-not -path './.agent/*' | while read f; do \
		name=$$(basename "$${f%.jelly}"); \
		$(JELLY) "$$f" --export --out "$(UNSIGNED)/$$name.shortcut" && \
		$(SHORTCUTS) sign --mode anyone \
			--input  "$(UNSIGNED)/$$name.shortcut" \
			--output "$(BUILD)/$$name.shortcut" && \
		echo "Deployed: $(BUILD)/$$name.shortcut"; \
	done

# ── Internal helpers ──────────────────────────────────────────

_require-file:
	@test -n "$(FILE)" || \
		(echo "Error: FILE is required. Example: make $(MAKECMDGOALS) FILE=utilities/flashlight-blink.jelly" && exit 1)

_mkdirs:
	@mkdir -p $(BUILD) $(UNSIGNED)

_preflight:
	@$(SHORTCUTS) list > /dev/null 2>&1 || \
		(echo "Error: iCloud not accessible. Sign in to iCloud and retry." && exit 1)
