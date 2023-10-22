VAR name = "Geoff"
VAR food = 5
VAR gold = 5
VAR wb_pop = 5
VAR char_count = 0
VAR wanted_portswood = 0
VAR day = 0
VAR ant = 0
VAR grasshopper = 0
VAR cure_progress = 0

-> Waking_up


==== Waking_up ====
~ day++
You awake from your blissful slumber. As you recollect your thoughts, you look at your surroundings..
A rickety wooden bed, a bedside table, and 4 stone walls are dimly lit by a candle about to extinguish. You recognize this to be your bedroom. 
As you gaze through the small peephole onto the outside world, you are left in awe at the rolling hills and sprawling forests of Portswood. 
# setName
For some strange reason, such a beautiful sight reminds you of your name: 
# waitDesk
"Of course your name is { name }, you silly ol' goose!" you think to yourself. Time to get on with your duties...
    -> Getting_Started
    
==== Getting_Started ====
You make it to your desk. Upon it is a half-empty bottle of wine, a sand timer and a book.
* [Look at wine bottle] -> Wine_Bottle
* [Look at sand timer] -> Sand_Timer
* [Look at book] -> Book

==== Wine_Bottle ====
"Wow.. Last night must've been a wild one. Explains why my head feels like its full of rocks..."
    -> Getting_Started

==== Sand_Timer ====
"Hmm. Definitely a sand timer"
    -> Getting_Started

==== Book ====
As you pick up the dusty, leather-bound book, you remember the words uttered by your father the day he gave it to you...
Father: "My most beloved son, I give onto you, the most important item a ruler can have: his personal diary"
"Cherish it and protect it with your life. It is a record of your progress as a ruler"
"It details the food stores, the supply of gold, and the wellbeing of the population"
"If any of these traits should fall empty, you will be forced to surrender yourself as ruler, so keep a watchful eye on them"
# enableBook # delay
"I must also stress that the book-keeper stays up every night maintaining it. If she catches wind that this book is lost, she will hit you where the sun doesn't shine"
    -> Father_Memory

==== Father_Memory ====
Hearing your father's voice again brings back the painful memory of his passing.
* [You remember your father fondly] -> Father_Memory_Positive
* [You remember your father hatefully] -> Father_Memory_Negative

==== Father_Memory_Positive ====
"I miss father.. If only he were still around to give me some guidance" you think to yourself.
"He entrusted me with his lands. I will make him proud"
    -> Introduce_Characters

==== Father_Memory_Negative ====
"I feel like I should miss him, but I don't. He was never around" you think to yourself.
"His death left me with the responsibility of looking after his lands. Now I'm forced to clean up his mess"
    -> Introduce_Characters

==== Introduce_Characters ====
The other advisors in the room can tell that your mind is wandering off to dark places. Go introduce yourself to them... (Press E to interact)
    -> Speak_To_Characters
    
==== Speak_To_Characters ====
{ char_count == 4: 
    -> End_Of_Day_1 
}
# waitChars
(Choice)
* [Bookkeeper] -> Bookkeeper
* [Farmer] -> Farmer
* [Alchemist] -> Alchemist
* [Treasurer] -> Treasurer

==== Bookkeeper ====
Book-keeper: "The most honourable lord Baron { name }, it is a pleasure to be serving you, my lord."
"I am your most humble servant Guinevere, keeper of books. It is my responsibility to maintain the lord's personal diary, and see to the wellbeing of the population."
"I shall let you know when your people are unhappy with your decisions."
"I sincerely apologize for the passing of your father. I served under his guard for many years, he was truly a great man."
"First order of business: You're inauguration ceremony takes place this weekend, and the people of Portswood would love to see you! Will you be attending?"
* [Attend Inauguration] "Of course, it is important to me that the people know who's ruling over them" you reply. 
    -> Attend_Inauguration
* [Do not attend Inauguration] "Meh. Gonna pass on that one. Seems like a lot of effort" you reply. 
    -> Dont_Attend_Inauguration

==== Attend_Inauguration ====
Book-keeper: "As you wish. Your presence will mean a great deal to them, as it does to me."
~ ant++
{ Inc_Wb_Pop(1) }
Guinevere the Book-keeper seems loyal and kind.
    -> Speak_To_Characters

