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
	oBarrier,
	layer_tilemap_get_id("brick_tiles"),
];
show_debug_message(layer_tilemap_get_id("brick_tiles"));

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
		}
	],
	"first_meeting_2": [
		{
			sprite:	sLucretiaDialog,
			text:	"Komm heraus, Euryalus, Geliebter."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Jetzt ist alles sicher, jetzt können wir ungestört miteinander sprechen, einander umarmen!"
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Nie habe ich solche Angst ausgestanden, aber du verdienst es."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Jetzt wollen wir die Frucht unserer Liebe genießen."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Oh es ist eine Sünde."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Ein Glück, das man genießen kann, nicht zu genießen."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Sollte ich nun die Gunst der Stunde ungenutzt vorübergehen lassen?"
		},
	],
	"alley": [
		{
			sprite:	sEuryalusDialog,
			text:	"Oh Lucretia, meine Liebste, in welche Gefahren ich mich nur begebe, um dich endlich wieder in den Armen zu halten."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Lass uns diese Liebe genießen, mein Euryalus!"
		},
		{
			sprite:	sLucretiaDialog,
			text:	"\n ..."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Versteck dich und fliehe! Mein Gatte ist zurück, ich werde ihn ablenken."
		},
	],
	
	"passage": [
		{
			sprite:	sEuryalusDialog,
			text:	"Lucretias Gatte war nach unserer letzten Begegnung wohl misstrauisch."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Ich muss einen anderen Weg zu der Frucht meines Lebens finden."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Meine letzte Hoffnung ist es, ihrem Verbündetem Pandalus meine Liebe zu gestehen."
		},
	],
	"last_meeting": [
		{
			sprite:	sEuryalusDialog,
			text:	"Lucretia, mein Herz, sei gegrüßt."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Umarme mich!"
		},
		// lucretia fällt um
		{
			sprite:	noone,
			text:	"\\LUCRETIA_PASSING_OUT"
		},
		//
		{
			sprite:	sEuryalusDialog,
			text:	"Lucretia!? Lucretia!?"
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Es wäre todeswürdig, jetzt wegzulaufen und diese Frau in ihrem Elend zu verlassen."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Bleibe ich aber, so kann einer aus der Familie kommen, und dann bin ich verloren."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Oh unselige Liebe, in welche Gefahren hast du mich nicht schon gebracht?"
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Es fehlte nur noch, dass du mir diese Frau in meinen Armen entseelst."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"\n ..."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Warum hörst du mich nicht?"
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Warum antwortest du nicht?"
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Öffne die Augen - bitte - und sieh mich an."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Wenn du sterben wolltest, warum hast du mir nichts gesagt, auf dass wir zusammen gestorben wären?"
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Verliere ich dich auf diese Weise?"
		},
		// lucretia waking up
		{
			sprite:	noone,
			text:	"\\LUCRETIA_WAKE_UP"
		},		
		//
		{
			sprite:	sLucretiaDialog,
			text:	"Weh mir, Euryalus, wo bin ich gewesen?"
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Warum hast du mich nicht hinscheiden lassen?"
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Ich war dabei, glücklich in deinen Armen zu sterben."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Oh, könnte ich nur so dahingehen, bevor du diese Stadt verläßt."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Du bist mein Ganymed, mein Hippolytos, mien Diomedes."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Lass uns diese Nacht zur süßesten jemals machen."
		},
	],
	"passage_2": [
		{
			sprite:	sLucretiaDialog,
			text:	"Wenn mein Herz Dir zürnen könnte, wäre ich böse auf Dich, dass du mir deine Abreiße verschwiegen hast."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Warum hast du mir verheimlicht, dass der Kaiser mit dir aufbrechen will?"
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Was soll ich Arme dann tun?"
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Wenn du mich verlässt, lebe ich keine zwei Tage mehr."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Ich verlange nicht, dass Du bleiben sollst, sondern dass Du mich mitnimmst."
		},
		{
			sprite:	sLucretiaDialog,
			text:	"Du brauchst nicht zu glauben, es sei für Dich eine Schande: auch Paris hat seine Helena geraubt."
		},
		//
		{
			sprite:	sEuryalusDialog,
			text:	"Ich habe es Dir, liebe Lucretia, bisher verschwiegen, damit Du Dich nicht vor der Zeit grämst."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Der Kaiser wird die Stadt nicht für immer verlassen, sondern wieder hierher zurückkehren."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Fasse also Mut und sei stark, mein Herz."
		},
		{
			sprite:	sEuryalusDialog,
			text:	"Gerne würde ich dich mitnehmen, aber wir müssen mehr an Deine Ehre als an meine Leidenschaft denken."
		}
	],
	"outro": [
		{
			sprite:	noone,
			text:	"Und so reiste Euryalus nur wenige Tage später mit dem Kaiser nach Rom."
		},
		{
			sprite:	noone,
			text:	"Doch dort befiel ihn ein heftiges Fieber."
		},
		{
			sprite:	noone,
			text:	"Nur mit großen Anstrengungen gelang es den Ärtzen, ihn am Leben zu halten."
		},
		{
			sprite:	noone,
			text:	"Aber kein Aznei half Euryalus mehr als ein Brief Lucretias, der ihm zeigte, dass sie am Leben und wohl behalten war."
		},
		{
			sprite:	noone,
			text:	"Als der Kaiser nach Perugia weiterzog, musste er freilich noch in Rom bleiben. Dann kam er, obwohl noch schwach und abgemagert, nach Siena."
		},
		{
			sprite:	noone,
			text:	"Aber er konnte Lucretia nur sehen, nicht sprechen."
		},
		{
			sprite:	noone,
			text:	"Doch nach drei Tagen wurde die Abreise gemeldet."
		},
		{
			sprite:	noone,
			text:	"Nie war ihr Zusammensein so süß gewesen, wie nun der Abschied schmerzte."
		},
		{
			sprite:	noone,
			text:	"Unsere Lucretia nun brach wie leblos zusammen, nachdem Euryalus ihren Blick entschwunden war."
		},
		{
			sprite:	noone,
			text:	"Sie ging nur noch in Schwarz, man hörte sie nicht mehr singen und lachen."
		},
		{
			sprite:	noone,
			text:	"In diesem Zustand verharrte sie einige Zeit, dann wurde sie Krank und ihre trostlose Seele enfloh diesem grausamen Leben."
		},
		{
			sprite:	noone,
			text:	"Aber Euryalus konnte sich nicht trennen, so folgte ihm Lucretia in seinen Träumen und ließ ihn keine Nacht ruhen."
		},
		{
			sprite:	noone,
			text:	"Und als er von ihrem Tod erfuhr, zog er, von Schmerz überwältigt, Trauerkleider an."
		},
		{
			sprite:	noone,
			text:	"..."
		},
		{
			sprite:	noone,
			text:	"So endet die wahre Geschichte einer unglücklichen Liebe."
		},
		{
			sprite:	noone,
			text:	"Ihre Leser mögen sich daran ein Beispiel nehmen und den Becher der Liebe nicht zu trinken verlangen."
		},
		{
			sprite:	noone,
			text:	"Euryalus und Lucretia\nWien, den 3. Juli 1444"
		},
		{
			sprite:	noone,
			text:	"\\EXIT" // exit game
		}
	],
};

