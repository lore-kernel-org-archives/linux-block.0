Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F7E22F0C
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 05:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494561; cv=fail; b=Qx4ojIEKLXXzI29HlcN/X87UdbRkLLPAVXwguxnZ2QiWo9EpZxM9Kk3pdg4jjxHjLJABtRi9XEUlxs+CvrCtG4gjU5JUxDsNj/HWYt9lxDG9kBo6yiia+OQlsrihjuG2cmIk2LL/NrXlaozfUCRGrd32tcnoeGEAMRJpFHx4uso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494561; c=relaxed/simple;
	bh=yzAVEY4NAqO2v476i1jfZgI7u5L8f8NfWkeCn/cUc0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mJqOZVs+0n9QDG3A6zhlW3ho1xkKzlzBAfEZg1dkBdyapjJL3glJo5DOJK2ygrwt29bRt8ffHrQsp8ysCYDBk5j0+F2QPMOgePIUVCWmc+mPVxc2yOeUeabUmon+PldKxYeUPIMdJxj+RJjJVMzMAfarjQFg12gj6BRyPfAtqTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KDisfn/5; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KDisfn/5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXShe6LGDUtB+KB4hx7YCogNq2rnTEe8RFg8gDLlFrlFAFPHOzB23781ujek9pqEliRUssaLqZwfvOZkjvw+G3gCQiD9ryxBh7beLRoIWhxAFgoOPOR1XgZbTH9OsjfJ/zjx3DhmS787wtmX7LmqIJOUk5ZGbYFxHYiOLcVn3S2qoLVvKskTMr/HcZZE0TDtx+0NdsYHZ3alVOEqUS40StO4BtwrUn316DzWp01OzIgy7KZUoSPzjxTO4S/qH8qPpgsglyioiH4ElQ98p6mKnprl3BK+I2I0ubH26i+SHFaAOe3jkGNb0nfE2K8p2wuTrkz5USQzqJL0r8C2RsGspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzAVEY4NAqO2v476i1jfZgI7u5L8f8NfWkeCn/cUc0A=;
 b=AR/9G3erFBZf5Bp8VXc6EMTyi3qbnnN46iWXKwbWIoJTZG0j/FiRzJ8Wqto8JPZ/Uyc2WpsH2hWuiow+ryVmNI83Jhf6/g1xiuebnZ6JbnKt275CIcQoWYwHfCUEWpvdA0WasM6hJadmUmLw9NGaRmMSxUNdjHV8fvzDH0l1c9TiRmH9eQfxe6pE7PcFblhiwfZgtaSRiv8HIl8JE1CB3uS4JdTGfYlYbkNNGOsgGsVWTpBujEhiThBv8fMHmIc4wqe6v7vswhDSzvZKpVjBs8Y0CQzt7/vn/cmtc4Fwsk0Jy0yV/lK5m04CGvG4aJwlQn1Lm3+vtUXcD0UOLuOKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzAVEY4NAqO2v476i1jfZgI7u5L8f8NfWkeCn/cUc0A=;
 b=KDisfn/5smhPKbK2NQ7iAhWPyhHIiEGyjremlSpb/bveRxOnmmUxj7FL9gjmBXXOlWSJCGBO2gS+2lVU7mmfzqcPdhNACd867jPEbSw2DudrcQfQX6LA+JXj/WNHe2SDpg7nc28N4HQRl/rb+PDQeKqUYZC92qLUQVglRhStF24FpXD8FV42rImdKH4VxTEA7yTghLgb9Wi8TBw5IXws0D1yC3HlDur3hNKLa8FNAsp9DvcdxqflLUGEjxr03MBxJhc0cxZJCY6qU8mk8NtdKAWK06HWnOxvcB/Hpf58ur/0SGY5ZH8zxct1CVZ36lNdW2VdZiRPCUoGNxc248LZeA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BY5PR12MB4949.namprd12.prod.outlook.com (2603:10b6:a03:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 05:49:16 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 05:49:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM BPF TOPIC] NUMA topology metrics for NVMe-oF