==== Dont_Attend_Inauguration ====
Book-keeper: "Oh. That is surprising. As you wish."
~ grasshopper++
{ Dec_Wb_Pop(1) }
Guinevere the Book-keeper seems loyal and kind.
    -> Speak_To_Characters
    
==== function Inc_Wb_Pop(x) ====
~ wb_pop = wb_pop + x
Wellbeing of population increased by { x }
    
==== function Dec_Wb_Pop(x) ====
~ wb_pop = wb_pop - x
Wellbeing of population decreased by { x }
    
==== Farmer ====
Farmer: "Ayup there bud, pleasure to be meeting you."
"My name is Ivar, and I am but a humble wheat farmer. I got wheat fields that go out as far as the eye can see. I'll see to it that everyone 'ere is fed."
"Just make sure that you sign off on my farmin' plans, and everything will be alright."
"Speaking of, what would ya 'ave me do with this bag 'o berries { name }? Got loads of 'em."
* [Save the berries] "It would be most sensible to store them away for when we need them" you respond.
    -> Save_Berries
* [Eat the berries] "Ooooo food! Gimme gimme yum yum" you respond, in-between taking mouthfuls of raspberries.
    -> Eat_Berries
    
==== Save_Berries ====
Farmer: "A smart one, I see! I shall put them in the food store."
~ ant++
{ Inc_Food(1) }
Ivar the Farmer seems honest and humble.
    -> Speak_To_Characters

==== Eat_Berries ====
Farmer: "Well hang on just a minute.. Those weren't for you! Oh bugger it, I'll have some aswell.."
~ grasshopper++
{ Dec_Food(2) }
Ivar the Farmer seems honest and humble.
    -> Speak_To_Characters
    
==== function Inc_Food(x) ====
~ food = food + x 
Food increased by { x }
    
==== function Dec_Food(x) ====
~ food = food - x
Food decreased by { x }

==== Alchemist ====
Alchemist: "Your lordship.."
"It's the rats that are carrying it, you know? Most people don't know that."
"The Black Death. That's what they're calling it. It'll only take a few years for it to get to these parts. You should be worried."
"The name's Lucian by the way. I am known as the alchemist.. I have made it my life's work to discover cures for diseases."
"I do so by transforming base metals into silver and gold. Fancy stuff. Put your faith in me and I will perform miracles."
"So, what should I do about this Black Death?"
* [Look into it] "Can't be too careful.. Have a look into it" you answer.
    -> Look_Into_Black_Death
* [Do nothing] "Meh. It's probably nothing. Try to forget about it!" you answer.
    -> Dont_Look_Into_Black_Death

==== Look_Into_Black_Death ====
Alchemist: "Glad to know I'm not working with an amateur. I'll get on it right away { name }."
~ ant++
~ cure_progress++
Lucian the Alchemist seems mysterious but quite knowledgeable.
    -> Speak_To_Characters

==== Dont_Look_Into_Black_Death ====
Alchemist: "Hmm.. As you command. Don't come crawling back to me when the bodies pile up."
~ grasshopper++
Lucian the Alchemist seems mysterious but quite knowledgeable.
    -> Speak_To_Characters
    
==== Treasurer ====
Treasurer: "..."
The treasurer is busy counting coins.
Treasurer: "Huh... Oh hey... Umm... Gimme a sec."
"Yes.. Uh.. Hello. The name's Milo. I am the treasurer in these parts. I see to it that every last gold coin is accounted for."
"I'll be keeping a watchful eye on your expenses. After all, money does make the world go round, hehe."
"..."
"You're still here? I'm very busy right now, I'll have to charge you by the minute for any further discourse."
As you turn around to leave, the treasurer lets out a squeal.
Treasurer: "No wait, there was one thing.. I noticed that you were going to spend a large sum of money on wine imports from France.."
"Is that such a great idea?"
* [No, save the money] "No, you're right. I shouldn't be digging into the gold stores for my own personal pleasure" you reply.
    -> Dont_Spend_Money_On_Wine
* [Yes, wine is great!] "Oh come on, allow me some of the finer things in life. I am a Baron now, after all" you reply.
    -> Spend_Money_On_Wine

