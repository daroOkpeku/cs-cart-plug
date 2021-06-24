<?php
use Tygh\Registry;
use Tygh\Settings;
if (!defined('BOOTSTRAP')) { die('Access denied'); }
$suffix = "update";
$auth = $_SESSION['auth'];
if (!empty($auth['user_id']) && AREA == 'A') {
  if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $status = 1;
      if($status == 1){
             fn_set_notification('N', fn_get_lang_var('success'), fn_get_lang_var('manage'), true);
          }
      if ($mode == 'update') {


         $order_id = $_REQUEST['order_id'];
         $word = $_REQUEST['word'];
         $product_code = $_REQUEST['product_code'];
         $carrier = $_REQUEST['carrier'];
         $product_name = $_REQUEST['product_name'];
         $data = array(
          'amount'=>$word
         );
        db_query('UPDATE ?:order_details set ?u WHERE product_code = ?i AND order_id=?i', $data, $product_code, $order_id );
        $show_list = db_get_array('SELECT * FROM ?:orders LEFT JOIN ?:order_details USING(order_id) WHERE  order_id = ?i AND product_code = ?i', $order_id, $product_code);
          foreach ($show_list as $show) {
            $address = $show['b_address'];
            $city = $show['b_city'];
            $country = $show['b_country_descr'];
            $firstname = $show['b_firstname'];
            $lastname = $show['b_lastname'];
            $phone = $show['b_phone'];
            $email = $show['email'];
            $amount = $show['amount'];
            $product_id = $show['product_id'];
              $carrier;
              $sun_list = db_get_array('SELECT * FROM ?:product_descriptions  WHERE  product_id = ?i ', $product_id);
              foreach($sun_list as $sun);
                $product  = $sun['product'];
                    $ch = curl_init();
$url = "http://206.189.199.89/api/v2.0/BookOrder";
curl_setopt($ch, CURLOPT_URL,  $url);
curl_setopt($ch, CURLOPT_ENCODING, " ");
curl_setopt($ch,  CURLOPT_TIMEOUT,  0);
curl_setopt($ch, CURLOPT_MAXREDIRS, 10);
// curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    "Content-Type: application/json"
));
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode(array(
  "CustomerID" => 850,
	"PaymentMode" => "pickup",
    "FixedDeliveryCharge" => 10,
	"Vehicle" => "$carrier",

	"IsProductOrder" => 1,
    "BankCode" => "",
    "AccountNumber"=> "",

    "IsProductInsurance" => 0,
    "InsuranceAmount" => 0,
    
    "PickUpContactName" => "stephen okpeku ighodaro",
    "PickUpContactNumber" => "08165648269",
    "PickUpGooglePlaceAddress" =>"3 jinadu street",
    "PickUpLandmark" => "Ikorodu",
	
    "PickUpRequestedTime" => "06 AM to 09 PM",
	"PickUpRequestedDate" => "30/09/2020",
    "DeliveryRequestedTime" => "08 AM to 09 PM",

    "Packages" => [
          array(
            "DeliveryContactName" => "$firstname.' '.$lastname",
            "DeliveryContactNumber" => "$phone",
            "DeliveryGooglePlaceAddress" => "$address.' '.$city.' '.$country",
            "DeliveryLandmark" => "$city",
            "PackageDescription" => "$product",
            "ProductAmount" =>$amount,
          )
    ],

    "CustomerAuth"=>"1shcqa0cc4jmXvtH6EpLZfvVNuApmFDS"
)));
curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_2TLS);
 curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
 $response = curl_exec($ch);
     
    
 $err = curl_error($ch);
  $joker = json_decode($response, true);
  if(defined("AJAX_REQUEST")){
         Tygh::$app['ajax']->assign('sound', $joker);
       }
 curl_close($ch);
          }
       
      }
     
    } 
     if ( $_SERVER['REQUEST_METHOD'] == "GET" && $mode == 'manage') {
    
           $person = $auth['user_id'];
            $jack =   db_get_field('SELECT company_id FROM ?:users WHERE user_id = ?i', $auth['user_id']);
            $order_list = db_get_array('SELECT order_id FROM ?:orders WHERE company_id = ?i', $jack);
             $order_detail = db_get_array('SELECT * FROM ?:order_details LEFT JOIN ?:product_descriptions  USING(product_id)');
            Registry::get('view')->assign('person', $jack);   
           
           
             
           $ch = curl_init();

              $url = "http://206.189.199.89/api/v2.0/Vehicles";

              curl_setopt($ch, CURLOPT_URL, $url);
              curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-Type: application/json"));
              curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
              $res = curl_exec($ch);
              $err = curl_errno($ch);
              curl_close($ch); 
              if($err){
              echo "error".$err;
              }
              $see = json_decode($res, TRUE);
         
     
      if(defined("AJAX_REQUEST")){
       Tygh::$app['ajax']->assign('steve', $see);
      Tygh::$app['ajax']->assign('orders',$order_list);
      Tygh::$app['ajax']->assign('order_detail', $order_detail);
      }
           
                     
    } 
  }
    ?>