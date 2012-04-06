class WindowCrack extends WindowElement
{
  public WindowCrack(float x, float y)
  {
    super(x, y);
    
    this.image = loadImage("crack.png");
  }

  public void draw()
  {
    image(this.image, x, y, width, height);
  }
 
  public void stepHandler()
  {
    return;
  }  
  
  public float[][] getAvailableSizes()
  {
    return new float[][] {
      {200, 120}    
    };
  }
  
  public float getTickLapse()
  {
    return 0;
  }
}
