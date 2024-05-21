Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2048.outbound.protection.outlook.com [40.107.255.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77155E43;
	Tue, 21 May 2024 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716290742; cv=fail; b=J/qhtTNDVSN8kPjkYoU8iHrhc7IBx0tt2JWO3aD+94Yo8ZKj09Oya+yxg63Wl9dUaPezeJQPpFVrDMpEoPcV2tCWkufS2jauoqP5dGZlLK1ruptiolD7MRWVxFvTv3oA5r2E1h5KSPATYnaqUZ7T/U1kdz8S0QScpSyXsHuNcaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716290742; c=relaxed/simple;
	bh=ZpIrLgJUKrwvfqMe3lm9VFEaLWnImpgqp5aWlpbOGaA=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YTz1NRLfDKRRZXgdJnrtj8scOUKzML9RIlfNnsVrgWRFTTNA7mT0pJVpNQ+yEDSKdi0g/sUFp03+/bUEea4MfQAYFczsMLQGzYl9p+cSaQCyRcmf9PHXKg29y+K43FczUqPdHavserqlc+7ErrJw88/jh+JQ5OWPXEZOM/wyKx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=S01HivuY; arc=fail smtp.client-ip=40.107.255.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="S01HivuY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDbx1jlBe2hrRQec98/OlHgoXCz4ARRcJFYB0GWhGMJ6YnB6jGevOaqLgKhwXY09X8kQ7GzRuWRXINTm1jNe3APZpJxHupY84g5nRFRpvZz+tPSsl84CVymbklpcMJTs0oQsIUc+YEhenoWpSqP1HiEAxNxN3catIRm4E8lRQPCZLapH6camn/lfyMF0XWMPAir4wyCeJZEr8kxgvRWs6eqIgAXjs2fwElZAPTQlKrfe10Y+jwdgo+CqSzc3Foq5SpM5pDMOqt4N0YWitlkLmHqZEP/lyYVpdlTMCUCzsrcpdEEyIbNTkdihHu+pb5DngUJ7pZ/tDwUQDecB4+70pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dr0twSVQJW9srZdQ8YiyU2z3PVf3Xac2pWznTxNSH0M=;
 b=V/LNsaKGMmkrh57M1ARhRXNjveK8WE++iseyCmgofgFCn97CKRHKy7Mg7WJlRV6L4N5aQ5qeQ1B7eDh+zF3oYHIUI4uW+Z9VryO1LmDDVcEQ66rNViHtMjJ0m3RweLaDnx9ghWRiMaEPqdCXCPnjm18ztPzUqgA68LRxA7WPxdOkp8YxccxjHL1S9husqdSK4ILJfpYoEM9WUK05lqjz3JyCDINIUmt3v2z7ASPHWSn7ZRFLWYFHy2QBQ+F+wO383UMrkdFrnbdgeiAZ925reVhfPx5UhbUmByn2GJcVK++1yFmRSYpbF0YVoRo7HQzTL9Pv/4oefo0W0lGHzk8T+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dr0twSVQJW9srZdQ8YiyU2z3PVf3Xac2pWznTxNSH0M=;
 b=S01HivuYtfaJRKV33ofIqu6xOm9VcbbBWecxLl6HDW7OCR6hLFXXE8rlAsz4ieKVGvqCxR4lB3+rfDJrNZ7/jFHvNqZi4NNQ2Hg0EK/q43bCO4Q1jzOif4cGFx8NWC3B4sxinRIvljsGCWH7tvZ5LoRuBqVmQ84z8BrtlcdZLeXoizw+6Vek35jX2FpRq0avhEM7ZIs82lG2+T5DEOPFZhNjxsCaGACGlQbagGfr1kGTK8uTbjA2hEbCwbEmTgZWhlIN+Lu3wsBDONabtKpoeG7n++ma9siuOY7vX3KGU9zFxMeF+Cvw2dk10QgHeWviMSOchJmKGzvU1By0kd2YIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEYPR06MB6999.apcprd06.prod.outlook.com (2603:1096:101:1de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 11:25:34 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 11:25:33 +0000
Message-ID: <de0c70fc-4965-42e3-b621-b5ffeb3bbc84@vivo.com>
Date: Tue, 21 May 2024 19:25:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] blk-mq: fix potential I/O hang caused by batch wakeup
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240520033847.13533-1-yang.yang@vivo.com>
 <24d4d60f-05f3-472b-8dfc-4edcb5f7883c@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <24d4d60f-05f3-472b-8dfc-4edcb5f7883c@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0187.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::8) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEYPR06MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d058ada-e9c5-4bb2-0646-08dc7988babe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clFnaGFvNnJCSEdTYVJSQk85cnVHQm42R2lRTXJIUkMrbVJqZC8wYnU1QVRQ?=
 =?utf-8?B?Y3BtNVYydnExRUd4WGxqa3lNSnhlZEFyY2s5ZG9Xb3I5dkNvbDVtZXplVXY0?=
 =?utf-8?B?WlZzQ2VodmpsU240ai92Q1M5V2tPN1JmS3laOTNQNWY4NStVVWJSUThYbzlQ?=
 =?utf-8?B?c2k0ZEUyVFZTMGdwOTFxdnZmSFVKdDRPNkNnMU1PWDZBNVV4Y25TbHAyQmww?=
 =?utf-8?B?TXZhUTA1aFFDYWt1cW1mSHplWTB5UmYvaytyRTVKZ2ExQ2w3c2wwV1c3Qkcw?=
 =?utf-8?B?TWRBLzlZMjJhcWxBSStrMitaOUNqQnd5ZHFFTGQzZEEwdW9QTEo0Ty9hVEt5?=
 =?utf-8?B?QXZNOS9iVnRQVStGVTdKcWNTVVMxOVR5UHhURHRrNnhrejkrTk02Nmk5dVVB?=
 =?utf-8?B?cHJUUVJTeUJKaVR2UkpNYW9ZRmYvZzFNRGZuSXBKVi9UOFY2OVRrVEQ3Vytk?=
 =?utf-8?B?NHBZb2owTlFqWlo4YlJNeUQ5OW9XMHd2L0phNUtXOXBPTi9JRXNKbVQxVGtY?=
 =?utf-8?B?c1R2S1EvcmpRRDFhVUR1MzhZOXk0ZVF2ZzF5ZTRkdnQ1UWZHWnVrQWc0Z0Va?=
 =?utf-8?B?bVd0Q2tqOWlJNW5WUGZYS2g2RjlQTEhPcTY4c0hpSkVxRFB1SlFTZ05TYllt?=
 =?utf-8?B?ZTB2ekY2NmhJY2hEM2VON2laMGpVL0VXb2hRcXFocWJxS0xWbjNEM2xPZUw2?=
 =?utf-8?B?S3hNcGdUbWl2S2hXR0hxSzRxZUM5VHNBeVhobjZubENxZ0FVbXByTGUyUzNa?=
 =?utf-8?B?TjdPOGdvRGhCRjV5QTRGRGZoUWRqNTljOFA0WHA0OTZrS2lLUHQvdVl5U25K?=
 =?utf-8?B?Q3JRTW5EaGFvN0tmMlZwUndUbWJOY2NLbWk5N2k2YzVWT3ErdWpkS05DZ2F2?=
 =?utf-8?B?TE9IbU5uZjM1NWxhUFBwNEwrOEJQSUYzV1N1MlFtRDFjYjlGU2VRS2djc2dG?=
 =?utf-8?B?WFU0MEk0Z2RGVC96U3dhNi9idGgwVko5d1M5bDZFVHI0MWhwSUhNLzBXNUxO?=
 =?utf-8?B?ZHBkVHpqZUFIWUtMRkNpQnBjajYyS0tKSVFxTGFwZ0M0QW9sZjhHWVRnUzJt?=
 =?utf-8?B?SGJtc0ZGVW1DdVc5NnJzb2hVL3hwb1ZQMjJWU2ZKRmozSHBwSWF0LytXaElt?=
 =?utf-8?B?SFVwVUtYVXVVSlU2VWUxRUp3NFNiZkdHODBvNDF0cFRUd2IxREFKNzRRc1Rq?=
 =?utf-8?B?WjFrVDFCdlZhaVJrblZaVzQxL0NWZlA0VFBJU1ltUTB6eC91OWhIYVpVT0or?=
 =?utf-8?B?dDZpTU1ESTdIMG1DUjh2NG80TFRrQ3NzUm1FVVhNUnlkMWRyVTJQblFraHg5?=
 =?utf-8?B?NHRYeURCUGhnYnN0c09VRGlmMUlQbno3b2YrcGVqKzVDYWlCQ1U4Sk5OVUNQ?=
 =?utf-8?B?bFNnZG55Z3h5ZXhNWHpUQU9VYmVCRFdxM0gxQXN6SDdKRVBPY3NGc1BKUGpa?=
 =?utf-8?B?ckRqQUFDMU9PWXRxUWNLWTFMaHYyV1pZbHVXTjFvTTN0UGR4T3pjRHdCVldP?=
 =?utf-8?B?LzZYODBiUG04REZwVi8zbHRnSXFxUmZCSldQMldVNzRlc2tST0FINGJmYTRr?=
 =?utf-8?B?bWM1OFAycVFmSjFpMXcrUVBrM3VqVElqQUVZcTRxQXVJb1AxMnJHQ2FDM2tH?=
 =?utf-8?B?Q3J2bGo5bzJ2WXhTc25ieWtXcG1yN0xhVDdLY1dVNHZmUEhzdlJJSVhEdk53?=
 =?utf-8?B?cGRwbUdmL0NHUHdzSzNQUzBid1pJb0R0RUJUcXhrZVduUlhta0ZzN3ZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmxxNzRka0xjSEFLK3MrRlVuN1VJd2N3WmNHWWFBZkt5ZTQwdDdKNVNJWlFk?=
 =?utf-8?B?eFhjdnJJNVZFL2pSZGMxN281bUtQOWxrRnBvWFZQdnV1Y3NTTUxvNUJzTFJD?=
 =?utf-8?B?SmxnT3dyNWtraGxPK0J2S1MwOWtVVHVhSVhjR241TzB3MHFURHpMVzg3aVlO?=
 =?utf-8?B?SUlZaFVlUTNMVlpyajgzMmQ5ejBDVzd2WEF2aEpUSGNqODRaS3J6VVVYUW50?=
 =?utf-8?B?cFR6NDZvNUY1azZIYjdiNmhTZXpGcTB2ZzBHeUpnU1h0MEg4dGZyQzhKUHFY?=
 =?utf-8?B?cEJwUHJSdVJuYTlJOS9oaVFFN1RRK3JNUTBOMUZVZFZHSXVBRDVoeUVUMVlC?=
 =?utf-8?B?UFQrL0hHZzdBejVuUzNUYUl3ZU5sdGlkU0orUXhLWVNFMEI4eHZvY1prNzI1?=
 =?utf-8?B?K3o3T1NLLzZoR1FYVFltKzR5YmZEUlVtSHRLQmdQbWtzWjY2cnNIaThUSWZG?=
 =?utf-8?B?cnIzbkdTTDUxdHROcWM0Uk5Lb1hCM0lnZmplNlJWMWhtc1dlemg1TXBOckla?=
 =?utf-8?B?YXd2RWRjdmYzM0xXYnEwdVFmeE11aEo0SjZwNjJUM2lKcWNFTjNEOHJNSGgy?=
 =?utf-8?B?SU9CcS9haGFDQ1VUaDJCQ3pKYUZXQmpzZy9UOGtiUWswdng5T1NFbGIrUnpj?=
 =?utf-8?B?TDM1NjdOVENnWmRqL3JCcU5ZL3BWRXlreHNxY29WdG1FWER2bmtRTUN3K0VN?=
 =?utf-8?B?WnRrQk5LeHRuSnNHMy94SENVbXExb1VWOU1LanpkKzdpa2NuTUl5ckZJbTlB?=
 =?utf-8?B?UW13bTcvK0R3MDdsUVBVZGtCdnhtWGtMZnBqcmRVN1ZaMFNHaE1jamJuUGF3?=
 =?utf-8?B?K1pGSkJwZ1ZGUjhCMFprM0h1Wi8yRGlXRkxlditZcjZKTU9TNzBqVmI1M0ta?=
 =?utf-8?B?QWVrZnI5d010eGlWUzdleWVxQTNUMjNqUEhsdHZjR2I3RjNhU3dzT2lZWDNx?=
 =?utf-8?B?Y3JJMWR4akx3ZE1xOGFqOFJmMEpIbjBJd2k2NzhOdFJpVVh0ZDNEM0o0TWMv?=
 =?utf-8?B?SUMwZkF6RmtvUmRGb2FYWGdobU1Rczh2OFcvVkc5VlRJVWhTSk1CTGdsQmps?=
 =?utf-8?B?VDVibFB6KzczbXQ3Z3RRRDFFTzZKQWp2SkhIRnVZeGtpQTQ1cG54WVNoeVFC?=
 =?utf-8?B?VGJUSWRXK2JOK3krbEhyV0YvWG5HYnFaMnRQS00vN0dhbDhVTFRyeXk3V2R4?=
 =?utf-8?B?SEFFbUhPcGxJd0dWeTdPclNxQnZwMEtVa2NPdkEwTzF3V2tDTlJMdklnSVNY?=
 =?utf-8?B?eStnVlVwcGFBS29yVEdtVWdtNE1OM2I0M3hBSDNUZzQ5NEdIdi9VOTlENkNu?=
 =?utf-8?B?RDBQRmdvRmw3bDlIRDZiTVBoV1drT2ZWS3htYTJUeXhhNVFNV0RmaXlFcktu?=
 =?utf-8?B?aXUyblZUQlROWkFVb0lsLzZmNFZQUGxJS01TbDNJK1NYMDlwcU1uUTJOU2VG?=
 =?utf-8?B?RCszZ29ONEFOUTJCNlNzbnNkU0hqdVE5SmFwYVRWYkZIRWk1YTVPUDVqWnlN?=
 =?utf-8?B?Sjc5RXBQNUsveEs2N1RoYU93SHptTStkWGJ0blhDVzB6MnF4cFdJMDhFcmNY?=
 =?utf-8?B?eVNYcXlyYmJyVGtZMFZ3Z0Y2cUNweUkvdUlUYlV2SC9HcHZxSVA5bnJMOTFi?=
 =?utf-8?B?OElaZGVPaStXN2VJWk02eVZpVEJVS25xbzczWGt1MUZ0L1draUZTelVrTHd0?=
 =?utf-8?B?MmNjNHRkTjZ6UHFEYkQwQThJQU1SSDkxOTRrVEh6cUo5MzhveEpZUmRLRGV0?=
 =?utf-8?B?RWRrWnp0S25Pd28yRUpRaHVlMjVKdi9ZVWUrS05haTUwOG43cStva2E3RmtV?=
 =?utf-8?B?ZkN2NndJaGoyN3owK1JMQWVtTHlZYXVDOFpjYjJqSGNEWFBWdnh5ZlJtME9P?=
 =?utf-8?B?cERNaVlUN3RVU1p2NUZ2OUUyM05GVElvRU5rQVpqeGFnWDNHNnBsUTdhcVFp?=
 =?utf-8?B?UUdRNktlTmwyczZKNlBkYlNUYWhWaXpxVXRpRzlOODEzWTkxMmhKWTVxbWNR?=
 =?utf-8?B?NzhaTWdQS1ZCUVBMOG9zVEdneVhhaU0wZVFoRllOQUJXSnZ6cmFRYUpzL1pm?=
 =?utf-8?B?elFYVE1XMU5JMjZQYlhPc28rWllTY2x2cmFNZE0zZ2dkVytoMDVvd1VBb0Er?=
 =?utf-8?Q?yulHQNwzdsDfD5LDjwNtUnqYX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d058ada-e9c5-4bb2-0646-08dc7988babe
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 11:25:33.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +drSKikW231MztHej+sWMvQLAjfsSwwrtc2GE6NOkYbtGyJVBrSdfaUscfSPd/8aM5XFW+118XVAaPZMDi4ELg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6999

