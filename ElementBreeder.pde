static class ElementBreeder
{
  public static WindowElement breed(String type, float x, float y)
  {
    WindowElement loadedInstance = null;
    
    try
    {
      ClassLoader classLoader = ClassLoader.getSystemClassLoader();
      
      Class loadedClass = classLoader.loadClass("Flob_WindowBugAttack$" + type);

      java.lang.reflect.Constructor constructor = loadedClass.getConstructor(new Class[] {Flob_WindowBugAttack.class, float.class, float.class});

      loadedInstance = (WindowElement) constructor.newInstance(new Object[] {applet, x, y});
    }
    catch(ClassNotFoundException e1)
    {
      println("Class " + type + " could not be read!");

      loadedInstance = null;
    }
    catch(ClassCastException e2)
    {
      println("Class " + type + " is not a WindowElement!");
      
      loadedInstance = null;
    }
    finally
    {
      return loadedInstance;
    }
  }
}
