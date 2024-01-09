Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109939FC5
	for <linux-block@vger.kernel.org>; Tue,  9 Jan 2024 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DuUINePN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUc7wsv1IgEK4sT1VqxpkIARgDcl4i7dqDTHqvgaHxHgDn9iif29qFrwRpeEu2Cwc+ZGG2B7stW+/Uw1/djFKd0iujHpc/MZLoGhHxaY69YElCV8FG3tvJAE4b4rTm3gkYxT91GbwuiKKT9KNMgyZnNeRf5vONgGy44S6ugx03hBtVUNkHuqbbDIX1QK9MyioLUUILQMyg5Xcuwa6E0fnhUOo053znN17sxlFlnxICLJvGwZRFBfpFacrHSw9Hx27Q//j4swhy8NPx+0nFtVDT7dRYtq4mjIRo/u337RYZaRiLVRVVZ1oxiEQ0e4nP7dLioHR7eTYx2Z9pLYNM7mJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCTEcAvrNNio4a91QJu6szB4Z/+JSC8Otp0TQdlNVNU=;
 b=WHKRqMi/oUA6MPnqjPeJKy4PtxzB1qA3vPvto69Rqop2TkgpQlIHJcnRPFRdmNVuarjbQ0i8WU4Tw4wbUwCwZhtGdPDZ0K0NIHHXEeKlPFYzLk5X2DKtgvkQQLLT2wV4EsG/qho6CUk175r18NF1kYrVMBcI+PqvM2i4LtNrRTZDSxF4Baf80c7StTne9wE4XPu/am3JgzyquPOAH47064sgANHVtsB4nDAS+Sfu57BEWNMmXjeMs8UTKXqwnw50hXqXlchllf/oPjwjjTTvaO/cTR92xd8YnAYXMUT0p5/uRyoeV0M4ha5BTyUkTgWOrYR5zLXjfFx99GU9dbDNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCTEcAvrNNio4a91QJu6szB4Z/+JSC8Otp0TQdlNVNU=;
 b=DuUINePNKdy0gou74BIg4sNSp0tYsFfksBNgnQp/7m1A0wJ80mzSFCSfGTgGifBWr1qtGcYwi+Z5OWKkVtD0Uhd9M1rcZOkeY39F28rzMr5k5g5kn3SzpnpZJHmcPNOkEEQ/TT/QB2FEiiBQoqg+gYnzBMCpWh3VULVn5h8LD/GinRQdSg8zUITiNhbaqg7DY5XrS8oBGuSMgJIH6sEa1Kwn0o8SGKDS6EmjYr8IOmKFWPlWnO7u+YpRNhFzXAAJJ6iqBZXarwiA3PThgwo8ZC+eTVwz8YeILjl+o2Hkmn7JqG+VUyenGkgqg3otP1AEP8v0m5pnp6D85YHR57miFA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 19:20:56 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 19:20:56 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 1/2] common/null_blk: introduce
 _have_null_blk_feature
Thread-Topic: [PATCH blktests v2 1/2] common/null_blk: introduce
 _have_null_blk_feature
Thread-Index: AQHaQuj5CR7KDBmjcEWJj+eKsURIb7DR3B4A
Date: Tue, 9 Jan 2024 19:20:56 +0000
Message-ID: <a1ed6bba-f5e3-4e99-a6a4-272c4465e665@nvidia.com>
References: <20240109104453.3764096-1-shinichiro.kawasaki@wdc.com>
 <20240109104453.3764096-2-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240109104453.3764096-2-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH0PR12MB7009:EE_
