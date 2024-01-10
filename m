Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF750241
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hP/cS+SJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCRc/4r6rt5pIrE4czM2tBD6A5R0DTy/OxuV8nVlGJNncePiL4UzNOOfhwTgJ2kM8CCe2/BSH6eLtUyOYehKUDdPza0sVYUfvbO1AxP4txDnEJYPSZvtoObtLV8qAFLuK3er4qYlTfGjLlx1wGi5qAnUy+tY4Zq3hHkYI1cQOZe0gGdsllsSHk3gZbruW0rQkD+IHWzYgh4tKwLsKqrktYWpAZtiIo/Gb+PHbYTJdG/5rQWjAUqPXjFva51v6u8hr+r/d4UpgrSG1uM5CetRUqdzPCbx/DqPjHnBl+WZj0jh2dTLlJRTJt6xJM/bo2640ZrwWN3AIgUXsmJL973QSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+S3FyLN7wgYGm9RUNwfqnsEtUAJWM59Jl8Lks8XpC8=;
 b=EFkgsKW66vGlm1XD0KgbyCRba29y/OiRCglKKmhi1Xi9dzGxCbOZBOQYk/BB0wFJbSVMmCfCbbu/hcQQLXEguRnPXfYk4JLksrbhtycDwVdt+AmqwOmfLHkdzChgv1AGy7sPfv1IQe+mfdlbi7iMDOhsIsGvpjiosmAf9m5NkxCy/TPB8KzFCCe3KQ+0bvPKmuLaUPoNOyMBE5XqoIEwAp0Nl61h0qbd0PfkboFiCXWgjgH48ySOoBPCF/bqBxZuZpkIpclmSxcV+I1NceMj3NtYS9brR7YQ+dELCPaI2Uf8ZLC9fSrn5HTy/dRejSdI/yUTg7+7R4mJFhPo81m55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+S3FyLN7wgYGm9RUNwfqnsEtUAJWM59Jl8Lks8XpC8=;
 b=hP/cS+SJrxgkWjmAJqf+gjSCkqSkQ9wdlTVvFIhbBJZe9XHjnzuuMskd53OHhtPYC8LlWPh+S4ho4nfrSO5GpKPZjnIkZjv2l+8L3tzqkIDlHIIxDp/ptFjtRHgHPz9pt51JxvRoYqG9R/Ludab6v8gANDBRom0lKYd9hNkHazTomaRbYzN7fJdgucrISj/aVrEx1rWyd9l7aueLQhOSUHq2NKL4C0M/2m4/p0QzqLQ1EPqoKcY0C+ePwOFKowhwzYti/kPI9PlWG2PG7EHyEk2ph/gMtoLROx63jFBZhd8ZzK1IJyNA+YeR6zDfpyPA9woqsWzTwa5UsxBv0M7Fkg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 23:47:22 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 23:47:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Nitesh Shetty
	<nj.shetty@samsung.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH] nvme: add nvme pci timeout testcase
Thread-Index:
 AQHaQ3lDV0aWrUFAIUCtA7cIZYYqELDSkmGAgAAXHoCAAAQIgIAABOuAgAAUQoCAAPEQgA==
Date: Wed, 10 Jan 2024 23:47:22 +0000
Message-ID: <9c9981a2-53f5-40e6-ac68-54fd5040661e@nvidia.com>
References: <20240110035756.9537-1-kch@nvidia.com>
 <CGME20240110062350epcas5p351f5b4f8e27b3c57545b49509d2a48b6@epcas5p3.samsung.com>
 <20240110061719.kpumbmhoipwfolcd@green245>
 <b09c8885-9907-4616-bf80-68ca145a1eea@nvidia.com>
 <20240110075429.4hqt2znulpnoq35h@green245>
 <aa82e427-a599-4cef-80bc-fac5bc517335@nvidia.com>
 <74c67758-3b27-4840-a8e3-63eb8f5e5257@suse.de>