==== Dont_Spend_Money_On_Wine ====
Treasurer: "I'm relieved to hear that { name }, though I have now forgotten what number I got to.. Hmmph. 1342, 1343, 1344..."
~ ant++
{ Inc_Gold(1) }
Milo the Treasurer seems impatient and petty.
    -> Speak_To_Characters
    
==== Spend_Money_On_Wine ====
Treasurer: "Wow ok, I see how it is. You've only gone and made me forget what number I got to.. Hmmph. 1343, 1344, 1345..."
~ grasshopper++
{ Dec_Gold(1) }
Milo the Treasurer seems impatient and petty.
    -> Speak_To_Characters

==== function Inc_Gold(x) ====
~ gold = gold + x
Gold increased by { x }
    
==== function Dec_Gold(x) ====
~ gold = gold - x
Gold decreased by { x }
    
==== End_Of_Day_1 ====
# endWaitChars
~ char_count = 0
"What an interesting bunch" you think to yourself.
# waitBed
Talking to all your advisors has made you weary. Go get some rest...
    -> Dream
    
==== Dream ====
You throw yourself onto the bed and, after a couple of tosses and turns, fall asleep.
ZZZZZZ
ZZZzzzZZZ
ZZZZZZ
You begin to dream, taking yourself back to an earlier point in time...
# dreamStart
Father: "You both know why I brought you hear today, don't you?"
Brother: "I do father, I've heard whispers from the clergymen that you are feeling unwell."
Father: "Yes, the rumours are true. I've been suffering a great deal these past few weeks."
"My days on this world are numbered."
Brother: "Oh father, I don't know what to say..."
Father: "Don't say anything, I do not need your pity right now. What I need you to do is listen.."
Brother: "Ok.."
Father: "As I'm sure you're both aware, my lands will need to be ruled by my descendants once I am no longer around."
"And as such, I must come to a decision on who gets what."
"The first district is Portswood, a land rich in resources and natural beauty, home to thousands of kind and delightful people."
Brother: "The Jewel of the south, father."
Father: "Most certainly."
"And the second is Shirley.. ummm.. a place that uh.."
Brother: "If I may speak freely, it is a dirty and unruly hell-hole where dreams go to die."
Father: "Silence, boy! You will not speak of my domain in such a manner. The people of Shirley are honest and hard-working."
Brother: "I put myself forward to rule over Portswood. I have trained and prepared myself to rule over such a place, and have always done right by you."
* [Choose Portswood] -> Dream_Portswood
* [Choose Shirley] -> Dream_Shirley

==== Dream_Portswood ====
~ wanted_portswood++
{ name }: "I will take on Portswood."
Brother: "In your dreams { name }, you are not worthy."
Father: "It does not matter, for I have already decided."
    -> Dream_2

==== Dream_Shirley ====
{ name }: "I will happily take on Shirley."
Brother: "There you go, decision made."
Father: "{ name }, my dear sweet boy, save your breath. I have already decided."
    -> Dream_2

==== Dream_2 ====
"Portswood shall go to you, { name }. I trust you to rule with honor and dignity."
Brother: "WHAT?! Uh.."
"I can't believe this! This is crazy! Obviously your ailments have reached your head.. Your judgement is clouded."
Father: "You should be greatful I am giving you anything. The decision is final."
Brother: "This is so unfair! { name } has always been your favourite. Has my hard work meant nothing to you?"
    -> Start_Of_Day_2

==== Start_Of_Day_2 ====
~ day++
# dreamEnd
{ wanted_portswood == 1 :
    <> "My brother has held a grudge ever since. At least I got what I wanted" you think to yourself.
- else:
    <> "My brother has held a grudge ever since. I never even wanted Portswood to begin with" you think to yourself.
}
Time to begin a new day...
    -> Speak_To_Characters1
    
==== Speak_To_Characters1 ====
{ char_count == 4: 
    -> End_Of_Day_2 
}
# waitChars
(Choice)
* [Bookkeeper] -> Bookkeeper1
* [Farmer] -> Farmer1
* [Alchemist] -> Alchemist1
* [Treasurer] -> Treasurer1

==== Bookkeeper1 ====
Book-keeper: "The most finest of mornings to you my lord. I am most pleased to see you."
"I trust you are keeping a watchful eye on the diary, my lord?"
* [Yes] Book-keeper: "Oh yes! That is wonderful."
    -> Bookkeeper11
