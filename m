Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50A72877CA;
	Mon, 16 Jun 2025 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082188; cv=fail; b=kLa+JwktAxHAc9OzZTWm9DejKLE33yMyY9Nsl+zkPaVlWShizXXJKUWO2sqLsFXRqboBYdBf3NF2daU5XXWHEZ0kt/fua2wQgvyZ1XibhgJlEHwyRb1Afd6PWOsW57Rx4bRonHSf8/07unvWMzpbqRttYj7BrSY9mQzsxvkRneo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082188; c=relaxed/simple;
	bh=xEfLUP+AlhRNaY5sovVOIW59GzQM7ljOYojH0gPOuNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=th8gHyeDc9DiYowFmaTOHwv8dWzJeqavL2BnkatFq00wIYkWFXUAlw4VCSVrCF8pgxRXJEt+jA/6Wyo/fa38URy9slWMWD0lPGaukQpMXRAOXtK81vqfOEdIv2hPnw2NDV9cUnbaWUY5TxKSYjEc1Cv5ihyI92u23sLjKHU4MyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hkGeihCN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qvSD7VXs; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hkGeihCN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qvSD7VXs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750082186; x=1781618186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xEfLUP+AlhRNaY5sovVOIW59GzQM7ljOYojH0gPOuNM=;
  b=hkGeihCNB52l5BmmrM0aQZoB+8GM6I7xT8b6U07+kWM4/4mxgluKs14n
   hmvpyGjFGpbQPUlCEbq+tAUGglvevCM5NsugGzVMcdgXiFIsFAn9uE3SF
   Qz3VLxBqiqpxKwXu/epEOFUaq160isnKTKMZXpZQTzUVzixQKLXugoWCr
   9Y2szh8KbKzqS1IilDD6TuLqnLKFoYeYsCGQ3EjLr8eH57/yixJBVpYE3
   kauqbdqTbabYi5mrFyUifOkAdsv3p+h6Adv83/llfvWMExjqNcLPi23bW
   hlbFhQvk2w+OikdSY6CDlzUnr7HB6/RTertUayxRCFtcCv4T9sGtRxcC5
   w==;
X-CSE-ConnectionGUID: 8kgYXxOpRf2snHYhwvIOUA==
X-CSE-MsgGUID: KYJoM87+R960sFEAAiSmnQ==
X-IronPort-AV: E=Sophos;i="6.16,241,1744041600"; 
   d="scan'208";a="89588535"
Received: from mail-dm6nam10on2075.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.107.93.75])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2025 21:56:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeJU815XVY2/GbL3SIqu0rG0MJbbfDhzD8/xV6gjoGE6EwfUsAM3MMvHsgLsM0mD7ibOrWUQZeuJkME8UBVk5ZwZ7/FwNDxWNOK8xdcmbsVTQ/fWoak0ybV44lp1mU/7SY5sRSUwPs+mL07cUFyDoS470HM0jSkdOO4mIiAFtLnwWHvDV6F0Fz1j9PlNBDXfG7D3Axf2VrugNJZtihkLULesM3KnvH4eTgB4ZJGnUXFJYLcDzmd1zURsGsizBp+Ikm5S1SrDDOOja8rCQE/FyQcT8VdV05HXn5nTOUdTTpzt/jrLozA03fg5YbXP3vqJAURSuYWQCOyirwHgY17Blg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEfLUP+AlhRNaY5sovVOIW59GzQM7ljOYojH0gPOuNM=;
 b=pRa4q/4aV7IJk5St7U/gKgIBSad/UPkyoqW1PYhMzgCJvugYdYl8bDyFMPqX/4FzQFnLW3PxxftwbccOY0roDenGxXXkTdPB0O9Qe5pu+rkY2VIOGWQ5seMpL7NVg4iRb3YAGpvJnR1+LcMaWsjPg4ZvGmY6zvMp6rFb+pSg3SLtwXH9V9WgE4UCYdRNM3Bkn5DtmGlFUVswchuzN/lI1p+ga/BaQyZDFHug6c47oI9x2F9dZWA3m9Cw1AZPpj2JJ6Z/M1RB1/E8OYzkFnD4Ufwn6Pmr8P+osRtVoluCl0gw5dRwUjrDWMZUOqxBXLqiUPa/xpUHascObRhEzTxH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEfLUP+AlhRNaY5sovVOIW59GzQM7ljOYojH0gPOuNM=;
 b=qvSD7VXsfoGBw+bF3lvqJQHKohSEY2OcmEaOOc4OLcc7bJKFzL15D+eVUkrsPc24m5HkEKcLfGx5etEQ9+UIIt3BTBOQ2IwszZtIhrQicd8DrJq523zBomYVgWS6ueWCfsLX34azyTW7Hy99oknmwSd6DOr/snM3zjYoCptzuV0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA3PR04MB9332.namprd04.prod.outlook.com (2603:10b6:208:505::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 13:56:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 13:56:16 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng
	<boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross
	<tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 9/9] rnull: add soft-irq completion support
