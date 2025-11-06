Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA41FDA89
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426141; cv=fail; b=Kvk4u4P9UK0TqzWUb33q96rQFd7Ajsh7wIpRNM8fI/Z+YGgw1WzZczkzMl0/x/PFO5Vlltoud9LePogm6oFL8jn02ATv16ehPxOcyLDunHtV9zlsw0xrRLN8ipQKVp+C9pUIn8CbO3di8iOxTQqSFhhXt1e6B9jTgvbisZ2fJOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426141; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hJRmDlzDHyf8eoQaHnBHJEFrdSsCPi+LlKsk+1sjB7S0MCuw+CxuUlBaxRkueTjY+chehTDa3YKJnkL56/CC/dGkTMWbJwX3kd5XGDvCcj7CFE3g0fQVvpdjEo7YEwRdBqwGWFcAdQBDZABSCqiiLECCZMpwgl2Jm2s0z15P/JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=O5B3G/5D; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ml1WvefD; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O5B3G/5D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ml1WvefD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762426139; x=1793962139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=O5B3G/5DpuQOj/t8nnhKIUj9ac5KZpHuP/Leu+L1uaf0ShjOyn9PraYM
   nBLZm9t1TEYkR/u2tf888lXOiYCvio0+gO/cxi4r5FELQyVGqvh7Uu5me
   Y+bhs2HHskvB3P2U0MuF1Trov+3idEjb7jIksDI9qZOSVmcYoxrPWz4nr
   ck8mXCglImCGdDirt6ciGC3Ng0VV8Au1QcaH49gOBNMibnhqF5znAUIdG
   OdEPT1mzpeDhcqXmGYVrri3fP0A+gHI5zwK6lRXGQLS5/wooHFesHHHE3
   gQy4GysLVo1uVihmDui8VpXP7sqqq7IsDevv1wAPofVPru41Yw2zv42pl
   Q==;
X-CSE-ConnectionGUID: xvD9iv1DS5GCDhhrVltCqQ==
X-CSE-MsgGUID: bqM/9ozJRSy6E5TIVdOKaw==
X-IronPort-AV: E=Sophos;i="6.19,284,1754928000"; 
   d="scan'208";a="134254206"
