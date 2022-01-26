Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316B2C2BA4C
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 05:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiAZFLi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 00:11:38 -0500
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com ([40.107.236.53]:4449
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229691AbiAZFLh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 00:11:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9K+9t3Q9uB2mEgEgDY7BrxHOAliofk25+/oupUoH8IJBJEXhp/9xvW/HrAniV8OMVHy7JKzbApn/1aIryvT8Dvmi6AtEX043syzhFSq9np/9FBvQzMAy6grUArlVmKvQ1ougEnAWT737Uy9YSm0BPm23CFFrgu59Q0rAcFP8UOXGhZeT0MYdgHdf4HaQbyQQ7UoXxCsUQQeIZQ1kJ9xMsJp4bh41/ZSIlfesEfckHk+rUZKhgkwl3gDXzAnvAayCQmg8QxDiB6IUThFBRRQ0wxPw5kq8w7iTZeEUybukVtjE2yltmpAIeLG+5azqCUSX/FW6n4trDhmDhZ3ZRI50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocX/37X6/NKK8SIaDski3djXuouFBxLtZ1WI4LQK2P8=;
 b=nFS2F7juyk3E+p/o8EBA31TMAYkoCKQASBsp8sSrh4XilzomQol3GpX12bjZyOQMqGdr/wRQu80pNnLVUBCNlTpVUNOd2w4cY7Ca8jTXh8PX1YsL1lmxz8pd/QOcsaV6IsZbhuyNXeHRjh8t3pUiDWSO9575i+tCKS+WCHVq/uFoxricvA4f/NvxBy7TQx2T65fhDb83yBht6t53XOi71nHRb05nJIVaKTk4lZD6H63mJWxG3Y6h6DpqA/JMP38Cs8PKeTxeWdicVwpoDhLI3QavsziZpEPDmZwFc48ER4edG1Jt4zFrNiv0G3jHXJcJpT9pdQvKBelNtSBTW2r3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocX/37X6/NKK8SIaDski3djXuouFBxLtZ1WI4LQK2P8=;
 b=Fc00Ux9NGh+aNJwSm9kpl/ciJe8L+tj16rLh/d4Ucmc51Ns5zVMO2+QV7UXK8FxPgUNXRYKGqquUrBiUNVfKSl+QLBd9EZdAemm6c1AVikIxXT6bUCmAN9wwj+9cn5j6asRAUuDjJpdbLF7P4I0OE5y7+u7XZnTvqENBwh8z1PHsHgGqbn7iDq+mCI09Dqf/JWXo4k+pEHHiLCPY+TSiceOCBT+PfWa+J/GFVYVjvq7BEKNPBsP98CWuGRL9lU6rMVphLv9KJGH7wU5dEtFWA4mtqpqx16kk4MfKw4cxk2ceLxlwED6RHR1qEeFtxxezFUOtAHoSLNTk4TsAU7UBbQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BYAPR12MB4613.namprd12.prod.outlook.com (2603:10b6:a03:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Wed, 26 Jan
 2022 05:11:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 05:11:35 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/3] block: move disk_{block,unblock,flush}_events to
 blk.h
Thread-Topic: [PATCH 1/3] block: move disk_{block,unblock,flush}_events to
 blk.h
Thread-Index: AQHYEQZFq48mdolDFEyiWB7cGCrTQ6x0xFMA
Date:   Wed, 26 Jan 2022 05:11:35 +0000
Message-ID: <70375fcb-b742-0fd0-8623-c806da19e2fa@nvidia.com>
References: <20220124093913.742411-1-hch@lst.de>
 <20220124093913.742411-2-hch@lst.de>
In-Reply-To: <20220124093913.742411-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bc238b1-4617-4d57-398c-08d9e08a5309
x-ms-traffictypediagnostic: BYAPR12MB4613:EE_
x-microsoft-antispam-prvs: <BYAPR12MB46130C884F76BBEA03DF6CFCA3209@BYAPR12MB4613.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:397;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6jfDpuAIxF5btf6RnMIWx1Ytt+kZRZo+1jisTjHGJqMVgg6NN+E/nNDOZnkCmKpOSdqIqy19NGB4eyV4iMHJyKeX6HAu0ZtgsJ9ZW7OcdFPZtKEe4atb98+zaJ0M05Iks8gWu4Lh990BFC95/rgzCIRp4j0u6GXv166QKDG9W3eAN+pZEcSEWBuXulMP8mvw0XTaZhtQLcjVOiX2zYWZfrcjDGBnuph4N2kSZoFXoAVkGwYVFwAN5yb16S8l/ObZz/RcUMNGDCXrs3DKSCgFGVrYmqsUpVFIwWdRRdzNiV68peRuq99cf3geTWFo2KeuQdxngwR4Du1lIXKsT8ZZdRTTglzpuIlahxNiYcicxtGAAxAKtVfawz/3/ekdQYTLX5vxSXA9GTzSnTLz7ZiTtU6sN2IifZkhYEZc2MZ7JORE6Dees7a2rBXkRoAIQ2kom93LGvDaL3yOR0WefJfU4efQfplkFhoGiUiSijEa6NVHHetgh4Pmhg5RR7e0rHe10G1pSSItfMsj3lF19nluIPihotiU75Yy6QFE6EL80oG++xraUTWCStV6F+trJ7x93VVX3zIDLo2KwCfwHyMwsW19c5b1kJYsRW5HwKzDKYf1c+jqJKloNw165WjXuuD9prcnK0eTru1fLTLGR3iXhdj+rgowUgoa9NEMkiFEnTamgRTIUhwaoyTIQbJtd5oVTZiHNK+ZF/Ligy0MPsM1Mcg3CpFkd5t0yK3W2RhyNbMst7dTm9u+DL0OlXHCkGUipizF2R3Gm7w9VAWktyP0FQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(6512007)(6916009)(31696002)(2616005)(2906002)(38100700002)(54906003)(316002)(508600001)(53546011)(8936002)(558084003)(4326008)(76116006)(66946007)(66446008)(186003)(36756003)(86362001)(8676002)(66476007)(91956017)(66556008)(38070700005)(71200400001)(6506007)(31686004)(5660300002)(64756008)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnlpN1Y1L0NFS3hpcGY2eVMvRm5ha05sRjhXcmJFc0cvaUc1NU0vcUt6dkVz?=
 =?utf-8?B?cEo0UnVWYk5tN2NhTjZLeGhIK21xbFI3MzUyNnQwbDZqL2NVQWU1QWtlUUlS?=
 =?utf-8?B?THZDRDBtSDhkdzA2Q0hzQTVSdXpjSnIzUmZMRy9XMG9yS3llMkhZTE9GbVZD?=
 =?utf-8?B?c2JEcDJUM0JRbTZNS0dQV2lHOXFBSEp2ZXUzREJsSDRDZUdYd3VUU3RnU25D?=
 =?utf-8?B?N1RBR3Z2Q2R3eVpVbXMxRTM3TWpxK3VOaEVKZ3VnVTVxaGNlZWdXcHhIbXBE?=
 =?utf-8?B?d244VjVub1ZpMGpoRGszQlV1bnh5MnNKRWZZa0k2SmN1QWhiaHNlKzFJbmNp?=
 =?utf-8?B?S2lUVnlDZ0NyM1BINUJuS2Exais4NnN1Zkp0OFJpQnVmVWJ4a1RBMWt0ZVZJ?=
 =?utf-8?B?eHY0bmRWc2gyNDkwaDNYeW9oelpqZ0kzeVZYOG94eUs5R04reDBOYVhxc216?=
 =?utf-8?B?V21rbEdRUnlFeGw1Q1VnV2o2WjM0OXRIUXJPbjU5SXROZzZBTzJNa2JtMUtn?=
 =?utf-8?B?Mzkzc29xbUJtOEIxeW1CMjhDRElZQUZXNko1RzQrck1TNWpoWDl2K1Y4UWl2?=
 =?utf-8?B?TndDOW5PeTc5Q2g2UUwyMjQzNnZOa2ZCUGZjaEVxUitMYlhkZjBtZ1krbzBL?=
 =?utf-8?B?Q2dsOTRYV2VPK0M3M0hnS29QOXBsc1BTK3RJM2Q2dXhwZFBYeWIraUJvT09V?=
 =?utf-8?B?TWhOS25rRW9SN0dBR1NQSFdhejR3OFJlQVVXdEg5Y0o2YldicnJVaVhmRjhX?=
 =?utf-8?B?TldodjJEYnJRdk1lNWE4N3NXT253SFZKc1lhSEMzREhEazNQT1l5WnRSZnR2?=
 =?utf-8?B?enFqNU9aK3ROZWhKTmFKWmdWeFFFdytGY1hIbitPWTZsZjUzTDFUYVZwa2Zy?=
 =?utf-8?B?MVBSTlIrbTVpMGZGeEd0c2dZc0RlWnpobDcvK0UzWng0SDMwb2w2ejVRZ3NF?=
 =?utf-8?B?SHJyNDROMnBWakZXVTJxdEpiTS8zbml6OFVSaFluTkZ3QnJxTk94QzRjblV0?=
 =?utf-8?B?enVycTNidDBjVGIwZmQxem5rTlk1YUhNNUMvbW1veFZXbk5YWEFzTEIxY2hn?=
 =?utf-8?B?cXNZS0x2ZXRHNWw4TjVKZCtZTEp2eGlCTHFVM1Nodm96Y2hiOEVPTjBEbkhS?=
 =?utf-8?B?OFc2Z3AwYldjaGF4ZjVMVlFqbmR5UG9BeGFCNytaRVdKc0VjRTdFeSsyUkxz?=
 =?utf-8?B?Z1dvZHNMN3JnM0tlbDR4TTk3Ky91UGorMTNCQ0xQYno1RU1aWE9nVU9kUFdO?=
 =?utf-8?B?R0ZsN0d4SCs5VFFjVFZ6NEZnb0YxNW5PalpEeEdIVnh4UE9QT3RKOEZndFFG?=
 =?utf-8?B?TWo5TGVPSDNscjBKTThiSWJ0QVRQK25VS3FhLzJoUWl1ZEdXM2xGLzdmK0Zo?=
 =?utf-8?B?dVNadHU4ZjV2NDlBQit4djBhV1A3S2oxVVRaZlVlZnh0ekZyL25NU3M4elZy?=
 =?utf-8?B?eTA2cTBwZSs4bDltaGNxc3ZQSi9oSXBFWUhXWG9Bai9Uc1F2K1FqZjJxK2hS?=
 =?utf-8?B?TVJCanVlWi92a3QrQ09uUThmNXFCb3RTWk50dzNEMzdST04xRlZ5WGtadmk5?=
 =?utf-8?B?dDJOTEtNN0pTYndyZFpHTU13SkVKaHBCK1Z1a2VvL2ZNbTRIdDJYTjFuZ2Iw?=
 =?utf-8?B?RjFzMC9nZWczNGJ1U2xTUmFaL3lkdTNISWFCYnlDQTI4NUpQSE5ac1h0Z0xp?=
 =?utf-8?B?ZmZUV3pva0F0cExuZDJsUG1QRzlwbk1kdnYzOWpyQysrS2l1dytjK21OK2Q5?=
 =?utf-8?B?cEJJRGxmYXNFeHBqQnpKUUd2alF2RlY0MmtJZXFpT2FnRzIxNGs3Z2tRRzFW?=
 =?utf-8?B?MmtyL3ZxYUxWZVpPeWd2NGE5SkFDK1h6WU1LT3dQa29Wc0x2TGdRYnBYRmJn?=
 =?utf-8?B?Sk5EckFqT3p2ekpMa1hZVVhnVUJ2QSt6YzZDT3N0aW1IOWx3bHlkZVZVbmJR?=
 =?utf-8?B?RUFxeE5IVDhrajVrYmhKY0s3dHZOaTd1ZWZsbzNrT2JNMkVCVHhKV2x0Q3c2?=
 =?utf-8?B?eEdwREFCYzhhSVN4dkRWWlZIMUVMaDRFUEl0YmMyRDBGc0ZpQ0JUU2VtM3BW?=
 =?utf-8?B?NWVudVJ4Zy9nTGFjVXRnMTBNQjFwdnpKdjFtQ0Jpc2ZjSGxyUGJRWEZSUSs0?=
 =?utf-8?B?eWhTbE96YzZvZWhGZ2lYeTBHZStoM1pZSDg4emJlZlBzOTNnZ0ZjejE2SnF4?=
 =?utf-8?Q?PVpu1SAkKgskLFXKPHyK9YPhnExMKI511JAJtIPM4dpI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26F4D34A243F75468EA34E88A115C5A7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc238b1-4617-4d57-398c-08d9e08a5309
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 05:11:35.1764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7P0NPxbMX4IJsoAE0aquDMiuUbL/uiED0PM0YQDBBUh8uhvKCkTHuMFqZOoAUPlF3YJalGhxECME03ZT9F34w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4613
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMS8yNC8yMiAxOjM5IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gTm8gbmVlZCB0
byBoYXZlIHRoZXNlIGRlY2xhcmF0aW9ucyBpbiBhIHB1YmxpYyBoZWFkZXIuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQoNCkxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQoNCg==
