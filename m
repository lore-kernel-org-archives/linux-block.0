Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31183D393
	for <linux-block@vger.kernel.org>; Tue,  9 Jan 2024 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eafZpLP1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJzSnxXaXc/Mx7Q9ch2/246iyXuf7ju0OlATXRmXPiLCZgwc4qIzK5ROssOE12/zV9soAxGFmim+DwG9qo6AGXNCnDvkISln4aezwD2pl6WlhMdGuNhIs1wgcdqRyWCWnmrPar2PXU/ToX8Nbj5Wc/3CZn6n3EMUlJsOSoSBW6XxCPwANn67B2jOyU4Hvy/HZYAMMAVdfHxQLy1nv3fUiS1qLG74ip81OYDoo/rK/y1cix3OFMnWX3rwze6+W6DMganArYtxFEKSF0wo/Etgw+HUJ4itSunnI4bbInXvKVDC17LN0nNEtgS1FGFuO7+daD7jpp3Ifa0wThhdtrrACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8f3la5u4Yo+QFAAtgoB4jjK/Sp0v2P2lX+SIVLHVlok=;
 b=j3FzU/34cjZdM5qwe3fVsb1SP9y2jQv1dIh3+t32LBtNvdmOrdRqcxsUzcwSnX2STjQpubG3uGrbtXke5LT56IL+MbXDFiQevO9DgMrfoL79pord1lRC6OULjChdHIEMvZKPmn2jz4hP+n4REmzfr67KHMQrQHEuzjB0E/jLHqHAxnGcpXK1R8c0bEA2T3Od53V5kQwnrsEVWagp+mu9bwTsTyIeNudwjcWkW6ueKrME6HU6f23Z4lfZsQBJ4CfHoA7W+je044Pef8vJK7ZlJNrPMhkWPNcs+WXoCROTrvhgZSiYCxqWwD0/GpKUIUSQkqOBqI7Gy7gMcnG/PnkG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f3la5u4Yo+QFAAtgoB4jjK/Sp0v2P2lX+SIVLHVlok=;
 b=eafZpLP15jTTnRMk+ksDd+6y6bL3EyiqX7XPvG/t2i5nHerNhIgv5zb/N+yAy3nLmAQZRQK9n8aN/OWZS9zHsCkXjBuRvuKD/Kny2W7wTiE/fTZqQ0ZinOXApHN6WRrxetex/PWYMlFehk8gisU80HCiAbBter3z4YeBTgDzJ1oJxEGBO1zSALbOkKOXWpJPxQJffzMlIKwOJbTP8NoMChD/FpRq7pqGYHieiYMqhtFZEf8crEyVtPR7aCWlX1PKa37j5IErYD857TU9ie+3j6bpOcyAgPuVAipyyIT/itO0KFh4J0aybo4FxGB9ui/93spZvJiAO3YI7IOAte6tbA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 19:34:49 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 19:34:49 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 2/2] block/031: allow to run with built-in
 null_blk driver
Thread-Topic: [PATCH blktests v2 2/2] block/031: allow to run with built-in
 null_blk driver
Thread-Index: AQHaQuj7yAx4awNVlUumGz7Jdkm18LDR3/+A
Date: Tue, 9 Jan 2024 19:34:49 +0000
Message-ID: <faea1bbb-cf01-455e-9986-3bbe2391d5f8@nvidia.com>
References: <20240109104453.3764096-1-shinichiro.kawasaki@wdc.com>
 <20240109104453.3764096-3-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240109104453.3764096-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB8644:EE_
