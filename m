Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647566;
	b=HcjMvxnEwiiI2SKnK1mlU4iBQ4VconwgHYN+KRQFr6sT2pq5W884klb5RVXeczQLpP3c
	 IO2bdrCy/i6BxEIsn66KDedq5hyzLh8EjYoPeb7GsDCl+Ml/TLyypqyzTse7wk58dTSYY
	 cywlVQ3/ww5lCoiTYIKZNdyie355o6GRbMrsGUHgYIVt7gShIn1Kua3xl0USacROTgd2y
	 cs7Ez0Ziw6NF5/IdubiHNbQgdSbkJzVQyS39t3oBEmGi8QPGn6SwXvLXjAdx+rONzPDdC
	 kMxuuk6lceKON/d/U3rIA4AakYH8zMk7OQcGueXy43f441uiTCD9A7vPPrDgiJz1sUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647566;
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
	bh=Qgnwlvjb98wHe/Jt4ADnFhID0Mg8+R5mYXbpL4UvaCY=;
	b=GgBqtXBy8vXb8QAgQ3kC8jotH0pXPhRU8Bs8AwIp2+AgoOo+AtdCv5/aSvT9XCXXqnQV
	 i0wS4nVcNooNdtoY0IMTtdZGhfOT0CGBnR6i7CIuuFByt6leIXiIA7JAod1N7qyrX3EmV
	 djD6C8e3MzFC/kq+BbEZBKT1WgjUJTR/WU5SJMhClK1T7CBf/XgRyORhNzIqNkJAuum2j
	 xWnEt3nfKTACESHqb4I4U85DB6WardKnmSdS1Fe/sJbi/2LRGtzf0iIe6PQ4bKjY9c0Ls
	 0E0F2iwi4lF+hLtdABR0GrPsyDKoFMKaiw0dcVOalbZLFoEWIdlBE3yUGPuh801zA/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OALEV5ze;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.71
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393A606A33D
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 22:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D393A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OALEV5ze
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV6nRmfdMd41nCqaiYDOqJXEu8HVKOp+f74RiBAgFRpyBFClIDYRa/POy+Y7Z7DIRlXQdACth+sm4wLTccG3/Z7rrNJ4AcEQPYPYJmjlqLBTeUGR9SeWpyvuJ4GkKa/yg9XH8GMCUfGDis5mhrz/vxOj4gQgXY5VtmF3aqR/9jM3PqKUsX+8EUZTBMg3J30e4haYiAm7rxz+ApRuUPX84Sfdy5qEWd0yDSRZGdtcIibwwJmGwgrNXbJP0gwsVxgO/i26xWNJrxfQ3Qd4vyB8qP3ND7X5xlsxmf7tjrO9xhJ5AT6oogasTVYWtLwFH17Dy0N6xH9dC8K+Uf/cqa3yhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qgnwlvjb98wHe/Jt4ADnFhID0Mg8+R5mYXbpL4UvaCY=;
 b=Fq5G6nqTCSwF/an8NaQQfnRQOL0mofWeGCE32cWSROVBu5UDz/HrzjO93unhOpl9MDb7sa6x9FDKaKP95cGpajOW5391S36ayuTVf33pa15zNNJNTWeq7yUvU2UyZbo7+tdsYHGFDc2zkpMvPP6a18IILjp4OwquWkJ3VL+F6gt2oWdxXxwZQzP8cC2CPuN6lanGQCWEi1RDbrKS24giD3SbNA7EV6PtI/zfqHpvh9QK9xWYCkD4ukazPPScXnIiRCEr57PicUKT/2fRCyUMQw9aBmzpOYnlDeAAJZba/FUIW0QhhWxEu12cAYYlJdD8f+vFZjVLnV7KtcfCSu5VlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qgnwlvjb98wHe/Jt4ADnFhID0Mg8+R5mYXbpL4UvaCY=;
 b=OALEV5zeDv04RCs1/n18T6k8NKPhhOe7pyyimpbzAXbWjAv+oIgMe5kRp9MKqlRQoEoaKsnSq6NV6BUh5ROnJPhdFT1Jo3WPPYnODgJ7XGbUI4jYOn8zYIwAH4J1eU/6H3o7+1Np1+1EOeWMdFhy6I5zAR+SrrAxHD9FkrD+PXxGG0SJKJSYtM86tE1fpBl8OjjFbdZR8JndjCO+DH53lP0LhYj8s77ZcdDX9yKq1jvKcZ5va0OnKPNM5HH8bKDc7t7ea8Et6LWb2SKqidGJY7eH7NYJuebai9gspaHcfedpgcjPpmV8vThK1Fxh8Ift2OVsNhdsRmBuDbDoiEbXTw==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by IA4PR12MB590810.namprd12.prod.outlook.com (2603:10b6:207:10f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 22:58:18 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 22:58:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel
	<cassel@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/5] blktrace: add blktrace ABI compatibility check test
