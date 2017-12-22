;
;TO RUN, ENTER THESE COMMANDS INTO CLIPS
;(clear)
;(load "NetflixYourLifeAway.clp")
;(reset)
;(run)
;
;LAST MODIFIED: 11/30/2017
;

;TVSHOW CLASS
(defclass TVSHOW
	(is-a USER)
	(role concrete)
	(slot viewedName)
	(slot nameShow)
	(slot genre)
	(slot isShow)
	(slot rating)
	(slot tag))

;ALLOWS ACCESS OF TVSHOW OBJECTS FOR SUCCESSFUL PRINTING
(defmessage-handler TVSHOW printname()
	(printout t crlf "->RECOMMENDATION<-" crlf "Title: " ?self:nameShow crlf
	"Genre: " ?self:genre crlf crlf))

;PERSON CLASS OF CURRENT USER	
(defclass PERSON
	(is-a USER)
	(role concrete)
	(slot firstName)
	(slot doIContinue)
	(slot excitementWanted)
	(slot intricatePlot)
	(slot goodFeelings)
	(slot laughMood)
	(slot kidsAround)
	(slot tabooTopics)
	(slot suggestedGenre)
	(slot suggestedShow)
	(slot suggestedRating)
	(slot suggestedShortLength))

;PERSON INSTANCE
(definstances PERSON-INSTANCES
	(firstPerson of PERSON 
		(firstName)
		(doIContinue go)
		(excitementWanted)
		(intricatePlot)
		(goodFeelings)
		(laughMood)
		(kidsAround)
		(tabooTopics)
		(suggestedShow zero)))

;TV SHOW INSTANCES
(definstances TVSHOW-INSTANCES
	(FamilyGuy of TVSHOW
		(viewedName FamilyGuy)
		(nameShow "Family Guy")
		(genre comedy)
		(isShow true)
		(rating T))
	(SouthPark of TVSHOW
		(viewedName SouthPark)
		(nameShow "South Park")
		(genre comedy)
		(isShow true)
		(rating M))
	(TheOffice of TVSHOW
		(nameShow "The Office")
		(genre comedy)
		(isShow true)
		(rating E))
	(JerryBeforeSeinfeld of TVSHOW
		(nameShow "Jerry Before Seinfeld")
		(genre comedy)
		(isShow false)
		(rating E))
	(Narcos of TVSHOW
		(nameShow "Narcos")
		(genre crimeDrama)
		(isShow true)
		(rating M))
	(PulpFiction of TVSHOW
		(nameShow "Pulp Fiction")
		(genre crimeDrama)
		(isShow false)
		(rating M))
	(LawAndOrder of TVSHOW
		(nameShow "Law And Order SVU")
		(genre crimeDrama)
		(isShow true)
		(rating T))
	(Zootopia of TVSHOW
		(nameShow "Zootopia")
		(genre crimeDrama)
		(isShow false)
		(rating E))
	(TheCloneWars of TVSHOW
		(nameShow "The Clone Wars")
		(genre action)
		(isShow true)
		(rating E))
	(TheWalkingDead of TVSHOW
		(nameShow "The Walking Dead")
		(genre action)
		(isShow true)
		(rating M))
	(BigTroubleInLittleChina of TVSHOW
		(nameShow "Big Trouble in Little China")
		(genre action)
		(isShow false)
		(rating T))
	(BurnNotice of TVSHOW
		(nameShow "Burn Notice")
		(genre action)
		(isShow true)
		(rating T))
	(PlanetLife of TVSHOW
		(nameShow "Planet Life")
		(genre documentary)
		(isShow true)
		(rating E))
	(BlackFish of TVSHOW
		(nameShow "Black Fish")
		(genre documentary)
		(isShow false)
		(rating E))
	(HotGirlsWanted of TVSHOW
		(nameShow "Hot Girls Wanted")
		(genre documentary)
		(isShow false)
		(rating M))
	(Religuous of TVSHOW
		(nameShow "Religuous")
		(genre documentary)
		(isShow false)
		(rating T))
	(Amelie of TVSHOW
		(nameShow "Amelie")
		(genre romance)
		(isShow false)
		(rating M))
	(LoveActually of TVSHOW
		(nameShow "Love Actually")
		(genre romance)
		(isShow false)
		(rating T))
	(FridayNightLights of TVSHOW
		(nameShow "Friday Night Lights")
		(genre romance)
		(isShow true)
		(rating T))
	(CorpseBride of TVSHOW
		(nameShow "Corpse Bride")
		(genre romance)
		(isShow false)
		(rating E))
	(BeeMovie of TVSHOW
		(nameShow "Bee Movie")
		(genre transcendant)
		(isShow false)
		(rating E)))


