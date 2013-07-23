<html>
<body>

<?php



$link = mysql_connect('localhost', 'root', '');
if (!$link) {
    die('Could not connect: ' . mysql_error());
}
mysql_select_db("sms") ;

$query = "select * from inbox order by ReceivingDateTime desc limit 1";
$result = mysql_query($query);
$old = mysql_fetch_array($result);
//for($i = 1;$i <= 5;$i++)
while(1) //INFINITE FOR LOOP TO KEEP SCRIPT ALIVE
{
	$result = mysql_query($query);
	$new = mysql_fetch_array($result);
	if ( $new[9] == $old[9] )
	{ 
		echo "."; 
	  	continue;
	}
	else
	{ 
		echo "new new"; 
	  	$new_sms_no = $new[9] - $old[9];
	  	$new_sms_no--;
	  	for($new_sms_no;$new_sms_no>=0;$new_sms_no--)
	  	{
	  		$old = $new;
	  		
	  		$single = "select * from inbox order by ReceivingDateTime desc limit $new_sms_no,1";
	  		$result = mysql_query($single);
	  		$fetch = mysql_fetch_array($result);
	  		echo $fetch[8];
	  		service($fetch);
	  	}
	
		//errorexit();
	}
		
	sleep(3);	
}


function errorexit()
{
	echo "\n</body>\n</html>";
	mysql_close();
	exit();
}


