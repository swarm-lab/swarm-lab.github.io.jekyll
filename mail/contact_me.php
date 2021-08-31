<?php
	// Check for empty fields
	if(empty($_POST['name'])  		||
	   empty($_POST['email']) 		||
	   empty($_POST['message'])	||
	   !filter_var($_POST['email'],FILTER_VALIDATE_EMAIL))
	   {
		echo "No arguments Provided!";
		return false;
	   }

	$name = $_POST['name'];
	$email_address = $_POST['email'];
	if(empty($_POST['website']))
	{
	   $website = '';
	} else {
	   $website = $_POST['website'];
	}
	$message = $_POST['message'];

	// Create the email and send the message
	$from = "contact@theswarmlab.com";
	$to = "garnier@njit.edu";
	$subject = "Website Contact Form:" . $name;
	$content = "You have received a new message from your website contact form.\n\n" . "Here are the details:\n\nName: " . $name . "\n\nEmail: " . $email_address . "\n\nWebsite: " . $website . "\n\nMessage:\n " . $message;
	$headers = "From:" . $from . "\r\n" . "Reply-To:" . $email_address;
	mail($to,$subject,$content,$headers);
	return true;
?>
