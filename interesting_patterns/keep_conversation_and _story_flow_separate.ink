// Created by Sawradip
// Here we see how to keep dialogues and story flow separate

->kitchen

=== kitchen
 - (top)
 <- tunnel_in_thread(-> conversation_opts, -> loop)
    * [The cooker]
        Looking for the Cooker
    + [The fridge] 
        Finding foods in Fridge 
    * [The catflap]
        Google about Catflap 
-  (loop) -> top

=== conversation_opts
     * [Ask about soup] -> conversation_soup
     * [Ask about  cooking] -> conversation_cooking
     * [Ask about souffle] -> conversation_souffle
 
 - ->->
 
=== conversation_soup
    ROB : "So tell me about this soup..."
    ->->
    
=== conversation_cooking
    ROB: "Are you ever going to cook anything?" 
    ->->
   
=== conversation_souffle
    ROB: "Interested in soufflé at all?" 
    ->->
    
=== tunnel_in_thread ( -> to_run_through_tunnel, -> to_return_to_origin )
    ~ temp entryTurnNum = TURNS()
     -> to_run_through_tunnel ->
     
     { entryTurnNum != TURNS(): -> to_return_to_origin | -> DONE }
     
