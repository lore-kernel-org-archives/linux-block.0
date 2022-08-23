Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10459C28D13
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 01:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbiHWBK7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 21:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbiHWBKo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 21:10:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0502657E29
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 18:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMnJ0c8zvU/VojB9hMJZPHt59H/Ri57qESzcPzmtMEl8X3h/9qUlNnDJj8GVZAaWNV43OVgMj21159t8VMnc8BB1+5hw+05qUf/nvoC2rBJwbbfwgDoAiWJf4ZDf23SSd+kNSSAybPiSoxdzrTf9WCHDKPaKQJXMuhPUh9mxz9gWgHrAmB1OwCSNyDqo+XmptsQAVaXt7yS+k0D5flXZMQekzxURwxyFoKNN/u4nhBFRFrDyw7gFrOhsIEvtQ/68jB+3T6jFBW+/UKRD1bWgO98im0376nSxWEr4+pCEVYtb46lDpn6uNJJ5YT72H1z2kzwL7M5bauFLBS8AmvG9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/cBPJ/pyXCtqo4OstjGZrFJvl0aWwQggdOPzW6BiME=;
 b=derRcU+/yHgThj7R+wsWaFp14KqWg8SOkWxR3YtoBddgMsBM//53QLrItTPHGvNU7cHg3Ekq5j2xGHkZUHg6BgbtT9g5F/wX2xhKA9NNsh3frdnzoRZCyyiFli8I306m8pkYiqMsbse5CfKvjPurMAd79GCdMrlYJ2t38+h7z/hbdszSgJU6nXuU0+tozM3E0AwPlP3tAVI+rVoqkp1u192d+g1kjaYu6AjIziSJPESgKLO1goy3qT6WcNH1fF7gbr98mbKO3KHLVvNhgWKvhDKTiUpTS58u1RIXrthTpe6wJvjIaNdmHT8kAL1u83Kt3Gq2hDFWzMD9A8/ht8Wakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/cBPJ/pyXCtqo4OstjGZrFJvl0aWwQggdOPzW6BiME=;
 b=GN+Zh3WP8EvpyoTA04I6/p6jGC5gvdm8dI3EACm61FJoRxAwbBwfxfNo/x11GkDSquTmAp1aYbqoCn37fZYbEYCcj1HfMcZNafQs5AVsc+5V6GG2s12/HQS3rLQ0dMyR3qIggQk/d6nL4PKHy5odhckEUpoEFws9o8JAbX5feAeHpCY5PRM0rY8NSyrP7vWAgXd9cX14Cp74HQHJWB/+Kja74b3hqxYoPwcmzhDVi9XkhLpWX+fUbai7vZ9UbKR4/7HCnyHQXPgxm8IMhiwD7n5iblEmovKdOyzjpvwBPdU97pVmG1ksVtdDi4d6bpq+vJf98Fv8S7eZUsAZpxEw4Q==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BN7PR12MB2708.namprd12.prod.outlook.com (2603:10b6:408:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 01:10:37 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::e033:3f08:d8d6:1882%7]) with mapi id 15.20.5525.019; Tue, 23 Aug 2022
 01:10:37 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/4] rnbd-srv: remove struct rnbd_dev
Thread-Topic: [PATCH 4/4] rnbd-srv: remove struct rnbd_dev
Thread-Index: AQHYte8bDvhHSodRuUeD9AcCp9X4HK27rm+A
Date:   Tue, 23 Aug 2022 01:10:37 +0000
Message-ID: <23ae7aa1-928a-04de-cc08-18a0093c8748@nvidia.com>
References: <20220822061745.152010-1-hch@lst.de>
 <20220822061745.152010-5-hch@lst.de>
