Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1210EECAAD5
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 10:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiHaKoX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 06:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiHaKoN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 06:44:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8229C9240
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 03:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P88y/KYfGF53EhT+YulfvEIeug7bhmv+pdnFmOUcKGS7fe9oingXHt3Mg0Uj6za46eHFtqheSL+C+nRt/Zg7RONVFPWtQig9xsCnwkrh/dSddj6rv+oOhL9ohm43wcZ7Va+QWUlQadJR65hWW620+faVuRzOtB7vIXkPcbPSlLoS8oFjkD7pTpFnRDDy19FQdFysqnPmAXR+MblYrfAInt/1zK/ZCe+ViIwnrbYNj626N5Likfjv86W/xJQSgOkSHIXMq9dKPenRsvT5tOxqiPGxY/0vWaHlSiAmJQjf1qvaNyJm9IG1ziRyzsF5YkQanfo61DghU9XGYIww8JVmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blicLMReyPFjvQ4c3qIy1nZ9N7sUhUJjr5/zZgDAlNU=;
 b=H3DcvjrbsEQaxrCLbuINt/kOkKk9YNrpm2Dh/K5EuKm6h0rfsQh8TKagUp6Cu3xNw2QgkciSnA7fzYLEEZBzI8KjI5cObYigPjMiGV9gKmhrjTfb7ImGyhDbG7pV02WYCuBu9up2uUYht0UQasKNZ4fd5Vj8YYwGRWpNPYFZj87CCjasAZ/R+pWYaE7j2aTuLZZmh1aR4IGMUPuNeTPhOeW3yyXfYZas8j8Y5jLYj8aNbX8X7YK7nPdWDBw994+v7bnCjvPhMnwI0ePKe6ROpxWQhkhJMNrD+5HNhtOIJlr6R1d6GAKlDjzjb4M95GwsAI0uJwEJVVctcqr8NBuO/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blicLMReyPFjvQ4c3qIy1nZ9N7sUhUJjr5/zZgDAlNU=;
 b=DMKUWW1tiSYxqTlGImbh2YFlRqdi5yDWTkhdDtY0PTbh4Vc2C8O+D/3WBPk3T8XYcmVX/RBWv6XUYGwdZx3Wtyc9l0ThLqxCfU9YLvCJT+oNsjSii1GP5zTQieHDQK5A0+nYxs6ty9dENMnKj9Me9fzRZLs6bBWAndFLSyMgDciziD4PBEmFwE837xBqCwvrXDWuaZF3OGwN1/v1eNXURtIqZvqbLe1li+kkaZEQtPXGXv3Q276c0SlxxDRKaHzuuMzF2G1Gu6ErP8M+FkKshxbR3o6B/pL/MUtJLkRfuwKb/Zgl4TvGxWWuJ9SUmaJ1pXESL8LVHLEsOTqQFxIvGA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Wed, 31 Aug
 2022 10:44:08 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 10:44:07 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests] nvme/043,044,045: load dh_generic module
