#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <csgomod>

#define PLUGIN	"CS:GO Music Kit"
#define AUTHOR	"Ted"

//These sounds are in arrays so we could match them with each other
new const MATCHPOINT[] = "sound/csgo_musickits/cs_stinger.wav"
new const MUSIC[][] =
{
	"startround_01.mp3",	//0
	"startround_02.mp3",	//1
	"startround_03.mp3",	//2
	"startaction_01.mp3",	//3
	"startaction_02.mp3",	//4
	"startaction_03.mp3",	//5
	"deathcam.mp3",		//6
	"bombplanted.mp3",	//7
	"bombtenseccount.mp3",	//8
	"roundtenseccount.mp3",	//9
	"wonround.mp3",		//10
	"lostround.mp3"		//11
}

// Setting task with their IDs so we can remove them later
enum (+= 100000)
{
    TASKID_ROUND_TEN = 100000, // start with 100000
    TASKID_BOMB_TEN
}

new player_cache[32], player_kit[32], player_folder[32][45];
new bool_firstround = 1, bool_endofround, bool_bomb_planted ;
new cvar_round_time, cvar_c4_time, cvar_freeze_time, cvar_windiff, cvar_winlimit;
new cvar_musickit_set;
new variant, tscore, ctscore, default_set;

public plugin_init() 
{
	register_plugin(PLUGIN, VERSION, AUTHOR);
	
	register_event("TextMsg", "Game_Commencing", "a", "2=#Game_Commencing", "2=#Game_will_restart_in")
	register_event("HLTV", "Event_New_Round", "a", "1=0", "2=0");
	register_message(get_user_msgid("TextMsg"),    "Event_End_Round");
	register_event("DeathMsg", "Event_Death", "a");
	register_logevent("Event_Start_Round", 2, "1=Round_Start");
	register_logevent("Event_Bomb_Planted", 3, "2=Planted_The_Bomb");
	register_logevent("Event_Round_Draw" , 4, "1=Round_Draw");
	register_logevent("Event_Bomb_Defused", 3, "2=Defused_The_Bomb");
	register_logevent("Event_BombTarget_Saved", 6, "3=Target_Saved") ;
	register_logevent("Remove_Tasks", 2, "1=Round_End");
	
	// CVARS
	cvar_round_time = get_cvar_pointer("mp_roundtime");
	cvar_c4_time = get_cvar_pointer("mp_c4timer");
	cvar_freeze_time = get_cvar_pointer("mp_freezetime");
	cvar_windiff = get_cvar_pointer("mp_windifference");
	cvar_winlimit = get_cvar_pointer("mp_winlimit");
	cvar_musickit_set = register_cvar("musickit_set", "1");

	default_set = get_pcvar_num(cvar_musickit_set);

	new client_cmds[32];
	for(new i = 0; i <= get_max_kits(); i++)
	{
		formatex(client_cmds, charsmax(client_cmds), "say /kit%d", i);
		server_print(client_cmds);
		register_clcmd(client_cmds, "ClientCommand_Select_Kit");
	}
}

public plugin_precache()
{
	new szFileToPrecache[64];
	new szFolderToPrecache[64];

	precache_generic(MATCHPOINT);

	for(new i = 1; i <= get_max_kits(); i++)
	{
		formatex(szFolderToPrecache, charsmax(szFolderToPrecache), "sound/csgo_musickits/%d", i);
		for(new j=1; j<sizeof(MUSIC); j++)
		{
			if (i == 1)
			{
				formatex(szFileToPrecache, charsmax(szFileToPrecache), "%s/CT/%s", szFolderToPrecache, MUSIC[j]);
				precache_generic(szFileToPrecache);
				formatex(szFileToPrecache, charsmax(szFileToPrecache), "%s/TER/%s", szFolderToPrecache, MUSIC[j]);
				precache_generic(szFileToPrecache);
			}
			else
			{
				formatex(szFileToPrecache, charsmax(szFileToPrecache), "%s/%s", szFolderToPrecache, MUSIC[j]);
				precache_generic(szFileToPrecache);
			}
		}
	}
}