Thread-Topic: [LSF/MM BPF TOPIC] NUMA topology metrics for NVMe-oF
Thread-Index: AQHaY9NM3YyUVfKmyE2MAB8W5gxYPLEUS8CA
Date: Wed, 21 Feb 2024 05:49:15 +0000
Message-ID: <8100ae71-b97c-4000-9caa-51aa66e55f5f@nvidia.com>
References: <1817f06c-5b56-4646-b631-9887cd28aba4@suse.de>
In-Reply-To: <1817f06c-5b56-4646-b631-9887cd28aba4@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BY5PR12MB4949:EE_
x-ms-office365-filtering-correlation-id: 8c2dbb76-a624-4142-e470-08dc32a0d6c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 r5nQSpUi/FpGMtfIYK8w6djA/6rx97MdECf55K/TeT494dQaCumsG6P5A+K80XWN9n6LVDQ2pA0UMJn7sfdXYLeX75aTA4HxDgm0iFnpslP1HpM19+5qHdVstpheLQvscCuWa52/QXzSK+g8v+bZ35THlgyQBSJsbeXMJTWKFOY6iby8TxcgiweCUOxz/V7YI/5/3cDV4T/PPp+Gd2IVBH/FqQ5WwRe7yYLiaxZcjP2UC01ExrLyvLU4subGqNkIVwKmlSmwnZlHJyp+lhr2K0409J78AXy2baIEj6uFN6bAHDzq/OCiUkweKDtNWGFeSuA+ZibivIw9B8eec7uYsXd9KGA3CiUaPLKP0yt5kuSFnF9IHPPOyMhKVkoTIGQHNJpwXYFHe4lehRgoGOhP6Msf0xumPYYwAgkWvuAq46Tvu8D+IIHr7QH2H4Tedo7fbloU3n3Lc8dkDFQeqd+wU4SZKuEjSrSIz+pYMJ4Hz3HhJRjDj59z3PQR0AlWjG9ha4SgEcEmB3CpsXiylpKM5OI1fHL9Jsv2Kkrk/xw0wCBjEs6yEwwhmqZU8OSLqz5m1Zvb9tPunv3yvYWHbbarUCUZAGoy9sGFEdz9psWPAevmKCwMWL+0a8o2bI/oZGhL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnF3VzJDUE9RWU4wbmplMzNsTXUrb1c1cnFKall6bUZyVFB2aG5vajV3WEZ0?=
 =?utf-8?B?RWFLSmFCYXZvSGFOT0Y0c3pGTjNScFJxU0VMZDRLeEdhQ2hidzRRcDBWRzNN?=
 =?utf-8?B?ajBST0VpWi9mSXNZa1ltTGZTL3pNYUFmRy83SkNqK20zSWdxTy9JaUU1NUJz?=
 =?utf-8?B?WGxjSnpyVTBDMmdFNnM0TmVJV1FQVHE4YVBhM3llNERxbTN3L0xPNFR0L0JD?=
 =?utf-8?B?TDBmZVBSSXYxNEMyTGR1TkFnUys2TDlZU3NBZjQ5cUdYOFhxQWtuWUtyRXpI?=
 =?utf-8?B?VlZTQ3g3SzhhWnRvMnJQQ0pDMHJzSFVwU1lIUlZMMFlnVWJvUnNyZEorOW5R?=
 =?utf-8?B?Z1cvRnM5NkpuMHE1aVRFTjlySmVGZjJLY09FSXJzS3hac1lvVWlhWFJyckJP?=
 =?utf-8?B?L3FZUjJVOFM5V3BCZ2w4NW81TDRIR3BROCtLSXZGRHBjQU1jNzg2T1dOVU1I?=
 =?utf-8?B?eGJmTzREZnZqTmplYkRZV3ZXWHNOelVtNTVyMURDOFZqR0pTOWZOTGF6bFZ3?=
 =?utf-8?B?U0paQ1gyL1VzUUZ3TWZnRkhhVFBqVTE2TWtodU01U2JpYVpVa3hmckErbCth?=
 =?utf-8?B?YVhEckVtZGlpTi9FZnhrZzJqbVJPZzFBcEN2aHVNOVlhb3I1WUVNb0tob2ww?=
 =?utf-8?B?NGYzcWV1YmRtM3pUc3dlU0ZMNFo3QnlzOENxWVltWGpoaWJ3THhXOFVWOTI2?=
 =?utf-8?B?Z1FYL1MrT0ZiTE9YWHdzc0JMeVhvcHVwa3JZalJ2VlJXanRhcHE0WnBXUzhX?=
 =?utf-8?B?c0ZYN2J1YWhkaENXckQ2N0NzRjJ2RFpGWjhpOThpMVV6MktMMG9iSGorMDRB?=
 =?utf-8?B?MUxjTDQrSDFHZ0NkTWFxUmJKckxIYUtJUmxTNXA2R0dVa2V4VGR6UmsxNklk?=
 =?utf-8?B?VERZL2l2dkhiVk8vN2p6RUk1WTFySEp1M05BVVZRQ2drelJMNlRnRzdWOVlh?=
 =?utf-8?B?SFIvMkRtQUNERjJvMHhNZHVzSklpbE1CMVJBTElBY3NOWkdSdU1sMmRSUnZv?=
 =?utf-8?B?dVlQVzhJNnVKMzJoK3NsRjEvZndHUldRZzQ1ZFNTWDRrNU1sQ1RTVkFGMlJv?=
 =?utf-8?B?Y05QVW90ZS9Tc2N2ZXFSMmgzNW5qZlN4azBxb29Remk5TjRVbExhMURjdWxU?=
 =?utf-8?B?NUpSOXRlM00wT0JjRUV6Uit5TTNrOFNUQkpmb3BuNXFvZzBjeE12dS9Ya0Z3?=
 =?utf-8?B?Qk5yQlo0VlcvVXdKQkpZaEo4N3ZvTXYreEZ1YnArdjF1MXlSNG9HK3NJM2p4?=
 =?utf-8?B?L1NJbFIrUEp3VGNHeXNDSklKbDFQellpL1FnbUlyQTRFYTEwWURSRUN6dDcw?=
 =?utf-8?B?N0YrdUtJR2RhK2F5ZDNOaWNzODhxOVdpZTdWU3ZJOXVyYzZUODJHNWRlTC9z?=
 =?utf-8?B?bzRHWUtFWjEzN0lVY1pEWDF6aWZVNlh1QjFlcTdDNkQ3ZEhYM2JQMTd3dXlS?=
 =?utf-8?B?MVNlK0F1eHB3WnM4L3BMWk5DUkFiZjRqeGZwRFp6YzUwOElMRGloNW5ZVXZS?=
 =?utf-8?B?Mm1LVmIxcGExWk9PWElTczI2a1RKSWJYUFVDUWRidWN1bDJVdndmeTBYOXdI?=
 =?utf-8?B?UE1Ob3ZXUlFqdW5BakxFQm56WFJDSHFKVktjMzRUcnhKNnV3Y3QzMFRXcTVa?=
 =?utf-8?B?WkN2V0RQQnVEUmNqeGU4Nlo2QUtwckh6UTZoUGxBYzhxRWtHT1pHNlV2UDRU?=
 =?utf-8?B?eHNqeE1OMXlpbVBoUnBiTXdUakgrZ0luT3k4cUhMTVlzSTM4WlRUaTVhdStD?=
 =?utf-8?B?azI5RVN5VVJ4clFwY2syWUJUQU1XcE9ka3ltVkVzWjl3cU9OYWNJd2xhN0o3?=
 =?utf-8?B?OVFoUHI2OTFUSllkL1BFT05HbDNUV2s2M3B3a1VZZG5ac0FBUDdLWkw4Y1Nl?=
 =?utf-8?B?ZmwySkJPVzY3azNvSk5jYzgxQTBXSHVMK3c1V0VqYURmcVRqVnZkemphSzVO?=
 =?utf-8?B?MUNRZlFmdDVLbjdEZjRJVXdzYUZmTHhvUTUzeGFBaTRHbGhVbm45elQwa2Yw?=
 =?utf-8?B?WW0xRTBEdmlybDFwZ1FERHRVc2pTUkpYYTZtL0tFL0RLOVpYdFNlY2RQY3hI?=
 =?utf-8?B?TGROQktabjdUbnZlLzlXL0kwUXZidVo5dUVtUFVUbG5IQlpFWmM3eWtiV1Y2?=
 =?utf-8?B?NUN3ZFROcU5tSUVNTHh6cW9VZDhrNHBIUm11SGM5MXo4YVQrbUlsU1NxaCtE?=
 =?utf-8?Q?Kt06hmta2iPFI5FBUk+rsD8ilpYmLild3xutgX+gbggf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8189CC9757F2DD4CB5A73E7B1B454500@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2dbb76-a624-4142-e470-08dc32a0d6c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 05:49:15.9020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Px4qSdt8RlVbhBaXnhFv7+u5BuSfnEJXzUjs4I9lthztBGiVcJWkv4zA64u/K7XkLS7NomlkIzl9vDXm+ytdHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4949

