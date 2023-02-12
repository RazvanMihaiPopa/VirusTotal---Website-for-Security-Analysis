const inputs = document.querySelectorAll(".input");

function addcl(){
	let parent = this.parentNode.parentNode;
	parent.classList.add("focus");
}

function remcl(){
	let parent = this.parentNode.parentNode;
	if(this.value == ""){
		parent.classList.remove("focus");
	}
}

inputs.forEach(input => {
	input.addEventListener("focus", addcl);
	input.addEventListener("blur", remcl);
});

function submitForm(event) {
	event.preventDefault();
	const url = "http://localhost:8080/api/v1/login";
	const formData = new FormData(event.target);
	const data = {};
	formData.forEach((value, key) => (data[key] = value));
	console.log(data);
	fetch(url, {
		method: "POST",
		body: JSON.stringify(data),
		headers: {
			"Content-Type": "application/json",
		},
	})
	.then((response) => response.json())
	.then((data) => {
		localStorage.setItem("AccessToken", data.AccessToken);
		console.log("Success:", data);
	})
	.catch((error) => {
		console.error("Error:", error);
	});
	localStorage.setItem("userEmail", data["userEmail"]);
	localStorage.setItem("username", data["username"]);
}