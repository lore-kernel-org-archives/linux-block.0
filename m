Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2121.outbound.protection.outlook.com [40.107.223.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C4B11190
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 02:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712111306; cv=fail; b=X7pEp+ZEpqilWsAoD8PzrYZplVWji3yFd58/QTmZuu98yXfntJt/ekE/tkCHn67wdvlos/D5+5nf0k7Kejg5jNBOKyLFRnqkWITIIpR7qH054b8ZyOgdGFnBMUWtwyaIBM3zwRLM3Gd9MwWNf6VcTQONDjV1UsQiuUucTfjdev8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712111306; c=relaxed/simple;
	bh=CoeTU7kzFbvSTb3gqBeijMu0RWA1cK336VAPBVy1OWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OICpZNwiVuvAERuE7okgqwyroN8nExt7plfMT8Dk9UWBUILp8rOtk/0Fslwv4Q9MTDLUuOCytIbCUzn9Ns/xfV8qrBdqXgOnBptGhbGTEvS3OInKqw+awmmOPaeEGMP5vbwpgLlREmpuoZ91iK8Ub1UDih+Jwdk60GY3dr3DTws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qd1e8L3E; arc=fail smtp.client-ip=40.107.223.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qd1e8L3E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KELTLS+SsWePI7ZVh0Ek3oyiya2e2lCit1MVomW6Kyx9+OLyQyvc00XGoLb74QO5osHG45oB1QTxNI86aL6s8x1vm5nfX2xfMgcOtlv6TKxbtpH5XnRd/LgDQctNU+bFsf54P66A7jRODHPcBI+HmeKH5XrVhgQicXRPy2KVFfK6Jv6sfhzMEfPMLkLSjBi0NKzwy6XlefwA6arprrdbtt1fZjOX3Txhj6e8CyrU9fZxu70dtkLAXY80ga5c98ghJ7BETsy10ZfeSAak28Am6tnueWdCackDDsPIwt/UJJlS8xWL/1hbCyU65TGWw7baZ++JRJDP5NzwAmBtwk2Teg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoeTU7kzFbvSTb3gqBeijMu0RWA1cK336VAPBVy1OWE=;
 b=EvKtV5lPro3NBxPjr/3TP83tb/agaejTxh/4JNysN7QjT87y3qo6uHi2Dr5iUJrzDnASXhaDc04qXTHcnNqKlwKtpvnvN4ayuOSIKA2JAZbqwp/yv2WPJuC//GIz69OOB/w2GtpO7sZ4K0X6FmbObB7GXu3SjpHTeINClxitmTPOLG+mP2/QrAOS8P1dDNkbMbMjlUA7zzbK5NmS7o8sPZv+mARvXbKd7RIStXw2rklu+IL3VFJ3fXlr/uJpV/6pc4MpNKADFn2npdDvNruuwyleeodFun9onTpkuRFw0GxmFI2ib6rrZ+RFsPQv6gY+HybbnsprvrfVRH1Aei3pSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoeTU7kzFbvSTb3gqBeijMu0RWA1cK336VAPBVy1OWE=;
 b=qd1e8L3Epa1luHjrS7dKhc5MK8IE9yndcyLnS0G02F9hSxhwGczpkLWzbyW52It5eWIOAeFm66PR57iuxLOfrTfs/ek7c3/BdO10M0uwdgQ2i8+QnE4lT20jAsWajGO9HisUKdJBgHjGpzwX0cFPEfX1M2pmox4dboFDND6eZwboWZ2/tQ0gwcTivUNeXJ9gfcMVLfRfTlhi4X0qyFYo3PTC5N08v+wDtsGnZJOyVGhfcob+a8Gg3xXTEv7lv5csk8EUzgdaPcc+wExplD3T5z1mhJIhSbAnO6bdxgScbCjx/ilxtx6HvNzxT5LSRqSLrgr2a3lMSB8PRjrnuYwcRg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 02:28:17 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 02:28:16 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Saranya
 Muruganandam <saranyamohan@google.com>
Subject: Re: [PATCH] block: propagate partition scanning errors to the
 BLKRRPART ioctl
Thread-Topic: [PATCH] block: propagate partition scanning errors to the
 BLKRRPART ioctl
Thread-Index: AQHahRcZ6qPvLo0/+0KB7GZTqcktabFV0vwA
Date: Wed, 3 Apr 2024 02:28:16 +0000
Message-ID: <54547ec7-69f2-49c6-b117-94585b6c1eff@nvidia.com>
References: <20240402160103.758141-1-hch@lst.de>
In-Reply-To: <20240402160103.758141-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY8PR12MB7099:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 e1MCf8xpDLynTmMZB2oOPXhp++Vd9WVbOY1kB6OZYAJOa1ZsQPSaDmY6qx9AzuxgFSKq6qJtmrPLTnxVFeoQSKm6+DhW22gqrBa2yXRetcfGUzvM0KGFfVZI2SbedQTCx87JE6+D1UJo9hQ8yQtNRr3KBL5ubhqQqdIPcIDj+rP1aikrPZNYWd8/J2i39yAu/dVsdNErQDXxggTe4Ii42jKr/nfGflCRUIfmvkmlb0wvKEQvir+ZufE1yP2PdcT4gDxnuo7azaGM14WDoCyDowzQdMX1AKARF9wN+xj2zUt8a0abcC5A+QCMWgp2Plu/KoQLdIotgmNKbM9FYRw/s9AOslVnDdxTbhulzFEOXanSfsGHIEZFgi/sBPdHTXitsv0jV2cXypZYV5KCqJNwfb8uRuHchm3tN5TCq0UaNxAtmNcDbJ9FnGVZTSEkPNdTpsqb49eSWND2PmYZXwcckO1sz9ms8QRW19GbRSZI2B5CcfWpPv9gQtiam/SyI7ezt724fDL9r/PaAShbqnZK4PS9/if4EqhzsNu6/dOr5rhivBouUHVWbjpYm4JRCjlnKyHnW4eKE3xhIfaYymt8NpxnkqQjX2jwA9QHxtVZLnIdMs9YY4QDAXp2If9Jq4CD+ji3YZwMz5hqbFrfn5piuyxL+ezd8iZ6Ak3yS+BanQk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjQ3TnQvLzBlOEdhTUE4UGdoMi81R09UQU85bFFaYkJFMGVqeExhbTAxWWlZ?=
 =?utf-8?B?SmlMWERtNy9XeU9LRzh2SlpoZzRHbFd5ZWlLVVc4Unl5akc3SmZ6RlRYdFlI?=
 =?utf-8?B?MndLdmZ2T0pETGRmOUVMNXBmWlN0elA0MTNmRGlSRFo5RjBpMEJCayt4SC9l?=
 =?utf-8?B?K0d2clRvcVAxM0NkU1hMOC9KTVQrdGVpQWVOdnRxZFlXaUVleWNaZWdrcHpp?=
 =?utf-8?B?eWhucUpVYzVUYjcvdExKQ1E0VmFsMEgvVVVKUzUyM0YzS2VtU3phT1IyL0Jw?=
 =?utf-8?B?QWkxRDlyZEdVUGtXd1NaT2lKaE9FYkw5RVJqMFNaOGNBZkwxWFdnL2ZxWmdw?=
 =?utf-8?B?b09FbDVaeXY0VHZvVFR3YnE3UlFEckhaM3pseFBoNnpmR0dYRjNVRm5FUGJC?=
 =?utf-8?B?M1JER3JSOE9weTFnd3dZN2syd2ZYZTRYbVlwN0x3Mi8wbENaRDJWVzRDMDd5?=
 =?utf-8?B?RnFkLzV3Q09PR3BQcWxuNFh3dmI3VHVSdHRRYTdBcy9VWFd1eCt3TEdody9y?=
 =?utf-8?B?VXJyMVUyNmZBTmlsc01RYm1WQU9IK3FndmhUekJzNkpMVkYzSi91S09lWjRQ?=
 =?utf-8?B?eVdOSUUyMURuYVV6b1RyNmhQeFREejJJekxPWHBjZGtuQ2VYa1BYV0ZuRUlL?=
 =?utf-8?B?MHBLVW5sdnpPT0x5VVRwZDE5R2ZRSjM0TTRYVldHajRqTEQ3RnNwTFc3cEtL?=
 =?utf-8?B?N0JQSEJJZlNaays3TStGRUhLNDUvcDM0dlFRekxzdkQxWldxNnBKVS9KS3NW?=
 =?utf-8?B?T2hmUWNhM1Fwb1lGY0FIcUxtejhqTlMyNmRqSk1McXV1SEkvK3pieGhaRy9K?=
 =?utf-8?B?d2ROUVNEcnphL1FGTUNOQkppenMxWlE1UHBTd3cvbFROb3hYcWJtS0dzbTQz?=
 =?utf-8?B?ejNTMXJzUmFySWdFNzYvdVlBTzZmUlZPczhyREY3eExnQjl4Q3NCcHY5U3Rx?=
 =?utf-8?B?RC91ZWJOTVVxZnZJQWZtMThsMERwajFIbUxMUDNzVXdHRUtmQ0EyVzlpcFp4?=
 =?utf-8?B?Wk5kWE1mMVRxc1NIZmJFTXpMTDRiUjcraG1teFZ4NmNnN29xaGk5V2JGaFJ5?=
 =?utf-8?B?REV2K3pFZTlkaklKZ1VIWXNwNTIzcjhja2o4amVRcFQzS2dwblBzY2M1ckRv?=
 =?utf-8?B?VzZwWUkwakVNOTlnTEhFV3lqcTlIdVk2U0dxT1NHdFVITjlocjQwWjFvU0Z4?=
 =?utf-8?B?ZURPdmJiTnNZUDdhUzNNRkxUMXRMZVZpZ3M5VU1nWm4vOXdRV0VyN1kxQ1ZM?=
 =?utf-8?B?OGJCYjROSTBVRTl2eHlSY2hlZ25JOUh1aC9OY3l6RlhRSWYyQkZRTjRmMXc1?=
 =?utf-8?B?cTF5QVdJSGJuVGRjckN3MEprTk1HSkQ5ZlovMGVUWWpEbFVwQmlpbHJpRW9Y?=
 =?utf-8?B?TXlISWptT2V4amsrTVNrMlFINzdnTE1uSnl1aUlaR1lvVjV2R1BpV3J3b0ZN?=
 =?utf-8?B?THQ5QkpmWWxJMW5MeUEyNng1ZDdtTkdyd01ULzdnVUg3anZzZTB5NENuOWhP?=
 =?utf-8?B?cTh3OFJlby8xaXVDTExpUGJZcGJPSlZFaGZoSURUcHpPc015bFEvUytOelNZ?=
 =?utf-8?B?TUdScjk3Kzh5bnFyVUJIdjZxdmJTREZzL3FmcVRlQXVESUtnb00wM0lvSzlG?=
 =?utf-8?B?V2xJTDF6MjBuQjV0cUE0RXhidkorRUFUYjVxWU9XOXpac2tuZ3FieHV3MXd3?=
 =?utf-8?B?bHN1VHdJbG9Eemc3ZWZhZDhyRVdDdUE1Mm5yU3R0cFVIWktHZ29NcXFyY3p1?=
 =?utf-8?B?RWJhZlNPRGhKTnZaVnJwUk42a1pZekdySTdYeDNQdXRlcFgrdmJ6aEFBK0hD?=
 =?utf-8?B?TExGbGxQQSt3MDZkRC9XL1FzaTQ4bUZ3Z0JVemhuS08wSzJIMi9jU2NORUhz?=
 =?utf-8?B?NnhXSS81MStQa010dUNWM3lEQjZhS3JWVVlScWd2NHhPRkNIUW1POFlLeHdv?=
 =?utf-8?B?Ukp3RmJoUkl1L3g3OTh3T250RWlrSTQrTXRPb1ptRzZxTjFaNUtnbWIvOFdZ?=
 =?utf-8?B?VTZjRWtJOHJwTWJldmRENWp2TElYMFFxc0dpbFlOWmhPMXJ3R250aFowa3B0?=
 =?utf-8?B?NzlIblZZNnVVaUM1bnk3K1pCbWloaFVhT0lGMVAzUnNpOTVoR2tqOUNSVTdV?=
 =?utf-8?B?bHJsdU1QS01xY3I3c1RVVjJrRGo0NFZpRGQvUkhBcHRZQ2RML05yM0NMaE1Z?=
 =?utf-8?Q?nZNVOJ7IOaI/49RIUrp3G3by01QdUNURrGxxzrLrSPRk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9D57060E0E2BA45A7D3E359491FAE40@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: be10060a-9182-451a-9235-08dc5385b848
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 02:28:16.6803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZKb6GjRRg91eQg39625uQbw/9PyakguSIw9F/s3jKnsCURYAw/a7et+3x7wCEx8VmdF6YyQ0or/CVGTyz9EDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099

T24gNC8yLzI0IDA5OjAxLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gQ29tbWl0IDQ2MDFi
NGIxMzBkZSAoImJsb2NrOiByZW9wZW4gdGhlIGRldmljZSBpbiBibGtkZXZfcmVyZWFkX3BhcnQi
KQ0KPiBsb3N0IHRoZSBwcm9wYWdhdGlvbiBvZiBJL08gZXJyb3JzIGZyb20gdGhlIGxvdy1sZXZl
bCByZWFkIG9mIHRoZQ0KPiBwYXJ0aXRpb24gdGFibGUgdG8gdGhlIHVzZXIgc3BhY2UgY2FsbGVy
IG9mIHRoZSBCTEtSUlBBUlQuDQo+DQo+IEFwcGFyZW50bHkgc29tZSB1c2VyIHNwYWNlIHJlbGll
cyBvbiwgc28gcmVzdG9yZSB0aGUgcHJvcGFnYXRpb24uICBUaGlzDQo+IGlzbid0IGV4YWN0bHkg
cHJldHR5IGFzIG90aGVyIGJsb2NrIGRldmljZSBvcGVuIGNhbGxzIGV4cGxpY2l0bHkgZG8gbm90
DQo+IGFyZSBhYm91dCB0aGVzZSBlcnJvcnMsIHNvIGFkZCBhIG5ldyBCTEtfT1BFTl9TVFJJQ1Rf
U0NBTiB0byBvcHQgaW50bw0KPiB0aGUgZXJyb3IgcHJvcGFnYXRpb24uDQo+DQo+IEZpeGVzOiA0
NjAxYjRiMTMwZGUgKCJibG9jazogcmVvcGVuIHRoZSBkZXZpY2UgaW4gYmxrZGV2X3JlcmVhZF9w
YXJ0IikNCj4gUmVwb3J0ZWQtYnk6IFNhcmFueWEgTXVydWdhbmFuZGFtPHNhcmFueWFtb2hhbkBn
b29nbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZzxoY2hAbHN0LmRl
Pg0KDQpUaGUgb25seSBjaGFuZ2UgZnJvbSBleGlzdGluZyBiZWhhdmlvciBpcyBub3cgd2UgYXJl
IGNhbGxpbmcNCmJkZXZfZGlza19jaGFuZ2VkKCkgYWZ0ZXIgYXRvbWljX2luYygmYmRldi0+YmRf
b3BlbmVycykgaW4NCmJsa2Rldl9nZXRfd2hvbGUoKSwgSSBndWVzcyBpdCBzaG91bGQgbm90IGhh
dmUgYW55IHNpZGUgZWZmZWN0cy4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQpJJ3ZlIHZlcmlmaWVkIHRo
YXQgZXhpc3RpbmcgY29kZSBpbiBibGtkZXZfZ2V0X3dob2xlKCkganVzdCByZXR1cm5zDQowIGlu
c3RlYWQgb2YgY2F0Y2hpbmcgdGhlIGVycm9yIGZyb20gYmRldl9kaXNrX2NoYW5nZWQoKSwgd2l0
aCB0aGlzIHBhdGNoDQpiZGV2X2Rpc2tfY2hhbmdlZCgpIGVycm9yIGlzIGNhdWdodCBpbiBibGtk
ZXZfZ2V0X3dob2xlKCkgYW5kIHJldHVybmVkIHRvDQp0aGUgdXNlcnNwYWNlIGluIGZvbGxvd2lu
ZyBjYWxsY2hhaW4gOi0NCg0KYmxrZGV2X2NvbW1vbl9pb2N0bCgpDQogwqBkaXNrX3NjYW5fcGFy
dGl0aW9ucygpDQogwqAgYmRldl9maWxlX29wZW5fYnlfZGV2KCkNCiDCoMKgIGJkZXZfb3Blbigp
DQogwqDCoMKgIGJsa2Rldl9nZXRfcGFydCgpDQogwqDCoMKgwqAgYmxrZGV2X2dldF93aG9sZSgp
DQogwqDCoMKgwqDCoCByZXR1cm4gYmRldl9kaXNrX2NoYW5nZWQoKSBlcnJvciBpZg0KIMKgwqDC
oMKgwqAgR0RfTkVFRF9QQVJUX1NDQU4gaW4gc2V0DQogwqDCoMKgwqAgYmxrZGV2X2dldF93aG9s
ZSgpDQogwqDCoMKgwqDCoCByZXR1cm4gYmRldl9kaXNrX2NoYW5nZWQoKSBlcnJvciBpZg0KIMKg
wqDCoMKgwqAgR0RfTkVFRF9QQVJUX1NDQU4gaW4gc2V0DQoNCg==
