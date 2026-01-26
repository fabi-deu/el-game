// speeds for movement
hsp = 0;
vsp = 0;


// walking
walk_acceleration = 0.5;	// x += x*walk_acceleration
walk_max = 3;				// for clamping 
walk_friction = 0.6;		// x *= walk_friction for stopping slowly

// jumping
jump_height = -6.5;		// how high you jump
jump_cut = 0.4;				// jump release multiplier
gravity_up = 0.4;			// upwards movement sp
gravity_down = 0.2;			// downwards movement sp

// forgiveness timers in frame (make user feel better than reality = false happiness)
coyote_max = 6;				// allows for jumping after leaving the ledge
jump_buffer_max = 6;		// allows for jumping slightly before landing

coyote_timer = 0;
jump_buffer = 0;



// character states
enum PlayerState {
	IDLE,
	WALK,
	JUMP,
}
show_debug_message(image_speed);


state = PlayerState.IDLE
on_ground = false;
airborne = false;
facing = 1;

is_dead = false;
death_timer = 0; // frames to wait until ´room_reset();´
death_index = image_index;	 // frame of animation


window_enable_borderless_fullscreen(true);
window_set_fullscreen(true);
window_center();


platform_tiles = layer_tilemap_get_id("platform_tiles");
colliders = [
	layer_tilemap_get_id("dirt_tiles"),
	layer_tilemap_get_id("pebble_tiles"),
	oBricks,
	oBarrier
];


// dialogs
lock_step_event = false;
current_dialog = 0;
dialogs = {
	"Intro": [ // room 1
		{
			sprite: sEuryalusDialog,
			text:	"Liebe Lucretia,\nHoffnung und Heil meines Lebens hängen von dir ab.\nIch liebe dich mehr als mich selbst."
		}
	],
	"lucretias_villa": [ // room 2
		{
			sprite: sLucretiaDialog,
			text:	"Ich habe deinen Brief erhalten.\nDass du mich liebst, wundert mich gar nicht."
		},
		{
			sprite: sLucretiaDialog,
			text:	"Doch mit mir alleine zu sprechen ist unmöglich, es sei denn, du verwandelst dich in eine Schwalbe."
		},
		//{
		//	sprite: sLucretiaDialog,
		//	text: "So nehme diesen Ring als Geschenk."
		//},
		//
		{
			sprite: sEuryalusDialog,
			text:	"Es tut mir weh, dass du meine Liebe gering achtest.\nDu kannst mir nämlich leichter das Leben mit Worten rauben, als jener mit dem Schwert."
		},
		{
			sprite: sEuryalusDialog,
			text:	"Sag, dass du mich liebst, Lucretia!"
		},
		//
		{
			sprite: sLucretiaDialog,
			text:	"Ich möchte dir, wie du wünscht, Euryalus, meine Liebe schenken."
		},
		{
			sprite: sLucretiaDialog,
			text:	"Die Geschichten von Frauen, die Ausländer geliebt haben, jedoch schrecken mich ab."
		},
		//
		{
			sprite: sEuryalusDialog,
			text:	"Oh Lucretia, mach dir keine Sorge!"
		},
		{
			sprite: sEuryalusDialog,
			text:	"Es ist ungerecht, nach dem Verhalten einiger das ganze Geschlecht zu beurteilen."
		},
		{
			sprite: sEuryalusDialog,
			text:	"Ich schwöre dir meine Liebe, doch ein Dienst erfordert meine Anwesenheit für 2 Monate."
		}
	],
	"window": [ // window
		{
			sprite: sEuryalusDialog,
			text:	"Oh Lucretia, mein Stern der Liebe!",
		},
		{
			sprite: sLucretiaDialog,
			text:	"Oh mein Euryalus, lange trauerte ich wegen dir.\nDoch jetzt bist du zurück, mein Liebster.",
		},
		{
			sprite: sEuryalusDialog,
			text:	"Ich sterbe, wenn ich dich immer nur sehen, nie aber in meinen Armen halten darf.",
		},
		{
			sprite: sEuryalusDialog,
			text:	"Doch wir müssen aufpassen, der Kaiser ist verdächtig unserer Liebe.",
		},
		{
			sprite:	sLucretiaDialog,
			text:	"\n ..."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Geh Sosias, und sage Euryalus, dass der einzige Weg zu mir, sich in vier Tagen als Lasttäger beim Einbrigen des Getreides zu verkleiden, ist."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Er soll sich dabei zu mir ins Schlafzimmer schleichen!"
		}
	],
	
	"first_meeting": [
		{
			sprite:	sEuryalusDialog,
			text:	"Sei gegrüßt, mein Herz, sei gegrüßt, Hort meines Lebens, du meine Hoffnung."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Umarme mich!"
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Du bist wirklich da, Euryalus, du bist wirklich gekommen, Ärmster."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Jetzt weiß ich, dass du mich Liebst, denn du hast mir deine Liebe bewiesen."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Aber du wirst sehen, auch ich bin es imstande."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Niemand außer du wird mich besitzen, auch der nicht, den ich nach dem Gesetz meinen Gatten nennen muss."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"..."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Nehm dich in acht!\nMenelaos eilt bereits die Treppe hinauf!"
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Hier versteck dich unter dem Bett!"
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Ich Narr!\nNur mein Leichtsinn konnte mich verleiten, hierherzukommen!"
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Jetzt ertappen sie mich und ich verliere meine Ehre!"
		},
		//
		{
			sprite:	noone,
			text:	"\\CANCEL_DIALOG"
		},
		//
		{
			sprite:	sEuryalusDialog,
			text:	"wdwdwd"
		},
	]

};

