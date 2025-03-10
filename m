Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4509E22A1E5;
	Mon, 10 Mar 2025 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612909; cv=fail; b=d15S//r9Lw+E1/s6PGZF4XgCKrGXNWnoJAkWWVjlw2/JsRqk4EYb1+4Cn/kwEE2FjfwAikqrPSRt9TkVsc5jWqwd3vjhFxbFpGO3WiugI9xLjmocUPAacoKaA5vMevjRIY3+Z7eO1zUgFyzNX/pDJ6PkFxlVWfLDBk26nBCHxPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612909; c=relaxed/simple;
	bh=DmDfrit2pssxFGKcOZDQyL5czHuNWvfvIAapyfljShE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TOGQEKlrRV4ePBMOk38ghSrKt3P3JLtdgsPT96oQUIhlFNxYg7GK9R/8lBAmgt+4les3TPL6tZ7B6yc7Wclb4LdveY7dm/nKrUeUb13BYly8KkwL9gu5TZQS1Iz3S9prWMlc3s2mlME0rbzgqYsXlTNulP6VsJeY2XsSALzcxqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=suxmwU7c; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=IZXpuAGh; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="suxmwU7c";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="IZXpuAGh"
X-UUID: 9a8febfcfdb211efaae1fd9735fae912-20250310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DmDfrit2pssxFGKcOZDQyL5czHuNWvfvIAapyfljShE=;
	b=suxmwU7ck6m3bJSj8dlHI7jxi/nKzfAXql0yCxELwCx9qBa96mVGyCb/aZgVPyqHKCihorn/XpuTFZ8fpaQbzL9pyjD1IH0zIaV3ElWgpGifW29CADWurmSgmv0HYrkIBykZy18TVuUM2C6/R9ZT/oimQFLUR1OBJ/r+CG0N2Rc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:18a64a42-7302-48ab-b48f-192c9154466c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:0e89eb49-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9a8febfcfdb211efaae1fd9735fae912-20250310
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <qun-wei.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1837918235; Mon, 10 Mar 2025 21:21:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 10 Mar 2025 21:21:39 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 10 Mar 2025 21:21:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoQ3ZldEZzPLGdak4ZT7yBEqhtW+qwOkbeu+UlfZYrquy5dapOgW1EbaVFxYxFJ9JskhKDLsefnGFCDUHFGYqMaqXqdUzLJSAsb7wDaLRP5J/LKmsqtBOBu4rffbtwabeQhuO0SvrVSBBq3jaoWXQ3KWCXWUBYUlZxlRxE0BjyI1du04UYGir0LfLUCPT8JWM5/F+PbTMwlJgn3/ckq1unVrHCv/oyWwSBpSVGRG4E3Cl16XFdBa/x/gwZ1ikzZX/E/zAsfP2JSZNfeRZvtOxP4ceUtMawBrtBJ/6h3VMYYjErCzQ2y9zPPrSKI08Yiw8B2P8tnrRToPY61QFSDGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmDfrit2pssxFGKcOZDQyL5czHuNWvfvIAapyfljShE=;
 b=G59tHx7eV9l7N8G5hxgX/juIrbwCSNSx0wtqhTiG46CLDRX0uvEzXgkAR5a9BxrFol5G4njzcbvnOCL4KppWCIfsoriy+WvsHURq6JOomuGyS38PRAMNMyolW68+hlq66JZPRu1n+3QxyRdb8HVa+InuaXexI3NOMP3cRsvVM73H1eD12nMf5e67Y6BTZpIn22t1M8ErTVH6UQ15iZcVkCFHkW1+ramdYJ4tQ9iFw2EdrbvetaorGTq5co5d0IpPOtljqCNmQ0v3zXVWAXcMj9Hb7ahXC6n8fIKivC4OiTo9lrW2LlexMB5uvKjb3iFRW6BBZ9EHnXlyJRbeSCBybQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmDfrit2pssxFGKcOZDQyL5czHuNWvfvIAapyfljShE=;
 b=IZXpuAGhqIupaKstzGWccV/12Dd9RQrRxP8j0dOJnoA/J3TvQwWnDsTekwo5mC2PfGAfMT2UcttREa/nNsW3s6zlA6Ch3TdMpEBxcsBKsw6GlScEMqYukD2+ml7pzbKkzF8JEsNVIWxMVkJP5O4Ho/Nmq41bbio1WTgrTqw5Y+k=
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com (2603:1096:301:4e::12)
 by PUZPR03MB7042.apcprd03.prod.outlook.com (2603:1096:301:11d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 13:21:36 +0000
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02]) by PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 13:21:35 +0000
From: =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>
To: "21cnbao@gmail.com" <21cnbao@gmail.com>
CC: =?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
	=?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
	"chrisl@kernel.org" <chrisl@kernel.org>,
	=?utf-8?B?SmFtZXMgSHN1ICjlvpDmhbbolrAp?= <James.Hsu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"schatzberg.dan@gmail.com" <schatzberg.dan@gmail.com>,
	=?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?=
	<chinwen.chang@mediatek.com>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"minchan@kernel.org" <minchan@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "kasong@tencent.com" <kasong@tencent.com>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "ying.huang@intel.com"
	<ying.huang@intel.com>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
