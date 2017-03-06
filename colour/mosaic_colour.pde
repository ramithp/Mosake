//Folder with files that will be used to generate tiles
String mosaicFolder = "";
//Base image to be turned into a mosaic
String mosaicFile = "";
//Final file name
String finalFileName = "xyz.png";
//Pixelation factor
int pixlFactor = 10;

/*
* A sketch to generate RGB normalized scores for images in a folder, rank them into 1000 different categories for scores.
* These 1000 images are then used to generate a new image that boxes pixels by the pixlFactor
*/
PImage baseImg;
PImage smaller;
PImage[] mosaicTiles;
float[] avgRGB;
PImage[] imageForRGBScore = new PImage[1000];

int w,h;

void setup(){
  size(5760, 3840);
  smooth();
  rectMode(CENTER);
  
  baseImg = loadImage(mosaicFile);
  
    w = baseImg.width/pixlFactor;
    h = baseImg.height/pixlFactor;
    
    smaller = createImage(w, h, RGB);
    
    //Copy the whole large image into a teeny image that is scaled down by the pixelation factor
    //This smaller image will be used to generate another blown up pixellated form of the original image that is "stretched" by pixelationFactor.
    smaller.copy(baseImg, 0, 0 , baseImg.width, baseImg.height, 0 ,0, w,h);
     
    File[] files = listFiles(sketchPath(mosaicFolder));
    
    //Override as required
    int fileCount = files.length;
    //int fileCount = files.length;
    mosaicTiles = new PImage[fileCount];
    avgRGB = new float[fileCount];
     
    
    //Process all mosaic tiles to draw with later
    for(int i = 0; i < mosaicTiles.length; i++){      
      // Load the image
      PImage img = loadImage(files[i].toString());
      
      // Shrink it down
      mosaicTiles[i] = createImage(pixlFactor, pixlFactor, RGB);
      mosaicTiles[i].copy(img, 0, 0, img.width, img.height, 0, 0, pixlFactor, pixlFactor);
      mosaicTiles[i].loadPixels();
      
     float avg = 0;
     for(int j = 0; j < mosaicTiles[i].pixels.length; j= j+1){
       avg += (getRGBNormalized(mosaicTiles[i].pixels[j]));
     }
     avg /= mosaicTiles[i].pixels.length;
     println(avg);
     avgRGB[i] = avg;    
  }
    
  for(int i = 0; i < imageForRGBScore.length; i++){
    float record = 1000;
    //Iterate through all images to find the one that is closest to 
    for (int j = 0; j < avgRGB.length; j++) {
      float diff = abs(i - avgRGB[j]);
      if (diff < record) {
        record = diff;
        imageForRGBScore[i] = mosaicTiles[j];
      }    
    } 
  }
}


void draw(){
   background(200);
  
  smaller.loadPixels();  
  //Iterate through every pixel and draw a square, thereby pixelating the image
  for(int x = 0; x < w; x++){
   for(int y = 0; y < h; y++){
     int loc = x + y*w;
     
     color c = smaller.pixels[loc]; 
     int imageIndex = int(getRGBNormalized(c));
     fill(c);
     noStroke();
     image(imageForRGBScore[imageIndex], x*pixlFactor, y*pixlFactor, pixlFactor, pixlFactor);
     //rect(x*pixlFactor, y*pixlFactor, pixlFactor, pixlFactor);
   }
  }  
   save(finalFileName);
}


//value is normalized between 0 and 1000
// Normalize by formula: x-min(x)/max(x)-min(x). Here, max(x) = sqrt(265^2 *3) = 458.99. Min = 0
int getRGBNormalized(color c){
 float unnormalized =  sqrt(sq(red(c)) + sq(blue(c)) + sq(green(c)));
 return round((unnormalized)*1000/458.99);
}

// Function to list all the files in a directory
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}