;USER INPUT QUESTIONS
;FURTHER QUESTIONS DEPEND ON PREVIOUS INPUTS
(defrule nameQuest
?ins <- (object (is-a PERSON)(doIContinue go))
=> 
(printout t "Welcome to the NetflixYourLifeAway Expert System!" crlf
"Please enter your name so that we can best personalize your experience: ")
(bind ?response(read))
(send ?ins put-firstName ?response))

(defrule excitementQuest
?ins <- (object (is-a PERSON)(doIContinue go))
=> 
(printout t crlf "Are you in the mood for excitement? y or n: ")
(bind ?response(read))
(send ?ins put-excitementWanted ?response))

(defrule plotQuest
?ins <- (object (is-a PERSON)(excitementWanted y))
=> 
(printout t "Are you willing to follow an intricate plot? y or n: ")
(bind ?response(read))
(send ?ins put-intricatePlot ?response))

(defrule goodFeelQuest
?ins <- (object (is-a PERSON)(excitementWanted n))
=> 
(printout t "Do you enjoy feeling feelings? y or n: ")
(bind ?response(read))
(send ?ins put-goodFeelings ?response))

(defrule laughingMoodQuest
?ins <- (object (is-a PERSON)(goodFeelings n))
=> 
(printout t "Are you in a laughing mood? y or n: ")
(bind ?response(read))
(send ?ins put-laughMood ?response))


;RATINGS USER INPUT 
;GATHERS INFORMATION ON DESIRED RATING BASED ON USER PREFERENCE
(defrule familyFriendlyQuest
?ins <- (object (is-a PERSON)(doIContinue go))
=> 
(printout t "Are you interested in something family friendly? y or n: ")
(bind ?response(read))
(send ?ins put-kidsAround ?response))

(defrule controversialQuest
?ins <- (object (is-a PERSON)(doIContinue go))
=> 
(printout t "Are you okay with controversial topics(drugs, LGBTQ, etc.)? y or n: ")
(bind ?response(read))
(send ?ins put-tabooTopics ?response))

(defrule lengthQuest
(nodontdoit true)
?ins <- (object (is-a PERSON)(suggestedShow conflict))
=> 
(printout t "Are you short on time? y or n: ")
(bind ?response(read))
(send ?ins put-suggestedShortLength ?response))


;GENRE DETERMINED
;USES PAST INPUT TO INFER DESIRED GENRE
(defrule suggestComedy
?ins <- (object (is-a PERSON)(laughMood y))
=> (send ?ins put-suggestedGenre comedy))

(defrule suggestCrDrama
?ins <- (object (is-a PERSON)(intricatePlot y))
=> (send ?ins put-suggestedGenre crimeDrama))

(defrule suggestAction
?ins <- (object (is-a PERSON)(intricatePlot n))
=> (send ?ins put-suggestedGenre action))

(defrule suggestDoc
?ins <- (object (is-a PERSON)(laughMood n))
=> (send ?ins put-suggestedGenre documentary))

(defrule suggestRomance
?ins <- (object (is-a PERSON)(goodFeelings y))
=> (send ?ins put-suggestedGenre romance))

(defrule beeMovieRulesAll
?ins <- (object (is-a PERSON)(suggestedShow BeeMovie))
=> (send ?ins put-suggestedGenre "transcends all genres")(assert (nodontdoit false)))

;RATINGS DETERMINED
;ASSIGNS RATINGS BASED ON USER INPUT
(defrule determineE
?ins <- (object (is-a PERSON)(kidsAround y)(tabooTopics n))
=> (send ?ins put-suggestedRating E))

(defrule determineT
?ins <- (object (is-a PERSON)(kidsAround y)(tabooTopics y))
=> (send ?ins put-suggestedRating T))

(defrule determineT2
?ins <- (object (is-a PERSON)(kidsAround n)(tabooTopics n))
=> (send ?ins put-suggestedRating T))

(defrule determineM
?ins <- (object (is-a PERSON)(kidsAround n)(tabooTopics y))
=> (send ?ins put-suggestedRating M))

;DETERMINE SHOW
;USES GENRE AND RATING TO DETERMINE SHOW TITLE
;WHEN CONFLICT OCCURS BETWEEN TITLES WITH SIMILAR GENRES/RATINGS, FURTHER RULES RESOLVE
(defrule suggestFG
?ins <- (object (is-a PERSON)(suggestedGenre comedy)(suggestedRating T))
=> (send ?ins put-suggestedShow FamilyGuy)(assert(nodontdoit false)))

(defrule suggestSP
?ins <- (object (is-a PERSON)(suggestedGenre comedy)(suggestedRating M))
=> (send ?ins put-suggestedShow SouthPark)(assert(nodontdoit false)))

(defrule suggestTOorJBS
?ins <- (object (is-a PERSON)(suggestedGenre comedy)(suggestedRating E))
=> (send ?ins put-suggestedShow conflict)(assert(nodontdoit true)))