In-Reply-To: <74c67758-3b27-4840-a8e3-63eb8f5e5257@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5295:EE_
x-ms-office365-filtering-correlation-id: eb7bd623-3c36-4283-9ca0-08dc12367d78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ejCOVoXLRK8pEGsRkH08Ogoagvq+Ut+bJe4CSNvLv1rcng1zZzgve0psrWkZdpFs7o28xjjhhMRuVBnM+MKfLlbT2fM3boRJpIl1lI3yT1QQnVE6hLdj1l0DK1RwWfAiECDlOB1xkRo6V5bz16tUXDe4JIpKaYoo0tyKVizPF2DwLKfp/uIXAJWTLK5EY2SFzmcUFPMbVM6kxRd19bxSFVvWntxMDg1nN3gq3F1cjuoXC8WdbOHmVljdeE+uKIQ1QBV3vJC1OwtWiPr4ys8u4N2s0DvR/N16GpWhMEpQ5bqRd77Aw7dcSDKhHz/Ve7PN/nxSzRktNsbdvGjBrjlUDdaTOhskNUYRJK7SkOt79DV6y1dGDm1LtwpH3qq0TC4YaW+zmK5Kjgp+VOoSk7tExIcL71Z4zSzRJ802AU/wR8ZFCwvgWdINk0ffOBJ9coJqGapxAzSVYRTbfmWE1k+bPPzIXVrUGdAyNujLN2ldivgy7mWT/O56nQIuwLh6O9TR2asb90FZvULg9qB9DyXViBiKkjM5KJv8jBjWjTMujfDSdLifL0T2pKq5S3ILfsrp/XxIucZDIjOVTTPllveFatqKfjuu3j9cs3JL2nIF/69spphD7aY2qTi8Iwu3A9YsDSKRg07c0UOlvugLqWf5SCK4qXnE7w1a8WJ3DRF/l8CSgqMAyeiCbRbZQrEFKpJ9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(83380400001)(6512007)(86362001)(31696002)(36756003)(38070700009)(38100700002)(71200400001)(4326008)(66446008)(316002)(5660300002)(2616005)(53546011)(122000001)(66556008)(91956017)(64756008)(8936002)(8676002)(6916009)(66476007)(66946007)(76116006)(2906002)(6486002)(478600001)(54906003)(6506007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjRpdzd0Y0tjeXdtbVAzR1FJN0VJdGYrM2lrKzczYnNIVm5mOW1SWW80MjQw?=
 =?utf-8?B?eGdQSUx4MVNKZjU4MkVIZW95dnA0V2ZqdWRVL3luZHFld3RaYTVmNjlibDRz?=
 =?utf-8?B?ZUV3RkZaY0hncnorNFJqSXAyU0wyKy9vQzJ6cnYxOVBsU1hzbHpsYjRxN2xv?=
 =?utf-8?B?cXFqSXNMM1NwQU1FRmtlZHZ2bzlmUWVKUTMxMVcvbkpHZElBUmxFTGJEQlY2?=
 =?utf-8?B?QXQ3TGIvM2x1NUJUVHVJTFpYeWh6T2pFdlg3azB1OXUvYm1pZ2hNcFdPRDRv?=
 =?utf-8?B?c1ZCYzhjd3hXTG9CZTY3R2RYMTNXRVR1RmtHNFR5TEo1SDNmcGIyZHYxVWp4?=
 =?utf-8?B?Wjc4andTVEZhZlJUdEM0YkhOR2RUM2doSUE0OVd0UHRsZUtacGlYdjBVWVpr?=
 =?utf-8?B?cHhoL09ISTVOandyaUpRTFcyeTRMMUdQMGh3VDl2VUNkVWdzUi94dlUrSUxx?=
 =?utf-8?B?ZjRDamhxbmlaaUQ5ZEl2VnRWd09YK0VLSVRLQnFnYXVlbGFScmR1cmkzTTg2?=
 =?utf-8?B?RFladzBOSEhMVDJ1ZmtxbTdHNmNNb1JCTHNIV3NnMmF3YWNLOWI2VzEvUjdz?=
 =?utf-8?B?VlpsejYzb0FBM1dvWGp2VVIzUkwwbk5URkhrRHZWbW1JVGt1QzRuZjJoRzV1?=
 =?utf-8?B?ZW82OUJTdEd1dzdxc055Mk9rRXJ4VUZsL0xwOTI3K1RFWnlmNTIxSk1wbXZG?=
 =?utf-8?B?d3RxdUtET0NkNG10MTBPZ1lNOWh4SlErRW1ObE95elVYZlczVUtQTnBQSXQr?=
 =?utf-8?B?WVk1VlVFc2ZZMzV2SVlhNkRITDQyTXJ5VE5rR2JuNmMvUDJxS1plc3RTNUFV?=
 =?utf-8?B?QVU4VzZjWWVXT0gwcUozbk5sSHVyT3dFNi9CM2xnZ0NRbTIrUXowOVVncjZN?=
 =?utf-8?B?cnVyeC80YlF3M0dhUGR2MlJtcVdoTFpyTVRPYS9kV0NOSTd6OW9OTEUyMmhR?=
 =?utf-8?B?dWhTMFpjR3BmM0dzVTlRdXgwQmdwMlRrQVhqNytmNkk0NFc0TmxhcU1Vejlh?=
 =?utf-8?B?VFVSVENCU1gxcklqbFVTNkxVeFI2b1dMbUFqdFIwNHpzbFY5eFh6bWZFKzFS?=
 =?utf-8?B?ZzUyNUVWczlGNlBza1V4Tnp6Nkd5RTlpeTFvY1lHTzU3TERiYkxscG9VYWps?=
 =?utf-8?B?c2dad1hrcG1FNkVHcVZvZmpIQ2FEdWRRakt3STlGcGF0RituQWlqZ0ZVOEdx?=
 =?utf-8?B?bTRqKzNNUzc0dFk3YmswUjlmdkpNRlRNUlNkYlU5NzdIdEdMKzJlUS9tY3VE?=
 =?utf-8?B?TEVuRXAwVWY2bmJPTHFmMDkyZmMwNlExM0NCQ214cXlIcE5qYXR1WjlhcXBY?=
 =?utf-8?B?c3BFb3dCVmhWNHl6QTZ2NW00VG9BaGsvOGkvMUc3WWkxUW9FdFI4TXpWbmdI?=
 =?utf-8?B?c2h5YWU0WjdHWHFhejRLZlN0N2d1M2xOZ29BWkVvQWVsV1VFb2pKcmNnTVl3?=
 =?utf-8?B?c2hKUEI3VkFoNG1RZFR4RlVIaCtaYWFKRVpNRWJzUkpTcHRtNnNoUFZHMnIy?=
 =?utf-8?B?eTFxTHVkMWhvcktNQkpSUHhNMklCR2FjS25SOFN3ekIxazZxeGVVc0pXa2Nk?=
 =?utf-8?B?aTNLSXh4VUgydCsxeG5JZE11NS80ZndIaUR0UzdGTjJaMURiL2dPdlRSSk9o?=
 =?utf-8?B?WVJ5b29IYm5RVWd2WEQ4TFVZUnkyLzFmbXJYMFI3K1gxaWtSbCtrbGFiWi8y?=
 =?utf-8?B?MkN4dndTSExQeVo0bEZHZTVYdzQ5K0I5U0FKbTMxdkhvR2xqYlV2R3VpbTc3?=
 =?utf-8?B?enBvemloWkcwVDd0WGl2UllGamEzTHpxTEd0d2I5bVRLb1lEUEhyQURGTmlF?=
 =?utf-8?B?UHdUUWd5TEw5dGhWTHlNMzRwTktqUXNKWTV1RjkwMkxjVmdoM3lvemxsYTRS?=
 =?utf-8?B?N2NSUmR4YWVzdmRoTjlqT3kvTWxRNGZ6c1pJblA0WkRvVHg5S2xwVXBtNkFG?=
 =?utf-8?B?Q2tnYWgzVWF2QkFuNkRLSkk4SVlZVlJrdCtSUThQdzdWM2FxUHY4dGdXaE81?=
 =?utf-8?B?YVRmeEU3OEp3YXYzTTJWcTZsT1d6S2RJQ2FRVjJQNDlNVWtRdm1nbWN2ZGhX?=
 =?utf-8?B?aVVvQ3BXTk9LWHRXVFN4V3ZkQ1R6STUvOUp2R1VNQWpIOFh2YTl1dlY0M2dB?=
 =?utf-8?B?dXIwWG8zTWJKUnJlWVZhdTl1amtRY3JhelJIMWw3MERrKy9vRVdJMGlHelYz?=
 =?utf-8?Q?EE5/qSOxkuCpmmWDcQsjCEIdGdB4md6O8+hVwUAcu2R2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B5A357A5574E94DB670F5620AFF0B57@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7bd623-3c36-4283-9ca0-08dc12367d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 23:47:22.2052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNhgvxxDfM6exBQMLTY+nYAmmVPtY4ZCdrM7/PP/nFgr8Z/HfE1vyLTz0PbFL113Jl4Ek5MViz+rV0LF+zjLIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295

T24gMS8xMC8yMDI0IDE6MjQgQU0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4gT24gMS8xMC8y
NCAwOToxMiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4NCj4+Pj4+DQo+Pj4+PiBTaG91
bGQgdGhpcyBiZSBURVNUX0RFViBpbnN0ZWFkID8NCj4+Pj4NCj4+Pj4gd2h5ID8NCj4+Pj4NCj4+
PiBNeSB1bmRlcnN0YW5kaW5nIG9mIGJsa3Rlc3RzIGlzLCBhZGQgZGV2aWNlIHdoaWNoIHdlIHdh
bnQgdG8gdGVzdCBpbg0KPj4+IGNvbmZpZyBmaWxlcyB1bmRlciBURVNUX0RFViAoZXhjZXB0IG51
bGwtYmxrIGFuZCBudm1lLWZhYnJpY3MgbG9vcGJhY2sNCj4+PiBkZXZpY2VzLCB3aGljaCBhcmUg
dXN1YWxseSBwb3B1bGF0ZWQgaW5zaWRlIHRoZSB0ZXN0cykuDQo+Pj4gSW4gdGhpcyBjYXNlLCBp
ZiBzb21lb25lIGRvIG5vdCB3YW50IHRvIGRpc3R1cmIgbnZtZTBuMSBkZXZpY2UsDQo+Pj4gdGhp
cyB0ZXN0IGRvZXNuJ3QgYWxsb3cgaXQuDQo+Pj4NCj4+PiBSZWdhcmRzLA0KPj4+IE5pdGVzaCBT
aGV0dHkNCj4+Pg0KPj4NCj4+IGl0IGlzIGNsZWFybHkgc3RhdGVkIGluIHRoZSBkb2N1bWVudGF0
aW9uIHRoYXQgYmxrdGVzdHMgYXJlIGRlc3RydWN0aXZlDQo+PiB0byB0aGUgZW50aXJlIHN5c3Rl
bSBhbmQgaW5jbHVkaW5nIGFueSBkZXZpY2VzIHlvdSBoYXZlLCBpZiB5b3VyDQo+PiBzeXN0ZW0g
aGFzIHNlbnNpdGl2ZSBkYXRhIHRoZW4gX2Rvbid0IHJ1biB0aGVzZSB0ZXN0c18gc2ltcGxlLCB3
aGVuDQo+PiB5b3UgYXJlIHJ1bm5pbmcgYmxrdGVzdHMgeW91IGFyZSBib3VuZCB0byBkaXN0dXJi
IHN5c3RlbSB5b3UgY2FuJ3QNCj4+IHByZXZlbnQgdGhhdCBieSB1c2luZyBURVNUX0RFVi4NCj4+
DQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyB0aGUgZGlyZWN0aW9uIHdlIHdhbnQgdG8gZ28uDQo+
IE5WTWUgZm9yIGludGVybmFsIGRyaXZlcyBpcyBiZWNvbWluZyBtb3JlIGFuZCBtb3JlIHByZXZh
bGVudCAoZXNwZWNpYWxseQ0KPiBvbiBsYXB0b3BzKSwgbWFraW5nIHRoZW0gdW51c2FibGUgZm9y
IHJ1bm5pbmcgYmxrdGVzdHMuDQo+IA0KPiBXZSBoYXZlIGJlZW4gcHV0dGluZyBxdWl0ZSBzb21l
IGVmZm9ydCBpbnRvIG52bWUtY2xpIHRvIGVuc3VyZSB0aGF0DQo+IGJsa3Rlc3QgX2Nhbl8gcnVu
IGNvbmN1cnJlbnRseSB3aXRoIG90aGVyIE5WTWUgZHJpdmVzLCBzbyByZWFsbHkgd2UNCj4gc2hv
dWxkIG5vdCBoYXJkLWNvZGUgYW55IGRldmljZSBuYW1lcy4NCj4gDQoNCk9rYXkgLi4uDQoNCj4g
T3Igd2UgZGlzY3VzcyB0aGlzIGF0IExTRi9NTTsgRGFuaWVsIG9yIG1lIHdpbGwgYmUgaGFwcHkg
dG8gZ2l2ZSBhbg0KPiBvdmVydmlldyBhYm91dCBjb25jdXJyZW50IE5WTWUtb0YgbWFuYWdlbWVu
dCBhcHBsaWNhdGlvbnMgb24gdGhlIHNhbWUNCj4gc3lzdGVtIChudm1lLWNsaSwgbnZtZS1zdGFz
LCBibGt0ZXN0cyBhbGwgcnVubmluZyBhdCB0aGUgc2FtZSB0aW1lKS4NCj4gDQoNCndvdWxkIGJl
IGEgZ3JlYXQgdG9waWMgZm9yIHRoZSBibGt0ZXN0cyBzZXNzaW9uIC4uLg0KDQo+IENoZWVycywN
Cj4gDQo+IEhhbm5lcw0KPiANCg0KSSdsbCBtYWtlIGl0IFRFU1RfREVWIGNoYW5nZSAuLi4NCg0K
LWNrDQoNCg0K
