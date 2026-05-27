Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013036.outbound.protection.outlook.com [40.93.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C089402428
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900711; cv=fail; b=c1ocKRN5J1D2TCUQHMDq3le3tBRK4k0fCb3VWGMEJ/cQwNlI8OsTXIILXvkewfVsA2dTWEyQQlWn8mkLi1Tm6unkoMqVWVovbnF5sATmhB7ff6pvsiCFttanu9YiBCblwEM0h5xg6MN2umSV9DDmoPP7x3nWF99ZtxX2kTQyQbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900711; c=relaxed/simple;
	bh=8jfL4ImXkTQP5thSt8h5tLeMjCjQUjLqqqIrbzVsUWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ia7YR5LSZNPwAPd2rwIwGmjYhViNwL5XVv3TtLlmsiIkKH8FSIwEB7YQV5xP0O3ieKScmnG4tQnbMSMhAKqLgefFlyqIDWJXpWW/AtkD3OFFkh9ca9HsFmTVuziOmkt02Umt4WvRW4C4yIopCZXrz8EdPB2KFzevOZcChy9hcI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U98SykZ2; arc=fail smtp.client-ip=40.93.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U98SykZ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kop2Pyjo5O9D5BEodGx9lZ+oR9w1PfEYpxISi4OhZ9XtksdjilsRS3DkOckgsmTRj6fyaa8HAweF4OO2saxnfZjmOBCEvdWXgmT/M0xnkZdnV/YeAmdkWM31HuB2ddLlr1xyS3i7vjDmAYh/d5iulvJGfuMcpRjSBtwwHz6Huc556u6goWEmVL6u17KV3VpT0l7hoEQh3qW4cI2Z94cBM2mVwqtaxl4yd8yHJwRR4Fg2ygJQJ/dkb65Y2fPLUo13b+/6Jo8vjvAVqWvMbZhEbGk0G7iNatFSmrKe0X3VVl7BAmXHSimxgFedLk32hHPX8SRkp90sUF4lFgNFydMXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jfL4ImXkTQP5thSt8h5tLeMjCjQUjLqqqIrbzVsUWY=;
 b=sCLezrjcrAirJiGkJqfvzigrf8ZpE5QtOLad42S5SqvLh9PUc+W00BDAEUpbIhm0oyZVFjDx1VRgguA/IOOzX8EC0GkxHX1QgTi5Syr4SE99DGEUZKqDw+rQ+v6CUTO9fHD1v9vqWggyM4ChNfG/JKl7bwiD96yFH/KwctWgIaqBBCObYoiXeQmW+b87fP6Li9dG2l85i6JwTYkQsgaq+cprwIsCRo452F/M9DKrPvZ3Yy1kQWrw2OA+lRS5QJH5yvPK93wHu9eifUdTrHU+TsMu1UzcY6L31G+SzBFOpww1zgKvu8zp1PKbFq/88NdO/50t9OA4E0KjoIBGqhtDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jfL4ImXkTQP5thSt8h5tLeMjCjQUjLqqqIrbzVsUWY=;
 b=U98SykZ22tGtSnsnOptcTzpJC+yVbzpiRrHnhzJVjdhN6khiBKx3eW6xAN6f31HkNCzWXM/LrFMTnTAWymP/Z+IGKGyhPESVHK/KUDXOQBKnOicrhBhwzwTxmIjxJqfzfHuYfgxGAQIhDB/ra4zmt+ShZTt/hUU0Yndp95xBqWMCWfac4d79AsUp0oeMQ0OsPePTbibgXwKrWTHuH0lJHxQdIP+/W73mvywwXW9VFDpr/Ia/+5/1L89Fb2hYZPLYoiDCM04qZBhT6umb14kQ6AW2PP5H/FbLSBoMmB0tyRtJ5PNfFGLXzyvpXZA93Nb6FPf3m9Vwy6msP4UNzT/PpQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 16:51:46 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 16:51:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Ming
 Lei <tom.leiming@gmail.com>, Bart Van Assche <bvanassche@acm.org>, Caleb
 Sander Mateos <csander@purestorage.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/3] bvec: make the bvec_iter helpers inline functions
