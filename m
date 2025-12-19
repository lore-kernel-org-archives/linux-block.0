Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDB1F4606;
	Fri, 19 Dec 2025 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766188240; cv=fail; b=jKndcJl2sGhYvGFDRKBXIyx25k8gQJh3WXgDh3DPO5Eu9SpKaBM2i3FLAqSHwxnkqx6LnuxHRA5FNIsIvvJom6xRscajZg+ZxhfeS7tFuZHfnBXSDyKZVtoJwE6eDFcp6MyMxOchxlJ0eSKjfUUytHnysj0bT2ayMbB0WBm3sZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766188240; c=relaxed/simple;
	bh=wThKGapoi23FJJYXeXDWcC+widakvk2N/lNeIcffHYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KaWyHe89mig+JtnWiKcC1qNOw713hJSpm5xW/gNg6OnA+PuNHrt15R0cJ69tHeI8vpAn37hR1GCfGErSV8zSKu1XMRZ+aH1XiGCh5PtkQxG77mmiDpTKdpCgXGmIT26cSZpp5xOZ+zYYgrh87TdRtzqaXmWh0Cli5VrU7TRVRJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=csdvkTwn; arc=fail smtp.client-ip=40.93.198.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="csdvkTwn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuMgtbPN9JTxCajX2iyCCMEGO2W9F2w3fCS46IlCtLgq83fW0X/T0nPzV7H+bf+PDKd34n/f9b27UEVaKSPPN9ZL6VOCiDMNmoGoe3JMK1zg6FyQVk97MHWz+NayKb1FS80f/0WKDfDP8QbaDn+JxZ8moZL3snn3XZYk+RrPJMjpqi4sii2HuVqoTWKzqWqEvf2xNzaP6vQaPiDtyEeT3BHXsDIS9P4kfASpYSH42z/XXpO16frhHs8QAJ6vo8occoCsrJE2YIt51jKVMWjM7aOsyNHx6kGxvVwZfD2JhmX/AiTsnsBw6XGMieP9XpdgFgcu9JY8KN4LZH2vIPrA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wThKGapoi23FJJYXeXDWcC+widakvk2N/lNeIcffHYk=;
 b=lNsp7rdehoXS6fu2z4ZrTc1NjtA0rwBZwcqfXuxQniWNOW9jFDVmlqi4ameePdacqkSG9pzsYWxsuMSBk6tlqZXoqiT/LPrAZkQBBgU5OnseYEMbxxyaPd4eivTC7yVNHOD6O2rZpzewLqbtHXHhaS4d+JhqW6lWwXFj0jTcSsTjMF+mpgV3crQy26S+ngMuz/VMgYpwgV/XP/5CimM62YUlzip3DKCXLY5w25B+StJUPSBNFoVtHy8ynqhVDr9V9Yo1qkJJKH+ioSjDX3IU8YPegd/zogW9eEtQEsfNnPEwkPvsKu3AZxddjHucRe879rz4vyNFy+MWYaS1Lxm4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wThKGapoi23FJJYXeXDWcC+widakvk2N/lNeIcffHYk=;
 b=csdvkTwncAy5Zx24Rn8RxPfhdmNbp9Itwhn0emW9GFYjPBnSdVuyGrUN/VK2p8LbxgKFEPlNM5Nati46IU1u/mIEfle1LSg4VDhx4teupUwIh5JRpvmkLivL7ct8UiIcBs7/9Z6p5g946t6EyhrEcBxWv/dhsYb/AZ/w0z/FPMd3qjM4vaf+6cLYpYxFPPoluoTEqGej54P/sIMC1s/n2c3Jy15ATPYgVCjjGjJ/Dq5OwdSRVLhglVsCGcOKHv29A8YVUldRBZr9R0tZcXaJHjGB5SEDdoFxoWuRcDHjxY1jJ2+s+smmHdQjVyLvz7yD8gURm18VQJt0GUvobFLFUg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH0PR12MB999113.namprd12.prod.outlook.com (2603:10b6:510:38f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 23:50:37 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 23:50:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH V2] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
