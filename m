Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745231C30
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dl/gCBmO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2f9LSftMhgHxhYezGY+a+QSqeX/11dF7gVGEWglwpd8W+TGCF9j0ebOABiJRsxUkv+tM5ws58/64sLfRh657H7bXnzoCD8hFx3LSsfhSmqiTjzuAZMx2Ws1zCGWAEXV/P/3dV8sNjMPHjG5pP2/j1A8sRjxbak2M2fkKZqMr8C2no3ySC+K27grHdCZx831MOb4+qFcmG041eK3rExjupmwYBy4ClfDobHBaQczIq16D80e3LA0Os8/sCZ9l13U6lXPVVEQGwyBDLbGwJH9NDvu22TppVt7hRcpgoIfwjmF21fdydgtCKB6int79fBAUbpR7gXDsmNmNZe2CaaB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDO6gI4VfRIuMblfYKX+KrUgAu3/8kR70Ba3m0uiaOk=;
 b=cvvfakDGx2y/qjgIagYbb4DbhQoZxiI4DG1kEzUpfBegDoGWUehs4CSlG2eBJKsopJRWUD12XxUgskVbmsj8uTNkCEHlcmGtxhFGbDP7YJ1U1nWkK7tYpR0edivf5N8UXFmsFcUk40dhJ2fhMuLqenfv6TyFLKVEcUQBXCvUy8IWwQVpeD2w8/a/IG2SK9C6TYq3htsf8fReB++90lh+Mn3bxQ5rorkCX0h8qB63kw+e3i9/CxP8YFD7jFTN1ze2jmO51/4xmquERBYVo0ef/dUx36GoqCDnebnRGUmMmCqgPMKpqlj6J4Mj7/1eQhIsMpOlelgwZDgAu9v2cdUESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDO6gI4VfRIuMblfYKX+KrUgAu3/8kR70Ba3m0uiaOk=;
 b=Dl/gCBmO0wtRaMM0YRCITyLype/1uWW0PAao+qZt0KexiY/BeXYu7xum2ygu5/1Nn4KaaXdAjl9jHvgtgMklb9TcCrLuznbeEuQAo8LXB8mKg6qw2+MXDxExyGIqz7QMUxhKck0nOF0jYn7UkPAeS7Gx1+cFZkZ+VuJpwSerJIIkFQf4jiJbSNslo/HP2G4Nvq0zFNLO61kZS93G9ANnaCeEQTVyGdwA88D8iTM4jil0RJ3/XciP3MStuUHdY1vtA6+6B9NAj+Tu3YIkeie1/gz5LHBRsWHhZu2hSq80hPbumlm/Dk+CNrGrn8qZdMO1eGEQj3WG38+78BjzhjRT6Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.27; Wed, 10 Jan
 2024 23:51:35 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 23:51:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH] nvme: add nvme pci timeout testcase
Thread-Index:
 AQHaQ3lDV0aWrUFAIUCtA7cIZYYqELDSkmGAgAAXHoCAAAQIgIAABOuAgABx54CAAJSagA==
Date: Wed, 10 Jan 2024 23:51:35 +0000
Message-ID: <0e02391c-c3cd-48db-8ac9-6e21cf617107@nvidia.com>
References: <20240110035756.9537-1-kch@nvidia.com>
 <CGME20240110062350epcas5p351f5b4f8e27b3c57545b49509d2a48b6@epcas5p3.samsung.com>
 <20240110061719.kpumbmhoipwfolcd@green245>
 <b09c8885-9907-4616-bf80-68ca145a1eea@nvidia.com>
 <20240110075429.4hqt2znulpnoq35h@green245>
 <aa82e427-a599-4cef-80bc-fac5bc517335@nvidia.com>
 <d921a213-df5d-45dd-bc37-99f3034a1a03@kernel.dk>
