// Butterfly healer
// documentation
// Git

////////////////////////////////////////////////////////////

Game game;

static Flob_WindowBugAttack applet;

////////////////////////////////////////////////////////////

void setup()
{
  size(640, 480);
  
  applet = this;
  
  game = new Game(10, 1400);
}

void draw()
{
  if(game.getStatus() == Game.STATUS_PLAYING)
  {
    game.breed();
    
    game.draw();
    
    game.checkForBites();
    
    game.step();
  }

  if(game.getStatus() == Game.STATUS_DEAD)
  {
    game.drawDeadScreen();
  }
}

void mousePressed()
{
  if(game.getStatus() == Game.STATUS_PLAYING)
  {
    game.mousePressed(mouseX, mouseY, mouseButton, mouseEvent.getClickCount());
  }
  
  if(game.getStatus() == Game.STATUS_DEAD)
  {
    game.reset();
  }
}

void keyPressed()
{
  if(key == 'r')
  {
    game.reset();
  }
  
  if(key == 'X')
  {
    game.setStatus(Game.STATUS_DEAD);
  }
  
  if(key == 'q')
  {
    println("Goodbye!");
    
    exit();
  }
}

////////////////////////////////////////////////////////////

/*
class Butterfly extends WindowElement
{
}
*/

////////////////////////////////////////////////////////////

