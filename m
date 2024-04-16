Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A0134BC
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 03:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713236557; cv=fail; b=QT6wrMsZJGGMvMRzTyE/Li/A7cqX1tj32mJ8C4lF76Ie6TppYIclqUp74AmGpPVeSmfI/YstDa0Zes8ybHHdT8zkSgl7ERipQ2Q6dtHX9YO5E5amYz00JaoaGDGi7chDJiC5Dqhhtblp14P/wGiXiT2jKe/8kGZaevd+goq5OBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713236557; c=relaxed/simple;
	bh=eMWZuICbR1rYuwe41T+U2TubgPc4qZ95QaH9fabYYoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kyQbfvaYrSBzwXDb+XSeKAMcD2wV1z8OeSQHtcbO5zsEMhQyh9lbVGzaBNinAZERpWP+vAKsUjqFclZCTUrOKaE/tZ9EFZmlA3lDrbuMJ8tIlquTSKWZHyK36NkdtxYyrprmmX5PZCdM5bLY/r7gPg/SJkzYWVeYD8ri+JRJDSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kUQscZMn; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kUQscZMn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNoez7VeGLv1sTpHLKRL3JoEtdPjp10DnZQs6Q0QKJw8q1RYBYNHeIAmZNbptycE0x3tzC38p24s+9bpgFplD+XUAZuS8oZhCcqH3fOU80OHned0joFFrrjxgiFFGUUfiMRySjSie3g49YZumdpO8cviEqskYY1vE+ScOyUSQBsiqycSV+sEcfmEso1Fa8ma8I5qJqXTvQwkl+K6GjK80D3Z7XQCgxRGagtIdkc7ArH/kq3XXWMPi0w2QCILsO50DiSyRO56NdKB8dLkrydW5Am4X1kGVAPt2RvV+HMtaivO9GvgXohB4Qy7YTxpU0dbpwD/KzW1ybEH1RtYlYt68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMWZuICbR1rYuwe41T+U2TubgPc4qZ95QaH9fabYYoM=;
 b=NDS1pRmnXvnDV/x6POCi0+bjvNI45StOC+94PsCwhFPOLh6P+s7f7IvFiB4ASRatBEmf6qAPCo36YmoPrWdfTVgOw+lH8is+hZGcMlmScBW2toxjGfoCPJguqCabtaEmkdcE0RZ5xhcEMEf+nUPgatohKgfu3xQYnem5oZxv5Y8UmUMjc1gl2koJrkbE5/25E31TAOQddMDL/QIG9l/V82rbe2B9CmKKsFMQFUzDg2KuW9AXWJMIhkw1EKs0C5WnvzNMuVJEx3JFncciejHUpXxm4Dv45jml+2MKVMLYBtSQVvyYRxE8Ifc8F/dosqFF3VAJ7S5O4LDpZg7yyBYFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMWZuICbR1rYuwe41T+U2TubgPc4qZ95QaH9fabYYoM=;
 b=kUQscZMnAjB5a1+eakpQN17XEmDi93VrS41+eGi3RnCWWzZ1YCraWPcEF6N0mt89mVwXd0wjBbIeo6zrb3Xa6qxJyvN2PUi3BfSG76H0WrZqwhyKKBgVnemvpNF3sML1ZYFexzWsE/rRzVmph0m0spFNF6Fs2+zlYg3w1tbJMqRF2bQ5TdM4+rWyhvInKZeXu+wtfEbcjhjd2G9XPtTDs3UJYOYVViHeZE9rrIvm4ytLBt7HPJNZXDkTzau8BNOXXUqaO3gFSI4Mnwfc+o2RbQgiyqECSb13N/3t/DMqKyvG+uAljp88wbfqDlA67W3jnQClYlaJDpwl41/C7w481g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 03:02:32 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 03:02:32 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: "yukuai3@huawei.com" <yukuai3@huawei.com>, "yangerkun@huawei.com"
	<yangerkun@huawei.com>, "tj@kernel.org" <tj@kernel.org>,
	"saranyamohan@google.com" <saranyamohan@google.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH blktests 1/5] tests/throtl: add first test for
 blk-throttle
