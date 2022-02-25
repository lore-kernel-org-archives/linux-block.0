Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D57C433EF
	for <linux-block@archiver.kernel.org>; Fri, 25 Feb 2022 18:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiBYStH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiBYStG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Feb 2022 13:49:06 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2051.outbound.protection.outlook.com [40.107.100.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9657C1216A3;
        Fri, 25 Feb 2022 10:48:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hstB45bjXG4XvitaOI3MWLUga1NkCjmIOH7d2vU0pOT+VO1mvSdaWVuzex56Ypx4mU/3LGTJPKI1s5pY9Jpk+Ze3p2KrK+atADcI8DlyLLwyAwh7r1Vk1GBEXD0BiZXH+8vP3zIfVSb4Revi6FP4i0EoPY0jIGWVI4DWogq4JpVq/oJF2zbjL84TeK9xvT/mcm8MH26zMEvGL0I8/5gKSpkgR2NcaNtu4LDZiWNnmHX5NhXWTRG5dOS6JCtWqgQeCX92KLUzlj83sacDvBmMIFXL8baNKjX/kXA7ArkOnPucCgURvCa5ONjqnTvdhPCXM23oNP7AHlFqJQGDpOCkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4D6+OFpECuioVGWnrtU5wAAGf3xEXAFgoIeucmrTr7A=;
 b=PjQxU/yzRKipuqo256/63LU19sVZjV02hiZEhYLJQm0Qjj5/Wke5Y7TCJqWtdr//Tr5hoGL5eMKTjLfndz6eS4ekZb9XSz9DKItd8oAW8PlY/yZac8q1O+h4cku6raL8Am7IyEdkNbDMxZojov7MP34wkRerQwkCVliQS6fgRrWIPkENt0sTxfqVPZBtHTc018ZASOQqPTQE0dBhHvGZvEaYW9SugbjuIFVomg5XCbySSNnEkOcDeOglFM1nFqc1yFNyWPgAn/QJj1rqn6GMj7PUTSK6iYm5GGph4teYtguni6uNZho1WKT7bbHcnW8utBuDrkApqZxha+vbcM+ZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4D6+OFpECuioVGWnrtU5wAAGf3xEXAFgoIeucmrTr7A=;
 b=oRzn4DrvHHvdJNg5o3mQ8GFynUFaiPNB1DTylUNc2+IJhWx9bVycNu1X4tceKAm8dOzYWLymi6ojUUS4NxFx51G9u1GoxSbYxqY/VsziAg+YzW7jQNwScGMKQ5TG0uwTkIrN5DIr/na95OVRYwyMjkhHvhsE5XChWBK7Ow9uyltAbEPQ6xgisoHE0PEuQrv9ADnsb6LixDw9A4H3OOvWYHAR8qOHh/K0ErfHYguesVzKZ0y5sOHYNjzFSKkYtDJXEdvUrI8NKVUHg9BWS9h5ZKpwFFYpbLaKdY8far6oouDtxu4kWdoSEotYKIiU46Y+72H+1ugCCBnSj5sas8Hvzw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 18:48:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Fri, 25 Feb 2022
 18:48:32 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] losetup: don't skip adding a new device if it already has
 a device node
Thread-Topic: [PATCH] losetup: don't skip adding a new device if it already
 has a device node
