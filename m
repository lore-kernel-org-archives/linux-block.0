Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1238AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 09:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A036105A
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 09:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhIJJep (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Sep 2021 05:34:45 -0400
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:40353
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231991AbhIJJep (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Sep 2021 05:34:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsMGE0c5x2sa5BtsvQJWJvAhVG9WNMGBz7mNaMDCGOf+lVY2qF3xA10+iReU3+ujBbYl5iGVjPb1tUl4uHAEmGdSyywR+vT2v2kp5qLP6Q8VrZ9w7vyvqNi1B6amw3CvCB3x1XkjCB88jY7jdep+fD4o4h58sER85/4XZeq0ThBZU0sSl4C/nNH7AChJJ4MiUiUdiwHRWKeEKHopLycaKLAdTkoGVyLpOBpIu9vTh98tdwB6EbSY51qN1XUKGISkcVKrFurVVEfXjuaVqDQM2v0PYzsAipcOtuE2TS+VO4hbLUfr+rfJPU0p9hlfLf80XG9o5XAqY2jEHWrBc67D5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RClFUWF53CQ4jXNazW03BrR/Fgbo7l4wFbFY2XQta8o=;
 b=NCI09Lac4cISfTs4jSKhjIPxw5croUVoi9NB0ggg5tk6qbh2cE5VKnRw6KzITELK4rchzg8gsy0A1FgWQh80hrdeejHnKxbmwqpyhS2Zc4gj/GRId+wcEEoOSEuQDxtzA8/V+3x2GWeQFpiNkFVpM/lrbkfNvkprIxtvZ6NmW7P7tuuTyOW46NnvMkeOZZCp8KwJ7IIXjcOpP9eMTdrY72ew4SoIILUdbePrkcfWdgck0trZ7HKQnYBXxm0dPGafSYXvbVk3G6nKu0DY3/z3HFuxVgkzm+z8Y68J/4NSDSa7eIs0cP0nX9Jd6A6T0BDb18U3lYmH+ZDHyaHcGHugvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RClFUWF53CQ4jXNazW03BrR/Fgbo7l4wFbFY2XQta8o=;
 b=RcOF4OTw92h1Xp4i/Zz6EQD4SsJ+0zMaI0lGlnfegpKidP5bdI9LZfxNpX29zDc0jwsmbQWijsteM4Etxj2bPRxRvrJJlBDBS3GP15NCwAICvAJJnv0z/r49UL20pAa8zOj6o3XuzzantzehCSlNZxT6KT1C9pug1vKrRAT8LCQuM2ZhsctO9z+GS/Y3EvCD6+RX6lDauEUXA5ZV1kouAv+F0ovqxiJuIsm6OYrPMeSOPjHGVofBX/M1HkVRlOJZjjecPvT/eecGAjU1e933v+6GJR5m83zBG4uXOYh6JbGEP64hHZAURbVsf0OnlMQY3W549T46V91DASkmweAhZQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 09:33:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 09:33:32 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Xu Wang <vulab@iscas.ac.cn>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] blk-zoned: Remove needless request_queue NULL pointer
 checks
Thread-Topic: [PATCH v2] blk-zoned: Remove needless request_queue NULL pointer
 checks
Thread-Index: AQHXpg9weQhAXIecWUWrHLLl094VuqudAbgA
Date:   Fri, 10 Sep 2021 09:33:32 +0000
Message-ID: <952d7945-e876-f86e-b4a4-2190c876b64b@nvidia.com>
References: <20210910064412.80446-1-vulab@iscas.ac.cn>
In-Reply-To: <20210910064412.80446-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: iscas.ac.cn; dkim=none (message not signed)
 header.d=none;iscas.ac.cn; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 190e65c1-d908-4dbb-df0f-08d9743e0e45
x-ms-traffictypediagnostic: MW2PR12MB4667:
x-microsoft-antispam-prvs: <MW2PR12MB46673FD6CA4ABAC3D8B571C0A3D69@MW2PR12MB4667.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RCZw2c5R2aD3f5hVOVkhyfdN4wc7sEd2xFLAk/jqEbGCT3LBash2SW+qg2Xu3260g8tUQcx514Vk9wQkkHjJB0n/4p2G5rxJawtkbOqDBglp2Q17VYt8rJ0Fy3qGp6QedYF9GZDqkQ3TUr1ScdxM0HtFeHtdehzl6ZbgHZ5p8o0PlOv9BjQOtyxCW6U+hLhT/5PYdT4z9V1tvACaz5KUcs/6or7J2J3A/I7Dg02pQnzg1WQYSm0KLcYGOwcsU2aUn+xHq8yn3ncx5rUS6KAQ1EfoEQHgk2HZ92/bGceTqD3PxspApIv18hzAJIl+DqnUae3zHUKnqqeJaxqBURFDnOL2iisUHbYvEYDn13AMGeAk7ARgH4gn4ca2V8wxbvZY6IUGT2egnviJTK3DJk5kP6YLf0X7Y+8GwU6PrxZZs1OHCP7OCSBT4Aqit+0fNobo4S/KhoTeYvySpU/SOCYKdbC3vEuB/Ai8agb5g1ie6BGrdWNBY+hGUaI6iGrJQ6z0pXwtIJjphB6qXJ0WIHvYfzA8Ab6fKMNU0B0FHVJhWFQb7d5VXTuwf8QnpIWjR9od9xzo1ku7SBbSIPe6KWAlcMwCg7GGdqPgspT7mogSzaD32eMxbmEaa9RYIRVHrw2xecKwFF6Ni9tbu6MoNx2alUd8AWCtzPETr2oZe0Y/HPCIe9Go6pFp61zTcGDCYRCnR4qjfvOdlgOUkfEBVioS/L9C3jEbHVHPK3JxlLjdFDlU22bRypqKkxQjOn6PzmvS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(54906003)(2906002)(110136005)(86362001)(6486002)(31686004)(91956017)(76116006)(36756003)(71200400001)(66476007)(64756008)(66556008)(66446008)(66946007)(8676002)(8936002)(53546011)(6506007)(122000001)(4744005)(6512007)(31696002)(83380400001)(508600001)(4326008)(38070700005)(38100700002)(2616005)(186003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXRpSmEyRjFKL2ZJTW1TR2kzOXp1VVVRTisxZk9VMzhreTdSTWVsRHFhcSsz?=
 =?utf-8?B?N21QZWpTU0xxMlNaZkFnSmVZNm12RDVNNGwrZXFVdjFOa0c2blAxcTdVVzhj?=
 =?utf-8?B?V28xRU1JaFVlWExFMWxSbEJGTjVmWWxsNzZPQ3dKOSt0cFZRZERMdGFxY2RJ?=
 =?utf-8?B?Q0NkT0duMzI2ZmRoaGNoRlpzM3gxenBqbkJjU2ZGL2ZPUjUwRGovUEVKY3hj?=
 =?utf-8?B?eHBJa0pPMlorSFI3U0N5Zys3Ymg1L2szMDBjc2VPTSs2bUZwcFhNMkJWTDJ3?=
 =?utf-8?B?enVVOUdOOEVacXFzVHM4RVhoc3ZtdU9tMmhHRHQ4VEdXVWRTd2NSaHpsOW9i?=
 =?utf-8?B?VG9UbVMwSVUzNVBVV0NONmczNnpoMExKYXF4OXR2bWVDOWtsZW1OZ1lLRjlk?=
 =?utf-8?B?RjJZSzA0YWdEczhUZW9ZYnlMdWFFTURkcCsycldXWWx0ejErbHZ1UVRnU3k1?=
 =?utf-8?B?MWVrYk54Rnc2bU5WTUx6alJLZmF0VzkyNC9wUS9ZMEZxWm5YaXh4MlViRVRi?=
 =?utf-8?B?STlVRklSRWZ0NXZma1hSMEdzQi9LOWFRMDdTakVhRGIrOGVuMVhKejlRRjZ0?=
 =?utf-8?B?WFB0cE1EaTJtdTdFS1pRYUlYckhRUDBEWXdVQlYycWdlcE8rRVdOczFIRXJj?=
 =?utf-8?B?MnpHMDNvSFZmSWltbjFCVTE1RjVrUk9abTVtVUtETTQ1K0xjQW16czlheGto?=
 =?utf-8?B?OFJCYXA5amExZUtabUtCUWMzdG5rbTNEYmQvWWdaT1FYM2owZ0dzSytzNmRs?=
 =?utf-8?B?Z1p0bC9JbnhURmk5dWZQOXlrRFpOSEpQZUlCY3JNS3BXUGtJRFJpOE0rQ0dZ?=
 =?utf-8?B?OUV3a0ZJUEVFT2czWGI5a2xJMktHekc1VmJRaUhHZ2NBMC9aZVN5Y1FtdGNu?=
 =?utf-8?B?c1lWQjF2STQ4b3lIMEw1Vk5nOFFQcFVNbUZXbEFOa1RxVC81cnJISGhtdGVQ?=
 =?utf-8?B?bzJBeWk0S3Z5ckFodGhyMzlWY2ZkUTBBV210c0FlZUpBZlhFVVlzTU5KeTFB?=
 =?utf-8?B?dWZEVkpXRHMrcXA1MGJ6T0psOUkzUkJNREs1WWJlbzZHQ2U3b2I4UGV2MmRr?=
 =?utf-8?B?cDgwVlFpMnpiWFV1WU4waVRWdUlBaXhKQi9zVHBlNG5xZ1ZhNUR4ME1sQVA1?=
 =?utf-8?B?Nzd5NUJxVzNBb0d1bTNreWc1cDVZbXNwTWhCQlBvQVI4QUowMC91NFBDV0Zt?=
 =?utf-8?B?Vm1CTzllVitwMjhzRGxZQ1E5OGdOd21wanNZN0dzaElNWmd4WFFEZjFXV1M4?=
 =?utf-8?B?SzNWTFg3R2h5WUlvempFYzRmNVNjbVM0Q2p3WDQ0VHJFWXF0ZXM0aU1rQmtl?=
 =?utf-8?B?WGk3NStycGs4bnNRUkZJSmZaZWtwMG51MHRjK3d1eGtyYkRhc1VUazNzcXZN?=
 =?utf-8?B?ZmhGZ0RCendzWDdETHlkd1o0VWJZVCtzT0hHaU8vYmJFSDc3OVNSYjVjSldl?=
 =?utf-8?B?QVFTOFYwYkZ5T3RraTdPVlJqTnFrU2lUcHl3d3Y3dXFKU3FPYXQwQlYyd3RE?=
 =?utf-8?B?WWlFVDlLTmVFdm9UeXpPc3owL0dOT0Zlc2xsaVZsN1gzVVlBWk1aZExwUWdw?=
 =?utf-8?B?OVlUU21kR2I0eWY5WExYbUh3ZE10ek15UDFseE1peW9DVnVMb2lHNlcxYVBU?=
 =?utf-8?B?Q2xCU0N3VFdVaEMwa1JlRjhvMkNQTzd4VTZqOWwrYUcybFJjeC9YWDVtdFpr?=
 =?utf-8?B?ZlowQ2I1SUxINVVzQjJHaVJVZURoSUk0YjFEdnFtKzlLUUZSVUE5ZmNUZG5s?=
 =?utf-8?B?TmRYWnRqelJlZ0xQZU1YY1ZYWnN3SmpTMGxlL2Jsd2hXdW1OUFREL2ZqR29u?=
 =?utf-8?Q?DDBR1rfVmCdvXI25/0nD2hVSkBBQ4uHyAcofA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C0D46594F56A94E94360745B344B570@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190e65c1-d908-4dbb-df0f-08d9743e0e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 09:33:32.4341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4SXBReMTxmpetv/OrnUG+EurmAPyvVvzbtIOhNPIqdah3hzg/LONRilPMK5Qa8Oa4S1H8mPPWomfoNijLlNjOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4667
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOS85LzIxIDExOjQ0IFBNLCBYdSBXYW5nIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbDogVXNl
IGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IFRoZSByZXF1
ZXN0X3F1ZXVlIHBvaW50ZXIgcmV0dXJuZWQgZnJvbSBiZGV2X2dldF9xdWV1ZSgpIHNoYWxsDQo+
IG5ldmVyIGJlIE5VTEwsIHNvIHRoZSBOVUxMIGNoZWNrcyBhcmUgdW5uZWNlc3NhcnksIGp1c3Qg
cmVtb3ZlIHRoZW0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBYdSBXYW5nIDx2dWxhYkBpc2Nhcy5h
Yy5jbj4NCj4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gLSBNYWtlIHRoZSBxIHZhcmlhYmxlIGFzc2ln
bm1lbnQgdG9nZXRoZXIgd2l0aCBkZWNsYXJhdGlvbi4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoNCg==
