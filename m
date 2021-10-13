Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E585C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5BB60FDC
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhJMEWH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 00:22:07 -0400
Received: from mail-sn1anam02on2055.outbound.protection.outlook.com ([40.107.96.55]:42821
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229453AbhJMEWG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 00:22:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTxyahG1KQo/k60zdWEBv25mNMf25oUYQKBZ0riSQbR3T0hUaEI3SmJZ5JNKiNb30a6bTXRQOjx9QdI2CKPslgTXqUZQN3nxjujZC51IzBy1N5LrFlFvYi4wydzm6gAiL8q2eHW72gM3Hha7f854IQUSkx/8GzGCbn77aKORfI5F5Wycy4+8kgGrI5LCLI1X9k5dOKfdwSlp0jaUpdU3UUy+z15iP+Yhuv39h513BqmhGTDdaHmAvgjV1cXL3Bac95GDDRmmuEpu87Emna2gLZoXPWgZ+AVW80hYWMIXTMMT923SnDTRBS/pNIXGPS9+6cWbOgR9YJSeG5GnCAhH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7NDMooQrM8+U95eGZPPZ/2IeNZo8QD9WSndD1U/RRI=;
 b=UH0ZO8GQK56J7fiVgnSGKdPME59gNzQ8dEd5Ma1epJac9FogwPsvDBFk+2KK35N+1thSz9aXr8F/xlzifjMMrff2kA5NAFE9Xvqp5HOMCNEnJDY4je4/jK74TkGrQG7+ObcwjYh1yiFZiVlkAKe620WifcUrQ9VRseXt1tbjXK7ycS7nhblupxoyp7GUGM/ozOhauM9Ct7Z8BajtpreW++DxYiTj52b0/tjyNRuTW5cUbopX3if0AnW+ITEE9oi0NqO/6qWHgyZiw/K/YHBCbsOxsQLF8k1iQdTa/egDFv9bZZTuU/yQ4rdEiPMQYh+gy4oZnFjSEayPCKvdhjmYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7NDMooQrM8+U95eGZPPZ/2IeNZo8QD9WSndD1U/RRI=;
 b=hVOcUEKkXlDS7e3tKVB8s0zc4QYbQTJhyGBzKyFJ/fiBcFh9ZheEBlAzTl77pdHYKwyAt8t8GQX5eXaVi2owcRnx4fiUikUMPxCcXLkVAPCcINHx7qVrUu4ehsZ0ROLR/9fWTd1h8X0pBtMwuCyASyQ57Ur0z+RD2YsW2OnimmZtdx/rKCAQTsG/xqPFuF2Gl2caq0xjickfhNiLksXyKLOP4JFRt5uCHvm/X51zhtVBEuyM97QFSOD3vIKL9ffBz1YTAlypRiDqJFj+JLozkLtmAJbOh+J6bGVolZn1USpSyzeI9RTwbisyfN3If5J/zrX0A/DbmSXU3hx/esYDbw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 04:20:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 04:20:02 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/8] block: move bio_mergeable out of bio.h
Thread-Topic: [PATCH 3/8] block: move bio_mergeable out of bio.h
Thread-Index: AQHXv4V5raB/1+hgpk2jx3glwnyzHKvQVCYA
Date:   Wed, 13 Oct 2021 04:20:02 +0000
Message-ID: <28862608-0a73-93d2-4db5-6e057d69f54e@nvidia.com>
References: <20211012161804.991559-1-hch@lst.de>
 <20211012161804.991559-4-hch@lst.de>
