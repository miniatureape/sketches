import processing.pdf.*;
import java.util.ArrayList;

int width = 200;
int height = 20000;
float period = 100;
float amp = 10;

int bgColor = color(252,247,211);
int strokeColor = color(222,232,190);

void setup() {
  size(width, height, PDF, "sinewaves.pdf");
  smooth();
  
  background(bgColor);
  stroke(strokeColor);
  strokeWeight(1);
  
  createWaves(makeWaveData());
  
  println("Done");
  exit();
}

void createWaves(int[][][] waveData) {
  float yOff = amp * 2;
  
  for (int i = 0; i < waveData.length; i++) {
   
    for (int j = 0; j < waveData[i].length; j++ ) {
      ComplexWave cWave = new ComplexWave();
      
      for (int k = 0; k < waveData[i][j].length; k++ ) {
        Wave wave = new Wave(waveData[i][j][k], amp, period);
        cWave.add(wave);
      }
      
      cWave.draw(center(width, period), yOff);      
    }
    
    yOff += 50;
  }
}

class ComplexWave {
  ArrayList<Wave> components;
  
  public ComplexWave() {
    this.components = new ArrayList();
  }
  
  public void add(Wave wave) {
    components.add(wave);
  }
  
  public void draw(float x, float y) {
    pushMatrix();
    translate(x, y);
    this.drawWaves();
    popMatrix();
  }
  
  public void drawWaves() {
    float prevx = 0;  
    float prevy = 0;

    for (float x = 0; x < period; x++) {
      float percent = (x / period);
      float wy = 0;
      
      for (int i = 0; i < this.components.size(); i++) {
        Wave w = this.components.get(i);
        wy += sin(percent * (TWO_PI * w.freq));
      }
      
      float y = wy * amp;
    
      line(prevx, prevy, x, y);
    
      prevx = x;
      prevy = y;
    }
  }
}

class Wave {
  float freq;
  float amp;
  float period;
  
  public Wave(float freq, float amp, float period) {
    this.freq = freq;
    this.amp = amp;
    this.period = period;
  }
  
  public void draw(float x, float y) {
    pushMatrix();
    translate(x, y);
    this.drawWave(this.freq, this.amp, this.period);
    popMatrix();
  }
  
  public void drawWave(float freq, float amp, float period) {
    float prevx = 0;  
    float prevy = 0;

    for (float x = 0; x < period; x++) {
      float percent = (x / period);
      float y = sin((percent * (TWO_PI * freq))) * amp;
    
      line(prevx, prevy, x, y);
    
      prevx = x;
      prevy = y;
    }
  }
  
}

float center(float outerWidth, float width) {
  return (outerWidth - width) / 2;
}

int[][][] makeWaveData() {
  int[][][] waveData = new int[100][1][100];
  for (int i = 1; i < 100; i++) {
    for (int j = 1; j < i; j++) {
      waveData[i][0][j] = j;
    }
  }
  return waveData;
}

/*
int[][][] waveData = {
  {
    {1},
  },
  {
    {1,2},
  },
  {
    {1,2,3},
  },
  {
    {1,2,3,4},
  },
  {
    {1,2,3,4,5},
  },
  {
    {1,2,3,4,5,6},
  },
  {
    {1,2,3,4,5,7},
  },
};
*/