(defrule resolveComedyConflictTO
?ins <- (object (is-a PERSON)(suggestedGenre comedy)(suggestedRating E)(suggestedShortLength y))
=> (send ?ins put-suggestedShow TheOffice)(assert(nodontdoit false)))

(defrule resolveComedyConflictJBS
?ins <- (object (is-a PERSON)(suggestedGenre comedy)(suggestedRating E)(suggestedShortLength n))
=> (send ?ins put-suggestedShow JerryBeforeSeinfeld)(assert(nodontdoit false)))

(defrule suggestNRCorPF
?ins <- (object (is-a PERSON)(suggestedGenre crimeDrama)(suggestedRating M))
=> (send ?ins put-suggestedShow conflict)(assert(nodontdoit true)))

(defrule resolveCrimeDramaConflictPF
?ins <- (object (is-a PERSON)(suggestedGenre crimeDrama)(suggestedRating M)(suggestedShortLength n))
=> (send ?ins put-suggestedShow PulpFiction)(assert(nodontdoit false)))

(defrule resolveCrimeDramaConflictNRC
?ins <- (object (is-a PERSON)(suggestedGenre crimeDrama)(suggestedRating M)(suggestedShortLength y))
=> (send ?ins put-suggestedShow Narcos)(assert(nodontdoit false)))

(defrule suggestLaO
?ins <- (object (is-a PERSON)(suggestedGenre crimeDrama)(suggestedRating T))
=> (send ?ins put-suggestedShow LawAndOrder)(assert(nodontdoit false)))

(defrule suggestZoo
?ins <- (object (is-a PERSON)(suggestedGenre crimeDrama)(suggestedRating E))
=> (send ?ins put-suggestedShow Zootopia)(assert(nodontdoit false)))

(defrule suggestPLorBF
?ins <- (object (is-a PERSON)(suggestedGenre documentary)(suggestedRating E))
=> (send ?ins put-suggestedShow conflict)(assert(nodontdoit true)))

(defrule resolveDocConflictPL
?ins <- (object (is-a PERSON)(suggestedGenre documentary)(suggestedRating E)(suggestedShortLength y))
=> (send ?ins put-suggestedShow PlanetLife)(assert(nodontdoit false)))

(defrule resolveDocConflictBF
?ins <- (object (is-a PERSON)(suggestedGenre documentary)(suggestedRating E)(suggestedShortLength n))
=> (send ?ins put-suggestedShow BlackFish)(assert(nodontdoit false)))

(defrule suggestHGW
?ins <- (object (is-a PERSON)(suggestedGenre documentary)(suggestedRating M))
=> (send ?ins put-suggestedShow HotGirlsWanted)(assert(nodontdoit false)))

(defrule suggestRelig
?ins <- (object (is-a PERSON)(suggestedGenre documentary)(suggestedRating T))
=> (send ?ins put-suggestedShow Religuous)(assert(nodontdoit false)))

(defrule suggestTCW
?ins <- (object (is-a PERSON)(suggestedGenre action)(suggestedRating E))
=> (send ?ins put-suggestedShow TheCloneWars)(assert(nodontdoit false)))

(defrule suggestTWD
?ins <- (object (is-a PERSON)(suggestedGenre action)(suggestedRating M))
=> (send ?ins put-suggestedShow TheWalkingDead)(assert(nodontdoit false)))

(defrule suggestBTILCorBN
?ins <- (object (is-a PERSON)(suggestedGenre action)(suggestedRating T))
=> (send ?ins put-suggestedShow conflict)(assert(nodontdoit true)))

(defrule resolveActionBTILC
?ins <- (object (is-a PERSON)(suggestedGenre action)(suggestedRating T)(suggestedShortLength n))
=> (send ?ins put-suggestedShow BigTroubleInLittleChina)(assert(nodontdoit false)))

(defrule resolveActionBN
?ins <- (object (is-a PERSON)(suggestedGenre action)(suggestedRating T)(suggestedShortLength y))
=> (send ?ins put-suggestedShow BurnNotice)(assert(nodontdoit false)))

(defrule suggestAmelie
?ins <- (object (is-a PERSON)(suggestedGenre romance)(suggestedRating M))
=> (send ?ins put-suggestedShow Amelie)(assert(nodontdoit false)))

(defrule suggestLAorFNL
?ins <- (object (is-a PERSON)(suggestedGenre romance)(suggestedRating T))
=> (send ?ins put-suggestedShow conflict)(assert(nodontdoit true)))

(defrule resolveRomanceFNL
?ins <- (object (is-a PERSON)(suggestedGenre romance)(suggestedRating T)(suggestedShortLength y))
=> (send ?ins put-suggestedShow FridayNightLights)(assert(nodontdoit false)))

