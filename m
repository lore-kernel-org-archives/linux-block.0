Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39866C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 07:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjDFHHr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 03:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjDFHHo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 03:07:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0910AF22
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 00:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFgda77dxLVwTmUXKxkeNobTCaG7bfUkqPW/UIx1SGiUMK1IoHuqXnybac/Lp00JhrtUDFvIVjw+eTewLx+qrxvfRrvuernfe9xYwgVZR9SHHeFpul76Wrak98Su4U9Hfg5HxnctbLu3BGj2FKVw5EdglOkJAUuoWnLE6tyU6wbFi0SUnxT5jlYC39Jmq3KmNDi0cFaX+e16A3OqkfYkXzSRrIfEBYMesy7yeeRe5bmCpmNtR65dQ5PZmRL3pmP27yns0JG3Vlnl7JWHjA9Xidy63DEedFFGwfMh+9ndVat6AyQLHzO1CQdltoeSvTgZy5gNcpuKPZtcj7etKsdXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX2nNT6kmllj30WyQWYWRsHRC/7wgHzTIt+t3HcEWvU=;
 b=CTZpyyd+ShTixs/UnFe9tHCi1e34p6tgwwsC+6mBRL8+aLM1UWCGzJj02njo9zFDCLutnJpFE5zxfv+Km7tW1KXmxqvE8lwKZJO4fn9uQwIic1eDvtp5qFHU3SAKNupQCv5kjhYvaebqZEyMAV4k5pyHPRpchIydY5dbqRpcy7CYKH5zqU2ZHR5ZeyFUNLeb86h6vcEQJNHTrskfKIPm+yFADwe9TgIoQuf4+v/jaJb85b4how7yGUZK4XirUHZu/p4BFLOQhoj6ig8Dc/xjIcIinxfyy4QnStE7aK16z0qec8oaonbIJ+lU6SCIOpOkD/170TH/hWpeFfj7GZJRJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX2nNT6kmllj30WyQWYWRsHRC/7wgHzTIt+t3HcEWvU=;
 b=g/G7nQtDCn7xH6ERPeeaQpqzDri3PAi4DqijFX4zp6ph6fNhhORdH2UYKiNSXbmBglxf2TO5qgac0/nLndDnPGIIO+hh5d/jnvy7pbpTtBu9qP8XYFFmbkDWDRj6FNJzec4htFFxeNvQcda5ZWzqvkqyREhYqbWOqoUx92s1N+Onqj76cDeXpJWLKq+0uaCCwvz6OBRRomNMMUTjpcztcnQMO9RhGE6EJZVqbeqrtWU6+EDLY6mc/4y1g/lRuTdtACaCbD1nE/CwiFqgdNxqmSjUQFKWpUDRPnxaGjecvGGStDCb4zlP7SomOcdKx7hqTjeeFj3ZfyMOHsYSyzkayg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Thu, 6 Apr
 2023 07:05:45 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 07:05:45 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v5 1/4] nvme/rc: Add setter for attr_qid_max
Thread-Topic: [PATCH blktests v5 1/4] nvme/rc: Add setter for attr_qid_max
Thread-Index: AQHZZ9XvHQffJBzcM0KcFulzpb4Rpa8dDE2AgADBfQCAAA70gA==
Date:   Thu, 6 Apr 2023 07:05:45 +0000
Message-ID: <f83b0c8a-3716-5154-9c5c-3989bcf2d320@nvidia.com>
References: <20230405154630.16298-1-dwagner@suse.de>
 <20230405154630.16298-2-dwagner@suse.de>
 <9bde6907-20b8-1e19-8b5c-e26f62f2f9e4@nvidia.com>
 <2w3ki4ntl5m2farwokvepbgtcvd5piywv3cmdyzp4s6su6fngc@55wsvekrge3c>
