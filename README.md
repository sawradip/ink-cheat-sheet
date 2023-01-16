# ink Cheat Sheet


` // ` - Single Line  Comment - The compiler ignores the line, if the  line  is followed by this.

`/* ... */` - Multi Line Comment - The compiler ignores everything in between. 

` * ` - Choice - Lists choices, a choice is removed once it is selected in previous iterations.

` + ` - Sticky Choice - Lists choices, choices are  not  removed  on whether they were selected previously.

` === ... === ` -  Knot Defnition - A knot is  defined with this.

` -> ` - Knot Divert - With this, the story flow is diverted from one knot to another knot.

` = ` - Stitch - Sub-story(Sub-knot) inside the knot.

` <> ` - Glue - Undo's the default line break.

` - ` - Gather - Works as joining points in between choices, binds thestory   flow back together.

` { ... } ` - Conditional Choice - A knot_name or stitch_name in betweeen this, translates to the read count ( number of times the  player has seen this option ).

` { ...|...|... } ` - Default Sequence - As the players sees the choice sequence N-th time, the N-th option appears. When N is greater than number of options, the final  option appears repeatedly.

` { & ...|...|... } ` - Cycles Sequence - Like a default sequence. When N is greater than number of options, the options cycle repeatedly.

` { ! ...|...|... } ` -  Once-only Sequence - Like a default sequence. When N is greater than number of options, nothing(blank) appraes. 

` { ! ...|...|... } ` -  Random Sequence - Randomly selects an option.

` { ... : ... } ` - Conditional Text  - If the condition at left satisfies, the the text at right is displayed. 

` { ... : ... | ... } ` - Conditional Text & Alternative - If the condition at left satisfies the the middle text, otherwise the right text. 

` [ ... ] ` - Choice Hidden Text - The in-between text of the choice will not be printed into response.

` ... [ ... ] ... ` - Mixing choice & Output - What's before is printed in both choice and output; what's inside only in choice; and what's after, only in output.

` - ( ... ) ` - Labelling - This will label a Choice List or a individual choice, which can later be used as a  condition, that if the player has faced that before.
`  `
