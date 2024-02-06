<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>前端傳送資訊到後端</title>

		<!-- 引入 axios 1.6.7 -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.6.7/axios.min.js"
			integrity="sha512-NQfB/bDaB8kaSXF8E77JjhHG5PM6XVRxvHzkZiwl3ddWCEPBa23T76MuWSwAJdMGJnmQqM0VeY9kFszsrBEFrQ=="
			crossorigin="anonymous" referrerpolicy="no-referrer"></script>

		<style type="text/css">
			img {
				width: 200px;
				margin: 20px;
			}
		</style>
	</head>

	<body>
		<h2>【表單 文字上傳】</h2>
		<form action="/receive_form_text" method="POST">
			<div>
				姓名： <input type="text" name="userName">
			</div>
			<div>
				年齡： <input type="Number" name="user_age">
			</div>

			<button>送出</button>
			<button id="sendByJS1">使用JS送出FormData</button>
		</form>

		<script>
			// 【選取元素】
			const userNameInput = document.querySelector("input[name=userName]")
			const userAgeInput = document.querySelector("input[name=user_age]")
			const sendByJS1 = document.querySelector("#sendByJS1")

			// 【使用JS發送表單資料】
			// 當點擊「使用JS送出FormData」按鈕
			sendByJS1.addEventListener("click", (event) => {
				// 阻止預設表單submit事件
				event.preventDefault();

				// 建立FormData，並加入想傳的Key-Value
				const fd = new FormData();
				fd.append("userName", userNameInput.value);
				fd.append("user_age", userAgeInput.value);

				// 使用fetch送出請求
				fetch("/receive_form_text", {
					method: "POST",
					body: fd
				}).then(rs => rs.text()).then(message => {
					console.log("使用fetch", message);
				});

				// 使用axios送出請求
				axios.post("/receive_form_text", fd).then(rs => {
					console.log("使用axios", rs.data);
				})
			})
		</script>

		<hr>

		<h2>【表單 文字+圖片上傳】</h2>
		<form action="/receive_form_image" method="POST" enctype="multipart/form-data">
			<div>
				姓名： <input type="text" name="memberName">
			</div>
			<div>
				年齡： <input type="Number" name="memberAge">
			</div>
			<div>
				照片： <input type="file" accept="image/*" name="memberPhoto">
			</div>
			<div>
				<img src="/no_image.jpg" id="memberPhoto">
			</div>

			<button>送出</button>
			<button id="sendByJS2">使用JS送出FormData</button>

		</form>

		<script>
			// 【選取元素】
			const memberNameInput = document.querySelector("input[name=memberName]")
			const memberAgeInput = document.querySelector("input[name=memberAge]")
			const memberPhotoInput = document.querySelector("input[name=memberPhoto]")
			const memberPhoto = document.querySelector("#memberPhoto");
			const sendByJS2 = document.querySelector("#sendByJS2")

			// 【使用JS發送表單資料】
			// 當點擊「使用JS送出FormData」按鈕
			sendByJS2.addEventListener("click", (event) => {
				// 阻止預設表單submit事件
				event.preventDefault();

				// 建立FormData，並加入想傳的Key-Value
				const fd = new FormData();
				fd.append("memberName", memberNameInput.value);
				fd.append("memberAge", memberAgeInput.value);
				fd.append("memberPhoto", memberPhotoInput.files[0]);

				console.log(fd)

				// 使用fetch送出請求
				fetch("/receive_form_image", {
					method: "POST",
					body: fd
				}).then(rs => rs.text()).then(message => {
					console.log("使用fetch", message);
				});

				// 使用axios送出請求
				axios.post("/receive_form_image", fd).then(rs => {
					console.log("使用axios", rs.data);
				})
			})

			// 【前端照片預覽】
			// 當input元素發生變化
			memberPhotoInput.addEventListener("change", (event) => {
				// 根據event事件取得目標元素，並取得檔案列表(files)中的第一筆資料files[0]
				const photoFile = event.target.files[0];

				// 如果有取到值
				if (photoFile != undefined) {
					// 使用URL的方法createObjectURL()建立暫時路徑，存在瀏覽器的記憶體空間
					const tempURL = URL.createObjectURL(photoFile);
					memberPhoto.src = tempURL;
				}

				// 如果沒取到值，圖片顯示為「無圖片」
				if (photoFile == undefined) {
					memberPhoto.src = "/no_image.jpg";
				}
			})

			// 點擊照片，觸發檔案上傳
			memberPhoto.addEventListener("click", () => {
				memberPhotoInput.click();
			})

		</script>

		<hr>

		<h2>JSON格式 文字上傳(JSON只能使用JS送出)</h2>
		<div>
			姓名： <input type="text" name="employeeName">
		</div>
		<div>
			年齡： <input type="Number" name="employeeAge">
		</div>
		<div>
			圖片： <input type="file" name="employeePhoto">
		</div>


		<button id="sendByJS3">送出</button>

		<script>
			// 【選取元素】
			const employeeNameInput = document.querySelector("input[name=employeeName]")
			const employeeAgeInput = document.querySelector("input[name=employeeAge]")
			const employeePhotoInput = document.querySelector("input[name=employeePhoto]")
			const sendByJS3 = document.querySelector("#sendByJS3")

			sendByJS3.addEventListener("click", (event) => {
				const obj = { employeeName: employeeNameInput.value, employeeAge: employeeAgeInput.value ,employeePhoto:employeePhotoInput.files[0]}

				fetch("/receive_json_text", {
					method: "POST",
					body: JSON.stringify(obj),
					headers: {
						"content-type": "application/json",
					},

				}).then(rs => rs.text()).then(message => {
					console.log("使用fetch", message);
				});
			})
		</script>



	</body>

	</html>