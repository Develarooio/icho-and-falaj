# icho-and-falaj

A game of discovery and wisdom wherein you navigate the treetops as Falaj, the flowy sloth being, accompanied by Icho, a small glowing entity, in search of Our Natural Father.

# World

## Swinging

Although Falaj can walk and leap, his most identifying mode of traversal is a graceful swinging between the boughs of the trees. Long, somewhat elastic arms enable this.

## Day and Night

Day and night are short in Our Father's Forest and they each bring dramatic changes to the landscape. During the day, eagles from the ocean flit through the skies and during the night, forest fairies waft through the gentle night breeze, casting a soft glow on the brush and vines.

# Cast

## Main

### Falaj

Falaj is a well-meaning and naive sloth-spirit with a flowing mane of hair and stretchy arms which allow him to swing through the Forest. Falaj takes but he does not keep.

### Icho

It's unclear what or who Icho is, but it bears some resemblance to the forest fairies. Despite this similarity, Icho behaves nothing like his brethren and instead clings to Falaj's mane.

## Forest Spirits

### Som-som

Som-som is the first of the blue spirits. She expresses the spirit of the mole, and praises sleep to her listeners.

### Tango

Tango is the livelier of the blue spirits and her laughing energizes and rejuvenates.

### Our Natural Father

The oldest and most centered of the forest beings, Our Natural Father whiles away infinite hours in the Wisdom Dispensary,  communicating only in cryptic sayings. If one stops to listen to his sayings, Our Natural Father is likely to bequeath them with a wisdom nugget as a gift.

## Buds

Icho and Falaj are not alone in the forest wanderings. Indeed, the forest is full of life and Falaj frequently encounters his buds, who, despite initial coyness, enjoy opening themselves to passers-by and sharing their stories with willing listeners.

### Tora

### Dorito

### Eric



# Environment

## Stones

The forest floor is littered with mossy stones. Falaj can carry a number of stones of varying sizes. If he encounters (or places) a stone on the forest floor, he may stack another smaller stone on top of it in order to build a cairn.

## Cairns

Cairns are stacks of stone built on the forest floor. Forest beings find comfort in proximity to these cairns and at night they congregate around them, enjoying their soft glow and a sense of togetherness. Larger cairns glow brighter and thus attract more forest denizens. In some cases, if a cairn is big enough, the night dark enough, and the moon bright enough, forest fairies will travel to the cairn and perform rituals. If Icho is present during one of these events, it's possible that one of the blue spirits will appear.

## Mushrooms

The forest is lush with blue and red capped mushrooms which, if eaten, cause the consumer to fall into a calm and reflective state, ideal for bonding and communion.

## The Wisdom Dispensary

The wisdom dispensary is the hidden domicile of Our Natural Father. Entry to The Wisdom Dispensary is allowed only to those who bring acceptable offerings.

## Wisdom Nuggets

Our Natural Father, if appeased, is known to give wisdom nuggets to his visitors. A wisdom nugget appears to be a small chunk of ore of unknown origin (unusual, given that there are certainly no mines in the forest). In some ways, wisdom nuggets are serializations of the realizations one usually enjoys while conversing with Our Father. It's certainly worth storing these in a safe place for future consultation!

## Forest Fairies

In the darkest nights, the forest is still lit by the most minor of the forest spirits. Sometimes mistaken for fireflies, the fairies of the forest are aimless but not purposeless and drift between the trees unhurriedly.



# Mechanics Breakdown

### Game Objects

* Falaj
* Icho
* Wisdom Dispensary
* Our Natural Father
* Stones
* Cairns
* Fairies
* Buds
* Wisdom Nuggets
* Map
* Game
* Blue Spirits

### Behaviors

* There is a Game which
  * is started once
  * is saved many times
  * can be reopened
  * has one Map
* There is a Map which
  * is generated when it's Game is started
  * has an upper bound in the sky
  * has a lower bound at the forest floor
  * has platforms which Falaj can stand on
  * has attachment points which Falaj can grab onto and swing from
  * has one Wisdom Dispensary
  * has many Buds distributed around it
  * has a constantly-progressing time which
    * determines whether it should be night or day
  * has a moon which
    * only appears at night
    * varies in brightness from night to night
* There are Rocks which
  * appear randomly around the map
  * may be one of many sizes
  * have a fragility which
    * determines the likelihood that the rock will break if a Cairn it composes is knocked over by the wind
* There are Cairns which
  * are composed of many rocks of successively smaller sizes
  * have a size which
    * determines how likely a Blue Spirit is to appear there
  * at night, attract Fairies
  * have a Fairy attraction radius which
    * increases with size
    * determines how close a Fairy must be in order to wander toward the cairn
  * have a Fairy ownership radius which
    * indicates how close a Fairy must be to be considered contained by the cairn
  * have a Fairy saturation number which
    * indicates how many Fairies the Cairn must contain in order to summon a Blue Spirit
  * at day, may be knocked over by wind
* There is Falaj who
  * can walk left or right
  * can hop
  * can throw his arms which begin as a default length and rotate clockwise until they reach a lower limit at which point they retract
  * can lengthen or retract his arms while they are deployed (either being thrown or attached to a ledge or branch)
  * while holding the edge of a platform with his arms, can retract them until he is level with the platform, at which point he can mantel onto the platform
  * will swing if he grabs a branch with non-zero x momentum
  * can initiate a swing while statically holding a branch by rocking back and forth
  * can pick up rocks
  * can carry a number of rocks as long as their total weight is below a limit
  * can stack rocks
  * can engage in conversation with his Buds
  * can pick and consume mushrooms
  * has a mane which grows in length with his wisdom
* There is Icho who
  * holds on to Falaj's mane
  * joins the Fairies contained by a saturated Cairn
* There are Buds who
  * are stationary
  * each have a backstory which
    * has many segments, each of which
      * increases Falaj' wisdom when divulged
      * occupies a certain tier of intimacy which
        * has a divulgence likelihood which
          * expresses how likely a Bud is to divulge the segments it contains to a listener
          * varies with the mushroom-induced charisma of the listener
        * determines the amount by which Falaj's wisdom increases when it is divulged
  * divulge segments of their backstory to Falaj
* There are Fairies who
  * only appear at night at a rate which
    * varies with the brightness of the Moon
  * float aimlessly by default
  * float toward a Cairn if they are in its Fairy attraction radius
* There are Blue Spirits who
  * appear at saturated Cairns if Icho is present
  * are more likely to appear at larger Cairns
  * provide Falaj with Flowers
* There are Flowers which
  * can gain their holder entrance to the Wisdom Dispensary
* There is a Wisdom Dispensary which
  * is concealed
  * has an interior
  * appears to Falaj if he is carrying enough Flowers
  * may be entered
* There is Our Natural Father who
  * resides in the Wisdom Dispensary
  * Falaj can interact with one time before the Wisdom Dispensary disappears again
  * gives Falaj a Wisdom Nugget
