Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB220E029;
	Sun, 26 Oct 2025 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761457426; cv=fail; b=o/0H2ncnW8a+1IwnqoXPnA0JpDtTM7YXEWwYOuyXeusJEdAMnc+C3pox7jZYCT1xZndcZ6g5Q4gjqYU9zN7khxgkPL+deSETrzamfpywStgkMNbGv7NTpr4H8YFDyDp6E4I9mtEm3NInAk5SxSLXJrywnwrYOZ/9D2GLJgIYOMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761457426; c=relaxed/simple;
	bh=z4Yqa3ZjHM4tUcegGpplpVgvCF3lWZGThhwmxvuemxc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PZjzezMh26EhT5gJPujbdJ+wep8ZqrlF1hxH8FOfrxmmBcoNZUpRKGbyiV992pNfiMIdAR4po7jjZgDSevVVuG1lD28Pb49+sGxKZ+FyU6oholkkZfrvN5in6cajE/nUkirtDS/OxkFbr37+mnuqWu1WSSQq71FiHtvlIPndafo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UOMe18m9; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UOMe18m9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcCSOFADzF9Y/kn10XCHMeafvV+T492ScIV4RRAAQWTRuhoz8ODYtBNWMuDx0F1EI6fOn39PeyizJpr0c5wZVwXuJjTFXaAHxDxnqq19qa03uifVASX2wdNoyvHw6CNDB9NIPQaRmp5iWqksMHjWa4LOJsQos5h45dBowbZqtC+jo5aLGLSBaQWhVjjq1ckZMTyS/qqzGJT9kNjSyInR7Rwo3TzScFW73v0jI9zSMqZexq4qsSgmcxA481MfNVcf91ip7jePb66dyGbCkcAT5cm6MlDF7phYEthLNyr7Y31VhwFmCpRTRZ8nvwS8QhlIxvPFrjtUjnYWBQ2TPJ47Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4Yqa3ZjHM4tUcegGpplpVgvCF3lWZGThhwmxvuemxc=;
 b=tqXf6GsgEHzUhB0XzgVKoqhFJ0PFoxg60OR6CFu8W1UWrDTEfWGEy/KRlwOQv6ZzWTGun+4DhnUV5YS0R5dJmZrxpIOmY3qiLLqQNaE/27eKsUVNnFqvhMIhOjqnyWfdhNK9bjhloN5Xbr3Mp/BOwo4hAAg9kgbUZ1ea6pv5WQztaYXPPas9qh3jFwwAZQQd43Nus9w0h5WSQRbW1X5viTjfxGP1uBw3E1qbQkGLlWnaEbVA9BPeaxW07reiWSCme30N46IDiuBRdUUprCMTD4zKEUylh6fP/tYuFvCaFJ/iDqJnNHWl44rF+sqZ2HzIDo0CYaxxZwsEFPjFYwXLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Yqa3ZjHM4tUcegGpplpVgvCF3lWZGThhwmxvuemxc=;
 b=UOMe18m9BxiqkmfBsYPfGJO85k0w2tMitnK9QWES3bBWw1o2i3WYzF6hh6rsAdcP7U9nqdBmcUYjwd6AcD+2eUeCDCubL2cXFsThJ7RQVIslWNBvpWaLRl1i9GNwzI8XlKjWv1QfCN407ykHfrFgtLvQa3wx4A8q28eTxxtZCvbfLIsfesMvXHN0qiaGaV9McZ0i/1nLFzrPBk87asV9G9btp/RHggguhigAg+TdeH07RFHLvwVbTbTjdt6SDpHJeN2zxoeD/uX2SQYtnKY+1rJAE9yHp0dC9yi0Foa2pOo0XSissXnxmrKNDKUUsZWWGdJ8yfbyyIM12BqUtiPOwA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Sun, 26 Oct
 2025 05:43:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9253.013; Sun, 26 Oct 2025
 05:43:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: syzbot <syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [block?] [trace?] WARNING in __blk_add_trace
Thread-Topic: [syzbot] [block?] [trace?] WARNING in __blk_add_trace
Thread-Index: AQHcRTuRuF4tdLmizk2cNOZ+I1QUsrTS3e4AgAEBJICAAA1ugA==
Date: Sun, 26 Oct 2025 05:43:41 +0000
Message-ID: <d6df5ac5-6168-4c29-ba51-41c4b587bba8@nvidia.com>
References: <68fc07a0.a70a0220.3bf6c6.01aa.GAE@google.com>
 <c4ea8d7c-e449-47d6-b4a1-54fdbe86ba01@kernel.dk>
 <cc31bf15-5c9e-43b5-9615-2475aebd1d53@nvidia.com>
