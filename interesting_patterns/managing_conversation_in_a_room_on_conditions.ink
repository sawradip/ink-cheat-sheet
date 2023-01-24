LIST Characters = Alfred, Batman, Robin
LIST Props = champagne_glass, newspaper

VAR BallroomContents = (Alfred, Batman, newspaper)
VAR HallwayContents = (Robin, champagne_glass)
VAR BathroomContents = ()

 { describe_room(HallwayContents) }

=== function describe_room(roomState)
 { roomState ? Alfred: 
  <> Alfred is here, standing quietly in a corner. 
 } 
 { roomState ? Batman: 
  <> Batman's presence dominates all. 
 } 
 { roomState ? Robin: 
  <> Robin is all but forgotten. 
 }
 { roomState ? champagne_glass: 
  <> A champagne glass lies discarded. 
 } 
 { roomState ? newspaper: 
  On one table, a headline blares out WHO IS THE BATMAN? AND *WHO* IS HIS BARELY-REMEMBERED ASSISTANT? 
 }

// Option based on condition 
 * { currentRoomState ? (Batman, Alfred) } 
     [Talk to Alfred and Batman]
     'Say, do you two know each other?'
