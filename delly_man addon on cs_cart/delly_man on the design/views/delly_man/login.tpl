<!doctype html>
<html lang="en">
  <head>
  <style type="text/css">
  .ayo{
    margin:auto;
  
}
nav{
   
     width:100%;
     height:70px;
    
     
}
nav h2{
    font-size: xx-large;
    margin-left:10px;
    color:#9D2143;
    font-family:'Inter';
}
.details{
  width:350px;
  display: flex;
  justify-content: center;
  align-items: center;
 border-radius:4px 4px 4px 4px;
border:0.5px solid #9D2143;
padding:1rem 0;
 box-shadow: 2px 4px 6px rgba(0, 0, 0, 0.5);
}
.each {
  padding:1rem;
}
.each .text{
    width:220px;
    height:40px;
    border-radius:10px 10px 10px 10px;
    outline:none;
    /* border:none; */
 
  border:0.5px solid #9D2143;
}
.zack{
    display: grid;
    place-items:center;
    padding:1rem 0;
}
.zack button{
    width:200px;
    height:40px;
    border-radius:3px 3px;
    outline:none;
    border:none;
    background-color: #9D2143;
    color:white;
    transition:all 0.2s;
}
.zack button:hover{
    background-color:white;
    color:#9D2143;
}
#err{
    display: flex;
    justify-content: center;
    align-items: center;
    padding:1rem 0;
    width:50%;
    margin:auto;
    border-radius:4px 4px 4px 4px;
    text-align:center;
}
  </style>
  </head>
  <body>
    <nav>
  <h2>dellyman</h2>
  </nav>
<section class="ayo">
<aside id="err"></aside>
<div class="details">
<form method="POST">
  <div class="each">
    <label>
      <span>e-mail</span>
    </label>
    <input type="text" id="email" class="text" name="email" id="email" placeholder="delly@gmail.com" required/> 
  </div>

<div class="each">
    <label>
    <span>  password</span>
    </label>
    <input type="password" id="password" class="text" name="password" id="password"  placeholder="******" required/>
  </div>

  <div class="zack">
    <button type="submit" id="btn" name="btn" data-id="delly">Login</button>
  </div>
</form>
</div>
 </section>
  </body>
      {literal}
  <script type="text/javascript" >
  let email = document.getElementById('email');
  let password = document.getElementById('password')
  let btn = document.getElementById("btn");
  let error = document.getElementById('err');
  btn.addEventListener("click", function(e){
      e.preventDefault();
   $.ceAjax('request', fn_url('delly_man.send'), {
        method: 'post',
         data:{
          email:email.value,
          password:password.value,
         },
         callback:function(response){
             console.log(response)
            let Email = response.Email
            let CustomerID = response.CustomerID
            let CustomerAuth = response.CustomerAuth
            if(response.Message == "Invalid email or password"){
             error.innerText = `${response.Message}`;
            error.style.color = `red`;
            error.style.border = "1px solid  red";
              setTimeout(() => {
                    error.innerText = ``;
                    error.style.border = "";
                    error.style.color = ""
                }, 14000)
                }else if(response.Message == "You are logged in sucessfully"){
                         window.location.href= "{/literal}{"delly_man.manage"|fn_url}{literal}"+`&id=${CustomerID}&CustomerAuth=${CustomerAuth}`;
                }
            
         }
         
         })
   })

  </script>
  {/literal}
</html>