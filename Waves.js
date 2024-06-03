var s;
var g_width;
var g_height
var w = [];

function init_w(){
  for (let x = 0; x < g_width; x++){
    w[x] = [];
    for (let y = 0; y < g_height; y++){
      w[x][y] = random(0, 0.05);
    }
  }
}

function draw_w(){
  for (let x = 0; x < g_width; x++){
    for (let y = 0; y < g_height; y++){
      fill(150, 128, (w[x][y] * 128) + 128);
      square(x*s, y*s, s);
    }
  }
}

function update_w(){
  var e;
  var l;
  var u;
  
  for (let xb = 0; xb < g_width; xb++){
    w[xb][g_height - 1] += random(0.05);
  }
  
  for (let yb = 0; yb < g_height; yb++){
    w[g_width - 1][yb] += random(0.05);
  }
  
  for (let x = 0; x < g_width; x++){
    for (let y = 0; y < g_height; y++){
      if (w[x][y] > 0){
        e = w[x][y] * random(0, 1);
        w[x][y] = w[x][y] - e;
        l = e * random(0, 1);
        u = e - l;
        
        if(x > 0 && y > 0){
          w[x-1][y] += l;
          w[x][y-1] += u;
        }
      }
      if(w[x][y] < 0){
        w[x][y] = 0;
      }

      if(w[x][y] > 1){
        w[x][y] = 1;
      }

      if(random(0, 1) > 0.999){
        w[x][y] = 1;
      }
    }
  }
}

function setup() {
  createCanvas(400, 400);
  colorMode(HSB, 256)
  noStroke();
  s = 5;
  g_width = width/s;
  g_height = height/s;
  
  init_w();
}

function draw() {
  background(220);
  draw_w();
  update_w();
}
