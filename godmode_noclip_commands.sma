#include <amxmodx>
#include <reapi>
#include <targetex>
#include <cromchat>

enum CommandLine
{
	TYPE = 0,
	VALUE
}

public plugin_init()
{
	register_plugin("Godmode & NoClip Commands", "1.0-ReAPI", "Huehue @ GatheredGaming.COM")
	
	register_clcmd("amx_godmode", "Command_Godmode", ADMIN_RCON, "<player|group> <on|off>")
	register_clcmd("amx_noclip", "Command_Noclip", ADMIN_RCON, "<player|group> <on|off>")

	CC_SetPrefix("&x04[GatheredGaming]&x01")
}

public Command_Godmode(id, iLevel, iCid)
{
	if (!cmd_access(id, iLevel, iCid, 2))
	{
		return PLUGIN_HANDLED
	}

	new szArgs[CommandLine][MAX_NAME_LENGTH], szTarget[MAX_NAME_LENGTH]
	read_argv(1, szArgs[TYPE], charsmax(szArgs[]))
	read_argv(2, szArgs[VALUE], charsmax(szArgs[]))

	new iPlayers[MAX_PLAYERS], iNum = cmd_targetex(id, szArgs[TYPE], iPlayers, szTarget, charsmax(szTarget), TARGETEX_NONE)

	if (!iNum)
	{
		return PLUGIN_HANDLED
	}

	if (szArgs[VALUE][0] == EOS)
	{
		client_print(id, print_console, "Please specify on or off..")
		return PLUGIN_HANDLED
	}

	static bool:bActivated
	bActivated = (equal(szArgs[VALUE], "on")) ? true : false

	for(new i; i < iNum; i++)
	{
		rg_set_user_godmode(iPlayers[i], bActivated ? true : false)
	}

	CC_SendMessage(0, "ADMIN &x03%n&x01: has toggled godmode &x04%s &x01for &x03%s", id, bActivated ? "on" : "off", szTarget)
	return PLUGIN_HANDLED
}

public Command_Noclip(id, iLevel, iCid)
{
	if (!cmd_access(id, iLevel, iCid, 2))
	{
		return PLUGIN_HANDLED
	}

	new szArgs[CommandLine][MAX_NAME_LENGTH], szTarget[MAX_NAME_LENGTH]
	read_argv(1, szArgs[TYPE], charsmax(szArgs[]))
	read_argv(2, szArgs[VALUE], charsmax(szArgs[]))

	new iPlayers[MAX_PLAYERS], iNum = cmd_targetex(id, szArgs[TYPE], iPlayers, szTarget, charsmax(szTarget), TARGETEX_NONE)

	if (!iNum)
	{
		return PLUGIN_HANDLED
	}


	if (szArgs[VALUE][0] == EOS)
	{
		client_print(id, print_console, "Please specify on or off..")
		return PLUGIN_HANDLED
	}

	static bool:bActivated
	bActivated = (equal(szArgs[VALUE], "on")) ? true : false

	for(new i; i < iNum; i++)
	{
		rg_set_user_noclip(iPlayers[i], bActivated ? true : false)
	}
	CC_SendMessage(0, "ADMIN &x03%n&x01: has toggled noclip &x04%s &x01for &x03%s", id, bActivated ? "on" : "off", szTarget)
	return PLUGIN_HANDLED
}


stock rg_set_user_godmode(id, godmode = false)
{
	if (godmode)
	{
		set_entvar(id, var_takedamage, DAMAGE_NO)
	}
	else
	{
		set_entvar(id, var_takedamage, DAMAGE_YES)
	}
}
stock rg_set_user_noclip(id, noclip = false)
{
	if (noclip)
	{
		set_entvar(id, var_movetype, MOVETYPE_NOCLIP)
	}
	else
	{
		set_entvar(id, var_movetype, MOVETYPE_WALK)
	}
}