x-ms-office365-filtering-correlation-id: 904dbd19-3457-4b31-040e-08dc114a0b67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DKzisP8oJOwsJ7W2MRZUZWeTW3Afh9b4736imwkCSvjZxFQy+99lgbSG4A0HFF8O+/IDyi8L8J+uP5hWcwiT//p4SsZDbyg6Y8iyV/WjQzEncUYqZl9bG0YDoE+GGWgLpdN6dtZlknaPOPHevkMVzbHqUGJuoqfDTaPr4UY75ETqfgUu2XfPGyxDyqM4GwHcfCZ201pl2LwPsZlN7yI7F62142HzyKKxhGc5fcirGKa+DDpZfonjBW0Urd8FkyZy6vPlqvnUBHFsTc6p+oVHv8eTKzrt9SRGdvj3ARcsb0MLuBQOrPdz7YN8U3G3W8VctwIR/06T98zkjxlVnRgMaA8XmkLc8sogycpVSdMoqDLG3oSIahRysNwP0ewUaI6pFeF4Tg21wZijUWOOrwtG6bROn0/f40q1H7EaQ++j2xayqqaUC5bOZJALcU6d5WroaTR1Q53iz4iqAVf2gpnd1VKrtQL8CPh69r8wmtBrvPRxl08QFWGsLePdl/6uAnGeODdHfEq3e6Zi0X8Vp2musFvveyipSLrHrRTE4E5sNcC2D2QAb1EODFlX1ILDe7CqqfHu5RHyKy3Xdq2nak7sf/qjofW8tquSR5M/Fc1RikYmUh8jJ7rWPGHvtkLHscrsj4MxkTXfqjjGz/vvNICnVxtQzhH/MKUlwo0IAcmHN8vB3eeKxX1PcyxBH0Ni7uVo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(316002)(6512007)(53546011)(2616005)(26005)(122000001)(38100700002)(8936002)(8676002)(5660300002)(2906002)(478600001)(6486002)(6506007)(71200400001)(64756008)(66446008)(66476007)(66556008)(110136005)(66946007)(91956017)(76116006)(41300700001)(36756003)(31696002)(38070700009)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0IvenRkbjhyeVNqMUdTbDFQK2ZIcjBmRWxVTWtnT1NPcmt5U2kweGxpS3cx?=
 =?utf-8?B?Z0xzQjVFNUlGY3BXRm9Ha0FlYzJRZC9YakorZ21waFIxNWpKa2hCQllaRzBm?=
 =?utf-8?B?WkJSeWFsRUl3OU1EL0tjc2E3YmFBWlhpekU5QzFHM3BldDNmOHR4aGhEL09a?=
 =?utf-8?B?ZjE1LzlTSVlOdFRHTG1jSzNrZGlwVVdpV2lyTVNqZlNPek9MMmlTbmRJam1L?=
 =?utf-8?B?anBIZGhiUzV1T1ZqTVY5YU9IRkY1MmQ1RGNtQUlQN0N6YVdrVjFpdVREZldP?=
 =?utf-8?B?bUpYL1RRMjdxYUFpTGIxVS94aXNkNlNrYXRRRVd1TlVWbzgxNVZnRDdCL09m?=
 =?utf-8?B?V2FwR0tCWmphTW9mSi9iU2xZWlBtc3dOeUlJWHRWa2hXTE9VVHNQWVVPQ3Yv?=
 =?utf-8?B?aTJ1R2J5SG1XRnJoRS9EeTcxaHhucm1pMUgybGJkNyswcUhzMHFKaHk4enJt?=
 =?utf-8?B?MzNkQ2ViZEZ6SkxaOENIeFJPdUhjUTUyNHhjeWNKUVp1YzNmeEpvbmoySjlP?=
 =?utf-8?B?N242eTRJaTgxTkRYZlFmckFHZStzcEw2OEp4ekRFT1lsZ1FYUWtrRjZLOVY2?=
 =?utf-8?B?K2NQakpvZmJOT0M2NEI2NW55R292NEZybkljMDZYTExBYmVmYkZSMTRFOHVQ?=
 =?utf-8?B?dW5PalNUSEdGQXp6S01OMnhmdkllQ3R5T0pENUpYQXhzY3pmdk9ITmJYUkhy?=
 =?utf-8?B?NFZ2ajYrNFBSdDJuNzdsZ1ZqQ1VsRXhiL2dGd3Q0cXJ4RWpKQUt2M0F5djZF?=
 =?utf-8?B?TWNoRWJ3Z0NVMCtDMXlyNTc5a21OTWZzY2syMUxzdHBpNnF5bHBrTFA3U0Ir?=
 =?utf-8?B?ejFpOXlmUGV6NUNUWitQaXZuZkMweWlkSVd6VkU0UWtrRUtpQjFSMjBVMkZh?=
 =?utf-8?B?Mjg3eFBvMXU5bDhOeGtkaWF6V2lJcHdXdFgyZmJJYktOMWNWQkZvalJHY2E3?=
 =?utf-8?B?T21EaFZpY2ZZaFhqbnRuamN5L1ZSTWl0VS9pWkwxNVZxWnJiR21iUFgxOXh0?=
 =?utf-8?B?bUNmT3FKK1JkWGVOTUY3bmV1QVB0LzBxQ2VYK2ZtOFNrM2tiZ0VwaWp2d2J2?=
 =?utf-8?B?UjdHQWR0QlhvaVZpWXFLeXFOMGNEYW4wQ1BJUVBVNnJBRytNVGpNbWJXVXl1?=
 =?utf-8?B?UWtNK21kTXdyNUF4OUtqRGkyRmhzcHFUekF0ckU1Y2tBMUtoSFNZSWtLUEU0?=
 =?utf-8?B?c2hSMWhCbVdvVUg3bGRIWjBTQnUvZGxOamV2WVVYcWNEbEFLaEtmVlJRWGlR?=
 =?utf-8?B?OUx3R01PM3RqNlBvbUFpb3VVWUdvaE0yQnA3RDJ0YlpGbnJ6dlo5Zk1SVE5X?=
 =?utf-8?B?eXFuYUtzS2NlREVsNjNOdnBBc1pqdFNiVURJeEJTZlNJcTZic0oxYkVkWWtY?=
 =?utf-8?B?WVQwdjlFdGZOMlpZZmxJeHNhRDF3a25HcUpyQ2w0MzdPam94V1RVUWJNNHJx?=
 =?utf-8?B?NFBBdWIxYmpYckUzRFpYMUVJTU5sVHN3clFOMEJCSXBzNXlkNCtMVElnUlZw?=
 =?utf-8?B?TDRjWHV5OG1GdUw4K1d5b3FEbHJQYS8zbDFSSXlKSS9DSEdVdUVOQzdVdWhr?=
 =?utf-8?B?SWcwcFRDd0RWazlsUGR5Qlc1UU9QcnU4VGNpdmhSeGJGd08rbC9aMFZkY3Z6?=
 =?utf-8?B?VFFLSCs3N1hOaXVTV2JMcFpMSGVtK3Z3OTEzQjJjWnVFcE1rWHJEeHJ4djNv?=
 =?utf-8?B?RlZaZ21UakY5dXZicSt3eUs3VU5YaGprTUY5Z3BycnpOTEt2b2Q5ZXBNUEVG?=
 =?utf-8?B?YUpqTVJ6NWI5TERwZVJmKzFkdExLd0I3akVRSDlSZCszRmdOakUvT2dQYVo1?=
 =?utf-8?B?MWJJNjFYZFZXTnBadFZvWHRCSmZFQjI2ZFQ5dUZMaVRCMGpVYk1odUJ2eTZa?=
 =?utf-8?B?ejd1bUVxbytWNlgzUlR3ckpsc1c4OFVWY3JqNkV0R3BCR1dXY1ZIRFJPL21B?=
 =?utf-8?B?OFhacFVjQmpVZHM2RUlRcmxORTRzL2g3UndzVG1BckNSUElQWXc5YjM1VlR3?=
 =?utf-8?B?ak5BTDFsRVVJSVVFUkZYVFJvOE9ZTktRMHpxMFVXVDZBN01Uc3VwTEZsZ2NV?=
 =?utf-8?B?cGNPVkc5cW42bjZ4V0txSHdDSlg5MXNNQk5aMmJpaEtOZXkyZHdzNmxYWEpK?=
 =?utf-8?Q?Tbl+gIISOLlTlF2P/2KIxTagB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F005BDA0152664487025A2D290FE49C@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 904dbd19-3457-4b31-040e-08dc114a0b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 19:34:49.6091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hzO0zE+VMKDP6QaXqV4dwtJ2EEvFObJkw/pBE+aePKHgp1dHBUwyEeliNhoStxeA1jmJDh5Rg9WiGwXwo2ym0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644

