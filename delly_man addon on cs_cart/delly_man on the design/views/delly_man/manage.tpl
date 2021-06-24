<!doctype html>
<html lang="en">
  <head>

  </head>
  <body >

 <section class="overlay"> 
    <div class="within">
     <h2>Are you sure you want to ship these items</h2>
     <aside>
       <button>Yes</button> <button>No</button>
     </aside>
    </div>
  </section>
   <section class="overlay2"> 
     <div class="snow">
       <div class="loader"></div>
        <h2>Please wait.</h2>
     </div>
  </section>

  <section class="main">
     <h3 class="top">Send  Pickup Request to Dellyman </h3>
     <div class="show" id="show" data-id={$person} ></div>
  <form class="whole"  method="POST">
  <div class='box'>
 <h4> Step 1: Select order </h4>
 <p>Only orders with the payment status of PAID and fulfulment status of AWAITING PROCESSING or PROCESSING will be listed below</p>
 <aside>
 <select class="online">
 </select>
 </aside>
  </div>

   <div class='boxOne'>
 <h4> Step 2: Pick products from the order to ship </h4>
 <p class="xo">Select an order above,  enable you pick products to ship</p>
  <section class="cool">
     <div class="inbox"> 
      
  </section>
  </div>


     <div class='boxTwo'>
 <h4> Step:3 Select a carrier </h4>
  <section class="cool">
     <div class="inbox"> 
    <select class="on" id="on" disabled>
            
         
    </select>
 
  </section>
  <button type="submit" class="submit" >Submit</button>
  </div>
  </form>
 
</section>

  </body>

  {literal}
  <script type="text/javascript" >
//  console.log('here') 
    let joke;
    
   let authId = document.querySelector(".show");
   let option = document.querySelector('.online');
  let inbox = document.querySelector(".inbox");
  let aID = authId.getAttribute("data-id");
  let on = document.querySelector(".on");
  let submit = document.querySelector(".submit");
  let within = document.querySelector(".within");
let overlay = document.querySelector(".overlay");
let overlay2 = document.querySelector(".overlay2");
let van = document.querySelector('.boxOne');
let form = document.querySelector(".whole");
 
