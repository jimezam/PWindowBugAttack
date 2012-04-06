abstract class WindowElement
{
  protected float x;
  protected float y;
  protected float width;
  protected float height;
  protected int currentSize;
  protected PImage image;
  protected float lastTic;
  protected int status;
  
  public static final int STATUS_DEFAULT = 1;
  public static final int STATUS_REMOVE  = 2;
  
  public WindowElement()
  {
    this.currentSize = 0;
    this.lastTic = 0;
    this.status = WindowElement.STATUS_DEFAULT; 
  }
  
  public WindowElement(float x, float y)
  {
    this.setLocation(x, y);    

    this.currentSize = 0;
    this.lastTic = 0;
    this.status = WindowElement.STATUS_DEFAULT; 
  }
  
  public WindowElement(float x, float y, float w, float h)
  {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;

    this.currentSize = 0;
    this.lastTic = 0;
    this.status = WindowElement.STATUS_DEFAULT; 
  }
  
  public void setLocation (float x, float y)
  {
    float[][] as = this.getAvailableSizes();

    this.x = x;
    this.y = y;

    this.width = as[currentSize][0];
    this.height = as[currentSize][1];
  }

  public void setX(float value)
  {
    this.x = value;
  }
  
  public void setY(float value)
  {
    this.y = value;
  }
  
  public float getX()
  {
    return this.x;
  }
  
  public float getY()
  {
    return this.y;
  }
  
  public abstract void draw();
 
  public void step()
  {
    if(this.getTickLapse() == 0)
      return;
    
    if(this.lastTic == 0)
    {
      this.lastTic = millis();
      return;
    }

    if(millis() >= this.lastTic + this.getTickLapse())
    {
      this.lastTic = millis();
    
      stepHandler();
    }    
  }

  public abstract void stepHandler();

  public abstract float[][] getAvailableSizes();  

  public abstract float getTickLapse();

  public boolean isSizeCompleted()
  {
    float[][] as = getAvailableSizes();
    
    if(this.currentSize == as.length - 1)
      return true;
      
    return false;
  }
  
  public float[] getFullSize()
  {
    float[][] as = getAvailableSizes();
    
    if(as.length == 0)
      return null;
      
    return new float[]{
      as[as.length - 1][0],
      as[as.length - 1][1]
    };
  }

  public void grow()
  {
    if(this.isSizeCompleted())
      return;
      
    float previousWidth = this.width;
    float previousHeight = this.height;  
      
    this.currentSize ++;
    
    float[][] as = getAvailableSizes();

    this.width = as[currentSize][0];
    this.height = as[currentSize][1];
    
    this.x = this.x - (this.width - previousWidth) / 2;
    this.y = this.y - (this.height - previousHeight) / 2;
  }

  public boolean isHit(float x, float y)
  {
    return x >= this.x && x <= this.x + this.width &&
           y >= this.y && y <= this.y + this.height;
  }

  public int getStatus()
  {
    return this.status;
  }  
}
