Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4093B202C29
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773121414; cv=fail; b=peIo1Cx6M6OsVDX4w8mINaP3U+SaUObfTWc14nHWByBTVUQi3Ggd2waqtv72Ou5pb0ts1/1bqh62GiMqxyBSexbWMlT5mhwQyI/oOOQEQNMYh62HVKD6HTgn8q9aBEV6tT2b9QQ7X3azfIwqThuhxdvP6gbigUXH4qw04nPTlaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773121414; c=relaxed/simple;
	bh=MT72Hk9UKCeqf79hnfp8BzS331ypStbVgzQ08GC0/HQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rdLfRMwfVpcoHXj7sWkmXyNvRn5jNyPYabWpxOsZLOxkAjTUU7dfc5KY8GI1EdwXpz+m56lt4/utEfQrxx9loqpQxRLw5Hnjz6wK6xiTLEm0QaXIYWZNcp+83M2QxhanqmC1zU1EkXoGGcN+AsZ1lx3z4mLh660aflgMJrYZCvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JTlvV/wc; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JTlvV/wc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKBUNSHyYFzg7W7klwYpDISfHK0GOIohq/TvYnHRgCt+NNPIb8lrHZN6ab3xsTr/LZBSHkbcgj3pRc4ci06sw989bKTPTFClYKUYNzhMhcd1yQsATA9wCRNIVtNaHIVvzjzjm/D0cPX5bjwLrTmfHkdDUyEYEsd9n4QLYYS6WmB6OVWKbpRE9Lqt5xfTvMTYbpXjoGO7T9RbYk82dDofG0vKHYsTGNu32lhYYd9utw1cK076aM1V4q6TLkq5Csbqc3hsjxLAPYFJi27JBipc2CS7K2JLOn0KBxOVzQG0DnaqfdRAp9iRepmPpTiO8sUiuRv0l2L6RnSs7nJ7/scNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MT72Hk9UKCeqf79hnfp8BzS331ypStbVgzQ08GC0/HQ=;
 b=HV8KDglkCfvyJH6XyXkPyJskkBxJoTc+HhIIGiNoxwfZxo2WCqE99ZkwGtZGR3+KZhbzRI3n3TPHhp3TH4kKK0Bv9pHgrKHNdAD40/UuA2ybNcamxeWR0h03wwp492rPp8x2zhLy/z/PbNaNEkzR72eetEnlYzFazVawiVfH9YV5EB36+9nJExl7mBgipIiET15p4b0Yh76xUoRQXyhFKGclJIHTqvIQ5bwMNiqSu9gdSmXn3G+EyJADlrVtXypiWt+Y7CVQ1KguL/pd+oWwBGKql9WgDRuxTB5cVnXmpgkxvM5Gk7AMEOuo9TtFkyTzNHnmGz8lC+T3JYk4QzKVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT72Hk9UKCeqf79hnfp8BzS331ypStbVgzQ08GC0/HQ=;
 b=JTlvV/wcAtncjMHTXoPvg4U4ptT7EuqkyppJKBSWx4s6CGwTljn1mH90GpE/ZLLclgfukVzMKZEpbe748nLGe9av+ksHAAfIlTP3HgC3+pZ3xCJ7eZzuoalcyjH/l2XpEuud7UBG0lBbsiQtqtW9caRVzuU86ysO8yb3UWzjZfZAAm0Vz39kDwqDPGeEsLiJnEboO/8aSWZsNB1pTJ5jwJZtV7YV4WprhI5kmPicdQqaduMBXkhvbc9FVKQz5FvTCC97hsKxUo7i5NqjqyOozUhXrFUS6knzLle9NHjOYfvOTHv4o65UsWu9MLWBblGoyIhc03s8YJLHLiK5igNVgQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 05:43:28 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9678.016; Tue, 10 Mar 2026
 05:43:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "wagi@monom.org" <wagi@monom.org>, Jens Axboe
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 0/2] blk/nvme: fix NULL deref in rq_qos_done_bio() on
 multipath failover
Thread-Topic: [PATCH v2 0/2] blk/nvme: fix NULL deref in rq_qos_done_bio() on
 multipath failover