Thread-Topic: [PATCH 3/3] bvec: make the bvec_iter helpers inline functions
Thread-Index: AQHc7ewN4HdcyVQGsUSxretjiKZ347YiFlwA
Date: Wed, 27 May 2026 16:51:46 +0000
Message-ID: <24f9ce6b-ae7b-4210-98c8-53ee5f617cc2@nvidia.com>
References: <20260527151043.2349900-1-hch@lst.de>
 <20260527151043.2349900-4-hch@lst.de>
In-Reply-To: <20260527151043.2349900-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB8354:EE_
x-ms-office365-filtering-correlation-id: fdd951c5-5a80-47dc-2593-08debc103d25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021|18002099003|22082099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 ghmgNYFht6wq9teAdULpfnN6C9BkoIOovJI+e6nGgqdi8V1IG9DzShBueQfD8kmVSbhjbSGFRKckI30GiYdMUIjsEJkZmdweoomnE/niOFEQol94nc3O+3JTFBkLMTkSRDaUmnAcn5jP1g8KYwoMRFinJMrjCkNuafJZB0l9oPehFIgwIYq+iA4318x40G791saQuoXs90u8GMHokFo0I7TO+sY5POOr1LvQvmFNGwdE8SQsxEfKrXCYE3OV+7zB4lRjZBO4upZkOiLBHqwpBSrgvxavBtbN9FY0wo1xHdh8X+3AI6YFgSThsQjSgLDvwHDBtCcpHLULZpuZkflC7syzXO5yX7oHoYHp+s4gIxK9Gaq8rhW3pX8RBhiIwom1FHtJeOrSwzT5+pktxbcfaEWmwgunzSvdnzRLW4kcepSXnB8aquToOtQYDb9kEcnyoQjvz0mnd4l56S6nOTCxBT6odOgSC0sFv9gqmA+n15THaWf8fgEd1v4TA41TL5K0XdacT7kMfT5mCMI/cExOleqYNulPo0mGubYk2gfwn+XOUugqJ39VEOWa996l8LzHeLedla1S++L8wgC2D2Q5eE2F6CdGJjyDPBQWKjH30eF/ACjme7foZnpOwjs/8JsWPiVfDFhJrZi8FPXVx9lFVWkQ08Yw5tdXCrtkWw93JBZnpWXJE26PBdX++AvRQJOxBk2t7cYhMjqkLfduEuGiNM9IlVDa0UBY1PVMJPsP/2nv9+tepjieFgcoiFI8DbiN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?enNUNU52VCtZNlVnblJLT3NLek45bmN6WTN0Q1BIV1JFNFg4K1pLRzJkdUVo?=
 =?utf-8?B?RFFPVWFHZHVQbkt6aHJMV1F3S2Z1QVZldHhzSW9ZcitqQnBkVnJRaDVYeTZ6?=
 =?utf-8?B?cWRDSyswNDF6UG9UL2dwUUNvNWFaRjRTODc4REEzTDJ4TjZOdDVGRHV1TXh3?=
 =?utf-8?B?VVV4RUsyT1NuMmF5cEs3LzEwRy9hWTR1dGxJOUQzaGtWeDRIQWd6SVhOU3Bs?=
 =?utf-8?B?cTY0dEhVQlB4Q2ZwV0NGQUFhTFNQcnZPNEcycDRmYktRRWVsRWsrbEw2d3NY?=
 =?utf-8?B?Z3hCVEFtWGZRZGFFKzhrcnk5U0NlWlVLaDBSVE9BSmF0MGo3b0xWRE9adCtX?=
 =?utf-8?B?SytCYnhybWVaUDZ0bTg5c1JEK2dISEVjS1Y1YmdHVFpsOWhsdWVZZktlSGNT?=
 =?utf-8?B?TUhBVzFPUlpoNkk3L1lwZndwRnVlb0JsOU84Q1NacHh4NExDMDZVUTZnekVZ?=
 =?utf-8?B?aGlOb2dSQVF6ZjltWmQ3L2JNZGZ3alE2d01XZHBnSmtYVE13UUQ3WUo4ZThj?=
 =?utf-8?B?NTBQdXZVRjkxK0lMV2k0VjltT2MwWGNKdXJHK3EyOWZiMHp3ODlIbDJvWWRx?=
 =?utf-8?B?RXpzeHgvTGgvbm5UL2pqT3IvYTA0cStsd1oxd1JvUmRHWFBDdFBvYUU2cmhY?=
 =?utf-8?B?d1R1RWJYRjFjdmY3Q1Q2N29zU3lQTnBuMkU2ZGtQQjkvZFRBUHRvbXdFSjFG?=
 =?utf-8?B?a09nTWx3NHhkRkhQR0lTY0hHeWg1TitCNlY0Z1dTcTBxbTRsckxYdG5Cd1pq?=
 =?utf-8?B?WDhIZy9TRldZQi9ocHdIWTlVU3RKRitKRlNvSWplYTVwT3VITXJwOURFbUhu?=
 =?utf-8?B?SFl6R0FTZ3duaThXRzVOekxDeGhaQ1MwdjBxZE9QYTNsRnJLOEgzYzZaRWFi?=
 =?utf-8?B?U3dRakhkUzUyMmx3K0w4aGlleEJjTENDQi9qcHNZU2I4ZjZGNEZkaWtJOCtE?=
 =?utf-8?B?NXhjeWFuQ2p4dkxkT1dRcGlyU1UyNVI5Q29RWDk0STcwV0FYRVF0Z05QL2pY?=
 =?utf-8?B?ZVcwSEZxdU0zN1lXUE9jS2NxMEVxeXRYUG5rT0NIbHFMcElnVkc2ZnJseUJP?=
 =?utf-8?B?NGYrbXk0QXg3OVpRRjRNYTB3NjJjaUFwaDRMa2VNTi8yWUJ6Nk5KVEZWYk85?=
 =?utf-8?B?RW9QUzdOUWJPUUVpd0oyVExxVndBaVhXaHNVUXJhaDhQL0EvaUh5WlArRmtX?=
 =?utf-8?B?OGtTWXlndHRTNGhLNUlXU3Bnc0dqc29hM0lsV1BxaEUzS2hMNXRuQUdsUXZU?=
 =?utf-8?B?UzJZZ0MyMit0L0VQWm1UNlJ5RU1zMjUxQjFJS05MVUVkS2xjZ0RyQmhFTjJ1?=
 =?utf-8?B?c2xRcWpwSUp5YU9ZV2JnL21pZlN3K2NsS0dYUmV4WjFVSWw3T1FjRGRTREdF?=
 =?utf-8?B?YVNIMVd0MUU4dGt5WGVHVGpuTlhjOFMvZlF6MHFFVWJPYkJ0K1RmcStjSDRC?=
 =?utf-8?B?bHJTck5YTG9vblN5MFZhZWFxN1l1K3F2YlJtQWgyZkl3OXN6UUplVjQ4TVR5?=
 =?utf-8?B?Nm5sNFZFM3hUb3NKZHYrYW5ESUdLUHBGV2MzNnFVR2VwMzFXK05oc3UzOWJo?=
 =?utf-8?B?T2NWSzlkak1wM0kza2g1Z0hybDNENDRXOGZ2RlRsSVEvVW9SQmZ0dk5BaHBy?=
 =?utf-8?B?OVUwNWpuZW5JNjZNek9nL3NiSkF6MEpQN1VqZGFFSWtjS2NkVitTMThCbUlu?=
 =?utf-8?B?OWE5cTBlV0hDSTFRNXFZNjN6MHNodTFhZCt3blRGUElvTFp2S3EyZDNOYjZr?=
 =?utf-8?B?cXlBdUNaL1BCRDFESFNoRWR6eGFwUVlwaXBKSVpmenBIOXA0alA4bE5uczk5?=
 =?utf-8?B?NTFPa0hwMXVKb1RIQkcybEZNNklURDIwS1dKZ2hvbVNvT1FqMFBFU2hGTk9o?=
 =?utf-8?B?UElFWlAydmsyMXhiMXBZNUJ6d2ExQTc3TG83UHI0eFlwVVRqUGJKRzVSL1d1?=
 =?utf-8?B?WkczalMwR1dkNkNiWTU4bDY3TzlGUFJlM2V6UU81MWNDV3VValBicmdMdEs5?=
 =?utf-8?B?RjgyTHl4YTdjQzYySUsvcVNpTUVQWGlsK3FETGNDWmhDcFNyODIyWFh4bHNq?=
 =?utf-8?B?d1hYUGROaCs0WEQ0WjJtK2JqMnNZVTVicjM4bCtxZ2I3WHZTR3ZIMHR1eDU5?=
 =?utf-8?B?NmVrSEE4amlRcCtFd09NaXZpRmNWeTQ1dVU2VTludUU3R1E1OGFCS2RxeUFo?=
 =?utf-8?B?WUtMaExRVmxKcjByZHk0SkdRL2lNbmdhZUJsT1liY3pCQ3FZWkVKYWJkMDR2?=
 =?utf-8?B?bUFwS01vVngvMmpURU1CTDFPVllhbzJMT25OOHk4OUluNFdoc3FWSVpFZDht?=
 =?utf-8?B?Z3pkSlAxNnVCUTJ4VkhqY0ZnWUxkaUJ5TldwK1lhOWIyZ1lQVUJ5YUYrTEJn?=
 =?utf-8?Q?XCFl8l0EEyBPb3QTDFndWcwVkAr1t4TnmqKAx1QUmsGZT?=
