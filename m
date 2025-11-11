Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012065.outbound.protection.outlook.com [40.107.200.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337722D9497
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 01:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825781; cv=fail; b=rKg1vYb0zGW0UgHBREEiLQ4nK7ZeQZagKhkpcxo7zETXv1QKzQngqnWIiQCdXlL1I8kfd+AouN2BM/RvkRcgiPLVMrJlvg0XhzToO1r7D54E5E4NpIe8g1Crr7+wXzt1CLzTArCyaUVOZpQKZPa+GbPcE4iqlUYBZOADmSsR7As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825781; c=relaxed/simple;
	bh=LX/t+SpplnU8rL0uv+zOSB+b4uweN9UggT5r8FnVUJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qmDNpvaEC4d4lpEg31XMOES+QEXKpvKDdxUDpKfi4sRqBqejXpqwu4+wgMqrGQrLe87//a0ZyoCfNsdOPXHUfmgGP1FrzUbcT1iqY1i+UDnAXBYe9QXC+Xuye2Ho0XVWRdCtF7PEYptD+yZ/fEAeSWcIEPOd9ZcaDqAqMrvULpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jhZxHzOx; arc=fail smtp.client-ip=40.107.200.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jhZxHzOx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKRezZpzdoBBFbenndKiZKQT1nuxzRqMrugWwNzAyGZedt/phMHSXn5Zwz4yjBpqYTQuF/aHE+DZ9doKkyyLoVXIHLEjbt2K4+flhuiqNv4rNCI3bV8h95HA/dJzHV7HUTgGI8RY8b2m1Dd1kAZsZUz78abF7d52REzwbGKTBMGVOghFea7lhB4eRTu1BcCzvnI39IcssImYvdAyAQjnBZGHctkj+sXEfps6B7sLBQrci1dONCsflUPGHVNg2CsvMKgoNekzPqwJV45+enqszxIXBLg37WZxnMjSgsGbPlzloJesFUZc6n46ya8SASwaw/V0Z0erfhOmenXvZg+bRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LX/t+SpplnU8rL0uv+zOSB+b4uweN9UggT5r8FnVUJQ=;
 b=HqMEbQ0DMi5yV9tP1BHJsjYYgQ1MVRptTPFaNnpR8LeSjpMe6Nx0byoDfIj0bL0E29N25eqfHhWBEU7hlf2OgB8PQo4a40WDNgkvsVqxhbM7liZQUyywU250RKoQ4KxpVZUGV8q2t3DSK6Jnjioze1g1bRuhiMnZmG50abVziZt20D0Jbv9FiC+dYN03p+OKcpT5cWLrAR5GeX0St1IS6CMbX4fPctP4+uqpdAbn9Ex8LfL7lkfaWRQMSvLsxH6UtVKVlnj1CT3F9ryxYTa4v3TnNiOKay9NtmiDEMLY8KzMGdV0Ttgu1JztXQT3eydmJDzW6diznD1/MBAg6SOx2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX/t+SpplnU8rL0uv+zOSB+b4uweN9UggT5r8FnVUJQ=;
 b=jhZxHzOxlrDhVWJQl2Cr5u/xSN8SsS9QdR4kbYU1Gi3pNDdTu7YikfDHre+Pr13RXIQIWt6wDRcQPGppjMSAIxiv+0ipezc5J/6SVTOtZqhvHEhpsPJ0ZwNMILvgLGJT3OH1P/azBMXXYZ3mXoALxF0/9Ecdfx0tznvdve2ZzTSibsjqPN0z8FABLAat9M57wkMGKKCqgCcRsZALAtlMAye34L/jyh5TI75xZf7Oo3GXLXwSaNj8lSnc8s8ssGd65MuQdgEBYOfi4qtRJSnb636d4FAhF7vV8y+zglzOXmxsArS//ZRAvVqMBdKhRNir5YKljv5mjw5p2u4FrbJV0g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:49:37 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 01:49:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/4] blk-zoned: Fix a typo in a source code comment
Thread-Topic: [PATCH 1/4] blk-zoned: Fix a typo in a source code comment
Thread-Index: AQHcUpNV2K5SCdlTXEWZZ0/2EhbGSbTstbcA
Date: Tue, 11 Nov 2025 01:49:37 +0000
Message-ID: <dd785af0-c3ea-4a47-ab35-60b74b1ef630@nvidia.com>
References: <20251110223003.2900613-1-bvanassche@acm.org>
 <20251110223003.2900613-2-bvanassche@acm.org>
In-Reply-To: <20251110223003.2900613-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ1PR12MB6242:EE_
x-ms-office365-filtering-correlation-id: 3b47f835-f1f1-469b-7bfa-08de20c49224
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2Rhc2dWMERmU2RHU3hXUkxjaDVsMHVCaGxoS2VoUU9qVDNiOTlzNFNwODNJ?=
 =?utf-8?B?VXJaU2kvazg1U1ZuK1pxbW5kUVVuN2FXVEg0MEk5bFRtcSthaEdQUXRpMzRh?=
 =?utf-8?B?OEJsZkwrcGNyR05EU2NZVU5BM1plVkxKdE1oVFF6eW54eU1VcFFoczRuKyt1?=
 =?utf-8?B?VStudlNjazhwdkkyMDY0Z01LcTdLSHlzZWp6cVZwK2d2MmNRL3lFTUM0a3p3?=
 =?utf-8?B?T0xiTG1ldTA4Q0ludXYzNGRBazJoWmlYLzlFcTJVaU5xWTZiTGc1dlNTT0lv?=
 =?utf-8?B?M2g0RjR2a1doT1JVMDdORnpLNk1QclpQMHp1NFNuOEhGZVo1UmRFRFJFMHRV?=
 =?utf-8?B?ZXBPTkM5N0FSL0llL3JzZGc3UDFLdlh0VnBMbmRzSlZiVytmOVJFRm1RVXJh?=
 =?utf-8?B?WnpTNm0vRTlUckxONlh6Uml0ZXFmajFXbWk0UXFyd1BwR1RaZDkrdE05RE1X?=
 =?utf-8?B?dkV2QzViQ0toMmdaZjFUQXhXb2NVcGtQb3Q2N2ZJSDltbnZzcDdMS3JkL1Bq?=
 =?utf-8?B?ZTNpWTBlMExUUEEwNnpBUDBxVnFGcmZhTmd6Y1RLcThETy9xeW9pSmg3eTdX?=
 =?utf-8?B?WFZpczhWU2xxVDA1aklack5qMWI5MEdNVzBjakpRbVpQRmNTVk54OTRUbDVN?=
 =?utf-8?B?eFd6YmxsOHc4N0w2QlB5U0F5QTNpOTEwdmlVaXB1SUtaVnVYUWxDM1lVeWI1?=
 =?utf-8?B?RGphTmUwZW1meWxRcFJVUE5uSXdTMXFQZXhHbHJDZkRjd3NMeTl3dmxJdEFZ?=
 =?utf-8?B?OWF0RmQzMmE5K2pkaUpZcTlLODRDVERxQysrd2JhOXdjUXpoWHdDOE15MUQ1?=
 =?utf-8?B?T2k1S2NDTk53cU5UaVhhcDZtVUd6dnd6NUlWMmNRWUhiR3RTNWM2WWVVc0ZC?=
 =?utf-8?B?SVU4ZkhGWFdHYjhaMWhySVBvcEp0NjJoemw4OGdHRUh5UVl3TExaZ01aeDl3?=
 =?utf-8?B?VFZXekk3Vks1QUJZbUU2QVJla1dvVG9QVEVJcE1ySnZFUG52VGRqcXM0T1NP?=
 =?utf-8?B?NEZqOTFRQzE2N2orYWtudXpNUFViTXN5Z0gxZWZtS2d1U2xQMk5CVFJUU2du?=
 =?utf-8?B?dGVKeDY3c240b0Z4VjNTRTBmdW5EOU5yUklHbXNtM3FtVzZZZDU5RXJXbWpo?=
 =?utf-8?B?TXJCS0ZjYXIwSFdmTURBeVdzTGFCbExvVWpsN0xDdFUwYm9IcFhNeE56T1Zm?=
 =?utf-8?B?ZzE5Y2t5QnRtcUxramJ6Y25WWjBsYXR3U2kvYzFPRSt0SW50L2dWUFcyYVk2?=
 =?utf-8?B?ZC8wbXk4WnVaNCtXamFNSmF0Q1Zkd0QzaVViZ0NEc0pSdDliaFVRaTZUQnpp?=
 =?utf-8?B?b21HSE5peWhIZVp3TzV2RW5SdWtPdTJ1OTJocDBzUEFuNWMvV1ZXb2czMWho?=
 =?utf-8?B?T2JuSXBlMnhiRElaS0FkQjZMQVhPWWMvTy9IR1krWnpEUm9tRkhET2dSanM2?=
 =?utf-8?B?VXBhb0crdW9CTUpMalNhV3luSzlteGE5ZWM5YWdFcTFhUDVkdjdlajladENz?=
 =?utf-8?B?VUhRbnpCcU1GelZMOGlKNnRhOFBpUnRLTDFCWi9URnJkM3pEUm5sdjZwRzVm?=
 =?utf-8?B?UGtnWExRdDN4c2ZuRjdmVS9xNlhOREorVVBXMGxIeXBUdDNTa1B5bXpxYk8z?=
 =?utf-8?B?QUNwc2VEZDF5UWhZZDdSb3lMTTNPUjF5citBaHNNS0dtZU05RUNCLzVyOXFo?=
 =?utf-8?B?TkxtVVAva1lheGtrYVB4SlBTQXcwb0Q5MVpoWURaaEFHUUVCZEQyUTM1aTRw?=
 =?utf-8?B?dU9QbGpscGF5UVJBdEJ3eTY4TmJTL3pXQkhtQUMyVEYvZFVBd2pLbDU4eVNl?=
 =?utf-8?B?S09zY0ZjQnNxY2FkOXZoZWpsQzNLeTlQR1NYU21YaXM3Q1ZHNjc4eitMWWlp?=
 =?utf-8?B?YzU1TThMYXdLcUNIM0dRemVzUW1yWVpJbzRBRTNGM3pzSk9aWGErVHBUSHRQ?=
 =?utf-8?B?QXhlUGlhWi9WUXlneFpNK0pYZjhoM0pkdnV5bDRIaHZrTGpCMGpDVnZlZUg5?=
 =?utf-8?B?SkRMZk5BMG5jaXBjZ3lETTIzRFAyYWxCQ2RVenEzcnhtaVo3REJ1aFRMVXNw?=
 =?utf-8?Q?OaoZDF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEVlSFdjWGZkRUllRUVsVWpiYitTaytOSWFYb09KRGhyb3E3UkZ2SFNsNmtC?=
 =?utf-8?B?a25mRy9LbzY0K1kybCt1c2tnd1ZUZE9UeVVOZEwwdkxPMSsyc1VRWkoxbDJn?=
 =?utf-8?B?Z2pNcVFlR2x1SDJPS3ArRlYrTnJNOWE2Z09oa2NEVHZWR2psTFlSaWlrZVFz?=
 =?utf-8?B?S29MY3BtdnlmdFVYNXdTbDZtaVBUVU9CMVAxa05RQmxFMTg2K3FmS3dORFB3?=
 =?utf-8?B?L250THN2SWlHV2RLdHFPZU5Xdk5oL1F2eDJNT29lL1NIcjFRWDRFTngxODNC?=
 =?utf-8?B?T2JZQlppSlZJbThlQTFhclZ4ZDVNTThJVTZTc1VlREx6V2RyWmRXcHZXYkJB?=
 =?utf-8?B?MnJzWDR3T2VBQWhxZmtVYnZsMHRjRDVrTlVZSDk2ZXJRMWs3dG1yWVFWem9h?=
 =?utf-8?B?UGNzKzhObEhUREtqcnZMMUJmNTNkb1dySGxmeFRpT1FUWlhVRlNxU09OaHVB?=
 =?utf-8?B?bGhteWdaY2pwemoweDdMT3AxdGJhOVhRR1ptKytiS2d2dGh4eVQ0S2tvVGRp?=
 =?utf-8?B?VEROWmUwVWdGa1JzV2JBNW5PcHhVazdUU2R5Myt5Z05YTHBuTENhOVUrVG1m?=
 =?utf-8?B?K21NMmZZZmhZa0pJZHh6MGlZRHVCTXJUNFJqUFE0R0tIdUFoSTZhL2ZPbDNN?=
 =?utf-8?B?bEtKTGhkS3N5eklXT29XYk1obzBDajYxaFYxSGxIYWRTdzFRaWVJcXJLT255?=
 =?utf-8?B?OEc1eXdYTGVvRzRlci85MGNaY0xEUzVTaXVuUkpPSjlnaWh1YXc2Q0ZVNkZW?=
 =?utf-8?B?dnpRSmovcktRNlplWHJ5Sk9kdHZ0QXBMby9zeTg3LzFPZWtkTTRwZFh2RkF3?=
 =?utf-8?B?QzJYNDJrUVJqQ2lxbmtwMWk5Q3FvT2l5dy81ekFycWpxNUhNamhnMjJKc0Fn?=
 =?utf-8?B?WUsvVDY2dUh4dGF3ZlU5eHp5dWdFQnAyWnFselhaY1BvUWhOL0hPUklvMnl4?=
 =?utf-8?B?RjJCU3VJY1ZxYUs5NXdVb0Q1aWN5REhPNGFxd3lFRFYwaFJETXFrcnA3byt4?=
 =?utf-8?B?VW9qaG1XNUVQRkFXNVViVmlNTXhnc0RndUQzd1AyNFBCVjBGRS96RDludEVr?=
 =?utf-8?B?VTAzQmxvM3ZEUmdWS0VWRW5tNFp1UVMwZ2VBSGp5QnhFbzJlUDV2MGpsT041?=
 =?utf-8?B?NnNQOXRVM3VWaWZLWEFQZ3lyUzVtdGFtdHUybTJ5amswS1NPRXRDclo0VlZq?=
 =?utf-8?B?ZDFTdEM4aC9kK1dQQzBYOXExcEF3RHNNYmprUXFPVzFNWERXRzFic2d6ZHp5?=
 =?utf-8?B?R1poREZ2c2NycWRISnRoM1BEbVltRXlWaG9vTmlpMW5zUUVPejNCREowT3Nz?=
 =?utf-8?B?NEVxekQxbThybzhBdFFZUmVvTEdrcit0dTBzVDJlMURmbFlnRXJRY3FjU2hR?=
 =?utf-8?B?a2U2NEtWWjBxb0dxQTdSZXYybC9DaFVrWmVhemNUb1UvcFUxZWlyWS9LQWxL?=
 =?utf-8?B?Y29PV3JyQUtyRHVMZ2g5RHhLSmY5VzN2WHN2T005dm1rRkRLcVdxd01OVzU3?=
 =?utf-8?B?c3hxRzhkQkFNNjE3eGtRWUdOeVo0ZllzMUZuaFlMQXlSVXhnbk1xb3RySXJh?=
 =?utf-8?B?ZkVoRWZ4emhiODV4NFZjaURYTHZmVWxGWEJINDFHREg2WkpvcWxyTFdPdWVh?=
 =?utf-8?B?U2pWZ3hpYjFnVGhXcE1QNWtOak5LNEpUN0FLWHh4SXdVeElrT3BDSmwzQXcv?=
 =?utf-8?B?YlZMWVJTeCtaZkl3WjZvZkV5ZFBKVUxRb0UvbXVBdHRXRWRwRkpJdnZpL0hv?=
 =?utf-8?B?RE90ZDNCTjg1a3N0Zm5jWVZON1NhS0oyVGdQSmhlMEYyL3hPRUxHOFJuWWxL?=
 =?utf-8?B?bkxYbnBSWHBoYlB4TmF2a2NHcnNBSFlVd3BrWDhDVzJ4VW9YOTF3SmNaSDZT?=
 =?utf-8?B?c0dYT0tBZUtvUU9iOXBpWG5RQzBIY0VBdlFGaW5EMm9oc3Q4MUZPNjR0bUJM?=
 =?utf-8?B?VzZ2c2FlUExSR2lGY1RBSmdRSEVGYXY4cVlGMk9uUjlkL3NIaVFFQ3lJUlFi?=
 =?utf-8?B?K1czK1g5OXJjQlJlK2lDcUdwQnZSS2R1dWZ3eGtkcjRtbVViY21YWE9MTWlj?=
 =?utf-8?B?b3dKaXI2TWpaWm1GeXIvdWRveU5PMm1MNG9nRmJVRC9NSUxaVGQwSGt2L2s3?=
 =?utf-8?B?cUpHWG82bDc4dUpBOUpmOU50U3k3cldla0VldE4vTVUvL0owQi94cTY0NTlz?=
 =?utf-8?Q?xNFpXpOuLe0qaJv9C7devIumem3stVZlzxuw5A4i4tHF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAD2582DD4A2324A889A9D45CA0C8B54@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b47f835-f1f1-469b-7bfa-08de20c49224
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 01:49:37.0545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qx53Yo1NXi1zlgY0pHKPEoSqV22YVnpzdS+kBMx6qJUUjmmvCV0DHL6FAW7A11UjeoFTS8XP+zyulzmmQMlkFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

T24gMTEvMTAvMjUgMTQ6MjksIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gUmVtb3ZlIGEgc3Vw
ZXJmbHVvdXMgcGFyZW50aGVzaXMgdGhhdCB3YXMgaW50cm9kdWNlZCBieSBjb21taXQgZmE4NTU1
NjMwYjMyDQo+ICgiYmxrLXpvbmVkOiBJbXByb3ZlIHRoZSBxdWV1ZSByZWZlcmVuY2UgY291bnQg
c3RyYXRlZ3kgZG9jdW1lbnRhdGlvbiIpLg0KPg0KPiBDYzogRGFtaWVuIExlIE1vYWw8ZGxlbW9h
bEBrZXJuZWwub3JnPg0KPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCj4gU2ln
bmVkLW9mZi1ieTogQmFydCBWYW4gQXNzY2hlPGJ2YW5hc3NjaGVAYWNtLm9yZz4NCg0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg0K
