String state;
int player;

int player_1_wins;
int player_2_wins;

String player_1;
String player_2;

String start;
String end;
String game;

int winner;

String [] board;

String [] victory;

PFont font;

void init() {
  
  start = "start";
  end = "end";
  game = "game";
  
  state = start;
  
  winner = 0;
  player_1_wins=0;
  player_2_wins=0;
  
  board = new String[9];
  font = createFont("Verdana", 16, true);
  
  player_1 = Math.round(random(1, 2))==1  ? "O" : "X";
  player_2 = player_1 =="X" ? "O" : "X";

  super.init();
}
  
void setup() {
  frame.setTitle("Tic tac toe");
  
  size(640,480);
  background(0);  
}

void draw() {
  if(state == start) {
    draw_start();
  } else if (state == game) {
    draw_game();
  } else if (state == end) {
    draw_end();
  }
}

void mousePressed() {
  if(state == start) {
    click_start();
  } else if (state == game) {
    click_game();
  } else if (state == end) {
    click_end();
  }
}

void draw_start() {
  background(100,100,200);
  
  textAlign(CENTER);
  textFont(font);
  fill(0);
  text("Tic tac toe\n\nBy Jeremy Rich", 320, 400);
  
  noStroke();
  fill(200,200,100);
  rect(200, 156, 240, 64);
  
  textFont(font, 32);
  fill(0);
  text("START GAME", 320, 200);
}

void click_start() {
  if(
    mouseX > 200 &&
    mouseX < 440 &&
    mouseY > 156 && 
    mouseY < 220
  ) {
    state = game;
    player = Math.round(random(1, 2));
  }
}

void draw_game() {
  background(100,100,200);
  
  textAlign(CENTER);
  textFont(font);
  fill(0);
  text("TIC TAC TOE", 320, 40);
  
  text("Player " + (player == 1 ? "one's" : "two's") + " turn.", 320, 440);
  text("Player 2\n\n" + player_2_wins, 570, 60);
  text("Player 1\n\n" + player_1_wins, 70, 60);
  
    
  draw_board();
}

void click_game() {
  int cell = 10;
  
  int x = 140;
  int y = 50;
  
  int index = 0;
  
  while(index < 9) {
    if(
      mouseX > x &&
      mouseX < x+120 && 
      mouseY > y &&
      mouseY < y+120
    ) {
      cell = index; 
    }
    
    x = x + 120;
    
    if(x > 380) {
      x = 140;
      y = y + 120;
    }
    
    
    index = index + 1; 
  }  
  
  if(cell < 10 && board[cell] == null) {    
    board[cell] = player == 1 ? player_1 : player_2;
    
    player = player == 1 ? 2 : 1;
  }
  
  check_end();
}

void draw_end() {
  background(100,100,200);
  
  textAlign(CENTER);
  textFont(font);
  fill(0);
  text("TIC TAC TOE", 320, 40);
  
  draw_board();
  
  String text;
  
  if(winner == 0) {
    text = "The game ended in a draw!"; 
  } else {
    text = "Player " + (winner == 1 ? "one" : "two") + " was victorious!";
    
  }
  
  fill(255);
  
  text(text, 320, 440);
    
  noStroke();
  fill(200,200,100);
  rect(200, 156, 240, 64);
  
  textFont(font, 32);
  fill(0);
  text("NEW GAME", 320, 200);
}

void click_end() {
  if(
    mouseX > 200 &&
    mouseX < 440 &&
    mouseY > 156 && 
    mouseY < 220
  ) {
    state = game;
    player = Math.round(random(1, 2));
    
    player_1 = Math.round(random(1, 2))==1  ? "O" : "X";
    player_2 = player_1 =="X" ? "O" : "X";
    
    winner = 0;
    
    board = new String[9];
  }
}

void draw_board() {
  draw_map();
  
  int index = 0;
  
  int x = 140;
  int y = 50;
  
  while(index < 9) {
    String piece = board[index];
    
    if(piece == "X") {
      draw_x(x, y);
    } else if (piece == "O") {
      draw_o(x, y);
    }
    
    x = x + 120;
    
    if(x > 380) {
      x = 140;
      y = y + 120;
    }
    
    index = index + 1;
  }
}

void draw_map() {
  stroke(0);
  strokeWeight(4);
  
  line(260,50,260,410);
  line(380,50,380,410);
  line(140,170,500,170);
  line(140,290,500,290);
}

void draw_x(int x, int y) {
  stroke(200,100,100);
  strokeWeight(4);
  
  x = x + 10;
  y = y + 10;
  
  line(x, y, x+100, y+100);
  line(x+100, y, x, y+100);
}

void draw_o(int x, int y) {
  stroke(100,200,100);
  strokeWeight(4);
  noFill();
  
  x = x + 10;
  y = y + 10;
  
  ellipseMode(CORNERS);
  ellipse(x, y, x+100, y+100);
}

void check_end() {
  check_lines();
  
  int index = 0;
  int filled = 0;
  
  while(index < 9) {
    if(board[index] != null) {
      filled++; 
    }
    
    index = index + 1; 
  }
  
  if(filled == 9 || winner > 0) {
    state = end;
  }
}

void check_lines() {
  int x_count = 0;
  int o_count = 0;
  
  int index = 0;
  
  String[][] possibilites = {
    {board[0],board[1],board[2]},
    {board[3],board[4],board[5]},
    {board[6],board[7],board[8]},
    
    {board[0],board[3],board[6]},
    {board[1],board[4],board[7]},
    {board[2],board[5],board[8]},
    
    {board[0],board[4],board[8]},
    {board[6],board[4],board[2]}
  };
  
  while( index < possibilites.length ) {
    String[] possibility = possibilites[index];
    
    if(all_same(possibility) && possibility[0] != null) {
      String the_winner = possibility[0];
      
      if(player_1 == the_winner) {
        winner = 1;
        player_1_wins++;
      } else {
        winner = 2; 
        player_2_wins++;
      }
      
      
      return;
    }
    
    index = index+1;
  }
}

boolean all_same(String[] check) {
  int index = 0;
  
  String value = "none";
   
  while( index < check.length ) {
    if(value == "none") {
      value = check[index]; 
    }
    
    if(value != check[index]) {
      return false; 
    }
    
    index = index + 1;
  }
 
  return true; 
}
