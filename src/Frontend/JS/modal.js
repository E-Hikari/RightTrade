function sweetAlert() {
    Swal.fire(
        'Parabéns',
        'Inscrição realizada com sucesso!',
        'success',
        
      )
}


function uploadProject() {
  // pede o arquivo da pessoa :)

  Swal.fire({
    title: 'Tem certeza?',
    text: "Não é possível alterar o updlaod!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Sim!'
  }).then((result) => {
    if (result.isConfirmed) {
      Swal.fire(
        'Upload completo!',
        'Seu arquivo foi enviado ao solicitante, em até 7 dias ele retornará com uma resposta!',
        'success'
      )
      document.getElementById('receive_button').className = 'btn btn-outline-info';
    }
  })

}

function receive() {
  let timerInterval
Swal.fire({
  title: 'Conectando com a metamask!',
  html: 'O processo finalizará em <b></b> milisegundos.',
  timer: 10000,
  timerProgressBar: true,
  didOpen: () => {
    Swal.showLoading()
    const b = Swal.getHtmlContainer().querySelector('b')
    timerInterval = setInterval(() => {
      b.textContent = Swal.getTimerLeft()
    }, 100)
  },
  willClose: () => {
    clearInterval(timerInterval)
  }
}).then((result) => {
  /* Read more about handling dismissals below */
  if (result.dismiss === Swal.DismissReason.timer) {
    console.log('I was closed by the timer')
  }
})
}