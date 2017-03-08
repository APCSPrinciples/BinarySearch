import de.bezier.guido.*;
TargetButton [] targets = new TargetButton[20];
ArrayList <Integer> nums = new ArrayList <Integer>();
int numNums = int(random(900)+100);
int numToFind=int(random(numNums));
int numGuesses = 0;
boolean numFound = false;
public void setup()
{
  size(800, 300);
  textAlign(CENTER, CENTER);
  Interactive.make( this );
  while(nums.size()<20)
  {
    int num = int(random(numNums));
    if(!nums.contains(num))
      nums.add(num);
  }
  int[] numsArray = new int[20];
  for(int i = 0; i < 20; i++)
    numsArray[i] = nums.get(i);
  numsArray = sort(numsArray);
  for(int i = 0; i < 20; i++)
    nums.set(i,numsArray[i]);
  if (!nums.contains(numToFind) && random(1)<.5)
    while (!nums.contains(numToFind))
      numToFind=int(random(100));
  int i = 0;
  for (int x = 175; x< 775; x+=30)
  {
    targets[i] = new TargetButton(x, 30,nums.get(i) );
    new SearchButton(x, 70, i);
    i++;
  }
  
}
public void draw()
{
  background(192);
  fill(0);
  text("Number at [index]",120,40);
  text("[index]",150,80);
  textSize(32);
  text("Try to find: "+numToFind,140,160);
  text("Number of Guesses: "+numGuesses, 500, 160);
  if (numFound) 
    text("Number found after " + numGuesses + " guesses\nRefresh browser to play again", 400, 240);
  else if (notInList())
    text("Number not in list. Refresh browser to play again", 400, 240);
  textSize(10);
}
public class SearchButton
{
  private float x, y, width, height;
  private boolean clicked;
  private String label;
  private int index;
  public SearchButton ( int xx, int yy, int i )
  {
    width = height = 30;
    x = xx;
    y = yy;
    index = i;
    label = "["+(i+1)+"]";
    clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isClicked()
  {
    return clicked;
  }
  public void mousePressed () 
  {
    if (numFound || notInList()) return;
    if (clicked == false)
      numGuesses++;
    clicked = true;    
    targets[index].pressed();
    if (targets[index].value == numToFind)
      numFound = true;
    
    targets[index].pressed();
    if(targets[index].value < numToFind)
      tooLow(index,targets[index].value);
    else if(targets[index].value > numToFind)
      tooHigh(index,targets[index].value);
    
  }
  public void draw () 
  {    
    if (clicked)
      fill( 255 );
    else 
    fill( 150 );
    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
}

public class TargetButton
{
  private float x, y, width, height;
  private boolean clicked;
  private String label;
  private int value;

  public TargetButton ( int xx, int yy, int v )
  {
    width = height = 30;
    x = xx;
    y = yy;
    label = "";
    clicked = false;
    value = v;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isClicked()
  {
    return clicked;
  }
  public void mousePressed () {}
  public void pressed()
  {
    setLabel(""+value);
    clicked = true;
  }
  public void draw () 
  {    
    if (clicked)
    {
      if(value==numToFind)
        fill(255,255,0);
      else
        fill( 255 );
    }
    else 
    fill( 150 );
    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
}
public void tooLow(int pos, int val)
{
  for(int i = pos-1; i >= 0; i--)
    if(targets[i].label.equals("") || (val < Integer.parseInt(targets[i].label.substring(1)) && targets[i].label.substring(0,1).equals("<")))
      targets[i].setLabel("<"+val); 
}
public void tooHigh(int pos, int val)
{
  for(int i = pos+1; i < 20; i++)
    if(targets[i].label.equals("") || (val > Integer.parseInt(targets[i].label.substring(1))&& targets[i].label.substring(0,1).equals(">")))
      targets[i].setLabel(">"+val); 
}
public boolean notInList()
{
  for(int i = 0; i < 20; i++)
    if(targets[i].label.equals(""))
      return false;
  return true;
}
  