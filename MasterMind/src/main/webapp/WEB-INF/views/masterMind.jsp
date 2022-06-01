<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MasterMind Game</title>
<style>
.emptycircle {
	height: 40px;
	width: 40px;
	background-color: #bbb;
	border-radius: 50%;
	display: inline-block;
}

.emptypeg {
	height: 10px;
	width: 10px;
	background-color: #bbb;
	border-radius: 50%;
	display: inline-block;
}

.blackpeg {
	height: 10px;
	width: 10px;
	background-color: black;
	border-radius: 50%;
	display: inline-block;
}

.whitepeg {
	height: 10px;
	width: 10px;
	background-color: white;
	border-radius: 50%;
	display: inline-block;
}

.bluecircle {
	height: 40px;
	width: 40px;
	background-color: blue;
	border-radius: 50%;
	display: inline-block;
}

.redcircle {
	height: 40px;
	width: 40px;
	background-color: red;
	border-radius: 50%;
	display: inline-block;
}

.yellowcircle {
	height: 40px;
	width: 40px;
	background-color: yellow;
	border-radius: 50%;
	display: inline-block;
}

.greencircle {
	height: 40px;
	width: 40px;
	background-color: green;
	border-radius: 50%;
	display: inline-block;
}

.purplecircle {
	height: 40px;
	width: 40px;
	background-color: purple;
	border-radius: 50%;
	display: inline-block;
}

