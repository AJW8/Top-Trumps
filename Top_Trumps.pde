final int CARDS = 28;
final int CARD_WIDTH = 250 / 44 * 31;
final int CARD_HEIGHT = 250;
final int CARD_BEVEL = 20;
final int CARD_OUTLINE = 2;
Player[] players;
int turn;
ArrayList<Card> deck;
Card[] play;
ArrayList<Card> hold;
boolean started;
boolean playing;
boolean drawn;
boolean played;
boolean finished;
PFont font1;
PFont font2;

void setup(){
  size(1180, 650);
  players = new Player[]{new Player("Player 1"), new Player("Player 2"), new Player("Player 3"), new Player("Player 4")};
  deck = new ArrayList<Card>();
  String[] input = loadStrings("Cards.txt");
  for(String line : input){
    String[] split = split(line, ",");
    if(split.length == 8){ 
      deck.add((int)random(deck.size()), new Card(split[0], split[1], Integer.parseInt(split[2]), Integer.parseInt(split[3]), Integer.parseInt(split[4]), Integer.parseInt(split[5]), Integer.parseInt(split[6]), Integer.parseInt(split[7])));
    }
  }
  for(int i = 0; i < CARDS; i++){
    Card card = deck.get((int)random(deck.size()));
    players[(i + 1) % players.length].addCard(card);
    deck.remove(card);
  }
  turn = 0;
  play = new Card[players.length];
  hold = new ArrayList<Card>();
  started = false;
  playing = false;
  drawn = false;
  played = false;
  finished = false;
  font1 = createFont("viner hand itc", 1);
  font2 = createFont("tempus sans itc", 1);
  noStroke();
  rectMode(CENTER);
  ellipseMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
}

void draw(){
  background(#f0f0a0);
  textAlign(CENTER);
  noStroke();
  for(int i = 0; i < players.length; i++){
    Player player = players[i];
    int count = player.getHandCount();
    float endX = width / 2 + (20 + CARD_WIDTH * 1.5) * (i % 3 == 0 ? -1 : 1);
    float startX = endX + (CARD_WIDTH * (count - 1)) * (i % 3 == 0 ? -1 : 1);
    startX = startX < 10 + CARD_WIDTH / 2 ? 10 + CARD_WIDTH / 2 : startX > width - (10 + CARD_WIDTH / 2) ? width - (10 + CARD_WIDTH / 2) : startX;
    float y = i < 2 ? 10 + CARD_HEIGHT / 2 : height - (10 + CARD_HEIGHT / 2);
    for(int j = 0; j < count; j++){
      Card card = player.getCard(j);
      if(card != null){
        card.drawCard(count == 1 ? endX : startX + j * (endX - startX) / (count - 1), y, false);
      }
    }
    fill(0);
    textFont(font1, 20);
    textAlign(i % 3 == 0 ? LEFT : RIGHT);
    text(player.name + (player.out ? " (out)" : ""), i % 3 == 0 ? 20 : width - 20, i < 2 ? 40 + CARD_HEIGHT : height - (30 + CARD_HEIGHT));
  }
  if(finished){
    textAlign(CENTER);
    fill(0);
    textFont(font2, 40);
    text(players[turn].name + " wins the game!", width / 2, height / 2 - 10);
    textFont(font2, 20);
    text("Press any key to restart", width / 2, height / 2 + 30);
  }
  else if(started){
    if(hold.size() > 0){
      Card card = hold.get(0);
      for(int i = 0; i < players.length; i++){
        float x = width / 2 + (10 + CARD_WIDTH / 2) * (i % 3 == 0 ? -1 : 1);
        float y = i < 2 ? 10 + CARD_HEIGHT / 2 : height - (10 + CARD_HEIGHT / 2);
        if(!players[i].out && card != null){
          card.drawCard(x, y, false);
        }
      }
    }
    for(int i = 0; i < players.length; i++){
      float x = width / 2 + (10 + CARD_WIDTH / 2) * (i % 3 == 0 ? -1 : 1);
      float y = i < 2 ? 10 + CARD_HEIGHT / 2 : height - (10 + CARD_HEIGHT / 2);
      Card card = play[i];
      if(card != null){
        card.drawCard(x, y, true);
      }
    }
    textAlign(CENTER);
    fill(0);
    textFont(font2, 40);
    text(played ? players[turn].name + " wins the hand!" : playing ? "Press a key from 1-6 to choose a stat:" : drawn ? "It's a draw! " + players[turn].name + " goes again." : players[turn].name + ", your turn.", width / 2, height / 2 + 10);
  }
  else{
    textAlign(CENTER);
    fill(0);
    textFont(font1, 80);
    text("TOP", width / 2, height / 2 - 40);
    text("TRUMPS", width / 2, height / 2 + 30);
    textFont(font2, 20);
    text("Press any key to start.", width / 2, height / 2 + 80);
  }
}

void keyPressed(){
  if(finished){
    finished = false;
    Player player = players[turn];
    player.shuffleHand();
    Card card = player.popCard();
    while(card != null){
      deck.add(card);
      card = player.popCard();
    }
    turn = 0;
    for(int i = 0; i < CARDS; i++){
      Card c = deck.get(0);
      players[(i + 1) % players.length].addCard(c);
      deck.remove(0);
    }
    for(Player p : players){
      p.out = false;
    }
  }
  else if(started){
    if(played){
      played = false;
      Player winner = players[turn];
      for(Card card : hold){
        if(card != null){
          winner.addCard(card);
        }
      }
      hold = new ArrayList<Card>();
      for(int i = 0; i < players.length; i++){
        Card card = play[(turn + i) % play.length];
        if(card != null){
          winner.addCard(card);
        }
      }
      play = new Card[players.length];
      finished = true;
      for(int i = 1; i < players.length; i++){
        Player player = players[(turn + i) % players.length];
        if(player.getHandCount() == 0){
          player.out = true;
        }
        else{
          finished = false;
        }
      }
    }
    else if(playing){
      if(key < 49 || key > 54){
        return;
      }
      int[] numbers = new int[players.length];
      int stat = key - 49;
      if(stat < 2 & play[turn].stats[stat] == 0){
        return;
      }
      playing = false;
      for(int i = 0; i < players.length; i++){
        Card card = i == turn ? play[turn] : players[i].popCard();
        numbers[i] = card == null ? 0 : card.stats[stat];
        if(i != turn){
          play[i] = card;
        }
      }
      int max = 0;
      for(int i : numbers){
        if(i > max){
          max = i;
        }
      }
      boolean b = false;
      int winner = -1;
      for(int i = 0; i < numbers.length; i++){
        if(numbers[i] == max){
          if(b){
            drawn = true;
            return;
          }
          else{
            b = true;
            winner = i;
          }
        }
      }
      turn = winner;
      drawn = false;
      played = true;
    }
    else{
      if(drawn){
        for(Card card : play){
          hold.add(card);
        }
      }
      play = new Card[players.length];
      playing = true;
      Player player = players[turn];
      Card card = player.popCard();
      play[turn] = card;
    }
  }
  else{
    started = true;
    turn = 0;
  }
}
