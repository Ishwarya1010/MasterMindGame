package Model;

import java.util.Random;

public class GameLogic {
	public static final String[] colors = { "Blue", "Red", "Yellow", "Green", "Purple", "Orange" };

	public String[] generateRandomCode() {
		String[] randomCode = new String[5];

		Random generator = new Random();
		for (int rand = 0; rand < 4; rand++) {
			int index = generator.nextInt(colors.length);
			randomCode[rand] = colors[index];
		}
		return randomCode;
	}

	public int[] whiteAndBlackPegs(String[] selectedCode, String[] randomCode) {
		int[] blackAndWhitePegs = new int[2];
		for (int i = 0; i < 4; i++) {
			switch (selectedCode[i]) {
			case "Blue": {
				selectedCode[i] = "Blue";
				break;
			}
			case "Red": {
				selectedCode[i] = "Red";
				break;
			}
			case "Yellow": {
				selectedCode[i] = "Yellow";
				break;
			}
			case "Green": {
				selectedCode[i] = "Green";
				break;
			}
			case "Purple": {
				selectedCode[i] = "Purple";
				break;
			}
			case "Orange":
				selectedCode[i] = "Orange";

			}
		}
		int blackpegs = 0;
		for (int j = 0; j < 4; j++) {
			if (randomCode[j] == selectedCode[j]) {
				blackpegs++;
				randomCode[j] = "done";
				selectedCode[j] = "done";
			}
		}
		int whitePegs = 0;
		for (int k = 0; k < 4; k++) {
			if (randomCode[k] == "done") {
				continue;
			}
			for (int l = 0; l < 4; l++) {
				if (selectedCode[l] == "done") {
					continue;
				}
				if (randomCode[k] == selectedCode[l]) {
					whitePegs++;
					randomCode[k] = "done";
					selectedCode[l] = "done";
				}
			}
		}

		blackAndWhitePegs[0] = blackpegs;
		blackAndWhitePegs[1] = whitePegs;
		return blackAndWhitePegs;
	}
}