Thread-Topic: [PATCH 9/9] rnull: add soft-irq completion support
Thread-Index: AQHb3sKS98NDzXlofUqbPGxwzshFtrQFz1UA
Date: Mon, 16 Jun 2025 13:56:16 +0000
Message-ID: <2399a39e-a4e5-4f19-a5c7-2582b584e9d7@wdc.com>
References: <20250616-rnull-up-v6-16-v1-0-a4168b8e76b2@kernel.org>
 <20250616-rnull-up-v6-16-v1-9-a4168b8e76b2@kernel.org>
In-Reply-To: <20250616-rnull-up-v6-16-v1-9-a4168b8e76b2@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA3PR04MB9332:EE_
x-ms-office365-filtering-correlation-id: 806bdd1d-24b6-4843-f35f-08ddacdd906d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2ltUkdHUXN5S0NSWjc3L2hnanhqN1NpVHJKOW1MR0paU3NvdlZuZ0ZLRnpX?=
 =?utf-8?B?cHVobFk3bzZpdUk3NXBjWHNyY2JQaStWQWxDK3ZUSGR5dzd2SmkxMkxqTE01?=
 =?utf-8?B?bForTW85dUYraUxFYUpzbmhSQzBCcVE1L2NzOHRTVGVUT045bDZWYUhKMkU1?=
 =?utf-8?B?ZzhHaHZBN0tPa1NLVjhRQ2oxYjI4ZVdBZDFXRGFxc2Z6eDc3QWJxbWVPSjZH?=
 =?utf-8?B?NGxxN3NyVi82RzhrM3kxQkZUZjEvSXlsVEJubDg0NEtuVTJac2wrU1dwL0ps?=
 =?utf-8?B?TDRlc0pkSGUxc3V1Y0JxYk96L21DR08yT0UwN2JsckhUUG1MZXQ2RWUwTkRO?=
 =?utf-8?B?ckdlTGtjR0xhM0hvK2tldlp0UUFBaXNGMTk0N1V0MUZzRkVWMGZSOWpVQUsv?=
 =?utf-8?B?ZlErL21zZm00MTN4MVRROGp5b3NSMHJSTTU3ZEZMaFk4d3U1KytJK1R2Mjky?=
 =?utf-8?B?b1Juc2h1YnJ5cWNkRmsrSHBlcjlrdWRyeUcrSWczYldiVUo5WGRsaXltREdH?=
 =?utf-8?B?THltRnlkUG9JV2pEUGRCQ3FmUWZOQXh4cE9IQ1RPSjZIQlVwZm1oRzl2VnJZ?=
 =?utf-8?B?d2ZSbEJ5ZE9NTEthRlFnWHpmcjFkcktYRStGTDM0bEUzZGVWejRyUGw2TEV0?=
 =?utf-8?B?V0s0c3VweXFVdW84RjNIWnNFNWtBZ0VsNG1mQkphWWRrZGZGaGcvaVhDZ21m?=
 =?utf-8?B?cGxKZVNuQ3FzNUZncnZUclJJcHJGUXdjUnY4VGFiUm1FeC91S0YyZlJqRWxC?=
 =?utf-8?B?dXl2QndDZ0NhSjN0bXh3UTlzUk1kSVRLTVNHZHdoM1p1VndieVBqNkFKblFJ?=
 =?utf-8?B?NzNrZGZ4Y2NqYXhockF3TUV0cllEL3E1TTFjUGRkdktNTTVJSHpTb1RLV0xr?=
 =?utf-8?B?d3N4VjRNazdYNXBXOXMxSkYxQWs0NnJMN3djZjZ5aURUQnJZNTBkSkpNekpU?=
 =?utf-8?B?c1Iza2gxaERmNmoyaXlVVmcxV1YvVFVtRENzSUp3MnRpY0lLblRYWFppYU8r?=
 =?utf-8?B?Mk9DSWtvam45bzhwbkhseGpCWFRlanNGRnZvK3haOHk4TEFRUGJhTWFiRG9E?=
 =?utf-8?B?bTVpS3MyNVZqMStOZHFoUGNnRjBsZTB0ZWozTnNqVnFUTGhXenpDa0pMUmh3?=
 =?utf-8?B?WUJyTUhrajU3MG5ST25JWXl6YWJ1anJKcHFCd25haUJjNWlSRlBEdVAwbHJj?=
 =?utf-8?B?Tm5EQUErRHIyZTJDSTBZa0s4QWFWdzBaVm14RFJDOWxTcm9GOWxrZzdCMjdk?=
 =?utf-8?B?dUIyb3lDeW5DczBiZkhzKzg3c1JpMmhkL2paTmoyeXVYcFkvNWluRENBTExW?=
 =?utf-8?B?akRGUlpDbVZzeThFYVlMZEd6NTVQYVkyQnRCK2paZG5hRGhOSGx1Y0dsVk90?=
 =?utf-8?B?Vk9BZkhzL2JIREZ3SGlOeVpwUjJFMG8vL05xK0xoRURDRi9hZ2FBZzJlaTkx?=
 =?utf-8?B?LzRGUVZqK2k4NUMvdDBjRjU5NG53UEorQWtTMHMybFV4d0w4a0RTcmJvWG9h?=
 =?utf-8?B?MmkyU09OMUpZRTVqV2c5TDcxbi91NHhhUFJJcjVJQlVOR0ZhTk5SVWg5cFZl?=
 =?utf-8?B?K0oyTjNSRUpHK01CVDZJMHZ2cVpsUlZtKys3bUczTGE3algwbUNzYzdlYk14?=
 =?utf-8?B?V09IdUpiWmFUMFJGRHNxK21ncFBkdFVDWklsSnF4cm1zb0NWc0FUOTJ6c2lV?=
 =?utf-8?B?ZGRIcGZUNGVFSnFjQ1ErOEJ2MTFxMkxnQklRWmx2Y0luY2ZSUi85b0VDdlc5?=
 =?utf-8?B?R001dUo2UytjbHlhdkMrQWdsUDdkcUVuRUZqOWFMb1pqbzA1NUM4eW5jZWpK?=
 =?utf-8?B?ck11Y2pvdEI4WU9XZnBLUmFXekQ3WlN2R1Q0QUlDWitLZGhLTmFiWkIxcXNM?=
 =?utf-8?B?Uyt5WEFBd0J4MmZlaFdreTNiRGVXODNKYU9xLzNCYmZqVVNUU0FPWE5EdGVN?=
 =?utf-8?B?NFcwdDlaODFSRUtSdVJMenl2NTZlOGl5MHI2Zlk1N2hTdUk0SWNldXlwWjN1?=
 =?utf-8?Q?KutcrRWu+/fVKOMECsarZAcWw/NGfg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDN0WU1SQzRZYW5pbjJkV3J6K3JEcm9iTzJpYXlwRGd5NUwwbk9HU0VnNjN3?=
 =?utf-8?B?RTMxOEYrOHg1bFVDdFZIWjgrMFQ5U3V3cU5GS3Evb2tQMGtmaklnV3FXSGYz?=
 =?utf-8?B?UmNlaGJFNlNidmFMYU45eXpibEYxdnl6ZW9aZHZJVGFMZ1AwaEdmTGZYZE5F?=
 =?utf-8?B?UGRVN2hyTkxTR29PYzJveFo4clhFMFlDenc3Sk8rak5qL0N0RmIvSkUvOGlx?=
 =?utf-8?B?SG5Cd0RYTE00cmdHVGxsdndGMUpLaWR2TjVkTXVmMXVnU1MzVzBQZTZjMzBx?=
 =?utf-8?B?NUVyaDVVR05XeEtqZVQ2cDltdzJvbFRpb1NGWUtPWk9LZjFxVVYwVmtSa0Ey?=
 =?utf-8?B?V3BwSk80Y0ZVUVNscnNrcGxINTRSOGZnN0hvM08yTW5CUmJCeU41OTlETFZM?=
 =?utf-8?B?SlBqQ3BRMkF2SDRXNFFlUWxJOE0rTStaZy9kdGJlV0k3TlJqVHJMbVlRWHBt?=
 =?utf-8?B?UWt3MHFvRE5qZVpaR0JYSXFubU5nMitiYUM1QVQ1UEhSbVVMT3VLR2xFSWhk?=
 =?utf-8?B?cFNsZUhDTnJpNklWaDJldHdzQkNSSkFjSitjMmpJbDBZMVVpTXVZRHd5ZUox?=
 =?utf-8?B?YmE2TGkxdVc1dGdsdW44ekhJV29HRitIejNDYWd6d203VGxHdXhFWnJ2cHFM?=
 =?utf-8?B?OVJHd0h2ODY5TWtWc0hGMWY3aEJlNXdiYTFkMld2aU1XUTBWR2ZlcGRCa2NQ?=
 =?utf-8?B?andhTU1kbFZlSEVrbVVwSnE2WFZrY0FnaTJUdEVydEZKa3Y0WUhFUEJBZWVX?=
 =?utf-8?B?bzhia3ZGKzV1VG1wNGtVOVpaWjhubFdvaVFQSlVsOXkwSU0rdWU3NCsxZHlq?=
 =?utf-8?B?Qm9SL1c2Rkdya2o5QVM0VHk0Wlo1TWZFWEh3OU9pTitnSnQwaVdOVVFZNTV2?=
 =?utf-8?B?SStWeFoxUHlEQ055eTltcFRENzF1bHZCbGEvT3dDVWx5Tkw4VGxWMndvZ2NW?=
 =?utf-8?B?ZThqWHl1aDBsb3VSSUZRVG0wOFNLZnlmTDVtd3hKd1lQUUFhdEZONzJ2UFh0?=
 =?utf-8?B?eGpwRy9jRkFET2oxV0Nsd2dCNkRCTWxKNncrYUFXSm5BZnZRVWptK01PdEk3?=
 =?utf-8?B?Ly9naE1sc2s0enpZZERSeFBWOU9vWTkxRWo5cDVqOGI4Sk5INEFWL0tneHdC?=
 =?utf-8?B?RnNBb1FjRXRjTzNIQlNXa28yd1lOOWVJYzlKM2U3ZkI4RUN3RzVQV3NJZmNl?=
 =?utf-8?B?SllpZDN3anNaVFBjdk0zMEVGbXBHM2JEc0VudUlhaVZCUW9CR0lHYjRIek5t?=
 =?utf-8?B?d09nTW0xdHAvaDJjVU5ZT3VZVzZwdU44K2MrM2FUYUlnM2Q3bmxldnNLVU5G?=
 =?utf-8?B?c0lGMkd2SkM3VU95U3NQcHVyZDRRQWVxVWlYeFVGZzI2M1pZYi9WcVVKS1Za?=
 =?utf-8?B?aXFtU0IwbWZaWGs2VWR1TG1PdTFzK3RubjN5WWNJZDUzdWgwbk12WE55MzhH?=
 =?utf-8?B?NG4xS3ZRQUtVWnF0ZEZVNENJZEdsRFhwVCsrOVhTak5DOHFjNjBBSk0xZlc2?=
 =?utf-8?B?b3FQK0xZTnlHbzltVXNMa251aXdFSGxEWUhKOVZlL3hkd1pjVFpSMk9EVFkx?=
 =?utf-8?B?a2FLTkpZLzRMd3BCcHQvQUtQdTVMU1luVG43MmxyRlVkWEsyNVkzTzFmK0xE?=
 =?utf-8?B?Z2xVNDU2UFl1ZllWd0dUWkNXbEwvVkYzdlhzRWZPQWZTbWRySzRSMHE2bGp4?=
 =?utf-8?B?Wi8yVkZqMkpoZGtYSHNLSXJZQVY0d2p6Z1BIRE8wQ1RrWXdjNkJQeGhoSW1C?=
 =?utf-8?B?ZEhQVzhFd3ppeUVwdkp1NXlsMm84REk5RVNCbDV1LzdLbEpubFpVeWVDblhu?=
 =?utf-8?B?Tk5TMU5ET05ZRHpUdVFZOHBXVnVuS0FoU0l2SEE2bWRNd3NoNGgrYzhwaFV0?=
 =?utf-8?B?My9EVkpQSXRmc0p2L3poQWg5dXVJQTdmaElSVVNEQ2tZV0VBbnVPSHk2bGVx?=
 =?utf-8?B?ZzRUcm5QamF0TG8xcnZpL3J1b1ZTTWNQYWtDVTdPeWtzRWRLVGNRN1lDWFFR?=
 =?utf-8?B?T1dsOWlTVFhVb1lDand2L3lOMkpyMk9BaHRpN21yR1JzblNJRlRDdVJGYmNB?=
 =?utf-8?B?TzIvN3h2cm5TVUlkRTc5c3U1dmtQYkZOWStPQXhpblFJWVo3NkpSdEdGNzlL?=
 =?utf-8?B?ZnRaOHZBRS9USFBEOFpxR0RJVFRrQ053bXl6TnQ4WEtCRSt2TFBnN3krdHA2?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2529E4BF3C5ED438358343655CE544C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D3espu3q8nIJNMAfDB66YuXkd/6BjxW0h8k4w2T/eGx8lN6753bMaf+4GROfOt3iTwRLF4+dDcHE+sCF8dL2RCpzHIZNir3CJbblQdaXG9BaIgI5wwvT4S/RJgrcYQJWRrRhxPbmkJLYzHRa9REt7+sedy0sVOsHGQBpKDlOn3ebPFgfp3Fi0r8AluFxPcxQAFdrGeweXBMVgUkio7u8Yidq2UiZ8OyqNtVdgOTbPaHJ8hVjq4+reMh50WlXicToTNvYwBH5pRDlubpUjQcUi9NdQJQHTl8LhCeoCcbzUENTM/yMHq7HCzPMyYoafgUa5+HnXxPYR2eyJUz32eO+j/FlCW8YU2FAzsja+9Gvs/3iRhYpqqdA5nw0QHGMHroeF6AybxDJYu6k9vCxKD5yOcdKJyUfinj03cHGw3R8odHFHy+M73w/p+owIH9K1YkgoCMfdizfBpucVEcW/umWlOSGHpvG4Xd/jDvjWYphLpIkWdcfin5otiu4LfjSQrL0dZ+FBf0m9d00zUo7HyOV6ghkLRwfMxwGKu0dQckWugYL+UoqVF9tK/6fpxdjAuDzW8RWarljw0mwHoQ30FcXgZl8+Kwu+awYRCXTaijItBNoZfDhkYl/3s0UKesc+Vz8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806bdd1d-24b6-4843-f35f-08ddacdd906d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 13:56:16.6798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvtwRsez/IbJjBQ+ZPUo+9t50oQxeCHwecy5jrr3O/ezqiJMa7hC0/018VWxTn+HTEu4izoEjgXxvZ1m6mDAEwv0xt5LvbnyQRyVOqAPboo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9332

T24gMTYuMDYuMjUgMTU6MjgsIEFuZHJlYXMgSGluZGJvcmcgd3JvdGU6DQo+IHJudWxsIGN1cnJl
bnRseSBvbmx5IHN1cHBvcnRzIGRpcmVjdCBjb21wbGV0aW9uLiBBZGQgb3B0aW9uIGZvciBjb21w
bGV0aW5nDQo+IHJlcXVlc3RzIGFjcm9zcyBDUFUgbm9kZXMgdmlhIHNvZnQgSVJRIG9yIElQTUku
DQoNCk5vIGlkZWEgYWJvdXQgdGhlIFJ1c3Qgc3R1ZmYgYnV0IEkgdGhpbmsgeW91IG1lbnQgSVBJ
IG5vdCBJUE1JLg0KDQpCeXRlLA0KCUpvaGFubmVzDQo=