Thread-Index: AQHcps3TYCjW0+f4UkuBoysH2RLFBrWnVAgA
Date: Tue, 10 Mar 2026 05:43:28 +0000
Message-ID: <f77f9ffc-a989-4dd9-b4f6-443e9ad7e3d8@nvidia.com>
References: <20260226031243.87200-1-kch@nvidia.com>
In-Reply-To: <20260226031243.87200-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7239:EE_
x-ms-office365-filtering-correlation-id: 5071e945-dfd8-4c82-7cbe-08de7e67f4eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 MgpdcqJ4ovTYD6EahooTiEsvA3/JqAj2BJfkBGdYIJ4y/tXt3YKHaXni1c2ppjUAkFJVUOkDeBB6/bKTmkL8VjL/PRVE560gNkW1bg6InPRDRIwUSukDh7qBtgeJ3w1Tkc+VwSFhm09pi+Ze6DFL/OvawxYnySrY/q2AZyIMWv8SsvhnQErpegXib7mg4s2fXSISZZGMyE1HnGElZIWSywvHszxe1SC80iKrtPb0R2u4zUJSR5vx8HPKfUD3om2DMlAt3h5QM2ABiw5HwwZPOki1LSrgSNG5kF72/PcUQdX8QOr47gc8+Jv0jZZFJyfuGeEZs2YmCQkldBN0888gLf3WQUN5z4/b6w4kaQsyQRPBeL6e+mmEodTOibNZWZkT6r0SOMx5jXv5DXauYCirz/mqCBlmWcdgKGm2Nu7PZ3pXLyh7KWN9PRYm0ovyocWoCV2M5RWsVSP+RSAehoNFDMZz3ugtc6u/1gdlrQWYtsV6ED5nI98UlMtZQUJNb8Poj8BOyiDWinQg8bFOl9TCpD4Gbjdui4yGvfCRw4SZXXFSS1KgO85xVzWW6OGW5PUxaJV0jqXxAMOLTzEOgi8bod9bCJBTs5LPs5SEOG6U/Dw31KWjqST+tq75CR2N9o8lLQMqekQNdEBIduRRh95eeqt3X4Be+cBgM83HFCJ6s+sucgatuuwpRfSgJ9jl8ElQAj3NhwJuvUJGeJDyJQr3UZyq9dkl9yD9+WdCOTQhyEYh7xcJMB3xRGz1KAizJt4bPgTTGGQHFEt4rkEGkUA9dtOPAIxqvOzkN+SLKPZkxqM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym02bTVhS2dEZXFjS0xuV2dlSGlNc0tyaTJDRHR6aGJNa3pqYXBzeEVZelR3?=
 =?utf-8?B?MWdiSWlxbEVhVmcxcnlUQldFUldtY0ppOGNlWUJLQ2xIZ3BwZm1BY0FlMEhQ?=
 =?utf-8?B?dnI3SVNoTGZkUXVyWjM4NFhNaFNueUR6cGUyTjV3NFA0WEtqUkpPWVc0b1VW?=
 =?utf-8?B?R2tLSGZrNTR6WkdYanpoS01PY0dzcWhnNTlNdkE3T1Vjc3hqdzhrK2RTejZU?=
 =?utf-8?B?ZSsxZlZtcmhyRnFoQ1UyTS95WWxiUVB3elE4elg3VnphUFhGYUNMWUJBcGxr?=
 =?utf-8?B?RHFEV1ZBZG5ZS0s5MThBSVZyK24wVTg0NHF2elVaZ0E4UFBKbEhtQnRPN1BS?=
 =?utf-8?B?TUdFcG12QTFISXpnUjFwYmJLdTd6WHhpdEtsNFhMeTBYU2xIdFIyZkx6UlVv?=
 =?utf-8?B?dis4TmkzcFFwY05YMW5KMVZ5RHVPbEVselVBR2IrNmJxU0UzWitjcTlwTTNh?=
 =?utf-8?B?S0lTQTVRUjVyYUYrOU1lSTlnaHc2VjlwR0Fmdi9CRDFZTEI4b1R1aUo3cG9U?=
 =?utf-8?B?TTlRQnBoR2dIYkMxRE02clhGc0NJSkpHTFpEd2V1UmQ5U2JWL3BSclVGOUdE?=
 =?utf-8?B?WWRYT2xwc211dlFkemthQWZzN3BJTWFOS3FucVdQL3M0ODdIRm4vUFNzY2tq?=
 =?utf-8?B?WUlBMUtHK2lzalpFem53RUhEQnhkN3BzZWZiYktDVmZCL1BrZk9oV2o4WUdZ?=
 =?utf-8?B?U21acU1yN1dwa2lrMjltd1VsZElKMVpkNm8wWEhuNk9NcEZHcDI5bGN4bElB?=
 =?utf-8?B?VHFJczFIcWZ4cXVCTkdKNzBJMEdOYzVESjg3NE1QQ01FR1o5MUQ3Smh2QUpN?=
 =?utf-8?B?VmRwM2tuRy9lbkltV3Y5QmdwV0RxQUtqSnJtVmQrMS85TGtxaXlhbUJoY2ZD?=
 =?utf-8?B?NFpRRjh3UEtyVDRDUUFtdXZsWTU2WVdNTlFvTUNqOEgwM0Y2UUlNOUNaajJY?=
 =?utf-8?B?bkpiTXcyMndkbEhseE41UmUyaythT3FIY1MvaEpRNzhXZWFsZUhYWENoUHdx?=
 =?utf-8?B?ckFRYlp6TzhFVDlwTHlCSEpsSVdpeHFtdFJjTE5CMG02a1lzY3ZxRDF0VjFy?=
 =?utf-8?B?cnlRcmw1b2cxMjhjWE9XZHZaaDhEYkdrYVRMQmNsWTc3ei9WSHBaV3VyRFpN?=
 =?utf-8?B?ZWVqY3ROZjRlU0hENUs3UEpUKys3c2NOeUdySVpRNnFydzNndllGNE41RGtU?=
 =?utf-8?B?eWZTRUYweDRXS0NvbFQ2YThUcUtNZDhqNmNOaG9NZ2swZWRaK1JiSWgyaDlF?=
 =?utf-8?B?b0hmcURLNkpjT29BNzVTdHh0dEtSdWcwemhMUTF4Uy8xVUxxSlRyNFV4Umhx?=
 =?utf-8?B?R3duU3pDbk4rV0tiSi9NdkdsMnNFT21VSy9ZQXYrNkMrTDdGUVZrWkZxM3FB?=
 =?utf-8?B?K2o5RWJVY1NnWW5iQjZEMnc5MkhSQWpBTUJzTXN2bHV5dzJpNGxIeXNZSUxs?=
 =?utf-8?B?ejRVVWszV1dSV25ZNE1uQ0hkMzV6ZDRBRnd3VStXNlgwYjg4NzRjV2pBdk5P?=
 =?utf-8?B?ZGN5NzBJck9UTjRNNGJPaWI1UkpVQlpWekFLNVo0a2Y1VWhZM2FQYjZkMHdI?=
 =?utf-8?B?Tlg0NGVLNHZ5c0oyK3FiNGp0bUk4Q1o1a1ZVcjI5dE9VdEx2OEYxWEJnYmRk?=
 =?utf-8?B?WlArZlpSdVhNaDF0S1M1SjFYSVRvb3lldmgzTk5sQUsyK2N0Wms0Vnk4SHAz?=
 =?utf-8?B?OWpzNGk5RmRubWhvaTJrdjcvZFRjbG5UOUZiN3lVR1djV2g3dWxUV0hlLytR?=
 =?utf-8?B?TU9oOGg4L0pUNk5senF3RlNnYVpQYUNiczl1L00rK0hsckIwU3BiQzVDSEhC?=
 =?utf-8?B?blh5L1h2cnVrM01pSkc2eTc0UW5iaG5IL1RqOFRWcy9TbkpjcktiNXlxSmZx?=
 =?utf-8?B?U05wY3FpK2hOT2RIT2I0bWlRRVkwSVcrWkFaTURvMFhHOEZwRjFmL0ZMSTRX?=
 =?utf-8?B?N3B4MmlaTzFDWHNsSVlmMGhCRHVxLzZHZ0FVMlQ4em91dC9QUFMxZGtaazNm?=
 =?utf-8?B?dmZoVnRMVHFsejhZQ29ULzVPNjJmYk1SaXFtdHo3ZmhobDVlYjhGaUR5MzRo?=
 =?utf-8?B?djFuRUhQaDFYcmU5Rjl3MjhIeUpoalhYaDJRUHJadENxSG9SWjlpdldwaTBD?=
 =?utf-8?B?NzhLenJYcjdBZHVDdndjQjFGZFBlYkRBNnp5d3BVano4SWxJNSthZUhZMTZ6?=
 =?utf-8?B?SnV6eUtxbXpKcWk2bUt2eUd6S0RNZ0dsV1Y2K2g1aWw0dG13NGd6S083WHlN?=
 =?utf-8?B?eFBGUFdyMlhEMFJWbUEzYmhrSFYwVDBRQUhwbzBWbFRYanF5a3RSVG9OcldF?=
 =?utf-8?B?ODhUSkpJMS9rc0JnOHlBWjVPeGQvc09yeSttcWlPT05pUFpsN2hCUk1OaVc3?=
 =?utf-8?Q?Q/72VUTQjuAjgmSUHZh7pjgHJgdbz/W2AaY8n?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27E82775FFC05643B5AE8F3A56E3D807@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5071e945-dfd8-4c82-7cbe-08de7e67f4eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 05:43:28.8840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/l6UGb2+Jnq+itg9gmlfVZiZVpOgZ7SynZ9vrgAdrijhrMime0pd+jhECraNBoqzXJltEbPBFjA3psfGOZyZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239

