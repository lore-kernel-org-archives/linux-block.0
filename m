Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF882D2494;
	Wed, 29 Oct 2025 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761720484; cv=fail; b=V1GPOAxNI8mzT3R/KRS1maVuN6PJpA7ge++s8tncVexyd+9mFGRZ8JUnB1bMN5lMk59CLH/UqRFFAfTtVmsXldbDE5WrD2mKsvIU2cbbi/W3yK/6/xmSEH4KTQBRzEuCjuSnXTRUPzJUtFf4olklASxhzRHNgyiadWzprFVEsWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761720484; c=relaxed/simple;
	bh=T3MTsHunchUEelcmDhak7bFnTw6ra4EnSRjF6CItS7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aHLYpm6Yh0vTEFXvvRyLQw4B4H/34ZkUhKlJXiNrhUa3bRUPb349T/9x6QCQQ0JADTh56nAJCYS61ydOQo9C5DOM8Cvfbbc3xkwy8J581C68aSmoqt/9IAC1+/sSX3iVqMFVlWQmYnasZJiVvoX+zRpQsyhNkfwY2tWmJhOuOEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kKuMh3GK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ebbnokWD; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kKuMh3GK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ebbnokWD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761720482; x=1793256482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T3MTsHunchUEelcmDhak7bFnTw6ra4EnSRjF6CItS7k=;
  b=kKuMh3GKPIfqnxt1j0SJig/ohNn4IMvVNS5ZBzUBNQ2fft8e8+nUaOhz
   RO8gVMVtEu1IYVdY2uxgKJct4wX5ZYxLaj8jliovxISQoNvNpbHGVbycd
   qxpXuqsghNuJ9oD3CGzlcHdeI+9JHE/eBgIjAtSQQsWtJqP1+0gRsjWSz
   dBAoq+qdFvZORQz9OcjBUOK5SvMqia059oOwgiQqq0eqbwx2SmBUSQhpA
   QOq+Mzrxpci9aeAkZyvstYFJxbRSAFnBHmiixBu8sh/ct4pnvzZOYk2no
   scaSFLBRxepIQ7WLvlXgYlVdYaWNjSwG/kaoZQHgtmeY/wtGIdR4Ph4uW
   A==;
X-CSE-ConnectionGUID: /EIoVMYxSq6hnEdbJuIhpA==
X-CSE-MsgGUID: rI5HOhJOQnq2jKYkweFdtw==
X-IronPort-AV: E=Sophos;i="6.19,263,1754928000"; 
   d="scan'208";a="135359402"
