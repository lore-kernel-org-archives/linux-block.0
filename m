Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D913D891
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 01:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768442316; cv=fail; b=jTRvjHhhp4XaUS7egAw/9E7CKueEb+hJ9jxUP8b2qE7ip4Gg5qJRZQqeVMtrgbVqBTweRDYrc9GJHXBwtnmKe4ALy0W+1UKfDTfBbfADic2atwkp6GgSPK0qwohlaFhqq8k6rU/IlNPOZpzTG3vzuaqd+oKck1TLxGA5YEvttZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768442316; c=relaxed/simple;
	bh=AsoFOi03PDRrOjMs3ZStRThRGZCbOspjAX6j0cAdBWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pW1O6efKnSOVixWCVDaR3QG15d9uOS9qyjg9kgu/lthzpcWFs47s+cUxm20dU7RQphnv7FSJqM61T2T4MQPv53wXVWt0uWboa/cu60YjP45+zVhRUcLvcyuoI0eWoQQyrlclv/GWPPM2wIXzgr0gkZlwiqnW37IoGGf9EKet7c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tHk9zHMp; arc=fail smtp.client-ip=40.107.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tHk9zHMp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkCYbCINVI/1+9i4s2Lv5ufogw7KGjueOrwbIUjsnLkHrz+3fzyVMPS0CnStYlu5t/FIIdEF7n60skrYF6AX0TBZ5OlOYG4eiXlvMoC4msnkSbLNvU7GXnXCcpdnalhMr3dTvTfL2sCpP48tGR9ZzZbpvDVamQEWyvkhIBWjnCNbYXqhidUARpITccGEnPdm5atXxa7+jerATb5gx7jaPtsYIpzV+FszAzxfaoKH0J9CJFUyOp1URdllsqRlqy96uzlk01H4imXSKysfJTJd+CGnp0Z6EaqKtb3tKc5w3Fw+QsZVdjqeWrQhSa9RiEXkWsXLP6jFOtaaYHsYgccaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsoFOi03PDRrOjMs3ZStRThRGZCbOspjAX6j0cAdBWo=;
 b=w/mh3/e11Sg0NFz3V8EwNVyWhI4c1/Wgt/7sC/+wFJtB/Md72EArXu7c36reFAVnU3eYwKleTTPsPim5uVYrtgk7FaI5vyZhjnaooZklwT17M8iBIN52QyvGlbLlQkM5pCQhWdadrpVrSDzOIMQp12cEh+wPj3WAVp4J0rwTOXRetRHTF0b27zHUc8VuETmsKy7X4EX4yrF4vraLrL4YYihr/S2LagfY7UDarxnbmAhrCOWWa6ktHk3LNbTc5RpHehFDeVeHZXS65NV0UAsZbkYdkO21vaLR4BAeoP4Iw43LuAyFChr+XcHzNwEEpWNXcKS6XMbIuWSzAD/XEllJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsoFOi03PDRrOjMs3ZStRThRGZCbOspjAX6j0cAdBWo=;
 b=tHk9zHMpwbLQJLjU9YKlVUImK/M1rkGVgdsM2NVlvcnDxq2mLD2u1urHHekVZSGIHKy81wp+5KDyXxYBYUPwNkDBYNkOJkvDiQvbk3kM4YtVnKnEAYtut30NBGua+4C1kqkJSQYJkkcWSEs1CwBzfXriKD6DqiNag8S2Tk374gd3SUhKn1nG/JI6tbRmARAesf3+XJIn+WCXKUSul+0cSUkOleeorTufq0RcWEiyUebojf1oi+/ULPsTQwnKy7kD4zi8jJ6xMfOcXfPyYpbAmLLrZWnKzqe3JtJGDYeO/jkttrzRTzKeU6AN9+a8ciMr2VOM7pUtFdh5Y8QDFKeTNA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 01:58:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 01:58:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jinpu Wang <jinpu.wang@ionos.com>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>
CC: "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>, "yanjun.zhu@linux.dev"
	<yanjun.zhu@linux.dev>, "grzegorz.prajsner@ionos.com"
	<grzegorz.prajsner@ionos.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] rnbd-clt: fix refcount underflow in device unmap path