In-Reply-To: <cc31bf15-5c9e-43b5-9615-2475aebd1d53@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB9275:EE_
x-ms-office365-filtering-correlation-id: aa8a1a65-4e5e-45f8-e953-08de14529ea8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VElVeDNsWmNRK1dOZ3hjZUQ5MFlTejYyQTJjV1dIOXNoYkRHUlV6OUxNTDE1?=
 =?utf-8?B?RmJqcVNoUUNMVEpyRkNsWUJpY1NvT2pub0YvL0xEendDVlNGOVlEZGdjTHlX?=
 =?utf-8?B?cmF1WGVRckhpSCtneUY3VnVRRjJkUWljM0ZBampyQnY5STVwdjQxYldFWHdL?=
 =?utf-8?B?MkdhV2RnNVdLbExmVGxnMUpmSzRZekRiVEZTbHh6eXZSWUZralNaOE1MVTJK?=
 =?utf-8?B?Sm9iWEplMW5KUHY5T1lkbU81a0FMNzdwVlVKWDBRaHFURzUrNjZzZEE5OE9n?=
 =?utf-8?B?ejI2RGRob1lwV3c2NUtiemc1ZTlVOEp6MCs1dDRkVDRGZ1ZVWHB6SDh0U0JP?=
 =?utf-8?B?SFY1VUpvTzNoSnVQNnhsL3hZVmRuZ2FEVGV5Y2NvaGVRNEFzdE9zZ1p4NlRR?=
 =?utf-8?B?cks2aE5YNDFKY3RmSFVETVZncHBGUGNSclhZaDl3YVowbjdzU2IzcjFUKzgx?=
 =?utf-8?B?UHN3dm03QXYxNmhIbkxadjN1dWxYcEN2Y0JrWFZEdHBLS3BJRk9NNXNkM1cv?=
 =?utf-8?B?M1NmaFhTNjAwV1hQVnR3Znh4VTAyWEQzUWVOczhZdElrREsvd3A5MFdqNEVH?=
 =?utf-8?B?cW5PaDl5VkNxWWdUQzZKN3ZOeDN6Qk5kNW1WelRVUFgvS3BQcFd4ZHFSeXlC?=
 =?utf-8?B?QzBTMU9KVis4Q21pZkNwbGNuRUFXNXdLdXBVQTBwb3BqUjcvR1RJaFI0Vnlu?=
 =?utf-8?B?dWxpWkpvVU1QRGExdTFCSjdrcFFzNER2TU54M3dyYm5HYjAwNjFBUGxyY1RR?=
 =?utf-8?B?ZkhsT2hzbkZ2cUVSaTlWM1l6ZG9vT2VEeU5XMlV4SWx0SmdFUGVYYTUzTkxx?=
 =?utf-8?B?eTJYbUVRejdLNXhsdUxzTHh2NmxDcEt3VXNEajNDNURmcG1FS0hNMzR2ZTdl?=
 =?utf-8?B?cTFRejRyUFZLeWZaSjUzQXBRWmYvWkIvVE9oU2ZMTWk1dXYvVG9KbkZlckpU?=
 =?utf-8?B?bFB5bmlEaG5zckwzdGR5Y0JzUkNiYzQvN254VEc0aDRWa29oNnVNdThqWXpQ?=
 =?utf-8?B?U2swbjY2cWNYeWtET280MnZDOTZWTTBkUGFpdWtDSnhOOGlDZDFZbm5XTmU4?=
 =?utf-8?B?clZKZVk2eEFGL2ZmQUg3a3k4QVhYNkxZejduZVBCYkJzNUtFNmtMQ0JkOEhZ?=
 =?utf-8?B?ZjV3TjFucUZyOWRvcDdSdFhuZ0JTWjVPZE8wZm5mRmpNUnI2dmloWlNDU2Y1?=
 =?utf-8?B?TUpzOVhDYVpLUEZJU3hYK0Z0TUplUjRVMkEweStUVkRKbVZkQ2JjUG1hbFov?=
 =?utf-8?B?QmcvK21KSndmbVpZVWppaHFJMHFmeG8xUkh4QWVTWTNlMndlZCt2dlpGTzhP?=
 =?utf-8?B?aGVCSG9OWXZDL3RNM1BNWUw4d0x2ZU04Vy9RbGtZNDZMOFBMVEZ4TkNxcS9Q?=
 =?utf-8?B?S1ExaEIrQkltTXlFdVpSdjR5Q2lQb09kYXU5NFhZK0Q4TW91TXdYaXBsc0Nh?=
 =?utf-8?B?cWRoRnRNUVB5a0RqdVgzMEdyd1dneFlPN2ZoQ3R2UXpFZHpuMnlNeU5tcEU0?=
 =?utf-8?B?ZEl5VmZ1L21ZNzVUMzMxNitIb0t2akFid3NKMjYvcVlUTXV4cTV6ZHhwdDND?=
 =?utf-8?B?YjZKeGM5V1FuOGVkaldheld5dGk4VFp6WXRibS9aaUxsVlN4UWNSWS8vQnRP?=
 =?utf-8?B?d2tHZm9PVmo0c004UjdDTTJJaE10TWh0RDA4Z0g4RWNjcUZwNUt6VExicWxz?=
 =?utf-8?B?bE5CK3NHb1VOeS9UOTZnOTJOK3J1QURENDRYb1o2VDJiQmNiTVE4SndZLy9C?=
 =?utf-8?B?VVROM0xDWmtWTFlGRmpzVFpQeFFkalhjR1dRQWFob2hCTml0RXRNSW9WUzNw?=
 =?utf-8?B?bWxVaW80VFNqcjNkdWdqRE5hN2lYVFlWWGxSbDBhU0xSY1Z3VC9Ibm9RbEla?=
 =?utf-8?B?SSswY1k0RGdjd3hGTlZCSGdMS2phUmlZby9MUmhuOUlpWWNjUnNNVy8ySC80?=
 =?utf-8?B?dXE0eEJ5cnR2YnBWRVlyTmQyMDlWZ2dxSG9ITjhuVmtEYU5FajNUaTE5MGFs?=
 =?utf-8?B?UlNuaWhnNXRnZjA4RVNOeEIvT2lNdGVIUVVEVUtRVG5veDNEcFBMRXRNS3Fl?=
 =?utf-8?Q?i2d7HV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1c4QjMwbUI5MEE0RElPdnRRd01GbEw4VGQ2UC85b0RQWEtSZXF2TjRBenhm?=
 =?utf-8?B?YlAzTjBuLzlBN2Riak90SytRTG9jd1gxLzJkZ1VLN0RaZU4yQzZpWmZUVnFM?=
 =?utf-8?B?Y3ltVlhieWtxQVA5WEJUcE9Kd2F4UDM2NGJ3WFdkNTBkalN4TFJQR0NUNHo2?=
 =?utf-8?B?S0hpRFkxbGx3TkpmZ1gwZVdUcmtVM2RjTFRwbmFRSE93RDIrUEExcGp4d0Js?=
 =?utf-8?B?bGpKS29nQjB5KzhuSWkzYXA4dWNjak9pRERnczIweUUxNTVEaURYa0VRMGZB?=
 =?utf-8?B?S3RZZFVTYURVMkJJdUdWbW5BcUdnR3lvK2YrbytwbisxRktNdnFnV3ZXejJ0?=
 =?utf-8?B?dW9sMjBOaHV0QmxmeEN5ZzF5UXdjZ0JEenc2UE9sYmpUNEJCUThTTmgySVFP?=
 =?utf-8?B?azRNZmh2d0FWeXRrckN2TGRyamFxaGJKVmg1UzNGNStDWjBoQkxWR1NhQ0kx?=
 =?utf-8?B?a1phTGw2MkRVTG1KR1c4QkJqUk1VTk4vR0FSVWRZdE0vV1JGZXFNUGp4bVBO?=
 =?utf-8?B?S0dESkZUWXVTUG1JaXlrTTcxZkR0K3VyUi8xU3NTRUJPM0tDcVdWUkdmemZV?=
 =?utf-8?B?WkpOb1Ntek1KVVNSQnFVNGpCVjMrMzdTc3dkVmJCWnQyczhRT3J4OWZUUDRu?=
 =?utf-8?B?Z1VEcUpGbUhZYWpzZURkQm0vWWpOemtZSG5tOXd1TWx1TTNxN3BjV3p2WmlU?=
 =?utf-8?B?UE1DYmhJdHFKMTFXLzBFN2ptNzlmMjIxKzVWdm5xckMrY2xsZUpJREwzTGsw?=
 =?utf-8?B?c1NZT2pVT3JFVkFXdTBSSDYwdk1CVC8xMG9yMThnT2d3QjBXdUpTNUEyOTZT?=
 =?utf-8?B?NUYxTVU4Vk4rUlF4QkZQVE5FMFJLYXl6dGxCOXkxU1BKdkV0ZnpIUi9tYmNT?=
 =?utf-8?B?dzgxT0dHNkpYZnd4ekJzSDc0Q1VkVWlnRVFOc3VqNlFmRmpXZlVCUnhEQ1NU?=
 =?utf-8?B?VEJndEM1amtvSTRWM2trQjErR3ExSXVhRGRHYzNidU9FZUUwYlFZMFRhZlhM?=
 =?utf-8?B?WW5RcXN4ZGh2dlh0d2xhby8zMVNsRFJpTHlJRkY4ajhDUkpETGtnTE9FMXJH?=
 =?utf-8?B?TXpCSmxzTm5ycEx3R1JFaGEwQjExQU1GN1kyM2VBQWcyZEYxdlo2cWh1OXhT?=
 =?utf-8?B?Wm5QWTZRazNQaStjSDlsOFJNNmlmV2FadDY0L1F4aFlZZi9xS3VOVDZaSjAv?=
 =?utf-8?B?YkQzTVp6V2gwcy9mV1J6aW12ejZoSjgyc1IxY0xoTDVSN1BiOTdhd2wvUXpi?=
 =?utf-8?B?VXFGb2d4VzRlbVVSNTB0bE1YVkNrVkc3eU9Sc3BKRjQ1U2dhUnVBSkpVNkZF?=
 =?utf-8?B?enppRFdrV0Y2YzBsQUdFWElTSXBrTm1UaGhXaXNObi9zUnkwaGIxbE1EMk5K?=
 =?utf-8?B?L005bzB0dkxYYW52Mm9HWjNBVWRJZi92R09xMTNnUEl6Yy9xeFZKNFdqVzZS?=
 =?utf-8?B?aU1FRHZSUEQvTUJxNnlsR1hnTjF1MkRrTGJqREcrbm1pTVk3ejFXb2JJb2pI?=
 =?utf-8?B?YkFyNHVpVlJ0cW5BOUFFY1g2bFBzWnM0dU5MUDFiVVIvTHZIU0t2ZjVTdTUz?=
 =?utf-8?B?MmN3ZTd2Q0Y3NjU5K0JuK2tnQjlYNUtuU2xPeWFiWWVML1g1T3pRMnhHbUFL?=
 =?utf-8?B?bEwrZ2lSS0tMbFBScWV3QmZVL21OWUUzZ1RjMlM0c1JYUk1mSTh2bGJ6VzI3?=
 =?utf-8?B?MjNYMjE4cnRHSmJvR2VxZ08xYWE5TzdxSmc3a0VlMzVUZnFnWmVEYlFCYm5J?=
 =?utf-8?B?OU1nbG5xYmR2Mkh6SHRERVhXOEtxT3lZMU5mZDNoTWpFTW9UempaVzdzc0Fq?=
 =?utf-8?B?SVdha3lPWUY4ODBFNjVsVVppUWRCWGwxT1RrNFBUNTg2d0NhcXZPS1c1UGlt?=
 =?utf-8?B?MFE5ZER6ZExCbWk4ZlMwNkFaZEhHL3psclE3Y3c3ZFpocSs3enRtSXJidkNT?=
 =?utf-8?B?OVRUSjVsaWRzTjFzNjAxTXpDa3ZBUDFsYUp3OFBubnJ5Nkltd1JHOVpHK2J6?=
 =?utf-8?B?NjBGdTY0N3RaSlM3eEI2MTZDOGR2ODcrL1oySnJ5b0VHMTZmeXY4SUpSVTN3?=
 =?utf-8?B?TlVwcGhtcnpVSXNZRFRXbUNpWGhGTzY4WUJLN3UrQVRKVk9KLzlLUytNWlZD?=
 =?utf-8?B?R3JWQXVqckxpaDd1UGNnaFQ1ZUR0Qkw2Z0thOXJVNXEwZ0VBNUlQeituSXMw?=
 =?utf-8?Q?tsTJhYGkhHoB7a4ZFO8zyBwAgPbCbIz3y57XiXPdcmwE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D7A4A3BA940AC4C934153587AD8A8DA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8a1a65-4e5e-45f8-e953-08de14529ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2025 05:43:41.4303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibgrLXiM4k8HRy58au1d/PcNj5Flp6db5+UQ+Q1H26ROF0yDul9yTAFMZO02V7tdpAFeUkgcCHbbFkA5O+ZqeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275

