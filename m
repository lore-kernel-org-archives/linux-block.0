Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647569;
	b=pzYX/4O0I+gSMMB8VVSYnOBE7htNqCXR1wiV62+S4kXioDlXD9AZaqt+nEwTRJF7UpEH
	 Qf4VnhsnCMIt5TKHdiXx+8fhIxpwsZTOaQXkGk6KUfKq2yS6RB2R4ig2LXcggMBL6ey0V
	 WD0/HGgksjCEbL6fZnjUjwchn7GSRMhmsLPL4p/l/3JQ38/pTsHJWBPIgH1umTbK873i2
	 ZJMEK/biqb6SCrhguiQdreocrrrrwRPMWU3cM6l0yfuiF/RPr8nqRQyhWEMjr74z/xrvi
	 hPvaXGA9q/8Y/fGibQtYMRvLUjIS+oX9WlX+JFEL1GHagJiiWNWIMDDDn2kWvBN03dQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647569;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3ii81/k5RvZyedmGVUOa6rgMHZq27kN8ke4TP8pvCns=;
	b=TASf5k53ccOp+9CoTtxNMq3JewbSjZ2yde/Ha4cXSBsjIvHS69Kyxbo5laYG58am68bn
	 CCZ/zr/2PR+eBkHIdWDf/iJBNeZFFIsVaxGK/zTLPhgNSmwmsiPHByzM+gRMnU3y5fYAB
	 CEOGKdGES+sNw5CtRuj7lyV+qcX2L+gMsNQcZvQz9YVul2gsLWByAmY2MYW2DqZQtLMkq
	 UQtxK0W60KZpNwqZXjxPWikaCPEHYlP18x88hHbunl8iimwBzJBs3QDU0iyaBChppQ6gG
	 ebEqDH7z6cpqc677Un2S9FjlUC+MBvM/TShiDgOvuZtNzIQvf/SVvPBK2WNCDX0r+tA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RSxgDmAc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.71
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F64606A33C
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 22:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17F64606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RSxgDmAc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ul87dlLBU54URZCZEG1cd1C0zOct5+81wsJlvj23l6u8NTpAIFxMFvdr+icgmHZElj4X/jrqdNSdxFa43XFEjtX83UQHTDvJo6Oa1MuVjr55a7UpSUVM8hJGcvZERadYaqIYbWFJbbgy/ciu3JNDyIJ8cYoR1v5ew3gOEfuCJ0h1bYg8qUDwasXjoH5ocmCfhLLdeBSg0IZhMJ6lnOzPlVG6oBrxGe8TK9TfNz1bLCT3GNfdaAsICof4bm49d2/zIkNnaKNQh5seNudQXMMJ/BNIOnv0RUmVy6cgQKvnRIs7KuPXLESXNC0cYPsyHR/Of/Ho/8ZaSOtQ4ZFtZaVyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ii81/k5RvZyedmGVUOa6rgMHZq27kN8ke4TP8pvCns=;
 b=nr8K2SWqnfxU01kozqpKOm0CCMMuYAhkidzFXEEs6NvGRdNjHS2ArWwOHyMumckkYo6tldCYk/o3T/G0+WMe+MbGnTdaWnvyNnW98wNfHGr8usALK99rkAKB02YhbmsLeY7QBGlGbRWbijVSiEBftJKYnShjZ54aXZfHYhBTLpwolE7I6O42ClN33FrV2yCFYlbm8A/zmSlWeZ/YBgRqiONptOyf+dZ+K92GVhjY+ARFDqQ8zklJr5iNolOyQz81G8ZKterbscaeyp9m42d/LkZKpLtoCnKadbq/1HKu6ch/ZSzxomqqgc3LCOQLRew3bFsmxdYKwCs8y16rVlC2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ii81/k5RvZyedmGVUOa6rgMHZq27kN8ke4TP8pvCns=;
 b=RSxgDmAc0LUq1agqFJbr+sgiUuHozg7WXzjIxe7vOt7wRN0xYfIKcc6GabPvHzwzQZCzgUBGBBGvgjTdQow4LkEqI+1fhj+6fZBiggmq1SonQRUeQImivAccf4u1CMofzr1OGIrw+BuSTUGy2E8vKT1smyRuBiA+b5LAk5SaTSqnPBhuXtGQY3+yYS+b/a1g2ovq3gOnxgxR4+2c53Zp3CENpYmUfltLXNnQs1Zir+5LeVD8HKFekuld5gORpArv3nxo2vM1ZggDV2w9V3i2FOrIvMM0NfNlZ3su55t1LJkFIc/aCHUNgdKXKcU/e8BHm8Ke53xPlrLuPB/CUAt6CQ==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by IA4PR12MB590810.namprd12.prod.outlook.com (2603:10b6:207:10f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 22:58:34 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 22:58:34 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel
	<cassel@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/5] blktrace: add iotprio recording test
