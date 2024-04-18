Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D362625622
	for <linux-block@vger.kernel.org>; Thu, 18 Apr 2024 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424738; cv=fail; b=WR1pdxVBvsh2xhXYBEYyJ2OBJ++9qh6rM7yypEW8lMijdapR2H+tKimCwovbe3AgnuUxvFUZTWmghRF0BUFq/X4Flzw3jU09mvgwhsM6RTLNBw8qt9z4/UmP07uxKa0VoWpAJjPMxvRIBWcY+ltc6erU9q7bL9HdBQaLWOnIplg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424738; c=relaxed/simple;
	bh=nneNsXRnHmAbV2rgZOv6QhL4is96KoEgneXN8Tdj0GU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GXsCuJcoqXmdofXHBnkZV+omgTWjZnpxqJbcIaQd4amhg03RKUm0qZUazai61f+ES9t6ikbOhAhYuotH2atn8vWTM4iwM3xkRxHU3KRIHwYft0RTFkbpdZrJ/MlAeZddEKAR+4Fzmdpmp1EwKUM1NZC5zcDlFPIxAWH6OumyJmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b8zTGf+D; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b8zTGf+D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fy7Bdqm4rl8ZM6qQvV2l4ggHiulUxhZXb4Mo7SY7Tp9DkIp/AeKfbD60vNxFlJNuAyUSbAZ6VgSxKCMvt+X4jNRNxOd3zBREX4VSxmUrev8kopDfFgyhTrCn4H0PugnVx5H92ttuF9BDlFFHGXir9kbZGZscroaVdSOqzzo6g/P2xzO9x/7RYGdHcAwI8RvCO/pcnjcH9n1DmUUS3zef8UmIMnWxGrh++ZOcHegfrFANDWLkg8RmFTZoJqtWhq/iNtM7rttoII8mydjsO8jTPDCriD8kFhX417tVd1kOXXwHkl3vgB0JjB1fBXN0y/fqzRKfQcTvHy3r6bbzWfZodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nneNsXRnHmAbV2rgZOv6QhL4is96KoEgneXN8Tdj0GU=;
 b=MvrIlOUjuK+1JLVk1ITAd9q10Bnlz/qUSFEswZPBFI4cqkpEiGfevSgcrsB3WJ6oRqdNwp+pu7G6y3VFZgZqyqr97I+I6RIvhXbOqHTwxZzVlTPAdSKqHMOTZWrF+BAJ4vQWubZ8pJS2/jxuIup9fbOaprigQ2Cn9I9VtMf2uxB71kxT8WWX4+Sa3eKOWMbGaXVL4wT0QBL/g5KSOS0O+xxH6pcpWT/KQZAsviF3Mk4M3/1xC57uABGhXV5ZNYIP9PtnjC8hVD7CAuSRlfse5NbzJPyCfOh6T3AeXkjWDvLDFQPEwnwieJawfd0LwZbr2dDmKEHdSEQRMgps9GOHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nneNsXRnHmAbV2rgZOv6QhL4is96KoEgneXN8Tdj0GU=;
 b=b8zTGf+DO7GM+2DUzs95IFKbMmngnQhxRVgWxVLnF8bYBSTVeU49yArtDAsUeXxYexW4zFoQ94BD/FENYjTGNTAr1Akx75BZT5rDl0Qm6MOWW51ysBprW8JkU0ZSe4ya1dJ84kxoLEJyMNJuUTcA2kBkeQEs2NEw5cJe8IVQcLalEMlSmEsZf/ZQ1rpQRCXhCDqwU2gJpD0SxZ7yGZIpLJd+dJutfX2U++kIQQS8I3dzYxM5Myyld8v/I3F8OFYXYtqGzDjbdMcAr4GKtG9VOZGSYw+5GwQaLZQrVdWrZYgkVFiKM840wvP1qBRLp7I3n+KldPp2deJ67OJmijWNuA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:18:53 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:18:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Topic: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Index:
 AQHajAEqsQCXyo+DXUatOaKWBnORo7FqY7IAgABWCICAAGMtgIAAJv2AgABo7oCAAFX6AIABlAcAgAAGi4CAAAv1gA==