Thread-Topic: [PATCH V2] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
Thread-Index: AQHcSDGn6Dwgolv8p0+vvRCHKoVKgbTYr4YAgFFEoQA=
Date: Fri, 19 Dec 2025 23:50:36 +0000
Message-ID: <3bbc39bf-b96d-4d68-8e32-bee5662c0653@nvidia.com>
References: <20251028173209.2859-1-ckulkarnilinux@gmail.com>
 <fc5f6ed4-5bd3-4c4d-82c3-cdab26dcbf94@wdc.com>
In-Reply-To: <fc5f6ed4-5bd3-4c4d-82c3-cdab26dcbf94@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH0PR12MB999113:EE_
x-ms-office365-filtering-correlation-id: 7e24b822-1edb-47e2-2771-08de3f59685f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0NCNHR4TFVFNTNyQk5YRlRrM0ZycVJVWDhNSHN4OThjYU92a2hlTzJHbG9J?=
 =?utf-8?B?TWJGUGlwaEFNdnhNdlNuejMraHVpTkZ3WW9RS2YzNnA2NFBsaTBlOXlDdEJq?=
 =?utf-8?B?Z1JpaUozNlF5SmNhZGNhK2lrNDBpRkdXblZHTlpMUWFINW1xWjZ5MzNoUXRI?=
 =?utf-8?B?SWdxKzRDUnV4WTBtMmVnTmU0SXNRb21wQmw1MzNmOVF4UkN2MXJsenQyL2xQ?=
 =?utf-8?B?RlNETWxmdksvSlRZTXVTb3JzSTJVMmtrNGFBbWVkRGJzSWZGUVhpZ25IdDdK?=
 =?utf-8?B?RW1JY0duQnlONGlVQk85SDlLTnlZaUZxeE81cHBVWFl4TDNYUm1iYmxoa1JR?=
 =?utf-8?B?U0tKRFRKUVZsbEhVbmlBZTgrZlQ4WU1TRVdwUkFJVThlczc2ckJrUGJyeTlE?=
 =?utf-8?B?MUN0WEhlakp3Y2lrRmM3VmF6RFBiNDVOUXl5QmozQXRhZFdpTzRjc28vRG1p?=
 =?utf-8?B?SzU2OHpiNG1iOXlCaGtEZ0IvL0pMUUdQOTVDNDN0N1c5NGt3VllYSEh0dnp0?=
 =?utf-8?B?MWNWei96T2tyTFYwU28wa1NzWk1EM21wZUs3VXZFMDl2blpyV3pBWHVOSGEz?=
 =?utf-8?B?d0Q2NkhCd1lDTW9vbXZtQ2JQWmJ5TTdsVFJiZjlVeklwblFxMGVRcjRzcmd0?=
 =?utf-8?B?aG5sZmNsSldDbVUzTTQyZmtuZUdoSlMzQWxqKzNmTE5UMWFxN294VGFNUHV0?=
 =?utf-8?B?bm15UzJCaW5oSjdTZ3NzanJyNitkRTZFclIrRFREWmh6M3dWZmNiTjEvdnlo?=
 =?utf-8?B?Zll1Q0FmWWhNL2crbStDN1g3U210TzJndmxjNzU3RWZlSyt0NytDMXdHVnJi?=
 =?utf-8?B?WVEyQlRZMXhuWXU1R1ErelpldldtN2pDckswU1RHZU1iMXFPSzVjQ2pWcldO?=
 =?utf-8?B?MXBBM09zR1c2T3YyNmJ5U3cxbHE1ZmtxUG11eEJGNGNyZHVHdjZXb0Zpajh3?=
 =?utf-8?B?dDVoSm5aRjBFOGxzc245bis3SFZ5aENsMjZVQXNSd21qN2JmbnZ4UG53bDNH?=
 =?utf-8?B?dFA2UUlRSjVPeE1hOE05WE8wY3FnVnpTRE5vdEdiTDVCWU00K3FuOWhocEJT?=
 =?utf-8?B?MzBybFg2Nm8xOUFPOVlXYitGK1ZYOFhhR1l6dW16NUxBOFJJNVMvbnZYcEhi?=
 =?utf-8?B?UFJFcGN0MjJ1cVRQVmszRmV1dmFlRjRFejN5OUNkVDZnanJNOStsOWhPNUVG?=
 =?utf-8?B?eTBjMEtXYkZpUTAyZWRIejFMUFphandiRTlTU1d0a2JVZ3kzdGs1M2h1WXhh?=
 =?utf-8?B?R09nSm1oK2twVFYyM0ZFSVB6Mldkc0YvdVR1TVB0d3VZT3VmUmNZNjRpS0Ex?=
 =?utf-8?B?WjR4aVVnUjBrcmRtNmRUODQvOGhrSmlMWXZEVytmZFVaQzFQQjhqam1kcDJY?=
 =?utf-8?B?NzJSQjVPdnBjZWgxTEMvRDlpcFczUGJzeXBmYVhhL25RclVZcHM5ZUtnYjcy?=
 =?utf-8?B?eEdqTDA2R1VpajlHRlJzK29VU0dWWG1RSytUeU5DTzBzLzJtMFVNbEhZY2N6?=
 =?utf-8?B?U1ZTU3A1MGlmMUZHNkpsS1ZIcC9IQ0xDRGdrMTB0eWpoTUVOZGxLY05ncG1l?=
 =?utf-8?B?bW1yd3NxTnhPdmJ2Um9Ic0wyaEJINzNnSVlNd0pyWXdCVGtaS3JNaHRFNnFl?=
 =?utf-8?B?UG5OZmh3a1JRcDJNRDFsWXdjaXJ3Z2tFWEJ2VkxyQTViRzNvZ1JwTWlJWXJx?=
 =?utf-8?B?ODVzczgzdGJUa1h3bDZIY2hxdFlIYUJQTVlsUk5UUTBleDk0WGsvaDkxZTY2?=
 =?utf-8?B?VmpXdVdKbnFMUXYraVNpaVp1SUVyMlRwRFpRaGZocFExUlJuVExVc3JnUHFI?=
 =?utf-8?B?aWl4Uk1zT1F3MkZCTW1XZXFZZVNPb3ZHNG5TNDFoSVMvMUVzQmlIeHMxbVNG?=
 =?utf-8?B?L0RRdUxzOUVvMHVpeHJraE8xSTJXL053Q3dEOXpKQVdYZ3RpRDNkVTA4dE1w?=
 =?utf-8?B?SnhadmZYb2hlODlQd0hCTjBkTlVqQjZPR291SCtUMHpBTCtPdnRvQ2FJc2Nm?=
 =?utf-8?B?VE1uVWZ6NlJoTm1BVy9MWHJObkdBVHMrNVI5L2xKOTU2QUNlOFVTYVlRN3lI?=
 =?utf-8?Q?F5/Df7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VExLS0dKZWxpL3NoYzFQWlpSNHVGRGFTY1A1RnBMUi81OW9EejY4T2p2ajlL?=
 =?utf-8?B?dmtsaW5DVXhIdENLVEVJYXhlWVNpU2czTzRsem5TM2U2L2Yza0xleXJneDNG?=
 =?utf-8?B?aXZRR0RGWEVNMjdxNnIvaG9Dd0JPbXZhOTJ6amNRQ1l3dkp5SFlaQUQxVWxE?=
 =?utf-8?B?eGVCLzZSekdWQXpDcFNrSTJ0ektaR3g5OHF1TlozUkR5WHhYSms1d05WZEc5?=
 =?utf-8?B?Y2hYVnR2dWkwZWNNWDc3WDMzd3phS0hEemJvdFVibHdMd1RJTmJVZjVNV3o2?=
 =?utf-8?B?U2czcVcwQjFWREcwNXhtTDJVSWcxZEVJWjJjQW5xbFE3U0V5K045L0I1UXBx?=
 =?utf-8?B?b3d2cnhDOVF3Rm9aOTJOejBtYVBQQVNJektmZVYyUWpLRG1sYVFGbUxOODg3?=
 =?utf-8?B?YVpIZjdNMWUrRDF5eXFHei9UeGEweGNXS0dCeU8zM29FbVYreXM0WGNDdXFn?=
 =?utf-8?B?TnhmUG9LSXQydm4wU0VocEVOQ1FCbXo3cDN2R1lWY3JIc2wrVHlSdGdoeXph?=
 =?utf-8?B?ck1PaFUxT0YwZVVFRXoveEJwR2xTcGJYVmRPM3I4TDhGVUhNcXM0OU1oMnBS?=
 =?utf-8?B?TWxwUWVKTHJ1eVpwL3R6RGpoTGZzV1pveDhpREhwYVlqTTVrOVdzbmNjcjZh?=
 =?utf-8?B?T0thYnhEcE1vbjlQQVRyaHNIM2Z0azJ1SzlwVXVxODZqNUcxdC9pWmxXMXFu?=
 =?utf-8?B?a1E2bnV5S09iMHVjNW1PNEs4bkFmT0xXcU1NTWtxbm9qczhIQnNMT2gvVEQ3?=
 =?utf-8?B?Q2loN0tNNzdRVnJjN2h5UGVmNWZDcm1TSVhrdnR0ZnhLRDd6RDVVOE1iVE1V?=
 =?utf-8?B?bmZ1a0FFa1RzSk5ieDdQWkVuRnRieVRLZEZzVHd5ZWxnN1ZaWE8zdEJvQ1Ra?=
 =?utf-8?B?SWhYQkpMZUVkam9XZUV5SGtkN3pLTHZobUhFOWNYbUVWYzZjNUEyUjRyWTRV?=
 =?utf-8?B?UENrcm95WE9JeksrU0VScUFvdWlVUzB0N0dPREdLVHozNUZGVHZqRGwvM2Nk?=
 =?utf-8?B?S2lnR1Foc1QvQVY3dmNoRnBBOEVPMHFsVUFwb0U5ZXRNY2JOM0hCUm5SRThZ?=
 =?utf-8?B?bGpTOEU0YWdocDhaOEI5T0Z4cWptM01SaWRBRmUyOE9KSjJVWCtndDAveEFu?=
 =?utf-8?B?Y1FVc2J5VXVKblVFRklVU2JPYzlxOTBKV2xZTk1acDF2UGFkTC9hb0F4Qlpx?=
 =?utf-8?B?czhzZWZ0UDBiQVYxL1ZnUDVxRHo3YnlmdE81RkI2REV6Q0FPa0EzOHIrV0FK?=
 =?utf-8?B?THBINmZFeHhpdWV3OHk2QTluV292UWFDci9mNmFsVWlTL0l2aWx4QjZHMmZV?=
 =?utf-8?B?bkJSeXQ0R1BZQW56OWdEQ0N5NGJtcmd1MGtFMHJlZXdWNWVlVlFra0ZvOTUw?=
 =?utf-8?B?WHdzc2h4cVM1UVVubFl5cTdrSVl4UGRpczNvcm40MlNOU0k1S3MxUGpKaWc2?=
 =?utf-8?B?cGZLbUZnbWJBcG1WTDl2SU9LYWJvVHhGdUd4azBDT3RCMjE2OFlEUTVoSS9J?=
 =?utf-8?B?U3l4TWphWDdCb0VFQXFCOWM3NGVobTVVbDB2OS96VUpFZUtWQjdCRW5naGZ6?=
 =?utf-8?B?eHZjQ0JYQW8yMVowaS90YTVROVhqQ0RDUjVVRG1TNk54YStZa2lWRDRvS1Na?=
 =?utf-8?B?TUpRN0NvL0ZHNU92V0FGeXVKNjJOcTA4M1hmeEw4TWFsL24xc3o0MFVSQVZU?=
 =?utf-8?B?RnFXd21wdWFOMmFtY1EvWXQ5Nnl4REJiZDBVR3RGdEZtVlk5S1BsVm5RbCtu?=
 =?utf-8?B?dC9teURmSjdIbTdLTTg0L2FTRnBNd21YSGdmUkVGa0tROGl2QURiU2p1dHJq?=
 =?utf-8?B?SmpSL1E0UG5IWWM0dnh6Ulo3S1h1aVNQTnVZWTFVRkw5bWlRSlFwUWNqdTZD?=
 =?utf-8?B?VzR4MVoxMHoxYXNaVWkzUGEyTk1RU1pDOWhGRm52SjlGSFdzcjhieDZQUndY?=
 =?utf-8?B?TWlFbzFiZFdIb2xWa2V5aFNZc1p2MWpYTkc4L1pEU1RpSEdvT1B2V3pkV3ph?=
 =?utf-8?B?U2lQdTZpTXUzSnMvWFRwcHgyVGdwWGRlcW5mdlVUVWswUXdlamkzV241cE9l?=
 =?utf-8?B?aVZjOTllVm01VTR4UE14b1JOUkdRODk2U1Z6NWRRRmZIM3czWmp6cUQ5UTY2?=
 =?utf-8?B?RnlJUVMvVzM4TkZQMjJ6WGRvVGZ6MFpRdzVoemR6YkRybU1NeUt2OFkybElv?=
 =?utf-8?B?b0R5cFZlQm5EY0hLcGJ0cXdkNXEwUkJmM1Q5WW9Pc05qZSsvb0k2WVlGK3Iw?=
 =?utf-8?B?aUJEU0xCVVF1bThnZ1hOUWhCdm54UGd0Vk9MZlZXRFY2MVNIZE9FOEJNNGto?=
 =?utf-8?B?bDdMTTh1NWRtek03aEZXbUwvMjhIOHdBTFlyZy9zdWdLSndrTi9EcnRwMmE4?=
 =?utf-8?Q?nAaLMel3BImdkpoTShggSUDBEl2W8dL19CeVRLZQ9/HMr?=
