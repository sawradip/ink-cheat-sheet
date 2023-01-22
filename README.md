# ink Cheat Sheet

Ink is a scripting language designed for creating interactive narrative experiences. Whether you're developing text-based games or more visually-driven titles with complex branching storylines, Ink makes it easy to build and structure your story. With a simple learning curve and powerful features, it's the perfect tool for any developer looking to create compelling, engaging narratives.

Ink is a powerful scripting language for creating interactive narratives, but with so many features, it can be difficult to remember everything, especially for those new to Ink. While the Ink repository provides a great getting-started guide, it can be hard to find a quick reference for specific symbols and their functions. That's why this cheat sheet was created - as a condensed version of the documentation to provide a quick and easy reference for the functionality of different Ink symbols.

If you're new to Ink, it is highly recommended that you start by reading the official guide provided by the Ink team. This will give you a solid foundation in the language and its capabilities. Once you feel comfortable with Ink and have a good understanding of its features, you can refer to this cheat sheet as a quick reference guide for future use.

## Ink Symbol Reference Table

| Symbol | Used For | Description | Example |
| ------ | -------- | ----------- | ------- |
|` // ` | Single Line  Comment | The compiler ignores the line, if the  line  is followed by this. | # |
| `/* ... */` | Multi Line Comment | The compiler ignores everything in between. |
|` * ` | Choice | Lists choices, a choice is removed once it is selected in previous iterations. |
|` + ` | Sticky Choice | Lists choices, choices are  not  removed  on whether they were selected previously.|
|` === ... === ` |  Knot Defnition | A knot is  defined with this.|
|` -> ` | Knot Divert | With this, the story flow is diverted from one knot to another knot.|
|` = ` | Stitch | Sub-story(Sub-knot) inside the knot.|
|` <> ` | Glue | Undo's the default line break.|
|` - ` | Gather | Works as joining points in between choices, binds thestory   flow back together. |
|` {...} ` | Conditional Choice | A knot_name or stitch_name in betweeen this, translates to the read count ( number of times the  player has seen this option ).|
|` {...\|...\|...} ` | Default Sequence | As the players sees the choice sequence N-th time, the N-th option appears. When N is greater than number of options, the final  option appears repeatedly.
|` {&...\|...\|...} ` | Cycles Sequence | Like a default sequence. When N is greater than number of options, the options cycle repeatedly.|
|` {!...\|...\|...} ` |  Once-only Sequence | Like a default sequence. When N is greater than number of options, nothing(blank) appraes. |
|` {!...\|...\|...} ` |  Random Sequence | Randomly selects an option.|
|` {...:...} ` | Conditional Text  | If the condition at left satisfies, the the text at right is displayed. |
|` {...:...\|...} ` | Conditional Text & Alternative | If the condition at left satisfies the the middle text, otherwise the right text.| 
|` [...] ` | Choice Hidden Text | The in-between text of the choice will not be printed into response.|
|` ...[...]... ` | Mixing choice & Output | What's before is printed in both choice and output; what's inside only in choice; and what's after, only in output.|
|` - (...) ` | Labelling | This will label a Choice List or a individual choice, which can later be used as a  condition, that if the player has faced that before.|

## Ink Built-in Game Query Functions Reference Table

| Function | Description | Example |
| ------ | -------- | ----------- |
| `CHOICE_COUNT()` | returns the number of options created so far in the current choice list | # |
| `TURNS()` | returns the number of game turns since the game began. | 