Date: Thu, 18 Apr 2024 07:18:53 +0000
Message-ID: <6ec99060-34b3-4394-a47f-3893f5ceed0c@nvidia.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
 <7okerxv2q5k6d2jl4ehdvido37rmycxopqalkt3xcouxeuxxe7@q73je25fv33y>
 <x5xlzl6g3riybq4uuoznt47yp2ieixtltq2sw7w5uodpcosln5@pmx2vne4qgjq>
 <fact36d4ueuna534ktaafuel4uqkexmlkrwasky6ytvpmi33bq@x26qccgbqbnw>
 <b159e306-2b08-4880-96c0-2ff7d5c3023e@nvidia.com>
 <epbj4opovczrfrs3o3mdodjs2dtekl4jsxgbwhtnqhq5bjhjnl@54b5mo6wixsk>
 <extncf2en5xoiov5mhnaglwd33nmffx2u2mw3zlnrxuty3zurx@nij7avtahebv>
 <f4b9ca90-3d8e-4782-a54b-b83c01316d29@nvidia.com>
 <ar2nwyps3zu2vf3zjw322nfxhua67rh5tdyqfsj6cymvia3zjc@y42szgq6ikvc>
In-Reply-To: <ar2nwyps3zu2vf3zjw322nfxhua67rh5tdyqfsj6cymvia3zjc@y42szgq6ikvc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB5593:EE_
x-ms-office365-filtering-correlation-id: 81743e74-c2da-44c7-2dea-08dc5f77cd9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sXCQitCQ7xdoZF340loGdURB7trH+tVC2c3OuOq5/0Dx2kpEAWRwHbkAG/RsVYnHkl7w3LLrE73UJqeid3VhXW5gOrO7fCRH3IP3eBwBsw29WL/7HEiyezA9IKRSZLJbOazU+PzM3MTWPZCMpRn6SR8sZoEti07jgfeHHj5OSVIRAMsBrUI1PSbXqYT8z9WOrYjenf8z2oDzjlhnkTzRgvlVarf0hB/3JZwqGDlJ8DFTkr0mtFqKbXFF0/pecbkVvVE2J56yMU1iXN8tdAbmZnJUd+RkIEjoiLONUo3DpmAeVsE2SUUyOz62Wx2beLrnSkqyV5CyQLf38oZEvqbN/nbhTlYtRj2xVXwelBBUbYNihV6KVPBB2x4y5cg6TNIlA+WcCeeoDCQJF55GI8LGsLqzme4G9MZuA693PYRl4bJXJaSJ0t3mAUzELX3QxpOUODE+XdFnZ5VvShLyE8IDzSgDMB9pn5/LjEkXvU01puVA+tpxUHrUm12LmC4ZEjx0Ej6J6oqXJ7WhkXyg5ct4cNQMc/zKa0esKm9iwCJnarzNC1FxtijXtJH/vOnOZ2RwCmCDzUpMTbsciSNEZhxbRMP/0MMTliidmkX81MHjO+pzYxmutALLWWOp4dsQcg+ffxyBL0AZ3NGdBZnbY6Bdse+vYgDUSeD+EgOPgkRiLraKnkpAQhyzmfIQTxezDYFYCwtOH5bYE/d2r2MblBKOqRn+CWiymRp+ig8izVDb7SI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UElWbmoxVnVqNXQ5bm5yUmJUNWIyalo4MEI1NXdGeXN5ZGQyVFV4cFY0QUd5?=
 =?utf-8?B?ZTg4Mzhha0wxUWhleXVqWjdrMmZLd00wUGJDd2c2UXdsVS9vM3Vld3NtMnJk?=
 =?utf-8?B?WVd6dEl6ekNmdjZxakFiY29XdEZxZ1h1YjdTQUxJcVBJbVhCZkFEejJXKzJP?=
 =?utf-8?B?L2UxbVJJdlBwRHhsOXpVV0ZTQjVMeXVLQ2FGVkZkMGJzdndRT3o4Z3ljclY3?=
 =?utf-8?B?ZVJMYWFTNEgwN2ZWZTZ3enJQMHNYMTVsYVBZSUdOUnI2MkR6UzBuVENGZHNk?=
 =?utf-8?B?dFRIRWdnUkxpcU5Ya0dDZEdnbzduS2lIL095VWZMMDg4S1BwUmhaVUZ1cFg5?=
 =?utf-8?B?aVJwK0dLTmN6M3NCbkNEKzRYWHViWGJ5YWVhVXJKQzVVZ3NYbnhBUlhxOWY0?=
 =?utf-8?B?N1dObyt0ckdPRHZ4Z2xMK3VWT0VHTW1RdmgySnVoSEJKTzNxRFA0ZENvQzMw?=
 =?utf-8?B?MW5MMG1KQTg3Y3BmRXlVWWVaRmlVdjZnSWprVnNMYk13OTBhNEtZK3pXWDh0?=
 =?utf-8?B?Wkp2aS9nRkFWVm4yWUp5R1BpL2drWTNsUTFPaG1CejBJcWw0TWwydnI4OW1E?=
 =?utf-8?B?YUtzWEVraHRNMDVkb29nVFZHc1psaW8rTkR5Q0owTHlmV0ZTUDBMTXArTUtC?=
 =?utf-8?B?SXdoTW9KY3d6RUpoTDhBL0E5RWtvZ3QyVHBRZHdTYmNpUTNPUWt5TS92TEZX?=
 =?utf-8?B?Nk9XVWV4VWJmMkt2VnpqV2FXbmNiZ0R4MHVVMEVWNlNIU2I3czZBeXJJZndw?=
 =?utf-8?B?ZitPb3EwaU1ZK25Mb2FWY3hPWHRYYlVleVYxck53bGdMQUxiV2Y5NjVDb1Fi?=
 =?utf-8?B?Nlp3U2gzNHVpd1V5cHdGMFhQQ0tTNk8rcDBtWk55RERnM0J4d3FIczhESlFR?=
 =?utf-8?B?L1AzNS9rVjBrQjdFY0Q0dktJZzRwRFovdTdvbXFRV0Z3K3AvekI1MUw5cVZI?=
 =?utf-8?B?T25FcnorbXNYMysrdHNNNXEvVE1TNmh4SnRlV3pXTnYrdlo2RDhIK0gvSmxn?=
 =?utf-8?B?aFljQXQ5TzU0Z0xiaXhpS3Z1VWYreUJMalRTWU02eHRrWkFmcEFSM1FxRlp0?=
 =?utf-8?B?a2Q1dDNuZFpoMTYrNWxLWVcvVnVRaXZxbjZzdy9YSDJTTDRWcU5MNXFvM3c4?=
 =?utf-8?B?L216cnN1WlpiendoVnlJdE1mMHdpcmdweXlWdFYvTW8zeUxRMTFSYWhOelpo?=
 =?utf-8?B?SU04SDJvL0JsaDhLZ3VPbXU0NG5PaEpRc1p1bHhFMUxjWHNna1ZhZ05hTW1H?=
 =?utf-8?B?dmpHd2phN2lhVmY4VU5KSTlucHgvVHdmb0ViendScjF4eFRuUllINGIya0FD?=
 =?utf-8?B?dExLbUlzTlNDY1NPWDFEdWJsenAydmttQ1Y3bE84b21SR0NXK1NIL0pQLzgw?=
 =?utf-8?B?cEdmQjA0OENxd2xWYWR3QzlMelFhUm5ha0VabjlQWllmb0NJalY5cVR3TEtm?=
 =?utf-8?B?Q2w1RzQ0aExEbzZGdDFGSGlscjgvOE9Ta2dXeWExbS9VdUFSM0c2RE5pRFps?=
 =?utf-8?B?bjJ1L2xNdmsxa2FOaFpOTFlub2hzZU5FcjQ3QWtVdEQ5aUU1ekxzMDVmUFI0?=
 =?utf-8?B?K0ZjQ0FnVHg0SkN4TmpoVUUyZ05VOTlKMWhsS0Z5U0srTHlaRmpHYUo1SUJ5?=
 =?utf-8?B?OXlWYmFET01iRi91YWJHWGprOWFkUThMQjVTQVUzNG1sdTRhUzV4Y0orb0VF?=
 =?utf-8?B?aFozTXpjeGZJYXc1cVdYVWxwZHdqeFlwa3YyMGg3a2VKTUp5TW1Qa2NuaTl6?=
 =?utf-8?B?cTZjSUZmSjhHbWpMOFgwajRNYVZFcitZeXZianh6QlhCS1ByQWlBelhUeGRY?=
 =?utf-8?B?Qm1TSlJGSkJPeHlCTlpGdlBFcnFoMnFEZm03TmROaDZTbHlwWGFYdlRqRmtF?=
 =?utf-8?B?WmZoRjF0ZFZLYk5jUTc0d2laMElXQzNRcFh5UlR3cXZKbHNOb0dQUWhZSTZD?=
 =?utf-8?B?TUFScm5LSldUM1BVbGlSV2tjNTRocFp6T1lEdUFZR2xpcFJGZHVZQjg4UWto?=
 =?utf-8?B?N1hQSVVSS013VHZJYmpmRnJqa1RwRVRRS3hsMGtDbkhkNTd5THV2d0czWXAw?=
 =?utf-8?B?SE9JNHlCRUNEb3VhWTJacnBWTVhwSWl3ZkFJZS9iQVRhUFUyNGViTHpueXBN?=
 =?utf-8?B?ZkNIOCs2ZjN4NnhYci80RG5DcUFXOFZyenhmMzRMSStzZjJVSGpJMk96Tmkw?=
 =?utf-8?Q?l0usFKLJ2rzAoqKqnZa9f9iIf0xzbiu5EFor3ihFcaO3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F821472D2F19748AF8F8DA8E594C190@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81743e74-c2da-44c7-2dea-08dc5f77cd9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 07:18:53.4582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L85zGPgRhtlvAzvZK/5LatGOTL2j2eihRBIi8tKLQurBImiEcLneQLCmeis65BwEhRguH8p7KVPnHS+vchEakw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593

