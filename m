Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE9DD28B
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FwfDQgOM";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="OxuH1yme"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC74D1706
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 23:36:37 -0800 (PST)
X-UUID: 89a5f6bc7e0911eea33bb35ae8d461a2-20231108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SKFshr93lu2rTkUhorH9UzyW+YHQYn4m0wibdjAC6GE=;
	b=FwfDQgOMGl6L72iGZwNGDhlN3enMTbZK0CAZbi5IC8GlFfNuL6+S9moNd7NQXaL/RdQSnFuE9qVCMkt3ql7uWz0EqnfFfMCJjD7wOGiCbYn1USsms3KlG3KfcwCc2X+vqHosnRwS8BeMZvOHNPNw7UXYAq9Oa0+XokN9045g3nc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:efc2c6b5-e341-4a2b-817a-ff5f6db02c1c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:86672695-10ce-4e4b-85c2-c9b5229ff92b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 89a5f6bc7e0911eea33bb35ae8d461a2-20231108
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1384221951; Wed, 08 Nov 2023 15:36:32 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 8 Nov 2023 15:36:30 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 8 Nov 2023 15:36:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K32K6xmIoXQVIb4p8d9YmWt2fSMQdE+DVCmO5yU3egVxa1hO5Rz6nrVMM3DZSxCEYGEU6n3Z0seclPXJ/O2TYZ/HfV6gQtsPMNqv3NL/oXi0XbHdogvD6955YTcA/zqEzvCREBQIq2kGEW26FbRHMohl9Qv+k3PpMSWYRwu+wHZ4LuWjO6GJ+e1o6TIG38TCdi6dgowEZpX5r1Y4PC1ygPxaHafS0HxKHVc0Mx9S44+Uv6+1xlw2qceVLz3YkEXD/1HmWEucUwJeddOtE9u14FrUahrXBJ2vZD21VGJT4vr7eWtCDMUTCyLFO/kEOmTpIgrEs5I7h9ohx7Tz1vE6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKFshr93lu2rTkUhorH9UzyW+YHQYn4m0wibdjAC6GE=;
 b=bEO33Fm2O0hk9Ue+Gy+x+1eJfUaXMT6cqxZh/624gHeTN+sVPenj4xeCwoBGVLXBiKQNf5gYwvH/jRR7vNkHAcZY4WnGuE/o0R+VIyhumvQfIrriDBbGtjeIMUo5oMC/VzdqtVIzjYZKjWDkgPNHHKRMZ1a+ndG01+45NbB8/0tTAjRmvHvGsP1yDWoR4P7us3GF3wYP2gdPe/PCIwsmXlsUd77s0CA2OVF2ycf3AQsFktvQiJHqRvixHIsC9zrYbJMgJVd1FzWA2ZznRDKOQJ+aijbp6OvDmhXmXPHPdX02PfgOvLFYvjRPSESyfd78YszZgK36UAWkePkHkW/ojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKFshr93lu2rTkUhorH9UzyW+YHQYn4m0wibdjAC6GE=;
 b=OxuH1ymeJcdXOvt8NkNGKgrLwxzwWidvp48G2qmgA7OKsEeSgahlqtEVun8mcr+2pTqaZinrBGaVwauNKfxodKYUquMBkDk7IzhX6JkcR1qwAbGFoyeoGBnk78p1/oRACOYh2hTUTlskOADalU6zMdBvX4AKYMgbTTBSa19YLrc=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 SEYPR03MB6628.apcprd03.prod.outlook.com (2603:1096:101:81::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.29; Wed, 8 Nov 2023 07:36:27 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9%5]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 07:36:26 +0000