* [No] Book-keeper: "Ahh.. It would be in your best interests to do so, { name }."
    -> Bookkeeper11

==== Bookkeeper11 ====
"Right, well we must press on with today's news: the local potato farmers have requested your presence today to help settle a hedgerow dispute"
"I know it may sound meaningless but it is a part of your administrative duties, and they do pay their fair share of feudal incidents."
"Furthermore, this dispute has been going on for a number of months. I fear it may escalate without your intervention."
"So, { name }, what say thee?"
* [Settle dispute] "Of course, I would be happy to" you respond.
    -> Settle_Dispute
* [Do nothing] "You're right, that does sound meaningless. It also sounds like a lot of work" you respond.
    -> Dont_Settle_Dispute

==== Settle_Dispute ====
Book-keeper: "Oh, my honourable lord Baron, I am forever in debt to you. This hard work will not go unnoticed by the people of Portswood!"
~ ant++
{ Inc_Wb_Pop(1) }
    -> Speak_To_Characters1

==== Dont_Settle_Dispute ====
Book-keeper: "Well.. alright. I pray for your sake that the farmers don't take up their pitchforks."
~ grasshopper++
The potato farmers take up their pitchforks and threaten their neighbours further.
{ Dec_Wb_Pop(2) }
    -> Speak_To_Characters1
    
==== Farmer1 ====
Farmer: "Ayup { name }, glad to be seein' ya! This year's harvest has been most fortunate for us all. God looks kindly upon us."
"Don't suppose you have a plan for all this extra wheat?"
* [Save the wheat] "By failing to prepare, you are preparing to fail. Save it for when times are tough" you retort.
    -> Save_Wheat
* [Throw a bread party!] "Let's enjoy it while we can! Throw a party for everyone in Portswood - bread's on the menu!" you retort.
    -> Dont_Save_Wheat

==== Save_Wheat ====
Farmer: "Arr, how poignant my lord. I shall save it for a rainy day."
~ ant++
{ Inc_Food(2) }
    -> Speak_To_Characters1

==== Dont_Save_Wheat ====
Farmer: "A bread party?! Never heard that one before. That surely won't catch on, haha."
~ grasshopper++
{ Dec_Food(2) }
    -> Speak_To_Characters1
    
==== Alchemist1 ====
Alchemist: "Sudden onset of fever and chills, a pain in the lower abdomen, arms and legs..."
"What a terrible way to go. I am still fervently on the side of remaining cautious."
{ cure_progress == 1:
"I have made good progress on a cure. Should I continue with it?"
- else:
"I should've started working on a cure sooner. Shall I start now?"
}
* [Work on cure] "Yes. Do what you must." 
    -> Work_On_Cure
