Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57B23D982
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508740; cv=fail; b=S9JJaYcwsBg+JUMsfex2TePiWkzRtISHEhWsZ5MWO+EKZVgsRAusVrklPlDAs/7datGjJ+RiwDVibQtUDdabq65yAPlM8T6MT4CvsYbpwJspHBVT1N/7nWZXM82zHgiQlykM2y0+2Xf3Gsp4W+TQVMktrqE0Ubvp/1Qc8yMfzG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508740; c=relaxed/simple;
	bh=bhNEzzw17NNOdekkuPwaMCRTnA084hct1koDRWe0dE4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B/67c5Ski0TYGGJEQ1nFxBCHbygEfCNsJPs0xVEanQdA7gczpDS/q8aun4B8pRRv08HLuVe2FjB1oOoQDBdhaAUDrA4BZf/MljZ9Q1i+2GuBa+yTvH3EXH9BTUS/tMsMRbzfCMcPaD2co0YR0WZnVVzD/YqUDSdZDH4Zt9wfQv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZJ9fzvDS; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZJ9fzvDS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpsWsxlekmzFsuw7VerwyxstPNztH/LL2PBPdu2EH9MOXuQ2elntAED408VESDdrGZFPYH+J9jenMvY8fL5LPsOVH0tcJFMj31rmbjufWh1z7j8Pf2rxvj6PTTgtj8XTqqAypyjCFQ2g0HFf6Dupue5jrdqLEusamUH13pYvL5sCqBasAYr6Di+kUXVI0sDArYq0SI3npHmpEPrUd1wkySd2jjq7QaAuSvoBoyazjWr4LpwiXhPqIVGXnQrZ7wqgtJxdUJbW8AWtUVomhs4AKqc1kXxkAHQqx2STACronJAFTLGAwuKrgYVyLVYFp5p7L9SztULrAVgVbIYvvCT2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhNEzzw17NNOdekkuPwaMCRTnA084hct1koDRWe0dE4=;
 b=gX7kArT3JwZF5F9R2BG6GYEhiRViS30VLGpBf5WVe6dE1PgHfaVjoNjV3ADTlFKF1GF5JpeHJRKwRzG437xW//EkRLrHQKlLHnzV8DinnayuoxVRvIvIutSuC9j9wH1vxDAgU8zLEb86E6iYg/mo01ssOi9o3AKXtqt04I5qqD7LhR3USW3DRN1Tsq+GMGhBLPbeQGUW655rLxMJ0NOxbN2e5lOSmZsTOZwjnkJzlBlFyhVMFaCjg4bkWaDTHk/OiY3NTgYNI1XFcxmgAWMRnAXIOaFg1AAbc6dVKtOCwyPMy7TFDE9VDb0/9+38O2q1Y5cofeNoysXJJhWnC5T6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhNEzzw17NNOdekkuPwaMCRTnA084hct1koDRWe0dE4=;
 b=ZJ9fzvDS4jpfOW6iZBe8bJd9L+UZVkD9t4epoOqengb39plmb1RTo3HuNXr08kGcTpCqOC8maGceFqVg0YbNcxQrUIADeh6e9eMWx8GyoCdw+PqZeNdQ/f7D57eI2RR7S0TTC19/QSAgV7AwJKtUqHyQ3hH3GabJURusaCK5JqSGi6ZeeI8uI5Oi5FO9RNtHURjj66Jx49pv1oF5Sf0gd3PdScYY+f+RzWH0DFDlvi7A2Z/0gttKpoItnntl/kk11P+8fkPCT/R6KPJzgVfUkgXbjKHAy34LkeJ1rusEhxL9CEuZscad4XAeKU+SLg8xEiIXZiGvCqzRcx1HhZTJeQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 09:45:15 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 09:45:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.org" <axboe@kernel.org>
Subject: Re: [PATCH] blk-lib: let user kill a zereout process
Thread-Topic: [PATCH] blk-lib: let user kill a zereout process
Thread-Index: AQHaZD06sUSdY4lj2Ee2Ig44LaIhIrEUHSwAgAADEoCAAF5bAIAADkSA
Date: Wed, 21 Feb 2024 09:45:15 +0000
Message-ID: <d7ffffb1-2a6a-4227-bb25-d36210c311e2@nvidia.com>
References: <20240220204127.1937085-1-kbusch@meta.com>
 <132449a7-634c-41b6-b14c-863cb198133e@nvidia.com>
 <ZdVrDbaQ2DbSKQtL@kbusch-mbp>
 <CAFj5m9Jf-WXLoTEtok_+FzuAUEcRRoO+-DaPCh2U-884D2uXdw@mail.gmail.com>
