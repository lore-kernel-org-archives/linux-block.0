Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79251DFCD
	for <linux-block@vger.kernel.org>; Mon, 26 Feb 2024 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985885; cv=fail; b=DsrL4oEkyxmzLMLXyUURGz0dZ39hwXmJRVFKMnm7ET/h2urtYtCo8wgTHrGSk2Bqg75927jhN+HnEmoOPLN4YohOnDVjB6anrjKHRayU7sMEASL+3/NTx9VAJT7FDDKXHkZq0oUcVe+V3mGK+clsE9USjQHKLnKgWthjlWlB0aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985885; c=relaxed/simple;
	bh=wzMOOxPiy1iFeZIj38+w2mnIXFKTi/3Xz6z1nEA/ifY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O8udvzxE/MZEMmDBJ3/KC395wUrfBEsvAKRB7j8RvbyDHi15MpXTNZlrh7SPs/a0a02HKPjywn+9c2Hzblf1r3HHErRLvYcIVQKkhxrPJyXiHtOgUbxfX+iDQ/3C9IcqtNn+HxMchKOezBWDCfbSPtqebKz9/oL8i2deE4PIZWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sroiZAZD; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sroiZAZD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fC9KRsqZy5SlHSsFpd3diJo/BU7SyLv1RqBfu0/n49mTgovlYYuWF7P5QOv/ol0AhbSzfgi3t/kuqXKw1VWLwBpqaarachBkBEiAvGcadwO+b+dW1Wzm+vnBHkVyMsIlaQonpAuS8iHa0WaapTc3KhHeQb1lsyF7aXyAARnerqaQ34tfW1j4Hqf+pqijjvMQ+fZeXeOj2y50B3ix1B1xny3cAn6Qyl6LdGvdvvv6RKq6wnogG7RiozaqTp5/N8jBhBlV2QhRW2f6Ul3FfNH0yQQSwA03ieVYpldq1Pu1WvK5Aiefq/yuW3PEHKErfRInP5yFFfFgeCrmj7kw82ld/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzMOOxPiy1iFeZIj38+w2mnIXFKTi/3Xz6z1nEA/ifY=;
 b=nRRoV2h2QubIMW/YTMqGKiXQWzb6/fQ62M5b6w5LYCe6qkfeBVJUEh509iF61KkzWxFZn+TpM1r6GlbExYk9+QFN2aWJJIyQryowRLoHbV4TboHwJxxvMKly9Dhre1ebfrdnoWIX8FYJFfg4aJlv9tB6oae4fODzBNqzJakc7hUIVQtslv6clngQnMDeXiWo2U+q6rwKcEIIJ/TR3tZbbybwkkJ4C3Vhs0fEOUdhsF8wsM9y5hW4qxKXn3P4qzU3S9u5oRyyjegukL+9F9rB3TC+LILLRrSJFB2N1SpZ6boHScn/hY7G9DrnuSQS/mdQYpT525bW3Jq0j80LC3M8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzMOOxPiy1iFeZIj38+w2mnIXFKTi/3Xz6z1nEA/ifY=;
 b=sroiZAZDQD9DF/D37+JJ0toNxPKPrPrdKz5VmpIDk5i78D1kqRhgokXhnqIQOQR7kIxu4LEBf/PmtpIiV1aFsm3bI0JTnzRhFDj8C4SdLub0xzQf+4rcghemCdHWRIRyDtrCtSMru1Ib4IGsMZEsIy7TTqRs9sJv8jXsuXp/TeGKIlxQyFA0xIFzhDcwt+/aqmlF9gM7I4aewvtBTblB1dO5y9OlhmIfL2HQreY0v+nQHA0BqiTtjpEDZS9sf22zYIFAyKIv4I7HW5PqJAAed1VgudT4Lz/ot/H87kCL48+1WPTQBq95hR2nyoGJkAT37akjd/Bqxnb4U/EyOUlvGg==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 22:17:58 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::fd67:3880:45c:8a3]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::fd67:3880:45c:8a3%6]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 22:17:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, "johannes.thumshirn@wdc.com"
	<johannes.thumshirn@wdc.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "damien.lemoal@opensource.wdc.com"
	<damien.lemoal@opensource.wdc.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.de" <hare@suse.de>,
	"zhouchengming@bytedance.com" <zhouchengming@bytedance.com>,
	"akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH] null_blk: add simple write-zeroes support