(defrule resolveRomanceLA
?ins <- (object (is-a PERSON)(suggestedGenre romance)(suggestedRating T)(suggestedShortLength n))
=> (send ?ins put-suggestedShow LoveActually)(assert(nodontdoit false)))

(defrule suggestCB
?ins <- (object (is-a PERSON)(suggestedGenre romance)(suggestedRating E))
=> (send ?ins put-suggestedShow CorpseBride)(assert(nodontdoit false)))

;CHOOSE SHOW FROM TVSHOW OBJECTS
;RULES ALLOW SUCCESSFUL PRINTING OF MEDIA RECOMMENDATION
;UTILIZES TVSHOW OBJECTS AND ACCESSES nameShow SLOT
(defrule chooseShowFG
(object (is-a PERSON)(suggestedShow FamilyGuy))
=>
(send [FamilyGuy] printname))

(defrule chooseShowSP
(object (is-a PERSON)(suggestedShow SouthPark))
=>
(send [SouthPark] printname))

(defrule chooseShowTO
(object (is-a PERSON)(suggestedShow TheOffice))
=>
(send [TheOffice] printname))

(defrule chooseShowJBS
(object (is-a PERSON)(suggestedShow JerrySeinfeld))
=>
(send [JerrySeinfeld] printname))

(defrule chooseShowNRC
(object (is-a PERSON)(suggestedShow Narcos))
=>
(send [Narcos] printname))

(defrule chooseShowPF
(object (is-a PERSON)(suggestedShow PulpFiction))
=>
(send [PulpFiction] printname))

(defrule chooseShowLaO
(object (is-a PERSON)(suggestedShow LawAndOrder))
=>
(send [LawAndOrder] printname))

(defrule chooseShowZoo
(object (is-a PERSON)(suggestedShow Zootopia))
=>
(send [Zootopia] printname))

(defrule chooseShowTCW
(object (is-a PERSON)(suggestedShow TheCloneWars))
=>
(send [TheCloneWars] printname))

(defrule chooseShowTWD
(object (is-a PERSON)(suggestedShow TheWalkingDead))
=>
(send [TheWalkingDead] printname))

(defrule chooseShowBTILC
(object (is-a PERSON)(suggestedShow BigTroubleInLittleChina))
=>
(send [BigTroubleInLittleChina] printname))

(defrule chooseShowBN
(object (is-a PERSON)(suggestedShow BurnNotice))
=>
(send [BurnNotice] printname))

(defrule chooseShowPL
(object (is-a PERSON)(suggestedShow PlanetLife))
=>
(send [PlanetLife] printname))

(defrule chooseShowBF
(object (is-a PERSON)(suggestedShow BlackFish))
=>
(send [BlackFish] printname))

(defrule chooseShowHGW
(object (is-a PERSON)(suggestedShow HowGirlsWanted))
=>
(send [HotGirlsWanted] printname))

(defrule chooseShowRG
(object (is-a PERSON)(suggestedShow Religuous))
=>
(send [Religuous] printname))

(defrule chooseShowAM
(object (is-a PERSON)(suggestedShow Amelie))
=>
(send [Amelie] printname))

(defrule chooseShowLA
(object (is-a PERSON)(suggestedShow LoveActually))
=>
(send [LoveActually] printname))

(defrule chooseShowFNL
(object (is-a PERSON)(suggestedShow FridayNightLights))
=>
(send [FridayNightLights] printname))

(defrule chooseShowCB
(object (is-a PERSON)(suggestedShow CorpseBride))
=>
(send [CorpseBride] printname))

;IF USER IS SATISFIED, PRINTS GOODBYE MESSAGE
(defrule userIsHappy 
(object (is-a PERSON)(doIContinue y)(firstName ?fn))
=> (printout t crlf ?fn ", I'm so happy you are satisfied with your suggestion!" crlf
"Have a great day and come back whenever you're at a lost for what to watch!" crlf))


;IF USER DECIDES THEY DONT LIKE SHOW GIVEN
;ALLOWS ADDITIONAL OPTION TO BE PRESENTED
(defrule noLikeShow (declare (salience -10))
?ins <- (object (is-a PERSON)(doIContinue go))
=>
(printout t "Are you happy with this suggestion? y or n: ")
(bind ?response(read))
(send ?ins put-doIContinue ?response))

(defrule beeMovieFailState 
?ins <- (object (is-a PERSON)(doIContinue n))
=> (send ?ins put-suggestedShow BeeMovie))

(defrule chooseShowBM
(object (is-a PERSON)(suggestedShow BeeMovie))
=>
(printout t crlf "I'm sorry to hear that! Enjoy a movie you could never hate: The Bee Movie" crlf
"It's sure to bring you tons of laughs. Have fun!" crlf))