function service($row) //FUNCTION THAT HANDLES ALL OPERATIONS AFTER AN SMS IS RECEIVED
{
	$hostname = '{imap.gmail.com:993/imap/ssl}INBOX';
	echo $row[8];
	$sms_content = $row[8];
	
	$sender_number = $row[3];
	//echo $sender_number;	
	$result = mysql_query("select SenderNumber from info where SenderNumber like '$sender_number'");
	
	$check = mysql_fetch_array($result);
	//echo $check[0];
	
	if($check[0])
	{
		echo "Continue with the action";

			
		$result = mysql_query("select UID,Username,Password,Action,SearchString from info where SenderNumber like '$sender_number'");
		$tmp3 = mysql_fetch_array($result);
		$uid = $tmp3[0];
		$username = $tmp3[1];
		$password = $tmp3[2];
		$action = $tmp3[3];
		$string = $tmp3[4];
		
		echo $username;
		echo $password;
		echo $sms_content;
		echo $uid;
		echo $action;
		
		$inbox = imap_open($hostname,$username,$password);

		if(!strcmp($sms_content,"*"))
		{
			$result = mysql_query("select State from info where SenderNumber like '$sender_number'");
			$state = mysql_fetch_array($result);
			
			$tmp_st = (int)$state[0];
			$tmp_st = $tmp_st + 2;
			 
			echo $tmp_st;
			
			mysql_query("update info set State = $tmp_st where UID = $uid");
			
			echo "<br/>Fetching additional messages";
			
			generate_sms($inbox,$tmp_st,$uid);
			
		}
		elseif(!strcmp($sms_content,"."))
		{
			mysql_query("delete from info where UID=$uid");
			mysql_query("delete from indices where UID=$uid");
			notify("Session Ended",$sender_number);
		}
		elseif(!strcmp($sms_content,"#"))
		{
			mysql_query("update info set State = 0 where UID = $uid");
			generate_sms($inbox,0,$uid);
		}
		elseif(!strcmp($sms_content,"#1"))
		{
			mysql_query("update info set Action = 'UNSEEN' where UID = $uid");
			mysql_query("update info set State = 0 where UID = $uid");
			mysql_query("delete from indices where UID = $uid");
			
			
			$emails = imap_search($inbox,'UNSEEN');

				if($emails)
				{ 
					$index = 1;
					foreach($emails as $value)
					{
						mysql_query("insert into indices values($uid,$index,$value)");
						$index++;
					}
					
					generate_sms($inbox,"0",$uid);
				}
				else
				{
					notify("No Unread Mails!!",$sender_number);
				}
			
		}
		elseif(!strcmp($sms_content,"#2"))
		{
			mysql_query("update info set Action = 'SEEN' where UID = $uid");
			mysql_query("update info set State = 0 where UID = $uid");
			mysql_query("delete from indices where UID = $uid");
			
			
			$emails = imap_search($inbox,'SEEN');

				if($emails)
				{ 
					$index = 1;
					foreach($emails as $value)
					{
						mysql_query("insert into indices values($uid,$index,$value)");
						$index++;
					}
					
					generate_sms($inbox,"0",$uid);
				}
				else
				{
					notify("No Read Mails!!",$sender_number);
				}
			
		}
		elseif(is_numeric($sms_content))
		{
						
				$result = mysql_query("select MessageNumber from indices where `Index`=$sms_content and `UID`=$uid");
				if($result)
				{
					$tmp2 = mysql_fetch_array($result);
					$message_no = $tmp2[0];
				
					
					$inbox = imap_open($hostname,$username,$password);
					$email = imap_fetchbody($inbox,$message_no,"1.1");
					echo $email;
					$email = strip_tags($email);
					echo "<br/>Stripped<br/>";
					echo $email;
					notify($email,$sender_number);
				}
				else
				{
					notify("Inavlid Input",$sender_number);
					//errorexit();
				}			
			
	
		}
		else
		{
			$tmp_content = explode(" ",$sms_content,2);
			$sms_mode = $tmp_content[0];
			$sms_str = $tmp_content[1];
			
			if(!strcmp($sms_mode,"#3"))
			{
				mysql_query("update info set Action = 'SEARCH' where UID = $uid");
				mysql_query("update info set State = 0 where UID = $uid");
				mysql_query("update info set SearchString = '$sms_str' where UID = $uid");
				mysql_query("delete from indices where UID = $uid");
			
			
				$emails = imap_search($inbox,"BODY \"$sms_str\"");

				if($emails)
				{ 
					$index = 1;
					foreach($emails as $value)
					{
						mysql_query("insert into indices values($uid,$index,$value)");
						$index++;
					}
					
					generate_sms($inbox,"0",$uid);
				}
				else
				{
					notify("No E-mails matching specified criterion found!!",$sender_number);
				}
			
			}
			elseif(!strcmp($sms_mode,"#4"))
			{
				mysql_query("update info set Action = 'SEND' where UID = $uid");
				mysql_query("update info set State = 0 where UID = $uid");
				mysql_query("delete from indices where UID = $uid");
				
				$tmp_sms_str = explode("*",$sms_str,3);
				
				$to = $tmp_sms_str[0];
				$subject = $tmp_sms_str[1];
				$content = $tmp_sms_str[2];
				
				date_default_timezone_set('America/Toronto');
				require_once('class.phpmailer.php');
				//include("class.smtp.php"); // optional, gets called from within class.phpmailer.php if not already loaded
	
				$mail             = new PHPMailer();

				//$body             = "hi this is ankit whats up";
				//$body             = eregi_replace("[\]",'',$body);

				$mail->IsSMTP(); // telling the class to use SMTP
				$mail->Host       = "mail.yourdomain.com"; // SMTP server
				$mail->SMTPDebug  = 2;                     // enables SMTP debug information (for testing)
                                // 1 = errors and messages
                                          // 2 = messages only
				$mail->SMTPAuth   = true;                  // enable SMTP authentication
				$mail->SMTPSecure = "ssl";                 // sets the prefix to the servier
				$mail->Host       = "smtp.gmail.com";      // sets GMAIL as the SMTP server
				$mail->Port       = 465;                   // set the SMTP port for the GMAIL server
				$mail->Username   = $username;  // GMAIL username
				$mail->Password   = $password;            // GMAIL password

				$mail->SetFrom($username, '');

				$mail->AddReplyTo($username,"");

				$mail->Subject    = $subject;

				$mail->AltBody    = "To view the message, please use an HTML compatible email viewer!"; // optional, comment out and test

				$mail->MsgHTML($content);
	
				$address = $to;
				$mail->AddAddress($address, "");

				/*$mail->AddAttachment("images/phpmailer.gif");      // attachment
				$mail->AddAttachment("images/phpmailer_mini.gif"); // attachment*/
				if(!$mail->Send()) 
				{
					  echo "Mailer Error: " . $mail->ErrorInfo;
					  notify("Error in sending E-mail",$sender_number);
				} 
				else 
				{
					  echo "Message sent!";
					  notify("E-mail Sent!!",$sender_number);
				}
				
				
			}
		}
		
	}
	else // FIRST TIME USER
		{	
			$stats = explode(" ",$row[8],4);
		
			$username = $stats[0];
			$password = $stats[1];
			
			echo $username;
			echo $password;
			$inbox = imap_open($hostname,$username,$password);
			
			if($inbox == FALSE)
			{ 
				notify("An Error occured!!Login Failed",$sender_number);
				//errorexit(); 
			}
			else
			{ 
						
				if( $stats[2] == "1")
				{ 
					$action = "UNSEEN"; 
					
					mysql_query("insert into info(Username,Password,SenderNumber,Action,State,SearchString) values('$username','$password','$sender_number','$action',0,'')"); 
			
					$result = mysql_query("select last_insert_id()");
					$tmp = mysql_fetch_array($result);
					$uid = $tmp[0];
					echo $uid;
				
					$emails = imap_search($inbox,'UNSEEN');

					if($emails)
					{ 
						$index = 1;
						foreach($emails as $value)
						{
							mysql_query("insert into indices values($uid,$index,$value)");
							$index++;
						}
						
						generate_sms($inbox,"0",$uid);

					}
					else
					{
						notify("No Unread Mails!!",$sender_number);
					}
				
				}
				elseif( $stats[2] == "2")
				{ 
					$action = "SEEN"; 
				
					mysql_query("insert into info(Username,Password,SenderNumber,Action,State,SearchString) values('$username','$password','$sender_number','$action',0,'')"); 
			
					$result = mysql_query("select last_insert_id()");
					$tmp = mysql_fetch_array($result);
					$uid = $tmp[0];
					echo $uid;
					
					$emails = imap_search($inbox,'SEEN');
	
					if($emails)
					{ 
						$index = 1;
						foreach($emails as $value)
						{
							mysql_query("insert into indices values($uid,$index,$value)");
							$index++;
						}
						
						generate_sms($inbox,0,$uid);
	
					}
					else
					{
						notify("No Read Mails!!",$sender_number);
					}
				}
				elseif( $stats[2] == "3")
				{ 
					$action = "SEARCH"; 
					$search_string = $stats[3];
					
					
					mysql_query("insert into info(Username,Password,SenderNumber,Action,State,SearchString) value('$username','$password','$sender_number','$action',0,'$search_string')"); 
			
					$result = mysql_query("select last_insert_id()");
					$tmp = mysql_fetch_array($result);
					$uid = $tmp[0];
					echo $search_string;
				
					$emails = imap_search($inbox,"BODY \"$search_string\"");

					if($emails)
					{ 
						$index = 1;
						foreach($emails as $value)
						{
							mysql_query("insert into indices values($uid,$index,$value)");
							$index++;
						}
						
						generate_sms($inbox,0,$uid);
	
					}
					else
					{
						notify("No Mails matching specified criterion found!!",$sender_number);
					}
				}
				elseif( $stats[2] == "4")
				{ 
					$action = "SEND"; 
					$tmp_cnt = explode("*",$stats[3],3);
					
					//mysql_query("insert into info(Username,Password,SenderNumber,Action,State,SearchString) value('$username','$password','$sender_number','$action',0,'$to')");
					
					$to = $tmp_cnt[0];
					$subject = $tmp_cnt[1];
					$content = $tmp_cnt[2];
					
					date_default_timezone_set('America/Toronto');

					require_once('class.phpmailer.php');
					//include("class.smtp.php"); // optional, gets called from within class.phpmailer.php if not already loaded
	
					$mail             = new PHPMailer();
	
					//$body             = "hi this is ankit whats up";
					//$body             = eregi_replace("[\]",'',$body);
	
					$mail->IsSMTP(); // telling the class to use SMTP
					$mail->Host       = "mail.yourdomain.com"; // SMTP server
					$mail->SMTPDebug  = 2;                     // enables SMTP debug information (for testing)
	                                           // 1 = errors and messages
	                                           // 2 = messages only
					$mail->SMTPAuth   = true;                  // enable SMTP authentication
					$mail->SMTPSecure = "ssl";                 // sets the prefix to the servier
					$mail->Host       = "smtp.gmail.com";      // sets GMAIL as the SMTP server
					$mail->Port       = 465;                   // set the SMTP port for the GMAIL server
					$mail->Username   = $username;  // GMAIL username
					$mail->Password   = $password;            // GMAIL password
	
					$mail->SetFrom($username, '');
	
					$mail->AddReplyTo($username,"");

					$mail->Subject    = $subject;

					$mail->AltBody    = "To view the message, please use an HTML compatible email viewer!"; // optional, comment out and test

					$mail->MsgHTML($content);
	
					$address = $to;
					$mail->AddAddress($address, "");
	
					/*$mail->AddAttachment("images/phpmailer.gif");      // attachment
					$mail->AddAttachment("images/phpmailer_mini.gif"); // attachment*/

					if(!$mail->Send()) 
					{
						  echo "Mailer Error: " . $mail->ErrorInfo;
						  notify("Error in sending E-mail",$sender_number);
					} 
					else 
					{
						  echo "Message sent!";
						  notify("E-mail Sent!!",$sender_number);
					}
					
										
				}
				else
				{ 
					notify("An Error occured!! Invalid Action Requested!!",$sender_number);
					//errorexit(); 
				}
		
					
			}	
		
		
	
		}

}