Thread-Topic: [PATCH] rnbd-clt: fix refcount underflow in device unmap path
Thread-Index: AQHchBnvMmj8aOk0+kaT6bvRmUvcZbVRWpiAgAEiGAA=
Date: Thu, 15 Jan 2026 01:58:30 +0000
Message-ID: <bc5b7643-8f6e-4801-8d73-06e869318cd6@nvidia.com>
References: <20260112231928.68185-1-ckulkarnilinux@gmail.com>
 <CAMGffEmPCB4j-SfufLAdnBo=x-5HsM-vkzhu7o1ocHwnc0=jVg@mail.gmail.com>
In-Reply-To:
 <CAMGffEmPCB4j-SfufLAdnBo=x-5HsM-vkzhu7o1ocHwnc0=jVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB7461:EE_
x-ms-office365-filtering-correlation-id: b240c701-e215-4752-78a9-08de53d99515
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?M3FoeEdGRTQwSDBlVXU1Nmx4RmtDbnowRFJBSk9udU50UlNkY2tXTG1rV0pU?=
 =?utf-8?B?NytnYkhDZUxaQmZxS2VTeDZkV3ZJZ2l0TG1yWTZrK0MxYTVuUitVeitQNHZy?=
 =?utf-8?B?Y2Y4K2wvME1QMU9lWmVTZVNzclQrdml6c2g5NXp5aGJEZWNBWUpwZk9aaU10?=
 =?utf-8?B?UFUvcGw5VXdwMjBQb1VOUzg4TVMzRHlZaTBzT25zcTBwM3F4SGg0bjJycDZa?=
 =?utf-8?B?eUNSZFc1ei9lM0ErS3pjZDZHY2VsMy9hcnR6Mk9CZjhDNFJtZ3J6UDI0TDBa?=
 =?utf-8?B?ZkdWWmRoN2k0cTZ0UnBaOGgwMEFKS3FrUDV5Z2J5RGU5ek1VRU81b0hMZUFz?=
 =?utf-8?B?S0QxZVI1cVVtd05sRVJIaGJ6YWt0U3lkbHdzZlo5WC9LSTVDeEdKNXpDREhW?=
 =?utf-8?B?Y2V4Z1AwN3NmMFlQajcvKzQvOVc5WDQwMTBhRk4vUHRJOXdvamVVMDk5d0FI?=
 =?utf-8?B?anFiL0t2YzFwVWNXd1FITS9SZ29GUm5NOTFTc3hvUlhlU1hlOWcwSGp3blY3?=
 =?utf-8?B?SndaenhHUzRnMzFVS2hlbWZyc0JlUlNsYWdKRmo0UFVzN2JmVHUxL1ZSMENp?=
 =?utf-8?B?OUI5VXZOcFU1dSs0YlBhSzMwRmhsd2g2ZEVldVhHdjY3YTludHgzSTNQL3Q0?=
 =?utf-8?B?dzlxUDZTblZEZ3l6LzZ0eTVJUjZ2WjVYQ2FLQ01lTUZLV0xCQXVkc1MyQUNR?=
 =?utf-8?B?SUV1cTEwWXRKSy9BU0VMY1h6bWZZc1lvSk10ZElOYVdsUW1uRzdidXI1aXNT?=
 =?utf-8?B?dXphMGNoK0pqcC8ycjJWemFVTEFRRTFVVHBuUG44OFp1K1E1dVlkRDg3cm1Z?=
 =?utf-8?B?MGRaSTUzL2hDWDNlZjVyQy9HNHZOWlpSRTNaOCtVQkVUbDdXV1grSVpBTU9y?=
 =?utf-8?B?M0Q0cWtjeTU5VjQ4OHZGVkpFTGJ5MHBWWUptYUpOcThrSWUzY1NpTjFnazVu?=
 =?utf-8?B?NUQ5bGlQRHNlZFU4N21qQ2w3RjI3RGxpc1Z5WGJkYjhuQU12ZnBiTk04by9u?=
 =?utf-8?B?dU53aXRLaTZVNjhjakhlVENVMlV5b3BXSW9PNGRpYzBPdnlyb095OXlCcWxN?=
 =?utf-8?B?SThtZ0NaclFPTXg3ZkhJOHQ4QXdrQVY4U01qR0hBV1kxWXhVS3M5SEpQSndD?=
 =?utf-8?B?SnMxNDB3U3YxWGx6WEZpa1hPdVVaeHpjVjdIUnhwWUVkd3BEYUxuZnlIU1Yx?=
 =?utf-8?B?Ym5VMUxlaDUybytranltVy9zL0s2WndOdkdzdUQvbzg4TkdmRldVM1JnR3o2?=
 =?utf-8?B?NkNtcm9wejBwVlZrOHVKM1NsTHpvd3B3OWFaSFhEL3crNnVVMUoySGdGejcz?=
 =?utf-8?B?djhPQUh3Uituanl3OVlFSzNDaDRnSVFIOGhxZU9QSWJQazFpS1YxZFFIaGlp?=
 =?utf-8?B?TDY1cFE0cWVsNzlWaVdEN2FzWW52OTFkYW5RMGgwM1U2S0pWK3RUT1Vncytn?=
 =?utf-8?B?R3llQ1VyUXU1eWxXaVlUeElxeEk4RjdXQTdiVnJLL092OU5USzQrNHpMVzBP?=
 =?utf-8?B?L0lNYU5vL205dTVpakx2bE4ycTE3V2htYnp1c1lUTSszMGg2NWtrS0dUU29u?=
 =?utf-8?B?TTN5bFZXMnc3NGdCamFEZnNzTDAxZmZ5Vzl2Y2xFYm1ySXRkL3RzZnN1dCti?=
 =?utf-8?B?alZlbmVyUE02RWpzdkY4UVYvSG5qZmJ4UVJiRWdPRFkxYko2NFRodjN0SzJW?=
 =?utf-8?B?cWNQVGFUakZxSzdjZmc3K005d2prUGdyand2RG1jUnNUVFlYVkd1dzBTd0hX?=
 =?utf-8?B?bVY2dk9xTG5rOVFEL2tUQk1Oa21GZHdwaStXNWIwckJnV3dQUlpONllTNTho?=
 =?utf-8?B?Y0R1dktiU0JmSjRMbEtlZXBxQnFHWmN1bEpVRmpmR2tHQWJFNU5kM0xzOFBh?=
 =?utf-8?B?NmdQcTVNTWN2WFpkcEJKamUwR0VBNmRMRXRVdms4UWVxNnFXVnp2bDRHNW02?=
 =?utf-8?B?eVdzU1FpZDZuYWtkUnVqSFdScW5hMTgycWFVV0JyYmRaMWE1amZzc1lVUXJl?=
 =?utf-8?B?ZStTNTFBcUkxUDNrNFdDUHhmTXNwK3ZIczcwbno4b096bkdnM09uZTk3eEZS?=
 =?utf-8?B?TEJ5eVZKUVdDN0p5TWV0UVAwbTNkNURZMXJ1UVRBTWU5dUtkQTJhUWFIcEhE?=
 =?utf-8?B?KzNQY2pFV1NzY1ZQa3JnNXZEOHNCclBlakhlQ1dSdHVUeXZtMGV0MTFSbGo3?=
 =?utf-8?Q?CoLaejmHUVViv+WOUdgv5vw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTl5T0VtNEFad3lrSWJ3SDU5UzJtc0VkSy9NSFVWbFdNMEdFNjJRT2VXU2da?=
 =?utf-8?B?ZE1FME5QV1FMamlTbUE4N09uVGxLOURCM2FuaC9FSmNwTmZIcUV2U21LR1Nn?=
 =?utf-8?B?VEdmMUZKcGhDaXBTeEx3Rzl1R3R0Unl6ejJtYVQ5UTlLZE5QNDdyV25ncW1F?=
 =?utf-8?B?UjFwdUpEeUowbjM4RWVmWFlDd1B3cjZNWFYrWVRCT2tXM01idFJ3WEJqZnF6?=
 =?utf-8?B?ZGR3L2l2QmpOKy9XRWVLWUFXTTE2M1RxeXhEWVkvSXc1bWpBMXlLVXNKMFlL?=
 =?utf-8?B?TG4ybTFGSlQ1S01lZ1BPL3NiTjVtdlEwRUwwYjZOMHZpZW1iTk1Nc2VaT25B?=
 =?utf-8?B?Rit6a0p1Z3RIMnh5ekNFQ1RnZEVrUXRzeE80dmxkcFZuS0J1enVjL2N1alFs?=
 =?utf-8?B?V29hNHJ2U0thRE1EdGJFY2h3NTk5S25HNXEyZll0QS9CSmlCcWFxaWJYTERK?=
 =?utf-8?B?Y2FFNGE4WTM1TGpPUjBNRks4eGxWUlFRVVpzcXRBNVFYU0lnK3ZKV25NSXFr?=
 =?utf-8?B?Qm1FTFNpVG4wREhhRGY3WDZXVjdrV05odFBKMkVjZVRnSG1MSmhFUG5oRXBT?=
 =?utf-8?B?S0FrcFNNb2djd0IxeFF3SjNwVEhEeThLQ2NEaE03SFFmb1ppRmN3eU11OVV5?=
 =?utf-8?B?aEViR0s4K2UyeUQ1TGQxUDRaSmJvTGQwUHVGVEd4eFhuTzRhbEFzdGFDRExz?=
 =?utf-8?B?WXFjb1JpQ05hUlZqaXE1MGtkMGs0TGRUVTRXdFp2SFByZWNTT2t3L1RObDdE?=
 =?utf-8?B?MGRBWGJPWXhOYUVjb2p2dG5HNWZFT0RTcGIyYWM4dmNxZzRKOVBoOXNDYkNC?=
 =?utf-8?B?VFFnQXBwd2cvVGlHNDI5TDV4LzkrNC9Ld1JTSlVCV2g4NFd2d3RrWWhibVND?=
 =?utf-8?B?S2F5andkdXZLRWtHOHVhbE4rVjF4NTNmSWZmTjJQVWJsanVPdkRMY0tKQ0J4?=
 =?utf-8?B?VDhRcFA4elUwK0NqeW0zZHRFdnplb0N5cTg5NFovZG13b25sYWlLbVpLZ3Rx?=
 =?utf-8?B?RTNGN1VDY3ZEeHRkTzA3eVBlajE5UldFa0FlKzFvSkpaanhkWUFvTENnQ1Bq?=
 =?utf-8?B?c0VtTnM5cm9UbU5ua0hIbytjVEdxM3pzcnJhTyt1SmhYeEcwOGZhMDNBWDU1?=
 =?utf-8?B?YlozWDlqZE5ldzdRVnhVdFh6RG5uZ1JGaTdlL3ZsZUVmYVYzdW1JU0hNN1pq?=
 =?utf-8?B?NlA3K0FsaWFTVlZnYWNoYnJNYTJ6TVd3RnVBMGczK28yMzErbUN1bHpsOEIy?=
 =?utf-8?B?YmlmdWRneVFhNGVONlFkOWFWVmRNeVI1UDB6MHRjM3A5VUptcVB0RjdjOFhK?=
 =?utf-8?B?SkZvZjNTWEY4cUFSdjdEZDl4RlZaS3A4a25YM21YaXg0SnozeDNuN0pTS1lR?=
 =?utf-8?B?TW44S2lZMWltQVhaV1NxZDY3SnlxekNYZFVXQ05DVUMwU0hzVUxIVzE2eS9u?=
 =?utf-8?B?TDNTcE1YMkExNVRrd3JNRzdJd1pFcmpuUFhuTUpNNHc0ZlM0TGphWXhEZFZr?=
 =?utf-8?B?NGRnMnBEdkJmNThyR0ZwZTlQZkJTb29qZ2ZLdG1EU2twc1h4N3VmblJXdjJT?=
 =?utf-8?B?MEpmcS9ENDdkMElZaGlxYXVieXgxMXBrNEhlYko1YkJoSnBIVzIwTXJ5d3FH?=
 =?utf-8?B?cjNvWUMvWGwxOXRSVmZHWjg1cjRoK3dremI0ZTlja0dScEVHUGd1YW4ydVh0?=
 =?utf-8?B?YW1wMGRFWnJIVktXRnNtWWVzMXJ6SThOOEdYeCtRU0U2Vmt0VDV1cjltYmda?=
 =?utf-8?B?bWx6a3V1UVJCNVgvMC9aaXo5RHBhdVB5bHJGeUkzRVBueEcwL3B6REJNMkFS?=
 =?utf-8?B?N3BUVWoxMnJkbzFQdHlteGdYWnpndzA1LzJrWktSQXpqeVU0cDBMemxkdEZS?=
 =?utf-8?B?OVdYdXc2L0pvZ2dBUDRxakpySHFhUVAxTW9FaDlBMGJqbTliV0FFcFpnMXcy?=
 =?utf-8?B?eHZrRHBRQnFiNmRPRlFRdnZSY3pxeTlxaW50L2toUjNEOXV1eG54MjRSNDYx?=
 =?utf-8?B?MHU5cEJrd3FmcnVJRTZBN05BL01JRkZkL0JZMER2VTcvSDE2NENpVUhQcG8r?=
 =?utf-8?B?YURJczgvcWpBUEplSkdQUDVxTjJWM2JDVEtBcmFZWXhBT0xRU3pRczIzZWdr?=
 =?utf-8?B?U1B2dUpvYkVGbzdCS2tSUVliQk5ybGRsZExJZ0N1alMxYzFkeUVidHBBT1hi?=
 =?utf-8?B?V0RHQTBPZWFaVGNiVTBkV0FiSDdOUm1EQm8zcGpRdlExbkp0Y1V2ZHdqNHRD?=
 =?utf-8?B?YUJQNG5kdzZwL2ZRaFBzczIzZjVVakNCOWJiTUhZYXNSYzdYQ0dwc0dxdGxN?=
 =?utf-8?B?TlNOZXdNbUNJZnU0R2x0RS95eGNMcCtucmdHWVBSSjBETGNVUFFuZFAzQWtR?=
 =?utf-8?Q?meXlK8x1A90qiFx9wOjLl4iwpbF6HqZwDW8qCOyDP+Zbi?=
