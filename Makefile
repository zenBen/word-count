print-%  : ; @echo $* = $($*)

SRCDIR := books
TMPDIR := data
PLTDIR := plots

SRCS = $(wildcard $(SRCDIR)/*.txt)

OBJS = $(patsubst $(SRCDIR)/%.txt,$(TMPDIR)/%.dat,$(SRCS))
OBJS += $(patsubst $(SRCDIR)/%.txt,$(PLTDIR)/%.png,$(SRCS))
OBJS += results.txt
DATA = $(patsubst $(SRCDIR)/%.txt,$(TMPDIR)/%.dat,$(SRCS))

all: $(OBJS)

.PRECIOUS: $(TMPDIR)/%.dat

$(TMPDIR)/%.dat: $(SRCDIR)/%.txt
	./source/wordcount.py $<  $@

$(PLTDIR)/%.png: $(TMPDIR)/%.dat
	./source/plotcount.py $<  $@

results.txt: $(DATA)
	@echo $@ $^
	@echo $(DATA)
	./source/zipf_test.py $^ > $@

#Make the Directories
directories:
	@mkdir -p $(TMPDIR)
	@mkdir -p $(PLTDIR)

#Clean only Objecst
clean:
	@$(RM) -rf $(TMPDIR)
	@$(RM) -rf $(PLTDIR)

.PHONY: clean directories
