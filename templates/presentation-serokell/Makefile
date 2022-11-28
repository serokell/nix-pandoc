TARGETS ?= presentation.pdf speaker-notes.pdf article.html

SOURCE = presentation.md

RELOAD ?= presentation.pdf

BEAMER_OPTS = --standalone \
  --pdf-engine=xelatex \
  --pdf-engine-opt=-shell-escape \
  --pdf-engine-opt=-output-directory=_output \
  --slide-level=2 \
	--indented-code-classes=console \
  --to beamer \
  --no-highlight \
  --lua-filter $(LUA_FILTERS)/minted/minted.lua


all: $(TARGETS)

autoreload:
	echo $(SOURCE) | entr -sc $(MAKE) $(RELOAD)

check: $(SOURCE)
	proselint $<

presentation.pdf: $(SOURCE)
	pandoc $(BEAMER_OPTS) -o $@ $<
	rm _output -rf

speaker-notes.pdf: $(SOURCE)
	pandoc $(BEAMER_OPTS) --metadata='classoption:notes=only' -o $@ $<
	rm _output -rf

article.html: $(SOURCE)
	pandoc --standalone --to html	-o $@ $<

clean:
	git clean -dXf

install: $(TARGETS)
	mkdir -p $(out)
	cp $^ $(out)

.PHONY: all install clean check autoreload
