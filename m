Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEAEC433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Feb 2022 02:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbiBWCtl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 21:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiBWCtk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 21:49:40 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3994D609
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 18:49:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QM5wMu7oGH6syNihlXI9HBeljVzJXWgsniTm7e9uxxjNWFxGzbgtvlJXCcR0mS9BAtgU2wpc/OCwtnmSBKE6bQgf4l8jBMF9d2aHwKThjhV21PojLQueGPdgC/GJJUN8Ak0hPY3tgY6U0xq4opGPT2OCsq7lHGlDLzrxpPJLcz21h/gDTCJxqdM/Q7pc/Soma11gekZyu33PVR5jhLmtmZprdLZ4a/evcFj3b8SWD7KOvwPjQ5V4ZuKUvtQE52DfFNIFdzUH5DhxbtvPqKmkkazOol78iC3s5wf2jh/jZkrve6AYsE+V+d+/QR58xyVfKCC7OWDUWZJwjibI2U62zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEEuryXdYBGPdgP+WSNISdoQj+XBcPGp4y9L62zPJkE=;
 b=Z+CNYDWBlvaarMmVtsb7WKZ+n4F0khzls6QKrAyW93WdhhSEYvdXz7zJJ0cQSXBbBw/ADKaun4G6aSrGRoUgrccg4TZwJ3ARfxhny0thdCFszkrV80jdJJWJ2FVwI1NkcEJT8PtMfx+kUAYWZZjDH9bXYRfEwsVkbI5lAOxIBe82K+cHVnpXrh4BL056nG7nNv0PkXis8R9TmPourJ3EUoZMtyTvSoDRqQfLByrzFEgj/gwMqFC10SQQDsBqvqylbxd+oVCzvpJ7RzfxZuJD9PbsO3UPt8Z6U2ThnMchvKMI3MNjlnZIfTzlMxqgskNz//MczsSoieeL5JNNuqWcEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEEuryXdYBGPdgP+WSNISdoQj+XBcPGp4y9L62zPJkE=;
 b=j9tJ5LdP7LLp/KMwmY2QXa34eLuvdQ4WJ6AlwmYxyIUncjj269q3H/Iza6sJh5IEijYcJud4U8ukeq+8cjeIpHkKLdH58m0EpjzKCYdo7UnNWWjsJ3ssnIbPIKpnn6zgFcNBMKSTny4ds+WjWSZZhOYeoDGA7h7sJrjo0hUTl8oBbk22uop0onf8CViiS25yiGPZHXcZbjzFq1rocTdKyKfyXqYl6Wsp+FYV0hm+GiZ5TibbNmQ8Z9m6TRDiqovU1YsP/Q7b+KWTos6OSn35IHkZSYWEOefVZM6TRlv505bGrT/3rwgozC8Ay14xEu0sU2bAWdLi7fCLQSo5ywL3Lg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN8PR12MB3329.namprd12.prod.outlook.com (2603:10b6:408:61::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 02:49:12 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 02:49:12 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: block: potential bug on linux-block/for-next
Thread-Topic: block: potential bug on linux-block/for-next
Thread-Index: AQHYKF/wWr/jVoD/50Sb8ktq/+TGzA==
Date:   Wed, 23 Feb 2022 02:49:12 +0000
Message-ID: <ecc72e5f-dd71-d940-d50d-0347631a7933@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36d73567-5d38-437c-06dd-08d9f6771299
x-ms-traffictypediagnostic: BN8PR12MB3329:EE_
x-microsoft-antispam-prvs: <BN8PR12MB33297F3E3425753E2770BA40A33C9@BN8PR12MB3329.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nj37ze1ZsvmIYFLH3Qh2HuWEXv9L7ndKgeXxbjoXfgLsj9UTz0NopPknHmCTcK0JZUjtsTuz0F/WM3TeuhRTitSAHlLrGZLC6YBfKgIJeHVX3KxzrNZFNNW1EFnzkM0ys1ECs13FB32awVId08jSdWzPaQ5Fv3SkNEES/KqBYH/Rlo4PpEMvRD+QbtHsZOS1p8Nrsj6h4VZnn138wS9iJ51svaeZ2mrF6meAc+K/3FVvdDYujl8lRpuRUE78CuYpt/OIovcdp0UF+9j4bsD1s8ppKSynTI+4b7K00TfAiRn+d5GYZb/ucRGXbsqBXHpOxwfh8ifraM8efYxHJOYyGP8QDaNnKKWGxKGrKp3ZN9R3Ip50/td8YsPKJgiZ3rALL+56MobRv/ufMYqSTZ5f5gD8iubYSYC7Gygi9O7cgvirbUuUAYv6V2uvNqFn6rHzwL9MBjlJuy46y6lXF4GrBf/UauR/xErJO43EO8limQ1WFOIEygN1/Mmtv5MLAMVg+yrSznRxLg9ofUanxgMD7H3A/xpTOea0TQh2bAh7ebRjNHqIMR9AGdX+AnSrRCpcmD945wTnvoDPoC2LEMMP6Inz8n4XoPB4VejYCiRj1Wu0/rQk5Ze3mkYoKW3/k32FN2/DuY8D/OQoRl4gkk+oEea+f0h5Jha00Cb71nHdsyXKz3zA7PjSuhb46kBN+oFHZ1mcjH9TJOAn2ax9OoCHsSdOBPbVRg67ohAUisw+FQM9pCmmQbKnCoLQTLpkbcezh1g73meaVws+aq/G64hKTI62nENG2JMpvXFNdU8y1KfHaOqD8YbSmB60zMLRc6oNCIMxWagf2a8a4DTGUXX37b93Ga15k6yv7JqNgTPYprg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(6916009)(91956017)(66476007)(66946007)(64756008)(66446008)(316002)(36756003)(66556008)(122000001)(2906002)(71200400001)(5660300002)(76116006)(38100700002)(8936002)(966005)(508600001)(6506007)(6512007)(38070700005)(83380400001)(6486002)(186003)(86362001)(2616005)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czZ1eG0zK20wdDFPYlFIajllNTFtMCs0STNZWmVpR1lzbEZOM3BKU1pvRnpJ?=
 =?utf-8?B?bW5QTHlHUFVoTk1wZFJRdzRSYjNJcDFtVjcxOXhwa3ptV0ZYWjdBMVNwbHZT?=
 =?utf-8?B?dXU5TVk3Ty9LNHZucVp1Wk5uU3IwdUFHQXRvakw1MThIWTB1RU85SjJNUDF2?=
 =?utf-8?B?ajdOQm02d0Y5N1VFZ1VjNVFyYXJvS0hBbTltaW9Cd1dBYnVZZnlxM0tpUGlj?=
 =?utf-8?B?N3hRVzkwelcrMm1ySWl0ZEcrYXVuQndLb2Y1SklzS210NFdBaHlSUWI4L0xK?=
 =?utf-8?B?RjA4bDNEakZZZTFXNkVoRlZraDIwNUdHTXFKd3E3djBIcEJldHF0ZG9rTUhH?=
 =?utf-8?B?R3Iycjc5dDJFRTU1N2k4NjZETm8rS0JnNDl6djRlTTRRRG9hRyt6N0tIdWZU?=
 =?utf-8?B?UG1OLzFyQU1CT29KYkhMWXF5aStZRDkzMngzWEs3azJPNlVKanMwenhYR0hT?=
 =?utf-8?B?c09RcldBeDJXQUQxVnhMb0ZzenRHWXU1YkhLaTI3cFZlRzhxRGVKZS93cEdy?=
 =?utf-8?B?QVFHVExSWk5VbW1pN1pEV2lrdzlGZUhnQVhzRDR0MDVEY3hlbVFLYk1xanl1?=
 =?utf-8?B?eHArMHZ4Q056L1hwQllOeUYybWx5RFRpRisybmhNSEFuMGZWekE0bGN2WldZ?=
 =?utf-8?B?bmlWL1F2UkZhV1llT0dxdmU4L1FWYkJWaFovcHl4MEl1WjV1VDI0d1N2L0g4?=
 =?utf-8?B?RHk0NkRCZkdUenBFNElxR0tSU3JjRFQxOTlIRStRUkc1cEJrdy9OUStaNkRa?=
 =?utf-8?B?VGR0RjFpVHNQREd0WW91azlpNEJmeENXaDRwY2hRVW9jYVFWOFh1TzJBSE0y?=
 =?utf-8?B?OFNhTUsrZ2loRWNkdVRHendSbkVDOS9lUzMwZXM3aGVDUnBOZmZ5ZTFEbVpk?=
 =?utf-8?B?ZU9MUzkzL3ZIQS9jbXV3dXlmS1pqTUVKbW1yQllFcFBqYkxnaytvcUFWQm5z?=
 =?utf-8?B?Y211WVUrNGw4MzgwUGFFZjB3dktzdlI3VWJ5ck1FNXNOU1J2VFZsL2EwNGRv?=
 =?utf-8?B?Mzd1M3ZxSnZzNUdGVlpIeVlVaWpHUVQwRGxBeklTMWxseitZL2JDb1FGOXhO?=
 =?utf-8?B?bHpSR0Nta041eG5Ib0xvMjVqajY5RGNxSTgrZWdEdGg5cVpqN3huMUYrT0Nh?=
 =?utf-8?B?WE9KZ2VoWWpQV1ZXU1hqOHZNZ240WHAxY0psSjJra1RYKzdGWWlVeHphOVdQ?=
 =?utf-8?B?S2QzU1lpU1BmMUVWMmhSQm1sV0FjMWpqdDY0NDZqdUpWL0ppQ2dEWjdaYWph?=
 =?utf-8?B?QTI1S3V6T0gwUWo5V3RINk5aWjJJSVZVbFlvYmRDZXo2NGFCbkF1M3RwK3FD?=
 =?utf-8?B?TGlTNGJZRFZoQnU3eWlFbVNxTWxwb1I0L3d1VFZNSGVoVWp1R1dHYnZjMk1n?=
 =?utf-8?B?YXdDdE9KYytiWWc0Y0hIc1F6ZkFOYmZ4TDFmWXQvNlBZblRyQjNwTVg5N1Bo?=
 =?utf-8?B?TDB0OVJEMmpaaGxZYXBsc290bTZNNm1KQTBJcllHNzlXN3hwVWVuNGU2ci9h?=
 =?utf-8?B?Wm5tZ3Y2UytVbnBRZTdiaFBQd3Ywbms1SnErQjZJQTBPMnVFRS9TTmhod1Ri?=
 =?utf-8?B?V3pjOVgra3piQXFmNUs5ZDJwd0ZSRi9tWkU4U084eVl4L2ttRU4yQlkrUTNC?=
 =?utf-8?B?enVENTJTWnkwZWpnd1BieWxGVXA2RWM5VkdSYXkwWTZkYTBQMkdyYitSRGhC?=
 =?utf-8?B?RlNaWXRWeUVCK1BBbE0vT2NMTS9rTHZ4c3hBWUZQT3o3Q1dTaDNwNDVFVU5i?=
 =?utf-8?B?VnNlclJtRzlRVnVJdzBpWGdKdFNHTXYzdnY2emQ2MUJoQWVSRU1YUzhzR1ll?=
 =?utf-8?B?K0kxRG0ybUNpamZpVjQ1YWFXUlp6SVNTWmdVa29jdkpLaGw5UCs0WE9uOFF4?=
 =?utf-8?B?c3RpSk5aVWEyMUsxc3lPbENtWmFtVFNUTkM0Um5CQ3hYWDRYemtlTHpESStp?=
 =?utf-8?B?RXFub0lVRVVXSTlhSURXbHF1Ym51dEs4bkt1T2ZxT2lqcEdSZXZaVWFVRW1K?=
 =?utf-8?B?am0yQ2NyM0tCZ0tnaE9KM0pYLzlmN1JMSUQrUHdscVNKanJuOGxBcCtNcjQy?=
 =?utf-8?B?WUh1bkxZWmtWR29CTmNDWCtpWE9yYmlnSGxCKzNQQjN0T3drSTM3ZUcyaHJW?=
 =?utf-8?B?TVlGdHQ1ZzVGODY4Q2JseGtKeklGN2FTeVZyOGF3elpVRC90aFc4Um4xcHNr?=
 =?utf-8?B?V1dNU1plTyt3ZTlLTVJNbklXVHdlWUhRYzJwcXNmbVoyME9GMGpJNFlWbVVW?=
 =?utf-8?Q?y2MwxWh6n2gOpBsNYsVCw2bdPGVK8gXa2bqINkqbKg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE0910AA23F2E74AB7BA7B777C9AE2B2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d73567-5d38-437c-06dd-08d9f6771299
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 02:49:12.2101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knM8Jwst/1DQfLCHPBbQkt9zzZxIfgpHgLSe0cQFh7zi0GpQ2jrBtjrcKzaZm135Fe7lAemp86Gjqw07NmbVHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3329
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGksDQoNCkFmdGVyIHRvZGF5J3MgcHVsbCBvbiBsaW51eC1ibG9jay9mb3ItbmV4dCB0ZXN0IFFF
TVUgaXMgbm90IGFibGUgdG8NCmJvb3QsIGFueSBpbmZvcm1hdGlvbiBhYm91dCBob3cgdG8gc29s
dmUgdGhpcyB3aWxsIGJlIGhlbHBmdWwgYXMNCml0IGlzIGJsb2NraW5nIGJsa3Rlc3QgdGVzdGlu
ZywgaGVyZSBpcyBkbXNnIDotDQoNClsgICAgMS4zMDQ2OThdIGF0YTEuMDA6IFJlYWQgbG9nIDB4
MDAgcGFnZSAweDAwIGZhaWxlZCwgRW1hc2sgMHgxDQpbICAgIDEuMzA1NTg3XSBhdGExLjAxOiBS
ZWFkIGxvZyAweDAwIHBhZ2UgMHgwMCBmYWlsZWQsIEVtYXNrIDB4MQ0KWyAgICAxLjQ1NTk1OV0g
c3lzdGVtZFsxXTogQ2Fubm90IGJlIHJ1biBpbiBhIGNocm9vdCgpIGVudmlyb25tZW50Lg0KWyAg
ICAxLjQ1Njc0M10gc3lzdGVtZFsxXTogRnJlZXppbmcgZXhlY3V0aW9uLg0KDQoNCkhFQUQ6LQ0K
DQojIGdpdCBsb2cgLTINCmNvbW1pdCA1Nzc0ZjJmMDQ2NTQ4MDRmOGUwYTQwY2ZlOGZmM2Y4Y2Uz
YzBiNmM5IChIRUFEIC0+IGZvci1uZXh0LCANCm9yaWdpbi9mb3ItbmV4dCkNCk1lcmdlOiA3ZTA0
NjlkYjM0YjggMmZmNGVjNzgzZjRjDQpBdXRob3I6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az4NCkRhdGU6ICAgVHVlIEZlYiAyMiAxMzowMDozOSAyMDIyIC0wNzAwDQoNCiAgICAgTWVyZ2Ug
YnJhbmNoICdmb3ItNS4xOC9kcml2ZXJzJyBpbnRvIGZvci1uZXh0DQoNCiAgICAgKiBmb3ItNS4x
OC9kcml2ZXJzOg0KICAgICAgIG51bGxfYmxrOiBudWxsX2FsbG9jX3BhZ2UoKSBjbGVhbnVwDQog
ICAgICAgbnVsbF9ibGs6IHJlbW92ZSBoYXJkY29kZWQgbnVsbF9hbGxvY19wYWdlKCkgcGFyYW0N
Cg0KY29tbWl0IDJmZjRlYzc4M2Y0YzYzNTI4OTM4NDM5OGQxNGIyNDFmMjFiY2UyNjkgKG9yaWdp
bi9mb3ItNS4xOC9kcml2ZXJzKQ0KQXV0aG9yOiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlk
aWEuY29tPg0KRGF0ZTogICBUdWUgRmViIDIyIDA3OjI4OjUyIDIwMjIgLTA4MDANCg0KICAgICBu
dWxsX2JsazogbnVsbF9hbGxvY19wYWdlKCkgY2xlYW51cA0KDQogICAgIFJlbW92ZSBnb3RvIGxh
YmVscyBhbmQgdXNlIGRpcmVjdCByZXR1cm5zIGFzIGVycm9yIHVud2luZGluZyBjb2RlIG9ubHkN
CiAgICAgbmVlZHMgdG8gZnJlZSB0X3BhZ2UgdmFyaWFibGUgaWYgd2UgYWxsb2NfcGFnZXMoKSBj
YWxsIGZhaWxzIGFzIGhhdmluZw0KICAgICB0d28gbGFiZWxzIGZvciBvbmUga2ZyZWUoKSBjYW4g
YmUgYXZvaWRlZCBlYXNpbHkuDQoNCiAgICAgU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxrY2hAbnZpZGlhLmNvbT4NCiAgICAgUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPg0KICAgICBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjIw
MjIyMTUyODUyLjI2MDQzLTMta2NoQG52aWRpYS5jb20NCiAgICAgU2lnbmVkLW9mZi1ieTogSmVu
cyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KDQoNCi1jaw0KDQo=