public get_max_kits()
{
	new szFolderToPrecache[64];
	new maxkit = 1;
	for(new i = 1; i<= 99; i++)
	{
		formatex(szFolderToPrecache, charsmax(szFolderToPrecache), "sound/csgo_musickits/%d", i);
		if (dir_exists(szFolderToPrecache))
			maxkit = i;
		else
			break;
	}
	return maxkit;
}

public Game_Commencing()
{
	tscore = 0;
	ctscore = 0;
}

public ClientCommand_Select_Kit(id)
{
	static cmd[11];
	read_argv(1, cmd, 10);
	new num = str_to_num(cmd[4]);

	if(num <= 0)
	{
		player_kit[id] = 0;
		player_cache[id] = 0;
		client_cmd(id, "mp3 stop");
		client_print(id, print_chat, "Music Kit disabled");
		return
	} else player_cache[id] = num;
	
	client_print(id, print_chat, "Music Kit set to %d.", num);
	client_print(id, print_center, "Music Kit will change next round.");
}

public Event_New_Round()
{
	// Resetting some values for later
	bool_endofround = 0;
	bool_bomb_planted = 0;
	Remove_Tasks();
	
	new players[32], num;
	get_players(players, num, "c");
	for (new i = 1; i < num + 1; i++)
	{
		if(bool_firstround == 1)
		{
			player_cache[i] = default_set;
			player_kit[i] = player_cache[i];
		}
		else
			player_kit[i] = player_cache[i];
	}
	
	if(get_pcvar_num(cvar_winlimit) >= 1)
		if(tscore >= get_pcvar_num(cvar_winlimit) - 1 || ctscore >= get_pcvar_num(cvar_winlimit) - 1)
			Match_Point;
	
	if(get_pcvar_num(cvar_freeze_time) <= 2)
	{
		variant = random_num(0,2);
		return
	}
	
	variant = random_num(0,2);
	Play_Music(0 + variant, 0, 0);

}

public Event_Start_Round()
{
	if(bool_endofround == 1)
		return
	
	Play_Music(3 + variant, 0, 0);
	new Float:SecUntilRoundEnd = float((get_pcvar_num(cvar_round_time) * 60) - 10); // We calculate when there's only ten seconds left of round time
	set_task(SecUntilRoundEnd, "Round_Ten_Seconds_Left", TASKID_ROUND_TEN); // Setting task to play sound when only ten seconds of round time is left
}

public Round_Ten_Seconds_Left()
{
	if(bool_endofround == 1)
		return

	// If is already planted, function is ignored
	if(bool_bomb_planted == 1)
		return
	
	Play_Music(9, 0, 0);
}

public Event_Bomb_Planted()
{
	if(bool_endofround == 1)
		return
	
	bool_bomb_planted = 1;
	remove_task(TASKID_ROUND_TEN);
	
	Play_Music(7, 0, 0);
	
	new Float:SecUntilExplosion = float(get_pcvar_num(cvar_c4_time) - 10); // Calculating when ten seconds is left on the C4 timer
	set_task(SecUntilExplosion, "Bomb_Ten_Seconds_Left", TASKID_BOMB_TEN); // Sets tasks when ten seconds of C4 timer is left 
}

public Bomb_Ten_Seconds_Left()
{
	if(bool_endofround == 1)
		return

	Play_Music(8, 0, 0);
}

public Event_End_Round(id)
{
	// We get what type of End Round we have...
	static textmsg[22];
	get_msg_arg_string(2, textmsg, charsmax(textmsg));
	
	//...and play the appropriate sound to each player according to their team
	
	if(equali(textmsg, "#Terrorists_Win")) //Terrorists Wins
		Play_Music(10, 1, 1);
	
	else if(equali(textmsg, "#CTs_Win")) //Counter-Terrorists Wins
		Play_Music(10, 2, 1);
	
	else if(equali(textmsg, "#Target_Bombed")) //C4 explodes, eliminates target
		Play_Music(10, 1, 1);
		
	else if(equali(textmsg, "#Hostages_Not_Rescued")) //Time ran out and hostages not rescued
		Play_Music(10, 1, 1);
	
	else if(equali(textmsg, "#VIP_Assassinated") || equali(textmsg, "#VIP_Not_Escaped")) //VIP killed or time ran out and VIP has not escaped
		Play_Music(10, 1, 1);
	
	else if(equali(textmsg, "#VIP_Escaped")) //VIP escapes
		Play_Music(10, 2, 1);
}

