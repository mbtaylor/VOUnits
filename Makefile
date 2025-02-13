# ivoatex Makefile.  The ivoatex/README for the targets available.

# short name of your document (edit $DOCNAME.tex; would be like RegTAP)
DOCNAME = VOUnits

# count up; you probably do not want to bother with versions <1.0
DOCVERSION = 1.1

# Publication date, ISO format; update manually for "releases"
DOCDATE = 2022-02-11

# What is it you're writing: NOTE, WD, PR, REC, PEN, or EN
DOCTYPE = WD

# An e-mail address of the person doing the submission to the document
# repository (can be empty until a make upload is being made)
AUTHOR_EMAIL=norman.gray@glasgow.ac.uk

# Source files for the TeX document (but the main file must always
# be called $(DOCNAME).tex
SOURCES = $(DOCNAME).tex role_diagram.pdf gitmeta.tex known-units.tex

# List of image files to be included in submitted package (anything that
# can be rendered directly by common web browsers)
FIGURES = role_diagram.svg

# List of PDF figures (figures that must be converted to pixel images to
# work in web browsers).
VECTORFIGURES = 

# Additional files to distribute (e.g., CSS, schema files, examples...)
AUX_FILES =

# This has to be a python3 -- override on the command-line if necessary.
PYTHON=python

-include ivoatex/Makefile

ivoatex/Makefile:
	@echo "*** ivoatex submodule not found.  Initialising submodules."
	@echo
	git submodule update --init

VOUnits.pdf: known-units.tex

known-units.tex: unity-grammars/README unity-grammars/known-units.csv known-units-to-tex.py
	rm -f $@
	{ echo '% DO NOT EDIT'; \
	  echo '% Generated from unity-grammars.zip/known-units.csv'; \
	  echo; echo; \
	  sed 's/^/% /' unity-grammars/README; \
	  echo; echo; \
	  $(PYTHON) known-units-to-tex.py < unity-grammars/known-units.csv; \
	} >$@.tmp && mv $@.tmp $@

