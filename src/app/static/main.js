function edit(id) {
    var edit_element = document.querySelector("#" + id);
    edit_element.removeAttribute("readonly");
}

function test() {
    alert("a");
}

function setImage(target) {
    var reader = new FileReader();
    reader.onload = function (e) {
        document.getElementById("icon").setAttribute('src', e.target.result);
    }
    reader.readAsDataURL(target.files[0]);
};