* [It's not real] "Black death is a scary story mother's tell their children to scare them into behaving. Don't worry about it." 
    -> Dont_Work_On_Cure

==== Work_On_Cure ====
Alchemist: "A wise decision, { name }."
~ ant++
~ cure_progress++
    -> Speak_To_Characters1

==== Dont_Work_On_Cure ====
Alchemist: "You are what is wrong with this world, { name }. When your nose turns black, you won't be smiling."
~ grasshopper++
    -> Speak_To_Characters1
    
==== Treasurer1 ====
Treasurer: "Mmmmmmm"
"Mmm.."
"..mmm"
The treasurer appears to be rubbing gold coins along his hairy chest.
He is suddenly startled at your presence.
Treasurer: "Wuh.. Oh my lord Baron.. It's not what it looks like.."
* [Yes, it is] "It's exaclty what it looks like. You are committing heinous acts with the lords bounty." 
    -> Treasurer11
* [Pretend you didn't see it] "I'm not quite sure what you mean.."
    -> Treasurer12

==== Treasurer11 ====
Treasurer: "I am most apologetic. It will not happen again."
    -> Treasurer13

==== Treasurer12 ====
Treasurer: "Oh.. Um.. Nevermind.."
    -> Treasurer13

==== Treasurer13 ====
"Anyways.. Ahem. I've been meaning to speak with you.. "
"I am almost certain that this is a mistake, but I have noticed a rather large sum of money invoiced under your name, m'lord."
"It's for a.. uh... No that can't be right..."
"It says here it is for a 20ft Gorilla.. Is this some kind of joke?"
"20ft Gorilla? That can't be real!? Can it?"
* [No, it isn't] "Haha. Must've been a mistake. Clear it from the records" you reply.
    -> Not_A_Real_Gorilla
* [Yes, it is] "You better believe it's real! And I want it very badly!!" you exclaim.
    -> A_Real_Gorilla
    
==== Not_A_Real_Gorilla ====
Treasurer: "Phew.. That amount of money was going to bankrupt us!"
{ Inc_Gold(1) }
    -> Speak_To_Characters1

==== A_Real_Gorilla ====
Treasurer: "Are you certain that this is your wish, lord Baron? It is a lot of money.."
* [Yes] "Do it" you scream at the top of your lungs.
    -> A_Real_Gorilla1
* [No] "Yeh, no probably shouldn't do that" you respond.
    -> Not_A_Real_Gorilla

==== A_Real_Gorilla1 ====
Treasurer: "Well, before I do this for you, I want you to take this.."
The treasurer hands you a letter of resignation.
{ Dec_Gold(7) }
    -> Speak_To_Characters1
    
==== End_Of_Day_2 ====
# endWaitChars
~ char_count = 0
# waitBed
Today's been a long one. Go get some rest...
    -> Start_Of_Day_3

==== Start_Of_Day_3 ====
~ day++
# spawnBrother # dreamEnd
After 2 long days as Baron of Portswood, you start to get into the swing of things.
{ ant > grasshopper:
You honor hard work over laziness, and tend to err on the side of caution. You hope that this will pay off into the future.
- else:
Ruling feels easy to you, and you enjoy the finer things in life. Who cares about preparing for the future when life is so great right now?
}
You start to see yourself as a Baron, and not just the Baron's son.
11 years start to fly by. In this time:
{ food < 5:
You enjoy lavish luncheons and giant buffets, if at the cost of your food stores.
- else:
You continue to build up a supply of food. You are certain that Portswood is prepared for any eventuality.
}
{ gold < 5:
You appreciate the finer things in life, importing expensive wines and throwing parties every other weekend, much too the treasurer's displeasure.
- else:
You persist in maintaing a healthy backup of gold, even if Milo gives you the creeps.
}
{ wb_pop < 5:
You learn to block out the displeasures of your people and start living for yourself.
- else:
You learn to listen to the thoughts of your people and honor your agreements with them. Everyone is happy.
}
However, the threat of Black Death looms large over the district of Portswood, as neighbouring districts report bubonic symptoms..
    -> Speak_To_Characters2
    
==== Speak_To_Characters2 ====
{ char_count == 1: 
    -> End_Wait
}
# waitChars
(Choice)
* [Bookkeeper] -> Bookkeeper2

==== Bookkeeper2 ====
"Your brother is here to speak with you..."
    -> Speak_To_Characters2
    
==== End_Wait ====
# endWaitChars
~ char_count = 0
    -> Speak_To_Characters3

==== Speak_To_Characters3 ====
{ char_count == 1: 
    -> End_Wait1
}
# waitChars
(Choice)
* [Brother] -> Brother3

==== Brother3 ====
Brother: "Hello brother. It makes me so miserable to see you like this. So.. happy."
"I should've been the one in your position. I could've achieved so much more. But no matter.. Shirley has benefitted a great deal from my rule."
{ ant > grasshopper: 
    -> Brother_Grasshopper
- else:
    -> Brother_Ant
}

==== Brother_Grasshopper ====
"Whilst you have been needlessly saving up supplies and preparing for some kind of apocalypse, I have allowed my people to enjoy whatever they please."
"I relish the thought that whilst your slaving away with meet-n-greats in Portswood, I am enjoying lavish lunches and wines imported from France."
"You know your preparations are worthless, right? Have you informed your subjects about this yet? They won't take it too kindly when they find out."
"My wife got the 'Black Death' last week. And do you wanna know how she suffered? A minor cough and a sore head. Haha."
"See you never, brother."
    -> Speak_To_Characters3

==== Brother_Ant ====
"Whilst you have been throwing all your gold and food into the wind, I have been busy preparing and building up supplies."
"Because you know the Black Death is real, right? I'm sure your alchemist told you all about it."
"It's the real deal. And when it comes for a visit in your neighbourhood, Shirley will take great pleasure in watching you suffer. Good luck!"
"See you never, brother."
    -> Speak_To_Characters3
    
==== End_Wait1 ====
# endWaitChars
~ char_count = 0
    -> Speak_To_Characters4 
    
==== Speak_To_Characters4 ====
{ char_count == 3: 
    -> End_Of_Day_3
}
# waitChars
(Choice)
* [Bookkeeper] -> Bookkeeper4
* [Farmer] -> Farmer4
* [Alchemist] -> Alchemist4

==== Bookkeeper4 ====
Book-keeper: "Good afternoon most honourable lord Baron. I am greatful to see you in good health, all this news of the Black Death has kept me up at night."
"Everyone in Portswood is anxious and unsure of what to make of it all."
"Will you speak to your loyal subjects, and put their minds at rest?"
* [Yes] "Yes, I will try to ease their worries" you respond.
    -> Give_Talk
* [No] "No I will not! Everyone needs to just get over it. It's not my job to tuck them in at night" you respond.
    -> Dont_Give_Talk

==== Give_Talk ====
Book-keeper: "Splendid { name }, I will setup a meeting for later on today.."
~ ant++
{ Inc_Wb_Pop(2) }
    -> Speak_To_Characters4

==== Dont_Give_Talk ====
Book-keeper: "As you wish, my lord."
~ grasshopper++
{ Dec_Wb_Pop(2) }
    -> Speak_To_Characters4
    
==== Farmer4 ====
Farmer: "'Ello ther! Glad to be with ya { name }, hope all is well."
{ food < 5:
"I won't lie to yer, the food stores are looking a lil' low at the moment. Something might need to be done 'bout it."
- else:
"I can gladly say that the food stores are looking very healthy at the moment, might be time to treat everyone to a buffet, ayy! Think we all deserve it, don't you?"
}
"But that aside, I wanted to ask you about the harvest festival comin' up.."
"I know you said we would scrap the festival this year to do more farming.."
"See, we're low on helpers at the moment, and could use every hand on deck to keep the food stores maintained."
"Would you be willing to get yer hands dirty?"
"It's that, or go ahead with the festival.."
* [Get hands dirty] "I'll help out in any way I can" you answer.
    -> Get_Hands_Dirty
* [Do festival instead] "That sounds like hard work, let's just do the festival" you answer.
    -> Dont_Get_Hands_Dirty

==== Get_Hands_Dirty ====
Farmer: "Absolutely crackin'! 'Ere is a shovel. Get to work!"
~ ant++
{ Inc_Food(1) }
    -> Speak_To_Characters4
    
==== Dont_Get_Hands_Dirty ====
Farmer: "Arr! We could all do with a bit of a break at the moment."
~ grasshopper++
{ Dec_Food(1) }
    -> Speak_To_Characters4
    
==== Alchemist4 ====
{ cure_progress > 0:
Alchemist: "You were right to be cautious about Black Death. I've heard from many sources that the terrible disease has blasted it's way through Europe."
- else:
Alchemist: "You were wrong to dismiss the Black Death. I've heard from many sources that the terrible disease has blasted it's way through Europe."
}
"What would you have me do, Baron { name }?"
* [Work on cure] "Portswood is greatful for you work. Keep working on it, just to be sure!" you explain. 
    -> Work_On_Cure1
* [Take the day off] "You're clearly stressed and overworked. Take a rest" you explain.
    -> Dont_Work_On_Cure1

==== Work_On_Cure1 ====
Alchemist: "Work I shall. Next I will try to enfuse silver in copper. Silver has yielded good results so far."
~ ant++
~ cure_progress++
    -> Speak_To_Characters4

==== Dont_Work_On_Cure1 ====
Alchemist: "I am offended that you would think I could ever rest while the Black Death looms."
~ grasshopper++
    -> Speak_To_Characters4
    
==== End_Of_Day_3 ====
# despawnBrother
# endWaitChars
~ char_count = 0
# waitBed
Go get some rest...
    -> Start_Of_Day_4
    
==== Start_Of_Day_4 ====
~ day++
# spawnBrother # dreamEnd # playTense
All this talk of Black Death would prevent anyone from resting easy.
The district of Portswood would be left on it's toes for the next 4 years..
While some doubted the severity of Black Death, some doubted it's very existence..
And while some doubted it's existnce, some would fear for their lives..
{ ant > grasshopper:
But whatever would come to the serene town of Portswood, you, Baron { name }, knew you were ready.
- else:
You started to doubt that the serene town of Portswood world survive such a disease. If it were to suffer, you, Baron { name }, would be responsible.
}
Inevitably, in march of 1360, the Black Death dug it's deadly claws into the South of England.
Neighbouring towns and villages suffered the toll.
Famine.
Poverty.
And worst of all, death.
In the thousands.
{ ant > grasshopper:
At least that was the story for most. Due to the hard work and foresight of Baron { name }, Portswood was left unscathed.
- else:
And like all the other towns surrounding it, Portswood suffered the same fate.
}
{ cure_progress > 1:
Thanks to the caution shown by the Baron, Lucian the Alchemist was able to administer a cure to every inhabitant of Portswood, ensuring their safety and health.
- else:
If only the Baron had allowed Lucian the Alchemist to start a cure sooner.
}
    -> Speak_To_Characters5
    
==== Speak_To_Characters5 ====
{ char_count == 1: 
    -> End_Wait2 
}
# waitChars
(Choice)
* [Bookkeeper] -> Bookkeeper5

==== Bookkeeper5 ====
Book-keeper: "It's your brother again..."
    -> Speak_To_Characters5

==== End_Wait2 ====
# endWaitChars
~ char_count = 0
    -> Speak_To_Characters6

==== Speak_To_Characters6 ====
{ char_count == 1: 
    -> End_Wait3 
}
# waitChars
(Choice)
* [Brother] -> Brother6

==== Brother6 ====
{ ant > grasshopper:
    -> Brother61
- else:
    -> Brother62
}

==== Brother61 ====
Brother: "I come to you in a time of great need, dear brother."
"For now, in this moment, I think back on the times I looked down on you, and I realise, that I was the foolish one."
"You were right. About everything."
"I don't expect you to forgive me for the things I said."
"And I don't expect you to help me."
"But what I do ask is that you look into your heart, and find a way to help the people of Shirley."
"We have suffered a great deal."
"Will you offer your support?"
* [Yes] "Not for you, but for the people of Shirley.." you respond.
    -> Help_Shirley
* [No] "I'm afraid the time for forgiveness has long since passed." you respond.
    -> Dont_Help_Shirley
    
==== Help_Shirley ====
Brother: "Yes, of course."
"Then it is done." you proclaim.
You both share a smile for the first time in your collective lives.
    -> Speak_To_Characters6
    
==== Dont_Help_Shirley ====
Brother: "I understand."
You notice your brother shed a single tear, as he turns to leave your house for the final time.
    -> Speak_To_Characters6

==== Brother62 ====
You explain the severity of the situation to your brother, as he stares off into the distance, emotionless.
You describe the suffering and heartache felt by the people of Portswood.
Brother: "I see. Just come out with it already."
* [Will you help us?] "I beg of you brother, please help the people of Portswood. You're our only hope" you respond.
"Do it for Portswood, not for me.." you cry.
After a minute of silence, your brother quitely replys..
Brother: "Yes, of course."
You both share a smile for the first time in your collective lives.
    -> Speak_To_Characters6

==== End_Wait3 ====
# endWaitChars
~ char_count = 0
    -> Final 
    
==== Final ====
And with that, your legacy as the Baron of Portswood lives on, for better or for worse.
You are known as 'Lord Baron { name } the
{ ant > grasshopper:
    <> Cautious.'
- else:
    <> Lazy.'
}
    -> END

==== Traits_Empty ====
A terrible realisation catches you by surprise.
Your lack of ambition and caution has led to the depletion of.. 
{ 
    - food < 1:
        <> Food.
    - gold < 1:
        <> Gold.
    - else:
        <> The wellbeing of your population.
}
You are forced to surrender your title as 'Lord Baron { name } of Portswood'.
"Still, we did have a good run with it, didn't we?" you chuckle to yourself.
    -> END