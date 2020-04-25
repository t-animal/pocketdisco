# Usage

## Powering on
Simply plug in in the power plug. The disco will boot and after a while you'll hear some beeps and a voice. The disco is now ready.

## Playing songs
Press the shiny red button. Duh.

## Powering off
Press the shiny red button. Wait until the song is almost over (abou 15 seconds). Then press and hold the red button until you hear some beeps and a voice. The disco will now shut down. Unfortunately there is no way to tell if the disco has completely shut down. However after 5 minutes or so the disco is normally shut down. You can now pull the power plug.

# Contributing
Want a song in the disco? Sure, if it fits the set! Send a ~15 second snippet as wav to tilman-disco@t-animal.de. No guarantees that it will be included.

# Administration

## Commands
  * Volume: `alsamixer` to set volume then `sudo alsactl store 0`
  * Get debugging log: `journalctl -rb disco.service`

## Debugging
As the disco runs as a systemd service, check `journalctl -rb disco.service` in case of problems.

## Folder structure
Put all files belonging to a feature set into a folder as .wav-files. Put that folder into the `/dj-sets` folder. To select a dj-set, symlink it to `dj-sets/current`.

Here's a sample:

```
.
├── disco.sh
├── pulseaudio.service
├── disco.service
└── dj-sets
    ├── current -> ./dj-sets/disco
    ├── party.wav
    ├── poweroff.wav
    ├── disco/
    │   ├── stayin_alive.wav
    │   ├── barbara-streisand.wav
    │   ├── i_will_survive.wav
    │   ├── ymca.wav
    │   ├── rickroll.wav
    │   ├── i_wanna_dance.wav
    │   └── nightfever.wav
    └── karneval/
        ├── atemlos.wav
        ├── polonaise.wav
        ├── knall-rotes-gummiboot.wav
        ├── supergeile-zick.wav
        ├── pferd-aufm-flur.wav
        ├── viva-frankonia.wav
        ├── holzmichel.wav
        ├── holz.wav
        ├── fliegerlied.wav
        └── moskau.wav
```