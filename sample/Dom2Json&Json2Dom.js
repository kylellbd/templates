/**
 * by shiPengYi施彭译, qq:1441499497, 微信wechat:ShiPengYi123
 * **/

var dom2Json_Json2Dom = function(){
	/*参数说明：
		fromChildren：是否从子标签里选
		$DOM：选择器
		jArray：json数组*/
	var jsonData = new Object();
	
	//通过data-key获取val()
	jsonData.getVal = function(fromChildren, $DOM){
		var $these;
		var jArray = {};
		
		if(fromChildren){
			$these = $DOM.find("[data-key]");
		}else{
			$these = $DOM;
		}
		
		for(var i=0,L=$these.length; i<L; i++){
			var $this = $these.eq(i);
			var k = $this.attr("data-key");
			var value = $this.val();
			
			switch($this[0].tagName){
			case "INPUT":
				
				switch($this.attr("type")){
				case "text":
					jArray[k] = value;
					break;
				case "checkbox":
					if($this.prop("checked")){
						jArray[k] = value;
					}
					break;
				case "radio":
					if($this.prop("checked")){
						jArray[k] = value;
					}
					break;
				}
				break;
				
			case "SELECT":
				var optionDataArray = k.split(",");
				var optionVal = optionDataArray[0].split("option-value:")[1];
				var optionText = optionDataArray[1].split("option-text:")[1];
				
				jArray[optionText] = $this.find("option:selected").text()
				jArray[optionVal] = value;
				break;
			case "TEXTAREA":
				jArray[k] = value;
				break;
			}
		}
		
		return jArray;
	}
	
	//通过匹配和data-key相同的jsonArray的key给标签的val()赋值
	jsonData.setVal = function(fromChildren, $DOM, jArray,defaultOption){
		var $these;
		
		if(fromChildren){
			$these = $DOM.find("[data-key]");
		}else{
			$these = $DOM;
		}
		
		var radioI = 0;//radioIndex
		
		for(var i=0,L=$these.length; i<L; i++){
			var $this = $these.eq(i);
			var k = $this.attr("data-key");
			
			switch($this[0].tagName){
			case "INPUT":
				
				switch($this.attr("type")){
				case "text":
					$this.val(jArray[k]);
					break;
				case "checkbox":
					$this.val(jArray[k]);
					$this.next("label").html('<span></span><span class="check"></span><span class="box"></span>'+jArray[k]);
					break;
				case "radio":
					if(jArray.length == undefined){
						$this.val(jArray[k]);
						$this.next("label").html('<span></span><span class="check"></span><span class="box"></span>'+jArray[k]);
						break;
					}
					
					$this.val(jArray[radioI][k]);
					$this.next("label").html('<span></span><span class="check"></span><span class="box"></span>'+jArray[radioI][k]);
					radioI++;
					break;
				}
				break;
				
			case "SELECT":
				var optionHtml = defaultOption;
				var optionDataArray = k.split(",");
				var optionVal = optionDataArray[0].split("option-value:")[1];
				var optionText = optionDataArray[1].split("option-text:")[1];
				
				$this.empty();
				if(jArray.length == undefined){
					optionHtml+="<option value="+jArray[optionVal]+">"+jArray[optionText]+"</option>";
					$this.html(optionHtml);
					break;
				}

				for(var oi=0,ol=jArray.length; oi<ol; oi++){
					optionHtml+="<option value="+jArray[oi][optionVal]+">"+jArray[oi][optionText]+"</option>";
				}
				
				$this.html(optionHtml);
				break;
			case "TEXTAREA":
				$this.val(jArray[k]);
				break;
				
			}
		}
	}
	
	return jsonData;
}