Thread-Topic: [PATCH] null_blk: add simple write-zeroes support
Thread-Index: AQHaaIOJBd1tywPuQUuwEZ2sWPVYUbEcmGUAgACZ4gA=
Date: Mon, 26 Feb 2024 22:17:58 +0000
Message-ID: <dfe4afdf-f877-44e6-bef8-c2dc71c41ce0@nvidia.com>
References: <20240226071355.16723-1-kch@nvidia.com>
 <682d99ef-7773-4214-bc46-900ba4172563@kernel.org>
In-Reply-To: <682d99ef-7773-4214-bc46-900ba4172563@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|DM4PR12MB5748:EE_
x-ms-office365-filtering-correlation-id: 910e5b9c-2bcb-4d7c-55a5-08dc3718c9e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 k75hm+7nGUn83ZaWvq6L0ndzgXZIulHuzC1j2fSeqs2KB6XJ2YnOe3w9p9dgxWrRthjqVaFzHeNEEgl5x7aeYfUhxqhWcd/ot/70Th3AMG3UShyXh3fI5JOWPKDewy7ApeN/SFo74kyRMTg/W0W06d51ZEoFJsswfjtHm0b0yk0rFBRUHRrEpYHkkE8fYA+ACYeVBUAz3Yah9bORVmmvY530RVHUBeFoiiKSrtnhH+SgRus3h6tEiLid5GCLfg3OUY0JlmuTepBb/J0Xasl94oHCgHNMy3rP/sWHgP/jydg9IJ/UsAt7OqmvP2Ei9OLmRo20eR3dWnNZCgDtXlAY7DmRzznXhEZTLB1wCYIWahUC6eHdMBa1gum+rzuv9p2Xxy1KL+izDQsN8K7v69F4bzDVP4Dhzbiku7ZNM76J/dqFjLJi2EdOnsjTBKURqRPDV4CuySVuZuWuHCqeQ8MpDFR4WLBCO/ra5+BPP4G1h8F8Wu3eEovKbeRKSojy6RQYZLidKwi2JQxlgjuzmYlldUQX9ZbZQImapkOpTVXPHvGXPuZ7e4pDkyV8DNLwCevtt7e+dsh+FT4nPiglabcqPQ2yNkbORf7e/xIZw03Zbnlo5fEX/1xlE4Nagti78GRH2jqfVHo2fqun7V2ilFMoaYRA+oe9QJso7wgUpRDZkH5TRzGFkOBfphaZxGcdjL1Ou+0l7zBa0jU0YgykmfcKFg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1Fwd2ZRakROQ2EzSjlHNzBDejBvMDVwKzErM25aSGVpSGg4TTlHZkhKZzZo?=
 =?utf-8?B?aDAzRzB6N2ZjM1Rqa2RqUjJjWTBaVVJjd01QS2xSUHlsd3JjYjBmcmtLR0Nq?=
 =?utf-8?B?QjljcHpyUXpyYmt1a1RNcUYzY1R1SlpIVlB5M3VzVXJjTjFNTHNoOFBDRFAw?=
 =?utf-8?B?SG53QTdCUWM5Zk02WUR2WDJkZWVzWk9aMWRNRDl6Z3AzNmROQ0VtRVNNMEU4?=
 =?utf-8?B?UktyMjJ2bEdndkcvVENUTVFHK3ZtMkVpUTZ6bGI4RFBVQlJJYzI1YkVEY0p4?=
 =?utf-8?B?Vk9mQlZTWTdUQ20yajRCOUVvdm5Dd3VoeS9ZWWYzLy9YRE02MHRqekhpWEcx?=
 =?utf-8?B?K0FWSW9CZWZoNS9HNG5qUWpKZFo4R2NhK1VTejlqWC9pN1hvQWdHYjAybVdJ?=
 =?utf-8?B?NHozU3VwK3JsR003Qld5dUt6Mm9SdlRwYXU1Z0hONkFBU09rcXBNeEMxT0FE?=
 =?utf-8?B?dm02dGpTendvOUFwVTNSNk1NM1drNlNqbVFKZWsvTmU4WEoydnkrd3ZkVUQ2?=
 =?utf-8?B?N2RuQ2MyOXdaRHl2TGUybENtVHd4ZW5MUHEvNnFYNkxjdzR4dyszcFNCNjRu?=
 =?utf-8?B?ZnYzeG9JOENLRXpuSjdrUmd6ek9WS0MwbUp1RHFuU0FBTzlWQ3E2WklxYTRn?=
 =?utf-8?B?cVdRd0FGd1NGU1BaQUZQK3Q2VFYwMTByOFdNL0pZc0NYWlVMbWI2cytONktX?=
 =?utf-8?B?cnZIVTJJY1ZrSEh4LzBnU1A2dmtRNXc3b2hqVWtIejNjQXp3QThsbDQ3a1Uz?=
 =?utf-8?B?cEpkSVIwNVQwdjVDa0VSZHl5am1HV0Rqa2E3MEUvQ3phZTZzeU1xajU5TUww?=
 =?utf-8?B?bGZDaGpkM2IwZTc2RUZsdjI5L3pibFJyQXZOR09yWFpoaE16MUFpUDRhY3Fr?=
 =?utf-8?B?Um92TzMwZGx4Y1NFVHViMU9SU3psTkhtS2xobDRkazBqS2xGZ3prdXNvakVn?=
 =?utf-8?B?N0dHR0Y3Yml3WW9zZmpheGRwN2NZYmVBWGRKSlRNUjNEQy84OWROWEJsT0I3?=
 =?utf-8?B?RzdwVktvTzZ5d0MvK25VeTFidDJUbWR1NUZXNWoyOGNMR0IvcGJSSXFFaHVu?=
 =?utf-8?B?dXRKTlhmUE9ibGlSOVJEYkZsblh3YVk3YmorY2UrM3huMkdMUklXVDBldmpt?=
 =?utf-8?B?aHlFazFDNmU2TTFSTE9vYnhsd0IvdEEwYmxTWSt3US9LL2lOdnQ0a05BeHEv?=
 =?utf-8?B?bkVqVmtPZENuZytpbzFaejRJdFN1NkRKMGFoa1FoUWdLNUtFUWRrZi9iSGRR?=
 =?utf-8?B?dlpjZ1ZvSy8rT0RSZDlURG84TkhyWWdWZ2dFVlByc0tobURXWHQ1Zk9jcWk5?=
 =?utf-8?B?R1puNlRCOVFsRXRJWU81QzhNQVVLVHYxejVPVzFTY3RvRTZrSFFNdzhvU3JV?=
 =?utf-8?B?QkFSS21TNm0xZTFhVzNFcDlTKyswaHpKcFYrNDRyY2dESDRRRXA3ZFFZZ3o2?=
 =?utf-8?B?SWlYYk5ydkRjc1Z4UGFIdjdIU1pDeFFKOXFwOXhoUm5zSU9XcUxSKytTNStk?=
 =?utf-8?B?L25EeXRJaG5qT1FpaEJaeEdtbGpRWU0yeFFZWjF3U3d3elNtWEZuM2xmTnhC?=
 =?utf-8?B?czlkTGpacXZkeHFzeXcxbEg4UktMU1REOElabDBTeHQxYmFlNklWYWMzMmt5?=
 =?utf-8?B?eFYvUWV6RkpaaDZHTVhRTzB2K1lJVnhDOG1vcDNTTGNkeVZDQ3NmaWZJZVQy?=
 =?utf-8?B?UnNkbmVObUhoN2xiU0NMckptdnNyM283dnNYQlAxMWs0cW0xTG9GV0tRVXVU?=
 =?utf-8?B?UmwyRTVZWWRSNTlvTDlYNjEreDlrMG5LUlFweldxTWQ0YWErbUw4aFN2QzQ1?=
 =?utf-8?B?dUI3Wk9qR3FGN3pjSW5KRFVPSHNCQkp0OWV1WTlOYzVPVFozNnNadG1UK1R2?=
 =?utf-8?B?Q1hnOGxGbGFKVndFNDFNWUQzSTBHN2dTQWpsSS9VSTFwVGJrNjJnMEtHSVVS?=
 =?utf-8?B?dGZ2ZjVQdHR1VHdTSkp3UW9lU3Z1Q2VsUm1rRmI5ZmFNSlh2clE1ZG5vUzdR?=
 =?utf-8?B?U3JaUGxGNDBSSUQ4eWwwdXpHNkFZY1JEL3VYYnplTnlFZ1lMQ3RiY25RTlI1?=
 =?utf-8?B?Uzl5TDlvcy9yenVHaHptMVpIRlFtZ2hpUlR1TjZUNkZYTHkyclNEUkc3N1hF?=
 =?utf-8?Q?iwoySf1KtThdZbb0a8WStwljE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6293B88347489049A8D1A9FE49E46E76@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910e5b9c-2bcb-4d7c-55a5-08dc3718c9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 22:17:58.5443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clZUugeAIleS9HXfvuR2LlUhlqqQO6DaLVdxaW/CKfmKubw4sJuTJhmg7hvfqNwVswRnecJGgd9421M21DnNqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