Thread-Topic: [PATCH blktests 1/5] tests/throtl: add first test for
 blk-throttle
Thread-Index: AQHaj6MthPQacGq6v0qj0Tv/Bbybq7FqNcSA
Date: Tue, 16 Apr 2024 03:02:32 +0000
Message-ID: <c14a95c9-64a6-4929-9213-3f81bf118399@nvidia.com>
References: <20240416020042.509291-1-yukuai1@huaweicloud.com>
 <20240416020042.509291-2-yukuai1@huaweicloud.com>
In-Reply-To: <20240416020042.509291-2-yukuai1@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB7233:EE_
x-ms-office365-filtering-correlation-id: f0ed6c06-56ac-476e-4a3a-08dc5dc1a8bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ClgIeoXBsRqjVvwLbnZU1OJ1UXdzFky6VNxu10km7CFf8JKaUS3iY+d2hKqFHbmmlsjbFmd6HxpkD1+576XlRN63AGJSAVLjHvOATWL9ywNjNwKEvg4WbUnv0IsKJPSeCll9Eu2MQCW4PxvdhdKcPszB2Id2qiCJIF6sHWHmnmpH2Vb7lGWqvdG9aD0cEnJJsojkKI5PesRwnScQ6zfKDB+09dmRxEKJY8jkWXGB8YC409k2H3ShaAZzpbJYgXxtscIqjAvIBZEviQcN0QZGq9YXzedHpLFBA/t+rOWyJ8Yxeg8F4+KBtWIfFqt3MTx9ZlgHb4LuRd3Bxaq7RbihDNopYZnp2RDDdT+EVKZhwQuVu7Ss0tOVhcvXndbFAUvtb7fs+/hCaGsp2ExlA35BGSJlttRSIIK5UZCgh3ugXr+k/+oHOet3E1INTpVS7/00GdKUmUo/KPbFwVJg34IB66dKD7OzHMRTBbrI0vdG6Px1r8lP9JsAVHDIBpfB5vbGsmnyGdS5F6Y8Wr7SqvhC3Eiz29puOW9mGXWJUNSGLHYem3CCrt95GUr2lc2HRYkwnfXWtWnwK5zcaRg7uIDxxaK6XgGVc5iiV3hk/dn2mndRfpNvQjKesFp22Gs8D15UaFb+jFvC5iFzHoiHJH+f1jGFaEwtrcwZDhbnOZnC28VTJmcJtH2Ecu6mFNvM9gFzjNL4+LUX6P+5n4ZQvLw4N6eBeI8C5c5hl9ieyK7+a5k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1lXNnNmcDZaZXpWMWh0a2g3a2FDRnNpSVFWNnVKQXJNQmhZeFh0Tk1MU1Uv?=
 =?utf-8?B?UERZT3VTYksxamxmN1NlSWI3N05ETE1YdEMyZUhwY2x6dHNQRytxakZXdExE?=
 =?utf-8?B?anhoakV0VkFja0o4UGM2eTB0aFZQZ0dFZTJQa2JyUzZra3owbEJVaTlUOUpT?=
 =?utf-8?B?RXp3T1FZK3ljMUZ2OWd3YnBDaE9lWFhmTVRuRm1JV05Ccks5UzRnREtPVDBU?=
 =?utf-8?B?RWpQRjJ6VXFIQ0pjVCtRRDZrWnhQNlhJTDBFQjY0alhCcEdqWmdhbkV3UUVv?=
 =?utf-8?B?SzFhZmJ4WkwwQzRoaHNZYi9PVnNaK3FKbFQ0bldrSUNpQkg3blNRd2NUVnJu?=
 =?utf-8?B?TEYzTE0zY01CelEyRWtGRW92VTRrQUNsd2NuVVJzUTh2UURFd1Q3S3p2dU85?=
 =?utf-8?B?YmJvSnVnTmZZSnRqMzJ0aHJNNVA2SkFYQXB6L21sekNSeEJzRkREdDFKL0xX?=
 =?utf-8?B?bVh3RWtMSkhoek1iSTlhU25kcVE1eWN6eHBMQ3oyaHRxRmh4ei9sdFB6MXVM?=
 =?utf-8?B?bjBSaWR4aXROTXE0QzkvWUFlNWpGQmhDQkQxUlQ4Z1o1aHN0VW90OTJjUEFQ?=
 =?utf-8?B?QTREemRDRU5RNm83ZFpPOHdVaGZqcjE0bzNUbXlnRS9VMjZncDJkWHR3b1Fz?=
 =?utf-8?B?Tjd4M3EvenVsU0tqMXIybWJ6c2dQMXNnQllpbUhZY3JwNUkwZXFaQmlnVlpR?=
 =?utf-8?B?NjExa0UrT05NMnlESXN3UStwRktCdjFNZ2NXSVdEWlNrb1I3b01sdDRabEZ0?=
 =?utf-8?B?bGxvWjJzd0lRN2wzSEd1c0NoTU1ONnhlZjZWVzViR0lJa3RXQmp5WWJFaklr?=
 =?utf-8?B?VmVWbEdCSDExSytiYW5VK01IbFhxN0N1aU1HcU1SZnQ1NitOZnRtbGJkSVhK?=
 =?utf-8?B?cHh6aDd4aVZSa2V0a0ZIbkZpSVVjUnVWTjlKcGdsNk93UGRqWllYOVB5NEdh?=
 =?utf-8?B?VTh3SmFKYTRCQlYwMzlYR1UyV3N3VjZiM3lUTW12dU0vS3ZESk5IVHFRcThx?=
 =?utf-8?B?REc1SWh5blFOZjBNbFpGY1BuaGlvN21zZndDbkFDbUlFaTdhZm1WZDNsZkpu?=
 =?utf-8?B?Q1JET1BveUo0RmZNdkNZQ1RoTSs5K1J5YzFYa2tMOWlSNkpvYUtWaWJIdlky?=
 =?utf-8?B?VnRnOVhWR2tlcm1TUklDSkZEUGJsa0NkZ1lOTFNoOCs5MmNMMFRKQ050MTlt?=
 =?utf-8?B?WjlFdGczNnhXYVpXQTMwSE1oaUlWUnV1VGhyZzk2K1Z3NWhwaFlRVnV6Mkl5?=
 =?utf-8?B?M0NBYmMvR2V2eW9DMjNueTcweXNYWm50QTIrbk1nUThyUWRGWG8xV05NbGpO?=
 =?utf-8?B?RzRsZUU5aFplcnc5VlFTTU9icVp5ektVVHRJQzJ5Y3BvNlpUT2VxbStJbTBP?=
 =?utf-8?B?dkwzTEFReG54a0dRYld1TkF6S0RWZU95MFJKWEVUeFF5R2hwQ2tFTU9ML1Jv?=
 =?utf-8?B?eWtUd1NFUzdMWEMvd0ZYazhUWjVjTlFHZG9DYXFiOUE2eUdaR1MzOXdXSlE4?=
 =?utf-8?B?Q0lkSFl0dFlKeXBEbVRLeThyTUJzZWcxUFJvYTlsQ09RQVY3N0NQbTY0aVlI?=
 =?utf-8?B?anR3U3o1Ty9wejcxYjd1bEdsZWM4U2pTOEc4cDVUZ1d2cnMwQ29KOGNMaWVV?=
 =?utf-8?B?T2dYVGw3VXJDN29PWjliU1RpYVFrQ3FkYWxxZ2VGTWxSNzRHK2hNME52c2ZF?=
 =?utf-8?B?YWpGdEtEeGZLc0dGRmJiZ2xYZlhpdW9vSnFRNWtqZjUwN0lYb1NoTU95dVFl?=
 =?utf-8?B?R0krai9kaXRsdFF4MjF2RzFPTnVQY1ZRUGk3OGRuUFFDSUI2cGYvMTVmWVhP?=
 =?utf-8?B?bStlUEVhODZRRmxxUXZ0d25TZDBENHJDUTlKOStUR2UzVmNtTERiTkxQaGxq?=
 =?utf-8?B?dWM1VlNPVDMzK2YwSGJwR2NuaEJCZ2xWUHVYVFJzK0NHbjJ6ZjFyUDNTVFc2?=
 =?utf-8?B?QzZVZmR1UlhRWWM3SGZoQVNremhrbDMycE9YUVdSMFpQeXlTUUVCTFVYR0N6?=
 =?utf-8?B?SXd3cDNIY1Rsa3JiNU81dGFaQ0FZZ3EzSG5OSGVIYzh4K3l6QmRrZHkyWEp4?=
 =?utf-8?B?bGR0UVM5bGV3Uk9RK2R5SVZ4eXpiYnhhME9LcWdhUGpjNWxobVNEWUlUVWdp?=
 =?utf-8?B?SEtWU2VQZmZTRzFDTU1XNmxKYlNZckVxQ3dwYThGbG4rTTZkMVc0eG1TZEZp?=
 =?utf-8?Q?wu9c+7+0eYbuLZJJ0vS7eQ9uQiG45ryxgfKU/tRzqMet?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4EC3F3F84147B48BE69AC5A0B77705C@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ed6c06-56ac-476e-4a3a-08dc5dc1a8bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 03:02:32.0489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wnwQIpfm+n62To5m7Qwoo98PoQ9ghcr3QoWGYwv1Fc8HUgWn5HEvAQNJSZvXf7e6panPSu1vnVwWWRNteasDWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233

