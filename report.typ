// #import "@preview/k-mapper:1.4.0": *
// #import "@preview/karnaugh-express:0.1.1": *
#import "utils.typ": *

#set enum(numbering: "a.")
#show raw.where(lang: "vhdl"): set raw(syntaxes: "resources/VHDL.sublime-syntax")

#let headrow(a, b, c, a_s: 10pt, b_s: 10pt, c_s: 10pt) = {
  v(-0.65em)
  grid(columns: (1fr, auto, 1fr), align: (left, center, right), text(size: a_s)[#a], text(size: b_s)[#b], text(size: c_s)[#c])
}

#let pgcount = context [Page #counter(page).get().first()/#counter(page).final().first()]

#set page(
  paper: "us-letter",
  margin: (top: 1.8in, left: 0.5in, right: 0.5in),
  header: [
    #headrow([University of Florida], [*EEL 3701C: Digital Logic & Computer Systems*], [Gutowski, Dillon], b_s: 12pt)
    #headrow([Department of Electrical & Computer Engineering], [Revision #text(fill: rgb(115, 70, 160))[*0*]], [Class \#: 10704], a_s: 8pt, b_s: 11pt)
    #headrow([#pgcount], [Lab 6 Report: *Elementary CPU Design*], [Belilty, Jacobo], b_s: 14pt)
    #v(-0.7em)
    #h(1fr) #text(size: 10pt)[November 11, 2026]
  ],
  header-ascent: 0.7em
)

#set text(
  font: "Times New Roman",
  size: 12pt,
)

#show heading.where(level: 1): it => [
  #align(center)[
    #it.body
  ]
  #v(0.5em)
]

#show heading.where(level: 2): it => [
  #line(length: 100%, stroke: 1.3pt)
  #v(-0.24em)
  #strong(upper(text(size: 16pt, [#it.body])))
  #v(-0.75em)
  #line(length: 100%, stroke: 1.3pt)
]

== Requirements Not Met
N/A

== Problems Encountered

== Future Work/Applications
#pagebreak()

== Part 1: Pre-Lab Questions or Exercises
+ Why did we require the new instruction register in this design?
+ In this section of the lab, you are setting the `INPUT` bus by hand. If you wanted to read or fetch this value from memory, what could you add to do this automatically for you every `CLK` cycle?
+ How would you add more instructions (i.e., 8 instead of 4) to the controller?
#pagebreak()

== Part 1: Pre-Lab Requirements
=== Part 1: ASM Diagram
#fletcher.diagram(
  ..state((0.5,1), `S0`, [`IR.LD` \ `MSA0MSB1`], <st:s0>, [0]),
  ..state((1.5,1), `S1`, [``], <st:s1>, [1]),
  branch((1.5,2), [` IR1 ` \ ` IR0 `], <br:s0>),
  output((0,3), `MSA0,MSB0`, <out:s0>),
  output((1,3), [`MSA0,MSA1,MSB1` \ `MSC0,MSC1,MSC2`], <out:s1>),
  output((2,3), [`MSA0,MSA1,MSB1` \ `MSC0,MSC2`], <out:s2>),
  output((3,3), `MSB1`, <out:s3>),
  arrow(<st:s0>,<st:s1>),
  arrow(<st:s1>,<br:s0>),
  arrow(<br:s0>,<out:s0>, label: "00", corner: left),
  arrow(<br:s0>,<out:s1>, label: "01", corner: left),
  arrow(<br:s0>,<out:s2>, label: "10", corner: right),
  arrow(<br:s0>,<out:s3>, label: "11", corner: right),
  arrow(<out:s3>,(3,3.5),(-0.5,3.5),(-0.5,1),<st:s0>),
  arrow(<out:s0>,(0,3.5)),
  arrow(<out:s1>,(1,3.5)),
  arrow(<out:s2>,(2,3.5)),
)
=== Part 2: Truth Table
#sch_nstt(
  ("Q0","IR1","IR0"),("Q0+", "MSA1","MSA0","MSB1","MSB0","MSC2","MSC1","MSC0","IR.LD"),
  0,"-","-", 1,  0,1,1,0,0,0,0,   1,
  1,0,0,     0,  0,1,0,1,0,0,0,   0,
  1,0,1,     0,  1,1,1,0,1,1,1,   0,
  1,1,0,     0,  1,1,1,0,0,1,1,   0,
  1,1,1,     0,  0,0,1,0,0,0,0,   0,
)