In-Reply-To: <d921a213-df5d-45dd-bc37-99f3034a1a03@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB6834:EE_
x-ms-office365-filtering-correlation-id: b94ff47d-bcbb-4384-8008-08dc12371463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 w47Q5pxj8GizYosgl+KhYt49U6EvYh34DVCjRyt6ODQT4XI+RUAd5HVezMsL0HCcDQU4/EymK/7G7jiHSIKlhS7XWn2fwY5GHZWSeeTnhxUrNSm1CXXHglyXcL3pI5p8ghGiLoolUDI4Fd7OK1MyXHzic6r+rRYAkQ9pyPDwN8X8dSqIVOZkBrYRFb/EUuVwi+QE9ukHa/p4QNsUm3h1ViG85obi4rm/sjCtuNP1j7nhSCdCjYOQJShwgl7jkjzsZLQSqCakhIeydiSIHcvvdjAnNgwadk9x1mjOhRN4VBkw35vq24j0JqKTpMp/nKUnarrqLv2USaT8Ia+TvZoUjOT3Bqi0dB/z2+s7OjeaE6Z2f3pxEzo0VXK1Hk/Rk+F1EfxJhEt2hXa3MT2MYT4q4iWeW7N86l9njbplZI5jz6rOLuY96FpOJa1NI+Y/etPf1geSclH6MNXwOFqkaBnj+TFoEOw37nGXDyKcTWssLRW30RmVtjEY9APnqF4kTVuQxgO11bBEWw+u6hnDp69oNmLbZTgo8tBD5RLp5eku/spe3Q0yRu6eQxNKbUBjIkXC/XzapEK2I/WkYSnc3C5UZaXhbVkb8kdGlvlib/IFTOfyBVmmk1z7PRKFJxctr/zeuiUQiLo6lFYI06pkbaW0jXCTr5LRGlay9SVa3rTZ3y6fVRG59jn4hkl8rGOMXAVY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2616005)(478600001)(71200400001)(6506007)(6512007)(31696002)(53546011)(5660300002)(83380400001)(2906002)(91956017)(41300700001)(76116006)(66476007)(66946007)(4326008)(8936002)(8676002)(316002)(6916009)(66556008)(54906003)(64756008)(66446008)(6486002)(122000001)(38070700009)(38100700002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFBJSVQ4a0wzSEE4MHlVQ053TUEvbWtDejZoeHJwV3ZjQWszbFkrMmRpVjFq?=
 =?utf-8?B?aW9qNlBXY2gxTTA5SEVhMnZ0a1Z4MlFWeFBudzQ3Q2FQSU0zNUZuY1lSRis1?=
 =?utf-8?B?dnZTQk1XT1hOcithekFtZzRBcm1XZ2E0NTBtM2dNbmVQZGRYb0UwM2hYQnpQ?=
 =?utf-8?B?ZExYMHh0ZWxLbDJwd1NtbDAvclVuak0xRnUwTkVuL2pYTDYrRWNESkhLNUts?=
 =?utf-8?B?WmFjV1QzbWIwNkpVM3hmQ2Vac0lWbXE5Zi9mYzlJK3hkcllUNC9CbEQwZDZn?=
 =?utf-8?B?MDNveWUvdjJZM0Uxdk5ySi9Ba3hvWWxKdG5FQUdvSXkxM3FYTGpyMGdHV0Ju?=
 =?utf-8?B?cEczbGxXWGhUcllwUS9RZGRIVjV0d1hqelVBZ3JxdXhZaHdSeTAxY21JWStF?=
 =?utf-8?B?RjZ4ancwUkRDbzdwKzdDOHZPclkwMDJvaXgxWktvbnBNdzhaVU9YcHo3U0hv?=
 =?utf-8?B?a1MwS1V6ci9yZ2RLU1pwVnJzWEJOeTFJZkRXT0dCQitscmF3Q25lRUxFWHVK?=
 =?utf-8?B?ajZ4RjZnTkgwRFlEeFluM3drR05GTmZUVzlkb2I2Tm1Cc1RxR3o3UlVRaXE3?=
 =?utf-8?B?aWJlU0Z5RzdWc3lEWlNLOUlTaC9oc01QMEJBQ0RSdXhMc3lUdVBxbTg3bWJ4?=
 =?utf-8?B?bnhLNEhkMXIrWXJQcXBwRVlHZmIrNkFlM0NqMUJTQlo4L1BZSG5VUHVJT2Z4?=
 =?utf-8?B?c3dnV0MwaVE2VG9RZEM2ODNnMmFJay9Wa3pydVdYZWxha2QwOEI1ekpDaUNC?=
 =?utf-8?B?a2JXYlA4ZmxDSUJRenBsMXhEOU00dzk1L2RrcFdqbS9RcUVjR0FoaWJ3QW4w?=
 =?utf-8?B?QVVsbllsenoyaEVFaWgvREMyN2czdnJsak1XODYyMnBjK3hGU0JsQ3QrRTdT?=
 =?utf-8?B?czBvL0RKdmtsZHdBU2dhUVpVeXVjV3h2N3plSlY4Q0xLNVBCYUszT2FmNzQ1?=
 =?utf-8?B?Zk1OeVlQWWF2a2wzQThadVp2djg3enJMcXdmdHllZDVIc3M0WGsxTmw4eEFa?=
 =?utf-8?B?b0RlaFRkZE13TlVXZFJGeG1nZXBreHhUdHA3UEI5VHlGU2VZSitJRlk1SWc2?=
 =?utf-8?B?ZHFqdXpBTGRZNUIrWEkyQk9IRWw2bEVxMDkwc2hjUWdvYkl4VlVSSFBKWlVx?=
 =?utf-8?B?bklMeTB0Z1V1OHRXYW1IbHNucHNWS2FCZnFNdmY1SlFjZytsekEzcGlnTzF0?=
 =?utf-8?B?QmdUSWNSbzh6YjJQQmF0Q0tnSWwwN3hGa3l3MTBLbU1aMDBQblZBOCtSNG9j?=
 =?utf-8?B?TmRBQVRFdEl2N25BSXBCRnFhamtvQWlKRU5VRjJlQ0pmeS8xM1BDTnl3SlJj?=
 =?utf-8?B?dVVwQXZaTHpxKzZ0KzhkTEFPaHFPbGdialJ0UGMwWDhtS3JpZVNwbDBqa2Z4?=
 =?utf-8?B?M3d2ek5aWFdlYmU3S1Z6aGFMeWwyb2s5N1dPVjFVcDVqb05ZbnlHN1EzQkds?=
 =?utf-8?B?dXFuZm9ZYWtnU3FUTDhFR2ZjUjFpMkFsek5ZRnVSdmI5WVFyNkJhNzM5MWpW?=
 =?utf-8?B?OVg4TmZnQTNSVm9MWXlYbnZqZHkrV2VmbC83YU9WWTNvbkRGUit1ZFcrbExk?=
 =?utf-8?B?Mll6QXVqN3kvblRuR3V5N2FLVlIvK3F1QUROSnBRYXhqNC9YMTJDN1RhQUFW?=
 =?utf-8?B?NW90VmxyUTJzM3ZtdDVCLzdBejdJR1Rodk80aEVKQUNWekZXOUdrUGNMY3BH?=
 =?utf-8?B?MFBXUTI2TUQ2T1YzdFlDSmZsVFdiRnZKVjlaY1NMZEVib0NpdzBnSlNWc2pu?=
 =?utf-8?B?enVJQ21yZStwVXd2WnM3ZWJERHUrbEZ1TTlrc3JGR0NRM1BRSGJKY1lVVWpq?=
 =?utf-8?B?SDJDd1B0WjlBWjlaNy9uOG9FVjJZV0xDL1g3OVUwSER1RmJGSW80enF3UzVR?=
 =?utf-8?B?UzlnK1FqSGVsWDVUci93OHVubDJSUjVKYllGTlRFUXZOTkxNZi9tbHFIODlm?=
 =?utf-8?B?SHkxMFZlQkIyUXlzSGdIbENpSnFaZEtIY1U0aEFsZjhJV0hwT1BLc1c1Wlh1?=
 =?utf-8?B?MlEwVTg4TmdHUkhRL1ByejFhcS8ycHAzcnppWkoyZThXUHJNTDIzSHJtL3E0?=
 =?utf-8?B?aS90ZnhKYm1IVjNLQjJycXpIU1pxMmo1c05LWXBTYnZINjcxSU94eXBZMmtp?=
 =?utf-8?B?S3Y2dWZ0MXBFMHVlT0dtTXpGSjlWUFRSZkNWdzJiMUJqRU1BNmxYdWkyS05o?=
 =?utf-8?Q?xeUnZGOK3trPEv3B0MwuM2f1omrcbBF0HJIO7uN83AwD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A06274A32906F94AA16B94F8EF54B572@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b94ff47d-bcbb-4384-8008-08dc12371463
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 23:51:35.3708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jm5WQLBHX62LCy3eS4NJs6OvIhahxUeI59z6y5Q8tRXBrZLjlMo1KbASffoCdAtgrvilPdlg3u0+djSvmBcBlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834

T24gMS8xMC8yMDI0IDY6NTkgQU0sIEplbnMgQXhib2Ugd3JvdGU6DQo+IE9uIDEvMTAvMjQgMTox
MiBBTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4NCj4+Pj4+DQo+Pj4+PiBTaG91bGQg
dGhpcyBiZSBURVNUX0RFViBpbnN0ZWFkID8NCj4+Pj4NCj4+Pj4gd2h5ID8NCj4+Pj4NCj4+PiBN
eSB1bmRlcnN0YW5kaW5nIG9mIGJsa3Rlc3RzIGlzLCBhZGQgZGV2aWNlIHdoaWNoIHdlIHdhbnQg
dG8gdGVzdCBpbg0KPj4+IGNvbmZpZyBmaWxlcyB1bmRlciBURVNUX0RFViAoZXhjZXB0IG51bGwt
YmxrIGFuZCBudm1lLWZhYnJpY3MgbG9vcGJhY2sNCj4+PiBkZXZpY2VzLCB3aGljaCBhcmUgdXN1
YWxseSBwb3B1bGF0ZWQgaW5zaWRlIHRoZSB0ZXN0cykuDQo+Pj4gSW4gdGhpcyBjYXNlLCBpZiBz
b21lb25lIGRvIG5vdCB3YW50IHRvIGRpc3R1cmIgbnZtZTBuMSBkZXZpY2UsDQo+Pj4gdGhpcyB0
ZXN0IGRvZXNuJ3QgYWxsb3cgaXQuDQo+Pj4NCj4+PiBSZWdhcmRzLA0KPj4+IE5pdGVzaCBTaGV0
dHkNCj4+Pg0KPj4NCj4+IGl0IGlzIGNsZWFybHkgc3RhdGVkIGluIHRoZSBkb2N1bWVudGF0aW9u
IHRoYXQgYmxrdGVzdHMgYXJlIGRlc3RydWN0aXZlDQo+PiB0byB0aGUgZW50aXJlIHN5c3RlbSBh
bmQgaW5jbHVkaW5nIGFueSBkZXZpY2VzIHlvdSBoYXZlLCBpZiB5b3VyDQo+PiBzeXN0ZW0gaGFz
IHNlbnNpdGl2ZSBkYXRhIHRoZW4gX2Rvbid0IHJ1biB0aGVzZSB0ZXN0c18gc2ltcGxlLCB3aGVu
DQo+PiB5b3UgYXJlIHJ1bm5pbmcgYmxrdGVzdHMgeW91IGFyZSBib3VuZCB0byBkaXN0dXJiIHN5
c3RlbSB5b3UgY2FuJ3QNCj4+IHByZXZlbnQgdGhhdCBieSB1c2luZyBURVNUX0RFVi4NCj4gDQo+
IEl0IHNob3VsZCB2ZXJ5IG11Y2ggYmUgcG9zc2libGUgdG8gcnVuIGJsa3Rlc3RzIG9uIHNwZWNp
ZmljIGRldmljZXMNCj4gT05MWSwgdGhlIGludGVudCBvZiBhIHRlc3Qgc3VpdGUgaXMgbm90IHRv
IHBvdGVudGlhbGx5IG1lc3MgdXANCj4gZXZlcnl0aGluZyBhcm91bmQgeW91LiBJdCBzaG91bGQg
T05MWSBvcGVyYXRlIG9uIHRoZSBkZXZpY2VzIGdpdmVuLCBub3QNCj4gcG9rZSBhdCByYW5kb20g
ZGV2aWNlcyBpbiB0aGUgc3lzdGVtLg0KPiANCkknbGwgbWFrZSB0aGUgVEVTVF9ERVYgY2hhbmdl
IC4uDQoNCi1jaw0KDQoNCg==