let orders = ["Select Order"]
 let list = ["Select Carrier"]
  $.ceAjax('request', fn_url('delly_man.manage'), {
         result_ids:'stone',
        method: 'GET',
        caching:false,
        hidden:true,
        callback:function(res){
           localStorage.setItem("order_detail", JSON.stringify(res.order_detail));
          res.steve.map((item)=>{
                list.push(item.Name)
          })
          list.map((item)=>{
            on.innerHTML +=`<option>${item}</option>`;
          })
           res.orders.map((item)=>{
              orders.push(item.order_id);
          })
           orders.map((item)=>{
            option.innerHTML +=`<option>${item}</option>`;
          })
        }
      });

     option.addEventListener("change", function(e){
         let select = e.target.options[e.target.selectedIndex].innerText;
    let storage = localStorage.getItem('order_detail')?JSON.parse(localStorage.getItem('order_detail')):[];
    let filters = storage.filter(item=>item.order_id == select)
    localStorage.setItem("filters", JSON.stringify(filters));
     let cool = filters.map(item=>{
        return `<p class='product' >${item.product}  x${item.amount}  || code:${item.product_code}    </p>
          <button type="button" class="magic">
            <span></span>
            <span    class="switch"></span>
           <span></span>
        </button>
        <article class="quantity" >
        <input type="number" id="same" class="qty" data-number="${item.product}" data-id='${item.product_code}'  value='${item.amount}' placeholder="Quantity" />
        <button type="button" class="second" >Update</button>
        <p class="err"></p>
         </article>
     </div>
      <hr/>
        `;
        })
        inbox.innerHTML = cool.join(' ');

         let buttons = [...document.querySelectorAll(".magic")]
         let quantity = document.querySelectorAll(".quantity");
                      quantity.forEach((quan) => {
            let num = quan.querySelector('input')
            let second = quan.querySelector('.second');
            let err = quan.querySelector(".err")

            second.addEventListener("click", function (e) {
                e.preventDefault();
                let important = e.target.getAttribute('data-number');
                let con = document.querySelectorAll('.qty')
                // let cole = [];
                // con.forEach((one)=>console.log(one.value))
                
                let goat = e.target.getAttribute('data-id');
                let come = localStorage.getItem('filters')?JSON.parse(localStorage.getItem('filters')):[];
                let purchasedQuantity = come.map(item => item.amount)
                console.log(purchasedQuantity)
                function func() {

                    var cole = [];
                    for (var i = 0; i <= con.length- 1; i++) {
                        cole.push(con[i].value);
                          
                    }
                    

                    function sub(cole, purchasedQuantity) {

                        purchasedQuantity.map((total, figure) => {
                            Answer = total - cole[figure];

                        })
                    }
                    sub(cole, purchasedQuantity);
                    if (cole > purchasedQuantity) {
                        on.setAttribute('disabled', true)
                        console.log(true)
                        err.innerText = `quantity(es) ${num.value} is greater than order `
                        err.style.color = `red`;
                    }
                    else if (cole <= purchasedQuantity) {
                        on.removeAttribute('disabled')
                        console.log(false)
                        err.innerText = `${num.value} quantity(es) will be shipped `
                        err.style.color = `green`;
                    }
                   

                }
                func();



                if (num.value == 0) {

                    err.innerText = ` 0 quantity(es)  can't  be shipped `
                    num.style.border = "1px solid red";
                    on.setAttribute('disabled', true)
                    err.style.color = `red`;
                }

                if (num.value < 0) {

                    err.innerText = `negative quantity(es) can't  be shipped `
                    err.style.color = `red`
                    num.style.border = "1px solid red";
                    on.setAttribute('disabled', true)
                }


            })


        })

           buttons.forEach(btn => {
            let move = btn.querySelector(".magic .switch");
            console.log(move.classList.contains("slide"))
            btn.addEventListener('click', e => {
                let quantity = e.currentTarget.nextSibling.nextSibling;
                buttons.forEach(one => {
                    if (one !== btn) {
                        one.classList.remove("slide")
                    }
                })

                if (!move.classList.contains("slide")) {
                    move.classList.add("slide")
                    btn.classList.add("active")
                    quantity.style.transition = "all 1s";
                    quantity.style.display = "block"
                } else {
                    move.classList.remove("slide")
                    btn.classList.remove("active")
                    quantity.style.transition = "all 1s";
                    quantity.style.display = "none"
                }
            })
        })
       
     })
     
submit.addEventListener("click", function(e){
    e.preventDefault();
    overlay.classList.add('hide-overlay')
  })
  within.addEventListener('click', (e) => {
    let input = [...form.querySelectorAll(".qty")]
   
    
    if (e.target.innerText == "Yes") {
        window.scrollTo(0, 0);
        overlay.classList.remove('hide-overlay')
        input.forEach((one) => {
           let id   = one.getAttribute("data-id");
           let pname = one.getAttribute("data-number");
          console.log(`word:${one.value}, code:${id}, order:${option.value}, carrier:${on.value} `);
        
        $.ceAjax('request', fn_url('delly_man.update'), {
        method: 'post',
         data:{
          word:one.value,
          product_code:id,
          order_id:option.value,
          carrier:on.value,
          product_name:pname
         },
         callback:function(response){
         
         
           let {ResponseCode, ResponseMessage} = response.sound;
           if(ResponseCode == '101' ||  ResponseCode =='400'){
                authId.innerHTML = `${ResponseMessage}`;
                authId.style.color = `red`;
                authId.style.border = "1px solid  red";
           }else if (ResponseCode == '100'){
                 authId.innerHTML = `${ResponseMessage}`;
                authId.style.color = `green`;
                authId.style.border = "1px solid  green";
           }
        setTimeout(() => {
                    authId.innerText = ``;
                    authId.style.border = "";
                    authId.style.color = ""
                }, 14000);
         }
      });

        })
    }else if (e.target.innerText == "No") {
        overlay.classList.remove('hide-overlay')
    }
  })


  </script>
  {/literal}
</html>