Received: from mail-westusazon11012021.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.21])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2025 18:48:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWr2wNC5aqpbh1OCgEBdoBI8zBwWS+4n6ZrYDd9kz24/ZVNrMgQ3wqsaC4tm+9S45At8+a+hYaFivjo3kT6XcdxrkgewbT4LSSNFxI9/KNaXDPX9IRMlV/4nhrZbfw4XnTH8yQpPRfTvWqwsKaHfDiivhHaLRweTE3YcJiiNtaXqdMwAW3njUz40M8mYSrux+whwC/8V1wol5XW1sklH+UxBciddSSVtHVTGHgFZ/MDQZQeGh2eGVUvlTCx3LWr3ojnK/c/ytPiY2MXZ6dfkrBjxJqK+ofV1PMtsE7+gDJU5zRjgtaPuOW65hKQf1RpkqKdUucwEG8QSZRjyr6x71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=PKzJcC4RSdVfBfJme663bYQDuRoDVwgADD2HPzrJ5f9KaL3ifDYKtgu11pqf6yYUCRJb0D0SOeUgiyLfVn9uhBmmydlI5NSvYxiaQ1fuxb0PI1SWIdsHPKo/mJlgvQEFrzwQrbfQzLdA2qgmyUNsP14DxMq3876V/YLC44vO4bPJz3yQf34cn1/mqgVJQHMU0QhTARuY0LdE3jH9lN26hcecmW7AVn5gbvZgvsl+fCAXZ9EHsDkg/6ilkJsFBWhczz0RlVwW3g7Xy4/FOOKOygFd7KM6BKJhSfdqYhr/jKURMv0HbxHDWSbE3jrdK+1P4/b6ku1Sfdu/evE9W8gPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=ml1WvefDaoN/oUoMTD5jGUEg52NLPG5zCOMWnOSGa0RIIyW2rynnHUWxUU6BwmSkGZdc7y4L770Rcn6wctIbcgh8V0mbthxZcHYtd4wi7oRtpsvssDo8CUwB7Whh0hGTPcOKyV4iibWepMCm2bg30nvU2K0IPfhN1jqQDVN7c3g=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA1PR04MB8519.namprd04.prod.outlook.com (2603:10b6:806:330::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 10:48:56 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 10:48:56 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, hch <hch@lst.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "dlemoal@kernel.org" <dlemoal@kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/4] null_blk: simplify copy_from_nullb
Thread-Topic: [PATCHv2 1/4] null_blk: simplify copy_from_nullb
Thread-Index: AQHcTsBrHSd6dOmvFESMSK9RIvPpOrTleGSA
Date: Thu, 6 Nov 2025 10:48:56 +0000
Message-ID: <079691a4-607a-4cf6-935a-bd1d30889b71@wdc.com>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-2-kbusch@meta.com>
In-Reply-To: <20251106015447.1372926-2-kbusch@meta.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SA1PR04MB8519:EE_
x-ms-office365-filtering-correlation-id: 8584b79e-23fa-47b5-338f-08de1d2215a6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Umc0NTcxdlJzOHFSVjkxYWRDMytncVA3dzc2RDFqU1dDbnBaYnJ1b1hRaEVH?=
 =?utf-8?B?VFJOckY3V2xZS1BVTW9uZDc2NzU4RmwxdkhjcTJoTVB3R056c1dnVU56ajVh?=
 =?utf-8?B?Rmp5WDNyZExmRE9CNzFwdS9HOFoxOVVDVzhWTWFUbC8ySVMycFNxSHpnV05M?=
 =?utf-8?B?Zy82TzlUVE8yZlMySGVwMHZPUUNiRGUrNmNqNEJQU3VyZHA5MGhjS3lMU1lS?=
 =?utf-8?B?OCs2UXhUQUNKRmxkbnZKYkJLZ2I5alRRU09JNzFWUXU3TEdJWTJrS01aMGhX?=
 =?utf-8?B?bkFQVGYzY25PZzdiMUpXclN0WkhXeG13L3VnOVNZOVdqTjJaRC9FSG9aYndF?=
 =?utf-8?B?Vlp6dXFrdWpwUEovNWlPZm5teCtWdk9LcXY0di95R01kaHQ2bm82Q2hzOW55?=
 =?utf-8?B?SGNRNFdEVXRPeDRJa2lRajRWcHUya0YxQmlEVTNrSFQ2dVB3aFJ6V1ByR1Zx?=
 =?utf-8?B?SUtIVEdPQ0NiY0F2TzdqMk1YTXdHZmtxZXNqUjhqMlNvZzFyUmpkU1FXWHVH?=
 =?utf-8?B?dXJkQVk1SUE0ZGJlSjV5RTkweit6QmRrb1p1ZmMyeXc0OGk2NWc2U2Nhc1VI?=
 =?utf-8?B?T2pCMW11NmJHUXA1Y3ByNTFCQ24ya3BWZ3NuQVBya3QrRGx3RG9ST2ZhL3Vm?=
 =?utf-8?B?Yk84eTgwN281dTAxdFpzdGZBTTVhSjNkZVE1a3ljY3EzemNZaHUveklQbE9v?=
 =?utf-8?B?RkJJRGxjZHBlM1NPMlFMaEo5UnErZ3RDYk5yN1lub01kbDkyeUFWcmUxdWEw?=
 =?utf-8?B?NFlJdXJ4SzdPSHJqbXA0TE9VSitTVzYrRmJDQ0NESGptSXZ5WUhJU09NU3Ir?=
 =?utf-8?B?TFQxeWFVbHp6OTF2TnhKVVFIZ0h1K1NQVFA3Nnh2aklMTUJRVEJKWGVPTjhQ?=
 =?utf-8?B?M2cybmhCaWhvQXZVV2w2dnFUYitCWUl3KzV1ZmpKajFPc0VXOU5zK0NLbVdM?=
 =?utf-8?B?Zk1OUXlsRlFJamFoWG41d1ZxWm4zVDhuajhHWVVhM2xIMTR2WC90eDd5TERa?=
 =?utf-8?B?Z1BHZHZYdzBRTXZzMzEweHFwcjBhQmVqQ3RvUWpMR1pzZ25Kak16ZmxIWVhF?=
 =?utf-8?B?ODlnKytjK2xiNytzdW9GRDlhZVNtaHIwOGkwa0pwSW0zTGozZGtScnVrbWdF?=
 =?utf-8?B?ZjFzR2NlTEJpZDN4Y3hIOVQ4Nm9yM0hzWWVaaUF2TkVyUjNXMUlpU2IxaStk?=
 =?utf-8?B?TWV5NndrTTg0ZXYzOWo4dmlNOEJGRWtmMnBuTGZPZy9sUWM1cER2SExDUUtX?=
 =?utf-8?B?aG5rYWxkY252NkZYZUhMb0lEbmI3WjB2cUg5Q2gwbWVCZ3RWOFFhTzA0d0tj?=
 =?utf-8?B?UTdlb0RFQ3J4YjJYbjdPc3pnQm5GUDBDZm5rTWFjaDFPRTNuZVp2VWJuT2dJ?=
 =?utf-8?B?dXZzclYvSEpIWHBWMGVoUnlmanlLU2ZTM0g3M3lVUFEyQ094Zm9Tckt6ZWRw?=
 =?utf-8?B?RGxEcSs1QW1hUDNuWlRrUjFrODFaOXpDT2FJNzY3T2VHdlhqVGRnY2dLM3p3?=
 =?utf-8?B?VFZrMlJrN09NZFV6TE1hYXhuNHlVRWJGbHZXby9pNmkzS0FDeHRzQ28vdzhp?=
 =?utf-8?B?YlFjUWZmUDBIOUVsMGxQdXRReStUUmlXaGV3aFhDLzJETkxZbGk0eEFiNFFI?=
 =?utf-8?B?Nnhndy9GbUtFZ2wxenIrMUFKbElYWWhHK1F6bThib3pvQm83YXp2UUhzZmJz?=
 =?utf-8?B?TWx5WGJTb3YyQ0tneC9maUhHem9YSUpoY2lCaDMrcWY5ZlVUNEoyVWlWbTdv?=
 =?utf-8?B?bWVkN2RKSStTMnR0eWd4ZFVpYjc4cStSWmM4elViOUdlZXpDU0hlNkdwQjV4?=
 =?utf-8?B?My9jRERlU1pJVDh0ai9Bdk4zR3NHcmdLc2hpQ0JyQlVkeWlKNDQ2UDJNV04y?=
 =?utf-8?B?RkxIV3ZpSlJiNFJSNkJqT1IwQ09RK2ZOamtmMlJVSVF5OXdMQUZXSFoxL256?=
 =?utf-8?B?dU5mY09ueDA5TU1ONjNBUzloNU9GSHFsZ1FTM3QwaEZoVWdqQWdtRnRxL3V2?=
 =?utf-8?B?VmtuUGpINlZCRzV6L2UyUytadWhZVGJOT0hSQ0JKUDlnSVJoZDF3K1hOWllD?=
 =?utf-8?Q?pfQs1j?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEhMUVNFZXlLRjhNTHo5OU9TeEZyTTRZc21MbHBNdlFhRXVqV3FsUTRQTUV0?=
 =?utf-8?B?a2xYSy9jaUhlM2ZKS01ucmFyanZPVHQrN3F1aDNmaTMzZjFLcjJ6aWpGV3RN?=
 =?utf-8?B?V1k0YUlUSTBpdkJ1My9vODNHNHR5allXdjlrSUs4blVhc0pUMDVkN2RiQWQx?=
 =?utf-8?B?dUQwWHliWnQ2UWlDU2hXUlF6ZTl1K2puYlc3dis4a3k0a2lydjQwZFpSNDcz?=
 =?utf-8?B?R2FudDlpekpHZDQ4ZkNzeGlwS29SR2RQQlFKK3dkdkR1TXkwZDRhL25Xb05D?=
 =?utf-8?B?Y1BxOFd2L2QrVHM4VGpkd2t3SjBwcmluaVljak9USXVtRVV3b2E5UEFjaWQz?=
 =?utf-8?B?TVFjelJmSnZEVVA5Z1pBQzVjQ1ZTMkhEcVNoc0F1ZER4UWxtMkx4SmIrYWk2?=
 =?utf-8?B?SHdmWG5tQjVSaUZEd3RQQ0ZUcnVyeWcyd1VrZTZSWE9qQytlSUZGL1FzTm9U?=
 =?utf-8?B?aEdkalZNRXVlNDRKRkM2NktNZjNQTmFMVFYwS1E1NWtCK0svblRhRFNzRm9U?=
 =?utf-8?B?bUwrUUZ6U21aL2VpSkJPVC8vY3h0aHNYTmxVNENsYTRJVnVIMXQ1cXp0UVBM?=
 =?utf-8?B?eldYbUc0VEs5ekF1MmwweXA4UDFVdFJBc2c1VkdoYUlBTDltcFpLVU1qMHVs?=
 =?utf-8?B?T2xqZ1BmNkhjWSsyZy9oYXJnZ3JlRkE0Z3E2OFplVlNNNThJRWtLWkZRNHBq?=
 =?utf-8?B?Q3luMjFIYkM3d1JyMVl0TDBWWjhxVDBkOURCM0ZNdHNSUlJSdzh5U1dkM05H?=
 =?utf-8?B?b3BaZW5HOTRDSzlUR0diK3hmcDJ3eWtISTNCMEpSVHAwT3FTaHkyRXl1QWx6?=
 =?utf-8?B?a2c1ekVpTFh5TVBsanJTeTNQcmV4dU1sa0M0d1U2WFVOZGZrK1RkY1lUb09Y?=
 =?utf-8?B?QmxPK1pHR01mazhnUEFkbVg1VkpkaTdZb0plalVFdUJud2pDUnlUV1hwczhR?=
 =?utf-8?B?NTNvdXV1ZDRNclJKcndBU0hPQWlHSitrZVY2S2NJRktQMWkybGtqeGlTcjNi?=
 =?utf-8?B?M1JOMS9CTGpuMUtTS3ZBdWtiaHIwZ0Y4Zk1qMytaZ2hYUS9qSVpkcjh0anpD?=
 =?utf-8?B?QVJTSFh4QThRTjBmeSs1WEp5bHo4ZURyRjQ0RHFkdFU0TWQxS0R4TjVKaklH?=
 =?utf-8?B?dlNZeUIxbWpqcVhiTDMxU29NQWRyYUV2dGlGR09lZXJmQmpKR2dCb3I5MkZo?=
 =?utf-8?B?Unl4T0o2djhodkZHT2NnQXRjczZDN0NmN3lVMjk3OXRHOVBPY2JmMzVlcDd6?=
 =?utf-8?B?VFhYNmhsek9RU3BEM2pGRFAvY0VXYVIzalhGaEVoQ3dIUkxRc2pkRlpFSVYw?=
 =?utf-8?B?YzJaZXBEaFM0djM5Z25jSFQ2ckZXb2V5d0hYaW1uSTJDeEFFYlJoRnc4VXBP?=
 =?utf-8?B?ZWZDckp2cnNKNXpUMFFCeEozanlHd1hRRHZoOTN2NXRaaFB2bmhLTzZhODd1?=
 =?utf-8?B?RkpMYUlKN0llSzJtakJhdWJhS280WjRJMVdLb3dkNDI5dEY3VmdnZ05lVWYz?=
 =?utf-8?B?VlVIMmFSa3pjQ2F3UFo1RlIrdFR2V1ZadnRPbjhUdTAxT2VLbkcxVzl1ZUM2?=
 =?utf-8?B?SWxFUGF0ZG9qZUsvL2ZsRTRDNm5vNmJOblFoNEJJcWxmY09rVzQyRjV4WWJG?=
 =?utf-8?B?ZzhsbFpKcWRrdUt0OWx6K1BuV3NoTEw2ZGpBaHAyand3Yi85Ty9aRUhRM2ZT?=
 =?utf-8?B?ai9JSXA0QnJwZnpGeWZLclIveU1UK2FINDQ2bDNibnZVbnhnUmU2N0JYY3ZR?=
 =?utf-8?B?aFFPb1RxZmNqZlZKc2IxcUhNV1k4VmtFdTUzcEtleUJIaVYyV3FBZCtQRUxR?=
 =?utf-8?B?SFRwbXNqUlEyOEN2MWUwRG5VYVVJYmFLa0JMUmRHM0dlL2VxRzdwbUR4RVE1?=
 =?utf-8?B?cnFVaHZORFlFMjNwSm1UQnVFZnlkUjVCc1NBWjY0bXdUT3FreFRhSkRLTm5U?=
 =?utf-8?B?dCt4cGFwZW92WWVkVmZucS9yblc5WWx1enJhMlF1S09EU2hGc3pSQ0wyd2I0?=
 =?utf-8?B?UDFxZWkzTXN2MXZBNFBUM3JhcDk5dkhBOWlzSGE1VHBFM2wvaDhQS0dTcTd3?=
 =?utf-8?B?YXVhMFNYR0htZGJFazlTdjJRcG1yUVhLRnI0ZzQwN3hvTXhuN1pzc2RzRVlw?=
 =?utf-8?B?c3RiY09tTjY2Y1ozNjh3RFhCWjJoangrc0lSZFZvTXZUTXo5YytzWW9OMjJ1?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2FA9AF9D7BF3C40B68BF537E2288531@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bPKzsR6XnQfjbofh3T30kbqiL38hZxq6ZJHIWxOTAnK2VWbFjhmIIZR/4dqsSiQqJr9v99c7X8FFMHcvrpMudHokuWlo2ZpzMfqBmiVkvsmJNR/j5hy0w3YzEDbGx6btNfjEn4aTl/UJNe7zlpKgwO5H4qMSKJ+Xntk6/0WY3Zp9umKLEMgmncBQU4F3lp/CnLbcjnLHtM0rZI1/Va9sdUW4nmRdyzn7VbPwqR8+PQVDWyFVExtM5zACIGlGcknn21ClYD1+Gf7SC2R2ACwd8zlkPqZ2yllpnxpKwm5D1d394pWqtaGBS2AahNTXjlgOzyuP/FqeHNZpD6/4JMknYxl2wWiT3SuV412knFhTUdkI72bMITPBRFicyMWM9CdX0UTy935bso6ZwWjqZKSCzZmjqYnXh2iMGdLnWpZpAv8MtNB38PKWP6d4GqpfOR9+f96j4At5iPOGd/6rzB1HpcDzAj901GIYHqq0hTmoDGnTCP66bLZeaaAWcw95h/fYiNbJkFv202yzJrurhtfFAbkMOhL8T0h5xeZZhhk4inIux8zhHj+lU5zfJkLuFIePIadvEqEW4nIJdv4y6CAyx51OobYUqsA5Ep4GtuaUzr/vcVk1AfZPEGRcRtuJMAb0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8584b79e-23fa-47b5-338f-08de1d2215a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 10:48:56.2084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVWsBL6Bn+NKGflqvKpDhPy4e+JylMki5CJczcxzALHz7Yk64iOnuO4c+mGzAL1ED2GSFqoH9ilXs0SpWESqa0CUh/Hthq7BoC3TGkmV468=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8519

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