.orangecircle {
	height: 40px;
	width: 40px;
	background-color: orange;
	border-radius: 50%;
	display: inline-block;
}
</style>
<script>
	var rowCounter = 0;
	var cellCounter = 0;
	var selectedColor = [];
	var computerColor = [];
	var blackpegVal;
	var whitepegval;
	function CreateTable() {
		var table = document.createElement('table');
		table.setAttribute("id", "mytable");
		table.setAttribute("style", "background-color: brown;");
		for (var i = 0; i < 10; i++) {
			var tr = table.insertRow(i);
			for (var j = 0; j < 4; j++) {
				var td = document.createElement('td');
				td = tr.insertCell(j);
				var span = document.createElement('span');
				span.classList.add("emptycircle");
				td.appendChild(span);
			}
			var tablepeg = document.createElement('table');
			for (var k = 0; k < 2; k++) {
				var trpeg = document.createElement('tr');
				trpeg = tablepeg.insertRow(k);
				for (var l = 0; l < 2; l++) {
					var tdpeg = document.createElement('td');
					tdpeg = trpeg.insertCell(l);
					var spanpeg = document.createElement('span');
					spanpeg.classList.add("emptypeg");
					tdpeg.appendChild(spanpeg);
				}
			}
			tr.appendChild(tablepeg);
		}
		var div1 = document.getElementById('leftDiv');
		div1.appendChild(table);
	}
	function fillColor(ele) {
		var id = ele.id;
		selectedColor.push(id);
		var table = document.getElementById('mytable');
		if (rowCounter < 10) {
			var currentRow = table.rows[rowCounter];
			if (cellCounter < 4) {
				var currentCell = currentRow.cells[cellCounter];
				var currentSpan = currentCell.getElementsByTagName("span")[0];
				currentSpan.classList.remove("emptycircle");
				if (id == "Blue")
					currentSpan.classList.add("bluecircle")
				else if (id == "Red")
					currentSpan.classList.add("redcircle")
				else if (id == "Yellow")
					currentSpan.classList.add("yellowcircle")
				else if (id == "Green")
					currentSpan.classList.add("greencircle")
				else if (id == "Purple")
					currentSpan.classList.add("purplecircle")
				else if (id == "Orange")
					currentSpan.classList.add("orangecircle")
				cellCounter++;
			}
		}
	}

	function checkFn() {
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var obj = JSON.parse(xmlhttp.responseText);
				blackpegVal = obj.blackpeg;
				whitepegVal = obj.whitepeg;
				computerColor[0] = obj.cc0;
				computerColor[1] = obj.cc1;
				computerColor[2] = obj.cc2;
				computerColor[3] = obj.cc3;
				fillblackAndWhitePegs();
			}
		}
		xmlhttp.open("POST", "/MasterMind/MasterMindController?rowCount="
				+ rowCounter, true);
		xmlhttp.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");
		xmlhttp.send(JSON.stringify(selectedColor));
	}
	function fillblackAndWhitePegs() {
		var tableAns = document.getElementById('mytable');
		var currentRowAns = tableAns.rows[rowCounter];
		var currentTable = currentRowAns.getElementsByTagName("table")[0];
		var temp = blackpegVal - 1;
		if (blackpegVal > 2)
			temp = 1;
		for (var i = temp; i >= 0; i--) {
			var pegCell = currentTable.rows[0].cells[i];
			var currentPegSpan = pegCell.getElementsByTagName("span")[0];
			currentPegSpan.classList.remove("emptypeg");
			currentPegSpan.classList.add("blackpeg");
		}
		if (blackpegVal > 2) {
			for (var i = 0; i <= blackpegVal - 3; i++) {
				var pegCell = currentTable.rows[1].cells[i];
				var currentPegSpan = pegCell.getElementsByTagName("span")[0];
				currentPegSpan.classList.remove("emptypeg");
				currentPegSpan.classList.add("blackpeg");
			}
		}

		var tempwhiteval = whitepegVal;
		if (blackpegVal < 2) {
			if (whitepegVal == 0)
				var whiteend = blackpegVal;
			else {
				if (whitepegVal == 1)
					var whiteend = 1;
				else
					var whiteend = 2;
			}
			for (var i = blackpegVal; i < whiteend; i++) {
				var pegCell = currentTable.rows[0].cells[i];
				var currentPegSpan = pegCell.getElementsByTagName("span")[0];
				currentPegSpan.classList.remove("emptypeg");
				currentPegSpan.classList.add("whitepeg");
				tempwhiteval--;
			}
		}
		if (tempwhiteval != 0 || blackpegVal >= 2) {
			if (blackpegVal <= 2)
				var whitetemp = 0;
			else {
				var whitetemp = 1;
				tempwhiteval++
			}
			for (var i = whitetemp; i < tempwhiteval; i++) {
				var pegCell = currentTable.rows[1].cells[i];
				var currentPegSpan = pegCell.getElementsByTagName("span")[0];
				currentPegSpan.classList.remove("emptypeg");
				currentPegSpan.classList.add("whitepeg");
			}
		}
		var is_same = (computerColor.length == selectedColor.length)
				&& computerColor.every(function(element, index) {
					return element === selectedColor[index];
				});
		if (is_same)
			alert("You Won");
		if (rowCounter == 9 && !is_same) {
			alert("You Lost");
			alert("Code:" + computerColor);
		}
		rowCounter++;
		cellCounter = 0;
		selectedColor = [];
	}
	function deleteFunction() {
		var tabledel = document.getElementById('mytable');
		var currentRowdel = tabledel.rows[rowCounter];
		for (var deleteCellCounter = 0; deleteCellCounter <= cellCounter; deleteCellCounter++) {
			var currentCelldel = currentRowdel.cells[deleteCellCounter];
			var currentSpandel = currentCelldel.getElementsByTagName("span")[0];
			currentSpandel.classList = "";
			currentSpandel.classList.add("emptycircle");
		}
		cellCounter = 0;
		selectedColor = [];
	}
</script>
</head>
<body onload="CreateTable()">
	<div id="leftDiv" style="width: 15%;"></div>
	<div>
		<span id="Blue" class="bluecircle" onClick="fillColor(this)"></span> <span
			id="Red" class="redcircle" onClick="fillColor(this)"></span> <span
			id="Yellow" class="yellowcircle" onClick="fillColor(this)"></span>
	</div>
	<div>
		<span id="Green" class="greencircle" onClick="fillColor(this)"></span>
		<span id="Purple" class="purplecircle" onClick="fillColor(this)"></span>
		<span id="Orange" class="orangecircle" onClick="fillColor(this)"></span>
	</div>
	<input type="button" value="check" onclick="checkFn()" />
	<input type="button" value="delete" onclick="deleteFunction()" />
</body>
</html>