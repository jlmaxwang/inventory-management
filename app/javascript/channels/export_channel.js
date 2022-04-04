const checkBox = document.querySelectorAll('#ischecked')
console.log(checkBox);

function getCheckBoxValue() {
  let res = document.querySelectorAll('input')
  console.log(res);
}

function checkAll() {
  let inputs = document.querySelectorAll('.checkbox-all')
  console.log(inputs);
  for (let i = 0; i < inputs.length; i++) {
      inputs[i].checked = true;
  }
}