=== Part 3: VHDL Combinational Logic
// #text(size: 9pt)[#raw(read("quartus/traf_comb.vhdl"), lang: "vhdl")]

=== Part 4: Circuit Design

=== Part 5: Simulation

#pagebreak()
== Part 2: Pre-lab Questions or Exercises
+ Why do we need the extra states in the LDAA and JMP instruction paths?
+ What do you need to do to the address lines to get your program to start at address `0xB130` (instead of `0x37B0`)?

#pagebreak()
== Part 2: Pre-Lab Requirements
TAB: PC_INC, MSA0, MSB0\
ABA: PC_INC, MSA1, MSA0, MSB1, MSC2, MSC0\
LDAA0: PC_INC\
LDAA1: PC_INC, MSB1\
JMP Addr0: PC_INC\
JMP Addr1: PC_INC, MSA0, MSB1, PC_LD\
SAR: PC_INC, MSA1, MSA0, MSB1, MSC2, MSC1, MSC0\
SAL: PC_INC, MSA1, MSA0, MSB1, MSC2, MSC1\

=== Part 2: Truth Table
#sch_nstt(
  ("Q1","Q0","IR2","IR1","IR0"),("Q1+","Q0+","MSA1","MSA0","MSB1","MSB0","MSC2","MSC1","MSC0","PC_INC","PC_LD","IR.LD"),
  0,0,"-","-","-",   0,1,   0,0,0,0,0,0,0,   0,0,1,
  0,1,0,0,0,         0,0,   0,1,0,1,0,0,0,   1,0,0,
  0,1,0,0,1,         0,0,   1,1,1,0,1,0,1,   1,0,0,
  0,1,0,1,0,         1,0,   0,0,0,0,0,0,0,   1,0,0,
  0,1,0,1,1,         1,1,   0,0,0,0,0,0,0,   1,0,0,
  0,1,1,0,0,         0,0,   1,1,1,0,1,1,1,   1,0,0,
  0,1,1,0,1,         0,0,   1,1,1,0,1,1,0,   1,0,0,
  0,1,1,1,"-",       "X","X","X","X","X","X","X","X","X","X","X","X",
  1,0,"-","-","-",   0,0,   0,0,1,0,0,0,0,   1,0,0,
  1,1,"-","-","-",   0,0,   0,1,1,0,0,0,0,   0,1,0,
)

=== Part 4: Assembly
#table(columns: 11,
[*Addr*],[],[*Mach Code*],[*A*],[*B*],[*A*],[*B*],[*A*],[*B*],[*A*],[*B*],
[*0x37B0*],[LDAA \#7],[0x2,0x7],[7],[X],[],[],[],[],[],[],
[*0x37B2*],[TAB],[0x0],[7],[7],[5],[5],[2],[2],[6],[6],  
[*0x37B3*],[LDAA \#3],[0x2,0x3],[3],[7],[3],[5],[3],[2],[3],[6],  
[*0x37B5*],[ABA],[0x1],[10],[7],[8],[5],[5],[2],[9],[6],  
[*0x37B6*],[SAL],[0x5],[4],[7],[0],[5],[10],[2],[2],[6],  
[*0x37B7*],[ABA],[0x1],[11],[7],[5],[5],[12],[2],[8],[6],  
[*0x37B8*],[SAR],[0x4],[5],[7],[2],[5],[6],[2],[4],[6],  
[*0x37B9*],[JMP 2],[0x3,0x2],[5],[7],[2],[5],[6],[2],[4],[6],  
[*0x37BB*],[LDAA \#0xA],[0x2,0xA],[],[],[],[],[],[],[],[],  
[*0x37BD*],[ABA],[0x1],[],[],[],[],[],[],[],[],  
)
