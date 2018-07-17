// Play a sine wave and display it on the screen
// inputs 1,2,4,5  a,q,w,e,r,t
// use mouse to set freq and amp
// use P or p to turn printing of mouseX on or off
// Based on http://code.compartmental.net/minim/oscil_method_setwaveform.html

/**
  * This sketch demonstrates how to create synthesized sound with Minim 
  * using an AudioOutput and an Oscil. An Oscil is a UGen object, 
  * one of many different types included with Minim. By using 
  * the numbers 1 thru 5, you can change the waveform being used
  * by the Oscil to make sound. These basic waveforms are the 
  * basis of much audio synthesis. 
  * 
  * For many more examples of UGens included with Minim, 
  * have a look in the Synthesis folder of the Minim examples.
  * 
  * For more information about Minim and additional features, 
  * visit http://code.compartmental.net/minim/
  */

import ddf.minim.*;
import ddf.minim.ugens.*;

import com.jogamp.newt.opengl.GLWindow;

Minim       minim;
AudioOutput out;
Oscil       wave;

boolean first = true;
float freq;
boolean print = false;


void setup()
{
  size(1000, 600, P3D);

  minim = new Minim(this);

  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();

  // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
  wave = new Oscil( 440, 0.5f, Waves.SINE );
  // patch the Oscil to the output
  wave.patch( out );
}

void draw() {
  GLWindow r = (GLWindow)surface.getNative();
  r.confinePointer(false);
  if (first == true) {

    r.warpPointer(81, height/2);  // start at this frequency
    first = false;
  }

  background(0);
  stroke(255);
  strokeWeight(3);

  // draw the waveform of the output
  for (int i = 0; i < out.bufferSize() - 1; i++)
  {
    line( i, height / 2  - out.left.get(i)*200, i + 1, height / 2  - out.left.get(i+1)*200 );

    if (mousePressed == true) {

      r.warpPointer(80, mouseY);
    }

    if (print == true) {
      println(mouseX);
    }

    //// draw the waveform we are using in the oscillator
    //stroke( 128, 0, 0 );
    //strokeWeight(4);
    //for( int i = 0; i < width-1; ++i )
    //{
    //  point( i, height/2 - (height*0.49) * wave.getWaveform().value( (float)i / width ) );
    //}
  }
}
void mouseMoved() {
  // usually when setting the amplitude and frequency of an Oscil
  // you will want to patch something to the amplitude and frequency inputs
  // but this is a quick and easy way to turn the screen into
  // an x-y control for them.

  float amp = map( mouseY, 0, height, 1, 0 );
  wave.setAmplitude( amp );

  freq = map( mouseX, 0, width, 110, 880 );
  wave.setFrequency( freq );
}

void keyPressed() { 

  GLWindow r = (GLWindow)surface.getNative();
  r.confinePointer(false);

  switch( key )
  {
  case '1': 
    wave.setWaveform( Waves.SINE );
    break;

  case '2':
    wave.setWaveform( Waves.TRIANGLE );
    break;

  //case '3':
  //  wave.setWaveform( Waves.SAW );
  //  break;

  case '4':
    wave.setWaveform( Waves.SQUARE );
    break;

  case '5':
    wave.setWaveform( Waves.QUARTERPULSE );
    break;

  case '=':
    r.warpPointer(pmouseX + 15, mouseY);
    break;

  case '+':
    r.warpPointer(pmouseX + 1, mouseY);
    break;

  case '-':
    r.warpPointer(pmouseX - 15, mouseY);
    break;

  case '_':
    r.warpPointer(pmouseX - 1, mouseY);
    break;

  case 'a':
    r.warpPointer(25, mouseY);
    break;


  case 'c':
    r.warpPointer(81, mouseY);
    break;


  case 'q':
    r.warpPointer(109, mouseY);
    break;

  case 'w':
    r.warpPointer(221, mouseY);
    break;

  case 'e':
    r.warpPointer(360, mouseY);
    break;

  case 'r':
    r.warpPointer(584, mouseY);
    break;
    
      case 't':
    r.warpPointer(864, mouseY);
    break;

  case 'p':
    print = true;
    break;

  case 'P':
    print = false;
    break;


  default: 
    break;
  }
}
