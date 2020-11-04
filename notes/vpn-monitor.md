# Monitor Your VPN Connection with CloudWatch

This guide will help you setup CloudWatch to monitor Site-to-Site VPN Tunnels.


## <a name="step1">Step 1</a>  
Here we will setup an SNS [topic](https://docs.aws.amazon.com/sns/latest/dg/sns-create-topic.html) where you will receive notification in case the VPN Tunnel becomes disconnected. We will [subsribe](https://docs.aws.amazon.com/sns/latest/dg/sns-create-subscribe-endpoint-to-topic.html#subscribe-topic-aws-console) to this email address using an email address. Once the notification come to this SNS Topic forward 

* Go to [Simple Notification Service](https://console.aws.amazon.com/sns/v3/home) in AWS Console.
* Click on [Topics](https://console.aws.amazon.com/sns/v3/home?#/topics).
* Click on [Create Topic](https://console.aws.amazon.com/sns/v3/home?#/create-topic)
 * Select **Standard**.
 * Enter **Name** ... ```VPN_Topic```
 * Enter **Display Name** ... ```VPN Notification Topic```
 * After sucesefully Creating the Topic, click on [Create Subscription](https://console.aws.amazon.com/sns/v3/home?/create-subscription).
 * From Protocol - Select **Email**.
 * Enter an email address in **Endpoint** where you want to receive notification.
 * Click on **Create Subscription** to finish.

## Step 2

In this step we will create CloudWatch Alarm to monitor the status of the Site-to-Site VPN.

* Navigate to [CloudWatch Alarms](https://console.aws.amazon.com/cloudwatch/home?#alarmsV2) part of the AWS Console.
* Click on the button **Create alarm**.
* Complete the following Steps 1 to 4:
* In **Step 1**
	* Click on **Select Metric** and from the popup window navigate to the bottom and click **VPN** and select **VPN Tunnel Metrics**. 
	* *Note: Each Site-to-Site VPN connection has two tunnels, with each tunnel using a unique virtual private gateway public IP address. It is important to configure both tunnels for redundancy. You can read more about it [here]().*
	
	* Select the check box on the row that **Metric Name** as **TunnelState**.
	* Click on **Select Metric** Button. This will close the popup window.
	* From **Condition** select the following:
		* Threshold Type: **Static**.
		* Whenever TunnelState is... : **Lower**.
		* than...**1**.
		* You can read more about the VPN Metrics [here](https://docs.aws.amazon.com/vpn/latest/s2svpn/monitoring-cloudwatch-vpn.html#metrics-dimensions-vpn). 
	* Click on **Newxt**.
* In **Step 2** select the following values:
	* Alarm state trigger ... **In alarm**.
	* Select an SNS topic ... **Select an SNS topic**.
	* Send a notification to ... **Select the SNS Topic created in [Step 1](#step1).
	*  Scroll to the bottom of the page and click **Next**.
* In Step 3 enter the following values:
	* Alarm name ... ```VPN Tunnel Alaram```.
	* Click **Next**.
* In Step 4
	* Validate that you have selected the right **TunnelIpAddress** selected.
	* Click on **Create alarm**.

**Note :**
> Repeat the above step for the 2nd Tunnel. 