In-Reply-To: <20220822061745.152010-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00263c67-f140-438e-f39c-08da84a449ed
x-ms-traffictypediagnostic: BN7PR12MB2708:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aXKDxZ7ITyGpUgRHa73Nk7jSuTn3T4kZDuWZomeeyXzifSK0nQ4xHepvtcz42bOA3PPUIeEpHRals1Sp2X+PtvoCuGtjbfOxhEz39+verHBDm6o//tH8F7o+nX3wfHAMGnOKhjaz2G8tVW2nYZL0z0hoCW+4BVLPeOzlk6Lnm/rYadQQAWcD0cUNNILa5k/GfrdwWFLHVfkGzkN0A56ILBTdY2SJ5ZltgG3bVHEBMyLHpjqGgd6eWwOeNsFIPWbDcAkw5SQjCTFDPMxHEfVb93AnaLvdyXRFk3crsYCTRahg2OPcLWEyFYpAc5ol9TKZWmIdlRz3WXUuU7YEgnhn83n8eCr3TzUiHI1q1VIODrTZX4rso4/GbMWBIz34RbOrkZIDj2aWArUmNr6vB2HmHVlmHPv4o2erV8bDZKmSXRQsOpcxnKkzzT1+aTlhDsM97TTlGGKf8V37V2lVOw7ILKk3bJVqc951t8rkiSvEETS+5IiYcBqw3UMDC7jdq/4nbuKykAyRGBqOzYl2uz0/TbknZ3P6qns+WW4Yj+CEyyF4lOIEmQrYt3gb2s+dxHchUMt/AuFar+4HrA52gB/jjPJjWAMO57AO6LAWMBLZ3vwRdEblOKrx1yQgfP0b8yMYD3h61SbUBgCySL3WAeJ4gmC3QKeXM4GVsYbQRFtkiWra2Oe+YvnRX/Pa89Xd/JvjeWSWm4st7wfKx4KiW3I/qrWLRCx1x3YeX9eBNFEx2FTr7T5QQ1gwIqh+Q612E57kCD3Kf/i8aeMIp9O/1lRwimBgrKyflbCjSQPcHj7T1vCaqANkyZH9LPO6UhM6eP6Ui1vn2i3NvYpFDZUC9dheCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(66556008)(66446008)(66476007)(64756008)(6512007)(4326008)(5660300002)(41300700001)(6486002)(66946007)(6506007)(186003)(86362001)(2616005)(558084003)(91956017)(478600001)(8676002)(2906002)(8936002)(83380400001)(38100700002)(38070700005)(53546011)(122000001)(110136005)(76116006)(71200400001)(316002)(36756003)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWYvZ1BjaDJkaEhUNjkvWXpnOHA2L1NyRXQxZnF3UlVNcjE1Q0ppczhGMENN?=
 =?utf-8?B?Ry91TnU4QURFTHNURkZ2QUlhdE5lOTVKWWhXMmFsd2JIWVlETGtQSW1xSHZy?=
 =?utf-8?B?MVVXcWR6Qi9NcThWd1RscUdDTG83cWFBeEpPUnJSd2RWazRET1J0WU9ZeW1O?=
 =?utf-8?B?cDBrb2Jra0xFNFNUQVA4S0swQUJmc0N0cWg4MWs2VjJIMUJ4cDBSdHFYT1N0?=
 =?utf-8?B?d3hrektxN2srbnhuTkUzdjFUVnFjTUdkVzcwUEJiaVA2ZnFYM2x4ZGcwcGo1?=
 =?utf-8?B?bW1MTEdLOXRzYVhLNU5OMktQeW5JeFJLa2lRdmpIVCtzK3NDNDErcU8xT0dC?=
 =?utf-8?B?enVEZmg2d3RXR2FFZ28vcWpNSm80YjRQK1h6OHI3ZjdvN3R2VzZMQ3YyVFdo?=
 =?utf-8?B?a0Myb3BTTG5uYUlGeUY2RlJaTWpEOEJKblRDMTExdUx2UWx4VmdNWE9Ga2hQ?=
 =?utf-8?B?dkpGWll3aEd3Zy9lSjlrTFJFMzNhSnZEOS9OZWZCYUJNdGZLKzVwVVVvaXVt?=
 =?utf-8?B?NnYvSTZTb2hDWVIzQzY3akFpaGFLSU03dmNvMWdJdkZjdnRLYmVHNTlqV1FQ?=
 =?utf-8?B?eHJ5VWNkVUxrUjNyU0N0d25mOVdFUUdZZEN1Q3lPZUJ2QVB4bGduQk5UMnd6?=
 =?utf-8?B?V1hnSTQvd1ViTGJESVR4dWdHTVdvVm9XM2Ywb0I1eUR6MVB2U3AvakJnYlFR?=
 =?utf-8?B?djlRb2xwUnlpYWtaVW9RNFgvYkZJTGVPaThjMHZGTXBTR1Y2aDdTakNTS2lV?=
 =?utf-8?B?L3RqbVpoOG1scm14VjNJdVh3NEMwNExNeGpIeGMwbWxkTUQvSzVEL2FtOWRv?=
 =?utf-8?B?TFZVQzY3Rng2dWZUeWZ6VFNjVXdTOFQ4K3IyckhiT3lUdEo0NTRMd2lUb0Mw?=
 =?utf-8?B?WURPVDVDTmlnRmtHaEFLTzRuM05ndkl6YmVLWVpYUkw4RGp3bUdtY0d1c0F4?=
 =?utf-8?B?NHdWMFVURmF5QXl5S0NoZ3h4ZmYxQXYwUXhCbE5PRjVGaTIzWXV2amR6NXpz?=
 =?utf-8?B?TFhKSzRyOVJvc0lXcVp1R0ZKVGxtSkp4Z0ZLZGJCQjc2NEMvWHFmV3Eweno5?=
 =?utf-8?B?NXQ1V1N6bWh1dHdMZnM0dnhZQU1yeDJUNExwbzBnWXRFdi8rQ3N0aGkyazVD?=
 =?utf-8?B?c043cm9STlIrVTNrcUgvUldjalF6aUR4VFFrUC9CbHh4ankxbDg4K2RnOVhw?=
 =?utf-8?B?aW5mc0xrWjM3WU1JM0FUNkgrV20yK25xL3VTYVo1aUY4SXJBVFU0aUlxaG5t?=
 =?utf-8?B?YlptVzc2bjU5cnZXS3lBMUhYdlZsQnNaOTMvcndiWWRzUEVKd3N4dmU4R2Fh?=
 =?utf-8?B?U05qQWN5Skw4T25NZGRrTmt2dmdscDM1YnhZVXpyU3gxKzg2eEN1cW9xc2I1?=
 =?utf-8?B?dGtxZmgzcklrdjduSlBQczZzcnU0d1ZMZFV2L0VyOFgyRnBCYXB0UmdRRVZE?=
 =?utf-8?B?WFZvaWNUY1g3cFc4N0wrZW9SSkZkNWMvR0NCQnVTSlNNZ1VCQjV6R1FpbW1O?=
 =?utf-8?B?MktvVUFlTno0NEdkNFF1RWx2V2lhWHplcDVPaWloa0RFYlpmSEMrQ2xmMitX?=
 =?utf-8?B?cTZQM1Bqd29pclZuOFp4elplTWJzUVlqSW53REE5YkZob29RZ3h5dlNzNXZ1?=
 =?utf-8?B?MTUwcU9wZXpjY3hyZHFEQk5nelZ1TVdpUU5Sa0tDeE1ibDVPVHNudFlVaEdD?=
 =?utf-8?B?Nittdkw0ZXZCbitoQzFTNFBtUE1hWjVuQmxtcWlsakQ1V3V0ZUxFYmVHK2lq?=
 =?utf-8?B?a0RKdDNZWFlXbm1wQmdBWHRGWE84bDFUVGZTM0YrZmxCVDZGaytzenBicitN?=
 =?utf-8?B?bmRMc20yQ3NWUXBISkJRa1lVQUU5Q2Z6MU81cUVYZDFQTy9UVTdpa3FGYUtk?=
 =?utf-8?B?S3FKcDA3NXNXRStibFczSis1cExsdmtKSW16RVJpZTF0TjZHR2NhSC84a2Rs?=
 =?utf-8?B?R3dXWjBmQUhJNHpHTXUwUThWWmdsb3d1VUxlc3cvS3FPWFRRZ3lxaGxUaDVL?=
 =?utf-8?B?UG9rRzYySnc4anVodGkrRG9ST1ptdUNPY1lrR1lJMXVMaVNUWEpjOFhEUzBs?=
 =?utf-8?B?Qm02TWxBNTR0NDBwOHFCdVFRT2JqZWVQbzZybzZWYXRMc1dHaDJtUXVFblFK?=
 =?utf-8?B?cGFwK1doVGdTUkR1elo2L1lkUmJ2SFlQVWxFaTBPSVVzN3E3MFFOVVJkNWtv?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB713ADDF30E934FB56394504921CCAD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00263c67-f140-438e-f39c-08da84a449ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 01:10:37.5868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvXWhql+hWofc1OePFjzK+2X0wb/pL/q7/wqqTkTtjc8FVyw7mpm1RmnbV/4KeVsRMgWIoezhJ30f1U3AYiEhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2708
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8yMS8yMiAyMzoxNywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEdpdmVuIHRoYXQg
cm5iZF9zcnZfc2Vzc19kZXYgYWxyZWFkeSBoYXMgYW4gb3Blbl9mbGFncyBtZW1iZXIsIHRoZXJl
DQo+IGlzIG5vIG5lZWQgZm9yIHRoZSBybmJkX2RldiBpbmRpcmVjdGlvbiBhcyBhIHNpbXBsZSBi
bG9ja19kZXZpY2UgcG9pbnRlcg0KPiB3b3JrcyBqdXN0IGFzIHdlbGwuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=