Thread-Topic: [PATCH 2/5] blktrace: add iotprio recording test
Thread-Index: AQHdfBrKsGwGSrSTJ0yOQDSgOncNFbc/aMkA
Date: Wed, 25 Nov 2026 22:58:34 +0000
Message-ID: <9dcd9d7c-3b74-4621-8816-eae1835635d2@nvidia.com>
References: <20261124135016.153657-1-johannes.thumshirn@wdc.com>
 <20261124135016.153657-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20261124135016.153657-3-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|IA4PR12MB590810:EE_
x-ms-office365-filtering-correlation-id: 89b6da4e-8156-46cb-ffe9-08df4b47a25d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|10067099003|56012099006|5023799004|11063799006|261026140227099003|261022075727099003|261021121427099003|261022105027099003|261028144727099003|261102123227099003|261009223027099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 rPvl+r8jPoTGsRM4/NUhcEY6xepn6jeKcEprsV8ChwCDDFPRtHJPp50ThotSGi9El9ScyLoMDD6l6mCVhNyarlBHoluER2VY9GsyFuhxbU3dfGICdgRSIcaLrz+yX4mSDMYRorhrgY789MjYl4f82hTWETPHknp4OlZerrz8pIbKXfYbY7miziu8rjCPzfFc4yKOpd6lZFJ52bNPCyLQULOCMkFFXaa/XWnRrIozbVj9+d6W8Y2rS2PoxJh5NZt3Ei2Mn/j1krlHHXPAotXQkU0WkyqfB4X2EDBgQuqswmN26/jG5S84e3iP57YQy9jiOR9HDtyDZ6cVg3lkka2tc0H9FfK8rJJ5uChOQ9hqSDKG83vwk2zHzyxwTfDlQ2DLZZvZmnAdwWtbcJGy0jx6gt9rXI3myzGhilUBwGvs6w/NoP+E2u8R0seZDpMl99SoAuymxa5A48jqF73ILVuZ1haTjnqnyj95n6SZJNqCT6ElUx0jUHXqddpVRdJGaugUhFTgKyBw2b+XU4Ic/tlrXMIzrIor+wy3DLC2ZkLWdejjWB505jJGJ/aQRs2X/842mP7HR6UZziZiVsHKVwQg++ACidA5VlQw5n+gK3/7x/x9geha/9hdRvqAjYSQqZXgPLfzArrbQhHczE6F1gD4eCDNGU/woJu+FOAmmQRsVOeS3ztJmizzyIY/zLC+ennSNsO2fcGADlLEawHgJsqgKEzhgqmBswFW6ZDPsYjQ6B0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(10067099003)(56012099006)(5023799004)(11063799006)(261026140227099003)(261022075727099003)(261021121427099003)(261022105027099003)(261028144727099003)(261102123227099003)(261009223027099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejViaTh5SUdxTC9Md2ZZeVBkdjVlRi9oSldOYXBvK1NjaXNTWXZLYzRFMC94?=
 =?utf-8?B?QUFkaTZMUlliczRLdVlWc3ZHL3VtYng2ZEV3dVFYYzRiOTM3blhGb1dPVTVu?=
 =?utf-8?B?RWlyd3ZUWkt3c25FQjVBOHZaOU9hWHBOY1FHd3BuUFgwenZmS2JBQmwzUjhm?=
 =?utf-8?B?ZnhjbVBROFdLMEZJOVRPTVVNMEV5Sk0vQnhDdms3aGhaTHloL0I5L1VuZmgr?=
 =?utf-8?B?b0oxVnIzMXVWY3ErcTFETHh5UHUrRUJmZDlnYWk2NFlhTkc5aTMrNW91N2tz?=
 =?utf-8?B?Q0U0UXVkWjk4VWVncCs3Wmlyc3FBb2xqWGlpNTcyMWZTNkV5UzFWNVlsS1Nu?=
 =?utf-8?B?MjI0L0RNWlEyKzlTVnVCS2RJMnhiSUlaWlZZN2RvUXBxZHJVMVY3UWFnYUpk?=
 =?utf-8?B?c2lyUk5zNFpMNkJwNEZyMWV1L2lOekp1WUpLQ2dmM0xMMHhKRWl1aWNOZHdS?=
 =?utf-8?B?QjZXNFVTeVdhK3RuR01ERUQ0UjZjS1NNYnFFZVNlNHZ4ZnhCeHNrM1lMMm9n?=
 =?utf-8?B?aWVhZmdkS2lJbGkwV1NpWG04bTM4UFBLeFpCek9KMjFOMjR3aWkzdVpqTnVM?=
 =?utf-8?B?VnlwVWlnTjA0Z2Q1Wmsyc0JVeU90NXpCWkRoM1BwRzN4Z0NMNUVqL0pmZmJP?=
 =?utf-8?B?ZXNNN1l2YjZrRGR3MFVpNFpPTzdGQ0g1bGZYUUNTaW9aYVQ0RnNPMHNhNDk2?=
 =?utf-8?B?ZkY5R0oxSFV4UG5uajdlR0FIbXJIYUg0TEgyYmY0MkQ0VEwrMG41NEJ2ZWhK?=
 =?utf-8?B?Yit3T1hjeGl1REdwZGhOYVFaaTVFTGZkM1U4dVBqbUk4VUF2ZFdFREFiNnJv?=
 =?utf-8?B?ZUxYQU9HTnM4SFp4c3ZTMldGRFZZa3JaWXFjdHNoUHdEM2REL2lGZEdUelpr?=
 =?utf-8?B?VWI0OXB0cHBrMjhrSFpBbzlXUUtMUEQwSldscE1lcnVkZWN5amRaRHR5a3lp?=
 =?utf-8?B?b0FoWC9rYTVVTGVSb0l1WEFFbmxMZUhvbFdacnZCVzFRL1ZKZzdvUlBYRllR?=
 =?utf-8?B?THFodG5wSTlDS0hUTXdBQjQrRW9xZmx3NDdaL2RwQklQVS95bkYxT0NjWDRp?=
 =?utf-8?B?bGpMdHlnTjAzOFhZeVowOGdYVEdSOXVYMDU0SzgwZDhFeW5PL3k3OHdncGVB?=
 =?utf-8?B?aGxxZnJmYnNuUjhuOGtxRkxjWDJvUEM3YnVmSzF1dUtzRXA1eUcxeWp3M2Zm?=
 =?utf-8?B?Qms3bHVtYmFCUzVEZks4K0cxSGhWRDBSRVV3TVBhRWVyb1NCbmJYbUhoVFVr?=
 =?utf-8?B?ZEN2dXhWeGF1bUNTNVIvTUhMUk5aRzFTcW1zVmNvaHRHcjBsM0pGNGM0SjRo?=
 =?utf-8?B?ZzdJNjlBd1duckFjYmp4ZEJmK2lmZzA0RFRCL1FncGFabnlXZGlvU2tJZzY5?=
 =?utf-8?B?UFdFaEU4UGpvSjl5V2xwT1JmZ0VjYXlCamZmMUV4cGVNNEFyL09yaSs4cUti?=
 =?utf-8?B?aWZVTUx1ZWFlY0tsZVJTS05qOUdNYVRxT241YmRLb3M1RDl4S29Sd2ZPTHdj?=
 =?utf-8?B?TlRsMzVpMjZCQmNFdEV6Z1RVbVVwMDFQcVRvbXYwT0ZKditFSUYwMGV6TTRW?=
 =?utf-8?B?OHQ1QVBZNk5oSkhSbi9FVlVrVUlZZit6ZDYxRXpWWGNPVHFLMWhqbmdoaUVS?=
 =?utf-8?B?NXdGY1hzZ3FWZWs3dVBobzJRSk42RmJWSlBScG5qeXB3VlNQc3ovT2tlcGNo?=
 =?utf-8?B?cFdnNlBVSVBMUXlBdXJwR25LZm90WUgrcThpWVluaVRwNmU5YksrdWtEUjQ1?=
 =?utf-8?B?Z3VKeXMxeUpSMzBSVkdieEJJWW0xQUsyYUI3OFh2ZGVIN0t3STBxdHhUZjZ6?=
 =?utf-8?B?eFRhdW1NeEtCdU9BYnVIR0xFcnV5MEQwUGFBWFVEbWV6SDEwRElQNVMrbkFp?=
 =?utf-8?B?cGZwQUhYU3diaFdhWFBKZzRpdlRMUWx5RDArZmszd3B5TmpCdHc5VFIrVmt1?=
 =?utf-8?B?bXRQVnBpbkhSdk02dlQ3cU10Q0w3M0ZLU0pFdmNaSlErWFIwWDE4cXhqZWN3?=
 =?utf-8?B?eW1KT2VtVG15MzhxRi85bUFNM0pxTkpHeXU1ZVI5YzlZQy9KZ1dGZEVucGEx?=
 =?utf-8?B?UGt1YWttK0h2NFMyMWdSdDdkSUt4UVBTOFFoZm14UzN1M3Zrdk9oOGpaRDFo?=
 =?utf-8?B?WU5jYnF0NDA0RWdVazk0UDVIbStCVmE1QW80aVk2aGdKTUI4elpJNDdHUWMv?=
 =?utf-8?B?cXhaQmwzVnJ1dWxTeTN4V0o4MU9mb2dlQnVXK1Znc0V3Z1U3NFUzN0o2THl2?=
 =?utf-8?B?R1Z1ODNydjhER2FUZVJvZnkzT3JpQVQ3ajVDUlVYTTJsQ1lwTDdibGhpQnhu?=
 =?utf-8?B?b2duQ2dXQ0xRMHZqOSttbVhTRThLeWNSV1c4VTRNSExvaHNZRURKZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A643679FC8D8F042B76BF62AEFC141B4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4159.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b6da4e-8156-46cb-ffe9-08df4b47a25d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 22:58:34.8401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLvmPtcb/kL2U0oRHHYp1xa6AKY5t+jhrHKFP1IOk10lGOZpi3rtTTJW9+L5j8ulpObS5eOfZborstEBkT6Z3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB590810

T24gMTEvMjQvMjYgNTo1MCBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBDaGVjayB0
aGF0IGJsa3RyYWNlIC0taW9wcmlvIHJlY29yZHMgdGhlIEkvTyBwcmlvcml0eSBvZiBiaW8gYW5k
IHJlcXVlc3QNCj4gYmFzZWQgZXZlbnRzIGluIHRoZSB2MiB0cmFjZSBmb3JtYXQuIEV2ZXJ5IFND
U0kgY29tbWFuZCBkdXJhdGlvbiBsaW1pdA0KPiAoQ0RMKSBoaW50IChJT1BSSU9fSElOVF9ERVZf
RFVSQVRJT05fTElNSVRfMS4uNyksIG5vIGhpbnQsIGFuZCB0aGUgUlQNCj4gYW5kIElETEUgY2xh
c3NlcyBhcmUgY292ZXJlZC4gVGhlIGhpbnQgaXMgcGFzc2VkIHRocm91Z2ggdGhlIGJsb2NrIGxh
eWVyDQo+IGFzIGlzLCBzbyBubyBDREwgY2FwYWJsZSBkZXZpY2UgaXMgbmVlZGVkIGZvciB0aGlz
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm48am9oYW5uZXMudGh1bXNo
aXJuQHdkYy5jb20+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRh
bnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=
