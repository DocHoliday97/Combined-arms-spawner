📄 README
Doc’s Combined Arms F10 Map Spawner
Overview

Doc’s Combined Arms F10 Map Spawner allows players to spawn drivable ground vehicles in-mission by placing a marker on the F10 map and typing the vehicle’s exact unit name.

When the marker text is entered, the script:

Detects the F10 mark

Reads the text (vehicle type)

Spawns the unit at that location

Removes the marker

If the vehicle is supported by Combined Arms and server permissions allow it, the unit can be driven immediately.

Requirements

DCS World

Combined Arms module (for driving)

Mission scripting enabled

Multiplayer server must allow map drawing

Player must be in:

Tactical Commander

Game Master

Or a CA-enabled ground role

How To Use

Join the correct coalition.

Open the F10 Map.

Place a marker.

Type the exact unit name (case sensitive).

Press Enter.

The vehicle will spawn at that location.

Example:

M-1 Abrams

Important Notes

Vehicle names must match DCS internal type names exactly.

Not all units are drivable.

Air defense components (like Patriot radar) will spawn but are not drivable.

The vehicle spawns for the coalition that placed the marker.

Marker is automatically removed after spawning.

Recommended Test Vehicles (US)

Use these to confirm everything works:

M-1 Abrams
M-2 Bradley
LAV-25
M-113
Hummer

Troubleshooting

If the unit spawns but cannot be driven:

✔ Ensure you are not a spectator
✔ Ensure Combined Arms is installed
✔ Ensure you are in a CA role (Game Master / Tactical Commander)
✔ Ensure the vehicle type supports driving

If the unit does not spawn:

✔ Check dcs.log for “SPAWN: FAILED”
✔ Verify unit name spelling
✔ Ensure mission scripting is enabled

Installation

Save the script as a .lua file.

Open Mission Editor.

Add a trigger:

Type: MISSION START

Action: DO SCRIPT FILE

Select the script file.

Save mission.

Multiplayer Setup

When hosting:

Enable Map Drawing in server settings

Ensure Combined Arms roles exist in the coalition

Ensure scripting is not blocked