Thread-Index: AQHYKnLvgntNrnPXzk6rjSPDfbKubKykm6uA
Date:   Fri, 25 Feb 2022 18:48:32 +0000
Message-ID: <23deeb56-3731-63b6-b008-3dc82a466a83@nvidia.com>
References: <20220225180903.1341819-1-hch@lst.de>
In-Reply-To: <20220225180903.1341819-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9725323-d025-4f41-8077-08d9f88f6bce
x-ms-traffictypediagnostic: BN9PR12MB5116:EE_
x-microsoft-antispam-prvs: <BN9PR12MB5116D0A36F6B63C10E0D4D0CA33E9@BN9PR12MB5116.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SHfR+tmEwKY5Hq4oJzqX5YXnfQ5ZwbmU903iRY4T4WALdmcz9jkzBw72YfhZZFXpeEkACHXsqyXBFuqrhTNcv9PAOdtWAGYlm5wSODDu9SP7/INACaV/AxpK9rw6BbjwgstnFxtqzulTTLyA25XVTHuuZ6Uy9zGrxM4JPJ78KhDI1vm3G85c/nTTHjdFZgrI1nRvpGyOqTtiK685+K550XNwXfi2IDhLm+AuhciIE0jnkHRGHz2YeXzrVbcOA54idjM0OS5kv5Y74G0TpZtwKKX/TlAfNnX/4BVVctdttijkCOmIH0Ss/w8Nx74jzr2vJKGEuv2cdEJlM8F58kkyX0ihMYB4qU5PM4G9MXx1YJlip9G28o0bhMLhX9+6QK+EP4pCIU5HGZisoqh9U64+DVbTzd11lNqiF3f84wk8XNzXrC8D/Bh1uoAg4OxMySrROZ1j4L4Tbwju26XaDZyy04eW2QsYrfkSDI9DLsiHAIXDkHAFwUvMr5NVOFBaAgccR+7AhZ84Jb5DhRhuVyezmyW7qjbDUt4BXqGV+jLMigjQ6XZCuviC1HIuUXwRQCRCiSKlPZQYd3+aE4wbb8lM3ftToLbzTm1qxaUtxgitH4xzt0hg9b+cXCFgLIBHuZ3LuZ4y3/F/9q0zHnY/Kgoh9Vz+U4ycf0+3EP8qYYugp8MAnHyhtpUHsdiC+v5yp2Hu3jn2Vijv18lmeIKoWT7ZBC84YSBqXysI4ei6EKPd2ddxoCZHiiq6NnyOsvS8ZhUh75i23uMLaphJdc5F/IR8IA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(36756003)(83380400001)(186003)(2616005)(8676002)(86362001)(64756008)(4326008)(66476007)(2906002)(508600001)(8936002)(4744005)(31686004)(6506007)(122000001)(53546011)(6512007)(5660300002)(71200400001)(316002)(6916009)(66446008)(66556008)(91956017)(76116006)(66946007)(31696002)(6486002)(38070700005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1FGWGFFVkRGOG40R3JpZVhKZ24xaEdYS0ZSeExNQ3dUMXBPcDA1WDE4cnA2?=
 =?utf-8?B?bDhldkQ1b2Z0Y050MnkxbEs1OHBaVVg4SGNhRWhIcVZEVUFSZjhtRW14bnlG?=
 =?utf-8?B?OTZCdURWNUlLYXZmSzlvSzIxK3IrNWU0ak4zZllYcmRxanZBV0tFUnZPK1Nt?=
 =?utf-8?B?NWtTMzFMdnNrNzEzNEkvYlhsZGJYWVlSYk1Tbjh3ZDdEZXBKSHFHNzQ1cUJH?=
 =?utf-8?B?UEpDVktDNkxhOG82NG1VYmFRQUtmcEIxRUZvcmdzb25kb2Q1VVZiZXR1WWJU?=
 =?utf-8?B?U0RHU3JMUU5FVlp0UzF3am5BV3ljY01yVFFVNTROR1l0L0RxalBjZVU4UTZI?=
 =?utf-8?B?OXhoUjcxY2cvZUtJZ1RSZ0NKWHhqeFg4T2dvbk5odGtGRDMyaFhONytQYW9Z?=
 =?utf-8?B?YjRvaXduQTZMNDV2NVBwSXMxWjFuaEFTSHo1NDR5OTdUSGkybEdEVVc0NDYz?=
 =?utf-8?B?WnJaUmprdkJxMDR6Skt0SmJyVk1kdDI3RHFVZml3UkRxTEpwS0I2bTNYNCsz?=
 =?utf-8?B?T1FhbnNBMjRpUDRZSkRhU0Z0R0xSK2Z4QjRBSkF6SHpwQVhrVWF6UnJlU1Rv?=
 =?utf-8?B?eGx1NjlaZTNDTDZzeUxKVk5naUI0cUR2ckcrSVQydWRMN1FiYnVhMVhROThV?=
 =?utf-8?B?ZDZxeVhMWXJqNEFqamhTdndlblpBMVgyL2xNUVVia0I2NUN4czV4TDBySWJK?=
 =?utf-8?B?dXpmNlk3UlVSQ3V1VjFDK3d6azBwcHJNQlFUa2pRWFRNS0FoYXVwZGdncG1D?=
 =?utf-8?B?NEJ3QVJFa3Jac3VibWhDeEtEeWprcXpOc2MrYlBkVHcyUVJoYVdZMS9RMVZu?=
 =?utf-8?B?SDlGcFRyNDcydjJVcGNNN242dm5kZ3ByWFVtckV6MW5yM2kySHZJTzdpZXpQ?=
 =?utf-8?B?N1J6dEw0S241dEVwSHhZNVMwQWo2Sm9JKzVrL2t1QTdzSTJaOVd5L01FZHk1?=
 =?utf-8?B?S1JJWEJRTzdkcm11NURtaGpFekhMRVpYOHdnbDdhalZVR1c2VkZVVjRDZ3lM?=
 =?utf-8?B?Z2JjbXpnL2xzeWQyYnRxUVVGUFlTaENMcDJsbSt4dzNodGhPR0g2TnE4VkpB?=
 =?utf-8?B?Y2xvaFhaQ1RXOUtjWlF6SnNIdWNzM1VyajI2Q3pGSktxaVRvaHduMlhxWkhZ?=
 =?utf-8?B?NEV1ZE9HaGYwdHR6MXYwQmUrQmZ0YnBTSDNSQ3k5OUNPN0o1MXR4VGdYNDNn?=
 =?utf-8?B?c1c4eEkydHk1cEZuYUVWUXVRSW1abmZraklHK242dG9jYVNua3J4N0VYS3Jr?=
 =?utf-8?B?ZjUwYjQ1WHB1WE8zWk5yNnZMd0tMSDJQUTJabjRmWTVnbUVMRlYrWm4xS2cr?=
 =?utf-8?B?QWJKSkdOSGhiM3hxcEZNYU9IdE45aDM1M25tZXZ3cXNYakMyT0w1Qnc3dlhP?=
 =?utf-8?B?dmZRVTNTTmRHREVMTU1rTVVCYWZqdU1vRGtncjlTa2doTjdaeDB4SVRJOGJ0?=
 =?utf-8?B?THRtaURNdTMxeWw4U1VvZkdaQVg2Q09XUXVHWDJpZ0xmRXh0QXFvcERudjZm?=
 =?utf-8?B?cWRscldwZ05Wb1dIQnNremtMcVBGaW1NUGNwQ3BCQ2tTbWhUMCtGQkpaNjVi?=
 =?utf-8?B?L1F0UktMalMzVXdnUmVydEdNc2xMbUZGQk11U3FBaTkwUUNwNHhvaGkwYWFR?=
 =?utf-8?B?U0p1QWtoQ1pwRUgxZWxRZE1uTkpQc0prVzNZTHBSZ3ZiTnBLQWduNTE2Nm5s?=
 =?utf-8?B?bmxFMVZkNlNrZjNTUHMrbGdDYjREWGhZL1NSSTNmNE4zb1dkOS9CZ3Z3NGJr?=
 =?utf-8?B?ajRqTkkxSU5pbFlqZDNsTm5vMG1SSE5rK0Fldno4MSthRWxOdEh0ZzZZQUNa?=
 =?utf-8?B?TzVHdm52MCtnRlB4Z0NmaWpwSUJOZWxSZEFLSzIwd0JoVDVQaW5oS1FpNjJF?=
 =?utf-8?B?dlJzVHVCUngzL3RuZlFrRlNVRlpHSXE3T2ZkNjNBVGJUMnl5VmRPeTlzRnlJ?=
 =?utf-8?B?ejhPTUhlcFppdXo5cFRVY004Y3pqZmtuenErME1CYnNYSDczVml4a3BaWjBI?=
 =?utf-8?B?MGpJeThaWldXck5RSDdwaTRWb0xIUXdNcnI5NHdUYnJsc0dJc0xHZC9DYlk3?=
 =?utf-8?B?bFZUdkZkOGNIWVRETFR3U2VpSGVLQnAraXE2UU5MOFo3Z2psUTA3MTRSejVH?=
 =?utf-8?B?NWhOMHdDMjl4cnYzY1dzVnlHcXFHcEpqZkdZNGIyM283OVJqQTZERU9id29l?=
 =?utf-8?B?YkJLeDZNTWxkRVNWS05OYmZWLy9NM2R1T2FMRDdvNmtuNjh1enl0WjlNNjlG?=
 =?utf-8?B?MFBkdHNPZkh2d2dMZ3hhWVdXTlZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15DC16454B995F49B13818EA3DFC9E40@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9725323-d025-4f41-8077-08d9f88f6bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 18:48:32.1249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KtUJHKHgR9jb9y6P0Phw0Mb0ZU2bdt14PIOrCbO9Gzp1j9KzGk1I4QO6iOYPgX9JjoLy//9tSENwTJ7NoG5zwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8yNS8yMiAxMDowOSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IExpbnV4IHBsYW5z
IHRvIGRlcHJlY2F0ZSB0aGUgYXV0by1jcmVhdGlvbiBvZiBibG9jayBkZXZpY2VzIGJhc2VkIG9u
DQo+IGFjY2VzcyB0byB0aGUgZGV2aWMgbm9kZSBzdGFydGluZyBmcm9tIGtlcm5lbCA1LjE4LiAg
V2l0aG91dCB0aGF0IGZlYXR1cmUNCg0KJ3MvZGV2aWMvZGV2aWNlL2cnDQoNCj4gbG9zZXR1cCB3
aWxsIGZhaWwgdG8gY3JlYXRlIHRoZSBsb29wIGRldmljZSBpZiBhIGRldmljZSBub2RlIGFscmVh
ZHkNCj4gZXhpc3RzLCBidXQgdGhlIGxvb3AgZGV2aWNlIHRvIGJhY2sgaXQgaW4gdGhlIGtlcm5l
bCBkb2VzIG5vdCBleGlzdCB5ZXQuDQo+IFRoaXMgaXMgYSBzY2VuYXJpbyB0aGF0IHNob3VsZCBu
b3QgaGFwcGVuIGluIG1vZGVybiB1ZGV2IGJhc2VkDQo+IGRpc3RyaWJ1dGlvbnMsIGJ1dCBhcHBh
cmVudGx5IHRoZXJlIHN0aWxsIGFyZSB2YXJpb3VzIHNjcmlwdHMgYXJvdW5kIHRoYXQNCj4gbWFu
dWFsbHkgY2FsbCB0aGUgc3VwZXJmbG91cyBta25vZC4NCg0KJ3Mvc3VwZXJmbG91cy9zdXBlcmZs
dW91cy9nJw0KDQo+IA0KPiBDaGFuZ2UgbG9zZXR1cCB0byB1bmNvbmRpdGlvbmFsbHkgY2FsbCBs
b29wY3h0X2FkZF9kZXZpY2Ugd2hlbiBhIHNwZWNpZmljDQo+IGRldmljZSBub2RlIGlzIHNwZWNp
ZmllZCBvbiB0aGUgY29tbWFuZCBsaW5lLiAgSWYgdGhlIGxvb3AgZGV2aWNlDQo+IGFscmVhZHkg
ZXhpc3RzIHRoZSBMT09QX0NUTF9BREQgaW9jdGwgd2lsbCBmYWlsLCBidXQgZ2l2ZW4gdGhhdCBs
b3NldHVwDQo+IGlnbm9yZXMgdGhlIHJldHVybiB2YWx1ZSBmcm9tIGxvb3BjeHRfYWRkX2Rldmlj
ZSB0aGF0IGZhaWx1cmUgaGFzIG5vDQo+IGZ1cnRoZXIgZWZmZWN0Lg0KPiANCj4gUmVwb3J0ZWQt
Ynk6IEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3JvZkBrZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sN
Cg0KDQo=