x-ms-exchange-antispam-messagedata-1: 7mH86Il/4CqSyA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FB8B88F088A6A4088EB790B640CD111@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b240c701-e215-4752-78a9-08de53d99515
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 01:58:30.7051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C+eCeLR7FZtUmbl+sU+v34w+Kk1krMpRA1jiA47MUrUBXe2ep/KmqDM+b2QjqknO8SzO3ti17UpADOvudMvhgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461

T24gMS8xNC8yNiAwMDo0MCwgSmlucHUgV2FuZyB3cm90ZToNCj4+IFRoaXMgZm9sbG93cyB0aGUg
a2VybmVsIHBhdHRlcm4gd2hlcmUgc3lzZnMgcmVtb3ZhbCAoa29iamVjdF9kZWwpIGlzDQo+PiBz
ZXBhcmF0ZSBmcm9tIG9iamVjdCBkZXN0cnVjdGlvbiAoa29iamVjdF9wdXQpLg0KPj4NCj4+IEZp
eGVzOiA1ODFjZjgzM2NhYzQgKCJibG9jazogcm5iZDogYWRkIC5yZWxlYXNlIHRvIHJuYmRfZGV2
X2t0eXBlIikNCj4+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaTxja3Vsa2Fybmls
aW51eEBnbWFpbC5jb20+DQo+IGxndG0sIHRoeCBmb3IgdGhlIGZpeC4NCj4gQWNrZWQtYnk6IEph
Y2sgV2FuZzxqaW5wdS53YW5nQGlvbm9zLmNvbT4NCg0KSWYgdGhpcyBpcyBjb3JyZWN0IHdlIHdp
bGwgbmVlZHMgcmV2aWV3ZWQtYnkgdGFnIHRvIGFwcGx5IHRoaXMgcGF0Y2guDQoNCi1jaw0KDQoN
Cg==
