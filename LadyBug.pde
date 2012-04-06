public class LadyBug extends WindowElement
{
  public LadyBug(float x, float y)
  {
    super(x, y);
    
    this.image = loadImage("jilagan_Ladybug.png");
  }

  public void draw()
  {
    // rect(x, y, width, height);
    image(this.image, x, y, width, height);
  }
 
  public void stepHandler()
  {
    grow();
  }  
  
  public float[][] getAvailableSizes()
  {
    return new float[][] {
      {80, 65},
      {110, 89},
      {140, 114},
      {170, 138},
      {200, 163},    
      {230, 187}    
    };
  }
  
  public float getTickLapse()
  {
    return 2777;
  }
}
