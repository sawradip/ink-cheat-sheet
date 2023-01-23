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


## Ink List Operations Reference Table

| Operation |  Description | Example |
| ------ |  ----------- | ------- |
| `MYLIST`| Returns every 'in-the' list element separated by comma |#|
| `MYLIST(n)` | Returns n-th 'all-the' list element from `MYLIST` list |
| `MYLIST ? (A, B)` | Returns True if `MYLIST` contains `A` and `B` |
| `MYLIST !? (A, B)` | Returns True if `MYLIST` does not contains `A` and `B` |
| `MYLIST == (A, B)` | Returns True if `MYLIST` contains only `A` and `B` |
| `MYLIST != (A, B)` | Returns True if `MYLIST` does not contain only `A` and `B` |
| `MYLIST1 ^ MYLIST2` | Returns a list with intersection of 'in-the' list elemnets |
| `MYLIST1 > MYLIST2` | Returns True if the smallest value in `MYLIST1` is bigger than the largest values in `MYLIST2`|
| `MYLIST1 >= MYLIST2` | Returns True if the smallest value in `MYLIST1` is at least the smallest value in `MYLIST2`, and the largest value in `MYLIST1` is at least the largest value in `MYLIST2` |
| `LIST_ALL(MYLIST)`| Returns every 'all-the' list element separated by comma |
| `LIST_COUNT(MYLIST)` | Returns number of 'in-the' list elements from `MYLIST` list|
|  `LIST_INVERT(MYLIST)` | Return a new list  with 'in-the' list elements as non-'in-the' list elements and vice-versa|
| `LIST_MIN(MYLIST)` | Returns first 'in-the' list element from `MYLIST` list|
| `LIST_MAX(MYLIST)` | Returns last 'in-the' list element from `MYLIST` list|
| `LIST_RANDOM(MYLIST)` | Returns a rendomly  selected 'in-the' list element from `MYLIST` list|
| `LIST_RANGE(MYLIST, min, max)` | Returns a slice of 'in-the' elements of `MYLIST` from `min` to '`max` element(inclusive) | 
| `LIST_VALUE(...)` | Returns 1-based index of the list element `...` from 'all-the' list elments|


## Ink Built-in Game Query Functions Reference Table

| Function | Description | Example |
| ------ | -------- | ----------- |
| `CHOICE_COUNT()` | returns the number of options created so far in the current choice list | # |
| `TURNS()` | returns the number of game turns since the game began. Increases any time a choice is selected. | 


