package Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.JSONArray;
import org.json.JSONObject;
import Model.GameLogic;

/**
 * Servlet implementation class MasterMindController
 */

public class MasterMindController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MasterMindController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/masterMind.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		GameLogic gameLogic = new GameLogic();
		StringBuilder sb = new StringBuilder();
		String[] computerCode = new String[4];
		BufferedReader reader = request.getReader();
		int rowCount = Integer.parseInt(request.getParameter("rowCount"));
		String line;
		while ((line = reader.readLine()) != null) {
			sb.append(line).append('\n');
		}
		String sbString = sb.toString();
		int l = sbString.length();
		sbString = sbString.substring(1, l - 2);
		sbString = sbString.replace("\"", "");
		String[] selectedColor = sbString.split(",");
		if (rowCount == 0) {
			computerCode = gameLogic.generateRandomCode();
			request.getSession().setAttribute("computerCode", computerCode);

		}
		String[] ans = (String[]) request.getSession().getAttribute("computerCode");
		String[] passingString = ans.clone();
		for (int i = 0; i < 4; i++)
			System.out.println(ans[i]);
		int[] blackAndWhitepegs = gameLogic.whiteAndBlackPegs(selectedColor, passingString);
		String res = "{\"blackpeg\":\"" + blackAndWhitepegs[0] + "\",\"whitepeg\":\"" + blackAndWhitepegs[1]
				+ "\",\"cc0\":\"" + ans[0] + "\",\"cc1\":\"" + ans[1] + "\",\"cc2\":\"" + ans[2] + "\",\"cc3\":\""
				+ ans[3] + "\"}";
		response.getWriter().print(res);
	}
}
