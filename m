Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097BB81AC6
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966555; cv=fail; b=QT5DSXOw7jb6PFn7P2yzZGoxbrBtxmsSBMsDVTdKOk1ke/WZijz8mr0rB07NwyYGQdrd9sWheaScgAjCXIpyJH9+43BXntEyhBA/egdZ4pBTY+f1xDHOYNV2v1sfQT9E0CtKhOLPNnxo4N6//7K7GE2M7eksAWQS3i62gbjJBpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966555; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JsPrDWr9uoQQXLC5jRZ+Ag5o0Ft3rKS7OLukvcI2Ykdo4sK1/PCUL2ifop/geKf04s4s+NzhbXMCPDQaLUW6Yr5DALE/2TIS8HUpEpGYErwkrzbnfSawKAd0TRIKjDIjL4FG/+jccfd1Mzgas1MWHLqgO/RqWD0ZwnRw/oU+tEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gfC7k3vg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sDhx+zYp; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gfC7k3vg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sDhx+zYp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718966553; x=1750502553;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=gfC7k3vgBqb4Vc6NY1XZyqL0dKywvzLD0V183hPbq8e6nvZxs/ubIIAr
   ROzqOP9ZrTPlPKk7hr+62ZAX+GvtBIr8iTew+u6mXLVJPpFCkBlnR6EdU
   luK/hL7/Ek+r5+XTDoL31bcULXrao7BjPHfYxT9ykZ+jEpkr3lhS7WwRS
   OMMpz32CVE0exEGv/20ACkSiUcIKAMz61jvVX5vBf+KbPobRorkJ4oWKZ
   jVkRDRscg9GbEmnq41jlXP8RDV/g8clhK663GjjIuhRoC5xEqXUAqZZST
   hoCscrNfO59lDqlPt3UGVBaOG1EkiFANDyX0HKBpYj5B2JAE8/+ouziAf
   Q==;
X-CSE-ConnectionGUID: kysain7BSnyDExJsbxSGog==
X-CSE-MsgGUID: 8Vi3hKueQ+iSAuIgCx/YQQ==
X-IronPort-AV: E=Sophos;i="6.08,254,1712592000"; 
   d="scan'208";a="20479849"
Received: from mail-bn1nam02lp2042.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.42])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2024 18:42:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k813Y7CoXHtJDXkmLK7aLtkQzrUhj0supa6SO1jS+PVUlv1smCZROkBqF9ypxy7bXzyXc7lRzjoDZsSBEyUPxU3VkHfrsRXE1o9M4SUPpaE86qFrH3fD4hlpsnUi/6snUarwev6e5DMetBPumTEOeRPdjbCSayzCK2dJR1RM8/VBlfyErOCqxzKhYvpS0RAI38MllklyOW7fauyzd+ZAfAjmzw6azJMaMu9wiSPjtuTlENfKb/qRKhRWouPkMkr/ERCO5Bc/alGF4IPCjYnIkCxJEtyd1UM2AMCS1rBoUR+1z3tjapeMEBSKXKi0qa1U7dNcLHt9dprdtv/WtD1k2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=DQNWNh0iTT4bOoQWML95a4aLWp9o2u1/ixphl3QsTY0w2xLGjUsGjuMUnQAWc/kOYZHCmxpK38OlY2grrZGSye6rxSwa9OKoneMsLpw5majduiEHmKVNhAeINrAPGHwmg8rTJJ7ZFITpQJfD/PvDNI1SsWquPAARJW78yf60TtiMTMaAir62Hk3el85gR/waeCv0A4zEuxfZOpQ1bQCRLcqii6doVZwVejWFYxjWJGPn0uz27Nem90F4rbymhTBC8d+9m2s/KZjMBFiRv4hS3cenISepD7voiHGEDiY4vbhpqTTZHHkbPbFy7xuAvqfHIHJ4vxFmH5W+goRmOyz9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=sDhx+zYpZdXBFNC5aU10yKIraKkc6MBL9tsNEdF3TiSSG9jRMi1czCQBIqOLixCmiBPxaGxPjnGe0vbJlaU5FEIYpZGbPtAR9Obf8yOOSH/i8MeSL7KZ4E6PTC7P0giPnqVbL8KyFXEIR24mTx9pwZB2Sfi3oTF2Rtr8cJ9ro1k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7689.namprd04.prod.outlook.com (2603:10b6:806:14c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:42:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 10:42:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/3] block: Define bdev_nr_zones() as an inline function
Thread-Topic: [PATCH 2/3] block: Define bdev_nr_zones() as an inline function
Thread-Index: AQHaw4lDHoqgjVe1wEahYEtWY0Ct67HSCFsA
Date: Fri, 21 Jun 2024 10:42:30 +0000
Message-ID: <dce9d76a-ba37-45c2-9451-d9a55849d879@wdc.com>
References: <20240621031506.759397-1-dlemoal@kernel.org>
 <20240621031506.759397-3-dlemoal@kernel.org>