T24gMTAvMjUvMjUgMjE6NTUsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4gKHdoYXQgPj4g
QkxLX1RDX1NISUZUKSAmIH4oKHU2NClCTEtfVENfRU5EX1YxICogMiAtIDEpKSkNCg0KRm9sbG93
aW5nIGlzIHRoZSB0ZXN0IEkgdXNlZCA6LQ0KDQogwqB0ZXN0cy9ibGt0cmFjZS8wMDHCoCDCoCDC
oHwgOTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogwqB0ZXN0
cy9ibGt0cmFjZS8wMDEub3V0IHzCoCAyICsNCiDCoHRlc3RzL2Jsa3RyYWNlL3JjwqAgwqAgwqAg
fCAxMSArKysrKw0KIMKgMyBmaWxlcyBjaGFuZ2VkLCAxMTAgaW5zZXJ0aW9ucygrKQ0KIMKgY3Jl
YXRlIG1vZGUgMTAwNzU1IHRlc3RzL2Jsa3RyYWNlLzAwMQ0KIMKgY3JlYXRlIG1vZGUgMTAwNjQ0
IHRlc3RzL2Jsa3RyYWNlLzAwMS5vdXQNCiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9ibGt0
cmFjZS9yYw0KDQpkaWZmIC0tZ2l0IGEvdGVzdHMvYmxrdHJhY2UvMDAxIGIvdGVzdHMvYmxrdHJh
Y2UvMDAxDQpuZXcgZmlsZSBtb2RlIDEwMDc1NQ0KaW5kZXggMDAwMDAwMC4uZmE3MmY4OQ0KLS0t
IC9kZXYvbnVsbA0KKysrIGIvdGVzdHMvYmxrdHJhY2UvMDAxDQpAQCAtMCwwICsxLDk3IEBADQor
IyEvYmluL2Jhc2gNCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMy4wKw0KKyMgQ29w
eXJpZ2h0IChDKSAyMDI1IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQorIw0K
KyMgUmVncmVzc2lvbiB0ZXN0IGZvciBibGt0cmFjZSBmYWxzZSBwb3NpdGl2ZSBXQVJOSU5HIG9u
IHpvbmUgbWFuYWdlbWVudA0KKyMgY29tbWFuZHMuDQorIw0KKyMgQnVnOiBodHRwczovL3N5emth
bGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9MTUzZTY0YzBhYTg3NWQ3ZTRjMzcNCisjIExvY2F0
aW9uOiBrZXJuZWwvdHJhY2UvYmxrdHJhY2UuYzozNjctMzY4DQorIw0KKyMgVGhlIGJ1ZyB0cmln
Z2VycyBhIFdBUk5JTkcgd2hlbiB6b25lIG1hbmFnZW1lbnQgY29tbWFuZHMgKHpvbmUgDQpvcGVu
L2Nsb3NlLw0KKyMgZmluaXNoL3Jlc2V0KSBhcmUgdHJhY2VkIHdpdGggYmxrdHJhY2Ugb24gVjEg
dmVyc2lvbi4gVGhpcyBpcyBhIGZhbHNlDQorIyBwb3NpdGl2ZSB0aGF0IHNob3VsZCBiZSBmaXhl
ZC4NCisNCisuIHRlc3RzL2Jsa3RyYWNlL3JjDQorLiBjb21tb24vbnVsbF9ibGsNCisNCitERVND
UklQVElPTj0iYmxrdHJhY2Ugem9uZSBtYW5hZ2VtZW50IGNvbW1hbmQgdHJhY2luZyINCitRVUlD
Sz0xDQorDQorcmVxdWlyZXMoKSB7DQorwqAgwqAgX2hhdmVfcHJvZ3JhbSBibGt6b25lDQorwqAg
wqAgX2hhdmVfbnVsbF9ibGsNCivCoCDCoCBfaGF2ZV9tb2R1bGVfcGFyYW0gbnVsbF9ibGsgem9u
ZWQNCit9DQorDQordGVzdCgpIHsNCivCoCDCoCBlY2hvICJSdW5uaW5nICR7VEVTVF9OQU1FfSIN
CisNCivCoCDCoCBsb2NhbCBibGt0cmFjZV9waWQNCivCoCDCoCBsb2NhbCB3YXJuaW5nX2NvdW50
DQorwqAgwqAgbG9jYWwgZGV2aWNlDQorDQorwqAgwqAgIyBJbml0aWFsaXplIG51bGxfYmxrIHdp
dGggbm8gZGVmYXVsdCBkZXZpY2VzDQorwqAgwqAgaWYgISBfaW5pdF9udWxsX2JsayBucl9kZXZp
Y2VzPTA7IHRoZW4NCivCoCDCoCDCoCDCoCByZXR1cm4gMQ0KK8KgIMKgIGZpDQorDQorwqAgwqAg
IyBDcmVhdGUgem9uZWQgbnVsbF9ibGsgZGV2aWNlIHZpYSBjb25maWdmcw0KK8KgIMKgICMgOCB6
b25lcywgMUdCIHRvdGFsLCAxMjhNQiBwZXIgem9uZSwgbm8gY29udmVudGlvbmFsIHpvbmVzDQor
wqAgwqAgaWYgISBfY29uZmlndXJlX251bGxfYmxrIG51bGxiMCBcDQorwqAgwqAgwqAgwqAgbWVt
b3J5X2JhY2tlZD0xIFwNCivCoCDCoCDCoCDCoCB6b25lX3NpemU9MTI4IFwNCivCoCDCoCDCoCDC
oCB6b25lX25yX2NvbnY9MCBcDQorwqAgwqAgwqAgwqAgc2l6ZT0xMDI0IFwNCivCoCDCoCDCoCDC
oCB6b25lZD0xIFwNCivCoCDCoCDCoCDCoCBwb3dlcj0xOyB0aGVuDQorwqAgwqAgwqAgwqAgcmV0
dXJuIDENCivCoCDCoCBmaQ0KKw0KK8KgIMKgIGRldmljZT0vZGV2L251bGxiMA0KKw0KK8KgIMKg
ICMgVmVyaWZ5IGl0J3MgYSB6b25lZCBkZXZpY2UNCivCoCDCoCBsb2NhbCB6b25lZF9tb2RlDQor
wqAgwqAgem9uZWRfbW9kZT0kKGNhdCAvc3lzL2Jsb2NrL251bGxiMC9xdWV1ZS96b25lZCkNCivC
oCDCoCBpZiBbWyAiJHpvbmVkX21vZGUiICE9ICJob3N0LW1hbmFnZWQiIF1dOyB0aGVuDQorwqAg
wqAgwqAgwqAgZWNobyAiRGV2aWNlIGlzIG5vdCB6b25lZCAobW9kZTogJHpvbmVkX21vZGUpIg0K
K8KgIMKgIMKgIMKgIF9leGl0X251bGxfYmxrDQorwqAgwqAgwqAgwqAgcmV0dXJuIDENCivCoCDC
oCBmaQ0KKw0KK8KgIMKgICMgQ2xlYXIgZG1lc2cgdG8gaXNvbGF0ZSB0ZXN0IG91dHB1dA0KK8Kg
IMKgIGRtZXNnIC1DIDI+L2Rldi9udWxsIHx8IHRydWUNCisNCivCoCDCoCAjIFN0YXJ0IGJsa3Ry
YWNlDQorwqAgwqAgYmxrdHJhY2UgLWQgIiR7ZGV2aWNlfSIgLW8gdHJhY2UgPj4gIiRGVUxMIiAy
PiYxICYNCivCoCDCoCBibGt0cmFjZV9waWQ9JCENCivCoCDCoCBzbGVlcCAyDQorDQorwqAgwqAg
IyBWZXJpZnkgYmxrdHJhY2Ugc3RhcnRlZA0KK8KgIMKgIGlmICEgcHMgLXAgJGJsa3RyYWNlX3Bp
ZCA+IC9kZXYvbnVsbCAyPiYxOyB0aGVuDQorwqAgwqAgwqAgwqAgZWNobyAiYmxrdHJhY2UgZmFp
bGVkIHRvIHN0YXJ0Ig0KK8KgIMKgIMKgIMKgIF9leGl0X251bGxfYmxrDQorwqAgwqAgwqAgwqAg
cmV0dXJuIDENCivCoCDCoCBmaQ0KKw0KK8KgIMKgICMgSXNzdWUgem9uZSBvcGVuIGNvbW1hbmQg
Zm9yIGFsbCB6b25lcyAodHJpZ2dlcnMgYnVnIGlmIHByZXNlbnQpDQorwqAgwqAgYmxrem9uZSBv
cGVuICIke2RldmljZX0iID4+ICIkRlVMTCIgMj4mMQ0KKw0KK8KgIMKgIHNsZWVwIDENCisNCivC
oCDCoCAjIFN0b3AgYmxrdHJhY2UNCivCoCDCoCBraWxsICRibGt0cmFjZV9waWQgMj4vZGV2L251
bGwNCivCoCDCoCB3YWl0ICRibGt0cmFjZV9waWQgMj4vZGV2L251bGwgfHwgdHJ1ZQ0KKw0KK8Kg
IMKgICMgQ2hlY2sgZm9yIFdBUk5JTkcgKGJ1ZyBwcmVzZW50IGlmIFdBUk5JTkcgZm91bmQpDQor
wqAgwqAgd2FybmluZ19jb3VudD0kKGRtZXNnIHwgZ3JlcCAtYyAiV0FSTklORy4qYmxrdHJhY2Uu
YzozNjciIHx8IHRydWUpDQorDQorwqAgwqAgaWYgW1sgJHdhcm5pbmdfY291bnQgLWd0IDAgXV07
IHRoZW4NCivCoCDCoCDCoCDCoCBlY2hvICJXQVJOSU5HOiBibGt0cmFjZSBidWcgZGV0ZWN0ZWQg
YXQgYmxrdHJhY2UuYzozNjciDQorwqAgwqAgwqAgwqAgZG1lc2cgfCBncmVwIC1BIDEwICJXQVJO
SU5HLipibGt0cmFjZS5jOjM2NyIgPj4gIiRGVUxMIg0KK8KgIMKgIGZpDQorDQorwqAgwqAgX2V4
aXRfbnVsbF9ibGsNCisNCivCoCDCoCBlY2hvICJUZXN0IGNvbXBsZXRlIg0KK30NCmRpZmYgLS1n
aXQgYS90ZXN0cy9ibGt0cmFjZS8wMDEub3V0IGIvdGVzdHMvYmxrdHJhY2UvMDAxLm91dA0KbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLmExMjJhNjUNCi0tLSAvZGV2L251bGwN
CisrKyBiL3Rlc3RzL2Jsa3RyYWNlLzAwMS5vdXQNCkBAIC0wLDAgKzEsMiBAQA0KK1J1bm5pbmcg
YmxrdHJhY2UvMDAxDQorVGVzdCBjb21wbGV0ZQ0KZGlmZiAtLWdpdCBhL3Rlc3RzL2Jsa3RyYWNl
L3JjIGIvdGVzdHMvYmxrdHJhY2UvcmMNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAw
MDAwLi4wMTlmZjdkDQotLS0gL2Rldi9udWxsDQorKysgYi90ZXN0cy9ibGt0cmFjZS9yYw0KQEAg
LTAsMCArMSwxMSBAQA0KKyMhL2Jpbi9iYXNoDQorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTMuMCsNCisjIENvcHlyaWdodCAoQykgMjAyNSBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBu
dmlkaWEuY29tPg0KKyMNCisjIFRlc3RzIGZvciBibGt0cmFjZSBpbmZyYXN0cnVjdHVyZQ0KKw0K
Ky4gY29tbW9uL3JjDQorDQorZ3JvdXBfcmVxdWlyZXMoKSB7DQorwqAgwqAgX2hhdmVfcm9vdCAm
JiBfaGF2ZV9ibGt0cmFjZSAmJiBfaGF2ZV9wcm9ncmFtIGJsa3BhcnNlDQorfQ0KLS0gDQoyLjQw
LjANCg0K