Thread-Topic: [PATCH 1/5] blktrace: add blktrace ABI compatibility check test
Thread-Index: AQHdfBrKOKjJOol2N0+d/1+MJJcEwrc/aLYA
Date: Wed, 25 Nov 2026 22:58:18 +0000
Message-ID: <685512cd-08f3-4ed1-ac2b-61216b098439@nvidia.com>
References: <20261124135016.153657-1-johannes.thumshirn@wdc.com>
 <20261124135016.153657-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20261124135016.153657-2-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|IA4PR12MB590810:EE_
x-ms-office365-filtering-correlation-id: 3711e858-58fa-43a0-4c7a-08df4b479880
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|10067099003|56012099006|11063799006|261026140227099003|261022105027099003|261028144727099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 kxwBDb8wm7jU/c2P3xYu75ODv1kSrCU3adfHFUJj9rnnVkxoXweo1x6z1WQe6wzYsIiC+JadCNdycfGBdUPQf3OLILSzrmWpUP7tqyz52S4mq2ifLkAS85wmudjGd/7TmkqyGZLqHoxV01dDH/sBO+2gAxnUsQ5Ef9Y1DdZBaO9WKEna/56kxqkcFSXngH0UEBH4FZLm5cROqMs7aADw71M/OMLE9c0QSEkOjhVEkY0SZRAlO4YPKDEsKBqL4rqti9ttIGBYyEN9+c04DvoVyb17uZO2bYQEhwLyfZwntyEYCGtivBEeiUfhiTDh8OTQsKyKIHSl5OZ4gghfrvhdnyjBl+l2evGSoysP5EROUm9/lwmOFcpExvYq8TZ2zOoVVNXIbMaAdPBaMwWkx8WZfswR7g7h37QNB+8dcnHZaggNOSa1P/W6BNCfA3fo9YpoDQA30hpR5vF8lOa+YhX6R7TxoV+wlLc723VG9kIheYU1idIgLgEs5+bP9r1kepBxZ1qt57DodH5uYX4E13rBYjiO1I+Cdm5g+aID/s1ntErULsYJaczr8M2ic3YngN8apQcFnpwDFJydb8syamWRuEdq6ewDy9BVv/dtrpdoCxzd4Gw0t7XlYwGL918TC1GOT2j3nTKGPxr2miWKaeN6vU9QRjR5dixsBCW7fzIg1OSmTOROdE4Eh4BGYX+pq8NZyMB/rl8w8z0mc+GNPgAbbCtcg46uz+gG0t+B/ZZnqAI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(261026140227099003)(261022105027099003)(261028144727099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXRNb2ljQVk1a1o5ZkVEMkNOM0szY3ZYN2RKd2RFQjdzYkpHbEJZWllSaXB2?=
 =?utf-8?B?blExTy9teFllZVpCQlBzU2hPN2ZoY1BrSkhiOTc1N2hsQk9vZmZIeHNXYk9j?=
 =?utf-8?B?T2swOWVYV1FVUmJGQThNeGZYZ2thQ1RsQTRjVG1PbXdPZmJBVVNMR1JuWnd3?=
 =?utf-8?B?NzVyTmRhM0l1SUI1V1ZxdDBQZXRxQTJac2RrcVZ4ZDVUazBKN0FEMHl3L1lt?=
 =?utf-8?B?a0x5aGx1TjhKRlpsWHlFcGFzYUhvTFJuM3VqMHMxTnY5Wi9BVUF2NTF2cFFw?=
 =?utf-8?B?d2xuNWZtc3RSK2NSRFlkMUtvdTJ6YkErMS9XSllqbFZFYkZpQnVSUEFoZ0hV?=
 =?utf-8?B?RTdKY3JVT2RMUitSTURnZ2hQb1BKZ09teWV0WW1YNnhuSGlGSXVaMkRhNHgv?=
 =?utf-8?B?cFdDamFrVUV2YVptZWVBRFJiMUM1YjVzTUlManV1T0cyTzloQmZ0VFpUeWRN?=
 =?utf-8?B?eEtPY1RmYVZMQ2hVdkFtMFUyd2dwNDUrMVIycm1PLzBTNVhPTFMwaWcxVmJs?=
 =?utf-8?B?RnhXbzJvRDByM0NXWnpRTHVXdVVhZzNQYnpxNURnQ1V0NXBPUUVCbXk4cEdD?=
 =?utf-8?B?Yis0MEZycFdBM0NrMTQ2WXpMQ2Nwb0pGRVZoNS92NzV6Q1JNNHQ1aWU2VDRS?=
 =?utf-8?B?TE1RalNQaGhLdVF5NHFITW1hZEtET2xldk9NL0IzakZlY3llWGllZzdvdFJj?=
 =?utf-8?B?bGtiUUlGbTI2R2l2SUpoYXFNYXF3Y2dRK2dMZ2o1OUhpcUZleXUyNWZLdW9k?=
 =?utf-8?B?Zlhqb0Z6elFadEhVTjJlTDBUczd0Y3lSamFPWnR1b2IzTFowRTNDL3BNTTR6?=
 =?utf-8?B?REREbnRSY3RDRmdlekVTSHlYR0JUdVRQUFFRQjRPTGFJZ0d5WjZNanIxWktY?=
 =?utf-8?B?ZlY5MGNiUE9zN29YbitFelExL2NFRnZ2dVhRMW1UZjhkMVFIQ1htWmFNTm94?=
 =?utf-8?B?Mnp4MU5BVzdTdkYyYWhnOGVLSE1sV2tFcHFJSHY0Rkp0RWU1TU1Dc0dibDhT?=
 =?utf-8?B?UEk1ZG00WDNkcGZJTWwwT3JHSjg0cDArZmJUMTZCbUMvekhBV1MzOVFZWC9C?=
 =?utf-8?B?MWJENDhGQUVKSnBvWjgzcGh0VHo5TVpmcStVa1pnejZFbTdjaURvZXVWVmRy?=
 =?utf-8?B?azNUSHphUW9zcy9kaGN5dlpaUXQ2OFk4YTM5SjhsTWsvYTNOVUVLM0ZBRFNH?=
 =?utf-8?B?KzU2WXhRUzRVc29JbUdYMytHVTJab05zWmpxN1lhVFBUb3lZc1F0UXVZeno5?=
 =?utf-8?B?S2c1VGM4S0ZpVTNLMTgvZGIxVlRyQXJhVDVvNTIySWdXbUsvazlIQ1phTFdY?=
 =?utf-8?B?QjVoVk8wZDZ1bHNWdm5EMkpTMllrcjl4bUt6WjcyWFJVQU9WVTF1UVJkc04w?=
 =?utf-8?B?eElsOTgxajFrbWlRTXdiR3l1SHpxZEl3QjB5azdReDBJQjRFTFdMd3U2Q2JH?=
 =?utf-8?B?SitRSTZMVjlFa0dldVNZL28xcHlpZWRnanY3UGdQRUw2TmI4Ui9ZR3NKSXNH?=
 =?utf-8?B?SCt3RjRFUXVuRXVwc2RaNVE1em1pT3duT3R0OUYzMWFSQUZjdjExK2ZqdFp6?=
 =?utf-8?B?Z3JKWXljZnRNWndGQ0pQdFdXaXBIRkJDUXJNMFhZM1c3QWw0RHVrZlk5U0VD?=
 =?utf-8?B?ZmlteXY4Nnh3bEhrOFNha1NHM0xnYmFyaXpwcHhyeHM3ekZHU01DY0hZSTA5?=
 =?utf-8?B?dVo5T1UwUWxiWU9hZTRVeTRJc2pEUnFQN2V1MXdDWUJpSVZWWmV3K3ZhSWoy?=
 =?utf-8?B?K1ZtN2U0VW40RXl0MzRnQ3dYTnZzbEJ5KzArVGh5Z2IxcG03Q0RrUGJCUEht?=
 =?utf-8?B?Qnh2TVZYZlRkOHlPeFlyTGh1MkY1SXRUUDFvUzRybXMxcjF5NTk3MUlsdjBw?=
 =?utf-8?B?VkJTMlB0N1BzZ1lNYS9MWlVMbi9TbitzemVzVHNDM2lCQVRaNDFMTXdmanNt?=
 =?utf-8?B?endQSFBVbEJSa3k5ZWNaVmlUVEVmeFA1NE5ONGc1VWt6clJOUm5iQmtxR0Ew?=
 =?utf-8?B?UnJqSDluaFh4anZ1N2wvbXI0elZqWVNTc3hEVHNJNzVsb1l1K25IeVVVWWFV?=
 =?utf-8?B?eVdyZjRuRE5sRGptdWJKV2h2QVRkRCt0V0hLdWlYU1M2WkNIaVlvbEZFYTY3?=
 =?utf-8?B?NktYOVg5akxOOFhSZkNoamFyNXJxeDVoMTA3VE9lK3BSTGxUekc3R08xRnBp?=
 =?utf-8?B?Y1hqR0taZG1PRythenhkZjFGd2t4alNtWVh2aXpqTnFJenRlNTQxQVJXYlBH?=
 =?utf-8?B?T28yVm5CeDhMU2FUL0F0bzhQeU0rUmJIVG4yMFhTWFJDdzBOUnE2NHJzRmh4?=
 =?utf-8?B?WitCbGhFTE5qYjNyR2FYM0phZndBVWpOckFNamluY3NrV2dUTjhQZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB47C62FA73FE44B968162735245D77D@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3711e858-58fa-43a0-4c7a-08df4b479880
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 22:58:18.2802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aInQ98w06jMxsFUGIHYBm7+LGd9e0PUVJd0e6Wf7F//KXRBRq5NmNoo4XYrguyzmDI58MCeDv0ISfaP5EY17tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB590810

T24gMTEvMjQvMjYgNTo1MCBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBDaGVjayB0
aGUgQkxLVFJBQ0VTRVRVUDIgZmxhZ3MgQUJJOiBCTEtUUkFDRV9GTEFHX0lPUFJJTyBpcyBhY2Nl
cHRlZCwNCj4gdW5rbm93biBmbGFnIGJpdHMgYXJlIHN0aWxsIHJlamVjdGVkIHdpdGggLUVJTlZB
TCBhbmQgdGhlIGV4aXN0aW5nIHYxDQo+IGFuZCB2MiBzZXR1cHMgd2l0aG91dCBmbGFncyBrZWVw
IHdvcmtpbmcuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybjxqb2hhbm5l
cy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K
