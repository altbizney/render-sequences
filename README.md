# Render Frame Sequences

A collection of scripts we use to take a large batch of frame sequences and render them into lossless video files.

## License

These scripts are provided under an MIT license. They are not supported by Thinko. Use at your own risk.

## Setup

- All frames should be in directories like `./input/<ID>`, where "ID" represents a shot number.
- Sequences will be automatically resorted to be sequential, starting from 0, matching the format `<ID>_<5-zero padded sequence>.png`
- Sequences will be output at `./output/<ID>.mov`

If you get a permissions error running the scripts, try making them executable:

    chmod u+x *.sh

## Process

- Populate the `./input` directory with numbered sub-directories containing shots to render
- `cd` to this folder and run `./loop.sh`

## Notes

Frame sequences are renamed in place, so for maximum safety you should run the `./loop.sh` script on a separate copy.

If an output file already exists at `./output/<ID>.mov`, that frame sequence will be skipped. This allows you to re-run the script easily. If you want to rerender a sequence, just delete the output and run `./loop.sh` again.

If you exit the script while `ffmpeg` is running, the incomplete render will not be cleaned up. And, given the previous point, will not be re-rendered. Be sure to clean up manually if this happens.

Frame sequences will only be resorted if both of the following criteria are not met:
- `input/<ID>_<00000>.png` is present
- `input/<ID>_<zero-base frame count>.png` is the final file (e.g. if there are 50 frames, the final file is `<ID>_00049.png`)
