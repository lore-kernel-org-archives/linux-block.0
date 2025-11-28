Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011067.outbound.protection.outlook.com [52.101.125.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BFD149C6F
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764302239; cv=fail; b=mIEPc0mT0cUht4j55HlLQE4YmXOBe/yuAbtxYxxW2kCop5e2SKXdPMJp3uelNbvWEqb4x4eitaYSOHLCalF1z1xm5LjoautCbh3it//rLIZZWdZjDb/CWOmdZd5RJ0Yj6t4BHvsto0i39iwrA52fPM5+1WXfRUM/Z5lyCz2uOhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764302239; c=relaxed/simple;
	bh=eDz00M4vhth0/AdvIHwCwyynHfQj6/jSk36VM7TEGrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e+LXh5486vDAFeFg9NcjmK9n30nzzMnLH8hzBPIhtD+i/Qo26sSYRrx9tZxqt5j15S6PmxkKmzBRZ3s8LSy7Fefwn2DTPUKjcVerE/2K2A6jfjAya+jY9vhXA60oA8kHpnP3t61Mtpj+J4SF/d6UyvZy+ZzQlVuoM3OIX71XliQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=F1LIu20X; arc=fail smtp.client-ip=52.101.125.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="F1LIu20X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2ohqyczJekzpmhuUUWhD1FF1kSD0+dr9dJmfh0fmfoxE/sEh4TUx03DRThCim1UNM8DSPFyS/VxVemsan6tN5V8UsEVsvZDGSaRC+27XTVWmXlqPZxD676Eoo1up9frX0XhbRezO0qSBl8fU7lLhbEbKtHn9mXesnKfhaMirXguV5jHtOwNnzQkiUbxSTuT707OH0KmP9BGhMuE5ziVThrWeH5U+drt7U2xHCfX/k1Drc/LYGaSlDrTYB144wK2JjpMJSxjsJVGYGGQ8SOgcgOGTXqDM5CPIyHd1QYKQ1XcFmXzxvXDFnbIQSyU85gCuCf90oytDa4LxU6M+PWV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDz00M4vhth0/AdvIHwCwyynHfQj6/jSk36VM7TEGrE=;
 b=XVBeYR4GpDu4YaE3gNseiMlQUra1a4UfLa9zpGKsev+aO1jgPaAbGfjyAkXWWSEtiYLP4/+m2qIKMjpsM9jSZRX1IAwb1wBYwgon/iuKe0koS7IRXagabC1kKrgDv3vqmgytZukOwRE2V6BbV7UAfNVLd/s4Y1GsOEHGlUKxM0T4Xk2FAbnBbBrZTp+A3bb4clNbXrF9mFCyG04XWYM23ZUPtyKLdz31F1D2WchstXk5kZ9CXaAh7fUkqZnNwMSFB3HZcwhRkYrmlfeSFWxAvUd22X0cA6tNy64ADfaCfL44ttIycp1Xo+V1pR91S6lgtMLBLRvIuWFW0jaPTssl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDz00M4vhth0/AdvIHwCwyynHfQj6/jSk36VM7TEGrE=;
 b=F1LIu20XOiANpEU2kCLwz5c2D1M8RLwoBZVk+XlGwOxnOLxd6rhv9Rf01Ol1lQHcJAYl7nAnFf3f0zej7BK1Zdhl+m3SkGuAaT3hbepFOSGC3hvziSQ7ikmPeows6FHk65jos2Xch2xKM086JVzny4QTqofXMVGy3od2UlNdSL5yH/W2R0eetjxLZw+lYUfUAd9fHuLxHSHEvo8e7lIi0mgJGpBFqnTmQFeonzjmfDaKq0qbY9yRA8wiQhpiXtyTtG8t6zuEA/2xOTeV0GPvEq83grte/0FuQQx7blnT5ECnGgNOPk13MI7sIXw5QJBI3aC2U/sq1hB0CkfsaNmJLQ==
Received: from TYRPR01MB15539.jpnprd01.prod.outlook.com
 (2603:1096:405:284::11) by TY4PR01MB15031.jpnprd01.prod.outlook.com
 (2603:1096:405:237::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 03:57:15 +0000
Received: from TYRPR01MB15539.jpnprd01.prod.outlook.com
 ([fe80::9a8d:fc1b:1b73:4aae]) by TYRPR01MB15539.jpnprd01.prod.outlook.com
 ([fe80::9a8d:fc1b:1b73:4aae%5]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 03:57:15 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "yukuai@fnnas.com" <yukuai@fnnas.com>, Bart Van Assche
	<bvanassche@acm.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests] test/throtl: Adjust scsi_debug sector_size for
 large PAGE_SIZE hosts
Thread-Topic: [PATCH blktests] test/throtl: Adjust scsi_debug sector_size for
 large PAGE_SIZE hosts
Thread-Index: AQHcWoczw6nLMAM56EiPOlYNbhTHN7T9bduAgAP4nYCABMUeAIABVYQA
Date: Fri, 28 Nov 2025 03:57:15 +0000
Message-ID: <28761220-5f38-4e7b-b86b-a175ecac6271@fujitsu.com>
References: <20251121013820.3854576-1-lizhijian@fujitsu.com>
 <cb0d1c57-7cb3-4434-b6a0-592ce370a4e1@acm.org>
 <1c7ea752-11a1-4f2c-8b1d-1b289eabd583@fujitsu.com>
 <3407c6bc-9832-41d5-81c7-7216dd81f5e2@fnnas.com>
In-Reply-To: <3407c6bc-9832-41d5-81c7-7216dd81f5e2@fnnas.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15539:EE_|TY4PR01MB15031:EE_
x-ms-office365-filtering-correlation-id: d5fda898-2fa4-4061-35e3-08de2e3237e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?NVE3SkVCMi9nWWxOT2xRQVhtM3JpZ1dTYVFpcko0STRwK2dtSTR4MUxUQUQ0?=
 =?utf-8?B?OExwYy95dUkyVjVYQnN2SHZpc2dWS3BVNnhGS096WU1xZ1Q3VnBwZy9yb0lt?=
 =?utf-8?B?Q09kY0l2a2dicUpHR0ZuNXoyU2I1UW14NDlHZmVUSjRmYWZ6V1ZTTGlFUExG?=
 =?utf-8?B?MDkxdnlsNEY3cWxrcXU5OThHeEY3cVhJVEN4VkJVbUFrYUxvN1FGUnBlS1B3?=
 =?utf-8?B?bEdhYjJ5MWJpQmxJWXpsNGNKR0JzM2lYRUgyT0gyQmN0bVFLTEhFRTR4UC9o?=
 =?utf-8?B?TGtwdnEzdW91VGtSVkxzcXo1cUM5L2pxZEY5SzV6OVFGdDVINDBybnE4ZnhM?=
 =?utf-8?B?dmg0Q2RNV3NSclg1bjZLRnZITVg5S2UzZ2pGYnBTZk45cktSaDlUdGVBUmxO?=
 =?utf-8?B?WHZaRFVJOGVNaTR4Rlg4cHFYVkhSeU40UEloN0IvMDlzalhIRXlmRTB2d084?=
 =?utf-8?B?SEVaaUYrTUE0ODVxL1pkb0QrZDVsR0F1OG93ZFZsWGt0WHdHVEh3MjZqQ0Qy?=
 =?utf-8?B?aWM1RUF2NVVCOFphZGlIZkJxWEVPKzNjU3pOV0x6UlR0RHFtSDc1dzhQcGN1?=
 =?utf-8?B?eVByYUlaUzFNNVBoQ25zdlhNZStNTlJiMi85TXhnSWs4cnVEVEhEZ1AxUkJX?=
 =?utf-8?B?YjYwMy9tTDdWd3VqZlRadTBZNkVIck1BT3F4Rm84Z1FFOHhBZ0FjMmozakNk?=
 =?utf-8?B?U2NrWHVTZHNsL3FvWk9iSU1WU3Z0OTJETVJwRndONlhQY2Z4MFFsOTB0T1Fi?=
 =?utf-8?B?cFMweVdUQXA1ZkM4MHJ4bDdJWjNab2Z1bmRLS21UZW5iSzBFYzhISVBQV2cy?=
 =?utf-8?B?Wm9nRnp4aVNFb2I4cGJsbktFT0FLQy9ZL3BTMEJyMlRNZXo5cVJpY0tTQnc5?=
 =?utf-8?B?ck9pZzExMVQ3azhyV0xFdElEWEhWOVg0bTg5bUJlbzFJaGdxajRUVVAzaXVL?=
 =?utf-8?B?bngwMVBBampURC9zLytkYnU5aWg3U25NVHk0dlZOeTNNcm1IbmVCWGxBNjFZ?=
 =?utf-8?B?RmgwaU5pK0NiVWZKbnpFMHh0ZDUybXJlYUgrN2x5Q1lIcHFwVFB4V2NSQUhX?=
 =?utf-8?B?OE40ZFVtQ3JtZW50RkVjdEt0aUNITHd4SktUK3E3V3U4bzVXVWlaZXBta0E2?=
 =?utf-8?B?c1lQWlNVam9VVi9hTm50VDlIaXo4TFJJZDZ2bmdBSVpCZVYrNHJ1cnhIK0Y1?=
 =?utf-8?B?YjlRVitwRlEvOWlhZExXMmtsMll2N2t1TG4zRzhEejVyZ0dwL3Bkem51OHkz?=
 =?utf-8?B?MmJhb2t5S29Fbm12M0JvaUVadldiS2xkYlJZZmN0OEpnRlR0c0tQYzBWSXov?=
 =?utf-8?B?dUpHcFhuYS9qMDRJc2d2aEhKNGI1ajZzZ1JRaE1JWjhUdkhrTUNrRU82SVNC?=
 =?utf-8?B?bCtOdVZxQkxJNllSWlRKV21GbW12MTNUTHJQVnE2Q0Q5ZWtOaHZtSDNWYUR6?=
 =?utf-8?B?TFd4c3krclRKUTBmMGVtaTQ1VWVKQTlJMHhUeE1ieHVXYUIxOHBYZFU1Mlhz?=
 =?utf-8?B?VTF6aGZUTFRDTUgrcUFRcmg1UDRnczB4RzBKb3lzd25XV3orNTl0eWprdkxM?=
 =?utf-8?B?Q3F2elp4NUVSNFpOUUJybEswSzRzc0pNUEMvdEFQbzVNM1llaVNCSS84UzBD?=
 =?utf-8?B?eW1sYUNHb3NpRUtCU09xUlhNR1l6RW5RMGY5WHlqNmNyRFVIa0NmMWxTWXFN?=
 =?utf-8?B?eDczVWY1QnRMeG9ZTmlseVdmOVZJeXdINWgwb211VVFlTkZrS2cxYTgybU1j?=
 =?utf-8?B?c094YTdIaWt5eTl4S1JleFlETFlZMjRmWnEzZm9EcGszMEhLWnA3Y0RUQ094?=
 =?utf-8?B?UTlwazVKM1BMbHBmYndyOTdzY2NMYVdDRnVFTTJ1U1E1MHBWRlNPYndXTDNX?=
 =?utf-8?B?a2pVUDdlOGxmTVJiL0hmUEJ0ZE1JM3ZWRE9TQkNIQ1FsSTBKSjJsbnM1Wmk3?=
 =?utf-8?B?c1hlcGVlT3ZiVXZJNTYzdFE1QWZHSjlqZmtUdzRHQk53amFrRm5nK2xLOG51?=
 =?utf-8?B?VjN4YjU2VmQxb2hlemVuN243M045UUJoWFNQRTVXRnZPakd4ZWQrbHlienBI?=
 =?utf-8?B?V0sxVlRPMFNLWmI4aHM2MDdNQjY5VmJuRDFzUmIxYk13R0FrN1YxNkgvVWcr?=
 =?utf-8?Q?g09E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15539.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1BBVjJzQThJeURrT20ydXFWZEI1RG1yV0wvTGZ0S0xGcmNzRlMzbXdFajlr?=
 =?utf-8?B?SUZxd2ZrSE02ejNrV3pEc2pNYWJnREhMMkIrTWk2WFJpblJJS3F0M3A4cjdV?=
 =?utf-8?B?THVsNGdVNmUzeXFhNlBRNklPSzhrR1FlUU03dmlINGN0RzZTMEpBZkZaS0Q2?=
 =?utf-8?B?OW9PS3o4c0ppUTBnaHo4Z2FnekUrUlRYQWlScXJ5bFV6Z1kwNjFDNWZYRyts?=
 =?utf-8?B?d2RUSzdDVnYxQ1VCWk0zTjEwVmFtMTZnZWd4QVhXRTQ4SlpZS3ZEUjJ2K0p6?=
 =?utf-8?B?N1VCL3RHaDRuWnNqQ3FHalRTd2x4SjN1SXNQaGNVZ254SlBRNTFhQm93QWVR?=
 =?utf-8?B?eWc0RFJGVG1pa0p5VHRleFJUNlFFclVsRW5jOXZoU25wOWtKbnRPZDE5YW1T?=
 =?utf-8?B?Wk5LRktWM05LYkdmNlU3NGRTKzVVY1VWTE5YZWdJRVFLQU4wT3E5MWR4dmJF?=
 =?utf-8?B?ajN0SEgxRzFhSmhkaHpTblYvN2xRa0VzWWpLVkRiekpIKytVQ0ZPMktTSDRy?=
 =?utf-8?B?N1FTSVBCS1ArVzZCKzg1bHFleWIzWUFJNXdIWlgrMHhhbytXS3FvYzlpd2pZ?=
 =?utf-8?B?cm5aZU1PeUJISGpnMG9lZjNyc2ExalMrczJJUlY2bkhITlIxMUVNVGhjV1Ju?=
 =?utf-8?B?dkNrd0ZhbkR1MThwTlZ3OW9LZG9ZRDJpZGRoejUzYzdoRmhmbDlhdVpKM3BW?=
 =?utf-8?B?cXRkaXpZSmxiWFdJMVNrMHkvRGVzc2hoNkZtQUtpTFhtWnM3anFQZ0U2aDBj?=
 =?utf-8?B?Y1UvdGZZWXpMT3N2cjNaRWdkaXRKVXZEcEF2VWdMazF2bWdWb21aRWxmdHpI?=
 =?utf-8?B?am0zVllyYUV0Q3g3TmVESlBSYmpWVEErMXVjNThlUmc2STRDYVlMSUFySno4?=
 =?utf-8?B?V0d3Q0x3OFl3V0cyN3RBOWpLMTRsTGtWU3Y4dkdGa3hWMlVaUjc0VitUeXN2?=
 =?utf-8?B?cER4VS9TTXROclFBM0RnWHNNczc1cXFTa0dHTkVnTFpwdjJSTFFUNzh2czFY?=
 =?utf-8?B?TVlSWWdIN2tJWVNiS0NKQmVrT1IrSnNUemJoTTVqeUVnQzZIandqc3BibjN5?=
 =?utf-8?B?L252V1hNNTRXT0F6NHkxRlU2ejBENjlvZ1ZqcG5WVnhYL3g5Q1dvT0J2SXBO?=
 =?utf-8?B?RC9LeXVIYkcraGtRZXVxYjBLQUdBNVZrbjZrS3ZmdkdJcWpkTHNrYkZ3M1RJ?=
 =?utf-8?B?RUFjR3dVL3JJajhtVjRqb1B3VHVLY1V0UjhiK29sSTdVUW54cGhvQ2FIZ1pL?=
 =?utf-8?B?ZkFvWC94SHpFWFo5YVdqSXRnV2hPN1lwNEwwa0xCNGtLUjdmZHFaZUhieWdr?=
 =?utf-8?B?YzJmMiticC9TNkkvYnFIdzU3SXgxakJJajdOa2N5U1ppQkV2azdpM1hpT1NN?=
 =?utf-8?B?Qjl1NkVadW4rUUIrNUJ1RWVwZk16ZlF0SUNBaVNOTjlsVHRSOGhMVUxKRkZ3?=
 =?utf-8?B?a1VRM0dwak9QaGswb1JzRE42WTdKNEtPbHRvcWJIUXlLK1phUzRIWDgwVFZF?=
 =?utf-8?B?b09aSEQ1WDVVcFpJQmdGV2krbS94anZXZFh6N2d6YVQwclYvc3ZPK05DOC9U?=
 =?utf-8?B?ak1pMzBKYm96Wk1lYWNCeXBQQURsRk1wVnhKem1KVHEvRCt0aW42dzVDVzBY?=
 =?utf-8?B?ZXRMMGJpcEVEQ1hVVmh4dDRRR0l2REFhOEVuVGluYnRWL2JPS1dac0VYMjRC?=
 =?utf-8?B?bUtwV2hsaWxieUx2bTAvdTY2bUs1YzNyaWdHMnl0MEtBR2tma3RoT3FYT09T?=
 =?utf-8?B?ak40cDB3QzJsUzgyTmk3dVgrRlg3RVE5Z1hTY3pISjZ0NnlYcFRxcUpUNXJG?=
 =?utf-8?B?SVNRcUY1YlF3eE9VQ2VnWWNJNElKNExRaXZmWXpnVFBPUVE0ei9UZTR4aGQw?=
 =?utf-8?B?NWFjbmNHMkdhOWNLY3Z5SVhKcmlUMys1VkNwdWhMUitGNm5aMVhERkJSTEZ3?=
 =?utf-8?B?UFgyWHBBZzh3V2kvQ3R5aEYyM25oZzFhbzBpR3l5dzJEd3VISm5vN1l1N2Ey?=
 =?utf-8?B?ZVJQR3FlMDk5Vm5DcVlCRmJ3KzhLNlluTjFZMXAyZmFnZ2FpeGJ0QTdaNTdV?=
 =?utf-8?B?SklUWDFGODhEVDdPVkt3aWw3V3VKVHFEU3MwWGtwZG5mdVU3bDQrdXBLaUFy?=
 =?utf-8?B?cWVER05RbE5ucEI3emNyZ0RmSUtCN0pZQnpVVWdFQS80dDR3NzM2UGp4VFRv?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF1E00393D38934EABE59BDB9A81D7AA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15539.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fda898-2fa4-4061-35e3-08de2e3237e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 03:57:15.3852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7WEQVCU2hsnmutP5ywXapOBxajYxLnwoEsq0F4+2XLYZecTW6tMpMSgdqLv2A7O8sw5qxcHzWymwhDmWITA6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15031

DQoNCk9uIDI3LzExLzIwMjUgMTU6MzQsIFl1IEt1YWkgd3JvdGU6DQo+IEhpLA0KPiANCj4g5Zyo
IDIwMjUvMTEvMjQgMTQ6NDQsIFpoaWppYW4gTGkgKEZ1aml0c3UpIOWGmemBkzoNCj4+DQo+PiBP
biAyMi8xMS8yMDI1IDAyOjA1LCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+Pj4gT24gMTEvMjAv
MjUgNTozOCBQTSwgTGkgWmhpamlhbiB3cm90ZToNCj4+Pj4gICDCoCAjIFByZXBhcmUgbnVsbF9i
bGsgb3Igc2NzaV9kZWJ1ZyBkZXZpY2UgdG8gdGVzdCwgYmFzZWQgb24gdGhyb3RsX2Jsa2Rldl90
eXBlLg0KPj4+PiAgIMKgIF9jb25maWd1cmVfdGhyb3RsX2Jsa2RldigpIHsNCj4+Pj4gICDCoMKg
wqDCoMKgIGxvY2FsIHNlY3Rvcl9zaXplPTAgbWVtb3J5X2JhY2tlZD0wDQo+Pj4+IEBAIC03Niw3
ICs4Nyw4IEBAIF9jb25maWd1cmVfdGhyb3RsX2Jsa2RldigpIHsNCj4+Pj4gICDCoMKgwqDCoMKg
wqDCoMKgwqAgOzsNCj4+Pj4gICDCoMKgwqDCoMKgIHNkZWJ1ZykNCj4+Pj4gICDCoMKgwqDCoMKg
wqDCoMKgwqAgYXJncz0oZGV2X3NpemVfbWI9MTAyNCkNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgICgo
c2VjdG9yX3NpemUpKSAmJiBhcmdzKz0oc2VjdG9yX3NpemU9IiR7c2VjdG9yX3NpemV9IikNCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgICgoc2VjdG9yX3NpemUpKSAmJg0KPj4+PiArwqDCoMKgwqDCoMKg
wqAgYXJncys9KHNlY3Rvcl9zaXplPSIkKGZpeHVwX3NkZWJ1Z19zZWN0b3Jfc2l6ZSAkc2VjdG9y
X3NpemUpIikNCj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgX2NvbmZpZ3VyZV9zY3NpX2Rl
YnVnICIke2FyZ3NbQF19IjsgdGhlbg0KPj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFRIUk9UTF9ERVY9JHtTQ1NJX0RFQlVHX0RFVklDRVNbMF19DQo+Pj4+ICAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuDQo+Pj4gV2h5IGRvIHRoZSB0aHJvdHRsaW5nIHRlc3RzIHF1
ZXJ5IHRoZSBwYWdlIHNpemUgYW5kIHdoeSBkbyB0aGVzZSB0ZXN0cw0KPj4+IHVzZSB0aGUgcGFn
ZSBzaXplIGFzIGxvZ2ljYWwgYmxvY2sgc2l6ZT8NCj4gDQo+IEJlY2F1c2UgZm9yIG51bGwtYmxr
LCB3ZSB3YW50IGEgZml4ZWQgSU8gc2l6ZSB0byBkaXNrLCBhbmQgcGFnZV9zaXplIGlzDQo+IGNo
b3NlbiBmb3IgdGhpcyBjYXNlLCBhIGxhcmdlIElPIHdpbGwgYmUgc3BsaXQgdG8gYSBmaXhlZCBz
aXplIGFuZA0KPiB0aGVuIGNoZWNrIGJsay10aHJvdGwgd2lsbCB3b3JrIGFzIGV4cGVjdGVkLg0K
PiANCj4+IEdvb2QgcXVlc3Rpb24uIEFGQUlDVCwgdGhyb3R0bGluZyB0ZXN0cyB3aWxsIHRlc3Qg
bnVsbF9ibGsgYW5kIHNjc2lfZGVidWcgYmxvY2sgdHlwZSwgdGhlIGZvcm1lciB3aWxsDQo+PiBj
YWxjdWxhdGUgdGhlIG1heF9zZWN0b3JzIGJhc2VkIG9uIHRoZSBwYWdlX3NpemUuDQo+Pg0KPj4N
Cj4+PiBXaWxsIHRoZSBhYm92ZSBjaGFuZ2UgYnJlYWsgdGhlDQo+Pj4gdGhyb3R0bGluZyB0ZXN0
cz8NCj4+IFRoZSB0ZXN0cyBzdGlsbCBwYXNzIHdpdGggdGhpcyBjaGFuZ2Ugb24gNEsgYW5kIDY0
SyBPUy4NCj4+DQo+Pg0KPj4+IEFuZCBpZiBpdCBkb2Vzbid0IGJyZWFrIHRoZSB0aHJvdHRsaW5n
IHRlc3RzLCB3aHkgbm90DQo+Pj4gdG8gcmVtb3ZlIHRoZSBjb2RlIGZyb20gdGhlc2UgdGVzdHMg
dGhhdCBxdWVyaWVzIHRoZSBwYWdlIHNpemUgYW5kIHRvIGhhcmRjb2RlIHRoZSBsb2dpY2FsIGJs
b2NrIHNpemU/DQo+Pg0KPj4gVGhhdCdzIGEgZ29vZCBwb2ludC4gSSdtIG5vdCBzdXJlIGFib3V0
IHRoZSBvcmlnaW5hbCBkZXNpZ24gcmF0aW9uYWxlIGZvcg0KPj4gdGhlIHNjc2lfZGVidWcgcGFy
dC4gSSdtIENjJ2luZyBTaGluJ2ljaGlybywgd2hvIGF1dGhvcmVkIHRoZSBzY3NpX2RlYnVnDQo+
PiB0YXJnZXQgZm9yIHRoZSB0ZXN0LCB0byBzZWUgaWYgaGUgaGFzIGFueSBpbnB1dCBvbiB0aGlz
Lg0KPiANCj4gSSBhZ3JlZSB0aGlzIGNhbiBiZSByZW1vdmVkIGZvciBzY3NpX2RlYnVnLCBJIHRo
aW5rIHdoYXQgd2Ugd2FudCBhIGZpeGVkIG1heF9zZWN0b3JzX2tiDQo+IGZvciBkZXZpY2Ugc2V0
dXAsIG5vdCB0aGUgbGJzLg0KDQoNClRoYW5rcyBmb3IgeW91ciBpbnB1dA0KICANCkkgd2lsbCB1
cGRhdGUgdGhlIFYyIHBhdGNoIHRvIHJlbW92ZSB0aGUgZXhwbGljaXQgYHNlY3Rvcl9zaXplYCBw
YXJhbWV0ZXIgd2hlbg0KbG9hZGluZyB0aGUgYHNjc2lfZGVidWdgIG1vZHVsZSwgbGV0dGluZyBp
dCB1c2UgdGhlIGRlZmF1bHQuDQoNClRoYW5rcw0KWmhpamlhbg==
