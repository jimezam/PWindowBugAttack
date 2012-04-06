class ShotMark extends WindowElement
{
  private int type;
  
  public static final int HANDGUN = 1;
  public static final int SHOTGUN = 2;
  
  public ShotMark(float x, float y)
  {
    super(x, y);
    
    float[][] as = getAvailableSizes();
    
    this.x = this.x - as[0][0] / 2;
    this.y = this.y - as[0][1] / 2;
    
    this.setType(ShotMark.HANDGUN); 
  }
  
  public void setType(int type)
  {
    this.type = type;
    
    switch(type)
    {
      case ShotMark.HANDGUN:
        this.image = loadImage("1327192289.png");
      break;

      case ShotMark.SHOTGUN:
        this.image = loadImage("bullet_holes.png");
      break;

      default:
        this.setType(ShotMark.HANDGUN);
      break;
    }
  }
  
  public int getType()
  {
    return this.type;
  }

  public void draw()
  {
    image(this.image, x, y, width, height);
  }
 
  public void stepHandler()
  {
    this.status = WindowElement.STATUS_REMOVE;
  }  
  
  public float[][] getAvailableSizes()
  {
    return new float[][] {
      {110, 114}    
    };
  }
  
  public float getTickLapse()
  {
    return 7000;
  }
}
