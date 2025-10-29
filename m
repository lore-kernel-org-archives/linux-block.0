Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615F2C0286
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761720335; cv=fail; b=km4NCBbYCA9WBh0EC/BagDK1hXMV75m+s5TJCK9SwoTcWrE7MSY/jSylRYBvqoM1gjDt1eZVwqqwLgKBz++jywjuWnqM0+GytunErwZt/Fw5+Hxcpx53aYX/VmyF0SOfno8FgpZB8jOWfWedLpCyMd22RF3iWdX7uTyGwCnSpTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761720335; c=relaxed/simple;
	bh=ZEUZXezoy14i4G4aH33Lo61kykWBVbuRL19ZjZIoG/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tjWjG49+bHNzZSZyHwmWUIJrHSDPcEmKZUvjJiOqNpqyn4rWDOQ3DPF58ozlYd+cyosXbfPk0zT5UP2dXJo9eESdAHwDnxH4sJoUAyuRdapnXXzBOfzPfXS9jnAmQtv1OAKD2NE/j0j5ojK4jwmUIeNge7/9PxDU15xZBslUTRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mKrwXRVJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WIJT/s1F; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mKrwXRVJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WIJT/s1F"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761720334; x=1793256334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZEUZXezoy14i4G4aH33Lo61kykWBVbuRL19ZjZIoG/0=;
  b=mKrwXRVJuM8ffzjMVCBKUq3ELhd90DftkO6DZjlY/TlGFjef1jDNQmfJ
   PDV5/OnDZc11WrPKZU/5ZLcx0TUUzvGB5IcxZah0u9W/jZyKaNYRm/bIs
   m5tU92TFxIyVl7EUA5N1VnQuXynJOvSpww1nSD0gbJ4vZrW5xP08MYM48
   cotYBZmfz/G+Lme2+s6ysj9EOqmC+XpP7Ry3XE0EdKUO3fjclKjNo1TJ3
   v7lVcluPgvQr7Vj8zelTusAJ1QkC5DJUjln84Fs2bCgAelauG11Ifjp44
   f0gEa/WzoRiALohgoUS6JP+ph+M+U2noIThzP7h8EMczT5Ku9MV2tuKWA
   w==;
X-CSE-ConnectionGUID: l5dBaTGbQ5Gys4AS3GjhtA==
X-CSE-MsgGUID: lxyvKV8rQ9iZv5TO1ixo1Q==
X-IronPort-AV: E=Sophos;i="6.19,263,1754928000"; 
   d="scan'208";a="135042337"
Received: from mail-westusazon11010057.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.57])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2025 14:45:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJHGSy3hy5RpvUiYQmORqa/VseS6QkOub8AuXyeN8+6hN++ZatlCFISkZRXVrt/bICH752f6msxrgzd5pW0AHfDrXgd6cOYmZf/+OfuSE5UnaR0aIWU1grnahHSLcNarNUw18K8R5O1RHFS79PkkMvJKb/ZL5qmGuXgXUqaO/Ofj67+KAUKQbB7PW/TptvExc5/2IlpKO3AnNge1PgaBs4uOR1gwgiIRxhj6H4+JGNxzRkE8I82mumlNFEC5/NIdMMjuQ8ywnkZnJ9p2DnB5XUC/t4o8iPhRvRxiYOj05Ocmm4C2wNrSnJlNWkRsfsmCRShLF6gEZpCgD4QEHN/43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEUZXezoy14i4G4aH33Lo61kykWBVbuRL19ZjZIoG/0=;
 b=X0mYcXHkCPtjgq3fSMmcaxk01xlSZ+3/azM8blfyPaq8OKzlzP+AS12fn/KEz7ZrpnpLqrstU0MbmamnDilfbCicswUlg8pK/vUpte5EZjRSoq+af8qbdjxnTbBQGYUk49j+/LaW5Pfn6uU/Xgjzyg5guT+Nr97U9qyT9V0kGEJ1trsCTnWwzYrGH3Xu7fufYkyW+SpiGrx21fIAKKfh419fM3abIpT3CRA2UxDWXyJ52tMhfSXOvh9cGn2EjNYIQUAByUo81Dgh0qrXTibo7Mf5DlLbuK0GAEVQm63DQEEJQ4QB6h/WtWlfFKEiJJ9l2qrNZNjxNy40pI0G7qgcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEUZXezoy14i4G4aH33Lo61kykWBVbuRL19ZjZIoG/0=;
 b=WIJT/s1FebMBFvAzikMsQsCN12kVN7dort0x0CsuifPpAjJ5/9OcXG+FThQg/TeU/YZJVuO7q4jEUh//w5D35s4DDyjAyZKB74v4q1RD72uB0MQ4ah0Yv6ccN6ve6YbgwlI9b4gon0judAsc3KyiLXwvww+zccZZHJucmF8B7VU=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by MW4PR04MB7154.namprd04.prod.outlook.com (2603:10b6:303:64::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 06:45:31 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 06:45:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] blktrace: add blktrace zone management regression
 test