T24gNC8xNS8yNCAxOTowMCwgWXUgS3VhaSB3cm90ZToNCj4gRnJvbTogWXUgS3VhaSA8eXVrdWFp
M0BodWF3ZWkuY29tPg0KPg0KPiBUZXN0IGJhc2ljIGZ1bmN0aW9uYWxpdHkuDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IFl1IEt1YWkgPHl1a3VhaTNAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICAgdGVzdHMv
dGhyb3RsLzAwMSAgICAgfCA4NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiAgIHRlc3RzL3Rocm90bC8wMDEub3V0IHwgIDYgKysrKw0KPiAgIHRlc3RzL3Ro
cm90bC9yYyAgICAgIHwgMTUgKysrKysrKysNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDEwNSBpbnNl
cnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL3Rocm90bC8wMDENCj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGhyb3RsLzAwMS5vdXQNCj4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgdGVzdHMvdGhyb3RsL3JjDQo+DQo+IGRpZmYgLS1naXQgYS90ZXN0cy90aHJvdGwvMDAx
IGIvdGVzdHMvdGhyb3RsLzAwMQ0KPiBuZXcgZmlsZSBtb2RlIDEwMDc1NQ0KPiBpbmRleCAwMDAw
MDAwLi43OWVjZjA3DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdGVzdHMvdGhyb3RsLzAwMQ0K
PiBAQCAtMCwwICsxLDg0IEBADQo+ICsjIS9iaW4vYmFzaA0KPiArIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTMuMCsNCj4gKyMgQ29weXJpZ2h0IChDKSAyMDI0IFl1IEt1YWkNCj4gKyMN
Cj4gKyMgVGVzdCBiYXNpYyBmdW5jdGlvbmFsaXR5IG9mIGJsay10aHJvdHRsZQ0KPiArDQo+ICsu
IHRlc3RzL3Rocm90bC9yYw0KPiArDQo+ICtERVNDUklQVElPTj0iYmFzaWMgZnVuY3Rpb25hbGl0
eSINCj4gK1FVSUNLPTENCj4gKw0KPiArQ0c9L3N5cy9mcy9jZ3JvdXANCj4gK1RFU1RfRElSPSRD
Ry9ibGt0ZXN0c190aHJvdGwNCj4gK2Rldm5hbWU9bnVsbGIwDQo+ICtkZXY9IiINCj4gKw0KPiAr
c2V0X3VwX3Rlc3QoKSB7DQo+ICsJaWYgISBfaW5pdF9udWxsX2JsayBucl9kZXZpY2VzPTE7IHRo
ZW4NCj4gKwkJcmV0dXJuIDE7DQo+ICsJZmkNCj4gKw0KPiArCWRldj0kKGNhdCAvc3lzL2Jsb2Nr
LyRkZXZuYW1lL2RldikNCj4gKwllY2hvICtpbyA+ICRDRy9jZ3JvdXAuc3VidHJlZV9jb250cm9s
DQo+ICsJbWtkaXIgJFRFU1RfRElSDQo+ICsNCg0KbW92ZSBhYm92ZSB0byAzIGxpbmVzIHRvIHJj
IHdpdGggaGVscGVyIGluc3RlYWQgb2YgcmVwZWF0aW5nIHRoZQ0KY29kZSBmb3IgZXZlcnkgdGVz
dCA/DQoNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArY2xlYW5fdXBfdGVzdCgpIHsNCj4g
KwlybWRpciAkVEVTVF9ESVINCj4gKwllY2hvIC1pbyA+ICRDRy9jZ3JvdXAuc3VidHJlZV9jb250
cm9sDQo+ICsJX2V4aXRfbnVsbF9ibGsNCg0Kc2FtZSBoZXJlID8NCg0KPiArfQ0KPiArDQo+ICtj
b25maWdfdGhyb3RsKCkgew0KPiArCWVjaG8gIiRkZXYgJCoiID4gJFRFU1RfRElSL2lvLm1heA0K
PiArfQ0KPiArDQo+ICtyZW1vdmVfY29uZmlnKCkgew0KPiArCWVjaG8gIiRkZXYgcmJwcz1tYXgg
d2Jwcz1tYXggcmlvcHM9bWF4IHdpb3BzPW1heCIgPiAkVEVTVF9ESVIvaW8ubWF4DQo+ICt9DQo+
ICsNCg0Kc2FtZSBoZXJlIGZvciBhYm92ZSB0d28gaGVscGVyID8NCg0KPiArdGVzdF9pbygpIHsN
Cj4gKwljb25maWdfdGhyb3RsICIkMSINCj4gKw0KPiArCXsNCj4gKwkJc2xlZXAgMC4xDQo+ICsJ
CXN0YXJ0X3RpbWU9JChkYXRlICslcy4lTikNCj4gKw0KPiArCQlpZiBbICIkMiIgPT0gInJlYWQi
IF07IHRoZW4NCj4gKwkJCWRkIGlmPS9kZXYvJGRldm5hbWUgb2Y9L2Rldi9udWxsIGJzPTRrIGNv
dW50PTI1NiBpZmxhZz1kaXJlY3Qgc3RhdHVzPW5vbmUNCj4gKwkJZWxpZiBbICIkMiIgPT0gIndy
aXRlIiBdOyB0aGVuDQo+ICsJCQlkZCBvZj0vZGV2LyRkZXZuYW1lIGlmPS9kZXYvemVybyBicz00
ayBjb3VudD0yNTYgb2ZsYWc9ZGlyZWN0IHN0YXR1cz1ub25lDQo+ICsJCWZpDQoNCklzIHRoZXJl
IGEgYW55IHNwZWNpZmljIHJlYXNvbiB0byB1c2UgZGQgYW5kIG5vdCBmaW8gPw0KDQo+ICsNCj4g
KwkJZW5kX3RpbWU9JChkYXRlICslcy4lTikNCj4gKwkJZWxhcHNlZD0kKGVjaG8gIiRlbmRfdGlt
ZSAtICRzdGFydF90aW1lIiB8IGJjKQ0KPiArCQlwcmludGYgIiUuMGZcbiIgIiRlbGFwc2VkIg0K
PiArCX0gJg0KPiArDQo+ICsJcGlkPSQhDQo+ICsJZWNobyAkISA+ICRURVNUX0RJUi9jZ3JvdXAu
cHJvY3MNCj4gKwl3YWl0ICRwaWQNCj4gKw0KPiArCXJlbW92ZV9jb25maWcNCj4gK30NCj4gKw0K
DQphcHBhcmVudGx5IHRlc3RfaW8gaXMgYWxzbyByZXBlYXRlZCBjYW4gYmUgbW92ZWQgdG8gcmMg
d2l0aCByaWdodCANCnBhcmFtZXRlcnMgPw0KDQo+ICt0ZXN0KCkgew0KPiArCWVjaG8gIlJ1bm5p
bmcgJHtURVNUX05BTUV9Ig0KPiArDQo+ICsJaWYgISBzZXRfdXBfdGVzdDsgdGhlbg0KPiArCQly
ZXR1cm4gMTsNCj4gKwlmaQ0KPiArDQo+ICsJXzFNQj0kKCgxMDI0ICogMTAyNCkpDQoNCnN0YXJ0
aW5nIHZhcmlhYmxlIG5hbWUgd2l0aCBfIHNlZW1zIGEgYnV0IHdlaXJlZCwgd2h5IG5vdCBqdXN0
IHBhc3MNCiQoKDEwMjQgKjEwMjQpKSA/DQoNCj4gKw0KPiArCXRlc3RfaW8gd2Jwcz0kXzFNQiB3
cml0ZQ0KPiArCXRlc3RfaW8gd2lvcHM9MjU2IHdyaXRlDQo+ICsJdGVzdF9pbyByYnBzPSRfMU1C
IHJlYWQNCj4gKwl0ZXN0X2lvIHJpb3BzPTI1NiByZWFkDQo+ICsNCj4gKwljbGVhbl91cF90ZXN0
DQo+ICsJZWNobyAiVGVzdCBjb21wbGV0ZSINCj4gK30NCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3Ro
cm90bC8wMDEub3V0IGIvdGVzdHMvdGhyb3RsLzAwMS5vdXQNCj4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gaW5kZXggMDAwMDAwMC4uYTNlZGZkZA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rl
c3RzL3Rocm90bC8wMDEub3V0DQo+IEBAIC0wLDAgKzEsNiBAQA0KPiArUnVubmluZyB0aHJvdGwv
MDAxDQo+ICsxDQo+ICsxDQo+ICsxDQo+ICsxDQo+ICtUZXN0IGNvbXBsZXRlDQo+IGRpZmYgLS1n
aXQgYS90ZXN0cy90aHJvdGwvcmMgYi90ZXN0cy90aHJvdGwvcmMNCj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uOGZhOGI1OA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBi
L3Rlc3RzL3Rocm90bC9yYw0KPiBAQCAtMCwwICsxLDE1IEBADQo+ICsjIS9iaW4vYmFzaA0KPiAr
IyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTMuMCsNCj4gKyMgQ29weXJpZ2h0IChDKSAy
MDI0IFl1IEt1YWkNCj4gKyMNCj4gKyMgVGVzdHMgZm9yIGJsay10aHJvdHRsZQ0KPiArDQo+ICsu
IGNvbW1vbi9yYw0KPiArLiBjb21tb24vbnVsbF9ibGsNCj4gKw0KPiArZ3JvdXBfcmVxdWlyZXMo
KSB7DQo+ICsJX2hhdmVfcm9vdA0KPiArCV9oYXZlX251bGxfYmxrDQo+ICsJX2hhdmVfa2VybmVs
X29wdGlvbiBCTEtfREVWX1RIUk9UVExJTkcNCj4gKwlfaGF2ZV9jZ3JvdXAyX2NvbnRyb2xsZXIg
aW8NCj4gK30NCg0KYXBhcnQgZnJvbSB0aGF0IHRoYW5rcyBmb3IgdGhlIHRlc3RzIC4uDQoNCi1j
aw0KDQoNCg==
