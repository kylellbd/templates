var dom2Json_Json2Dom = function(){
	/*参数说明：
		fromChildren：是否从子标签里选
		$DOM：选择器
		jArray：json数组*/
	var jsonData = new Object();
	
	//通过data-key获取val()
	jsonData.getVal = function(fromChildren, $DOM){
		var $these = "";
		var jArray = {};
		
		if(fromChildren){
			$these = $DOM.find("[data-key]");
		}else{
			$these = $DOM;
		}
		
		var L = $these.length;
		for(var i=0;i<L;i++){
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
					if($this.prop("checked") == true){
						jArray[k] = value;
					}else{
						jArray[k] = "";
					}
					break;
				case "radio":
					if($this.prop("checked") == true){
						jArray[k] = value;
					}else{
						jArray[k] = "";
					}
					break;
				}
				break;
				
			case "SELECT":
				if(value == null){
					value = "";
				}
				jArray[k] = value;
				break;
			case "TEXTAREA":
				jArray[k] = value;
				break;
			}
		}
		
		return jArray;
	}
	
	//通过data-key获取data-value
	/*jsonData.getValue = function(fromChildren, $DOM){
		if(fromChildren){
			var $dataJsonGroup = $DOM.find('[data-key]');
			var length = $dataJsonGroup.length;
			var jArray = {};
			
			for(var i=0;i<length;i++){
				jArray[$dataJsonGroup.eq(i).attr("data-key")] = $dataJsonGroup.eq(i).attr("data-value");
			}
		}else{
			var length = $DOM.length;
			var jArray = {};
			
			for(var i=0;i<length;i++){
				jArray[$DOM.eq(i).attr("data-key")] = $DOM.eq(i).attr("data-value");
			}
		}
		
		return jArray;
	}*/
	
	//通过匹配和data-key相同的jsonArray的key给标签的val()赋值
	jsonData.setVal = function(fromChildren, $DOM, jArray){
		var $these = "";
		
		if(fromChildren){
			$these = $DOM.find("[data-key]");
		}else{
			$these = $DOM;
		}
		
		var L = $these.length;
		for(var i=0;i<L;i++){
			var $this = $these.eq(i);
			var k = $this.attr("data-key");
			var jArrayD1 = jArray[k];
			
			switch($this[0].tagName){
			case "INPUT":
				
				switch($this.attr("type")){
				case "text":
					$this.val(jArrayD1);
					break;
				case "checkbox":
					$this.val(jArrayD1.val);
					$this.next("label").html('<span></span><span class="check"></span><span class="box"></span>'+jArrayD1.text);
					
					if(jArrayD1.checked == true){
						$this.prop("checked",true);
					}
					break;
				case "radio":
					$this.val(jArrayD1.val);
					$this.next("label").html('<span></span><span class="check"></span><span class="box"></span>'+jArrayD1.text);
					
					if(jArrayD1.checked == true){
						$this.prop("checked",true);
					}
					break;
				}
				break;
				
			case "SELECT":
				var $option = $this.children("option");
				var L1 = $option.length;
				for(var i1=0;i1<L1;i1++){
					var $thisOption = $option.eq(i1);
					
					$thisOption.val(jArrayD1[i1].val);
					$thisOption.text(jArrayD1[i1].text);
				}
				break;
			case "TEXTAREA":
				$this.empty();
				$this.val(jArray[k]);
				break;
			}
		}
	}
	
	//通过匹配和data-key相同的jsonArray的key给标签的data-value赋值
	/*jsonData.putValue = function(fromChildren, $DOM, jArray){
		if(fromChildren){
			var $dataJsonGroup = $DOM.find('[data-key]');
			var length = $DOM.length;
			for(var i=0;i<length;i++){
				$dataJsonGroup.eq(i).attr("data-value", (jArray[$dataJsonGroup.eq(i).attr("data-key")]));
			}
		}else{
			var length = $DOM.length;
			for(var i=0;i<length;i++){
				$DOM.eq(i).attr("data-value", (jArray[$DOM.eq(i).attr("data-key")]));
			}
		}
		
	}*/
	
	return jsonData;
}