Thread-Topic: [PATCH V2 1/2] blktrace: add blktrace zone management regression
 test
Thread-Index: AQHcSD/73xQ2BuwITEWZB/cc2yy/D7TYrrsA
Date: Wed, 29 Oct 2025 06:45:30 +0000
Message-ID: <11fef91a-c377-4ac6-b22f-c11b62890e6c@wdc.com>
References: <20251028192048.18923-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251028192048.18923-1-ckulkarnilinux@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|MW4PR04MB7154:EE_
x-ms-office365-filtering-correlation-id: 5800a4e0-f828-458d-58d5-08de16b6c0f8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WU9BRGNpR0R3c0xuaWUvcDdKNjh0SHdaRE9SU3NrTnJaZGM2NFEza3NlbnNF?=
 =?utf-8?B?SWtRYXVEQTg1VE9WRFdaR2w5TEVEZTJ3WXN6OXRZcnNXeXZ6dlBPSnZQMGlZ?=
 =?utf-8?B?TDNNUFgyVnd2Wk9rcVU3b3JCNDkvaGlvWVBNVEx2Z0p5bkVrS3dCMmEvcWVq?=
 =?utf-8?B?YjRvOVR0WUlnRG1obVFlSGpWZWx3eFR3MnZBUGxpdG53NWE5RkVpUVd6dUJp?=
 =?utf-8?B?NE11VXIvREpBTzZ1TGZKK1J3NzEwR0tLRkk2VFo0NmJXdWJid0dnOEJrWXdp?=
 =?utf-8?B?T3c3K1R6MGFGZFgybEo2VVlGOGtMRnR5Zko5aE9scCtrMDR1Z3U0ZzRWS1E5?=
 =?utf-8?B?cTliQXNqTC91UzdRSlNsWGVrUTRDazkyZVUxVFRBQUNkQzJVNmE0c3ZmdGg1?=
 =?utf-8?B?U3BBblgxY3d4dmJGMDJXRnl3VlJPZkdqKzVlUmYzUWdMa2FVeVEwemIwOTJp?=
 =?utf-8?B?WUtpZnluMzB3YkpOTHBYQ2hwWGM3cFlueVJ6K0x5VVYxNS9xbGExZTlLVTVC?=
 =?utf-8?B?S3ZoL1FtbUZsb3V1RFdpTHc0Y2ZXNE9RRk5VOHV6VVFQWEEwMGZuUzkvb3dB?=
 =?utf-8?B?azJFaG82aGYvOE55ZzVvTFFQY2RPUnFtcUZMRExmOU1ibEh2Nm9NZDNaa2U0?=
 =?utf-8?B?UGNPR0FZcE9pTFlsQmsrNlZxS1U2aTQ3NVBBeDlSd01NK3VtdExmVENsMHBB?=
 =?utf-8?B?ckhZOFFTY1Zjazc1K0V5N3c2blZobUF2cTZnUW1kRXFjVkthZmVZMXB5UDd5?=
 =?utf-8?B?NXR3YVM1QVhqZkhuQnhkcmQyblQ4Zy95Wng1NnhWRUNwZ2VGbWFhWnNyR3lE?=
 =?utf-8?B?L2g1NGZ6eks5d084SlY3QW1yRytvYngyaDBmb1d6WnllRkN6QlJuaVhXcGVp?=
 =?utf-8?B?aUlPMXpVTlh5MTYyeW5PNWxhNWNjemd6c1Q1UXJ0cVVrdUFZTEVVVUNKOVd1?=
 =?utf-8?B?Z1RrMWIzT1daakROR1JGVEk2cmoxY2VrUXYzYWxEQ1F5YjlFank3K3VoUmh0?=
 =?utf-8?B?QUtWZldEdnduOERMU3pnMUZiNmRyM1RWWHdxZTdGS20rTVcrbk01ZEttZC9G?=
 =?utf-8?B?L1FwcDZvNG9hdjNzeisyeVhkR1dFc0hDVUMwNmo4S3VEQktWblVSdStMeCtq?=
 =?utf-8?B?bmFCdTg1WDNVLy9ZWHo5czQxMkRQQ0hOaXdSRVpwZHdSQmNOUXpGV0dnMDdI?=
 =?utf-8?B?VlVyNG1pa3hydENuK2YybURjV3RLOW11TkZ6SXJHVGxnWWtrcXRNQkZtK2xX?=
 =?utf-8?B?cXlmMW12a3RtUGtpZmQ4Q0U0RTlZZ0kzZUJJbkppeklHdUhhVUJDSUtrREw4?=
 =?utf-8?B?SER3aDN5S2t2U2NUbFNuSVg5UEsyT21GbCtxc3BWdlZubTNYenFza3JPSnEv?=
 =?utf-8?B?cU92RXNic09GVUd6NHJtd3IvODVBSmJ0ZHJjU3dMbFVEenovZDJtcU9nL1ZH?=
 =?utf-8?B?YTJaaXFSdmJpcDgvMEJCN0ZpYnZOWXFybWNrR3JicU53d0Rjd2YxZUl6eTJ1?=
 =?utf-8?B?UUtROWFtMHdhdE9Xd1lQeVNnZGZFaUQyY0ZZNU5xM3VSb2F1TGZ1L0NSeXN4?=
 =?utf-8?B?MUN6OUFVRkxjdGk2dEk5S2gxZ2YwMmUrRE1CamZqZmZQeUlsRUZBaVo5Z0tm?=
 =?utf-8?B?UTlYQktENWlXTEY0eEVicTgrQTNNdXJsOExGc2t6Zm9hTHgxRGFXNTU2VThu?=
 =?utf-8?B?MC9pVCtmNHdtSDB4bVZuaGM2MlpLNDVoZnl6bFMzbitzZzY0NG9BNjB6S3dX?=
 =?utf-8?B?eXNUS1BzOTlaeDM0bUJtbEVmemlNeXRQRHBkdDd0OS94SjV4dGkvUTBKRERP?=
 =?utf-8?B?cElOemFSekJzdW1SUUJaZUorOGNrZ3NpanhXL2NJeEVZQytJSDU0V2pNRG96?=
 =?utf-8?B?dDJBM01Ccm1sOXVVdHBiR0RTdGIyN2hkVHBHNzJKY0swd3hmRDN4SjVNNG9K?=
 =?utf-8?B?S0lIRHBVeXora1EzeTNydUpicFNhMEk3NUdhZU1xZXg0MkRkSGJUZUpJSDc3?=
 =?utf-8?B?VWoyMmh1TjV6NDVDK1N4cml5YyswcVZ1WjlaN1ZGcWtIVkh0SUowMER4ZzV2?=
 =?utf-8?Q?ciV7L9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckxTTzdFRURsVnVldG9sU1NwOEREaHRvZk0yYUY3bysxYmd4UnVOeFQzM0xX?=
 =?utf-8?B?VnRmOVFycS9GeFdUcGxzVHJkbEIyWUpSc1JvaFhTemd0SjhFNVM0YU9uejky?=
 =?utf-8?B?N0NTdzZoaGJNdFN5SndZTCtnZWNlUmxKZytOQXBRRXZra1NnUncwekxLR1VO?=
 =?utf-8?B?REZPMmFoUDczTkJkdHNiby9FTVdxaHNZeUVlczlQdWJwTkwvL2VhNG9RMzZz?=
 =?utf-8?B?V1RiZ1ZHT1ZKSTNNYXRDWmNBY016WnR0ZVZ1a256WEJITVZrbTk2YVRNbmRi?=
 =?utf-8?B?YkYyT3ZrQ3hybGo5TlVaQ3NhZC9RS2JuLytxNFp1Z1ZYTmpqTXk3VkZudjIz?=
 =?utf-8?B?MTBZSGFJblNaTXV5S0tsQkJ5aFg0Z2NhSmhHU0s5eSt4a1Z0aDJHSEV0Zytq?=
 =?utf-8?B?UnNtajFLd0NvNW5LTENUTitzajRKbXFPbTRETXBkOEF1dHFsZ3FvZExFTGxx?=
 =?utf-8?B?cUw5M2hkbW5QTnIyZWhFdWtrSy8xdGt5RVM4OXZWcjc1V2Mvem9zTmdiSTNt?=
 =?utf-8?B?VkF1ZU96bk9YeGJMWXIxdndNNE9hZjQ3azVOTUxmUGNwWHVOVmh2bU9KNlE5?=
 =?utf-8?B?S1VzTHl2dzc3bEgyK2hXQXhOcDB5M2FRQWpUb0I4Z1BoQ1JTYy9mK0MwMjJS?=
 =?utf-8?B?d0dPSTErQkZmV1dHakpVK3NOdVh3R09XU29ZSkVWRmQvdnFGbldHUHdSTVZK?=
 =?utf-8?B?R0pNVVp5N00xTnBTNVRReENOMFlBcThtQnN0ZEllVWxUVHF6VWFDU1FKQWt5?=
 =?utf-8?B?Sm1OQXRqelRWWjZkMTU0TXFiQnJmamwyNFgyczVNaHppQUNSTWdzNjVZb0RN?=
 =?utf-8?B?R243MXBkWUVQTzhmK1BnRVFMWG5pQkk5MlpMNjBUSmN2MjFtQW1nM0lKRUxV?=
 =?utf-8?B?Y2FVQmQ1UUR0VXUzbkZlUkZnR1JBTVJmTHdnc2RGd2grMFhsRUpwZGFOKzJH?=
 =?utf-8?B?aUZoTjZNeTdFRDRCRmNMZ3Z5Z1AzMkIwSVUzcTMxZ2RxSjJ4cnduVU81RkFu?=
 =?utf-8?B?MHBjTFdQS3JDWUZPMlF4allqTDJTczV5aXhJaWlHd2s0WG45QUxFUlh5OEJE?=
 =?utf-8?B?WWhod0tqVEFKTUNQRlo4eElZVDFCdnVhYUs2TWR6b0U5b3lYdlNDcUNwaUV0?=
 =?utf-8?B?c2gyMWNSUWRwNWZMRURKNmNiSVNtS2cvbzdUNklydExGbG9Ob1JmQVk1L3Fw?=
 =?utf-8?B?QndXL2U2aUh1b091NThvbDZEeVZrQ1BzK0dLUVlhWnB3VDJDVkI0djZZQTAy?=
 =?utf-8?B?c3JsMGpTQXVMMVMvZ0dyYjVjVnY2RU42TlNlQm1DY281dkhmY2dwbFRrcjRK?=
 =?utf-8?B?dHZjOHE5UlIvNHVJZi9vWUoxbFNFVkZvTnZST0hIbjBIN1JaVDVIdHp1TlZh?=
 =?utf-8?B?T2VqZDdlK0w3SkZEQlFCSWJlejJTZmNEVGUweVY5WEJCSkYzaHRDNGxha1RE?=
 =?utf-8?B?ZkJlRXBNcFZyN0NmRmdxRUVONU5Ma3ExNTlzTzhkaUZITFJWL1hPUW9MMmNF?=
 =?utf-8?B?dDh2Y0JHeXh1d24wUFZCbVBMeDRBamx4NWFSVjQvL0dpU0NGS0JGc1ZxVVdG?=
 =?utf-8?B?T3BJbDVKUHJjMGNRK1pNOXNWT0NzZm94MVgvZ2JsdWJMMElPb0JWVkF4TU9C?=
 =?utf-8?B?NWpFQlUrbUk0K2lVbnpMd1NpQlRPb1JSWGtCQ1Q5UFcvUTRONGJvcDJWMVNs?=
 =?utf-8?B?ZkFkK3UreE5LUzZMN2p3RHh2VHcyejhrdGhnbFFCeEU5aGtHNEtHMFJQZVZ3?=
 =?utf-8?B?bmdLMFIwczIyeXRGZEY4ZU1YS242a0Y3TUh6ZXBGcnV0RlQ4cGUvR1pLMGdF?=
 =?utf-8?B?bk8wVitxV1IxNFpreUNYdlI4SmxNWTZidldoODRFSkVERk1VdVI4R2JkK1lp?=
 =?utf-8?B?QW5kVkhxYm5ERjByTWlldnZIamtEZTFoWmRZTStPOVJEUTVEdUZISlpnSjJF?=
 =?utf-8?B?L1cyU09hY3krYS9XSXpKMXg0RVhNVHZTZGorYXNqQUNLbVRQSzdZRVJQcG1Y?=
 =?utf-8?B?V0JSeUpNOEMwRzh4aDMzQWFhdVFzSER3Skd0Yi9lcUNoeWVWNWJod2RTT0N6?=
 =?utf-8?B?YXU2eWU4VGJaYUdOaEtyekU3a254SzBZS0ptVlBCRlVhbjBPdGh2OGc0bTRi?=
 =?utf-8?B?cjRneWpKZm5qczZYN25zUlRsOEkzWFdkeUFuMEtCcVlKampXamUyVzlYenpJ?=
 =?utf-8?B?U2NIbjNMRW82VHZ4N3FXRHFTcHVZK21aYjdtODd0UGVrYlcvcTJDYUNlQzFN?=
 =?utf-8?B?QTgrTk04MEljdnVmZUhXbVk0MVRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3025C15F4DDEAE438A6F7BBB868D0678@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MrV+D0BH7CPJKWjIIooxbmeVGoDVAyhwPgtvnUNs9n6XfIePXjX0MgNeKK0rvzky9GPm7SHygz2oj4iRAjOE3n0DRpCmKfqn2/E0LDNwy8J97Fff6jDtYdk88Eyx84VJIFj9ZAnlfGuI+Dp5NCRb0A/XOmYNuQziEZkwjZWv6w/YGzXLPc26rgnofgeq5+DMqvDk0ItDf8Tf/cfhlX7aZyTsP8oy0XlOCdA+w38+3ZPZk09L1/PiD4Si/kpNeHIE6UMUDQBeleL/xo92ymV+B3mNJU0FUCzawAFfvRrvDIj9DqbDWgMPJwai11Q+uZ2szUKvgHpElUODy8lzDzibUqSpRnVopoORyd0F96YnGt0FpcseSjbphWn0MlofCVLiIheIH29AC/Q8umZvjERnI1VnJA7R1DgH4TJmiiP1j6Q11fzejEAmVDyNE6QLQhHV8h0zyg38Lr9kvdUcqbazaBo4L1u3c8Rov+B/99fxW1cK7ULPleWSrlaNp7X1yj8iZCK+Zyconz/XiPXhQGvLqvlOYJt640/ChTNL1lcsZ9Qv0Y8TNUhVeC/sef+Xa43IrG7CW418Opp5HdVuvSY4C7zga7vMIqiTp5zvP8DkEWb+NF+vMKM3KaTlS82MidIE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5800a4e0-f828-458d-58d5-08de16b6c0f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 06:45:31.0167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wz3bbYm/ZpaNSKPgL4VZY0HM/g+e6kHcgAVqUdRbhxcfZD87rw8tWFyUiQrAGdnG99A7mMuSRWZUp4I+nLy8CqAyOas01+/dqPUbBbZyLTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7154

TG9va3MgZ29vZCB0byBtZSwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9o
YW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