x-ms-exchange-antispam-messagedata-1: FQtANMpIZ58WXw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <84D3D90CA7C7FD4C929C7E53328A2CCF@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd951c5-5a80-47dc-2593-08debc103d25
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 16:51:46.4347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YuijC64zr++g0LAivmYnPKgpmlG51XXu00JeBNdhPCYpvRqiLngGk4TRtVZaggY1SswnPkbiG62GgghKerYIFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354

T24gNS8yNy8yNiAwODoxMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZSBtYWNyb3Mg
YXJlIGltcG9zc2libGUgdG8gZm9sbG93IGR1ZSB0byB0aGUgbGFjayBvZiB2aXN1YWwgdHlwZQ0K
PiBpbmZvcm1hdGlvbiBhbmQgYWxsIHRoZSBicmFjZXMuICBSZXBsYWNlIHRoZW0gd2l0aCBpbmxp
bmUgaGVscGVycyB0bw0KPiBpbXByb3ZlIG9uIHRoYXQuICBCZWNhdXNlIHRoZSBjYWxsaW5nIGNv
bnZlbnRpb25zIGFyZSBhIGJpdCBwcm9ibGVtYXRpYw0KPiB3aXRoIGEgbG90IG9mIHBhc3Npbmcg
c3RydWN0dXJlcyBieSB2YWx1ZSwgYWxsIHRoZSBoZWxwZXJzIGFyZSBtYXJrZWQNCj4gYXMgX19h
bHdheXNfaW5saW5lIHNvIHRoYXQgdGhleSBhcmUgZm9yY2UgaW5saW5lZC4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCj4gUmV2aWV3ZWQtYnk6IEJh
cnQgVmFuIEFzc2NoZTxidmFuYXNzY2hlQGFjbS5vcmc+DQo+IFJldmlld2VkLWJ5OiBDYWxlYiBT
YW5kZXIgTWF0ZW9zPGNzYW5kZXJAcHVyZXN0b3JhZ2UuY29tPg0KDQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sN
Cg0KDQo=
