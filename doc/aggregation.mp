input mp-tool;
verbatimtex \input dplain etex

beginfig(1);
path p, q ; p := unitsquare xscaled 90 yscaled 40;
q := p shifted (50,70); fill q withcolor white; draw q;
label(btex \vbox{\hbox{transport}} etex, center q);
q := p shifted (0,0); fill q withcolor white; draw q;
label(btex \vbox{\hbox{vehicle}} etex, center q);
q := p shifted (110,0); fill q withcolor white; draw q;
label(btex \vbox{\hbox{destination}} etex, center q);
draw (45,40)--(95,70);
draw (155,40)--(95,70);
endfig;
end;