On 2024/5/21 2:11, Bart Van Assche wrote:
> On 5/19/24 20:38, Yang Yang wrote:
>> The depth is 62, and the wake_batch is 8. In the following situation,
>> the task would hang forever.
>>
>>    t1:                 t2:                          t3:
>>    blk_mq_get_tag      .                            .
>>    io_schedule         .                            .
>>                        elevator_switch              .
>>                        blk_mq_freeze_queue          .
>>                        blk_freeze_queue_start       .
>>                        blk_mq_freeze_queue_wait     .
>>                                                     blk_mq_submit_bio
>>                                                     __bio_queue_enter
>>
>> Fix this issue by waking up all the waiters sleeping on tags after
>> freezing the queue.
> 
> Shouldn't blk_mq_alloc_request() be mentioned in t1 since that is the function
> that calls blk_queue_enter()?

  t1:                      t2:                          t3:
  blk_mq_submit_bio        .                            .
  __blk_mq_alloc_requests  .                            .
  blk_mq_get_tag           .                            .
  io_schedule              .                            .
                           elevator_switch              .
                           blk_mq_freeze_queue          .
                           blk_freeze_queue_start       .
                           q->mq_freeze_depth=1         .
                           blk_mq_freeze_queue_wait     .
                                                        blk_mq_submit_bio
                                                        __bio_queue_enter
                                                        wait_event(!q->mq_freeze_depth)