T24gMi8yNi8yNCAwNTowNywgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE9uIDIwMjQvMDIvMjUg
MjM6MTMsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IFRvIHRlc3QgdGhlIFJFUV9PUF9X
UklURV9aRVJPRVMgY29tbWFuZCBhbmQgZmF0YWwgc2lnbmFsIGhhbmRsaW5nIGluDQo+PiB0aGUg
Y29kZSBwYXRoIHN0YXJ0aW5nIGZyb20gYmxrZGV2X2lzc3VlX3plcm9vdXQoKSwgYWRkIGEgbmV3
IG1vZHVsZQ0KPj4gcGFyYW1ldGVyIHdoZW4gbnVsbF9ibGsgbW9kdWxlIGlzIGxvYWRlZCBpbiBu
b24tbWVtb3J5LWJhY2tlZCBtb2RlLg0KPj4NCj4+IERpc2FibGUgUkVRX09QX1dSSVRFX1pFUk9F
UyBieSBkZWZhdWx0IHRvIHJldGFpbiB0aGUgZXhpc3RpbmcgYmVoYXZpb3IuDQo+Pg0KPj4gd2l0
aG91dCB0aGlzIHBhdGNoIDotDQo+Pg0KPj4gbGludXgtYmxvY2sgKGZvci1uZXh0KSAjIG1vZHBy
b2JlIG51bGxfYmxrDQo+PiBsaW51eC1ibG9jayAoZm9yLW5leHQpICMgYmxrZGlzY2FyZCAteiAt
byAwIC1sIDQwOTYwIC9kZXYvbnVsbGIwDQo+PiBsaW51eC1ibG9jayAoZm9yLW5leHQpICMgZG1l
c2cgLWMNCj4+IFsyNDk3Ny4yODIyMjZdIG51bGxfYmxrOiBudWxsX3Byb2Nlc3NfY21kIDEzMzcg
V1JJVEUNCj4+DQo+PiB3aXRoIHRoaXMgcGF0Y2ggOi0NCj4+DQo+PiBsaW51eC1ibG9jayAoZm9y
LW5leHQpICMgbW9kcHJvYmUgbnVsbF9ibGsgd3JpdGVfemVyb2VzPTENCj4+IGxpbnV4LWJsb2Nr
IChmb3ItbmV4dCkgIyBibGtkaXNjYXJkIC16IC1vIDAgLWwgNDA5NjAgL2Rldi9udWxsYjANCj4+
IGxpbnV4LWJsb2NrIChmb3ItbmV4dCkgIyBkbWVzZyAtYw0KPj4gWzI1MDA5LjE2NDM0MV0gbnVs
bF9ibGs6IG51bGxfcHJvY2Vzc19jbWQgMTMzNyBXUklURV9aRVJPRVMNCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KPj4gLS0tDQo+PiAg
IGRyaXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jICAgICB8IDE0ICsrKysrKysrKysrKy0tDQo+
PiAgIGRyaXZlcnMvYmxvY2svbnVsbF9ibGsvbnVsbF9ibGsuaCB8ICAxICsNCj4+ICAgMiBmaWxl
cyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYyBiL2RyaXZlcnMvYmxvY2svbnVs
bF9ibGsvbWFpbi5jDQo+PiBpbmRleCA3MWMzOWJjZDg3MmMuLmI0NTRmNmU2YzYwYSAxMDA2NDQN
Cj4+IC0tLSBhL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jDQo+PiArKysgYi9kcml2ZXJz
L2Jsb2NrL251bGxfYmxrL21haW4uYw0KPj4gQEAgLTIyMSw2ICsyMjEsMTAgQEAgc3RhdGljIGJv
b2wgZ19kaXNjYXJkOw0KPj4gICBtb2R1bGVfcGFyYW1fbmFtZWQoZGlzY2FyZCwgZ19kaXNjYXJk
LCBib29sLCAwNDQ0KTsNCj4+ICAgTU9EVUxFX1BBUk1fREVTQyhkaXNjYXJkLCAiU3VwcG9ydCBk
aXNjYXJkIG9wZXJhdGlvbnMgKHJlcXVpcmVzIG1lbW9yeS1iYWNrZWQgbnVsbF9ibGsgZGV2aWNl
KS4gRGVmYXVsdDogZmFsc2UiKTsNCj4+ICAgDQo+PiArc3RhdGljIGJvb2wgZ193cml0ZV96ZXJv
ZXM7DQo+PiArbW9kdWxlX3BhcmFtX25hbWVkKHdyaXRlX3plcm9lcywgZ193cml0ZV96ZXJvZXMs
IGJvb2wsIDA0NDQpOw0KPj4gK01PRFVMRV9QQVJNX0RFU0Mod3JpdGVfemVyb2VzLCAiU3VwcG9y
dCB3cml0ZS16ZXJvZXMgb3BlcmF0aW9ucyAocmVxdWlyZXMgbm9uLW1lbW9yeS1iYWNrZWQgbnVs
bF9ibGsgZGV2aWNlKS4gRGVmYXVsdDogZmFsc2UiKTsNCj4gU3VwcG9ydGluZyBtZW1vcnkgYmFj
a2VkIGRldmljZXMgaXMgbm90IHRoYXQgaGFyZC4gV2h5IG5vdCBhZGQgaXQgPyBBbmQgd2hpbGUg
YXQNCj4gaXQsIHdlIGNvdWxkIGFkZCBkaXNjYXJkIHN1cHBvcnQgZm9yIG1lbW9yeSBiYWNrZWQg
ZGV2aWNlcyBhcyB3ZWxsLg0KDQpBZ3JlZSwgSSBqdXN0IG5lZWRlZCBzb21ldGhpbmcgdG8gYWRk
IGEgdGVzdCBmYXRhbCBzaWduZ2wgZm9yIHdyaXRlLXplcm9lcw0KdGhhdCBkb2Vzbid0IHJlcXVp
cmUgbWVtYmFja2VkIHdyaXRlLXplcm9lcyBzdXBwb3J0LCBJJ2xsIGFkZCBpdCB0byBWMi4NCg0K
Rm9yIG51bGxfYmxrLCBkaXNjYXJkIGlzIG9ubHkgc3VwcG9ydGVkIGluIG1lbWJhY2tlZCBtb2Rl
IFsxXSwgYnkgYW55IGNoYW5jZQ0KeW91IG1lYW50IHdlIHNob3VsZCBtYWtlIGRpc2NhcmQgc3Vw
cG9ydCBmb3Igbm9uIG1lbWJhY2tlZCBtb2RlID8NCg0KVGhpcyB3aWxsIGFsc28gaGVscCBmYXRh
bCBzaWduYWwgdGVzdGluZyBhbmQgZm9yIF9fYmxrZGV2X2lzc3VlX2Rpc2NhcmQoKS4NCg0KPj4g
Kw0KPiBObyBuZWVkIGZvciB0aGUgd2hpdGVsaW5lIGhlcmUgdG8gc3RheSBjb25zaXN0ZW50IHdp
dGggc3R5bGUuDQo+DQo+IFBsZWFzZSBhbHNvIGFkZCB0aGUgZXF1aXZhbGVudCBwYXJhbWV0ZXIg
Zm9yIHRoZSBjb25maWdmcyBpbnRlcmZhY2Ugc28gdGhhdCB0aGUNCj4gc2FtZSBkZXZpY2VzIGNh
biBiZSBjcmVhdGVkIHdpdGggYm90aCBtb2Rwcm9iZSBhbmQgdGhyb3VnaCBjb25maWdmcy4NCg0K
SSdsbCBhZGQgaW4gVjIgLi4NCg0KPiBBbHNvLCBpbnN0ZWFkIG9mIGEgYm9vbCBhcmd1bWVudCwg
d2h5IG5vdCBkZWZpbmUgdGhpcyBhcyBhDQo+ICJ3cml0ZV96ZXJvZXNfc2VjdG9ycyIgd2hpY2gg
ZGVmYXVsdHMgdG8gMCAoZGlzYWJsZSkgPyBEb2luZyBzbywgdGhlIHByb3BlcnR5IGlzDQo+IG1v
cmUgZ2VuZXJpYyBhbmQgbm90IG9ubHkgYWxsb3dzIGRlZmluaW5nIHRociB3cml0ZSB6ZXJvZXMg
c3Vwb3J0ZWQgKHdyaXRlDQo+IHplcm9lcyBzZWN0b3JzID4gMCkgYW5kIG5vdCBzdXBwb3J0ZWQg
KHdyaXRlIHplcm9lcyBzZWN0b3JzID09IDApIGJ1dCBhbHNvIHNldA0KPiB0aGUgbWF4aW11bSBz
aXplIG9mIHdyaXRlIHplcm9lcyBvcGVyYXRpb25zLg0KPg0KPiAobm90ZSB0aGF0IHRoZSBzYW1l
IGNvdWxkIGJlIHNhaWQgZm9yIGRpc2NhcmQuLi4pDQo+DQoNCnRyeWluZyB0byBrZWVwIGV4aXN0
aW5nIGltcGxlbWVudGF0aW9uIGNvbnNpc3RlbnQgd2l0aCBkaXNjYXJkIGZvciBub3csDQpob3cg
YWJvdXQgd2UgYWRkIGEgc2VwYXJhdGUgcGF0Y2ggdG8gbWFrZSBkaXNjYXJkIGFuZCB3cml0ZS16
ZXJvZXMgdG8gYWNjZXB0DQp0aGUgc2VjdG9ycywgd2l0aCBtYWludGFpbmluZyB0aGUgYmFja3dh
cmQgY29tcGF0aWJpbGl0eSBmb3IgdGhlIGRpc2NhcmQgPw0KDQpUaGFua3MgZm9yIHRoZSByZXZp
ZXdzIERhbWllbiBhbmQgSm9oYW5uZXMsIEknbGwgc2VuZCBvdXQgVjIgb25jZSB3ZSByZXNvbHZl
DQp3cml0ZV96ZXJvZXNfc2VjdG9ycyBjb21tZW50Lg0KDQotY2sNCg0KWzFdDQpzdGF0aWMgdm9p
ZCBudWxsX2NvbmZpZ19kaXNjYXJkKHN0cnVjdCBudWxsYiAqbnVsbGIsIHN0cnVjdCBxdWV1ZV9s
aW1pdHMgDQoqbGltKQ0Kew0KIMKgwqDCoMKgwqDCoMKgIGlmIChudWxsYi0+ZGV2LT5kaXNjYXJk
ID09IGZhbHNlKQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQoNCiDC
oMKgwqDCoMKgwqDCoCBpZiAoIW51bGxiLT5kZXYtPm1lbW9yeV9iYWNrZWQpIHsNCiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVsbGItPmRldi0+ZGlzY2FyZCA9IGZhbHNlOw0KIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9pbmZvKCJkaXNjYXJkIG9wdGlvbiBpcyBp
Z25vcmVkIHdpdGhvdXQgbWVtb3J5IA0KYmFja2luZ1xuIik7DQogwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybjsNCiDCoMKgwqDCoMKgwqDCoCB9DQoNCiDCoMKgwqDCoMKgwqDC
oCBpZiAobnVsbGItPmRldi0+em9uZWQpIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgbnVsbGItPmRldi0+ZGlzY2FyZCA9IGZhbHNlOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBwcl9pbmZvKCJkaXNjYXJkIG9wdGlvbiBpcyBpZ25vcmVkIGluIHpvbmVkIG1vZGVc
biIpOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQogwqDCoMKgwqDC
oMKgwqAgfQ0KDQogwqDCoMKgwqDCoMKgwqAgbGltLT5tYXhfaHdfZGlzY2FyZF9zZWN0b3JzID0g
VUlOVF9NQVggPj4gOTsNCn0NCg0KDQo=
