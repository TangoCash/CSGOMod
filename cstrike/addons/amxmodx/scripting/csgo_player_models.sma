#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <csgomod>

#define PLUGIN "CS:GO Player Model"
#define AUTHOR "Ted"

public plugin_init()
{
    register_plugin(PLUGIN, VERSION, AUTHOR);
    register_event("ResetHUD", "set_players_models", "be");
}

public plugin_precache()
{
	new szFileToPrecache[64];
	new const szDefaultModels[][] = {"", "csgo_urban", "csgo_terror", "csgo_leet", "csgo_arctic", "csgo_gsg9",
				"csgo_gign", "csgo_sas", "csgo_guerilla", "csgo_vip", "csgo_militia", "csgo_spetsnaz" };

	for(new i=1; i<sizeof(szDefaultModels); i++)
	{
		formatex(szFileToPrecache, charsmax(szFileToPrecache), "models/player/%s/%s.mdl", szDefaultModels[i], szDefaultModels[i]);
		precache_model(szFileToPrecache);
	}
}

public set_players_models(player)
{
    new players[32];
    new modelname[32];
    new modelname_csgo[32];
    new num;

    get_players(players,num,"h");

	for(--num;num>=0;num--)
	{
		cs_reset_user_model(players[num])
		cs_get_user_model(players[num], modelname, 31)
		//server_cmd ("say [model] before  %s", modelname)
		formatex(modelname_csgo, charsmax(modelname_csgo), "csgo_%s", modelname);
		cs_set_user_model(players[num], modelname_csgo);
		//cs_get_user_model(players[num], modelname, 31)
		//server_cmd ("say [model] after  %s", modelname)
	}
}