> 
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index a16b5abdbbf5..e1eacfad6e5b 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -298,8 +298,6 @@ void blk_queue_start_drain(struct request_queue *q)
>>        * prevent I/O from crossing blk_queue_enter().
>>        */
>>       blk_freeze_queue_start(q);
>> -    if (queue_is_mq(q))
>> -        blk_mq_wake_waiters(q);
>>       /* Make blk_queue_enter() reexamine the DYING flag. */
>>       wake_up_all(&q->mq_freeze_wq);
>>   }
> 
> Why has blk_queue_start_drain() been modified? I don't see any reference
> in the patch description to blk_queue_start_drain(). Am I perhaps missing
> something?

blk_mq_wake_waiters() has already been called in blk_freeze_queue_start(),
so I thought it can be removed from blk_queue_start_drain().

> 
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 4ecb9db62337..9eb3139e713a 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -125,8 +125,10 @@ void blk_freeze_queue_start(struct request_queue *q)
>>       if (++q->mq_freeze_depth == 1) {
>>           percpu_ref_kill(&q->q_usage_counter);
>>           mutex_unlock(&q->mq_freeze_lock);
>> -        if (queue_is_mq(q))
>> +        if (queue_is_mq(q)) {
>> +            blk_mq_wake_waiters(q);
>>               blk_mq_run_hw_queues(q, false);
>> +        }
>>       } else {
>>           mutex_unlock(&q->mq_freeze_lock);
>>       }
> 
> Why would the above change be necessary? If the blk_queue_enter() call
> by blk_mq_alloc_request() succeeds and blk_mq_get_tag() calls
> io_schedule(), io_schedule() will be woken up indirectly by the
> blk_mq_run_hw_queues() call because that call will free one of the tags
> that the io_schedule() call is waiting for.

This patch is a workaround solution. I think the hang is caused by
a lost wakeup, so after blk_mq_run_hw_queues(), t1 is still waiting
for the tag.

     bt = 0xFFFFFF802F9C6790 -> (
     sb = (
       depth = 62,
       shift = 6,
       map_nr = 1,
       round_robin = FALSE,
       map = 0xFFFFFF803BF97000,
       alloc_hint = 0x00000049119B3F4C),
     wake_batch = 6,
     wake_index = (counter = 0),
     ws = 0xFFFFFF803BEBCA00,
     ws_active = (counter = 1),
     min_shallow_depth = 48,
     completion_cnt = (counter = 1),
     wakeup_cnt = (counter = 0))

Upon analyzing the coredump, it was noticed that sbq->completion_cnt=1,
and I can't figure out why.
blk_mq_put_tag->sbitmap_queue_clear->sbitmap_queue_wake_up(sbq, 1) should
be called multiple times, considering that sbq->ws_active=1,
sbq->completion_cnt should be greater than 1.
Looking forward to some advice from block layer experts.

Thanks.

> 
> Thanks,
> 
> Bart.