Received: from mail-eastusazon11012003.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.3])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2025 14:47:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxzkvqkLp37cWAMpXEL33w3umRowMm48UW+EUxEhdhg5SdilimWm7nbcgpMOj6lhI0K6VFmc7yleJRLITwGYsiXO0QtizaCufkHj1Oeu7LWDTq1VXtbBY4Wob94uHZL/zo4onqc32uZ0Vdgcb+Z5x/ai0zZGSXVYPhgWAZ4wueo5pgOeBjiIX79Kozru4TYCHyw+5IhE4KmU1/0KP+IYjE3dgZlUITY5qGdFE1qyVxQKCygnivk/bwLXTZWLETgxxWPoe7qReKiKLiispkHVpMeu6AUwDuEu+mcMN5159DjVcw4Bw19DypRPH3Clwe4BBHhljZnMLY4FRVTCeKybNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3MTsHunchUEelcmDhak7bFnTw6ra4EnSRjF6CItS7k=;
 b=ZtVCZXBimBuOcRNlJIIIQR0TPgfyuA5jX1q3YeyVSk2OZX1lYqAIxCAuX7qHRQe7k5uTWFsHnL8hm1vbEdTKfjlp8Y5agwEiCy8SmkJ1Uy8p5Ic5jqORvrRHI5DZO6Ebl0YUyDogpfHi+13sCL+KZK0LLR0amVdoTx6eNLCSMysmfqUhkZh98YknImJ/9XzX35ZiKNCXWXTLPS3x7RM95aMZHxPjpq7CEdAEWs1n/TAW8rgy3KJOrSbvg93AIQoIR8cAB3t69och7sDhWsLunRdGbxGMoUvL/2N/j9Ls1v2r8CoiSmZwmExZ/nM+L9K/bQXP+61WnOK8tAx17F6a/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3MTsHunchUEelcmDhak7bFnTw6ra4EnSRjF6CItS7k=;
 b=ebbnokWDqmi0Jf3JuNybsJYG5Jz0tvIxEu8d8xmhSX4l8xjsBu6oVSmW0psQUx7GZt7psWIzuxVpQ5poqWm4QEK8klmbrHkrefCI+7tG2yOhOBvVn8+cnGbLr+ogY0u5tIbsOeZl7EaKiUYyKxnR/y72qQ9gEqHH8PbjYKv3WEM=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by MW4PR04MB7154.namprd04.prod.outlook.com (2603:10b6:303:64::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 06:47:56 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 06:47:56 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
Thread-Topic: [PATCH V2] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
Thread-Index: AQHcSDDR0B0C1wjjx0SoHzEgln8qObTYr4gA
Date: Wed, 29 Oct 2025 06:47:56 +0000
Message-ID: <fc5f6ed4-5bd3-4c4d-82c3-cdab26dcbf94@wdc.com>
References: <20251028173209.2859-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251028173209.2859-1-ckulkarnilinux@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|MW4PR04MB7154:EE_
x-ms-office365-filtering-correlation-id: 326abe15-1d7b-4ab1-5498-08de16b717bf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NW5NNDZ0M1FzeEtXbUwzNzc3ZnRNTm5xUkpIeVJXOHBlNDk2WVQxWlBwNXhh?=
 =?utf-8?B?UXpOWGZKeFdITW1IVDhpa2tOaUtFQ2d3RGEwUGFEQkZEMGZkVnhyNHRNMDdV?=
 =?utf-8?B?YXFRbFExZTRFNEJIY0RQMXdvS1duUEJQaHdnOW1KMGJvQWhScWFaQm5mQW1m?=
 =?utf-8?B?K2lETTFoMm44Zk81N2lTNHRIRmFmUlFhYWVmU1ZMWHBFZ0hkV0tiSEVsOERQ?=
 =?utf-8?B?clQ1TWdrSXV6Tmk3c2Mxd3ozbkZYRHZmd0ZlcjRtOGRVSUluS3AxckRRUFE1?=
 =?utf-8?B?YkZqM0F4WTBSUW9PSmxrQXRnWDVZdjRQZWZkTUpmVkgyMjJPK1pCdVM2aUNW?=
 =?utf-8?B?ZEJ1aUpRMExyM3Q1Zzk1UktvYzZWZHc2UWtTMTBpV2xyT2s1aE5IZUIzcU51?=
 =?utf-8?B?OXlDZ0pCc3dlaE9yZ1dpU1NJYkdBSEg1U0I4RXhnb1dBSmhBSkZ1bGNFWWdS?=
 =?utf-8?B?UktQRDJPVmlMZldnNnptb0NEZGl6NUJRbTRRSHpPMW5Jd0dIOW9KUTBXbW1a?=
 =?utf-8?B?cDVJOGZpRDZkcnk5OGczQ2FlbUNsUjRhV3lsSXg1MEFEUkhjRlFqVUdTQXRR?=
 =?utf-8?B?RG85VFZsQkw4THNNdk9XclBhTEhkdkVVUUdHMXR6REUvSDlhRGJ0WG9DYXkv?=
 =?utf-8?B?ekwydE1qR3ZFdktjZW1PSEUvS0JlOVI3ei9SaFBFcStldndjUlcxTDIvQU9z?=
 =?utf-8?B?ZkNzNEhiQ05jd3VpMGlhelVubmN6ZkwxY2Frb3dOVUQ1QUZsUk9VTGlkRUZz?=
 =?utf-8?B?d3pEVFBldzBMNG9vSWpjU1dHMHNjWm91UFFhaEdyMmhlNGIyT2NWczJaR2VR?=
 =?utf-8?B?Q1g3OE5lM0tXcnRHOVpBV1lqQkZwYU1OTG4vQWVtbmQ0MzVYR095dllvNFFC?=
 =?utf-8?B?dTFkR1NzVGZQYklZTk45VHpYQ2tTOFp3UnBYUnlnSXZLL2RlZUU4UHZXbDZj?=
 =?utf-8?B?ditaNmFCRlM1Q2hVM3l1NXNuVi8zNDAweWVrQlI5OWxDZ2hHd05UaHQrc2tt?=
 =?utf-8?B?T251WGJTOFk5QzVMa3c3U2VzUENTdVZ3NkR3UWx2VndubERIVkJVQXJQOXc0?=
 =?utf-8?B?RWJvQUgwL1JZSXFZVGxXUmdGWDlDZkpIUmRETGJaWWZDZUplQzY2SWpRWTR1?=
 =?utf-8?B?QWtOYWR2R3laRWV1cHZSZ3hkNDV1Q0Y4SG1TNE45SExIVWNESWRFMzhyY04w?=
 =?utf-8?B?dEcxOW5xWHdGNGYxQ1pZZzZyL0xkMDgyc2NCRU1iMWQyckpORS9TVnlnVnNo?=
 =?utf-8?B?bFozRlZoNnpVc0dHeHN1MndHOFN4SGNJMEMvOStiQVVpSHZkYkpNSCtacGNa?=
 =?utf-8?B?cFNvNWEyeVk3cDRrNkdaVlErQUpWMTEydi9pb0RnRllrRkhXOUdCUVlrbkZI?=
 =?utf-8?B?ZGcwMmVWbzZJK0lUTG9vZ2xCQ0MzWWJYekczWVRIVFlzcnRmbi83MkFZeDJJ?=
 =?utf-8?B?NTFONkJBWkc3YlZnS2RVaEh2ZlZEajg2T0F3cDk2RE0ySklibW1zSVNOYW9T?=
 =?utf-8?B?dDFpMkpOampXZXY3Vng2aHdLVUx3VWo3N2JJWitWazI4MEcyLzVOQ09oa2hh?=
 =?utf-8?B?Y1ptT3E2MzMxNVAySVV2Y3ZLd3R4L3laT1JIU3R1V3puc0luSUNuanNRRWhO?=
 =?utf-8?B?ZEhNdlVrSGlBS1kwcVBhdUE4MkpsZFB2YzdsZlB5bmtHdTFMbGY5cy82aE1C?=
 =?utf-8?B?dlF5K0JXbkJUak9uSjBOb0V3MW8rZkNWaStaU21rRENkYkM3UXNrcTBUS2s1?=
 =?utf-8?B?eHU1d2tRUkRROFRwL1lKb2JncE1oVmFiYURManZnT1FFOEJJaml4ckVyRkt0?=
 =?utf-8?B?SEd5OGpiSi9FTG1ydzZZWWZXWmhwT0dzNlVTYlpRMUQ2clM2dDBMNDdpVlZ1?=
 =?utf-8?B?eGRkS1k5TWp2SGloQm5SK2h1ZHk4NSs1Y2M1anJHV2FmQVJ3SnBsOUNBNkdI?=
 =?utf-8?B?M0w5dTNoeFJnb0RubTlUbUVicjh3UWYvNEFZZE52T3owZmYvYm12amdQRkhu?=
 =?utf-8?B?U3NrZXZiSXUzaW5pbWNXdUtCR2N4RGk4Y3ZmVTJMV1FrRE1uaUtQYy9lTVFE?=
 =?utf-8?Q?PKHcrh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnVEaUdnekovc2pveHphcC83RlJ4VjIva1JwZmhjMEVadDZmNndjd0grZ1VO?=
 =?utf-8?B?cHJycnR0QnFjSDh1VEkyaTJyVmlmMHRmb1g3KzBKbUk1TThIczUyUTVtVkNU?=
 =?utf-8?B?UENGcUoxQ1FDTXozdzVzcHQweGFaeGtaZGh4aXRVUjRDWXdKWEZDeWdrN3VU?=
 =?utf-8?B?SGN0c3l6MUZ4dVhjL01WK2FsZWNVNG1LY04vdHRIaUJ4bzl1VXFJZk9HZzAr?=
 =?utf-8?B?MFB1bEZ4MzJBM1A5NjJSeXllTjlwRkFWTTdCQkhHRzkzeWh4aWgyTXhUdmFn?=
 =?utf-8?B?WHplOUlnVURxRDFFa3JMVUFodmd0MjhPVUs2a2hMTDc1bWl2ZFFhY3ViRU1Y?=
 =?utf-8?B?dVRMQm83cnA2aVhoTVRaYkJCV21EV01KSCsycmhpUXpTWW5HWVl5SUhOclFw?=
 =?utf-8?B?cEVpTUhQTVlwV29MRjdWN0NKUE9RUlh1aHliM25XUXQrWUlaNWl4a3BJWmts?=
 =?utf-8?B?YmR0NmJINGROdzRLbVVKUFdhQ2NzUHI0TzRqZ2pmMWM5MCtCRTNMK0hSa0Q0?=
 =?utf-8?B?eUY0K3BFVjR5QnpJWkhrdXI3eWczMUN1V0RBQVQ4WUlraDJRNloxbnlmcTR1?=
 =?utf-8?B?d3l4aXY1dmM1ekcwTnJIOEpueWRma01nME9BWEx5L1hNRVlZTkNUVVRiOG01?=
 =?utf-8?B?cFZsOG52bjlCV1ZxcnBNeVdtcnlPZ1hxWGsvb2JERVh3R0M3U3FTMCtQSCsw?=
 =?utf-8?B?NFAwZU5iWE9VMXBtM0VibkZDcUlWQXliWm9ySTJpVlhEMldNQ0FZa1orcjFz?=
 =?utf-8?B?RzFtZU9XMUdYK2NxRTN5Nld4dVBSaE9rQTRKREE1R2JlV1FuUTdlSWZhNXlE?=
 =?utf-8?B?TEFQVEtGWDU3YnZxK3pUeHhoODRLZHNqeldmU1p0Z0NPb1NxL1o5ODBXd1JF?=
 =?utf-8?B?LzNyZUFUWTFzMzlzZzNwZ0NlWFk1a2lyQmZPSHpwRDQvbHZFUVh4YkNGNmhT?=
 =?utf-8?B?c1VlMHNJT1BxY2p1Vi9uaEpraVFnRngzbEhQQlNzUnJxdnVqUllTQ0JTUzFK?=
 =?utf-8?B?d1BmQThEOE9IVndLdXN2cFZqZjAvZitkeXl0eEg3T0lyOVZFaWVYejc3UUtk?=
 =?utf-8?B?Zmo1R3Z4Qk5SQ3lOSHNLcDN5S2pjVm4zMTZEWE92dVplWkJuSzBsRmhZUVk2?=
 =?utf-8?B?ZStKeGg5YTJyZm8yYysyL3JNQ2NuQlhmK2RWZGpTUzB6dHNCSjZkL3ZubVVG?=
 =?utf-8?B?Wno3VE9LV0lNOU9Ya3JOUWdVNm85T0t6Qk52NUExaDd2Ni9hNDd4VkNpRWZY?=
 =?utf-8?B?L3BTbHFZT0h3ZjZNRUdYdlNVWVcrUXRaZStUR21Za2pQK1VCT21qK3N5aUhI?=
 =?utf-8?B?SnJRc0Jya2g0aG56cFZJK2F3SytRWE9nWUFkT1JJZ0lzMUhSQkZLdmpUVHE3?=
 =?utf-8?B?N2h3VkRZQjRSS01sSURjQ3FadG1sT2pBNUpEeW43ZEVTM2dyWVU0TlRZekwx?=
 =?utf-8?B?bGJkdElyY09vNW8yODl6NkxNaXBqQVpDTU5QNUVNWU0vcVVmb1hQOE81NElB?=
 =?utf-8?B?MUV0NExrcDIyYU9jdWRsdUQ0eHZOYnYycmsxWVl2eXd0aVhhbG14aWlHK2dF?=
 =?utf-8?B?Qk5vZzZSOEpwVzNpUUJlVXRFeWoxQ2lrL2ltUnZ3VWI1SVV0L1RQUmJJRWYy?=
 =?utf-8?B?QWRadEdVaGNSOWQrZ2lrVjI0MjZVMkFpMUlNVlBLZ3ppYWdCdFNxSU1IbHdw?=
 =?utf-8?B?MDBWSzZqTjNiN2ttSXdGMC9ZMHJ3ZnpaWGZNempNcmE1dzRLbngrai9OWEZS?=
 =?utf-8?B?ZGlKcXJqZXRIbG1vWXlzREJsMjh2Z3d4c0lhUjVBajdQamErMXhnekxmWUVQ?=
 =?utf-8?B?L003WU1iS0JxLy96OG0ySWpCQzg3aXNJdnhjQTFaUmVkNUhSUmJpRlZpbEta?=
 =?utf-8?B?MGhaR0xDYTFUWjM2ZlFqR1prOXJ4WFZjVWZOWWFacWVhYWpPaS8rMHB1UzBa?=
 =?utf-8?B?eDI5MTR2a0svTkN0cjFLZWN6MVRJU2V1NFRIYXRLZmxvVnphSWFIVi8zWHRW?=
 =?utf-8?B?MlFQdDRKTWx6cjVhQkFmNklGckVuUVJiSzl4RElSVFE3b0ErTDFtUjVDdFhG?=
 =?utf-8?B?RVFFNlY5QmRtbC94RzBCSGw1T0dzR2M0MExaYkVpcTcyZ2creWNBTDBMdEpS?=
 =?utf-8?B?Vkx5VzhFMVVYTUFFVTR3UHdlU1RVRG1KZ0hTYXpmcjd2amNiOFQvcTVtcklR?=
 =?utf-8?B?aytxYmpRVGpRS0tDL2c0aDZxdWhnRmlkdUp5MVJQckdvNVl6Y3NjTWxMaWFu?=
 =?utf-8?B?RzRjaDNOTzdFSitXNk90cVVWdUJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B3A31C0A55F9E4F8D10EE2960D4378F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LaCPW8vUbiLDbGoJZbIlBiHDXa13utkx1rFR6R1hBmMH5njO36aIMOrsi6Y+b1Pr95/f/bHXDDT/lfy1UBTs+hQx7TcQ0Sqj9TXMeMTMAy/CHkElkGQ82V47OtGRW7WbR2DjQuOndaojpJYjTTzHccXVKzYVSRkWSiuazYSAInVafyrr7/W69F4XoluJwG8cqqac4vEzmt66b/7zhdgGDG5sRm44qecH4Mfh/qs/qEIdHACLC4yWVtcQZAZoYbUvfrxOiubzzZ9Ct07yWPPO/lZcvrJaHKYY0ge5gax0AqlNw9+bJImX+33BuyJqQDLgv4wXRfnVew/n3kSr244RWJfwQH2AqOo0RsK+CI+tS9KCAoHuKBAMDqgy8yxkPtiUNoXgjHeS2SXNqYe8QpouOEyhjQONOU9suIQJIR7/DChz+7CwXFt09IyDkC0FZ32U1ROvJZBgoWKAlPoj/sVQpnmvB6kcrh48CX6hnzPeO03ttdnwHgpd7Ax962nb9kwOJwmBWfUFZbbByBkWPOzQKvd+dQYw3miMuCPw2VVk+zH9JFCEK4Sw6nDl88s8Y2EMP+NSydaOLK3WwI9uIzROnnTKI21EmzgSzeJ5YQUAb/pnoOs1J0y9oDL1cYqtHhpC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326abe15-1d7b-4ab1-5498-08de16b717bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 06:47:56.6028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+RqLE7U5y+fE5IGyWNg0dcSF4EPFyEP7Xlrb4zqY2iZ9nwNJbquGD5VnDMcbYLVLlfJ8NKD41vWryPGdpGBW81hFTf9Oddkv1QcUs/O3a4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7154

T24gMTAvMjgvMjUgNjozMiBQTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiArCWlmICh2
ZXJzaW9uID09IDEgJiYgSVNfRU5BQkxFRChDT05GSUdfQkxLX0RFVl9aT05FRCkpIHsNCj4gKwkJ
cHJfaW5mbygiJXM6IGJsa3RyYWNlIGV2ZW50cyBmb3IgUkVRX09QX1pPTkVfWFhYIHdpbGwgYmUg
ZHJvcHBlZFxuIiwNCj4gKwkJCQluYW1lKTsNCj4gKwkJcHJfaW5mbygidXNlIGJsa3RyYWNlIHRv
b2xzIHZlcnNpb24gPj0gMiB0byB0cmFjayBSRVFfT1BfWk9ORV9YWFhcbiIpOw0KDQpKZW5zIGhh
c24ndCBtZXJnZWQgdGhlIHVzZXItc3BhY2UgcGFydCB5ZXQgYW5kIEknbSBub3Qgc3VyZSBoZSds
bCBhc3NpZ24gDQphIGRlZGljYXRlZCB2ZXJzaW9uIG51bWJlciBmb3IgaXQuIFNvIEknZCBzYXkg
aG9sZCB0aGlzIHVudGlsIGhlIGhhcy4NCg0K