x-ms-exchange-antispam-messagedata-1: 3h+ePw9jtppulA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <406312288C97534BB24DD56088E93B54@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e24b822-1edb-47e2-2771-08de3f59685f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 23:50:36.8500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8H9jwkyFDaxJbUj5x4Ia9q52sZuehxBZpG3QZeXaeTPIXowdfQGwLaK4jEpQK30LX+PIsPjgImSa+ireQLMMWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999113

T24gMTAvMjgvMjUgMjM6NDcsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gT24gMTAvMjgv
MjUgNjozMiBQTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gKwlpZiAodmVyc2lvbiA9
PSAxICYmIElTX0VOQUJMRUQoQ09ORklHX0JMS19ERVZfWk9ORUQpKSB7DQo+PiArCQlwcl9pbmZv
KCIlczogYmxrdHJhY2UgZXZlbnRzIGZvciBSRVFfT1BfWk9ORV9YWFggd2lsbCBiZSBkcm9wcGVk
XG4iLA0KPj4gKwkJCQluYW1lKTsNCj4+ICsJCXByX2luZm8oInVzZSBibGt0cmFjZSB0b29scyB2
ZXJzaW9uID49IDIgdG8gdHJhY2sgUkVRX09QX1pPTkVfWFhYXG4iKTsNCj4gSmVucyBoYXNuJ3Qg
bWVyZ2VkIHRoZSB1c2VyLXNwYWNlIHBhcnQgeWV0IGFuZCBJJ20gbm90IHN1cmUgaGUnbGwgYXNz
aWduDQo+IGEgZGVkaWNhdGVkIHZlcnNpb24gbnVtYmVyIGZvciBpdC4gU28gSSdkIHNheSBob2xk
IHRoaXMgdW50aWwgaGUgaGFzLg0KPg0KTm93IEplbidzIGhhcyBtZXJnZWQgdGhlIHVzZXJzcGFj
ZSBwYXJ0LCBtYXkgSSBwbGVhc2UgZ2V0IGEgcmV2aWV3ZWQtYnkgaWYgdGhpcw0KbG9va3MgZ29v
ZD8NCg0KLWNrDQoNCg0K