In-Reply-To:
 <CAFj5m9Jf-WXLoTEtok_+FzuAUEcRRoO+-DaPCh2U-884D2uXdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5748:EE_
x-ms-office365-filtering-correlation-id: 594f64d8-b1c2-4967-98ea-08dc32c1ce71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 w/GsNtnHIsrzdsUGLdenI+rr+QHTz84oN5JuNSVpJXUsO8BIAJ4+8s2b+jeVwDkNa7NQ2CScVRQgSt2gNZp5qhkLeIo/62pvztsnvAdd0HXrR0ivq9aTvdWgYDGAEZFUed8eGPzgjxgrbzri9DbQgYtx60dcPc0r5JRTDAJ44EdxOHtOz0Seu5oaOSqNspE5tB4EZzcd2jM+Z71T7o8yq8PlKG1FUWl9KpJ3SqCkOYiRd5J3hqmwMwu/mnqI5iEGHKkfuvobfk16QibR3V7InOYlkf8WQ96ikGpxCexTocQYf7qE+o6jYoWpJq55z8RUI8Fg5oowEU7VUhn7OvEioXFOAxys+uZIw62FCurfeFWjzegPEpDdedthdZN87o0luat0lo0CS8M0FJaysPS3TcLmwdxkyYzCD4It4qOGc3uaH/ox7cbi/tOpXU/2pLuzBg6ComBgwJN9acXOypPtaab6Bbi7tvJ4T2rfwYvkYLyVmhS8267ninQMcaDR8KWvn5KAH5P/VxeYePJn12Q/CdOR+0GrebApaIZ8kUibPYOABhiVhLkZCH+11L8AYJrvXbxsrQuDaRCD8uJJxJlLgsgNs3zVqASwODyI/t8eQ1HErrVMmW0Wwqno1tmUkpC7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTl2OU0wdkdPWDMxZzZ2WHpIYjg4M2xpaFRRaVZtcy91WUFRc0E1VzNQcFRN?=
 =?utf-8?B?b0cvQnBSbDFFYTRMWU1VMG54TCthRHc0ZHhkSGk1K0FPbWZSQTVIM3RJTU1M?=
 =?utf-8?B?NFRkUWlpUWxSSnNta1gralpjTTlPZHBUQmNiVzNrMFBRS3BOTEtCejdLdXZa?=
 =?utf-8?B?WUJJbXpVNXFYZHBwMjhvNitRTEt6by9Lakc0UWR4bjRqK1RIUm5mYk93eWl2?=
 =?utf-8?B?T3A2RGhDeGN0NmU0VEp4K0lERnVHcmJlb3JCWFJLZzZ1ekg0WlFWbXdLUTMw?=
 =?utf-8?B?NWV4QTd1QkpWSlVYcUVnbU1xMDhBMW8vWTlocFhQVUs2RzhILzRmQ1l3OWRz?=
 =?utf-8?B?VEJFa0w5YkMzN1k3YmlQalRYcGNiRGowQUpMWGJPQmtYd2t5WHJQa1ZYUU1n?=
 =?utf-8?B?bVdFUncyTGp1a2lGdGJsa3U0VlgwelJZeGE2UUxXS0JZd3FjdCtsUDg4QkJa?=
 =?utf-8?B?djhiQXJyb3NpZjVFTmdacHIzc1hyTysrKzJ2eWc3bXB0N1VCNEV0QXlXRk9h?=
 =?utf-8?B?bDhyZFJVenBTQU1hUG9razdGU0pJcHFxS0wycEJNUzVQWWVGTlhUWDExdDNL?=
 =?utf-8?B?NFJ3c2Nxc3dzUUg3QkVkV2g3RkRRb0txVkZtL0t3KzNadGxCQ3plWUwrV09I?=
 =?utf-8?B?QTNFd3Q2S2hWZWszMDhTYWY0czBDOThLaEdXdWFCUHVjak9PQmhPTWRuMHZt?=
 =?utf-8?B?Y1d6aXJTQndRMjRMeEVOVXNKQllZdk5WdytYOVlQU2hzNWNheFg3R3ZTZTVL?=
 =?utf-8?B?N2J2MC8zSFAwT0Vyb3hxeUpaZHlXMkh6TlFtam16WUVmSzVuWnIvdmVXcDBC?=
 =?utf-8?B?R25xMEJ1Q3hiWlBtaS91SmFwTm1qZkxHWW5DVno4eFpVMlRBVTFpTzYrdnlO?=
 =?utf-8?B?ZW9pWGtFSElhTWFqMWoxNDdWNWh0UTJLOERJUVR0ZUZkMkkrZTIxeGpIcXdt?=
 =?utf-8?B?TU42Rko3NEdoWjZ1ZmtnWDdxbTVoeHhISWR6ek43NlFhV3UrbWN3NVFkOE9r?=
 =?utf-8?B?eEU4eXAvaWdReU9TWUc3WkZMai9tT0FWYWxMR0J0VkZxWlpmVFN1bzFGemVU?=
 =?utf-8?B?QmZRUWt6cDUvRnU3T1ViT1dPQ3YxNWlkckllT2trU1FZdGQydGZMRXNSRTBB?=
 =?utf-8?B?bWpSYTdLS293aXBSM0VnSmJrUU14YkcrVnA4bTlOZnprZC9rNXlYa1V5S0J2?=
 =?utf-8?B?YnJFdjNEbHRBbjN5MFp1RUlEYkVLNVYrZjJtSzJoMXQzbDhYYW9EMm0xM3Jo?=
 =?utf-8?B?L3ZrbDl4SitqSWRVYlZZc1EydGJ1TU1FblI3WDdkYnhNeml6dGZQMHVORGVU?=
 =?utf-8?B?SFJpY21JZit3c0ZNN3YrY3hxT3B1QUNPYzNYT1JjTDRLZVIwY3RVOW94RndF?=
 =?utf-8?B?MEZ5NHFSVExyTTFGak8wOFkyME94akFnV21LVlNnTWMxTmYzVlJBYnpQeTI1?=
 =?utf-8?B?ais5c29yL3g1VDZ4dDB0VFlEQ1hYNEl4UkZYWGYrTFYrYjZaMFRtM2VYNDRj?=
 =?utf-8?B?dzVvUU9kS1FtWjQyT2p6emdXUHNqVlhORmVUYnluVGVrZWNzb0VORFpIYXRk?=
 =?utf-8?B?VXdmZ3dZK3JtZVBUd3Bta1IzYXluc1VJVG5wQVl6Mk5MZXRWQUhLQzBBY3Rl?=
 =?utf-8?B?WlRvTHZQNlFjYW5ta1lEb0xxaUROeEF0dFM3NUg5Snl4OVkxRG8zcGhzUW1p?=
 =?utf-8?B?VTZaQTd2YzlFbmVLSWg4ODFYYnlUSHdYeGVuQlI1U1pXNXZVWWNYZEtGNHJm?=
 =?utf-8?B?Y1Zqck80NlZnYVR3M1ZHbXhnZEtISkU5dWRsQVFoMUNaZ3BvNkhIV0g5enlD?=
 =?utf-8?B?N2o1aytoeTRrSlIzcGFhNTdwL0pSQmd3YUR1SXJqdyt5WFNQWDZKNE5jbUU5?=
 =?utf-8?B?SUJmOXlpb3dCeEdvZG9lVmJGMXQ4NnFYSm5xcHY5dnhGazRndUI1MWU1bDVo?=
 =?utf-8?B?Uy9EdnpiMU5XclBPUVd3UkJDZHd3Um5tTU1KRUJuMVY1aWRuWGU3d05nVXdz?=
 =?utf-8?B?Ym1oWGR1QnpWU1hQNG9WMDhGZUpoR0Y5Nmx4eFplNHZJSnl0Ujd2N05rZUpL?=
 =?utf-8?B?S3ZUa0pFK08rUXhBeUZBTzVVTGpMMVYyVm5tME5tbFRtenZROFZUQ0UxMG9h?=
 =?utf-8?B?Wldwai9JZW1WWGx2ZHFITkJjc2dBaE1WUVBYU0gybFhJM3dTUWNjYjZnb2M1?=
 =?utf-8?Q?Y5pguaMLOrz/xg4MVynLhcFKHIVS0i/fke//Vsdmp4qv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25DFB62AB9FD4B4189482852698F1940@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 594f64d8-b1c2-4967-98ea-08dc32c1ce71
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 09:45:15.3211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MsJbHudMmP3bYq8xyMirF0qDKWZhZBHOxHrA7FXgcXZ2RvRrXKuCN9sPMRbPlH5teKVR6OzI52IbpDOfECv4Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

