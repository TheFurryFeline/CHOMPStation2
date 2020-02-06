var/const/NETWORK_THIRD_DECK   = "Third Deck"
var/const/NETWORK_SECOND_DECK  = "Second Deck"
var/const/NETWORK_FIRST_DECK   = "First Deck"
var/const/NETWORK_SUPPLY       = "Supply"
var/const/NETWORK_MAIN_OUTPOST = "Main Outpost"
var/const/NETWORK_CARRIER  = "Exploration Carrier" //CHOMPedit: Exploration outpost cameras
var/const/NETWORK_XENOBIO = "Xenobiology"	//CHOMPStation Edit 17/1/20 TFF - Xenobio network addition
//
// Cameras
//

// Networks
/obj/machinery/camera/network/third_deck
	network = list(NETWORK_THIRD_DECK)

/obj/machinery/camera/network/second_deck
	network = list(NETWORK_SECOND_DECK)

/obj/machinery/camera/network/first_deck
	network = list(NETWORK_FIRST_DECK)

/obj/machinery/camera/network/main_outpost
	network = list(NETWORK_MAIN_OUTPOST)

/obj/machinery/camera/network/supply
	network = list(NETWORK_SUPPLY)

/obj/machinery/camera/network/carrier //CHOMPedit: Exploration carrier cameras
	network = list(NETWORK_CARRIER)

/obj/machinery/camera/network/research/xenobio	//CHOMPStation Edit 17/1/20 TFF - Xenobio network addition
	network = list(NETWORK_XENOBIO)
// ### Preset machines  ###

//CHOMPStation Edit Start 6/2/20 TFF - Add to presets rather than having camera_ch or computer_ch. Hopefully fixes Travis' screeching.
/obj/item/weapon/circuitboard/security/xenobio
	name = T_BOARD("xenobiology camera monitor")
	build_path = /obj/machinery/computer/security/xenobio
	network = list(NETWORK_XENOBIO)
	req_access = list()

/obj/machinery/computer/security/xenobio
	name = "xenobiology camera monitor"
	desc = "Used to access the xenobiology cell cameras."
	icon_keyboard = "mining_key"
	icon_screen = "mining"
	network = list(NETWORK_XENOBIO)
	circuit = /obj/item/weapon/circuitboard/security/xenobio
	light_color = "#F9BBFC"
//CHOMPStation Edit End

// #### Relays ####
// Telecomms doesn't know about connected z-levels, so we need relays even for the other surface levels.
/obj/machinery/telecomms/relay/preset/southerncross/d1
	id = "Station Relay 1"
	listening_level = Z_LEVEL_STATION_ONE
	autolinkers = list("d1_relay")

/obj/machinery/telecomms/relay/preset/southerncross/d2
	id = "Station Relay 2"
	listening_level = Z_LEVEL_STATION_TWO
	autolinkers = list("d2_relay")

/obj/machinery/telecomms/relay/preset/southerncross/d3
	id = "Station Relay 3"
	listening_level = Z_LEVEL_STATION_THREE
	autolinkers = list("d3_relay")

/obj/machinery/telecomms/relay/preset/southerncross/planet
	id = "Planet Relay"
	listening_level = Z_LEVEL_SURFACE
	autolinkers = list("pnt_relay")

/obj/machinery/telecomms/relay/preset/southerncross/cave
	id = "Cave Relay"
	listening_level = Z_LEVEL_SURFACE_MINE
	autolinkers = list("cve_relay")

/obj/machinery/telecomms/relay/preset/southerncross/wild
	id = "Wild Relay"
	listening_level = Z_LEVEL_SURFACE_WILD
	autolinkers = list("wld_relay")

/obj/machinery/telecomms/relay/preset/southerncross/transit
	id = "Wild Relay"
	listening_level = Z_LEVEL_TRANSIT
	autolinkers = list("tns_relay")

/obj/machinery/telecomms/relay/preset/southerncross/explorer //CHOMPedit: Tcomms relay for exploration carrier
	listening_level = Z_LEVEL_MISC
	autolinkers = list("exp_relay")

/obj/machinery/telecomms/relay/preset/belt_outpost // CHOMPedit: Tcomms relay for Belt Outpost
	id = "Belt Mining Relay"
	listening_level = Z_LEVEL_BELT
	autolinkers = list("belt_relay")

// #### Telecomms ####
/obj/machinery/telecomms/hub/preset/southerncross
	id = "Hub"
	network = "tcommsat"
	autolinkers = list("hub",
		"d1_relay", "d2_relay", "d3_relay", "pnt_relay", "cve_relay", "wld_relay", "tns_relay", "explorer", "exp_relay",
		"c_relay", "m_relay", "r_relay", "belt_relay", // Chompstation edit - adds belt outpost to relays
		"science", "medical", "supply", "service", "common", "command", "engineering", "security", "unused",
		"hb_relay", "receiverA", "broadcasterA"
	) //CHOMPedit: Adds "exp_relay"

/obj/machinery/telecomms/receiver/preset_right/southerncross
	freq_listening = list(AI_FREQ, SCI_FREQ, MED_FREQ, SUP_FREQ, SRV_FREQ, COMM_FREQ, ENG_FREQ, SEC_FREQ, ENT_FREQ, EXP_FREQ)

/obj/machinery/telecomms/bus/preset_two/southerncross
	freq_listening = list(SUP_FREQ, SRV_FREQ, EXP_FREQ)

/obj/machinery/telecomms/server/presets/service/southerncross
	freq_listening = list(SRV_FREQ, EXP_FREQ)
	autolinkers = list("service", "explorer")

/datum/map/southern_cross/default_internal_channels()
	return list(
		num2text(PUB_FREQ) = list(),
		num2text(AI_FREQ)  = list(access_synth),
		num2text(ENT_FREQ) = list(),
		num2text(ERT_FREQ) = list(access_cent_specops),
		num2text(COMM_FREQ)= list(access_heads),
		num2text(ENG_FREQ) = list(access_engine_equip, access_atmospherics),
		num2text(MED_FREQ) = list(access_medical_equip),
		num2text(MED_I_FREQ)=list(access_medical_equip),
		num2text(SEC_FREQ) = list(access_security),
		num2text(SEC_I_FREQ)=list(access_security),
		num2text(SCI_FREQ) = list(access_tox,access_robotics,access_xenobiology),
		num2text(SUP_FREQ) = list(access_cargo),
		num2text(SRV_FREQ) = list(access_janitor, access_hydroponics),
		num2text(EXP_FREQ) = list(access_explorer)
	)