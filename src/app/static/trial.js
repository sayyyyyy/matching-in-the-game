const buttonOpen = document.getElementById('modalOpen');
const modal = document.getElementById('easyModal');
const buttonClose = document.getElementsByClassName('modalClose')[0];

const buttonOpen_ = document.getElementById('modalOpen_');
const modal_ = document.getElementById('easyModal_');
const buttonClose_ = document.getElementsByClassName('modalClose_')[0];


//ボタンがクリックされた時
buttonOpen.addEventListener('click', modalOpen);
function modalOpen() {
　　modal.style.display = 'block';
};

//バツ印がクリックされた時
buttonClose.addEventListener('click', modalClose);
function modalClose() {
　　modal.style.display = 'none';
};

//モーダルコンテンツ以外がクリックされた時
addEventListener('click', outsideClose);
function outsideClose(e) {
　　if (e.target == modal) {
　　modal.style.display = 'none';
　　};
};
//---------------------------------------------------------------------------------------------

//ボタンがクリックされた時
buttonOpen_.addEventListener('click', modalOpen_);
function modalOpen_() {
　　modal_.style.display = 'block';
};

//バツ印がクリックされた時
buttonClose_.addEventListener('click', modalClose_);
function modalClose_() {
　　modal_.style.display = 'none';
};

//モーダルコンテンツ以外がクリックされた時
addEventListener('click', outsideClose_);
function outsideClose_(e) {
　　if (e.target == modal_) {
　　modal_.style.display = 'none';
　　};
};

//----------------------------------------------------------------------------------------------


//以下みーや追加
//ボタンがクリックされた時
buttonOpen_follow.addEventListener('click', modalOpen_follow);
function modalOpen_follow() {
　　modal_follow.style.display = 'block';
};

//バツ印がクリックされた時
buttonClose_follow.addEventListener('click', modalClose_follow);
function modalClose_follow() {
　　modal_follow.style.display = 'none';
};

//モーダルコンテンツ以外がクリックされた時
addEventListener('click', outsideClose_follow);
function outsideClose_follow(e) {
　　if (e.target == modal_follow) {
　　modal_follow.style.display = 'none';
　　};
};