SGFubmVzLA0KDQpPbiAyLzIwLzI0IDAwOjAzLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IEhp
IGFsbCwNCj4NCj4gaGF2aW5nIHJlY2VudGx5IHBsYXllZCBhcm91bmQgd2l0aCBDWEwgSSBzdGFy
dGVkIHRvIHdvbmRlciB3aGljaCANCj4gaW1wbGxpY2F0aW9uIHRoYXQgd291bGQgaGF2ZSBmb3Ig
TlZNZS1vdmVyLUZhYnJpY3MsIGFuZCBob3cgdGhlIHBhdGggDQo+IHNlbGVjdGlvbiB3b3VsZCBw
bGF5IG91dCBvbiBzdWNoIGEgc3lzdGVtLg0KPg0KPiBUaGluZyBpcywgd2l0aCBoZWF2eSBOVU1B
IHN5c3RlbXMgd2UgcmVhbGx5IHNob3VsZCBoYXZlIGEgbG9vayBhdA0KPiB0aGUgaW50ZXItbm9k
ZSBsYXRlbmNpZXMsIGVzcGVjaWFsbHkgYXMgdGhlIEhXIGxhdGVuY2llcyBhcmUgZ2V0dGluZw0K
PiBjbG9zZXIgdG8gdGhlIE5VTUEgbGF0ZW5jaWVzOiBmb3IgYW4gSW50ZWwgdHdvIHNvY2tldCBu
b2RlIEknbSBzZWVpbmcNCj4gbGF0ZW5jaWVzIG9mIGFyb3VuZCAyMDBucywgYW5kIGl0J3Mgbm90
IHVuaGVhcmQgb2YgZ2V0dGluZyBhcm91bmQgNU0gDQo+IElPUFMgZnJvbSB0aGUgZGV2aWNlLCB3
aGljaCByZXN1bHRzIGluIGEgbGF0ZW5jeSBvZiAyMDAwbnMuDQo+IEFuZCB0aGF0J3Mgb24gUENJ
NC4wLiBXaXRoIFBDSTUgb3IgQ1hMIG9uZSBleHBlY3RzIHRoZSBsYXRlbmN5IHRvIA0KPiBkZWNy
ZWFzZSBldmVuIGZ1cnRoZXIuDQo+DQo+IFNvIEkgdGhpbmsgdGhhdCB3ZSBzaG91bGQgbmVlZCB0
byBsb29rIGF0IGZhY3RvciBpbiB0aGUgTlVNQSB0b3BvbG9neQ0KPiBmb3IgUENJIGRldmljZXMs
IHRvby4gV2UgZG8gaGF2ZSBhIE5VTUEgSS9PIHBvbGljeSwgYnV0IHRoYXQgb25seSBsb29rcw0K
PiBhdCB0aGUgbGF0ZW5jeSBiZXR3ZWVuIG5vZGVzLg0KPiBXaGF0IHdlJ3JlIG1pc3NpbmcgaXMg
YSBOVU1BIGxhdGVuY3kgZm9yIHRoZSBQQ0kgZGV2aWNlcyB0aGVtc2VsdmVzLg0KPg0KPiBTbyB0
aGlzIGRpc2N1c3Npb24gd291bGQgYmUgYXJvdW5kIGhvdyB3ZSBjb3VsZCBtb2RlbCAob3IgZXZl
biBtZWFzdXJlKQ0KPiB0aGUgUENJIGxhdGVuY3ksIGFuZCBob3cgd2UgY291bGQgbW9kaWZ5IHRo
ZSBOVk1lLW9GIGlvcG9saWNpZXMgdG8gDQo+IHRha2UgdGhlIE5VTUEgbGF0ZW5jaWVzIGludG8g
YWNjb3VudCB3aGVuIHNlbGVjdGluZyB0aGUgJ2Jlc3QnIHBhdGguDQo+DQo+IENoZWVycywNCj4N
Cj4gSGFubmVzDQoNCkknbSBpbnRlcmVzdGVkIGluIHRoaXMgdG9waWMsIEkgYWxzbyB0aGluayBp
ZiB3ZSBjYW4gZ2V0IHNvbWUgYmFzZWxpbmUgZGF0YQ0KYWJvdXQgd2hlcmUgd2Ugc3RhbmQgd2l0
aCBjdXJyZW50IGFyY2hpdGVjdHVyZSBhbmQgd2hlcmUgd2Ugd2FudCB0byBzZWUgdGhlDQpudW1i
ZXJzIGJlZm9yZSBMU0ZNTSBpdCB3aWxsIGhlbHAgb3ZlcmFsbCBkaXNjdXNzaW9uLg0KDQotY2sN
Cg0KDQo=
