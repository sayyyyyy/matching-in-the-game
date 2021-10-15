const buttonOpen = document.getElementById('modalOpen');
const modal = document.getElementById('easyModal');
const buttonClose = document.getElementsByClassName('modalClose')[0];

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