T24gNC8xNy8yNCAyMzozNiwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gT24gVGh1LCBBcHIgMTgs
IDIwMjQgYXQgMDY6MTI6NDBBTSArMDAwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4g
YWdyZWUgdGhleSBzaG91bGQgYmUgdXBwZXJjYXNlIG5vdCBkZW55aW5nIHRoYXQsIHRoZSBvbmx5
IHJlYXNvbiBJDQo+PiBhc2tlZCBzaW5jZSBleGlzdGluZyB2YXJpYWJsZXMgYXJlIGxvd2VyY2Fz
ZSwgaXQnZCBiZSB2ZXJ5IGNvbmZ1c2luZw0KPj4gdG8gaGF2ZSBzb21lIHZhcmlhYmxlcyBpbiBu
dm1lIGNhdGVnb3J5IHdpdGggbG93ZXIgY2FzZSBhbmQgc29tZQ0KPj4gdXBwZXIgY2FzZSAuLi4N
Cj4gU2FtZSBoZXJlLCBzbyBsZXQncyBmaXggdGhpcyBhbmQgYWRkIHVwcGVyIGNhc2UgdmVyc2lv
bnMgb2YgdGhlIGV4aXN0aW5nDQo+IHZhcmlhYmxlcyBpbmNsIGRvY3VtZW50YXRpb24uIEkgc3Vn
Z2VzdCB3ZSBrZWVwIHRoZSBsb3dlciBjYXNlIG9uZXMNCj4gYXJvdW5kIGZvciBhd2hpbGUgKG1h
eWJlIGluY2wgYSB3YXJuaW5nPykgYmVmb3JlIHdlIGRyb3AgdGhlIHN1cHBvcnQuDQo+DQo+IFdo
YXQgZG8geW91IHRoaW5rPw0KDQp0aGF0IHNob3VsZCB3b3JrIGJ1dCBsZXQncyBiZSB2ZXJ5IGNh
cmVmdWwgYWJvdXQgcmVtb3ZpbmcgbG93ZXJjYXNlDQpvcHRpb25zIHNpbmNlIGl0IG1pZ2h0IGJy
ZWFrIGJ1bmNoIG9mIHNldHVwcyAuLi4uDQoNCi1jaw0KDQoNCg==