Subject: Re: [PATCH 0/2] Improve Zram by separating compression context from
 kswapd
Thread-Topic: [PATCH 0/2] Improve Zram by separating compression context from
 kswapd
Thread-Index: AQHbj1ja3HBtEsnk0kq5WQ+MAj7gkbNoESKAgARO3YA=
Date: Mon, 10 Mar 2025 13:21:35 +0000
Message-ID: <b9fc1efa457aa29104737e5f6a4868602a3078e5.camel@mediatek.com>
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
	 <CAGsJ_4z4yKRQiqMtGRr2bjvgVY6mmujdqyKyVgid=RUXr_9TbQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4z4yKRQiqMtGRr2bjvgVY6mmujdqyKyVgid=RUXr_9TbQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5542:EE_|PUZPR03MB7042:EE_
x-ms-office365-filtering-correlation-id: f23bf892-a67f-465e-14ac-08dd5fd67ba7
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VCsvUmRvT05maVM5SmU1ais1MWVvN0tsb2RIYk9tNnUzcXpnbHUzN2wxbkdq?=
 =?utf-8?B?U0pCWlRYTlpqdmpoNUlBbWFabDdVcHcrMG1Mb1hVK2h4dzBRQ290N2YxZmpC?=
 =?utf-8?B?blAzU1J5MWZRTmVReUxIdng2UW42MmlNSFMyNmxFcUFjSUFjVndQUUNya1ow?=
 =?utf-8?B?ZHhGakFJMFIza3lENXJrZW1oT2hHcEowaWdGd0dwRDZLMlNuY0hvMjYyTlJ3?=
 =?utf-8?B?UjljbGFYVUNvWUxQb2M5UzMyRFM5clgwemQrTlBsaXlRakVHakoxWGt5SzUr?=
 =?utf-8?B?Z3BzM0pNcjRtYjZnQkdrbHg4eTRGU1JzVWRIZ0ZIWkNXNElTM3REQ09pdThG?=
 =?utf-8?B?M0RYdDYyb0Y0TzVTRFRhb0ZRK0REU2dnQ1FaVzI5Q3lzU2phODEvK1BieER6?=
 =?utf-8?B?ZWt5b1R3SDhoaWpNSkdDRmFiTjVnZnpDWFQybEJ3MXI3bVZmWHpkN2dLbE1P?=
 =?utf-8?B?TWZkNUdLK2VxaVN6MmpzM0FkNXR6VVBrSTBuMXJKYzJiL3Vld2lQb1B0ai9w?=
 =?utf-8?B?S3Yrc2JvelVWelBhd3dMLzZHVThGNTdxMFMzUUxxTVdNZ2U2VXAxOHJoWndG?=
 =?utf-8?B?bGcwYUtZM1hBajNrUXdRbnpMTEFkM1NWV1RQYTVqZmR5T1lFQUc4T25PNFFD?=
 =?utf-8?B?azR5MG1SVk1XNWo1Q1ZuSzMxUlI2OG9vMFZVdXBZaXoxVkh1QXRXMGtYUWFu?=
 =?utf-8?B?amp5TnRwSnJsR01YT3d2aUlBVGs4bHFWVTFoSXRtMkRJaGlZOXIwTU1KQkZx?=
 =?utf-8?B?UDZhMDZDaUszNnpYSk1SRENrMWp0WVphOTRZK0gyY3RTbEliMU9rUTllM29X?=
 =?utf-8?B?SDMrelhYb3lkOWRPeDlpTHpqYzlPaHVPZGJEVzQ4YXorSDQvQ08vN3ZPdUZN?=
 =?utf-8?B?VVFRaTNEUW9yY3NpRjhIVkM1azN4d3htTnU3cWRGVzZGaTg3NW5aMFhabmNM?=
 =?utf-8?B?cHVPSytVVmhCRjkyY2R0dThGaFI2TTZ0VTRNVGRGcjg2SExEVVpHdC9wenNM?=
 =?utf-8?B?VmJXVHZBMG56eXVUenhwMzc4SjBIUC8vWVNxVUJ1MEhTanhJWE5hZWlpWEpC?=
 =?utf-8?B?NEQrOEEzb01XVEhhTUNjcm5uYm5pSFBNUVV1RkVGbUt5Y0xxc2U3S1VQTkkz?=
 =?utf-8?B?QzNBTVZEYzNmaEtFZk9TRGVDR05vWGwrWG1HelBwcjhONXJyb1p5REl6RDlR?=
 =?utf-8?B?bTlFMjE0THFSM0xzcGdvcVZIQmRZVUZoZndHTHg0MVhKNXg5cUhlZGZzSFZK?=
 =?utf-8?B?azlmcERBQ2RoeTRxVlh1L1ZUUVArS3NFdHE5c1dadjFZMGlFemhEZ2ZRWHVT?=
 =?utf-8?B?czJweTdBTzlOdFBQVEZDQlhpQWJtY2RERXRzT1Z1MUh5MmZWK2ZNb3VzemRu?=
 =?utf-8?B?eFo0czIxRHhSNzlTUFhKZFdhT2NnMTRaRERPMis4TGxac0pXdDZSSnVZZWp2?=
 =?utf-8?B?SGh0OTV6elliWVJLYUpRdytUNXl1Zk1CWnM3QWNLUjBKdUhHYjltMjZTRlZB?=
 =?utf-8?B?VFBRTS9yMlEvdFY4NG9XdWRoSXI1bWUyNVBGd2N6cXVKWUJjdzQvQVkvUGR5?=
 =?utf-8?B?YlI2UUkyNmtrcVQ2eEpUeXlqS1kybWlKMHE5dFRjZGlNd3d3NUhhU3VqRVFx?=
 =?utf-8?B?NzRKVFpGeWl4dEIrdzFTKytYVjQyQm81N1pZdzZ2VVNUMy9jeGNRWW4xTFNH?=
 =?utf-8?B?Tlc0a0lFMUozZURTS2Y5cHNEWlRTY1JHcUc3VzdtS2J1UWNRNU9DSVRNdGFQ?=
 =?utf-8?B?VjZ6N0JKSEtLeE03cE54eDQ2UENnVDNhaCsvNVM2enlHK1RyOVEwTDZROHM0?=
 =?utf-8?B?VWRNWFdIVUV0TThvUG56ZW9vUmtFRHRtRnVxRnZML0xONW4zZXUwSHZuaHdT?=
 =?utf-8?B?amc4dkRKUG54eXNCbVNJRG5WS1JyeXdTREtYUzJyY3ljUkhxaGJiOUo0K2p2?=
 =?utf-8?Q?9kH5izacYdPz7QanArwoE3sVvrRyo0+k?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5542.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzg3a1ZtSFR2SzQzOG5VSHRuNnZkejk1Y2c4djNzQlZpQzFPejFTTEVSTTlp?=
 =?utf-8?B?aUpPcHZhcjVFbEZoSjBid3A2KzR1M1pvWnU4YXRMV0tlVkZYWjZEd2pwWWhp?=
 =?utf-8?B?RTVCQndXeHltNEtWeWNQby9IT1hRbDk2RS9DUVV2M2lESkRTOGtBMW52dHdz?=
 =?utf-8?B?cytXaEdHaFFidTQvUm9iZWpUK2VmY1ZPMEJBdmJ0RE5WY3VoNjU5T2xwd2ow?=
 =?utf-8?B?QVdiODNmT1JpYW4yQnl4QkR2WXY0dU9uc3VRZUR0dmVqcXYvNThDVHlTeGox?=
 =?utf-8?B?VGRCYzZYWFJjZlVVRFNmaFVZaXpnZ2hPeEErdUY2VDRXT004NEFzb25XOEF1?=
 =?utf-8?B?QTlMbTU3NHN3TmVwYm5sRHJjUDhXcUdsVnBIa1RJMXlpRWJ5TC80RE5NaGFp?=
 =?utf-8?B?aTBsQjJ0WDNPTVBNVU4xOXZGUzBaTTZVMytucnZhM3dIaTFhRWlCYUNHOGQr?=
 =?utf-8?B?dTA5NTZNVTRZWEtSeG96VkVxSU5hQWZ2K1RkalBGZWFWMTE2OTZ0eHlGWlZ6?=
 =?utf-8?B?OVVtRU42dC9GWkFzTzIwc2FLa1dvSFgvVG1NZWhsZ0dPckNYZDh6dXVja3JG?=
 =?utf-8?B?dXBOeG5kekFOWk01MkVwQllHUFZvZkhxYW90VjM4cmtxV2s0Y290dFk5ZmtS?=
 =?utf-8?B?SEdwbmVRcjdsbWY2SXhlTTdJUktPM1hnQUV1MTBEc3puKzBJVk0yQzdRV2Zq?=
 =?utf-8?B?b1dhUFo5OHJQemQ1TnNiMkpnd2dFY1VoQ2ZpNzZpS2tYQmM2NnoyTjRuRVdl?=
 =?utf-8?B?R1Rybk5GLzlqZ3h5VWt2R2w3dHdYQW1SOC9hbHNrdzhNN2g3QUEzditPU0kw?=
 =?utf-8?B?NkREN3ZPdTE4NHNLOVplSklCUkQ4bGl1MUk4ajhOdXNhRXEzeDZxaFI0dkhG?=
 =?utf-8?B?T3VyeWh4WWpGeUlhMlB4d2hmMXJKa1U2djVBWmVVWkZPbjdJcHRDZHczaUJQ?=
 =?utf-8?B?MjEzYmx5bE13QkxLK0ducGdwaHVuWDFSM0g0dWsyVFdiWlVjTDhqVTZtSmJm?=
 =?utf-8?B?RlM5Y2twTzhYb0Y3RU1YT3RQTURYUGR2RzZORzdpNUpoRmxhdkgwWm1WRlFK?=
 =?utf-8?B?aGVoSGtiVWR2Nmh4THFUQ0ZrQTdEREd3cElzU2EvNGoyN1JqUEYxbi96a2NN?=
 =?utf-8?B?UFBRVFg5MCtSZEtSRHMxVjMxdlhVdVdDSUVzaFBjSWx6SzBvaWVhR2txZjBM?=
 =?utf-8?B?MWZxY1JkS2FnUHJFeXFkWXYwMFR5azZESUp6enR4Z2FZSEozU2JJYkFwblla?=
 =?utf-8?B?NHppNjdnSzNVTlIvT0hhVW9UWmRlb2Y4bzU1MjIrdzAvTUpRLys0NzRVWFdv?=
 =?utf-8?B?b1ZrQitjSlFhSGptOW10aHhzdUkva2llakZncXJ6OXhKVGtaNGtVSUtGcU0y?=
 =?utf-8?B?YWpQTXRPSldxVjIxbWptMFdpTGVoRlY1R2h6WkZHNVRRWC9IYkdDZXllZ2Mw?=
 =?utf-8?B?dFR1V3ZhamJSK0plTDZVdjNaQWRuTDZxbG52cmN6WUhBUGhSck1INW5pK1Y2?=
 =?utf-8?B?dkljMzVGeWE4L0hZREhodnFIdmZQMkd1VlZYeXVLODNoUUZCSGtEQ1F1RFZV?=
 =?utf-8?B?YXAvdHZ6dXFiR0Y5YXhRa01yc2FvOFlSZElVVWU0cVNzUGM5cUpvZTI1V0Rl?=
 =?utf-8?B?cUFjTHJRQVJmY0pSR0JzSmdnbE0yekxUWTJ1WWo0UTJ1ejJ3N1NTeEc3aUFS?=
 =?utf-8?B?WUVacEFONE8xZWRHNWVreDFzYTRhaW5oUkMxa2F1ZXZlYmJ1OFpGdzA2Z1My?=
 =?utf-8?B?UUpjaCttM3JXdnRNQWxrYkR1MzhTdTZla3JpZUFUY2g4eC9XMytFL3VTdnNC?=
 =?utf-8?B?dFlXdm5YZTg0WXJSOHpqOVEySGVrcEhLU0RPeEg0QlI4NnB3REJqbmNSOGFr?=
 =?utf-8?B?SkZQS2dMWkVIWWNrNVdZY0JTZFdYdHVoOUhKdGNXRHhlZS9LNUJ2b2VjWE5W?=
 =?utf-8?B?Z2NGQTlpWWdRdEhYN0ptWm85NTBWeVdZZ0NOSXFnZFVnMm16NmxmdFUyTlhF?=
 =?utf-8?B?c2svR3B1dytoK0dhM3lFaWFhaHZNUUdQUmNwM0ZEdVBJdjJUc3kzazdkakJs?=
 =?utf-8?B?TVJieHR3a1FxWlFPVkd3R1lSc2VGRVR3aHh5ZVNrVVpodDIxSElpaUtHRmM1?=
 =?utf-8?B?R1REeVhqWTRJVno5L0VIZUlsWFowRzhEQTZrZ2ZBREdNajlYVzliOWdva2ln?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E6FA88F1329744E95C810096EE8084B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5542.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23bf892-a67f-465e-14ac-08dd5fd67ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 13:21:35.8328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKsfZaaJMyMYHSQHHsbkpGtCVvER15o/G59RiSiRmhXjTK2pLzGZlaeeMvbMIMOHZkN8mdioeg9XbRZmwGjRnCld3p0CGIducmJL3IXirwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7042

