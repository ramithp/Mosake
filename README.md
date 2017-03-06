# Mosake
Collection of processing sketches to create a photo-mosaics

## Usage:
Modify the first few lines of the sketch before running
```
mosaicFolder = //The folder with tile images
mosaicFile = //File to be mosaic'd
String finalFileName = //Final file name
int pixlFactor = //Pixelation/scaling factor
```
Hit run and wait. :)

## Example: Usage with subset of 4984 images from Oxford flower 102 category flower data-set 
### Raw Image to be mosaic'd
![raw_image](https://cloud.githubusercontent.com/assets/11968702/23606779/3cc398b2-0288-11e7-9a66-4e81af3e07e3.jpg)

### Pixelation factor of 30
![pixel30](https://cloud.githubusercontent.com/assets/11968702/23606770/337bbd52-0288-11e7-91ee-9a29b3191099.png)

### Pixelation factor of 10
![pixel10](https://cloud.githubusercontent.com/assets/11968702/23606769/336a67dc-0288-11e7-883f-b2f23a02b92f.png)

### Pixelation factor of 3
![pixel3](https://cloud.githubusercontent.com/assets/11968702/23606768/334b1e68-0288-11e7-9582-570c99723249.png)

## Troubleshooting:
Out of memory: Use fewer images/give processing more memory via preferences.
