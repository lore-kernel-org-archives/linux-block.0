Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A1EC77B60
	for <linux-block@archiver.kernel.org>; Wed, 26 Apr 2023 08:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbjDZImi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 04:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239645AbjDZImd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 04:42:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096B12D74
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 01:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DidOtJY5YTp5SOVBzec2w28RpKWeUUDZnHClqmh1a3uCbVCmG49f1mXcJvCQjvl89hPpgkbSnodHtuXeAufBNuhLQ/Vtloh1/vp0Ll4Qh3DdGrtOzU4py7gR6BO2wgVH/yd3Yd4cO88x4okfbRkCSxRAws0Kd1wYH5taJ0daULkTYx7z3H2TE2jHn1iJ7DqgtITfpdT86EHHURvuR0Urghe+k/JM7Cxfuz38u9EHI9WDN7FyXnoKBUvX3OkksoHSeXkEGWcgI9GtdsM8K5UgGPGtFBhnH7CJGZ3fnnTb6npdmXvAQwXFWgCkLNPyS+ghe4cPIcLajEgB4qu16taE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ2OpAtsyLi5UC5lirjk5MjGzcx3OoEgXctthoE7SmI=;
 b=Ify9DqbILz1/xbEQchK2wsLPLTfpgMPvgVuZBVUKBTNdkAIwFsOn76p+TimuPzioWGqI8AFh75iRXhs6296gr35DXFT/NjY9oD0Og2diobVUdYBTDAAbgWsu/O3ZXfVcT9BxnwUdDTTqqhVK3z4s0knB8SZRUKpLJID6Py1lyxAlxlGNX2ed84qu0qKE9HeFVkua4D4iEgy1ySApzcvLPcVZdTn4ySERgwzY36xKjdi7gx7DpZPDVuUP9apXaTpC2RH3I7/UCsLH0ErmpOdtxEbqE9QIn3xidLLKMSfLt/OBjcnjWIO2AZGKmQsu8U/IPRL0GcxS8ZOHlzRaJkHyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ2OpAtsyLi5UC5lirjk5MjGzcx3OoEgXctthoE7SmI=;
 b=h8IbwHqds10FXFFiBuCFqFC9BcArIzahfyU45lYLBZ3qpASObvEgu+hQcmFkJ7Nx/8OnenQL2eP+eEHiVVq2X6PdKAsmmo9SxD7TUEq8NYmhsTIlA6lQo9iLAot3RrKZ6gx6IqqWaobAVUdOVDHe1kJ6a6fWyVe99y1XC2DcLPt8hF20nm+8mN0geiBTwvKdnbWseP3CsSHdUS2uVBUYiZ9TMZbhv4fU4aMOlUaIXmp2LS2wvqEyuQYBnFIILAqci9oPuq1SqKyBMYI+G0WiXInoTslpw2dGyDHOqXHQ/WDCFzhiIZ5TtjdkrsIPdTgMH4FvKO6A8vM9tHK/gdarRA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5314.namprd12.prod.outlook.com (2603:10b6:610:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 08:42:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 08:42:26 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Mike Snitzer <snitzer@kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
CC:     Yu Kuai <yukuai1@huaweicloud.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "yukuai (C)" <yukuai3@huawei.com>,
        Li Lingfeng <lilingfeng3@huawei.com>,
        Joe Thornber <ejt@redhat.com>
Subject: Re: [PATCH blktests] dm: add a regression test
Thread-Topic: [PATCH blktests] dm: add a regression test
Thread-Index: AQHZHBi8eATZiCTOIkK8kukyngKzOK6aC9mAgKJaAACAAEEnAIAAVkwAgAEAkAA=
Date:   Wed, 26 Apr 2023 08:42:26 +0000
Message-ID: <a8f2ca5c-0ae8-47af-d6c8-f9430c19ff64@nvidia.com>
References: <20221230065424.19998-1-yukuai1@huaweicloud.com>
 <20230112010554.qmjuqtjoai3qqaj7@shindev>
 <6ccff2ec-b4bd-a1a6-5340-b9380adc1fff@huaweicloud.com>
 <oklvotdaxnncrugr2v7yqadzyfa5vvzrumrfv46vrzowjw3njo@tlvhd4eo5spl>
 <ZEgMuvNCud3fNdl4@redhat.com>
In-Reply-To: <ZEgMuvNCud3fNdl4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH0PR12MB5314:EE_
x-ms-office365-filtering-correlation-id: 012424a7-da70-4c1e-be43-08db463229f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MrmmUa/HD6S68Ij9KHynXEdRukgQdwANchLefIL5uPLNkJqIYLWpJ/T6poQWW0UtEhC7S2MFxGtLFvE1qXOvlpKpG8kcHMmYgQTt65kpduleDs9BsUSPP+Kf4Gqru0Y1P525IWdwdY2W3u8fnblbk4fYdq/N07nPOR36eu+yjmxqJTrhSXskzAmyf5j1P+ekx/VkL+Ffbq+8PmBdHeeU27tWqe6CqdMyHBI6fL4lZdWBu+FM56q0vCsGxs0HHMl/lV05NInyJs3bFvwfxv5hTEaKrsup/uBvS65XyEG2yfDaCcl46U4bWabTeNnYN0GeurkvHmUa1BzTHfBp5ACSjkGkYQgOH+qjDzBjnNUfrTnJh3fDFInbAGorLVE9NLlhLgS83LGbB7vWB+x77yXDfET+W3eBpUOJYR8DD61i7wpuGjQM6JPC/09cqAPrHjEHVtWUqJWpiCFBmK5MZDNlCtAxXS6dhRKVBcWHmwvJ7PJf7Po97ktmuFCctqHKc3zyFz/jXv4W5gW81gRDdDM+Eb1kZ5cOPuZqG/iu2oueJUIMzT5ZRZwep4Oy2tCUftadCSkuofld1BmjLZAWkXmdnMvhmuO98w7hjEAD1ljBuOk+BBwTph5iYioZBgECZc021UVCAW0ePOMEzptwyaV5iuvjMGkz/Nd5hsv6GEWvpqFreVFpu7oqTAD0gtAVIL+emgdV8lDDr7vHrqfEuQoUoglLtz2RKQ5TxSqq91aWVzI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(36756003)(478600001)(54906003)(6486002)(71200400001)(38100700002)(122000001)(41300700001)(8936002)(8676002)(110136005)(91956017)(66476007)(316002)(66556008)(76116006)(66446008)(64756008)(4326008)(66946007)(2616005)(83380400001)(966005)(31686004)(6506007)(6512007)(53546011)(186003)(86362001)(31696002)(38070700005)(2906002)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHAwNzU0WVg0SVBqeXZnaUdGd1RsYUNZMk5yanhGZThkeEJ2Uk9hbFpMZWlh?=
 =?utf-8?B?VE94MFFSU25kd2FNOEhGUjFyUHVJTVhLR0FlRHVtMlBpdGVFQjZzdFlhREFv?=
 =?utf-8?B?SWxWdEdVd3I2WHZrL0RqdDh1ZE9tNThGbjQ3YUR6azhPVUlXSmx5UDdQcTNv?=
 =?utf-8?B?djBxV05yU1ZRc2p6ZUJKZ0lRcFRXR0N2VnJPVW9mYWJ0d2ZPamUyY2lUVUhX?=
 =?utf-8?B?SSsybFBuVU1qb1piTHBiNloxVUcxQy90Z1NaS3FNblR2dFMvbEplMmVyYm9Z?=
 =?utf-8?B?RUNWM2tYV1NXTWkxdGZJdGd3aXNhWGtGQmdueEhDSDJFSCtEbDhwQmttcXJK?=
 =?utf-8?B?dzYrZEtGY2pwSFY1K1V1c0lHOWVDUDJIVE9HTlU4cGI5VzN5QlZrcjNxZ3Vj?=
 =?utf-8?B?OGErbnh6Zlc1VWEyRlFuQ0dZT0pwL1BUSlpQanlucXlvT2RqaWhPTWRCUVl6?=
 =?utf-8?B?dFNDMHcvZ0JtK1EwS2cvYUtUUW1idGtSUjRpbWg4bS9uck1GMlFHeERUVkVz?=
 =?utf-8?B?WU9aeGhndGc4QzBkeERvb0NOeVZWN052U05OYi96ZW1IOTNNQjE4MWJ1NkZ6?=
 =?utf-8?B?UExFQXFlb01OVDRieFBiTDBDUm9SUzZVNzR1ajVrc1hIbHRXNFdwQ0hHL2NC?=
 =?utf-8?B?TlZsc0I4aXF3c0hUSWxRcHp0S0Vtczlyelhqbm5xaWtXUU54UHpmWUUvNWZF?=
 =?utf-8?B?N0FLbm9TN0ZXcnJrYTgyalFKTDYxbkRoRmRqZVIvZXdzWFJQU3ZCY0VpMlMy?=
 =?utf-8?B?OEhnckt3dTkzdHpmYys0MFh2VkNyeis4ekZZVTJLWlorWjJHK0NpTjc1Tk1I?=
 =?utf-8?B?cWZtRDN1MktRVFZ4VlNQVmpWKzk2NlVHU3ByQ20wbDd3ZHZIRjF6R2d0WS96?=
 =?utf-8?B?WXZKQjBJdkpQY1pGTm04cHkwY3FyTG9MbGJ4MDBiMzltVjh3VERmdjl6dXV1?=
 =?utf-8?B?blptb3lVaEtjK0o2amxHVU0yME1rZWhlelVOa3FiUm9zR1M1UHlXVVF2ZHVh?=
 =?utf-8?B?bldISllWMm0xYmVoS1FUSnlFTTJWTFBiRFdOYmErYzlSZHdCdnB2OG9UQ0tX?=
 =?utf-8?B?Yldaalozak5qd1N6dUFSVS9SRERuOUpFYXkwYnQ2K1pxSzFBbnVsa25HYzZI?=
 =?utf-8?B?OU82TktsMjZGdU94SlJEQTJKbXhXVjVkU3dqOTF1eEZlM2Mvb0QvM3UrdEVY?=
 =?utf-8?B?MmVqL0REaUc2M3M3WG5Gc09POTg3Y3RCS2VhT3k0Ym5ISTBKWGZLU1BzUW1W?=
 =?utf-8?B?ZTdLOWJqZXdodUxQYk1oNU9wZVRFbTlPdG5FWFAwemNFeWFOSWNiU0xybUNP?=
 =?utf-8?B?bHU4U1NrZ2xBV1hGSCtLaFJNVUJFYzlYT1MyUVhDa1dMMVVnVUhMUUIrNGg5?=
 =?utf-8?B?dWk5b0h4c2tCNm1zb052UGsrUHBBNnd2Q3Y3bElTUVZVVU5iTXZvM1BQcmR5?=
 =?utf-8?B?Ny9Mb01NdUcrZmovZzNnR1RuWVk2TGV1RUFCVG1QOG5lbEVaUGQ5V0JlQ2pH?=
 =?utf-8?B?RnZrOWdaWllGVFlnamxDR3JZK3FqMFdQV3huV2dGVk5KNjgycnBOTklNM0N0?=
 =?utf-8?B?UStiS0FQaG1JdUFTMG8zdXdCVHg4ZlZtOG8wbUxxN1RhMFRuNVNJNnFYLzBC?=
 =?utf-8?B?UnJEdDNzRWNXUUFpNkduVnZLOUhKYytEaEVZY1MzWmJaRXdQS0Zab1JDWm9s?=
 =?utf-8?B?cjRoNGcvYWxYVHA1cTEwc2k3dE1OWXVoL2JSazdQRFJOajJjWlNkdmRIS0tO?=
 =?utf-8?B?UnA2NytnVU9WVzlPazFuN1hPZHlIcjVoQkswMFZvT2IzVHVsY1FRY0xadVNX?=
 =?utf-8?B?dEVhTTJLc1lCdU1ndUdxWnExN2svMnZXdzBOY2lDaXJFc2ZqekpkSEkzOE14?=
 =?utf-8?B?RXMvSjVJTFdkc2lEaHVNS0s0VkRNcmQzaHU4clNNb004YzJ0cTNONUMrT1Ns?=
 =?utf-8?B?UHhLQ25Ub3J2R2JMQ2lTUDdtdmNRVk5pRHdKNFpBNzM3aUV6QlB5c3hKcndu?=
 =?utf-8?B?WGgrUzBIaXdGUEtwUjcyRGl3MHRtcjdsWlhBZDhuL3NwcVFIb2FMZTFKaGNI?=
 =?utf-8?B?V2JLNmZpL2FOeXNlWkZQc1NCUklxVU5XSVBIUlJOVHlyYUx2UFNjcnQrOXhr?=
 =?utf-8?B?R1RNL29IM2dTL044b3puS3N1OHc3bUxKOVFkNytEanEzcllFMVdWMWphQ3BG?=
 =?utf-8?Q?waQJJeQEYWX04OnSNL/ZX3Hu2dSaGRtFPgAmXtrmDKQA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8715AFB5FD6374DA2749D5E597AF137@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012424a7-da70-4c1e-be43-08db463229f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 08:42:26.8689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/qCc91NE2iqDRnxFYi7Qi7L6Z/4sOu66ZROSZbLxukMEI9xsjhCGQDds9LYeQO30TDRVE5bq5ytj52vYuqpww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5314
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8yNS8yMyAxMDoyNCwgTWlrZSBTbml0emVyIHdyb3RlOg0KPiBPbiBUdWUsIEFwciAyNSAy
MDIzIGF0ICA4OjE1UCAtMDQwMCwNCj4gU2hpbidpY2hpcm8gS2F3YXNha2kgPHNoaW5pY2hpcm9A
ZmFzdG1haWwuY29tPiB3cm90ZToNCj4NCj4+IE9uIEFwciAyNSwgMjAyMyAvIDE2OjIyLCBZdSBL
dWFpIHdyb3RlOg0KPj4+IEhpLA0KPj4+DQo+Pj4g5ZyoIDIwMjMvMDEvMTIgOTowNSwgU2hpbmlj
aGlybyBLYXdhc2FraSDlhpnpgZM6DQo+Pj4+IEhlbGxvIFl1LCB0aGFua3MgZm9yIHRoZSBwYXRj
aC4gSSB0aGluayBpdCBpcyBnb29kIHRvIGhhdmUgdGhpcyB0ZXN0IGNhc2UgdG8NCj4+Pj4gYXZv
aWQgcmVwZWF0aW5nIHRoZSBzYW1lIHJlZ3Jlc3Npb24uIFBsZWFzZSBmaW5kIG15IGNvbW1lbnRz
IGluIGxpbmUuDQo+Pj4+DQo+Pj4+IENDKzogTWlrZSwgZG0tZGV2ZWwsDQo+Pj4+DQo+Pj4+IE1p
a2UsIGNvdWxkIHlvdSB0YWtlIGEgbG9vayBpbiB0aGlzIG5ldyB0ZXN0IGNhc2U/IEl0IGFkZHMg
ImRtIiB0ZXN0IGdyb3VwIHRvDQo+Pj4+IGJsa3Rlc3RzLiBJZiB5b3UgaGF2ZSB0aG91Z2h0cyBv
biBob3cgdG8gYWRkIGRldmljZS1tYXBwZXIgcmVsYXRlZCB0ZXN0IGNhc2VzDQo+Pj4+IHRvIGJs
a3Rlc3RzLCBwbGVhc2Ugc2hhcmUgKE9yIHdlIG1heSBiZSBhYmxlIHRvIGRpc2N1c3MgbGF0ZXIg
YXQgTFNGIDIwMjMpLg0KPj4+IENhbiB3ZSBhZGQgImRtIiB0ZXN0IGdyb3VwIHRvIGJsa3Rlc3Rz
PyBJJ2xsIHNlbmQgYSBuZXcgdmVyc2lvbiBpZiB3ZQ0KPj4+IGNhbi4NCj4+IEkgc3VnZ2VzdCB0
byB3YWl0IGZvciBMU0YgZGlzY3Vzc2lvbiBpbiBNYXksIHdoaWNoIGNvdWxkIGJlIGEgZ29vZCBj
aGFuY2UgdG8NCj4+IGhlYXIgb3BpbmlvbnMgb2YgZG0gZXhwZXJ0cy4gSSB0aGluayB5b3VyIG5l
dyB0ZXN0IGNhc2UgaXMgdmFsdWFibGUsIHNvIElNTyBpdA0KPj4gc2hvdWxkIGJlIGFkZGVkIHRv
IHRoZSBuZXcgImRtIiBncm91cCwgb3IgYXQgbGVhc3QgdG8gdGhlIGV4aXN0aW5nICJibG9jayIN
Cj4+IGdyb3VwLiBMZXQncyBkZWNpZGUgdGhlIHRhcmdldCBncm91cCBhZnRlciBMU0YuDQo+Pg0K
PiBJdCdzIG9idmlvdXNseSBmaW5lIHRvIGFkZCBhIG5ldyAiZG0iIHRlc3QgZ3JvdXAgdG8gYmxr
dGVzdHMuDQo+DQo+IEJ1dCBqdXN0IHNvIG90aGVycyBhcmUgYXdhcmU6IG1vcmUgZWxhYm9yYXRl
IGRtIHRlc3RpbmcgaXMgY3VycmVudGx5DQo+IHNwcmVhZCBhY3Jvc3MgbXVsdGlwbGUgdGVzdHN1
aXRlcyAoZS5nLiBsdm0yLCBjcnlwdHNldHVwLCBtcHRlc3QsDQo+IGRldmljZS1tYXBwZXItdGVz
dC1zdWl0ZSwgZXRjKS4NCj4NCj4gVGhlcmUgaXMgbmV3IGVmZm9ydCB0byBwb3J0IGRldmljZS1t
YXBwZXItdGVzdC1zdWl0ZSB0ZXN0cyAod2hpY2ggdXNlDQo+IHJ1YnkpIHRvIGEgbmV3IHB5dGhv
biBoYXJuZXNzIGN1cnJlbnRseSBuYW1lZCAiZG10ZXN0LXB5dGhvbiIsIEpvZQ0KPiBUaG9ybmJl
ciBpcyBsZWFkaW5nIHRoaXMgZWZmb3J0ICh3aXRoIHRoZSBhc3Npc3RhbmNlIG9mDQo+IENoYXRH
UFQuLiBhcHBhcmVudGx5IGl0IGhhcyBiZWVuIHdvbmRlcmZ1bCBpbiBoZWxwaW5nIEpvZSBnbHVl
IHB5dGhvbg0KPiBjb2RlIHRvZ2V0aGVyIHRvIGFjY29tcGxpc2ggYW55dGhpbmcgaGUncyBuZWVk
ZWQpOg0KPiBodHRwczovL2dpdGh1Yi5jb20vanRob3JuYmVyL2RtdGVzdC1weXRob24NCj4NCj4g
KHdlJ3ZlIGRpc2N1c3NlZCByZW5hbWluZyAiZG10ZXN0LXB5dGhvbiIgdG8gImRtdGVzdHMiKQ0K
Pg0KPiBJJ3ZlIGFsc28gZGlzY3Vzc2VkIHdpdGggSm9lIHRoZSBwbGFuIHRvIHdyYXAgdGhlIG90
aGVyIGRpc3BhcmF0ZQ0KPiB0ZXN0c3VpdGVzIHdpdGggRE0gY292ZXJhZ2UgaW4gdGVybXMgb2Yg
dGhlIG5ldyBkbXRlc3QtcHl0aG9uLg0KPiBibGt0ZXN0cyBjYW4gYmUgbWFkZSB0byBiZSBvbmUg
b2YgdGhlIHRlc3RzdWl0ZXMgd2UgYWRkIHN1cHBvcnQgZm9yDQo+IChzbyB0aGF0IGFsbCBibGt0
ZXN0cyBydW4gb24gdmFyaW91cyB0eXBlcyBvZiBETSB0YXJnZXRzKS4NCj4NCj4gUmVhbGx5IGFs
bCB3ZSBuZWVkIGlzIGEgbWVhbnMgdG86DQo+IDEpIGxpc3QgYWxsIHRlc3RzIGluIGEgdGVzdHN1
aXRlDQo+IDIpIGluaXRpYXRlIHJ1bm5pbmcgZWFjaCB0ZXN0IGluZGl2aWR1YWxseQ0KPg0KPiBN
aWtlDQoNClRoYW5rcyBNaWtlIGZvciB0aGUgZGV0YWlsZWQgaW5mb3JtYXRpb24sIHdlIGRpZCB0
YWxrIGFib3V0IERNIHRlc3RjYXNlcw0KaW4gbGFzdCBMU0ZNTSwgdGhpcyBpcyByZWFsbHkgaW1w
b3J0YW50IHBpZWNlIG9mIGJsa3Rlc3QgdGhhdCBpcyBtaXNzaW5nDQphbmQgbmVlZCB0byBiZSBk
aXNjdXNzZWQgdGhpcyB5ZWFyJ3MgTFNGTU0gc28gd2UgY2FuIGludGVncmF0ZSBhYm92ZQ0Kd29y
ayBpbiBibGt0ZXN0cyBhcyByaWdodCBub3cgd2UgYXJlIG5vdCBhYmxlIHRvIGVzdGFibGlzaCBj
b21wbGV0ZQ0Kc3RhYmlsaXR5IGR1ZSB0byBsYWNrIG9mIG9mIHRoZSBkbSB0ZXN0cyBhcyB3ZSBh
cmUgZG9pbmcgaXQgZm9yIGJsb2NrDQpsYXllciBjb2RlIG9yIG52bWUgZm9yIGV4YW1wbGUuDQoN
Ci1jaw0KDQoNCg==