T24gMi8yMS8yNCAwMDo1NCwgTWluZyBMZWkgd3JvdGU6DQo+IE9uIFdlZCwgRmViIDIxLCAyMDI0
IGF0IDExOjE24oCvQU0gS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPiB3cm90ZToNCj4+
IE9uIFdlZCwgRmViIDIxLCAyMDI0IGF0IDAzOjA1OjMwQU0gKzAwMDAsIENoYWl0YW55YSBLdWxr
YXJuaSB3cm90ZToNCj4+PiBPbiAyLzIwLzI0IDEyOjQxLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4+
Pj4gRnJvbTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPj4+PiBAQCAtMTkwLDYg
KzE5MCw4IEBAIHN0YXRpYyBpbnQgX19ibGtkZXZfaXNzdWVfemVyb19wYWdlcyhzdHJ1Y3QgYmxv
Y2tfZGV2aWNlICpiZGV2LA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPj4+PiAgICAgICAgICAgICAgfQ0KPj4+PiAgICAgICAgICAgICAgY29uZF9yZXNjaGVkKCk7
DQo+Pj4+ICsgICAgICAgICAgIGlmIChmYXRhbF9zaWduYWxfcGVuZGluZyhjdXJyZW50KSkNCj4+
Pj4gKyAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+Pj4gICAgICB9DQo+Pj4+DQo+Pj4+ICAg
ICAgKmJpb3AgPSBiaW87DQo+Pj4gV2UgYXJlIGV4aXRpbmcgYmVmb3JlIGNvbXBsZXRpb24gb2Yg
dGhlIHdob2xlIEkvTyByZXF1ZXN0LCBkb2VzIGl0IG1ha2VzDQo+Pj4gc2Vuc2UgdG8gcmV0dXJu
IDAgPT0gc3VjY2VzcyBpZiBJL08gaXMgaW50ZXJydXB0ZWQgYnkgdGhlIHNpZ25hbCA/DQo+Pj4g
dGhhdCBtZWFucyBJL08gbm90IGNvbXBsZXRlZCwgaGVuY2UgaXQgaXMgYWN0dWFsbHkgYW4gZXJy
b3IsIGNhbiB3ZSByZXR1cm4NCj4+PiB0aGUgLUVJTlRSIHdoZW4geW91IGFyZSBoYW5kbGluZyBv
dXRzdGFuZGluZyBzaWduYWwgPw0KPj4gSSBpbml0aWFsbHkgdGhvdWdodCBzbyB0b28sIGJ1dCBp
dCBkb2Vzbid0IG1hdHRlci4gT25jZSB0aGUgcHJvY2Vzcw0KPj4gcmV0dXJucyB0byB1c2VyIHNw
YWNlLCB0aGUgc2lnbmFsIGtpbGxzIGl0IGFuZCB0aGUgZXhpdCBzdGF0dXMgcmVmbGVjdHMNCj4+
IGFjY29yZGluZ2x5LiBUaGF0J3MgdHJ1ZSBldmVuIGJlZm9yZSB0aGlzIHBhdGNoLCBidXQgaXQg
d291bGQganVzdCB0YWtlDQo+PiBsb25nZXIgZm9yIHRoZSBleGl0Lg0KPiBUaGUgemVyb291dCBB
UEkgY291bGQgYmUgY2FsbGVkIGZyb20gRlMgY29kZSBpbiB1c2VyIGNvbnRleHQsIGFuZCB0aGlz
IHdheQ0KPiBtYXkgY29uZnVzZSBGUyBjb2RlLCBnaXZlbiBpdCByZXR1cm5zIHN1Y2Nlc3NmdWxs
eSwgYnV0IGFjdHVhbGx5IGl0IGRvZXMgbm90Lg0KPg0KPiBUaGFua3MsDQo+DQoNCnRoYXQgaXMg
d2h5IEkgYXNrZWQgZm9yIHJldHVybmluZyAtRUlOVFIgaW5pdGlhbGx5LCBidXQgaXQgc2VlbXMg
bGlrZSBpdCANCndpbGwNCm5vdCBoYXZlIGFueSBlZmZlY3QgPyBnaXZlbiB0aGF0IHByb2Nlc3Mg
aXMgYWJvdXQgdG8gZXhpdCA/DQoNCm5vdGUgdGhhdCB0aGF0IGl0IG1heSBhbHNvIGdldCBjYWxs
ZWQgZnJvbSBvdGhlciBwbGFjZXMgZS5nLiBOVk1lT0YgdGFyZ2V0DQpvciBhbnkgZnV0dXJlIGNh
bGxlcnMgOi0NCg0KbnZtZXRfYmRldl9leGVjdXRlX3dyaXRlX3plcm9lcygpDQogwqDCoMKgIF9f
YmxrZGV2X2lzc3VlX3plcm9vdXQoKQ0KIMKgwqDCoCDCoMKgwqAgX19ibGtkZXZfaXNzdWVfemVy
b19wYWdlcygpDQoNCi1jaw0KDQoNCg==
