SHELL = /bin/bash
FPRE := main
SRC := $(FPRE).tex

CHAPTERDIR := sec
REFERENCEDIR := ref
FIGDIR := fig

SUBSRC := $(wildcard $(CHAPTERDIR)/*.tex) $(wildcard $(REFERENCEDIR)/*.bib) $(wildcard *.sty) $(wildcard *.bst)

$(warning CC = $(SUBSRC))
DVI := $(FPRE).dvi
TARGET := $(FPRE).pdf
STYS := $(wildcard *.sty) $(wildcard *.cls)

FIGS_PDF := $(wildcard $(FIGDIR)/*.pdf)
FIGS := $(FIGS_PDF) 


LATEX := platex
BIBTEX := pbibtex
LATEX_FLAGS := -interaction=batchmode -synctex=1

.SUFFIXES: .tex .pdf .jpg .png .xbb


$(TARGET) : $(DVI)
	dvipdfmx $<

$(DVI) : $(SRC) $(SUBSRC) $(STYS) $(FIGS)
	$(LATEX) $(LATEX_FLAGS) $(SRC)
	$(BIBTEX) $(FPRE)
	$(LATEX) $(LATEX_FLAGS) $(SRC)
	$(LATEX) $(LATEX_FLAGS) $(SRC)

.pdf.xbb:
	extractbb $<

.PHONY : clean
clean :
	-rm -f $(FPRE).log
	-rm -f $(FPRE).aux
	-rm -f $(FPRE).bbl
	-rm -f $(FPRE).blg
	-rm -f $(FPRE).toc
	-rm -f $(FPRE).fdb_latexmk
	-rm -f $(FPRE).fls
	-rm -f $(TARGET)
	-rm -f $(DVI)
	-rm -f $(CHAPTERDIR)/*.aux
	