x-ms-office365-filtering-correlation-id: 11a61e23-6c9f-40ad-9eb8-08dc11481ad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7Kh1EH3je8IWxahKP+ckIeuEfeM5BvB6XrwuUuhUvIghWbZA71In4dfyhkFeHCszhU0TVlccTCj7ZyP6NhO9K1RVqlksBAlrdz/lOvwpe817iBSr5Pq+lQLKbB99v54+NzawGjT7TmhQEGXf4mXS+odSX8MV5L3UqUHxTtRZnmjvBQSQmJehwTYFkqMzbhwJI3OacG/VZRwZwQx7nRgt8qxuGhdoBQM2FOgMMovmKYSvZ2kxSKlzxHutN1h5U0O/tagQ67CKTOa99tVmHE+vtPhInV2SDLpI26SXlbFfiT62FOubxB0cM5YDP2FsR8ItI9lUtn/0mcvasb6jdj4SRAlpyP32FLXm+864oNpDCgiTqDHFEOhRlZdVcAK3sgAlr5cMn3vX+rWva1ePhc28ln935Gw4/84Sgihju4Kpj5rI2bOyOKi9s89ysr8iVXkWQpmI/vlOYgoBDXbHkFJPZaGNQltz6unbZ0HJfP9miTPqmRnMT8AgCPNJmeQ1dK88/dYuRe1DqENx276m9aodRy9pHcLzoR3nbaeEghnTrTp6zd6FgjH2LME7CGLBQNUoSC/iLhiLmF8S5TMHkQYyzaGhAr9sUV9GBfl+hD0UFPMWCmTo46Rpo4ctTNMekrW7stegqgVs1RzJRMQhBXg5ZviRsaV6whmNuEwQAMWNuStWq64uIHYKV3J/56Q64Tdh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(122000001)(2906002)(31696002)(86362001)(41300700001)(38100700002)(36756003)(110136005)(316002)(66556008)(66446008)(53546011)(66476007)(71200400001)(76116006)(6506007)(8936002)(66946007)(8676002)(6512007)(91956017)(6486002)(5660300002)(478600001)(4744005)(26005)(64756008)(2616005)(38070700009)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWtCa3RkdStzemtPaGdZOTdDTDRBK2UzYTlKOGZhazI1azlpTW92RHFBTGlr?=
 =?utf-8?B?OTkxQ0kvZHhXc092TGFKTU1uN21yZDE1bk1pSThDQUphaWpndVJScHdMMWVw?=
 =?utf-8?B?Y0ZaNjd2NTFjWkxoWkRYRnpHeGtKVWhVcGQ4YjZUOC9Eb0hFa1lLRmY5NXR6?=
 =?utf-8?B?MFl0eGt0RGhCcFpKMDh0bFFMWDJCL2xBV2NFOHBNRCs0dnZaYVZDTHRBOVBG?=
 =?utf-8?B?WjdQKzhvRTVHaG5ZU2lsTUhGT3F2VE9UZm9udnd6UEVwREZkeGduNXFOdWJp?=
 =?utf-8?B?eE9mNnNKRUhpbUN3R0xLTnVUQ29nY1c5aGxFdU9VSDdaa3d1K2oxcWx2aThX?=
 =?utf-8?B?eUFESExmcmFLTVpCWnNDUW42QjM5K1BPU3plN0Y3QlNCSWt1NnAyRW1MaUh3?=
 =?utf-8?B?b0l1MFlBTlFJYzNadW5mNDJvbys5enVPNVYveHRWMWo0WllkVldvdjRpZUYy?=
 =?utf-8?B?TnJxaXV3UGRWNGdlbTBBV2NpV1dwRG0zL0gxMDRPTmtxYkpoRkhKa0U4aHZq?=
 =?utf-8?B?ZFFvUHJLRm9uSWZDRnZoYVl2M0tqRUdKWFdkK0pCdysxVXJvbXpFWkYyUE9V?=
 =?utf-8?B?QU4zOHVlbGY1V2kvVnVVUmYzdk45Tmx0eUEvcEhUU0orWHpxNzVlSGYwYmxz?=
 =?utf-8?B?dGljNFNnMHNHWHNtSWpnQlJRZVA2Z09NOTJvOGZ4aWpwdVpubnRkQStHL2Vr?=
 =?utf-8?B?RXFrbnE0VGI4WTFRVHBNMWI3TE1UTFpNYmxOWXpjejNraUxWUGhWcXk3MFA5?=
 =?utf-8?B?UGNyYmExbmFhMkNrL0ltOEl4MFdNdlVvWkFpclZhNTVGczZhUTBwY252ajQ5?=
 =?utf-8?B?elBoaGNIazFRVFI5YmZ4a1NSajJjUzhnZHZGUzRtZEpheWl4M0RkYTNYdEJV?=
 =?utf-8?B?cGcrVU9uUWlWc2dzUkNjTGwxcFFCVUxEVzNkdnQ5ZVVsUUszWnBEVy9yRi9n?=
 =?utf-8?B?WlZRaHY0REVjenhmbEVNTXVRemQ4MkR1SGVCeWVVZVRYRUc3Y1F4N2JHMHVz?=
 =?utf-8?B?L2xKZFFMdmdacDBZeHpGVU01RWZ5Y2crSkptOTN4QS9uOHlCWkptZWZVUk1R?=
 =?utf-8?B?SGtwT3c4VGJEdmNLRm5kMmdVOE1EODJHaEhtWnNwdFJ0WlBoSWY5cGF0TTJR?=
 =?utf-8?B?bkVYamJCWWRrUlI5U0NUTFMzRGR4enpvVSt1ZlYray9XczYzdVY3dzMzMG9l?=
 =?utf-8?B?RUFXRmFiNGlod3JxVEVPOEZuRmFvM3RSWGxWRUhsYU5OeVpEeXJuWUVHdDFI?=
 =?utf-8?B?S2dvOUY0QjZjMDdVV2R6cUkvWC91SGJpbUcxeUs1ajg5eXoxTlV2TjY2bG55?=
 =?utf-8?B?bjluVVViSVNKbnAwYXBodFQyaFpla3I0ZlVPd04wdUVzNjNkTTFBQVVKTzdl?=
 =?utf-8?B?MlNWMDRBbWx2QTNneW5LOCs1NytzSE5Xb0JKcExzVy9razN2c0FpM013R1FC?=
 =?utf-8?B?eFJuNjFqZGNpRVQ1UW1JeXR5MlZmRXJtSkZqYnV6WVJSdlRrY0t6a0JTekR2?=
 =?utf-8?B?V0lUWjA4WEwzdzc2MmJkZGsxZ2s0aTZnT21kU3R2eFhRbldCbTNhT2wwSFl4?=
 =?utf-8?B?Rmp0eXUyUzdYMXpieVI0N2cxYWlBSUxEYmJrdXRaL1dnVXZoRTZ0K1NUbExO?=
 =?utf-8?B?czlpMFJRaHdiZXdPQ2dlc1NCZTRBNjFRN2ZuRGZVdlBEOGlZRytyUW14L2pV?=
 =?utf-8?B?WnNMQXpiQVNLTStyTGtESXYrenVDVFFtTERVT3U4OWFwbGpnbnBqMnZpK1JW?=
 =?utf-8?B?TllCcktKNXN6aTJuQjJWS01ic2xhdC9yMmRYcUtnUlV2WldLR3RqanUzNnZK?=
 =?utf-8?B?TWR2dEorT0RaVDJyRzQwR1IwUkhxZkVqZzlOcVgzVkJQQVZGd2NhQWJ3MVEv?=
 =?utf-8?B?dytldG5jV01PQzBPS1RGa2t3d0dhRmhVQXFMRVpwRU9KYlJ0ODBPc3ovQWl5?=
 =?utf-8?B?Z3pycmsxMjBYamhBODNvdSswZ245MU9pQm4wcWtMUCtleVJRRGVkdXBQWFhn?=
 =?utf-8?B?Qy9SZHRwdVN4My9QdVpzR2lHOE1oOXo2K3doMWtVZUlJUXVVZk5rM3pMWlox?=
 =?utf-8?B?WThOWUljWWE2elo0YzdSS3N6bW1ZZlNMaUNMV0w1TDdXR1hldkc5d09GMFJw?=
 =?utf-8?Q?GsI1nujDegujI5UT6F1fNZRLq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <796B1C83B065E640A19E414A167F7328@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a61e23-6c9f-40ad-9eb8-08dc11481ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 19:20:56.4854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VsIdsGX2OBTaXESamPoufPydAqHuaZBcHP/6r19mUofNJ2o/qrFa/VkcC2mJFKC0krxehLWgwQhRJUoFA6KzrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009

T24gMS85LzI0IDAyOjQ0LCBTaGluJ2ljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gSW50cm9kdWNl
IGEgaGVscGVyIGZ1bmN0aW9uIF9oYXZlX251bGxfYmxrX2ZlYXR1cmUgd2hpY2ggY2hlY2tzDQo+
IC9zeXMva2VybmVsL2NvbmZpZy9mZWF0dXJlcy4gSXQgYWxsb3dzIHRlc3QgY2FzZXMgdG8gYWRh
cHQgdG8gbnVsbF9ibGsNCj4gZmVhdHVyZSBzdXBwb3J0IHN0YXR1cy4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogU2hpbidpY2hpcm8gS2F3YXNha2kgPHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4N
Cj4gLS0tDQo+DQoNCm11Y2ggbmVlZGVkIGhlbHBlciBmb3IgYSBkcml2ZXIgc2luY2UgZmVhdHVy
ZXMgY2FuIGNoYW5nZQ0KYWNyb3NzIHRoZSByZWxlYXNlIG9mIGtlcm5lbCBmb3IgdmFsaWRhdGlv
biBjYW4gYWxzbyBiZSB1c2VkDQp0byBza2lwIGNlcnRhaW4gdGVzdHMgLi4uDQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=