T24gMi8yNS8yNiAxOToxMiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBIaSwNCj4NCj4g
V2hlbiBhIGJpbyBpcyBwcm9jZXNzZWQgb24gYSBwYXRoJ3MgcmVxdWVzdCBxdWV1ZSB3aXRoIHJx
X3FvcyBlbmFibGVkLA0KPiBpdCBnZXRzIEJJT19RT1NfVEhST1RUTEVEIG9yIEJJT19RT1NfTUVS
R0VEIGZsYWdzIHNldC4gIER1cmluZyBOVk1lDQo+IG11bHRpcGF0aCBmYWlsb3ZlciwgbnZtZV9m
YWlsb3Zlcl9yZXEoKSByZWRpcmVjdHMgdGhlIGJpbydzIGJpX2JkZXYgdG8NCj4gdGhlIG11bHRp
cGF0aCBoZWFkJ3MgZGlzayB2aWEgYmlvX3NldF9kZXYoKSwgYnV0IHRoZSBCSU9fUU9TIGZsYWdz
IGFyZQ0KPiBsZWZ0IGludGFjdC4NCj4NCj4gVGhpcyBzZXJpZXMgbW92ZXMgYmlvIHF1ZXVlIHRy
YW5zaXRpb24gY29kZSBpbnRvIGJsa19zdGVhbF9iaW9zKCkNCj4gYW5kIGFkZHMgYSBwYXRjaCB0
byBjbGVhcnMgQklPX1FPU19USFJPVFRMRUQgYW5kIEJJT19RT1NfTUVSR0VEIGZsYWdzDQo+IGlu
IGJsa19zdGVhbF9iaW9zKCkuDQo+DQo+IC1jaw0KPg0KPiB2MS0+djIgaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjUxMTI0MDcwMTQyLkdBMTc2MzJAbHN0LmRlLzoNCj4NCj4gKiAgQWRk
IGEgbmV3IHBhdGNoIHRvIG1vdmUgdGhlIGJpbyBmbGFnIGZpeHVwIGxvb3AgZnJvbSBudm1lX2Zh
aWxvdmVyX3JlcSgpDQo+ICAgICBpbnRvIGJsa19zdGVhbF9iaW9zKCkgcmF0aGVyIHRoYW4gYWRk
aW5nIGl0IG9ubHkgaW4gdGhlIE5WTWUgbXVsdGlwYXRoDQo+ICAgICBwYXRoLiAoQ2hyaXN0b3Bo
KQ0KPg0KPiBDaGFpdGFueWEgS3Vsa2FybmkgKDIpOg0KPiAgICBibG9jazogbW92ZSBiaW8gcXVl
dWUtdHJhbnNpdGlvbiBmbGFnIGZpeHVwcyBpbnRvIGJsa19zdGVhbF9iaW9zKCkNCj4gICAgYmxv
Y2s6IGNsZWFyIEJJT19RT1MgZmxhZ3MgaW4gYmxrX3N0ZWFsX2Jpb3MoKQ0KPg0KPiAgIGJsb2Nr
L2Jsay1tcS5jICAgICAgICAgICAgICAgIHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPiAgIGRy
aXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIHwgMTUgKy0tLS0tLS0tLS0tLS0tDQo+ICAgMiBm
aWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4NCkdlbnRs
ZSBwaW5nIG9uIHRoaXMgaG93IHNob3VsZCB3ZSBtZXJnZSBudm1lIG9yIGJsb2NrIHRyZWUgPw0K
DQotY2sNCg0KDQo=