In-Reply-To: <20240621031506.759397-3-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7689:EE_
x-ms-office365-filtering-correlation-id: 812260c8-0eb1-49d8-510e-08dc91deda33
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?SkZiR0doakZXWFIwUk8rTnZmWUV1dFpFWkxTaVVTQnhFU1dXRzR2T0kyTHRz?=
 =?utf-8?B?dE4yNHhjcFpxcWRQYklPdWwrckJ2Yk53bE1vdW9PVU1icTFnWTFqRHcxZlJC?=
 =?utf-8?B?RjlUUWE1TC83cXMwM2NFZG9KQ0RIR1YxOFNPU3hKaU9xMlkyOVhlOW9FMjJu?=
 =?utf-8?B?Skg5azFDK1dQc09CNjh1TXhpNWNZZ2F2NVY1a0swTlVnOVZIRmFDS1AxcXY3?=
 =?utf-8?B?N0FVR0N1QzM3K0g0c2V6bDJJUzl0R3BlczVHbVdkNDRoNEdnZ29YUEtEOE9K?=
 =?utf-8?B?TysyMkdEeHJ2OWVtSmdUQ2tZT2ROK1h5U3BXY0JYL0F3NW8wVWhXTHFRNmlt?=
 =?utf-8?B?ZElpWmdydFFwMVlZcDh6SVd1YnB6MGxxNE5LMUx5TU9iMno3a3llYkJQSVZN?=
 =?utf-8?B?NHhCL1VvNkJhTDMzUDRDbnhLRkswMnk5WUwwSHIyUVM5T2c4Z3IxZVVsMThK?=
 =?utf-8?B?QkNYeTd6OVp0Q3lPUm5vTWtTQXJvbWRHb0hQb2FUeEthRW9zL3AxV1NaUTB0?=
 =?utf-8?B?YnVRNTRvV3o3UWdTWTFsOWN0blBrbFpQTkpXeVYzL3BuVlgwOU1uR2tlVmFU?=
 =?utf-8?B?aHpxelFXejZoZDM3UDllL0p3VXU5clFFWDFtRHc5c05EbVEvOFRSTVZ2QTZP?=
 =?utf-8?B?MGxwZnhaZWE5cWxkT2xtTzF0TFgvSmV0WEpWK3VQU2xBc0FhRTNCT1lDWTVB?=
 =?utf-8?B?emVmaTEvcDlJZEZ1MmZzbzBzV3FlMi9UdzI0T0ROZ1FRd1oxNkMycHhrYnpX?=
 =?utf-8?B?RXdseUNLemdXeTJpbkF2ZjFmbERDUFUzMkRSdCtkMndvSVNxV3JUNEV5SHBO?=
 =?utf-8?B?MXZqQTdldjl1TXYxbUw1NzZmWVJVN2k2dnVDd2pSUEo0Vk9GNGd1eStIbXBM?=
 =?utf-8?B?TzRld0pPLzJsekpqMGd6UUVHZVhWWUpUQ2gvUHpCL29BS0dKNnE1TVJ2czN1?=
 =?utf-8?B?cnBMS0REa1llcFAycml0WFBQNVIxOWFETVV3OFN3UTJnNXVXN2NkV0Y2Nlpj?=
 =?utf-8?B?dlAzRzBBajZpemVRSUZSYm1CVno0SnoxeERRMVYxM28vd29ZTU1PR0tTNklE?=
 =?utf-8?B?L1dPeTNKbTFncFNzeCtLUUF4ay8zbmNTR1FLeXlLM2Ftc3pxVDRkMHd2ekZa?=
 =?utf-8?B?NDJIZVJCSkw3Q2RNM1RRU0hHQ0tPa1NsMWM5YUxSVzdnVE40TUI1c1cydHNi?=
 =?utf-8?B?cGtKNmFyZHVFditobzZ2RGFlYXB5Tjc4cWlILy9ObDlmNm1oNjc5OWlIZ0hl?=
 =?utf-8?B?ODFjYTJKazZpMWtOYWRaYVVJLy8wdE14Q0dVbDE5MnM2b3ZTZjdPM2JVZWxz?=
 =?utf-8?B?RVB4TnY1TUhKU2NXQ0pMUUlmRERCeENsQ0pWRlYxc0xOcXVpRU9SeGZvTS82?=
 =?utf-8?B?OERsVVdLZjZsUnFsdmhBT1dCdForeUdOTUZCVEdEYXZZNnU2c3NNc3RKYUl6?=
 =?utf-8?B?ZTZhWGE2em9FeDdGMXgwSzhMeFl5NUR0MFpweitHKzFtUnNQYWlZei9hUVVh?=
 =?utf-8?B?UWtsOXJhRU0ySkpYQ1RJbitsQ21Fczhua1lVZXdkZ1VlcFlQc251aGFQbnpz?=
 =?utf-8?B?UWxSSk1rZFlvTzI0WWY4UStGTGhDYmRZN3M4dGJxQnpVakE2KzJkTXBlVHFl?=
 =?utf-8?B?OFdmOFFjanNYWmdtOHJkbWxkWUxObUM4QjRxdTJOcWlnQVFFMG1nb2JQUm1Y?=
 =?utf-8?B?ajE0QWIxVGUxN3U0aGZ2ZzhQWkpoZlFkZ1pvTEpIbytIaSs3d1dxazdrOHFQ?=
 =?utf-8?B?a2dLOVQvZFF2VG1ZZHhocHc3anYvN0xXVzdPSm4yZytWZm1oNHdUNE8vMjN6?=
 =?utf-8?Q?xLcSRiSSVltP36XWsosJ0coIHrZW7LiJLPY1A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWllSlVwR01BVngyNFdvcGNPTjdlMEg3ZXhrNjArbDFodENTYjUxaFNoakxY?=
 =?utf-8?B?Y0Z3Ry9NNFJUV1pESHZQTU0wNGwrZENmWU05aVY4cTRRUFV5ZUNGMmc5ZUVy?=
 =?utf-8?B?ZWtrNE9aVkI0Q28vSk1KcEZkc2ZiWGplRmhWQ2tCMmxNaUI4RzlXYWkzMlpi?=
 =?utf-8?B?cHBtS2l0TXIzVWgxRXdRQ3VXN1RqV0JKRmpsVFE1VlplWVR1cVdIQ2ZSUHdL?=
 =?utf-8?B?bE5HS0xIdEVVQkFiVFJLTlJvZzhHOWNLVVhEMWpUT0hKUzgxOHd6T3FwZFVV?=
 =?utf-8?B?T2oxTmJuSGtLUSs2M3hRUXJQWmZGVnpkVFdKTWpPbGx1RFVTWFBiM2RkaTZJ?=
 =?utf-8?B?ZVpPUDllSXpMNjd6dnk5ckJ1SHNRbk0xbVczWjl1aHV0UEtXU1h5emxKWDE4?=
 =?utf-8?B?bXZROXUrNTE1TGs1L2M5UE1DQnBnOEEyYTZIWmRGditMT2s2NXJkSkJuVEds?=
 =?utf-8?B?UGNEUmZkWC84SS9RNGQ2emYySWh4VXRSSFdKRFMvTldmeVJSNklSUHRvMmxI?=
 =?utf-8?B?R0RTb1Y0NFVvbFRFdHFuR1FwbjNCRGlLN002bHQ0OG5jT2Y0Nk9UTXBudmQx?=
 =?utf-8?B?c3M3VkJTME9Ld0tUOTlxRS9RbHpSNERVWlNXME05cGFZbjg4UDVuWk85U200?=
 =?utf-8?B?d1ZiTXVBaXh0dTdLTzlEQzhsaExmaDdaSjMzVmVVL3I1ZWJzWStXelpGYURU?=
 =?utf-8?B?ZFY5VCtTL3hRb0VBQkcyWHN2ZEI4NTMyQVBtZU4zbmw1bkYzWHRIdy9qc05i?=
 =?utf-8?B?MzFiZU9xR1dzSm9DQWk0ckRZd1Ruc3o2K2V5NW9IbmZsVGdYRUJLVDVaM0dx?=
 =?utf-8?B?OGxyN0dBc1c5amxsWW05WlhDT0tMZ2NQTk1RcXJXZHpvL2tieEFTOWdQWTg4?=
 =?utf-8?B?aW5ZUmFVWGpPT3RhVGU0WXN3TlJFeXdNUW1kckJDVjJwKzlVNTEyZE40NHJX?=
 =?utf-8?B?QzB4QjN2aWkwNVM0bHloSmFTUUJlV0hGczJ3MTQ4dVprV3JKN3NWL1FnazFU?=
 =?utf-8?B?bDlXemptM1RYdytyaU02WUY4OUhBRzRyOVpHdlVjeHgvVk5KWkM2aVlLekhP?=
 =?utf-8?B?N0ZsTDh0YkJINHB3dVBjYjN4RUJFRkdaeUl1MGtZQlYrbVdaaG00bXBMT1Jw?=
 =?utf-8?B?T0RKL2pBVmJ5ZUpqdUZ5Y2xYOE0wc05wYWFTVjNubTFtdHJsVENNWkoxUnc5?=
 =?utf-8?B?cEg3ZjFqZTFWRzRrd2g1cFk5ejBhanZpZ1k3UFVaRWh1MzBNbi9KRjhydTE1?=
 =?utf-8?B?YzJBZVVER3lYc0luMk9lYlhXZW01YjVBY2lCaU82bDZXb1laOE1NTmo5Tmpt?=
 =?utf-8?B?VWQ4d0pYcTNWYkpkQk5oS1BKNDZrdmZCQldpdHNQS2UwTUFQNmFGdzVZQ0FZ?=
 =?utf-8?B?RmlMSjNmZjd1STQ2ck5uUU1uZkhGanFhQUJybllGZ1NpV2FLWUY1NE10Vlpv?=
 =?utf-8?B?SEgvR1NZOTBvems3RDdyejZpL3JsSGdsZWZvWGFGdU5OVnBPZ0pYQkhpZ3Ri?=
 =?utf-8?B?MU5ITTQwcDRsbzR1NERTSW5wbFlJamcxMk1Ib3UvNmZDUGxBNjRFTkpjdEdm?=
 =?utf-8?B?aGxkZVcrL3c2M0YwVmVESHVzblZVY0FRL09peTBlK1M2a1RhSEZqMm1NU0Jq?=
 =?utf-8?B?N3RqM0RwRTUvRC9uMTJVWkJkOEY1L2psLzE5a1JqSWdIRjNlcXg0Z3Vka2JP?=
 =?utf-8?B?eUFud1ZjUUFwL0RDM2g1RW9nazhFd0h3N3dKSjBETWV1VTZyM1laNGZBYzl5?=
 =?utf-8?B?eWxWMzZNMURtVWQvYlg3NVdYV1QxQ1NvTGlRZnRNK3FHRGxsaXR3NlJqQW43?=
 =?utf-8?B?VnNmdUZUa2kxK3dmcEJ6ZHdYZ3ZUd2lRcmhRaXlWQ3FWQjJ4dlZndU1Kb2VV?=
 =?utf-8?B?aEUxWmczeCt2MUluYkx6cDBoZVRzQlFUSU16MEtxOFhJTGNzUFR4WmZ5TS90?=
 =?utf-8?B?b04zQUw1UHFwNGluZ21xNDBMMkpIU3BNK3pYSEl5M01WQUxsWGg3MUIvWnh3?=
 =?utf-8?B?SzBVZFFQdDRnMjFYUDhrSkxmaUc3L3V1QW95bXBFWkd4YUNXY2IvdW5NYlpz?=
 =?utf-8?B?NERjVlRzMDRjdlUrZG5BOHpObFZGT09WSzZicmthWmR3WE1hWTJ4bzR5RG5C?=
 =?utf-8?B?VDZxcXY1eVRqdGtaMDhQbThQem9kVGkzQXdWbDVqTWJaT3VvUThYZ1JaV0Fw?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6DF83A3F8C9774CB2AED4B3CFF5C5F8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N4oe2C7kkmJzdydpXWlr58327MOMZ7LImbVs3O8n+XCasiZ/fPNqa0EZthJxb19IVVIlWFBUum62WFf24UUS2Ced8NUUVUsxOGnhzdj22sDp12bJbxVfLkhMf3JEAGfAGnODmZyutlMNsYqF3TWeBaHU1QKoELI1oC7nLtHR+YQdmGVltd82aptOlDxw5bLyXqo+Se+K3PrT51ziKAoOanvsgAnvBIZcgJ2Jyv0sSxkz3ooU+DIGpKzXSHWwWQH4yDiRfadSqOygzBR5gXd16bPpPrAAS998z3Y11fpqEboxzVDY+AnjjWGYWcg3DjOGA8xou2xhbKb5Yy1X98urWegLIPewdBUEIG8+kWH2m6kStfgx/kXVjKPbHiKbcuLKbXj8E0bnHfK7KjUrKrxkWRXyQ9gIS7E0u8taWgb0CHRu+3fFFEl43aeCxfofI+o/qB7SEx4leWUrl18uNM7pAJKQGZWy0o15v6GtMV0vIQI7TNOy1gqze94L/l6fW4dQTbY/POSdh8nRJpPjcnXOXqI3egrXXwh08V9dyp49PNgYSuDb7XI+Rwth5SN4lY+bFAR1fI+TVOied3BmefNonpjSKEwao39d/GeFH8y/BpvIhHTIRlRXL1fIbCxPowVs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812260c8-0eb1-49d8-510e-08dc91deda33
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 10:42:30.8954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofG2oynDZnP3AT4rZDGBFU3k/nyYlOhM0b4Kyfps75E+OmCxJx9qIwjNlSPXhuSBV/nRwYz3Q1EN7Fmm7IByZhVegIt82KXYNYkx66qnwz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7689

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