T24gMS85LzI0IDAyOjQ0LCBTaGluJ2ljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gVGhlIHRlc3Qg
Y2FzZSBibG9jay8wMzEgc2V0cyBudWxsX2JsayBwYXJhbWV0ZXIgc2hhcmVkX3RhZ19iaXRtYXA9
MSBmb3INCj4gdGVzdGluZy4gVGhlIHBhcmFtZXRlciBoYXMgYmVlbiBzZXQgYXMgYSBtb2R1bGUg
cGFyYW1ldGVyIHRoZW4gbnVsbF9ibGsNCj4gZHJpdmVyIG11c3QgYmUgbG9hZGFibGUuIEhvd2V2
ZXIsIG51bGxfYmxrIGFsbG93cyB0byBzZXQNCj4gc2hhcmVkX3RhZ19iaXRtYXAgYXMgYSBjb25m
aWdmcyBwYXJhbWV0ZXIgc2luY2UgdGhlIGtlcm5lbCBjb21taXQNCj4gNzAxMmVlZjUyMGNiICgi
bnVsbF9ibGs6IGFkZCBjb25maWdmcyB2YXJpYWJsZXMgZm9yIDIgb3B0aW9ucyIpLiBUaGVuDQo+
IHRoZSB0ZXN0IGNhc2Ugbm93IGNhbiBiZSBydW4gd2l0aCBidWlsdC1pbiBudWxsX2JsayBkcml2
ZXIgYnkgc3BlY2lmeWluZw0KPiBzaGFyZWRfdGFnX2JpdG1hcCB0aHJvdWdoIGNvbmZpZ2ZzLg0K
Pg0KPiBNb2RpZnkgdGhlIHRlc3QgY2FzZSBmb3IgdGhhdCBwdXJwb3NlLiBSZWZlciBudWxsX2Js
ayBmZWF0dXJlIGxpc3QgYW5kDQo+IGNoZWNrIGlmIHNoYXJlZF90YWdfYml0bWFwIGNhbiBiZSBz
cGVjaWZpZWQgdGhyb3VnaCBjb25maWdmcy4gSWYgc28sDQo+IHNwZWNpZnkgdGhlIHBhcmFtZXRl
ciBhcyBhbiBvcHRpb24gb2YgX2NvbmZpZ3VyZV9udWxsX2JsayBhbmQgc2V0IGl0DQo+IHRocm91
Z2ggY29uZmlnZnMuIElmIG5vdCwgY2hlY2sgaW4gcmVxdWlyZXMoKSB0aGF0IHNoYXJlZF90YWdf
Yml0bWFwIGNhbg0KPiBiZSBzcGVjaWZpZWQgYXMgYSBtb2R1bGUgcGFyYW1ldGVyLiBUaGVuIGNh
bGwgX2luaXRfbnVsbF9ibGsoKSBpbiB0ZXN0KCkNCj4gYW5kIHNwZWNpZnkgc2hhcmVkX3RhZ19i
aXRtYXA9MSBhdCBudWxsX2JsayBtb2R1bGUgbG9hZC4NCj4NCj4gQWxzbyBjaGFuZ2UgbnVsbF9i
bGsgZGV2aWNlIG5hbWUgZnJvbSBudWxsYjAgdG8gbnVsbGIxIHNpbmNlIHRoZSBkZWZhdWx0DQo+
IG51bGxfYmxrIGRldmljZSBuYW1lIG51bGxiMCBpcyBub3QgdXNhYmxlIHdpdGggYnVpbHQtaW4g
bnVsbF9ibGsgZHJpdmVyLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2Fr
aSA8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMuY29tPg0KPiAtLS0NCj4NCg0KTG9va3MgZ29vZC4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==
