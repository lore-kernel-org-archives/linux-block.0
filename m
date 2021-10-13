Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793B7C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1AA60238
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhJMEQZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 00:16:25 -0400
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:65376
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229453AbhJMEQZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 00:16:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ww+hcmfBSakjwWAjWAq4vZMx5cVvg1jMpTeKJJ0QrcC19s7UqXHrlx6oNtbQ1xbxO3gb8UiiKgRbt2XwuQ8V9A3DSKYS4IMULTfwEasu+SzYhXaLHmPW8A5UPtHud5TB0PMoKM3BBg6YCFvhZHSUORyGZNBiS8zDlf8Lr+aEEIiNk+KyjrxGqeo6rYxaIVTur1YEpWKlQUNQjJcM4TrdDSTh623Ueac3iT23umAA1Vv+Ng7BVb5uwWcwUj66OWnlHcJRVGd0sXH09aOzBVVX+V6BWx0Z9uqctVynhCj89PmCym007Xk1mPHYeN+cgdKwd/fbYnMX4x8w6u7Zm4N/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymlv6gDlWzY+luOGCupap01ToZTyEhBGzt+7zzTz+vQ=;
 b=E4c++IJXOJ/YAgdd181It8fZLrVjbTiv+mN9PjoSVZi6yjyTbWFgaxj6xvUe1qUAknyC/g0T2dpXHZg4zZ75mNz3xkO0U9yrkgWhXMI/3A9du2uKfE2K13fFTtncgDNwFurCuPEZWXG6+6PYBJO2rTonBGgFPAK/fZnOwDDCuod/2e/qGzy3yjXH9trzMrbY+D0/PRMXrtEl+Lu5fgRpeoay90rl3SaCljnea6I51YaokMnQZ27XYxa//KcBfPW6bwAzBHUa6GGdSrq6Qs3QsB4iMWE02yWZiGBpKiTbzXk9oXF6ecw3WRR5bJnekymc8/30BDb1pXQ4el2WMn2FSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymlv6gDlWzY+luOGCupap01ToZTyEhBGzt+7zzTz+vQ=;
 b=Lmhx/rNOiNk+J3nqzJaoAiYhmFHyByRfqeGTPVPboRZ7VONt3VJOvmtIC/KVLssnYfwgjMvVh6P4gFff6WcbhBPhf6DaXjLWIvzV3wqodxhmGsm8pH0L7MsXIq+WmLQcf8epSPIczFW/bzQLHHA5vhxcjl17QE5xeGX7rDEAvxIvBTPWfGIF8INscGna86eMJHpJWBL7sSVw89MUcJlI1xL8JSFftc5rCmecBsUZCUrHP5Gd5VZRbblSdJFB13uUaUIhPbxhfY5R8KZGGiH2nrxRTUOf3ywFbUBBN1KRu2Se8SHa9eM8zb+73qQZaZbvLjzkJSPbUMVOhRElPcGPcQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1263.namprd12.prod.outlook.com (2603:10b6:300:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 04:14:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 04:14:21 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: don't memset() the normal read/write command
Thread-Topic: [PATCH] nvme: don't memset() the normal read/write command
Thread-Index: AQHXv5TsaXeORPwhEkyBU1XwVl9tM6vQUnCA
Date:   Wed, 13 Oct 2021 04:14:21 +0000
Message-ID: <e97056a2-2304-3b5e-a297-9bf96147292f@nvidia.com>
References: <b38d0d5c-191a-68cd-f6fb-5662706dc366@kernel.dk>
In-Reply-To: <b38d0d5c-191a-68cd-f6fb-5662706dc366@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec84353f-c0e5-4b53-62cc-08d98dffeeee
x-ms-traffictypediagnostic: MWHPR12MB1263:
x-microsoft-antispam-prvs: <MWHPR12MB12636D3DC87CE0C0A07E8125A3B79@MWHPR12MB1263.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KMnbnbQfdX/IcDqvojak8Z5wEMsduJg7A7F+n8hpU4VNwfvYptMl37w/lpf+he7XkPoRW+Wf2kC4bEQ1H1xYWp4eeumAsSZNu7T3TX5MmneYpP5SGYVxxoTIdsUUBzmGMTkFUM7le6h409pBJeG2jDG1j1UURW4dfgJaJldoHdydUdNqlddW4BhuvXN8isaVp7o6Ig3YkCzenWf8di3dtNrMX/GXRGV1Ueugj6a7kP07P4xewRulP9HH+Fe3Cozb5rqVIb/ZDjdPgAvJCbWZDlXk76GsP8tx3mwWguq5guim7KLA+ymxtDHD3hT+PY0WdH5J1x8wEWR3M5+g0cy7t0OeAI1ktoRSpzyDspBNw/CR/EXdYa45w1BK6OhlrEokd/6StE4CN+He3NhrHDEYldAlBNeLzKwjgUJKbh2MK7JYadMPHYWSmInqudgh9xsh5eoS92stAi9U5429FsTsuX0nxOjYQpAIn1igBZBWIqznVMQThEOZ5w26YaDMUczE0RDfBtEwuFkvVSTXAV1q+gExI2Ly3hGC+X6Rm0A808NoBGmtGPlyZ9ayBQ8JvkMuH3QMEkt3sOqGJsoIWqwmqYJqWRNWGrf7SvCaCHmexYAFQtNmdRcK9xaRcJNLyh1O0dpKueY2N5ZjrlwEHR0K35Y1G7JJtCnem01CmOHZpUrin+QgrjijWhgPkmYx5egqvZiwYEr32tdN2F/QluXKOtse5iGLhTx0ybgoNm09H6PaVs7EB3zrL47nsVvx9jvzQqpBtI1tODdo1ltgmPlqfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(2906002)(316002)(508600001)(36756003)(8676002)(4744005)(66476007)(2616005)(66446008)(64756008)(66556008)(91956017)(76116006)(5660300002)(66946007)(86362001)(31696002)(122000001)(38070700005)(31686004)(6512007)(8936002)(110136005)(6506007)(38100700002)(186003)(53546011)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1RpSjZDS1Q0R3lZZS80SW00WHdXWExicGNVQklhSHJaQ3V2SUNsZi9OeElh?=
 =?utf-8?B?SUlWSWdGQ3ZOMjNTTVNHSUl0ZmRWWTAybFN3UVJLOUl5RXVCQXlNcGRqUmRr?=
 =?utf-8?B?OVdjdWhJNUl1WkJBUk5EU3RLTXhYTEo5SlJBUGkyNUQxMlBxZkZkYWJzQ09i?=
 =?utf-8?B?aVFobHpZSng1dDZ6YktLaUcycDFmamhBeXB1ck8xeWoxQ1FoanN6R1hTbnow?=
 =?utf-8?B?OEVwV3o3cEE1Z25nQ3M5MzlNMnViVXFsYzVPenlTSFM1a2h3U0xkckh4MVJY?=
 =?utf-8?B?MVYyZW8xbE4rSWZDZ2JEQXVXUGlOT3NKQk4yL3BWNFhLcXdIR0Q5ay9LQjBP?=
 =?utf-8?B?QjR2QWsxQUFtQTZGOGhUSU1WcGJIMlY5Ui80OUtPMklDMVZPQkJMTWxKVy9l?=
 =?utf-8?B?bU0wd3AyaC9iamxNNVg3WG92ZDFJM1VDQUVnVkNJL1BSdVlud0g1b0o0QmYv?=
 =?utf-8?B?V0k1bFZlMlg3K1h0QjZpdmtBWFhhRTVpQlNncWo4OFVHVHNHTWxteFh2SnpO?=
 =?utf-8?B?am5GUWszaVFzZ2VVRnczK1BjMWUrcGNsOXRFU1ZnVHZEL0JVM2phQWJpT1V3?=
 =?utf-8?B?SUN3WTJzQWNndUlrOThpWWY1ZnlJMkp6N0pvUnZWaXl2NzVTRGZya2JiMjd5?=
 =?utf-8?B?VVNLeTlhUk9qRzlOQWhERUdaVHVUU0hkdllyaGoxK2VTeTZHUmREd1JYNTJC?=
 =?utf-8?B?NFplVEdkTloyaHgyMVBpaTgwN2RJbVJWVjUvM2c1dFZmVWR5RzgyQS9JdVlZ?=
 =?utf-8?B?VXNGdkNCdzZIei9oMytRN3JIUDh6N3lGUlB0MTA0dkgzeElVOEJtaElJMlp1?=
 =?utf-8?B?elNCTktjMnVDc0xZUDdKOXVPZWZWcXJSNDF6UC9EVExqVzdCbEY3R1l4d1VI?=
 =?utf-8?B?SVNwaFlTWnd6OTBpWGxOQW9ha0xtZXZHZW5qaWhYd3IwU1BoR2xEK3pLaGRW?=
 =?utf-8?B?YlFwU2sxR0VMME1RcUlvZ1UzNWtXMWtrN2ExdUx0OXFUQWkrbkljMnlaWlhK?=
 =?utf-8?B?R21mU20zd0NkWXBQcHV4TDdnOUVHZEpCcU1WR0NnbDYvU21VNEFaeGR1V2N2?=
 =?utf-8?B?NmhvREppTUp0RXhHZzB5OVJxcE5BeFNMdkszMDhkNEhTWGp3QXFMVXMzQUl4?=
 =?utf-8?B?OHpFVERXWitXdTAwZ2gwU3JscEpzV0pIOFZwcmZlaEx6bVpUVlBVajVpN0pN?=
 =?utf-8?B?c3NhbzlCcmVLR1R2Zm1IYVM5VlpTZ1JpUXloNytLeG83Q2ZJRitMNUIzMzBz?=
 =?utf-8?B?M0R4ZUFGU016dEpkTlFNeFZ0SDQwUzJrVnFSYjhpcjdzKytMVVNUVmxDUlZi?=
 =?utf-8?B?MTF1QWkyMHJxNFlHdElmSm1iNW9QME53cFVKV0VITlN5Qm5ZRnE3WERiR29z?=
 =?utf-8?B?TFZ4Mno4ZDZ1amlYb2FHQkt1U2xmd0hCNlc0aFBod2cxQnJ0ZW9wUFdnUEpU?=
 =?utf-8?B?L1R6NWRaOXdqSFFJQTREUUo0RjgvVkwvcXovN3E0L0QrZEYwT3hFU1lZcXAx?=
 =?utf-8?B?Rm5ic3JpRzd0K3IrUzhJbGY4Q1hFenJkeDZVZXp5L1pQTEFQRUZ4Tk4xUEJI?=
 =?utf-8?B?UlN6UGJQZ3RJZ01XZ1l4dGFhK1VXYmFCVDVUbkVWa1ROUFVGUng4ZjB6d29p?=
 =?utf-8?B?R0ZhTWYxUWs4ZXZzSkdzTXlSYlNqOTRlamJiNGxWeDhGL21qVDVOTUx1SlEy?=
 =?utf-8?B?SU56S0xtdG14ajVJM2tpZ3lIRTVoK3pSSDFBdk9zaTRRNXpHbFR3dFR0Vm1H?=
 =?utf-8?B?eFBoczlQRlZHS3MwTkdtNEtpR2dYWXhIcXpEeEZkRjFKZjZyYWRMU2dKM0J1?=
 =?utf-8?B?bzVQdmUzL1lxYmE5bVJlTjlaR1FHTFo4aUZ2RlZ3VUdtUitXSHpvTlJZaU50?=
 =?utf-8?Q?UQBZkqPEFcC04?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ABF577A93C1884798057AC809F54D75@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec84353f-c0e5-4b53-62cc-08d98dffeeee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 04:14:21.2783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /L9NbBZsBogHxDoMKIfbiIu0nftxVMjocFYCXIaZCi0tIfFOy8j6wM/pFpep57g/z66KgAD9FWUSidO1s2aeIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1263
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTIvMjAyMSAxMToxMyBBTSwgSmVucyBBeGJvZSB3cm90ZToNCj4gRXh0ZXJuYWwgZW1h
aWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBU
aGlzIG1lbXNldCBpbiB0aGUgZmFzdCBwYXRoIGNvc3RzIGEgbG90IG9mIGN5Y2xlcyBvbiBteSBz
ZXR1cC4gSGVyZSdzIGENCj4gdG9wLW9mLXByb2ZpbGUgb2YgZG9pbmcgfjYuN00gSU9QUzoNCj4g
DQo+ICsgICAgNS45MCUgIGlvX3VyaW5nICBbbnZtZV0gICAgICAgICAgICBba10gbnZtZV9xdWV1
ZV9ycQ0KPiArICAgIDUuMzIlICBpb191cmluZyAgW252bWVfY29yZV0gICAgICAgW2tdIG52bWVf
c2V0dXBfY21kDQo+ICsgICAgNS4xNyUgIGlvX3VyaW5nICBba2VybmVsLnZtbGludXhdICBba10g
aW9fc3VibWl0X3NxZXMNCj4gKyAgICA0Ljk3JSAgaW9fdXJpbmcgIFtrZXJuZWwudm1saW51eF0g
IFtrXSBibGtkZXZfZGlyZWN0X0lPDQo+IA0KPiBhbmQgYSBwZXJmIGRpZmYgd2l0aCB0aGlzIHBh
dGNoOg0KPiANCj4gICAgICAgMC45MiUgICAgICs0LjQwJSAgW252bWVfY29yZV0gICAgICAgW2td
IG52bWVfc2V0dXBfY21kDQo+IA0KPiByZWR1Y2luZyBpdCBmcm9tIDUuMyUgdG8gb25seSAwLjkl
LiBUaGlzIHRha2VzIGl0IGZyb20gdGhlIDJuZCBtb3N0DQo+IGN5Y2xlIGNvbnN1bWVyIHRvIHNv
bWV0aGluZyB0aGF0J3MgbW9zdGx5IGlycmVsZXZhbnQuDQo+IA0KPiBSZXRhaW4gdGhlIGZ1bGwg
Y2xlYXIgZm9yIHRoZSBvdGhlciBjb21tYW5kcyB0byBhdm9pZCBkb2luZyBhbnkgYXVkaXRzDQo+
IHRoZXJlLCBhbmQganVzdCBjbGVhciB0aGUgZmllbGRzIGluIHRoZSBydyBjb21tYW5kIG1hbnVh
bGx5IHRoYXQgd2UNCj4gZG9uJ3QgYWxyZWFkeSBmaWxsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KPiANCj4gLS0tDQo+DQoNCkxvb2tzIGdvb2Qg
dG8gbWUuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQoNCg==
