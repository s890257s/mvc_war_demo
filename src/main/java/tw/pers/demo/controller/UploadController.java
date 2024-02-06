package tw.pers.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import tw.pers.demo.model.dto.EmployeeDTO;

@Controller
public class UploadController {

	@GetMapping("/uploadform")
	public String getForm() {
		return "uploadform";
	}

	/**
	 * 基本文字接收，使用情境為<br>
	 * 1. 前端使用 form 或者 FormData<br>
	 * 2. 後端變數不多，可以逐一寫出<br>
	 */
	@PostMapping("/receive_form_text")
	@ResponseBody
	public String receiveFormText(@RequestParam String userName, @RequestParam(name = "user_age") Integer userAge) {

		System.out.println("使用者上傳的名字是：" + userName);
		System.out.println("使用者上傳的年齡是：" + userAge);

		return "done. 檢查後端Console區。";
	}

	/**
	 * 基本文字接收 + 圖片接收<br>
	 * 1. 前端使用 form 或者 FormData<br>
	 * 2. 後端變數不多，可以逐一寫出<br>
	 * 
	 * 注意要使用MultipartFile介面承接檔案，再從介面的內部方法取出對應的資料。
	 */
	@PostMapping("/receive_form_image")
	@ResponseBody
	public String receiveFormImage(@RequestParam String memberName, @RequestParam Integer memberAge,
			@RequestParam(name = "memberPhoto") MultipartFile memberPhotoMultipartFile) {

		System.out.println("會員上傳的名字是：" + memberName);
		System.out.println("會員上傳的年齡是：" + memberAge);

		String filename = memberPhotoMultipartFile.getOriginalFilename();
		long filesize = memberPhotoMultipartFile.getSize();

		System.out.println("會員上傳的檔名是：%s, 檔案大小為：%d".formatted(filename, filesize));

		return "done. 檢查後端Console區。";
	}
	
	
	/**
	 * JSON文字接收，使用情境為<br>
	 * 1. 前端使用 json 格式<br>
	 * 2. 後端有DTO物件存在
	 */
	@PostMapping("/receive_json_text")
	@ResponseBody
	public String receiveFormText(@RequestBody EmployeeDTO employeeDTO) {

		System.out.println(employeeDTO);

		return "done. 檢查後端Console區。";
	}
}