From: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	=?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= <Chun-hung.Wu@mediatek.com>
Subject: Re: [PATCH] block: try to make aligned bio in case of big chunk IO
Thread-Topic: [PATCH] block: try to make aligned bio in case of big chunk IO
Thread-Index: AQHaEWF4GkJb+XAE0k6y5xfLSeBrLLBwCcwA
Date: Wed, 8 Nov 2023 07:36:26 +0000
Message-ID: <a4603322ccab3825d823c2bd3a7997613ff72496.camel@mediatek.com>
References: <20231107100140.2084870-1-ming.lei@redhat.com>
In-Reply-To: <20231107100140.2084870-1-ming.lei@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|SEYPR03MB6628:EE_
x-ms-office365-filtering-correlation-id: 716b0038-0fff-40d8-f917-08dbe02d6a89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5/AeqmqZMhev0Gmlii1p3r+xyOKjQuS71knwF846KGk+rcZeORZjD7Jb6reiRFW/iMaP9bYi3CDiv2PVrPf+jVl5CMKECH/DGOeqWJUyDmIC4o2NT/1ibk3ZwqDAPn14nqjJMx4GSEzldLo31+5v8sDDd4t0GfSjwOLA6C0Ra6YBI4MGCgzhoqYx/NP42mou/8AXX4iMRVMqcqS9sA1w8tg2s43DtZHAZUkc0Vt33QvIvygRMJ907O2KQL/rXFb1hesGRIkXQavyfVI6bBv5Z6I3cIn51MXdEgj8RdB8mdbC8TKs/PYF0MpUN0uRmC+kRAEEsh8iBDVgZ8w/taXByK7ZezMbJMaqxob7f+E+1ssIw9J/hbwE4Nb8z94CdrxGyKQyl4MuS1+KSWMUV81FRDWT8dwLX01RJXGmYaEi1tgT2IYj5W2E+Zapkz1NnZMOpfeLmkGBeGvCD60/b0MGGiV9IK+jwppFhAP59k42SVFZGl+z5EuY/vVUh2Nl6n9v3onQp8zSWkn9o2PVIpvI+eGmSwnOdwvn1+bxUmoovzoY8HA3zJRLNa8b68GB0ug2SrrjXUNFh0azMWh0B+ChIVeSU1sspTrk35Jaf1ZE2IAja6CwgYsKOv2WyKpQgd7muiw+xkQ754P9A7PfhbBLCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(5660300002)(8676002)(8936002)(4326008)(83380400001)(86362001)(38100700002)(41300700001)(85182001)(6512007)(2616005)(122000001)(107886003)(110136005)(76116006)(91956017)(38070700009)(66476007)(66556008)(66946007)(66446008)(64756008)(54906003)(6506007)(316002)(71200400001)(6486002)(966005)(26005)(478600001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWVpUnFEcFphbjlJbktwc3NnUWVzZVduUXV3NFhZdk5PcFVyN2JEOFR4Sk8z?=
 =?utf-8?B?S3FiWFJZUm85VmhxSUg0azlFMk1sbmtuUmFOK1JISTBQQXc4Tmc1Nk9HVVBR?=
 =?utf-8?B?QzRUR2M2STUwMHVlZ0U0WmNrNWZnRThrUzN1QmRxeVFHMjl2aUJZQ0g1OWVx?=
 =?utf-8?B?QnNsdkhQMTZLbE1pYVAxMDk5RlBVcHFOSE9HVlV4UVdNTFpFSDVLbytUVkti?=
 =?utf-8?B?WmhOeGFEMEQ3eTVuTHMrRk5abXpYSlExVWpRUUkwK1EzeVRoWmxnWUNHTlc3?=
 =?utf-8?B?bnVsTE02anpXVWlLR1F1MFl0SUF0QlRhNnlHVSt5SVNlemdGMGJ5bmhKWU0y?=
 =?utf-8?B?K0hyNTEwZSt6TUhTWEY5Y2lWc1dvNzVpcW5sOW9LZGx3cWNQbmNCZFJzaDNH?=
 =?utf-8?B?dkEwYjdJNEZhUzdPb0d1cFlrdDdDYlFkekkxTGFHSi9JZkd5eWM1N2hVaXd3?=
 =?utf-8?B?Wk10Z0NtczRSK0k1TGRPVENpZEFKZEMraTdhS2pGdzM1cXJGaXBGMmRVUFFX?=
 =?utf-8?B?NjlKRVFpeEFEZWZUTHp5QVhPeG1HVVUzL0ZZK1UvenliNWVJY1k0VCtzclpD?=
 =?utf-8?B?cnBZSzFRR1FCcVhTaGxtbWpIYjBRUjM3bERKUHJha0xueEhpeUczdG1WeHNU?=
 =?utf-8?B?a3NlODZFakhjVlFVNVA1b0Fham1kOXdzaTExQ0N4MFZyT0xJeHNGSUR3L2hO?=
 =?utf-8?B?RzNtUGVoTHJxOUcyZFgwRXlJR2FUckNtR1JXZ2tMMUJsWUZXeDliRVFUSUQz?=
 =?utf-8?B?VGZFNFhqMVozVnBpRWNlVTZGZXc0NEE1U2hsV2s2L0cvQk43NnFJdzY0MkR6?=
 =?utf-8?B?TjdVbExhbURNY1cySDNTNWVCMG1vcEo1cU95bkswRVdVSmJUZU4zMENWVTB1?=
 =?utf-8?B?dHJOU21QdXVvcFR6cERqUDl6VVRCalA4eGVNVEUwMWEwL1hzRUhuMlBHTXlx?=
 =?utf-8?B?bXluL2tJZnpzbkszZ1lGL1ZkcHluY0RrZ0lCRzhJUk5Sait3OU54cUJwTGRT?=
 =?utf-8?B?MVRuMHp4cHFvUDdpMUwrTjZmUEtUZ1p1V1drZHh5VnU3c25RekpWSUFhQjJm?=
 =?utf-8?B?YmVwZ240UldaZ3dESlZQMjFaQkVPU0VUNkVFSVFqRzA0M1A1QXcvd2l2c1R1?=
 =?utf-8?B?cFBEbVY3bkVGeVlMSkllZG1uVnRaMndKMGtweGUwYlRGRHBLSkZmaXM5c09y?=
 =?utf-8?B?QnFKOUJ2cFhPekJIRDlYc0pRdWVONlVpOWNYZ01WTEVsdXNKMk5MQkNhSThN?=
 =?utf-8?B?Zmx3blZsaUIrWW95a1h6MkZhZkYzMHozeUFGVmNDdm1QY0lGSW9rcDRCVEZm?=
 =?utf-8?B?ZEtQVUlKaUV6VERrb2RxaktERXVhSUlNR3JtYXlDbWxtNVJjSmdncGNWTzYz?=
 =?utf-8?B?NTN4bERnVnFKL3dwb2RsOVZXcFBqY2trNnBvZHhoSE5nb2xiSUZjS2VzMm1X?=
 =?utf-8?B?OVhDaWJzbDlKNGJvTmtLdVFoQzJLeHZFd1RXRFk4U3JsODJDVFIzN0tJcXlk?=
 =?utf-8?B?eVdra3R1NFNVQjdEQWRxQ29tZUtpQ1VEYnBOaHhnU1Y3czZRNU1RcTYrYU5E?=
 =?utf-8?B?Y1BLZm1CYkQvRHl4T1JYNFV3MDY3UHBMREFrVUxuMnhLN0ZPcDhhSGJyeDdt?=
 =?utf-8?B?L2RNbkJpWkd6ZkkzdkFxUS9veXJka1BjWTRKcWM0QStZM0crMFE0WWJBTnhm?=
 =?utf-8?B?T3hEcCsvZlVxV1cwcU82WTVLR0RzT3ZqWG15THc0Q292SXMwVFFvTUZqdmZN?=
 =?utf-8?B?VEwxOXd4czg3NVlpQ3hVZlRHZm0wYmV6aUswV2xDU0owWmRad3ZaeFJUcDdi?=
 =?utf-8?B?ajJZZ0t2anpRSUk2Ym5CNVNVeTlMR3l0NG9lSEFnNWZNcHFxWG96RGNuY1lx?=
 =?utf-8?B?ZWc5RnRvcURxemZsMTZwSDl0YmtFTDc0ajFWYmRndmk3VzYvTm9yclhEaCt5?=
 =?utf-8?B?by9IYWNUNXJKTHAzNXl4U2Z2V1JGSnEzemhnK3ZPQ1lFeGN0RVpjdW9OK1Ux?=
 =?utf-8?B?YUIwRU9QOHdxRWJvUVBvWGJnZ1BiVUJnMjFlcFFiSFNITlQ3VU5GdW5qbmpu?=
 =?utf-8?B?elg5THhXT0FaUUpxS0lYZEJtdTJIYkdBY0tFeWZnWjdGd09xN0hjMERjZGZr?=
 =?utf-8?Q?BL4QvVCxhvsQsBHAau3d5xEiT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <045B957A5064A74C95C721138719A5A0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716b0038-0fff-40d8-f917-08dbe02d6a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 07:36:26.8518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +8yhQ08gZFvXcfU+pB2W79l2VllQ+02mOq/UVoDF0wmo0/y4QvgZItpCpt6XVII3yB+iWnkQ+30CQ4mhNFWXaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6628
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.585200-8.000000
X-TMASE-MatchedRID: Q8pJWSpPf0PUL3YCMmnG4utL5wHKYQ1eUjH7I+o7mhsNcckEPxfz2AVM
	9kPsaYx4sk0hhPV3U0WOMDjZHc3LHeI+D4eDXPKVypeMiaCPnxtKKWJchzA/cX0t14tR/LT04xW
	Kt2T4zoAVQsuS4sAgc67svvUHcjUpXSJ4c3nT+QcZXJLztZviXLLiLKO9VZOiluu3g4Ulmf35WK
	Feqf3EsanR98XAR0WNoXaQ1VGW4+YPRVepDWIjx6OuVibdZNTvgQP483M95wE9uRG0Mbl1332FN
	gn+xn/ZkxZqoEsW6HAQbi0n2beMrJcmBIMGsQL1ngIgpj8eDcDBa6VG2+9jFNQdB5NUNSsi1GcR
	AJRT6POOhzOa6g8KrdZOKGXOxdfYYt6PdWHvS6fXDfyxTYsPQThbiI7yVw+dUqRqeTKok3s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.585200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	1CF1A7D3C0A71407FD5AA8B69CC1C7B22282F1AF84A930F8EAD71A36B009DDA62000:8

T24gVHVlLCAyMDIzLTExLTA3IGF0IDE4OjAxICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gSW4g
Y2FzZSBvZiBiaWcgY2h1bmsgc2VxdWVudGlhbCBJTywgYmlvJ3Mgc2l6ZSBpcyBvZnRlbiBub3Qg
YWxpZ25lZA0KPiB3aXRoDQo+IHRoaXMgcXVldWUncyBtYXggcmVxdWVzdCBzaXplIGJlY2F1c2Ug
b2YgbXVsdGlwYWdlIGJ2ZWMsIHRoZW4gc21hbGwNCj4gc2l6ZWQNCj4gYmlvIGNhbiBiZSBtYWRl
IGJ5IGJpbyBzcGxpdCwgc28gdHJ5IHRvIGFsaWduIGJpbyB3aXRoIG1heCBpbyBzaXplIGlmDQo+
IGl0IGlzbid0IHRoZSBsYXN0IG9uZS4NCj4gDQo+IEVkIFRzYWkgcmVwb3J0ZWQgdGhpcyB3YXkg
aW1wcm92ZXMgNjRNQiByZWFkL3dyaXRlIGJ5ID4gMTUlfjI1JSBpbg0KPiBBbnR1dHUgVjEwIFN0
b3JhZ2UgVGVzdC4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBFZCBUc2FpIDxlZC50c2FpQG1lZGlhdGVr
LmNvbT4NCj4gQ2xvc2VzOiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxvY2sv
MjAyMzEwMjUwOTIyNTUuMjc5MzAtMS1lZC50c2FpQG1lZGlhdGVrLmNvbS8NCj4gU2lnbmVkLW9m
Zi1ieTogTWluZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgYmxvY2svYmlv
LmMgfCA1Nw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9ibG9jay9iaW8uYyBiL2Jsb2NrL2Jpby5jDQo+IGluZGV4IDgxNmQ0MTJjMDZlOS4u
NzQ5YjYyODNkYWI5IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9iaW8uYw0KPiArKysgYi9ibG9jay9i
aW8uYw0KPiBAQCAtMTI5NCw2ICsxMjk0LDQ3IEBAIHN0YXRpYyBpbnQgX19iaW9faW92X2l0ZXJf
Z2V0X3BhZ2VzKHN0cnVjdCBiaW8NCj4gKmJpbywgc3RydWN0IGlvdl9pdGVyICppdGVyKQ0KPiAg
CXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4gKy8qIHNob3VsZCBvbmx5IGJlIGNhbGxlZCBiZWZv
cmUgc3VibWlzc2lvbiAqLw0KPiArc3RhdGljIHZvaWQgYmlvX3NocmluayhzdHJ1Y3QgYmlvICpi
aW8sIHVuc2lnbmVkIGJ5dGVzKQ0KPiArew0KPiArCXVuc2lnbmVkIGludCBzaXplID0gYmlvLT5i
aV9pdGVyLmJpX3NpemU7DQo+ICsJaW50IGlkeDsNCj4gKw0KPiArCWlmIChieXRlcyA+PSBzaXpl
KQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlXQVJOX09OX09OQ0UoYmlvX2ZsYWdnZWQoYmlvLCBC
SU9fQ0xPTkVEKSk7DQo+ICsNCj4gKwlpZHggPSBiaW8tPmJpX3ZjbnQgLSAxOw0KPiArCWJpby0+
YmlfaXRlci5iaV9zaXplIC09IGJ5dGVzOw0KPiArCXdoaWxlIChieXRlcyA+IDApIHsNCj4gKwkJ
c3RydWN0IGJpb192ZWMgKmJ2ID0gJmJpby0+YmlfaW9fdmVjW2lkeF07DQo+ICsJCXVuc2lnbmVk
IGludCBsZW4gPSBtaW5fdCh1bnNpZ25lZCwgYnYtPmJ2X2xlbiwgYnl0ZXMpOw0KPiArDQo+ICsJ
CWJ5dGVzIC09IGxlbjsNCj4gKwkJYnYtPmJ2X2xlbiAtPSBsZW47DQo+ICsJCWlmICghYnYtPmJ2
X2xlbikgew0KPiArCQkJYmlvX3JlbGVhc2VfcGFnZShiaW8sIGJ2LT5idl9wYWdlKTsNCj4gKwkJ
CWlkeC0tOw0KPiArCQl9DQo+ICsJfQ0KPiArCVdBUk5fT05fT05DRShpZHggPCAwKTsNCj4gKwli
aW8tPmJpX3ZjbnQgPSBpZHggKyAxOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdW5zaWduZWQgYmlv
X2FsaWduX3dpdGhfaW9fc2l6ZShzdHJ1Y3QgYmlvICpiaW8pDQo+ICt7DQo+ICsJc3RydWN0IHJl
cXVlc3RfcXVldWUgKnEgPSBiZGV2X2dldF9xdWV1ZShiaW8tPmJpX2JkZXYpOw0KPiArCXVuc2ln
bmVkIGludCBzaXplID0gYmlvLT5iaV9pdGVyLmJpX3NpemU7DQo+ICsJdW5zaWduZWQgaW50IHRy
aW0gPSBzaXplICYgKChxdWV1ZV9tYXhfc2VjdG9ycyhxKSA8PCA5KSAtIDEpOw0KPiArDQo+ICsJ
aWYgKHRyaW0gJiYgdHJpbSAhPSBzaXplKSB7DQo+ICsJCWJpb19zaHJpbmsoYmlvLCB0cmltKTsN
Cj4gKwkJcmV0dXJuIHRyaW07DQo+ICsJfQ0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICAv
KioNCj4gICAqIGJpb19pb3ZfaXRlcl9nZXRfcGFnZXMgLSBhZGQgdXNlciBvciBrZXJuZWwgcGFn
ZXMgdG8gYSBiaW8NCj4gICAqIEBiaW86IGJpbyB0byBhZGQgcGFnZXMgdG8NCj4gQEAgLTEzMzMs
NiArMTM3NCwyMiBAQCBpbnQgYmlvX2lvdl9pdGVyX2dldF9wYWdlcyhzdHJ1Y3QgYmlvICpiaW8s
DQo+IHN0cnVjdCBpb3ZfaXRlciAqaXRlcikNCj4gIAkJcmV0ID0gX19iaW9faW92X2l0ZXJfZ2V0
X3BhZ2VzKGJpbywgaXRlcik7DQo+ICAJfSB3aGlsZSAoIXJldCAmJiBpb3ZfaXRlcl9jb3VudChp
dGVyKSAmJiAhYmlvX2Z1bGwoYmlvLCAwKSk7DQo+ICANCj4gKw0KPiArCS8qDQo+ICsJICogSWYg
d2Ugc3RpbGwgaGF2ZSBkYXRhIGFuZCBiaW8gaXMgZnVsbCwgdGhpcyBiaW8gc2l6ZSBtYXkgbm90
DQo+IGJlDQo+ICsJICogYWxpZ25lZCB3aXRoIG1heCBpbyBzaXplLCBzbWFsbCBiaW8gY2FuIGJl
IGNhdXNlZCBieSBzcGxpdCwNCj4gdHJ5DQo+ICsJICogdG8gYXZvaWQgdGhpcyBzaXR1YXRpb24g
YnkgYWxpZ25pbmcgYmlvIHdpdGggbWF4IGlvIHNpemUuDQo+ICsJICoNCj4gKwkgKiBCaWcgY2h1
bmsgb2Ygc2VxdWVudGlhbCBJTyB3b3JrbG9hZCBjYW4gYmVuZWZpdCBmcm9tIHRoaXMNCj4gd2F5
Lg0KPiArCSAqLw0KPiArCWlmICghcmV0ICYmIGlvdl9pdGVyX2NvdW50KGl0ZXIpICYmIGJpby0+
YmlfYmRldiAmJg0KPiArCQkJYmlvX29wKGJpbykgIT0gUkVRX09QX1pPTkVfQVBQRU5EKSB7DQo+
ICsJCXVuc2lnbmVkIHRyaW0gPSBiaW9fYWxpZ25fd2l0aF9pb19zaXplKGJpbyk7DQo+ICsNCj4g
KwkJaWYgKHRyaW0pDQo+ICsJCQlpb3ZfaXRlcl9yZXZlcnQoaXRlciwgdHJpbSk7DQo+ICsJfQ0K
PiArDQo+ICAJcmV0dXJuIGJpby0+YmlfdmNudCA/IDAgOiByZXQ7DQo+ICB9DQo+ICBFWFBPUlRf
U1lNQk9MX0dQTChiaW9faW92X2l0ZXJfZ2V0X3BhZ2VzKTsNCj4gLS0gDQo+IDIuNDEuMA0KDQpU
aGFua3MuIFRoaXMgbG9va3MgZ29vZCB0byBtZS4NCg0KQWNrZWQtYnk6IEVkIFRzYWkgPGVkLnRz
YWlAbWVkaWF0ZWsuY29tPg0KDQotLQ0KQmVzdCBSZWdhcmRzLA0KRWQgVHNhaQ0KDQo=