Thread-Topic: [PATCH blktests] nvme/043,044,045: load dh_generic module
Thread-Index: AQHYvPphn0PEpPtD4Ea8UQKZLCXHs63I0zuA
Date:   Wed, 31 Aug 2022 10:44:07 +0000
Message-ID: <7247a6c7-24c0-cea5-255a-5316dde14066@nvidia.com>
References: <20220831052729.202997-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220831052729.202997-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e4de2e1-20e1-4bd4-c2d6-08da8b3dbb50
x-ms-traffictypediagnostic: SJ1PR12MB6364:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sAXm+ydXQENqRKUbYvoesjQ9+eDt3CE2ycUqpL6zPks5Mapq78/VzzA0Ggl3GXfndT9oQJfdn0kfBBMmdXCUY6RTlHoW+yHCYVkSmvQZLbGEKwshT3ogd0szWKz6F0IfMUdhwhTLGvvFOjuuJJFrlVZjrrCqWyqK+Y/1+LJuJcEyueOLo34IgMBaxsjWFNs5amsUJDpHPNhv89+lXmkSeC+L2a1XK4HGuz42dLuN48yXmx0wX5iuq/m8d7Yv265LKdZeXdPt9Lme+YxZ/pPJYfJR043JZI46jOkQ7RYA+AQCvqrhC1XNP02c4aYI3gPpGdT8KWtjDcCOxDqO/0XEKfSd4pH3iB2/KF/c8KvIFQNdLVTGS8NmngnDyIIVAJbuE9XDkOAdzbEBpNoAOmT4KOvCxHm40/ueFPcvQlC0LFsztnAFWOgewTN7KVSBwHLUUVzq6PLrx9zYUDQp3NibVglqHxA5LPl37gnZCU9k+qeKM57WgW0QRnXUNbrUe9IWTHRFSOstdUFMf4RE8ogM4oKhh8cHlCnL7mhafCba1esJo74rdoKvWnsbbHMEdYV1yYdC4sgQmvLR8n+MLW3SrcjJf6TCVZaEMYYqcFrf3764l+Cy9yVFSTkDF8eiWOv0QjsR+QamtAzJTnw/mgEjP0Q+ofoyIf1kBGxBlCJJXdJwo9siOUtgpGt3jdMfyHXSd10k3stSpLhfxWF5QKYdlIP4fZPyjh3QVfOe5Zcb1GCWZ37cSOfvtW3eBE4AP+/8iJaA1TyAk2Ow8qBt+TXSFly5jlXeew4Q5q13mqExcz3Q1y2wM0LmM+ymatqGjIETe/ioekCHNFd1JW9M91nkpKAdJp1xiRGpDgyCxQc7EQD3ccibp+wII66/cNEZ56LKs0uW5l+oe0NuKDNaxnQN4Z/Cb/vvOp3SpcfkvRmXx+8ToJ+rBlwyDylseRyRYvje
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(316002)(66946007)(66476007)(5660300002)(478600001)(66556008)(64756008)(110136005)(66446008)(6486002)(4744005)(186003)(6506007)(31696002)(76116006)(2616005)(38070700005)(122000001)(4326008)(41300700001)(8676002)(8936002)(31686004)(71200400001)(91956017)(6512007)(36756003)(2906002)(53546011)(83380400001)(966005)(86362001)(38100700002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnUwbmxIUi9LU0VZR0Q4VE1IWGRZYndFRGhRN0JrNXQvQnZab0Y3Um9pN2Nk?=
 =?utf-8?B?ZVA4bnZLdTdhT08wLzYxSjFrbzdzZzJMKzdXbk02SkJrVVB3dFptdFN2cnAr?=
 =?utf-8?B?Wk5sem84OHpYR3NRd25uRitkWkxlU3dpaUVuNDdSM28zNzFDMllXbElHRWlV?=
 =?utf-8?B?ek1PcEkvRExocUxLYTlwMlMwNFlua0JpelZBc0JVSUhXRngvRThJS0Q3T29N?=
 =?utf-8?B?aVp0YzJKbGR3Y2ZhNWxZZUJ1enZwNy9GRURmWnZJK3lwekVQZnBjUm83RFRR?=
 =?utf-8?B?WVg5STNFMDR0cVdka3pNeW5IUStmblZKbTlYMkpDL0psZXo2dUtsUkt6V05Y?=
 =?utf-8?B?TzlROHhDTXBnMkJpZTRGbkJhTlZQYXNTS2FvK2R6T1dBaE9VYXppb2lETk1O?=
 =?utf-8?B?TFVTVUYxNVJPV3RpdEVmekVCaS95M1plOGJ6T3Znd0o3MEk1ZzAvMEZOb25E?=
 =?utf-8?B?KzhYZ1pKNUZFUGpMNzJnbmV2MVpNejR4bDQwR1pYb0haQ0F1RzZBMkNxcmha?=
 =?utf-8?B?STRHRGQwekt6bm95WHlsajJqMytNbXlhNFNYTEY2R2tPUldpSWhpa3p6bUlC?=
 =?utf-8?B?dHVZdG9KUkxrN0FqWXJqWUVvRmh5aVRFaUxRdjM5ampHT1YyUGU2NG5EZENX?=
 =?utf-8?B?elBOcGVhd21NREc1TjJPcFVoRVFVOHhndXJETG1wVzR6ZXh6RFFrRVdhWXhK?=
 =?utf-8?B?ZXE3R3ovNkl2WmVBdkNiNThsSVY3bnlia0lBb2tpSnNIbnN4cmVmZmorRmJ5?=
 =?utf-8?B?S2ZlT21NK1krSzR0YTROdDIzdmI3VTZOUjRqSXB4L1dCVzlST3pQOTBibDhE?=
 =?utf-8?B?ZWYxaS9oU3NiN1ZTZGlFYldEWmMyWGFBOUdGa1RmdTRtemdLVmdBV01jSEd6?=
 =?utf-8?B?bkZJeXJwQXJDWjNaQXp5R1lUV2ZUejhBbWhUQWV4SEs4ZTJvN1ZBV3krWlJT?=
 =?utf-8?B?emphMmJ4TGZ3UVlqaTZieWhML3duT2xEd0I4NzJUZm1XaUt3TEovUlhaM1NF?=
 =?utf-8?B?dnlyRWRBZTgwaVVhT1VENWY1OWdwTEt4bGFIQ1cwMEFlclNXZGNueCtDbHZC?=
 =?utf-8?B?Y2JFUk1pRjNRdmVsUTVkWnJubmxyYm95WW5RV0ZjOUtxTU1MKzE3Ti84TkZD?=
 =?utf-8?B?N3VyYTN2SklkQmVvcWZIQStCQ2NaOVlQTExnUEdpTlNxbFRiZ2dMcmRJdncr?=
 =?utf-8?B?dW5PSHliVkl2bDhhTzQ3NERzWWVXQ1lhSWxYWHpNSnhrWWM0R09xODRXZmFk?=
 =?utf-8?B?T1dkWGo2WkpDc21ZMFdieTdzd280RkNrcU1OUHZVa295bVloWFhYNS9zR21T?=
 =?utf-8?B?bG1vY1hBbER6a01QNkg4aFQrdlVIOSs5MlZwNUpVTUxka0haNmNVZmxpU2p1?=
 =?utf-8?B?Z1dkSUtSa0xWajdkOU10Q0NtQTlnVnhISHpuSEtBSUFjMUl1ZDV4WTdjWDF3?=
 =?utf-8?B?Ymw5RlVIRjcvSzVyUUIwV3IyS3RxOHZKbHVXUGpEQ2xxbUFUWVdNemxyeG5S?=
 =?utf-8?B?YTQzRU81N2VBTVg3UnlMQ0d0MjZVTzRmUHl5VWFabnY1RjI2T2ZuaVVzajVj?=
 =?utf-8?B?Mnl2cnVKRVAxUUxTb05kOGRnQXFhN3MveWtMbWNYUzhSRVlYU2RBTDlaRXJa?=
 =?utf-8?B?NTdxcU1RQ3Y1VzRzSkRmaHRnSDNIVno4YXlUakw2bFFNRnZJUnFGRDF0ZFY2?=
 =?utf-8?B?ejhqREgwMERDbzVUYkZGWWc1M2RMZk5ScjREa3NVSkxubmtOOHpmM0cvYkR2?=
 =?utf-8?B?N2cyZkY4SDNLNUVzRTZhM0NKSnh6ZmxtNlVHY2hEeWVoQktUeURtSkd3d1gw?=
 =?utf-8?B?aHgxVllFTU1qeWF1TnI5RGZVYWRNcFZRVXNiVkRhTkJiSTh2U0NTTFllMDhW?=
 =?utf-8?B?VUZ0OFZrSjdncFkwWjR0bXlDYVJPTTUzLytnTGJNeXc4YVptWk5BU3RoSjRI?=
 =?utf-8?B?MzFZUllOVElTK2p6WXFrUjBRR0VGb3o3TWV3TFdXeHkxaG1WSnZOeUlGQ0Ny?=
 =?utf-8?B?N1dGVysxZU9YTHdURWRsQ281N2lsZ1RpY1dnZWJLQ3R1RUFJRWR4V0Vjd0Fi?=
 =?utf-8?B?ZTQxaWQ3L2dpcEpqQlkzM2xtWEJLT1crRHNZeWlmNFErOWE3RlFBOHRuMTNz?=
 =?utf-8?B?VVlNWUZhSStrZ0d2Mkl4bWZLZlVOSGlSb3g2S2laZHJ6ZjlzU2RWYVlZWXlM?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6C95BEEA78D4C4592E4812EB4943844@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4de2e1-20e1-4bd4-c2d6-08da8b3dbb50
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 10:44:07.7619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gy5aUU6IpQss2j0cufXhrgRa0X3cxI0Z1vk3v4DSxflRBIHMe+vL7jKe0tqptd9Cy6DBxr40/EqImyE4ElcifQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8zMC8yMiAyMjoyNywgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFRlc3QgY2Fz
ZXMgbnZtZS8wNDMsIDA0NCBhbmQgMDQ1IHVzZSBESCBncm91cCB3aGljaCByZWxpZXMgb24gZGhf
Z2VuZXJpYw0KPiBtb2R1bGUuIFdoZW4gdGhlIG1vZHVsZSBpcyBidWlsdCBhcyBhIGxvYWRhYmxl
IG1vZHVsZSwgdGhlIHRlc3QgY2FzZXMNCj4gZmFpbCBzaW5jZSB0aGUgbW9kdWxlIGlzIG5vdCBs
b2FkZWQgYXQgdGVzdCBjYXNlIHJ1bnMuDQo+IA0KPiBUbyBhdm9pZCB0aGUgZmFpbHVyZXMsIGxv
YWQgdGhlIGRoX2dlbmVyaWMgbW9kdWxlIGF0IHRoZSBwcmVwYXJhdGlvbg0KPiBzdGVwIG9mIHRo
ZSB0ZXN0IGNhc2VzLiBBbHNvIHVubG9hZCBpdCBhdCB0ZXN0IGVuZCBmb3IgY2xlYW4gdXAuDQo+
IA0KPiBSZXBvcnRlZC1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gRml4
ZXM6IDM4ZDdjNWU4NDAwZiAoIm52bWUvMDQzOiB0ZXN0IGhhc2ggYW5kIGRoIGdyb3VwIHZhcmlh
dGlvbnMgZm9yIGF1dGhlbnRpY2F0ZWQgY29ubmVjdGlvbnMiKQ0KPiBGaXhlczogNjNiZGY5YzE2
YjE5ICgibnZtZS8wNDQ6IHRlc3QgYmktZGlyZWN0aW9uYWwgYXV0aGVudGljYXRpb24iKQ0KPiBG
aXhlczogNzY0MDE3NmVmN2NjICgibnZtZS8wNDU6IHRlc3QgcmUtYXV0aGVudGljYXRpb24iKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2FraSA8c2hpbmljaGlyby5rYXdhc2Fr
aUB3ZGMuY29tPg0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay9h
NWMzYzhlNy00YjBhLTk5MzAtOGY5MC1lNTM0ZDJhODJiZGZAZ3JpbWJlcmcubWUvDQoNCkxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQoNCg==
