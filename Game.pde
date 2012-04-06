class Game
{
  private int maxBugCount;
  
  private int bugCount;

  private int crackCount;

  private ArrayList elements;

  private float bugBreedLapse;

  private float lastBugBreedTime;
  
  private PImage backgroundImage;

  private int status;
  
  public static final int STATUS_PLAYING = 1;
  public static final int STATUS_DEAD = 2;

  public Game(int mbc, float bbl)
  {
    this.maxBugCount = mbc;
    
    this.bugBreedLapse = bbl;
    
    this.backgroundImage = loadImage("farm-fence.png");
    
    reset();
  }
  
  public void reset()
  {
    this.bugCount = 0;
    
    this.crackCount = 0;
    
    this.elements = new ArrayList();
    
    this.lastBugBreedTime = 0;
        
    this.status = Game.STATUS_PLAYING;
  }
  
  public void setStatus(int value)
  {
    this.status = value;
  }
  
  public int getStatus()
  {
    return this.status;
  }

  public void breed()
  {
    if(bugCount == maxBugCount)
    {
      return;
    }
    
    if(millis() >= this.lastBugBreedTime + this.bugBreedLapse)
    {
      elements.add(this.breedBug());
      
      bugCount ++;
      
      this.lastBugBreedTime = millis();
    }
  }
  
  private LadyBug breedBug()
  {
    float x = random(0, width);
    float y = random(0, height);

    LadyBug bug = (LadyBug) ElementBreeder.breed("LadyBug", x, y);    

    float[] fullSize = bug.getFullSize();

    if(bug.getX() > width - fullSize[0])
      bug.setX(width - fullSize[0]);

    if(bug.getY() > height - fullSize[1])
      bug.setY(height - fullSize[1]);

    return bug;
  }

  public void step()
  {
    for(int i=0; i<elements.size(); i++)
    {
      WindowElement e = (WindowElement) elements.get(i);
      
      e.step();
      
      if(e instanceof ShotMark && e.getStatus() == WindowElement.STATUS_REMOVE)
      {
        this.elements.remove(i);
        
        i --;
      }
    }
  }

  public void draw()
  {
    background(backgroundImage);
    
    for(int i=elements.size() - 1; i>=0; i--)
    {
      WindowElement e = (WindowElement) elements.get(i);
      
      e.draw();
    }
  }
  
  public void checkForBites()
  {
    for(int i=0; i<elements.size(); i++)
    {
      WindowElement e = (WindowElement) this.elements.get(i);
      
      if(e instanceof LadyBug && e.isSizeCompleted())
      {
        WindowCrack crack = (WindowCrack) ElementBreeder.breed("WindowCrack", e.getX(), e.getY());    
        
        this.elements.set(i, crack); 
        
        this.bugCount --;
        
        this.crackCount ++;
        
        if(this.crackCount == 10)
        {
          this.status = STATUS_DEAD;
        }
      }
    }
  }
  
  public void drawDeadScreen()
  {
    PImage deadBackground = loadImage("1294056173.png");

    PImage deadCrack = loadImage("crack.png");

    background(255, 0, 0);
    
    image(deadCrack, 0, 0, 640, 480);
    
    image(deadBackground, 0, 0);
    
    String message1 = "Press 'r' or click anywhere to restart";
    
    fill(255);
    
    textSize(20);
    
    textAlign(RIGHT);
    
    text(message1, 0, 10, width - 10, 50); 

    String message2 = "You are so dead, bugs bite you!";

    fill(216, 63, 216);
    
    textSize(40);
    
    textAlign(CENTER);
    
    text(message2, 0, height - 66, width, 66); 
  }
  
  public void mousePressed(float x, float y, int button, int clickCount)
  {
    ShotMark shot = (ShotMark) ElementBreeder.breed("ShotMark", x, y);
        
    if(button == RIGHT || clickCount > 1)
    {
      shot.setType(ShotMark.SHOTGUN);
    }
        
    this.elements.add(shot);
        
    for(int i=0; i<elements.size(); i++)
    {
      WindowElement e = (WindowElement) this.elements.get(i);
      
      if(e instanceof LadyBug && e.isHit(x, y))
      {
        this.elements.remove(i);
        
        this.bugCount --;
        
        if(shot.getType() == ShotMark.HANDGUN)
        {
          break;
        }
      }
    }
  }
}

