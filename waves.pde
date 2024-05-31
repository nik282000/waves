// Waves
// Set up the world and scale factor
float [][] ocean;
int ocean_width, ocean_height;
int scale = 4; // <--- Makes your pixels bigger

// Map ocean values 0-1 to 0-255 colour
color colour_map(float i){
  int b = int(i * 128) + 128;
  int s = int((1 - sq(i)) * 128) + 64;
  int h = int(i * 4) + 148;
  return color(h, s, b);
}

// Start the world
void init_ocean(){
  for(int y = 0; y < ocean_height; y++){
    for(int x = 0; x < ocean_width; x++){
      ocean[x][y] = random(0, 0.1);
    }
  }
}

// Do some crappy math!
void update_ocean(){
  float e; // Energy to be transfered from one pixel
  float l; // Energy to be transfered left
  float u; // Energy to be transfered up
  
  // Generate noise at bottom and left edge
  for(int xe = 0; xe < ocean_width; xe++){
    ocean[xe][ocean_height - 1] += random(0, 0.05);
  }
  for(int ye = 0; ye < ocean_height; ye++){
    ocean[ocean_width - 1][ye] += random(0, 0.05);
  }
  
  // Move energy from one cell to neighbouring cells, move negaive cells up from 0, add random energy points.
  for(int y = 0; y < ocean_height; y++){
    for(int x = 0; x < ocean_width; x++){    
      if(ocean[x][y] > 0){
        e = ocean[x][y] * random(0, 1); // Caclulate energy to move <--- Playing with this speeds up or slows down the wave propagation
        ocean[x][y] = ocean[x][y] - e; // Remove energy from cell, transfer to drawing
        l = e * random(0, 1); // Split energy between left and up <--- Playting with this changes the the angle of the wave propagation
        u = e - l; // up/down energy is the remainder

        // Add energy to neighbouring cells
        if(x > 0 && y > 0){
          ocean[x - 1][y] += l;
          ocean[x][y - 1] += u;
        }
      }
      
      // Move any cells with negative values up to 0
      if(ocean[x][y] < 0){
        ocean[x][y] = 0;
      }
      
      // Clamp any overacheivers to 1
      if(ocean[x][y] > 1){
        ocean[x][y] = 1;
      }
      
      // Add random sparkels
      if(random(0, 1) > 0.9999){ // <--- Playing with this changes the rate at wich sparkles spawn
        ocean[x][y] = 2;
      }
    }
  }
}

// Draw mworld to scale
void draw_ocean(){
  for(int y = 0; y < ocean_height; y++){
    for(int x = 0; x < ocean_width; x++){
      fill(colour_map(ocean[x][y]));
      square(x * scale, y * scale, scale);
    }
  }
}

void setup(){
  size(1024,768); // <--- Try to keep these a multiple of you scale number to prevent and ugly boarder
  colorMode(HSB, 255);
  noStroke();
  ocean_width = width / scale;
  ocean_height = height / scale;
  ocean = new float[ocean_width][ocean_height];
  init_ocean();
}

void draw(){
  update_ocean();
  draw_ocean();
}