T24gU2F0LCAyMDI1LTAzLTA4IGF0IDA4OjM0ICsxMzAwLCBCYXJyeSBTb25nIHdyb3RlOg0KPiAN
Cj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29u
dGVudC4NCj4gDQo+IA0KPiBPbiBTYXQsIE1hciA4LCAyMDI1IGF0IDE6MDLigK9BTSBRdW4tV2Vp
IExpbiA8cXVuLXdlaS5saW5AbWVkaWF0ZWsuY29tPg0KPiB3cm90ZToNCj4gPiANCj4gPiBUaGlz
IHBhdGNoIHNlcmllcyBpbnRyb2R1Y2VzIGEgbmV3IG1lY2hhbmlzbSBjYWxsZWQga2NvbXByZXNz
ZCB0bw0KPiA+IGltcHJvdmUgdGhlIGVmZmljaWVuY3kgb2YgbWVtb3J5IHJlY2xhaW1pbmcgaW4g
dGhlIG9wZXJhdGluZw0KPiA+IHN5c3RlbS4gVGhlDQo+ID4gbWFpbiBnb2FsIGlzIHRvIHNlcGFy
YXRlIHRoZSB0YXNrcyBvZiBwYWdlIHNjYW5uaW5nIGFuZCBwYWdlDQo+ID4gY29tcHJlc3Npb24N
Cj4gPiBpbnRvIGRpc3RpbmN0IHByb2Nlc3NlcyBvciB0aHJlYWRzLCB0aGVyZWJ5IHJlZHVjaW5n
IHRoZSBsb2FkIG9uDQo+ID4gdGhlDQo+ID4ga3N3YXBkIHRocmVhZCBhbmQgZW5oYW5jaW5nIG92
ZXJhbGwgc3lzdGVtIHBlcmZvcm1hbmNlIHVuZGVyIGhpZ2gNCj4gPiBtZW1vcnkNCj4gPiBwcmVz
c3VyZSBjb25kaXRpb25zLg0KPiA+IA0KPiA+IFByb2JsZW06DQo+ID4gwqBJbiB0aGUgY3VycmVu
dCBzeXN0ZW0sIHRoZSBrc3dhcGQgdGhyZWFkIGlzIHJlc3BvbnNpYmxlIGZvciBib3RoDQo+ID4g
wqBzY2FubmluZyB0aGUgTFJVIHBhZ2VzIGFuZCBjb21wcmVzc2luZyBwYWdlcyBpbnRvIHRoZSBa
UkFNLiBUaGlzDQo+ID4gwqBjb21iaW5lZCByZXNwb25zaWJpbGl0eSBjYW4gbGVhZCB0byBzaWdu
aWZpY2FudCBwZXJmb3JtYW5jZQ0KPiA+IGJvdHRsZW5lY2tzLA0KPiA+IMKgZXNwZWNpYWxseSB1
bmRlciBoaWdoIG1lbW9yeSBwcmVzc3VyZS4gVGhlIGtzd2FwZCB0aHJlYWQgYmVjb21lcyBhDQo+
ID4gwqBzaW5nbGUgcG9pbnQgb2YgY29udGVudGlvbiwgY2F1c2luZyBkZWxheXMgaW4gbWVtb3J5
IHJlY2xhaW1pbmcNCj4gPiBhbmQNCj4gPiDCoG92ZXJhbGwgc3lzdGVtIHBlcmZvcm1hbmNlIGRl
Z3JhZGF0aW9uLg0KPiA+IA0KPiA+IFRhcmdldDoNCj4gPiDCoFRoZSB0YXJnZXQgb2YgdGhpcyBp
bnZlbnRpb24gaXMgdG8gaW1wcm92ZSB0aGUgZWZmaWNpZW5jeSBvZg0KPiA+IG1lbW9yeQ0KPiA+
IMKgcmVjbGFpbWluZy4gQnkgc2VwYXJhdGluZyB0aGUgdGFza3Mgb2YgcGFnZSBzY2FubmluZyBh
bmQgcGFnZQ0KPiA+IMKgY29tcHJlc3Npb24gaW50byBkaXN0aW5jdCBwcm9jZXNzZXMgb3IgdGhy
ZWFkcywgdGhlIHN5c3RlbSBjYW4NCj4gPiBoYW5kbGUNCj4gPiDCoG1lbW9yeSBwcmVzc3VyZSBt
b3JlIGVmZmVjdGl2ZWx5Lg0KPiANCj4gU291bmRzIGdyZWF0LiBIb3dldmVyLCB3ZSBhbHNvIGhh
dmUgYSB0aW1lIHdpbmRvdyB3aGVyZSBmb2xpb3MgdW5kZXINCj4gd3JpdGViYWNrIGFyZSBrZXB0
LCB3aGVyZWFzIHByZXZpb3VzbHksIHdyaXRlYmFjayB3YXMgZG9uZQ0KPiBzeW5jaHJvbm91c2x5
DQo+IHdpdGhvdXQgeW91ciBwYXRjaC4gVGhpcyBtYXkgdGVtcG9yYXJpbHkgaW5jcmVhc2UgbWVt
b3J5IHVzYWdlIHVudGlsDQo+IHRoZQ0KPiBrZXB0IGZvbGlvcyBhcmUgcmUtc2Nhbm5lZC4NCj4g
DQo+IFNvLCB5b3XigJl2ZSBvYnNlcnZlZCB0aGF0IGZvbGlvX3JvdGF0ZV9yZWNsYWltYWJsZSgp
IHJ1bnMgc2hvcnRseQ0KPiB3aGlsZSB0aGUNCj4gYXN5bmMgdGhyZWFkIGNvbXBsZXRlcyBjb21w
cmVzc2lvbj8gVGhlbiB0aGUga2VwdCBmb2xpb3MgYXJlIHNob3J0bHkNCj4gcmUtc2Nhbm5lZD8N
Cj4gDQoNClllcywgdGhlc2UgZm9saW9zIG1heSBuZWVkIHRvIGJlIHJlLXNjYW5uZWQsIHNvDQpm
b2xpb19yb3RhdGVfcmVjbGFpbWFibGUoKSB3aWxsIGJlIHJ1bi4gVGhpcyBjYW4gYmUgb2JzZXJ2
ZWQgZnJvbSB0aGUNCmluY3JlYXNlIGluIHBncm90YXRlZCBpbiAvcHJvYy92bXN0YXQuDQoNCj4g
PiANCj4gPiBQYXRjaCAxOg0KPiA+IC0gSW50cm9kdWNlcyAyIG5ldyBmZWF0dXJlIGZsYWdzLCBC
TEtfRkVBVF9SRUFEX1NZTkNIUk9OT1VTIGFuZA0KPiA+IMKgIFNXUF9SRUFEX1NZTkNIUk9OT1VT
X0lPLg0KPiA+IA0KPiA+IFBhdGNoIDI6DQo+ID4gLSBJbXBsZW1lbnRlZCB0aGUgY29yZSBmdW5j
dGlvbmFsaXR5IG9mIEtjb21wcmVzc2QgYW5kIG1hZGUNCj4gPiBuZWNlc3NhcnkNCj4gPiDCoCBt
b2RpZmljYXRpb25zIHRvIHRoZSB6cmFtIGRyaXZlciB0byBzdXBwb3J0IGl0Lg0KPiA+IA0KPiA+
IEluIG91ciBoYW5kaGVsZCBkZXZpY2VzLCB3ZSBmb3VuZCB0aGF0IGFwcGx5aW5nIHRoaXMgbWVj
aGFuaXNtDQo+ID4gdW5kZXIgaGlnaA0KPiA+IG1lbW9yeSBwcmVzc3VyZSBzY2VuYXJpb3MgY2Fu
IGluY3JlYXNlIHRoZSByYXRlIG9mIHBnc3RlYWxfYW5vbiBwZXINCj4gPiBzZWNvbmQNCj4gPiBi
eSBvdmVyIDI2MCUgY29tcGFyZWQgdG8gdGhlIHNpdHVhdGlvbiB3aXRoIG9ubHkga3N3YXBkLg0K
PiANCj4gU291bmRzIHJlYWxseSBncmVhdC4NCj4gDQo+IFdoYXQgY29tcHJlc3Npb24gYWxnb3Jp
dGhtIGlzIGJlaW5nIHVzZWQ/IEkgYXNzdW1lIHRoYXQgYWZ0ZXINCj4gc3dpdGNoaW5nIHRvIGEN
Cj4gZGlmZmVyZW50IGNvbXByZXNzaW9uIGFsZ29yaXRobXMsIHRoZSBiZW5lZml0cyB3aWxsIGNo
YW5nZQ0KPiBzaWduaWZpY2FudGx5LiBGb3INCj4gZXhhbXBsZSwgWnN0ZCBtaWdodCBub3Qgc2hv
dyBhcyBtdWNoIGltcHJvdmVtZW50Lg0KPiBIb3cgd2FzIHRoZSBDUFUgdXNhZ2UgcmF0aW8gYmV0
d2VlbiBwYWdlIHNjYW4vdW5tYXAgYW5kIGNvbXByZXNzaW9uDQo+IG9ic2VydmVkIGJlZm9yZSBh
cHBseWluZyB0aGlzIHBhdGNoPw0KPiANCg0KVGhlIG9yaWdpbmFsIHRlc3RzIHdlcmUgYmFzZWQg
b24gTFo0Lg0KV2UgaGF2ZSBvYnNlcnZlZCB0aGF0IHRoZSBDUFUgdGltZSBzcGVudCBvbiBzY2Fu
bmluZyB0aGUgTFJVIGFuZA0KY29tcHJlc3NpbmcgZm9saW9zIGlzIGFwcHJveGltYXRlbHkgaW4g
Mzo3Lg0KDQpXZSBhbHNvIHRyeSBaU1REIGFzIHRoZSB6cmFtIGJhY2tlbmQsIGJ1dCB0aGUgdGhl
IG51bWJlciBvZiBhbm9ueW1vdXMNCmZvbGlvcyByZWNsYWltZWQgcGVyIHNlY29uZCBkaWQgbm90
IGRpZmZlciBzaWduaWZpY2FudGx5IGZyb20gTFo0ICh0aGUNCmJlbmVmaXRzIHdlcmUgZmFyIGxl
c3MgY29tcGFyZWQgdG8gd2hhdCBjb3VsZCBiZSBhY2hpZXZlZCB3aXRoIHBhcmFsbGVsDQpwcm9j
ZXNzaW5nKS4gRXZlbiB3aXRoIFpTVEQsIHdlIHdlcmUgc3RpbGwgYWJsZSB0byByZWFjaCBhcm91
bmQgODAwLDAwMA0KcGdzdGVhbF9hbm9uIHBlciBzZWNvbmQgdXNpbmcga2NvbXByZXNzZC4NCg0K
DQo+ID4gDQo+ID4gUXVuLVdlaSBMaW4gKDIpOg0KPiA+IMKgIG1tOiBTcGxpdCBCTEtfRkVBVF9T
WU5DSFJPTk9VUyBhbmQgU1dQX1NZTkNIUk9OT1VTX0lPIGludG8NCj4gPiBzZXBhcmF0ZQ0KPiA+
IMKgwqDCoCByZWFkIGFuZCB3cml0ZSBmbGFncw0KPiA+IMKgIGtjb21wcmVzc2Q6IEFkZCBLY29t
cHJlc3NkIGZvciBhY2NlbGVyYXRlZCB6cmFtIGNvbXByZXNzaW9uDQo+ID4gDQo+ID4gwqBkcml2
ZXJzL2Jsb2NrL2JyZC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDMgKy0NCj4gPiDC
oGRyaXZlcnMvYmxvY2svenJhbS9LY29uZmlnwqDCoMKgwqDCoCB8wqAgMTEgKysNCj4gPiDCoGRy
aXZlcnMvYmxvY2svenJhbS9NYWtlZmlsZcKgwqDCoMKgIHzCoMKgIDMgKy0NCj4gPiDCoGRyaXZl
cnMvYmxvY2svenJhbS9rY29tcHJlc3NkLmMgfCAzNDANCj4gPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+IMKgZHJpdmVycy9ibG9jay96cmFtL2tjb21wcmVzc2QuaCB8wqAg
MjUgKysrDQo+ID4gwqBkcml2ZXJzL2Jsb2NrL3pyYW0venJhbV9kcnYuY8KgwqAgfMKgIDIxICst
DQo+ID4gwqBkcml2ZXJzL252ZGltbS9idHQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
MyArLQ0KPiA+IMKgZHJpdmVycy9udmRpbW0vcG1lbS5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
wqAgNSArLQ0KPiA+IMKgaW5jbHVkZS9saW51eC9ibGtkZXYuaMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgMjQgKystDQo+ID4gwqBpbmNsdWRlL2xpbnV4L3N3YXAuaMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDMxICstLQ0KPiA+IMKgbW0vbWVtb3J5LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDQgKy0NCj4gPiDCoG1tL3BhZ2VfaW8uY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDYgKy0NCj4gPiDCoG1tL3N3YXBmaWxl
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNyArLQ0KPiA+IMKg
MTMgZmlsZXMgY2hhbmdlZCwgNDQ2IGluc2VydGlvbnMoKyksIDM3IGRlbGV0aW9ucygtKQ0KPiA+
IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvYmxvY2svenJhbS9rY29tcHJlc3NkLmMNCj4g
PiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Jsb2NrL3pyYW0va2NvbXByZXNzZC5oDQo+
ID4gDQo+ID4gLS0NCj4gPiAyLjQ1LjINCj4gPiANCj4gDQo+IFRoYW5rcw0KPiBCYXJyeQ0KDQpC
ZXN0IFJlZ2FyZHMsDQpRdW4td2VpDQoNCg==
