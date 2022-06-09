class Card{
  
  public String name;
  private String force;
  private String[] categories;
  public int[] stats;
  
  public Card(String n, String f, int yOB, int yOD, int w, int s, int l, int p){
    name = n;
    force = f;
    categories = new String[]{"Year of Birth", "Year of Death", "Leadership", "Warrior", "Strategy", "Personality"};
    stats = new int[]{yOB, yOD, w, s, l, p};
  }
  
  public void drawCard(float x, float y, boolean face){
    fill(0);
    rect(x, y, CARD_WIDTH + CARD_OUTLINE, CARD_HEIGHT - CARD_BEVEL + CARD_OUTLINE);
    rect(x, y, CARD_WIDTH - CARD_BEVEL, CARD_HEIGHT + CARD_OUTLINE);
    ellipse(x - (CARD_WIDTH - CARD_BEVEL) / 2, y - (CARD_HEIGHT - CARD_BEVEL) / 2, CARD_BEVEL + CARD_OUTLINE, CARD_BEVEL + CARD_OUTLINE);
    ellipse(x - (CARD_WIDTH - CARD_BEVEL) / 2, y + (CARD_HEIGHT - CARD_BEVEL) / 2, CARD_BEVEL + CARD_OUTLINE, CARD_BEVEL + CARD_OUTLINE);
    ellipse(x + (CARD_WIDTH - CARD_BEVEL) / 2, y - (CARD_HEIGHT - CARD_BEVEL) / 2, CARD_BEVEL + CARD_OUTLINE, CARD_BEVEL + CARD_OUTLINE);
    ellipse(x + (CARD_WIDTH - CARD_BEVEL) / 2, y + (CARD_HEIGHT - CARD_BEVEL) / 2, CARD_BEVEL + CARD_OUTLINE, CARD_BEVEL + CARD_OUTLINE);
    fill(face ? force.equals("Wei") ? #4000c0 : force.equals("Wu") ? #a00000 : force.equals("Shu") ? #008000 : force.equals("Jin") ? #00a0a0 : #b0b000 : #f0f090);
    rect(x, y, CARD_WIDTH, CARD_HEIGHT - CARD_BEVEL);
    rect(x, y, CARD_WIDTH - CARD_BEVEL, CARD_HEIGHT);
    ellipse(x - (CARD_WIDTH - CARD_BEVEL) / 2, y - (CARD_HEIGHT - CARD_BEVEL) / 2, CARD_BEVEL, CARD_BEVEL);
    ellipse(x - (CARD_WIDTH - CARD_BEVEL) / 2, y + (CARD_HEIGHT - CARD_BEVEL) / 2, CARD_BEVEL, CARD_BEVEL);
    ellipse(x + (CARD_WIDTH - CARD_BEVEL) / 2, y - (CARD_HEIGHT - CARD_BEVEL) / 2, CARD_BEVEL, CARD_BEVEL);
    ellipse(x + (CARD_WIDTH - CARD_BEVEL) / 2, y + (CARD_HEIGHT - CARD_BEVEL) / 2, CARD_BEVEL, CARD_BEVEL);
    fill(0);
    if(!face){
      textAlign(CENTER);
      textFont(font1, 30);
      text("TOP", x, y - 5);
      text("TRUMPS", x, y + 25);
      return;
    }
    image(loadImage(name.toLowerCase() + ".png"), x, y - 35);
    textAlign(CENTER);
    textFont(font1, 20);
    float w = textWidth(name);
    if(w > CARD_WIDTH - 20){
      textFont(font1, 20 * (CARD_WIDTH - 20) / w);
    }
    text(name, x, y - CARD_HEIGHT / 2 + 25);
    textFont(font2, 14);
    textAlign(LEFT);
    for(int i = 0; i < categories.length; i++){
      text(categories[categories.length - 1 - i], x - CARD_WIDTH / 2 + 10, y + CARD_HEIGHT / 2 - (10 + 16 * i));
    }
    textAlign(CENTER);
    for(int i = 0; i < stats.length; i++){
      text(i > stats.length - 3 && stats[stats.length - 1 - i] == 0 ? "n/a" : stats[stats.length - 1 - i] + "", x + CARD_WIDTH / 2 - 20, y + CARD_HEIGHT / 2 - (10 + 16 * i));
    }
  }
}
