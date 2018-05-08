SRCDIR := data
TMPDIR := processed_data
RESDIR := results

SRCS = $(wildcard $(SRCDIR)/*.txt)
OBJS = $(patsubst $(SRCDIR)/%.txt,$(TMPDIR)/%.dat,$(SRCS))
OBJS += $(patsubst $(SRCDIR)/%.txt,$(RESDIR)/%.png,$(SRCS))
OBJS += $(RESDIR)/results.txt
DATA = $(patsubst $(SRCDIR)/%.txt,$(TMPDIR)/%.dat,$(SRCS))

all: $(OBJS)

$(TMPDIR)/%.dat: $(SRCDIR)/%.txt
	./source/wordcount.py $<  $@

$(RESDIR)/%.png: $(TMPDIR)/%.dat
	./source/plotcount.py $<  $@

$(RESDIR)/results.txt: $(DATA)
	./source/zipf_test.py $^ > $@

clean:
	@$(RM) $(TMPDIR)/*
	@$(RM) $(RESDIR)/*

.PHONY: clean directories