In-Reply-To: <20211012161804.991559-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79b69046-2cf6-4add-93b7-08d98e00ba79
x-ms-traffictypediagnostic: MW3PR12MB4396:
x-microsoft-antispam-prvs: <MW3PR12MB439622C9983C8EA05C4B0692A3B79@MW3PR12MB4396.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:264;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EQc6Yg2gmNQ9+es2E/FwwlQTdukQkxuZP65hQjATWA/vhDHc18+FjRSfoey9z5bJFaZWezCSaLdYH3rs7MEQqoe0QeOivmvmbYkS5R2fLciIYOv1eVwtqX6enIiQ+9CmxWFWT0J78ZDtF52BVH5rJLsV6FOneeHDZVQHiGVc3pXSKF4I5nETtnUuPLrirGvPLmiGcM2qKESoTuvTq/i1YbWmvWEQCtljeM2+1kJwXrGyYKxNDPhgf5LrF7rhu2iqpqobaq7HU/I6actrBEPqp13bHuXcA0o/ys3L2Hh3zgkv68Mlfh7JOizO+HBHpJrrfgH6I7XDkVaHjGxcc0nDbPFYJDh04Jf6rm+8601CLAvMeBUEqPpMIxu6+PQAFmwSTuel2zcewNtSg6KQBZky5WRt6jZtQMdVDzG+IABap4XPxWs9zt1uK0c8BLcB3f+Hvj5leQmxxzpPkj9Xtv3NnT14KcSR0yZuanO3kaD0n5NpBj3PlLL0v9/NWzN+wo1IBlYXGZl1Zxsm+P/lGrP7KquvITAK6jZKuJzS8eTpnpAgbViXjHUkMvEuveRl124Dy1sibyDAQXf58TaGkElHJ6krkFS8UggYxmUi0Sh1V6wCG//6mIdGv8xMTL0cfZCtrepEnMZIU6RzSsRHR07t20QB8vJrFzbCLv7TVR2rLUH4NoIylbdWogxDIjf8+ST/PjeMJzrebXsZ19wcoAPRP+macHaXC8MCyuQs8Gv1p39+J8ZHyA3EVWgqECbgiO/YbQ3VMa7ZzZmUXMAQRhrwZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66556008)(64756008)(76116006)(66476007)(4326008)(6486002)(36756003)(38070700005)(8936002)(86362001)(186003)(71200400001)(6506007)(91956017)(508600001)(53546011)(66946007)(2906002)(122000001)(110136005)(66446008)(316002)(31696002)(2616005)(38100700002)(558084003)(5660300002)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWZVQk1RYjBEeVVNNGdMQnZGeVY2M2srWk5LcFFYMFFVeS83NjZIZEhYb1Rp?=
 =?utf-8?B?bThPdVhySkRLRXVaS3B2b2JDcFE2NW4zUThkZThENVp3ZTVKOEpINXdGTFdG?=
 =?utf-8?B?YTJ1ZTRKRm14MTUyUkp0QTBSLzdTOWNQL1hDZVFkWmRiMTNNM0w2TStIM0ZB?=
 =?utf-8?B?cGNhQVVpeFBqT0Q4OWJMTnhic09WTDhBRTgybmRrM1dFQUJLNzZVTjVjOEhJ?=
 =?utf-8?B?RGw2RENIZmxNcUc0cG5nWjRFL29JRE9kckJWdlRwYmpMUlhSOTZabFh4Zmt4?=
 =?utf-8?B?U0JKTXB5WGtRcVhKeFF0TDdueGQ5czdLT0lSQldwY2ZjaFdWbHFFazRQb3Iw?=
 =?utf-8?B?S0x3a0NNSnlvMnNTenM0M3pGVlZDUW5DcFl1d0FkdTZ3b2xNaitGZ0FhOEF1?=
 =?utf-8?B?S1FMTXB6UGFGcXJBUFRaZlQwYWZMcmIwNmpiczB4RUY3RjdDOW5RS1AxM05K?=
 =?utf-8?B?VWxQYm9EaUpUWnhrVEhDa3NDUi94ZzY0QWNBS1NWVHV2OUczMHNEQURXNmZQ?=
 =?utf-8?B?cGlRRXF4YnlJSHdKT2g1Z0EwRmtjZWllLzYvWlhTUzV6eWpiUjZBQ29IZGNK?=
 =?utf-8?B?K3dkdUxNS2VqQXdndDhrMHdWTzYxNGdQbFNkL0xCZTRyU2xsbS94ZE9FeW9Z?=
 =?utf-8?B?VmZ6ZnNxckIxM2huNVdhYUY2S0tmMGY3SlhrNkVEQzFaVTJ4Q1Nnc0RUaWVX?=
 =?utf-8?B?dncrbzZtWWloeGVRTW1zcytSTjNvcENlK2c2cUlSaEhVWnoxYjhwOWN1RW9m?=
 =?utf-8?B?L0lXME1XTTBIM3pIN3cxWVpRazN0MkZtRzlGdi95Sis2Vk1qUVJqSGtpTU4x?=
 =?utf-8?B?ZEJReUhqRTdVdStmUlk0bjc4Q0hkMEJPY2JUSlk1N1U3WUxoNG53a0ZQdHdC?=
 =?utf-8?B?Vmt2VHpNQTlXc1UxYk11dGhnU2VPNnErTVV6UWN1ZVY0MmdHRWdCSEY4Ri9l?=
 =?utf-8?B?c3NBbE1JQW1jbzJtVHUvbEorSUJ2eS9jWndBUXJwTTBnT1BqcmVaWnoyazBi?=
 =?utf-8?B?RVpySmhXb24rSjBxZWJ4ZVZCSUMvNEhoTXU5czI4bmxWY1ZBYjJQdVV2L3N3?=
 =?utf-8?B?cVgyclNiSDdkYk4rUWMyNDZ2cDc4MHdNT3pXd1BPQ2VpOW9NL3FmbTB1eUJE?=
 =?utf-8?B?ZFNMeFFoRzhHeDFFdEQ5UHR4OHdLU2NRaGplaTJlNXZ1eE5Ya2kwVmpnb1VK?=
 =?utf-8?B?cE9tUWZVNDMwMUxGVGJlYklpYkZxOXFOWS9CNVpSanRBYnE4ZG1ENTdHTldm?=
 =?utf-8?B?eW1uRjJpY1pjOTI2REVXMGk3R3VMSWE4aEN1NGk2SG5wdDRaQktWVS96SXd4?=
 =?utf-8?B?eGNwQm9mL3AzNm5iQSt3YmNFMXVwc2N4aHR2ZHVHcEJ4c2ZQcHpYem5PS1NL?=
 =?utf-8?B?NzNmZ2E1d0tpWmZOTFJoR2RGdlJKMTdZRytuVHhmZWliZlZBdE1OcWVJejBt?=
 =?utf-8?B?aWc1V3J0TDdDcDZuSHcwUzk2bWU3U1dpeWgwL2xYeUs0c0U0eHl2ckhkZ1Qx?=
 =?utf-8?B?L3BZMTJUSmpoTHI4N0NQaE5VU2orRFNoR2p1VWZTVjdPMmVSTzloUVorZHht?=
 =?utf-8?B?YWhndDh6MGJjb0orQldlWFBueVVablE1d0lCUzhRVmFuRGJEOXRjdURHT21B?=
 =?utf-8?B?V2wwNzhrZHA0d2tzVXJSSm5VcitLMnFsdjM0Mmp1OGdCQU51OVV3WFVTOFdt?=
 =?utf-8?B?TSsxK2VLbXNNTUIrcUYrM3Q4NHhYNWpwQkxnSVgxTGlodTJ3SHVzK2xsaktK?=
 =?utf-8?B?YzVoaHhkdSt0L1Fzdy90aTVTTHJML0l6amFwbHMxc2NUSkdRYWd1WlE4VTlp?=
 =?utf-8?B?Mkdadis5WHc2Z1ZjTjlsQmlRVGxQd1ZYNGVpVXFTWUdDZjFYd2tWK3FVZWts?=
 =?utf-8?Q?aQtD4W6+QChVW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B0673CBE80C8A4B9B0D3A35CD3548D0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b69046-2cf6-4add-93b7-08d98e00ba79
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 04:20:02.7750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1ZYleMWsragvqOxxnM32N37+LddDk2V+DQ77w5eEXmI7i1QKogI3Ytxr7d8SFVYvqi0p3aMdDnQrY+s9Fgt8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTIvMjAyMSA5OjE3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gYmlvX21l
cmdlYWJsZSBpcyBvbmx5IG5lZWRlZCBieSBJL08gc2NoZWR1bGVycywgc28gbW92ZSBpdCB0bw0K
PiBibGstbXEtc2NoZWQuaC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPg0KPiAtLS0NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hh
aXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=
