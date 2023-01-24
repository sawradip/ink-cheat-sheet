// A Game of Pontoon
// Taken from Ink Official User Guide:John Ingold

// This example uses a lot of the tricks listed in this chapter and employs a lot of advanced features. A deck of cards is simulated using a list, with variables to hold what’s in each player’s hand. There’s an AI routine for working out what the NPC (Carstairs, an English gentleman and card shark) will do each turn.

-> play_game -> END 

/* ---------------------------------------------

  Functions and Definitions

--------------------------------------------- */

VAR myCards = ()   // my hand 
VAR hisCards = ()   // his hand 
VAR faceUpCards = ()  // the face up cards (from both hands)

VAR money = 400 
VAR CstrsBank = 1000

// The deck is stored as a list, but note the values we assign:
// Spades take the values 1 through 13
// Diamonds 101 through 113
// Hearts 201 through 213
// Clubs 301 through 313
// This allows us to convert a list item into its face value and suit

 LIST PackOfCards =
  A_Spades = 1, 2_Spades, 3_Spades, 4_Spades, 
  5_Spades, 6_Spades, 7_Spades, 8_Spades,
  9_Spades, 10_Spades, J_Spades, Q_Spades, K_Spades,

  A_Diamonds = 101 , 2_Diamonds, 3_Diamonds, 4_Diamonds, 
  5_Diamonds, 6_Diamonds, 7_Diamonds, 8_Diamonds,
  9_Diamonds, 10_Diamonds, J_Diamonds, Q_Diamonds, K_Diamonds,
  
  A_Hearts = 201, 2_Hearts, 3_Hearts, 4_Hearts, 
  5_Hearts, 6_Hearts, 7_Hearts, 8_Hearts,
  9_Hearts, 10_Hearts, J_Hearts, Q_Hearts, K_Hearts, 
   
  A_Clubs = 301, 2_Clubs, 3_Clubs, 4_Clubs, 
  5_Clubs, 6_Clubs, 7_Clubs, 8_Clubs,
  9_Clubs, 10_Clubs, J_Clubs, Q_Clubs, K_Clubs

LIST Suits = Spades = 0, Diamonds, Hearts, Clubs

LIST Values = Ace = 1, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King

=== function suit(x) 
 // Suit is derived from the integer part of the card value / 100
 ~ return Suits(INT(FLOOR(LIST_VALUE(x) / 100)))
    
=== function number(x) 
 // Face value is the tens and units part of the card value 
 ~ return Values(LIST_VALUE(x) mod 100)

=== function value(x) 
 // in Pontoon, all face cards (King, etc) are worth 10.
 ~ return MIN(LIST_VALUE(x) mod 100, 10)

=== function shuffle()
 ~ PackOfCards = LIST_ALL(PackOfCards)
    
=== function addCard(ref toHand, faceUp)
 ~ temp x = pullCardOfValue(LIST_ALL(Values)) // choose a card
 ~ temp retVal = addSpecificCard( toHand, x, faceUp) // deal it
 ~ return retVal 

