GameController controller;
GameSimulator simulator;

float SCALE = 300f;
void setup(){
	/*
	 * Define the teams for the current match here
	 */
	controller = new GameController(new Match(
		// Team A Class
		CustomTeamA.class,
		// Team B Class
		CustomTeamB.class,
		// Number of robots on each side
		2
	));

	controller.getSimulator().setFieldSize(2.44f, 1.82f);

	size((int)controller.getWidth(SCALE) + 200, (int)controller.getHeight(SCALE)+100);
}

void draw(){
	
	background(255);

	controller.run();

	translate(100, 0);
	controller.draw(this, SCALE);
	translate(-100, 0);
}

public void mouseDragged(){
	controller.moveBallToSpot(new PVector((mouseX - 100) / SCALE, (mouseY - 100) / SCALE));
}

public void keyPressed(){

	if(key == ' '){
		if(controller.isRunning()){
			System.out.println("Pausing game...");
			controller.pauseGame();
		}else{
			System.out.println("Starting game...");
			controller.resumeGame();
		}
	}else if(key == 'i'){
		controller.resetGame();
		controller.resumeGame();
	}else if(key == 'r'){
		controller.restartPositions();
	}else if(key == 'd'){
		String debug = "DEBUG:";
		debug += "\nisRunning:"+controller.isRunning();
		debug += "\nController Robots:"+controller.robots.size();
		for(Robot r:controller.robots)
			debug += "\n\t"+r+" ["+r.position.x+","+r.position.y+"]";

		debug += "\nSimulatables:"+controller.getSimulator().simulatables.size();
		for(Simulatable r:controller.getSimulator().simulatables)
			debug += "\n\t"+r;

		System.out.println(debug);
	}

}