// Plays victory sound for CT when C4 is defused
public Event_Bomb_Defused(id)
{
	if(bool_endofround == 1)
		return
		
	Play_Music(10, 2, 1); 
}

// Plays victory sound for CT when target has not been bombed
public Event_BombTarget_Saved(id)
{
	Play_Music(10, 2, 1); 
}

public Event_Round_Draw()
{
	Play_Music(11, 0, 1);
}

public Event_Death()
{
	if(bool_endofround == 1)
		return

	new id = read_data(2) // Getting index of player who just died
	
	Format_Music_Folder(id);
	if (player_kit[id] > 0) 
		client_cmd(id, "mp3 play ^"%s%s^"", player_folder[id], MUSIC[6]);
}

public Remove_Tasks()
{
	//Removing set tasks
	remove_task(TASKID_ROUND_TEN);
	remove_task(TASKID_BOMB_TEN);
}

public Play_Music(music, team, end)
{
	if(end == 1)
	{
		if(team == 1)
			tscore = tscore + 1;
		else if(team == 2)
			ctscore = ctscore + 1;
	}

	new players[32], num;
	get_players(players, num, "c");
	for (new i = 1; i < num + 1; i++)
	{
		if (player_kit[i] == 0) continue;
		client_cmd(i, "MP3Volume 100");
		Format_Music_Folder(i);
		if(end == 1)
		{
			if(team) // If one team wins
			{
				if(get_user_team(i) == team)
					client_cmd(i, "mp3 play ^"%s%s^"", player_folder[i], MUSIC[10]);
				else
					client_cmd(i, "mp3 play ^"%s%s^"", player_folder[i], MUSIC[11]);
			}
			else // When no one wins, everybody loses
				client_cmd(i, "mp3 play ^"%s%s^"", player_folder[i], MUSIC[11]);
			
			bool_endofround = 1;
			bool_bomb_planted = 0;
			Remove_Tasks();
			
			// The 1st round is when players are still connecting and game has not commenced.
			// To prevent the sound from playing after that, we do this check
			if(bool_firstround == 1)
			{
				bool_firstround = 0;
				return
			}
		}
		else
			client_cmd(i, "mp3 play ^"%s%s^"", player_folder[i], MUSIC[music]);
	}
}

stock Format_Music_Folder(id)
{
	new iFolder[45];
	
	if(player_kit[id] == 1)
	{
		if(CsTeams:get_user_team(id) == CS_TEAM_T)
			formatex(iFolder, charsmax(iFolder), "sound/csgo_musickits/1/TER/");
		else if(CsTeams:get_user_team(id) == CS_TEAM_CT)
			formatex(iFolder, charsmax(iFolder), "sound/csgo_musickits/1/CT/");
		else
			formatex(iFolder, charsmax(iFolder), "sound/csgo_musickits/1/CT/");
	}
	else if(player_kit[id] >> 1)
		formatex(iFolder, charsmax(iFolder), "sound/csgo_musickits/%d/", player_kit[id]);
		
	player_folder[id] = iFolder;
}

stock Match_Point()
{
	new windiff, score_dif = tscore - ctscore;
	
	if(score_dif <= -1)
		score_dif = score_dif * -1;

	if(get_pcvar_num(cvar_windiff) >= 2)
		windiff = get_pcvar_num(cvar_windiff) - 1;
	
	if(score_dif >= windiff)
	{
		client_cmd(0,"spk %s", MATCHPOINT);
		set_task(0.5, "MatchPoint_Txt");
	}
}

public MatchPoint_Txt()
{
	set_hudmessage(255, 255, 255, -1.0, 0.40, 0, 3.0, 3.5, 1.5, 2.0, 4);
	show_hudmessage(0, "MATCH POINT");
}
