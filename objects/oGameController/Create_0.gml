global.current_level_idx = 0;
global.levels = [
	Intro,
	lucretias_villa,
]



if (file_exists("save.ini")) {
    ini_open("save.ini");
    global.current_level_idx = ini_read_real("Progress", "Level", 0);
    ini_close();
} else {
    global.current_level_idx = 0;
}