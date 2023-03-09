import de.bezier.guido.*;
public int NUM_ROWS = 25;
public int NUM_COLS = 25;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(700, 700);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
        buttons = new MSButton[NUM_ROWS][NUM_COLS];
    
    for(int r = 0; r < NUM_ROWS; r++) {
      for(int c = 0; c < NUM_COLS; c++)  {
        buttons[r][c] = new MSButton(r,c);  
      }
    }
    
    setMines();
}
public void setMines()
{ 
    int r = (int)(Math.random()*25);
    int c = (int)(Math.random()*25); 
    // generate random col
    for(int i = 0; i < 100; i++) {  
    if(!mines.contains(buttons[r][c])) 
    mines.add(buttons[r][c]); //mines.add(buttons[r][c])
    r = (int)(Math.random()*25);
    c = (int)(Math.random()*25); 
    }
  }

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    for(int r = 0; r < NUM_ROWS; r++) {
      for(int c = 0; c < NUM_COLS; c++)  {
        if(!buttons[r][c].clicked && !mines.contains(buttons[r][c])) {
          return false;
      }
    }
   }
    return true;
}
public void displayLosingMessage()
{
  for(int i = 0; i < NUM_ROWS; i++) {
    for(int j = 0; j < NUM_COLS; j++) {
      if(!buttons[i][j].clicked && mines.contains(buttons[i][j])) {
        buttons[i][j].flagged = false;
        buttons[i][j].clicked = true; 
          buttons[12][7].setLabel("Y");
          buttons[12][8].setLabel("O");
          buttons[12][9].setLabel("U");
          buttons[12][10].setLabel("L");
          buttons[12][11].setLabel("O");
          buttons[12][12].setLabel("S");
          buttons[12][13].setLabel("E");
      }
    }
  }
}

    
public void displayWinningMessage()
{
  buttons[12][7].setLabel("Y");
  buttons[12][8].setLabel("O");
  buttons[12][9].setLabel("U");
  buttons[12][10].setLabel("W");
  buttons[12][11].setLabel("I");
  buttons[12][12].setLabel("N");
  buttons[12][13].setLabel("!");  
}
public boolean isValid(int r, int c)
{
    if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS) {
    return true;
  }
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for(int r = row-1; r <= row+1; r++) {
    for(int c = col-1; c <= col+1; c++) {
      if(isValid(r,c) && mines.contains(buttons[r][c])) {
        numMines++;
      }
    }
  }
    if(mines.contains(buttons[row][col])) {
      numMines--;
    }

    return numMines;
}



public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 700/NUM_COLS;
        height = 700/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    { 
        clicked = true;
        if(mouseButton == RIGHT) {
          flagged = !flagged;
          if(flagged == false) {
            clicked = false;
          }
        }
         else if(mines.contains(this)) {
          displayLosingMessage();
        } 
          else if(countMines(myRow, myCol) > 0) {
          buttons[myRow][myCol].setLabel(countMines(myRow, myCol));
        }
        else {
            for(int r = myRow-1; r <= myRow+1; r++) {
          for(int c = myCol-1; c <= myCol+1; c++) { 
           if(isValid(r,c) && !buttons[r][c].clicked) {
              buttons[r][c].mousePressed();
           }
        }
     }
  } 
}
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) {
          frameRate(2);
            fill((int)(Math.random()*220), (int)(Math.random()*245), 260);
        }
        else if(clicked)
            fill(255, 215, 240);
        else 
            fill(210, 255, 226);

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }

}
