input mp-tool;
verbatimtex \input dplain etex

beginfig(1);
path p, q ; p := unitsquare xscaled 90 yscaled 40;
q := p shifted (160,90); fill q withcolor white; draw q;
label(btex \vbox{\hbox{car}} etex, center q);
q := p shifted (0,0); fill q withcolor white; draw q;
label(btex \vbox{\hbox{vehicle}} etex, center q);
q := p shifted (120,60); fill q withcolor white; draw q;
label(btex \vbox{\hbox{truck}} etex, center q);
draw (90,40)--(120,60);
endfig;
end;
