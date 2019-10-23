public class Snake {

  public static final int RIGHT=0, LEFT=1, UP=2, DOWN=3;

  private ArrayList<Pos> parts;
  private final int cellSize;
  private int currentDir=RIGHT, lastX, lastY;
  private boolean isAlive = true;
  private long lastUpdate;
  private int updateFrq = 100;
  private int hue = 0;

  public int x, y;

  public Snake(int cellSize) {
    this.cellSize = cellSize;
    parts = new ArrayList<Pos>();
    parts.add(new Pos(0, 10));
    lastUpdate = millis() - updateFrq;
  }

  void changeDir(int dir) {
    switch(dir) {
    case RIGHT:
      lastX = parts.get(0).x + 1;
      lastY = parts.get(0).y;
      currentDir = RIGHT;
      break;
    case LEFT:
      lastX = parts.get(0).x - 1;
      lastY = parts.get(0).y;
      currentDir = LEFT;
      break;
    case UP:
      lastY = parts.get(0).y - 1;
      lastX = parts.get(0).x;
      currentDir = UP;
      break;
    case DOWN:
      lastY = parts.get(0).y + 1;
      lastX = parts.get(0).x;
      currentDir = DOWN;
      break;
    }
    //println("lastX : "+lastX+" / lastY : "+lastY);
  }

  public void kill() {
    isAlive = false;
  }

  public boolean isAlive() {
    return isAlive;
  }

  public void addPart() {
    parts.add(new Pos(lastX, lastY));
  }

  public void setPos(int x, int y) {
    lastX=x; 
    lastY=y;
  }

  public void draw() {
    if (!isAlive)
      return;
      
     boolean update = false;
    if (millis() - lastUpdate > updateFrq) {
      update = true;
      changeDir(currentDir);
      lastUpdate = millis();
    }
    
    colorMode(HSB,255);
    fill(hue++ % 255,255,255);
    int tmp, i=0;
    for (Pos part : parts) {
      rect(part.x *cellSize, part.y *cellSize, cellSize, cellSize);
      //swap
      if (update) {
        tmp = part.x;
        part.x = lastX;
        lastX = tmp;
        tmp = part.y;
        part.y = lastY;
        lastY = tmp;
      }
      if (part.x == parts.get(0).x && part.y == parts.get(0).y && i!=0) {
        kill();
        return;
      }
      i++;
    }
    x=parts.get(0).x; 
    y=parts.get(0).y;
    colorMode(RGB);
  }

  public class Pos {
    public int x=0, y=0;
    public Pos(int _x, int _y) {
      x=_x; 
      y=_y;
    }
  }
}
