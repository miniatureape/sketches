import java.util.ArrayList;

int width = 800;
int height = 600;
float period = (float) width * .50;
float amp = 30;
float vertPadding = (amp * 2) * .3;

int bgColor = color(252,247,211);
int strokeColor = color(222,232,190);

int[][][] freqList;

void setup() {
  size(width, height);
  smooth();
  
  background(bgColor);
  stroke(strokeColor);
  strokeWeight(1);
  
  freqList = createWaves();
  
  float yOff = amp * 2;
  
  for (int i = 0; i < freqList.length; i++) {
    yOff = yOff + (i * (amp * 2) + vertPadding);
       
    for (int j = 0; j < freqList[i].length; j++ ) {
      ComplexWave cWave = new ComplexWave();
      
      for (int k = 0; k < freqList[i][j].length; k++ ) {
        Wave wave = new Wave(freqList[i][j][k], amp, period);
        cWave.add(wave);
      }
      cWave.draw(center(width, period), yOff);      
    }
  }
  
  
}

int[][][] createWaves() {
  int[][][] freqList = {
    {
      {2},
      {1,3},
    },
    {
      {1},
      {1,7,9},
    },
    {
      {3},
      {5,4},
    },
  };
  return freqList;
}

float center(float outerWidth, float width) {
  return (outerWidth - width) / 2;
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
