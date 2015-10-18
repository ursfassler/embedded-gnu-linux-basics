
handname=handout
slidename=slides
backupname=backup
bibname=literature
pdfprexif=embedded_gnu_linux_basics_

quick: handout backup slide pdfclean
#	evince $(pdfprexif)$(handname).pdf &
#	evince $(pdfprexif)$(backupname).pdf &
#	evince $(pdfprexif)$(slidename).pdf &

handout:
	-pdflatex -draftmode -halt-on-error $(handname).tex 1> /dev/null
	bibtex $(handname) 1> /dev/null
	pdflatex -draftmode -halt-on-error $(handname).tex 1> /dev/null
	pdflatex -halt-on-error $(handname).tex 1> /dev/null
	mv $(handname).pdf $(pdfprexif)$(handname).pdf

backup:
	-pdflatex -draftmode -halt-on-error $(backupname).tex 1> /dev/null
	bibtex $(backupname) 1> /dev/null
	pdflatex -draftmode -halt-on-error $(backupname).tex 1> /dev/null
	pdflatex -halt-on-error $(backupname).tex 1> /dev/null
	mv $(backupname).pdf $(pdfprexif)$(backupname).pdf

slide:
	pdflatex -draftmode -halt-on-error $(slidename).tex 1> /dev/null
	pdflatex -halt-on-error $(slidename).tex 1> /dev/null
	mv $(slidename).pdf $(pdfprexif)$(slidename).pdf

pdfclean:
	rm -f $(bibname)-blx.bib *.log *.toc *.aux *.bbl *.blg *.lof *.lot *.out *.bak *.nav *.snm *.vrb

png: ps
	pstoimg -multi -type png -scale 2 -aaliastext -aaliastext $(handname).ps

clean: 
	rm -f *.dvi *.pdf *.ps *.png