function notify($notice,$phnumber) //SMS ERROR NOTICES
{

	$notice = substr($notice,0,157);

	mysql_query("INSERT INTO `sms`.`outbox` (`UpdatedInDB`, `InsertIntoDB`, `SendingDateTime`, `Text`, `DestinationNumber`, `Coding`, `UDH`, `Class`, `TextDecoded`, `ID`, `MultiPart`, `RelativeValidity`, `SenderID`, `SendingTimeOut`, `DeliveryReport`, `CreatorID`) VALUES (CURRENT_TIMESTAMP, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '$phnumber', 'Default_No_Compression', NULL, '-1', '$notice', NULL, 'false', '-1', NULL, '0000-00-00 00:00:00', 'default', '')");
}

function generate_sms($inbox, $state, $uid) //SMS E-MAIL LISTINGS
{
	// Generate SMS of requisite elements here ----------
	
	$result1 = mysql_query("select SenderNumber from info where UID=$uid");
	$tmp_sendernumber = mysql_fetch_array($result1);
	$sendernumber = $tmp_sendernumber[0];
	echo $sendernumber;
	echo $uid;
	echo $state;
	
	$result2 = mysql_query("select `Index` , `MessageNumber` from `indices` where `UID` = $uid and `Index` > $state order by `Index`");
	if(!$result2)
	{
		echo "fail";
	}
	
	$counter = 0;
	$sms = "";
	while(($message_no = mysql_fetch_array($result2)) && $counter<2)
	{
		
		$msg = imap_headerinfo($inbox,$message_no[1]);
		echo "<br/>";
		
		echo $value;
		echo $msg->subject;
		echo " -FROM- ";
		echo $msg->fromaddress;
	
		$tmp_index = $message_no[0];
	
		$sms = "$sms"."$tmp_index".")"."$value"."$msg->subject"." -FROM- "."$msg->fromaddress";
		
		
			
		$counter++;
	}
	
	$result3 = mysql_query("select `Index` from `indices` where `UID`=$uid order by `Index` desc limit 1");
	$tmp_index = mysql_fetch_array($result3);
	$max_index = $tmp_index[0];
	
	/*
	if((int)$max_index > (int)$state + 2)
	{
		$sms = "$sms"." For more listings sms * or sms index number to view email";
	}
	else
	{
		$sms = "$sms"." Sms index number to view email";
	}
	*/
	
	$sms = substr($sms,0,157);
	
	mysql_query("INSERT INTO `sms`.`outbox` (`UpdatedInDB`, `InsertIntoDB`, `SendingDateTime`, `Text`, `DestinationNumber`, `Coding`, `UDH`, `Class`, `TextDecoded`, `ID`, `MultiPart`, `RelativeValidity`, `SenderID`, `SendingTimeOut`, `DeliveryReport`, `CreatorID`) VALUES (CURRENT_TIMESTAMP, '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, '$sendernumber', 'Default_No_Compression', NULL, '-1', '$sms', NULL, 'false', '-1', NULL, '0000-00-00 00:00:00', 'default', '')");
		
						
}						

?>
<br/>
END OF MESSAGE
</body>
</html>

