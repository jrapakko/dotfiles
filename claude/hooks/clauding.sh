#!/bin/bash
# Hook for UserPromptSubmit / Stop / SessionEnd: marks a session as busy
# so statusline.sh can show "Clauding…" (or another spinner verb) while
# Claude is working. One verb is picked per prompt and stored in the flag.
# Usage: clauding.sh on|off  (hook JSON on stdin)

dir="${XDG_RUNTIME_DIR:-/tmp}/claude-clauding"
session=$(jq -r '.session_id // empty')
[[ -z $session ]] && exit 0

# Claude Code's spinner verbs
verbs=(
    "Accomplishing" "Actioning" "Actualizing" "Architecting" "Baking"
    "Beaming" "Beboppin'" "Befuddling" "Billowing" "Blanching" "Bloviating"
    "Boogieing" "Boondoggling" "Booping" "Bootstrapping" "Brewing" "Bunning"
    "Burrowing" "Calculating" "Caramelizing" "Cascading" "Catapulting"
    "Cerebrating" "Channeling" "Choreographing" "Churning" "Clauding"
    "Coalescing" "Cogitating" "Combobulating" "Composing" "Computing"
    "Concocting" "Considering" "Contemplating" "Cooking" "Crafting"
    "Creating" "Crunching" "Crystallizing" "Cultivating" "Deciphering"
    "Deliberating" "Determining" "Dilly-dallying" "Discombobulating" "Doing"
    "Doodling" "Drizzling" "Ebbing" "Effecting" "Elucidating" "Embellishing"
    "Enchanting" "Envisioning" "Fermenting" "Fiddle-faddling" "Finagling"
    "Flambéing" "Flibbertigibbeting" "Flowing" "Flummoxing" "Fluttering"
    "Forging" "Forming" "Frolicking" "Frosting" "Gallivanting" "Galloping"
    "Garnishing" "Generating" "Gesticulating" "Germinating" "Gitifying"
    "Grooving" "Gusting" "Harmonizing" "Hashing" "Hatching" "Herding"
    "Honking" "Hullaballooing" "Hyperspacing" "Ideating" "Imagining"
    "Improvising" "Incubating" "Inferring" "Infusing" "Ionizing"
    "Jitterbugging" "Julienning" "Kerfuffling" "Kneading" "Leavening"
    "Levitating" "Lollygagging" "Manifesting" "Marinating" "Meandering"
    "Metamorphosing" "Misting" "Moonwalking" "Moseying" "Mulling"
    "Mustering" "Nebulizing" "Nesting" "Newspapering" "Noodling"
    "Nucleating" "Onioning" "Orbiting" "Orchestrating" "Osmosing"
    "Perambulating" "Percolating" "Perusing" "Philosophizing"
    "Photosynthesizing" "Polishing" "Pollinating" "Pondering"
    "Pontificating" "Pouncing" "Precipitating" "Prestidigitating"
    "Processing" "Proofing" "Propagating" "Puttering" "Puzzling"
    "Quantumizing" "Razzle-dazzling" "Razzmatazzing" "Recombobulating"
    "Reticulating" "Roosting" "Ruminating" "Sautéing" "Scampering"
    "Schlepping" "Scurrying" "Seasoning" "Shenaniganing" "Shimmying"
    "Simmering" "Skedaddling" "Sketching" "Slithering" "Smooshing"
    "Sock-hopping" "Spelunking" "Spinning" "Sprouting" "Stewing"
    "Sublimating" "Swirling" "Swooping" "Symbioting" "Synthesizing"
    "Tempering" "Thinking" "Thundering" "Tinkering" "Tomfoolering"
    "Topsy-turvying" "Transfiguring" "Transmogrifying" "Transmuting"
    "Twisting" "Undulating" "Unfurling" "Unraveling" "Vibing" "Waddling"
    "Wandering" "Warping" "Whatchamacalliting" "Whirlpooling" "Whirring"
    "Whisking" "Wibbling" "Working" "Wrangling" "Zesting" "Zigzagging"
)

case $1 in
    on)  mkdir -p "$dir" && echo "${verbs[RANDOM % ${#verbs[@]}]}" > "$dir/$session" ;;
    off) rm -f "$dir/$session" ;;
esac
exit 0