In-Reply-To: <2w3ki4ntl5m2farwokvepbgtcvd5piywv3cmdyzp4s6su6fngc@55wsvekrge3c>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ2PR12MB8689:EE_
x-ms-office365-filtering-correlation-id: 40bc67d9-c4ff-4bf0-8b1d-08db366d57cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xitSa0gWE0Anht+/gl74+0HjsbgQD6nAyD1smw4i598kUayCV0N5qHbXES1bckLsst2nROjar2PzIFK5douVFw35ATgiCaGb7ZiYpYkQKwFbZfUbJJTd56enl3/yXptYt+/uVWedUNr2wmUXNmOpGTjoi1/HsbVz3fw/9P4lY3kSdHpWqQR1qn0AWxHcsGgebJ3mNd17JMPAeBii0c25RLtBl8Q92+m/m3qfBiMvQfU13sZdzjSWLWJmMLKQ6NVrHzSZmDDK4dgKbEB632HbyrmiKfuVLjqsMHNUIAY+CEI1KOyzkDDaOeKiNqqxrLd00Bqe6X+kar7Pe584BvXcEOKsdMfxgUhfaTi1nmRNrE5UaXmm8oys0vZNW/XVwWNEj7iLTB4ItX03gdyUuY8yrIPSGQMKYkRyip0bOh1JZ3cTLAyI7Makk1SgrdDcq7jDUwFHfzYT2LfykIgzx4a3jV/ZJjfqOoTjqPCNXAutjjEkXEkir9mNY9AqLID+wBIHrcD+gvTNMyOY8D3xatCYb5l9L7v2vFx1DrtihZdbRJd6i9sNETeNbTVMF5zU5VJIvhPxPSoTnxth6aN/bAHrHb4c0n+KXdv7kf/JHEHy1yaksraWL7RfxgzWyforxXv+KGN+e+7QlwSDGvFmqQpf48J9BFivqDBp7J536I9qqehCuARb95VELtFVTVplFWtB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(36756003)(2906002)(5660300002)(6512007)(86362001)(6486002)(54906003)(186003)(478600001)(4744005)(53546011)(6506007)(91956017)(2616005)(316002)(8676002)(66476007)(64756008)(66446008)(38100700002)(122000001)(76116006)(8936002)(4326008)(38070700005)(66946007)(66556008)(41300700001)(6916009)(31696002)(71200400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1daYm5qcFcwZUJEN21vUlcyZ0xiQU82ZWhRRjJxQnp5Sk9zL25qWFQ0dVlG?=
 =?utf-8?B?bVBpbTA2ZTJsNnVORytwYm5QaDBpaEZxTis2WHdnTjQrTEhqRjQ2Wmg1QU91?=
 =?utf-8?B?ZTErOXBzaU9ISnUyOEIrVUVDS2ZFT1I2VVRkTmhQTTRXbDRoaXFpMjdjaHQ5?=
 =?utf-8?B?RCtNZHpVN0VqVHM3bWNrelhYMkN3TUN6ODBZVEFxbGxPUlZKdXh4RXlRNEUy?=
 =?utf-8?B?cm95RFhnaVdjWmFUYnV5VHc2TnBuQ1hNbnZyUUpUWXpYWG5pZy9FbGpUbzYy?=
 =?utf-8?B?UGQ3Y3FYcVRWOFVIcWhKMVg5NFJvTEh1dVRKcW90eTR3TnJFT0gzUDVQeGMz?=
 =?utf-8?B?YjFab3JQOEhGWkt2cDh2SmRJb2NBdFBSa0JkdFJ6RGZYWGV2TjZRZ1B4TmhO?=
 =?utf-8?B?QUVCWlZMdWo5eWZZNm9NNEhRNGc4dCsxQlNiSU1MMUVtSnhmak5tR01Td2Vm?=
 =?utf-8?B?TTloVTArT3lnS2duWnJ3SDk5Y2hpZDlMT2lleFAycFpJZjB3dnZFbitLRkFR?=
 =?utf-8?B?TkYzZFdqcEtRbyt5VDErMlhQMm96TVl1ci9lTXZEZ1pMNUoyTUpESGh3UW1V?=
 =?utf-8?B?blBSemhPWmVVZzBVUG9LNUJ2VWEwb2h1akx5Zkc0c25veWd4bEFMZE1DWW9t?=
 =?utf-8?B?c0tUNkt6RHVIZEVUSVV6QTZ0L29SOHpKck9rSzhPeGxDRTNQWkNGNURyMkNT?=
 =?utf-8?B?SjliWll6WXgwSFFsRkJpbnhUYnBnclh5TFd0bUZFeUtTM3NvcHJGUDU1bXRR?=
 =?utf-8?B?NWpPdFhWRDZubE9zS1Q1YjhIcWN1MmFvYjlRQkVra2MrSVFvUUswUEdjUVVE?=
 =?utf-8?B?dkpPbEtaR0VpTndUalorSkJYL3F0SjZEQUlPVDNuRGZtYlVmd2xCN1dEUk9n?=
 =?utf-8?B?MTQwV1JNNTZoSHJ0T1I5bmR6c3F0K1VXR3R4RGkwUDRMOVJ3OHBhdGZiUGcw?=
 =?utf-8?B?VzBGV1I0Q2JsdExsWjBwNHQvNFh0UHVKNmdjdkVNTzlSNEFZbFFWQllRTkph?=
 =?utf-8?B?VXZrL2VMTmhteEh0bVhzQ3RPYklCNllMZGZLbXB0bHhiTU91RXY4VXBkMDRB?=
 =?utf-8?B?eWhYUmRmV002ZFJLVUdCbjZzdGpnc3J0QlFHZDBKTkdVRFNrdW05SlhxcXVP?=
 =?utf-8?B?c2pQM2FVT1QzVXdOOHkzdEVXQTZTOHY4Zk1SeXRUY3ZKN0NmR2pxYWNWTUgy?=
 =?utf-8?B?VUF4WVBTdHIrQ1RwVG4rRmxWVkZqeTF4S0ZHaUxhSVh4NEx1dVFvTGZxZTZ5?=
 =?utf-8?B?OGtpTnhhclczSDkrYTZMcVdLaE9lbXc0M2M5RXpvWmMrT0FVRzJDWm9ESVF5?=
 =?utf-8?B?SFZLckE5V3J6cm5DMzFkYXJhdm1EVFRRek4veTVPaW5pZnl0R09ROEhjSk8x?=
 =?utf-8?B?dDFjQTUrNjBONG9raHBicUNYd0hKL0NLeXNweWllT0tJaUY5bUt2cFBEUlZw?=
 =?utf-8?B?TUpsNHFYVHBva3ZOaGQ4a21CWUJLblA1WWpWVWFFMmZnL1BwZHBUU0VzUHFv?=
 =?utf-8?B?OEd3b1BCKzI5NklQM014YytCK2R4N2ZYeXYrZXVRbHdaRVAwUGdXcXArdkNK?=
 =?utf-8?B?ZlZiQkRkaGM3WThqcDh5MERTcHRieXlHcUxqa0xFdlZpa1RObVROQlZWWTB4?=
 =?utf-8?B?enlSQmdobUtiSGZzM3ZacStCU3FnYWJraFJENDViczhGSVJ3UEluUVg5SDlr?=
 =?utf-8?B?OEEwRE9UREwxYzE0YS9nMWR0elJjeGxnTTlBZlEvU1ZJQmx1M1VzdmVuWVZo?=
 =?utf-8?B?UXpFUVRBK1F5ZHVOcUtLdFRGRDVVL0VZdVFMK01TKzRtbVY0U09MbXNxU0VO?=
 =?utf-8?B?NElrNEhiZ3hpc3NrZ0JEM1JWcGJQY1FBenBxYTR4R1ZwUmlrV3B6ZjVPZkFH?=
 =?utf-8?B?YVNvQ0t0RFd1NzIwZ2tYTHk3Yms2YzBjMlFHc3oyYjlGZ1Z5dEw1cXdhbUxR?=
 =?utf-8?B?L0xBZmtPTmxlWUMwNzFyYlh6bFA4QWlBMmhZWmlNZnVVb3NabFJwQkhuSVJm?=
 =?utf-8?B?SUxGZGIvNVRYbHZDR0Y4QzgyT2ltWk5SLzlHcmtLd2QwOG10TkhYM0pHbUV4?=
 =?utf-8?B?R0RIN2cvU3hhS2dDeWdiMEoxVlpGMVFZbklBR0IwVXMreFBGdkVEOFpjZlVB?=
 =?utf-8?B?ZXgyMXFqekxtSmNISWtHSlBZN0huK3ZqRytMaDZ2Q2JXc3V5TnU3SmlQR1Vo?=
 =?utf-8?Q?sXGeApo1FBJzDQcidNpDVHbt5qNFDXU65oi6KGv21Sfl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD8DEA050142B94BA6BC175E9B3F7793@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bc67d9-c4ff-4bf0-8b1d-08db366d57cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 07:05:45.5144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Umy7QGx+XjUZA4zSQZhSCF3ktLBlPHRFmDhp5IfaKRyZevPM4skLdAMDLDkDI1mzi1KDTt+xQUQTKoNlBmYgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC81LzIzIDIzOjEyLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBPbiBXZWQsIEFwciAwNSwg
MjAyMyBhdCAwNjozOTo0M1BNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiB0
aGlzIGlzIG9ubHkgdXNlZCBpbiB0aGUgdGVzdGNhc2UgcGF0Y2ggIzQsIHVudGlsIHdlIGdldCBh
IHNlY29uZA0KPj4gdXNlciBtb3ZlIGl0IHRvIHBhdGNoICM0ID8NCj4+DQo+PiBpbiBjYXNlIHRo
aXMgd2FzIGFscmVhZHkgZGlzY3Vzc2VkIGFuZCBkZWNpc2lvbiBtYWRlIHRvIGtlZXAgaXQNCj4+
IGluIHJjLCBwbGVhc2UgaWdub3JlIHRoaXMgY29tbWVudC4NCj4gVGhlcmUgd2Fzbid0IGFueSBk
ZWNpc2lvbiBvbiB0aGlzIHRvcGljLiBJIHdhcyBub3Qgc3VyZSBpZiBJIHNob3VsZCBwdXQgaXQg
aW4gcmMNCj4gYnV0IEkgc2F3IHRoZXJlIGFyZSBhbHJlYWR5IF9zZXRfbnZtZXRfKigpIGZ1bmN0
aW9ucy4gVGh1cyBJIGNhbWUgdG8gdGhlDQo+IGNvbmNsdXNpb24gaXQgbWFrZXMgbWFpbnRhaW5p
bmcgdGhlc2UgaGVscGVyIGZ1bmN0aW9uIHNpbXBsZXIgaW4gZnV0dXJlIGJlY2F1c2UNCj4gdGhl
eSBhcmUgYWxsIGluIG9uZSBmaWxlLiBJZiBzb21lb25lIHRvdWNoZXMgYWxsIF9zZXRfbnZtZXRf
KigpIGZ1bmN0aW9uIHRoaXMNCj4gb25lIGlzIG5vdCBmb3Jnb3R0ZW4uDQo+DQo+IFRoZSBzYW1l
IGdvZXMgZm9yIHRoZSBvdGhlciByYyBoZWxwZXJzIChwYXRjaCAxLTMpLg0KPg0KPiBUaGF0IHNh
aWQsIEkgcmVhbGx5IGRvIG5vdCBpbnNpdCBpbiBwdXRpdGluZyBpbiByYy4NCg0KaWYgdGhlcmUg
YXJlIGZ1bmN0aW9ucyBpbiByYyB3aGljaCBhcmUgb25seSB0ZXN0Y2FzZSBzcGVjaWZpYyBsZXQn
cyBrZWVwDQp0aG9zZSB0aGVyZSwgd2UgY2FuIGFsd2F5cyBkbyBjbGVhbnVwIGxhdGVyIC4uDQoN
Ci1jaw0KDQoNCg==