=== function pullCardOfValue(valuesAllowed) 
 ~ temp card = pop_random(PackOfCards) 
 { card: 
  { valuesAllowed !? number(card):
   ~ return pullCardOfValue(valuesAllowed)
  }
  ~ return card 
 }
 [ Error: couldn't find a card of value {valuesAllowed}! ]
 ~ shuffle()
 ~ return pullCardOfValue(valuesAllowed) // try again

=== function addSpecificCard(ref toHand, x, faceUp) 
 ~ toHand += x 
 {faceUp:
  ~ faceUpCards += x
 }
 ~ return x


/* ---------------------------------------------
 Querying Hands

--------------------------------------------- */
    
=== function handContains(x, card) 
 ~ temp y = pop(x) 
 { y: 
  { number(y) == card: 
   ~ return true 
  - else:
   ~ return handContains(x, card)
  }
 }    
 ~ return false

=== function isPontoon(x) 
 ~ return handContains(x, Ace) && (handContains(x, King) || handContains(x, Queen) || handContains(x, Jack)) && LIST_COUNT(x) == 2
    
=== function minTotalOfHand(x)
 ~ temp y = pop(x) 
 {y:
  ~ return minTotalOfHand(x) + value(y)
 }
 ~ return 0

=== function maxTotalOfHand(x)
 ~ temp minTot = minTotalOfHand(x)
 {handContains(x, Ace) && minTot <= 11:
  ~ return minTot + 10 
 - else: 
  ~ return minTot
 }
   
/* ---------------------------------------------

 Printing Cards and Hands

--------------------------------------------- */

=== function nameCard(x) 
 {_nameCard(x, true) }

== function listMyCards() 
 ~ _listOfCards(myCards)

=== function printHand(x)
 ~ _printHand(x)

=== function _nameCard(x, allowVariants)
 ~ temp num = number(x)
 {allowVariants:
  { RANDOM(1, 3) == 1:
   a{(Eight, Ace) ? num :<>n} {num} in {suit(x)}
  - else:
   the {num} of {suit(x)}
  }
 - else: 
  {num} of {suit(x)}
 }

== function _listOfCards(hand) 
 ~ temp y = pop(hand) 
 { y: 
  <>{_nameCard(y, false)}
  {hand:
   <><br>
   ~ _listOfCards(hand)
  }
 }
    

=== function _printHand(x) 
 ~ temp y = pop(x) 
 {y:
  {nameCard(y)}
  {LIST_COUNT(x):
   - 0:    
    ~ return 
   - 1:
    <> and {_printHand(x)}
   - else:
    <>, {_printHand(x)}
  }
 }
    
=== function printHandDescriptively(x, mine) 
 {printHand(faceUpCards ^ x)} face up
 ~ temp faceDownCards = x - faceUpCards
 {faceDownCards:
  <>, and <>
  { mine:
   {printHand(faceDownCards)}
  - else:
   {print_number(LIST_COUNT(faceDownCards))} <> more
  }
  <> {~{mine:hidden|}|face down|blind}
 }
    


/* ---------------------------------------------

 Other Printing Functions

--------------------------------------------- */
    
=== function finalTotalOfHand(x) 
 { isPontoon(x): 
  pontoon
 - else:
  {print_number(maxTotalOfHand(x))} 
 }

=== function sayTotalOfHand(x) 
 ~ temp minTot = minTotalOfHand(x)
 { shuffle:
 -   for a total of 
 -   total of 
 -   giving 
 -   making 
  }
 <> {print_number(minTot)} 
 { handContains(x, Ace)  && minTot <= 11:
  ~ temp max = maxTotalOfHand(x)
  <>, or {print_number(maxTotalOfHand(x))}
 }

=== function describeMyCards()
 { shuffle:
 -   V:      ... {printHandDescriptively(myCards, true)}. #thought
 - { shuffle:
  -   CARSTAIRS:  {~First {~card|out|up} {!for you} is|} 
   
  -   CARSTAIRS:  The lady {~has|gets} 
  }
  <> {nameCard(faceUpCards ^ myCards)}
  V:  ... and face down, {nameCard(myCards - faceUpCards)} ... #thought
 }
 V:      ... {sayTotalOfHand(myCards)} ... #thought

== function describePot(bet)
 { shuffle:
 -   CARSTAIRS:  The {~bet|stake|pot} is {print_number(bet)} pounds.
 -   CARSTAIRS:  {~That makes|{~There|That}'s} {print_number(bet)} pounds {~in the pot|on the table}. 
 }

/*------------------------------------------

 GAMEPLAY CONTENT LOOP

------------------------------------------*/

=== play_game
- (top_of_game)
 ~ temp startingMoney = money   
 ~ myCards = () 
 ~ hisCards = () 
 ~ faceUpCards = ()
 ~ temp bet = 20
 { once:
 -   VO:     I throw two ten-pound notes onto the table. 
 -   V:  Twenty pounds. 
  CARSTAIRS:     The pot stands at twenty pounds.
 -   VO:     I toss in my ante. 
 }
 {    
 - LIST_COUNT(PackOfCards) < 10:
  ~ shuffle()
  ~ temp plural = RANDOM(1,2)
  VO:         Carstairs {~collects together|gathers up} {plural:{~all|} the cards|the deck}, and {~riffles|shuffles} {plural:them|it} {~thoroughly|expertly|quickly|carelessly||} before dealing the first two cards.       
 - else:
  VO:     Carstairs {~passes me|spins me|tosses over|deals out} {~{~an opening|a new} card|my first card} {~face up|} {~from the {~top of the|} deck|}.
 }
    
 ~ temp myNewCard = addCard(myCards, true) 
    
 { shuffle:
 -   CARSTAIRS:  {~First {~card|out} is|} {nameCard(myNewCard)}.             
 -   CARSTAIRS:  The lady {~has|gets} {nameCard(myNewCard)}.
 }    
 ~ temp hisNewCard =  addCard(hisCards, true) 
 { stopping:
 -   CARSTAIRS:  And the dealer... gets {nameCard(hisNewCard)}.
 - { shuffle:
  -   CARSTAIRS: And it's {nameCard(hisNewCard)} for me. 
  -   CARSTAIRS:  {~Dealer {~gets...|has}|And I have} {nameCard(hisNewCard)}.
  }
 }   
 
 {once:
 -   CARSTAIRS:      You can fold, or make a bet to stay in.
 }
 ~ temp incr = 0

- (bet_opts)
 +   [ Fold ]        
  V:  {~Pass|Fold}. 
  -> i_lost
        
 +   [ Bet 50  ]
  ~ incr =  50

 +   {money - bet < 200} [   Bet 100   ] 
  ~ incr = 100

 +   {money - bet >= 200} [ Bet higher... ] 
  + + {CHOICE_COUNT() < 2 }  {money - bet <= 300} [  Bet 100   ]
   ~ incr = 100
  + + {CHOICE_COUNT() < 2 } {money - bet <= 250}  [  Bet 150   ]
   ~ incr =  150
  + + {CHOICE_COUNT() < 2 } [   Bet 200   ]
   ~ incr =  200
  + + {CHOICE_COUNT() < 2 } {money - bet >= 300}  [  Bet 300   ]
   ~ incr = 300
  + + [ Bet lower... ] 
   -> bet_opts                            
-   { shuffle:
 - V: I put in {print_number(incr)} pounds {incr > 50:more}. 
 - V: I raise {print_number(incr)} pounds.
 }
 { incr >= 200:         
  { shuffle once:
  -   VO:     Carstairs raises an eyebrow. 
  -   CARSTAIRS:  Crikey. 
  -   CARSTAIRS:  Well, now. 
  -   CARSTAIRS:  Someone's feeling lucky. 
  }    
 }
 -      ~ bet += incr        
 { describePot(bet) }        
 VO:  He {~hands|deals} {~me|out} a second card, face down. 
        
 {once:
 -   CARSTAIRS:  Take a look, don't let me see.
  }        
 ~ myNewCard = addCard(myCards, false) 
                
 V:   {nameCard(myNewCard)}: {sayTotalOfHand(myCards)} #thought

 ~ addCard(hisCards , false) 
 { shuffle:
 -   VO:     He deals one more for himself, face down. 
 -   CARSTAIRS:  One more blind for me, too. 
 } 

- (myplay) 
 { minTotalOfHand(myCards) > 21:
  { shuffle:
  -   V:  I'm bust. 
  -   V:  Damn.
  -   VO:     I {~toss|throw} my cards down. 
  }
  { i_lost mod 3 == 2:
   { shuffle: 
   -   V:  You're rigging this. 
   -   V:  How are you doing this? 
   -   V:  This can't be fair. 
   }
   { shuffle:
   -   CARSTAIRS:  I assure you I'm not! 
   -   CARSTAIRS:  I play the odds, Ma'am, not the player. 
   -   CARSTAIRS:  I promise you, I'm as square as they come!
   }              
  }
  -> i_lost
 }
 { LIST_COUNT(myCards) == 5: 
  CARSTAIRS:  A five card trick! 
  CARSTAIRS:  That beats the same value on fewer cards.
 }
 
- (check_for_burn)  
 { LIST_COUNT(myCards) == 2 && minTotalOfHand(myCards) == 13 && money - bet >= 20: 
  +   {came_from(-> burny)} 
   [ Burn again ] 
    -> burny 

  +   (burny) {not came_from(-> burny)} 
   [ Burn for twenty more ] 
    ~ bet += 20 
    V:  Burn. 
    >>> AUDIO CardCollectAndDealTwoCards
    VO:     Carstairs collects the cards and deals two more.
    ~ faceUpCards -= myCards
    ~ myCards = () 
    ~ addCard(myCards, true)
    ~ addCard(myCards, false)
    V:      {printHandDescriptively(myCards, true)} #thought
    V:    {sayTotalOfHand(myCards)} #thought
    -> check_for_burn 
           
  *   [ Keep them ] 
   -> bid_loop
 - else: 
  -> bid_loop   
 }
 -> DONE  
    
- (bid_loop)  
 { not seen_very_recently(->  describePot): 
  { describePot(bet) }
 }
 ~ temp gotTwentyOne = (maxTotalOfHand(myCards) == 21)
 {gotTwentyOne:
  {isPontoon(myCards):
   V:  ... It's a pontoon..!  #thought
  - else: 
   V:  ... Twenty-one!   #thought
  }        
 }
    
 +   [ Stick {not gotTwentyOne: on {finalTotalOfHand(myCards)}} ]
  CARSTAIRS:  Final bet is {print_number(bet)} pounds. 
  -> hisplay_begins
        
 *   (gloat) {gotTwentyOne} [ Gloat ] 
  >>> AUDIO: V Chuckle 1
  V:  You're in trouble now, Mr Carstairs...
  CARSTAIRS:  Is that so?
  -> hisplay_begins
        
 *   {gotTwentyOne} [ Give nothing away ] 
  >>> AUDIO: V Clear Throat 1
  V:          Your turn, then.
  CARSTAIRS:  I take it you're sticking, then?
  -> hisplay_begins
        
 +   {not gotTwentyOne} [ Twist ] 
  { shuffle:
  -   V:  Twist. 
  -   V:  Another card. 
  -   V:  Give me another.
  -   V:  One more, face up.
  }
  ~ temp newUpCard = addCard(myCards, true)
        
  CARSTAIRS:  {nameCard(newUpCard)}.
        
  V:  ... {sayTotalOfHand(myCards)}. #thought
  -> myplay
        
 +   { (money - bet) >= 50 }  {not gotTwentyOne}
  [ Buy for fifty ]

  ~ bet += 50 
  ~ temp newDownCard = addCard(myCards, false)
  {shuffle:
  -   V:  Buy. 
  -   V:  I'll buy one. 
  -   V:  One more, face down.
  }
  {shuffle:
  -   CARSTAIRS:  The stake is now {print_number(bet)}. 
  -   CARSTAIRS:   {print_number(bet)} in the pot. 
  }
   { shuffle:
  -   VO:     Carstairs passes me another card, face-down. 
  -   CARSTAIRS:   Here's your card.
  }
       
  V:  ... {nameCard(newDownCard)}. #thought
  V:  ... {sayTotalOfHand(myCards)}. #thought
  -> myplay
        
- (hisplay_begins)  

 ~ faceUpCards += hisCards 

 { shuffle:
 -   CARSTAIRS:  Let's see what I have...
  CARSTAIRS:  {printHandDescriptively(hisCards, false)}.
 -   CARSTAIRS:  Dealer has... {printHandDescriptively(hisCards, false)}.
 }
    
 CARSTAIRS:  {sayTotalOfHand(hisCards)}.
 
- (hisplay_main)

// AI plays 

 ~ temp hes_scared = seen_more_recently_than(-> gloat, -> top_of_game)
 ~ temp hisTotal = minTotalOfHand(hisCards) 
    
 { hisTotal > 21:  
  { shuffle:
  -   CARSTAIRS:  I'm bust!
  -   CARSTAIRS:  Too high! 
  -   CARSTAIRS:  No luck there!
  }
  -> i_won 
 }

 ~ temp hisMaxTotal = maxTotalOfHand(hisCards)     
 ~ temp yourVisibleTotal = maxTotalOfHand(myCards ^ faceUpCards)
 ~ temp yourBestTotal = 21  

// edge case. You have ? - 3 - 5 => your best is 19.
 { LIST_COUNT(myCards - faceUpCards) == 1 && yourVisibleTotal < 10: 
  ~ yourBestTotal = 11 + yourVisibleTotal
 }
    
//  AI uses fallback choices to pick a strategy

 +   {hisMaxTotal > yourBestTotal || (hisMaxTotal == yourBestTotal && LIST_COUNT(myCards) < 5)} ->
  - - (he_sticks)
   CARSTAIRS:  Dealer sticks on {finalTotalOfHand(hisCards)}.
   -> hisplayover
 +   { hisMaxTotal >= 18 && !handContains(hisCards, Ace)}   -> he_sticks
    
 +   { hisTotal == 10 || hisTotal == 11 } -> he_twists
    
 +   { hisMaxTotal <= 15 || (hisMaxTotal <= 17 && handContains(hisCards, Ace)) || (hisMaxTotal <= 18 && hes_scared) } -> 
  - - (he_twists)
   { shuffle:
   -   CARSTAIRS: I'll take another. 
   -    CARSTAIRS: Dealer twists. 
   -    CARSTAIRS: One more...
   }
            
   ~ temp newHisCard = addCard(hisCards, true)
   CARSTAIRS:  {nameCard(newHisCard)}, {sayTotalOfHand(hisCards)}.
   -> hisplay_main
        
 +   {RANDOM(1, 3) == 1} -> 
  -> he_sticks 
       
 +   -> he_twists
    
- (hisplayover) 
 ~ temp facedownCards = myCards - faceUpCards   

- (dealoutcards)
 { pop(facedownCards):
  -> dealoutcards
 } 
 ~ temp scoreDiff = maxTotalOfHand(myCards) - maxTotalOfHand(hisCards)

 { cycle:
 -   VO:     I lay my cards down. 
 -   VO:     I {~turn|flip} my cards {~face-up|over}. 
 -  
 } 
 
 { cycle:
 -   V:  I've got {scoreDiff < 0:only} {finalTotalOfHand(myCards)}{scoreDiff==0:<> too}.
 -  V:      {finalTotalOfHand(myCards)}.
 }
    
 { 
 - scoreDiff > 0 && maxTotalOfHand(myCards) < 21:        
  V:  I won{~.|!|?} 
  -> i_won 

 - scoreDiff < 0: 
  CARSTAIRS:  Dealer wins! 
  -> i_lost 

 - scoreDiff == 0: 
  {LIST_COUNT(myCards) >= 5 && LIST_COUNT(hisCards) < 5: 
   CARSTAIRS:  Five card trick wins!
   -> i_won 
  }
  CARSTAIRS:  It's a draw. Dealer wins, I'm afraid.
  -> i_lost 
 }
  
- (i_won)
 ~ money += bet 
 ~ CstrsBank -= bet
 VO:     I collect up the money from the table. 
 { 
 - isPontoon(myCards): 
  CARSTAIRS:  And pontoon earns double. 
  ~ money += bet 
  ~ CstrsBank -= bet        
  VO:     He counts out another {print_number(bet)} pounds. 

 - maxTotalOfHand(myCards)==21 && LIST_COUNT(myCards)==2:
  { once:
  -   CARSTAIRS:  But it's not a pontoon, I'm afraid. 
   CARSTAIRS:  Need a face card for that.      
  }
 }
 { shuffle:
 -   VO:     I've now got {print_number(money)} pounds. 
 -   V:      ... I've now got {print_number(money)} pounds. 
 }      
 -> done 

- (i_lost)
 ~ money -= bet
 ~ CstrsBank += bet
 VO:     Carstairs {~takes|{~collects|scoops} {~up|}} the {~pot|stake|money {~{~off|from} the table|}} and gathers up the cards. 
 { money < 50: 
  V:  You've cleaned me out! 
  CARSTAIRS:  I'm sorry to hear that, Mrs V. 
  VO:     He tucks his winnings into his waistcoat pocket and grins like an idiot.
  -> finished
 }
 { money >= startingMoney:
  { shuffle:
  -   VO:     I've still got {print_number(money)} pounds. 
  }
 - else: 
  { shuffle:
  -   V:      ... I'm down to {print_number(money)} pounds ... #thought
  -   V:     ... {print_number(money)} pounds left ...  #thought
  }
 }
 -> done 

- (done)
 ~ temp wasPontoon = isPontoon(myCards)
 ~ myCards = ()
    
 { CstrsBank <= 50:
  CARSTAIRS:  Well, you've cleaned me out of spending money, Mrs Villensey! 
  CARSTAIRS:  I must say; a much better show than your husband achieved. 
  -> finished
 } 
  
 {
 - came_from(-> i_lost): 

  {shuffle: 
  -   CARSTAIRS:       Have you had enough? 
  -   CARSTAIRS:       Keep going?  
  -   CARSTAIRS:       Again?
  }
 - came_from(-> i_won): 

  { shuffle:
  -    CARSTAIRS:      Another round? 
  -    CARSTAIRS:      Again? 
  -    CARSTAIRS:      Another? 
  }
 - else: 
    
  { cycle:
  -   VO:     Carstairs {~has been squaring up|is fiddling with} the {~pack|deck}.
  -   VO:     Carstairs is shuffling idly. 
   ~ shuffle()
  }
  { shuffle: 
  -    CARSTAIRS:      Are we still playing?
  -    CARSTAIRS:      Another hand, Mrs Villensey?
  }
 }  
 - (replay_opts)  
+   [ Play another round ] 
 { 
 - money >= 250:
  { shuffle:
  -   V:  Deal.
  -   V:  Another!
  }
 - money >= 100:
  { shuffle:
  -   V:  I'll play another round.
  -   V:  I'm not finished yet.
  }
 -  money >= 70:
  { shuffle:
  -   V:  I can afford one more round.
  -   V:  I'd better be lucky this time! 
  }
 }
 -> top_of_game 
    
 +   [ Stop playing ] 
  V:  Perhaps later.  
            
- (finished)
 ~ myCards = ()        
 ->->

/*------------------------------------------

 STOCK FUNCTIONS

------------------------------------------*/

=== function came_from(-> x) 
 ~ return TURNS_SINCE(x) == 0

=== function seen_very_recently(-> x)
 ~ return TURNS_SINCE(x) >= 0 && TURNS_SINCE(x) <= 3
 === function seen_more_recently_than(-> link, -> marker)
 { TURNS_SINCE(link) >= 0: 
  { TURNS_SINCE(marker) == -1: 
   ~ return true 
  } 
  ~ return TURNS_SINCE(link) < TURNS_SINCE(marker) 
 }
 ~ return false 

=== function pop(ref _list) 
 ~ temp el = LIST_MIN(_list) 
 ~ _list -= el
 ~ return el 
=== function pop_random(ref _list) 
 ~ temp el = LIST_RANDOM(_list) 
 ~ _list -= el
 ~ return el 
    
=== function print_number(x) 
 {  
 - x >= 100:
  ~ temp z = x mod 100
  {print_number((x - z) / 100)} hundred 
  {z > 0: <> and {print_number(z)} }
 - x == 0:       zero
 - else:
  { x >= 20:
   { x / 10:
   - 2: twenty
   - 3: thirty
   - 4: forty
   - 5: fifty
   - 6: sixty
   - 7: seventy
   - 8: eighty
   - 9: ninety
   }
   { x mod 10 > 0: <>-<> }
  }
  { x < 10 || x > 20:
   { x mod 10:
   - 1: one
   - 2: two
   - 3: three
   - 4: four
   - 5: five
   - 6: six
   - 7: seven
   - 8: eight
   - 9: nine
   }
  - else:
   { x:
   - 10: ten
   - 11: eleven
   - 12: twelve
   - 13: thirteen
   - 14: fourteen
   - 15: fifteen
   - 16: sixteen
   - 17: seventeen
   - 18: eighteen
   - 19: nineteen
   }
  }
 }
