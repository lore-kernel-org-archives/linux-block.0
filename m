Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591BDC433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 05:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32EEC61A08
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 05:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241958AbhJAF5t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 01:57:49 -0400
Received: from mail-mw2nam08on2083.outbound.protection.outlook.com ([40.107.101.83]:4192
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230494AbhJAF5t (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Oct 2021 01:57:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yzd7OJUIpxLJi70FbVzNwd8lp44F+znkpR0ptMAtD0o0NqGh3YLl+0ZcWDgeD1r2k392MjvN088UVE32zpJnQFfd6Kj3W0GKbvAAFIUlCFb7YsZuiN/wi/RP5NhUaPjPqL+BdhZ6JQBc3A6tI1V7EzmGQZtD2DEzEo1RhuCj3b/e4kcKc9sWGGZfKQ5e+F9eUfKBzvcTC2c2Diu1ClAzdZYV4FosR/RNz3aOrJKN4bpyM9FJu4yLcr19vcuHI+MI27NAgn9LfIag8UY48gZr3LO5GMBtPfQsNFQJ2RyvjeJv+k1+ru+SnK2Y0F8td+8pqz/bQ+lzBb4W3efp+Ae5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uz3nClvC8SMifu/H0Or8nubEZepsNpNQKlIDjRzuP6w=;
 b=oEIo5+kQTLdxGGV8Yz9DJZBLzEOeAiLdSb5cCQl1VAAfFeipxg7GH97uYzyqMnrkB2VoWAzJ1DjN13VzPrr44Xp0/qOmNYrDvSZyl+Verj21N+JkEU1+rZrU6BQNfbZg9JN0QwehhFmMdhDFdzweSaC3/htDw9IT0js0b38tIuFLNrkI9S4WQE282NqE8Zc2oxgVcs0kzrT3nRRDdk+efQG/YFlgBvCTx9+a+bO9NRN7NOuQJBD4UoxBocVAEvP0BhuoIcg4GFrPcCKdyoNfxaeYV5jSR/slINesNp1ZHOnquIeHfXBBAXteiqLg4W+w3/6pcOCvHzJpq0ZTAQIN5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz3nClvC8SMifu/H0Or8nubEZepsNpNQKlIDjRzuP6w=;
 b=Ma+4mIj6SeFMMFmgSpybst3Yw/pIwwu+EIetrc+r4WLv/4cKL4jd3ciC1DuwDDrBtw+QaF+xjwREGQlmjapNVwtAlQ8r9ifeQz4/F7x6FjBaiYQvNgNmHUkJrGBz9qGeqk/aQXQplO9zU4kSSqWmAoAIgRGwgnef5NpLAJhZcfvfkBHPwwlKXzAoP4zPUpi4/ZDzJ7ZoO8auIUi1Lp2LTDJ6Dk5YIs4xlA6XPr2cdlOu2YmqDxrHbASbJPmOSv78yyl+PSF7pYldwz/lGGEsMg88o8WkZQ2mpNYMkBVZeXexUDTOoq+uT02iZ+fw3Op2OcnayrW5jJzkVbI5q0qn8A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0093.namprd12.prod.outlook.com (2603:10b6:301:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 05:56:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4566.014; Fri, 1 Oct 2021
 05:56:04 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 1/5] nvme: add APIs for stopping/starting admin queue
Thread-Topic: [PATCH V2 1/5] nvme: add APIs for stopping/starting admin queue
Thread-Index: AQHXtfqjo6XrkhaLxkCH4OgsGNpS36u9phOA
Date:   Fri, 1 Oct 2021 05:56:04 +0000
Message-ID: <95d25bd6-f632-67cc-657e-5158c6412256@nvidia.com>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
 <20210930125621.1161726-2-ming.lei@redhat.com>
In-Reply-To: <20210930125621.1161726-2-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d3ccaff-a9e5-4128-c288-08d984a027aa
x-ms-traffictypediagnostic: MWHPR1201MB0093:
x-microsoft-antispam-prvs: <MWHPR1201MB0093982DBF2210878296888BA3AB9@MWHPR1201MB0093.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UKFYIB4pMgRdkJUsoVVttiNRbAi+4D5aj/pB56MnIvtpb+njRPG57klCis+1n0J3Z2gDeobRQt7RC2n5liLywsa4t3fj4VfOXs6Ps4vKbvwmp0xWqD7fLwEjMtmegFAYshFx8xZgGNaxUz9bmdt/u2IVIP0KpdiTy6gT1Xjx9ouuk/X1AIsAm+Xt3SWOht1oY2IinofDgM2SBmPJiiirgKS9skJl0i/GVtXB6g3yV8K4pXLc2vvKaTocyF7O8NScy7YH5sxNBQQfNBmSQyUNcAVpFQe7zk/x6x/VYe0Ir5HSnBWOxhTzYmOlE9KSGCtX0Y2Fhm4HNqmYgTCTsxgfX0IemudAVRcCU5Pmj77bvSgANMpdA+zVXzVbxg63sFZUsynFWPh8WPYSe39qSJMWeqN44uoHnF6txKSUsdhFz303dCx5ayHtSc5y1BZU6qGD6Vi1nB1ahEQLIk/SLYf27z/T4nML5VJj6QXnPv3ONlt8GcBC+fE+STas21PwK7hK9DyNqKmJaoWdIKVlTRQOEyPknzMcW3ATd71QKXD5vA6EflODgU3zw7H2TOLaVAcmegF3MnbWMQHnb8qw9FvYtjBKrxs3NInn5+F6MAVGBJ6uMpesUD2l670OnwJZiIx19lj5wm8x6WThxJnXWoIkxbs0WE3IylE9bmPhye4Lm1gnLO6SYuqALWX4kme33uvXq0haBtwkAvY1ymlDVxJbREV1mPbMedhdCF8fZLYyJ4ampqI1sEmdaaozEsFkmmF5Mq5Nu3QFcLzZ9MEIBZC5iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(8936002)(4744005)(6506007)(66946007)(6486002)(110136005)(31686004)(64756008)(66446008)(66556008)(508600001)(66476007)(53546011)(122000001)(38070700005)(6512007)(38100700002)(76116006)(91956017)(316002)(71200400001)(26005)(5660300002)(8676002)(83380400001)(2616005)(186003)(86362001)(31696002)(2906002)(36756003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0Z5RERzc1FyUXRWM1QzTDU1K3JCRVdTbC9aOXg1bmVuRGFqdkM4WVVENDMr?=
 =?utf-8?B?VEUvYitKMTRjVEZkL0VjSytWZ3FTYUU4TUlpMFc2elZnUDFON2RQdENQZGR1?=
 =?utf-8?B?TXhYMTFtM1pOVHBvWWNWUHVpSkJROFFLcTZDK0MxL2hMNmQ5dHdpY3R1UTkz?=
 =?utf-8?B?WHg0WHZvWURpdUkvR09XTTNueFU2TjhqVGIvbGtvYUZnUjI0NnVVYW9tcUpI?=
 =?utf-8?B?eHk2QjJIY1ZlMi80THF0ejN1TU5ZWFlhQ1B1aVI2TlVYYTlWT2pHVitVakZX?=
 =?utf-8?B?Mk9LR3NvSWo0QStIQjNnbGlmNVlCdGtSWmpJby9XaW1CT3pwNTVIdy9qMDQ1?=
 =?utf-8?B?T1BCdFg2MmZhakIzczNoeE9uaUo4R2Q1RWJCVExSYUF5RWNCYTRtV3BBWW1K?=
 =?utf-8?B?aTRjdWQ0bXoxd0JBTVlSNUVjVllpWUVWOVdaY2hQMVVxRU9QMHFSRTd0S3Rn?=
 =?utf-8?B?YTcwc01pWjBOckt0SnByZUhTTXV2bFlvV0U5aEx6ZUxrK2lPeGVHQno2MWl3?=
 =?utf-8?B?ZHRaNFJreERFZ2xDak5TcXh3MHQyRzlFT2lKQUJhUHE1aTJ2S0FKWWhZNlpC?=
 =?utf-8?B?dVlHTit6RFJyZHl6VVh3MFRhWUw0L0puZ203c0VnSlV4UWNFM2xPZUxMZjdE?=
 =?utf-8?B?UVR2eDU3clRkWnpvZXNYM2Z2RUJ3Zk43RXJleEIzazhmalF1UUhhR2kwczFk?=
 =?utf-8?B?VXMwbHVtazl4ZEg5RnhjaURXc25wR0NBTm90RERnMkNtblBZR1BKWWRKRjBX?=
 =?utf-8?B?bXBTQklqRC94c05TaVgrRkxlUGk2bnVXOUZHcFE5dUJxOFV3Z3Q5YkJrV0t1?=
 =?utf-8?B?cVg1QjRpSmZXUUg0WlB2SWoybGx1bEtTK0JjWENhK3lpeWVpdFAwZmoxRytR?=
 =?utf-8?B?NXdacThXVTY2VHNYUytsVEdaOUdPaTRqcStTUy9FUGw1bzdSeEduMHkvSXF2?=
 =?utf-8?B?WjZtNnFGUkFVWCtjNThNamVuZk1XWWRoQlRPZndDUDd4RS9UNlZIWTF6UXkw?=
 =?utf-8?B?djhHZFBpeW1wL0dxN1g0bVhpTjVsWklRdUV4cUcrRmVTT2I4cTI2WjhrT2pi?=
 =?utf-8?B?cUhQWVZYTGg1eE1ud0M4V3ZNYnUwLzkyVi95M1lENVlEcVRDb3UvdmlRdkd4?=
 =?utf-8?B?Qmtkc0ZEQUJncitxUmRIZmV2Z015VUtxcXZ0dm1FTzB1MzBFY0FOYmxnTXFo?=
 =?utf-8?B?VlpyOGk4VGtvMTEybFhOdFJFbisvVmhUcWd5ZDZCZ0NXVVBXU0lSdzlTWTNa?=
 =?utf-8?B?T3FFV2YzeTc2UTkxeEJiOGR2d0JkZkEwbjZMdEFKbUx1S2JocDliRGpxSnNO?=
 =?utf-8?B?NVc1QkRHLzFOVmtHS09lM0J4ZU5RQXBnNVZFTmw5YVh0NW5VUEIzUEtaNGxw?=
 =?utf-8?B?MXJpcFhGb2JXVVpqNGNEbCtkVFNUenczMXdrVGhKVGRHS2ljY0g0LzU1S25u?=
 =?utf-8?B?ZXFJMDRkNjNzdHlHaWlCcld1QUFIMTgxaDlMQTN4REdGUjdpZU5DczNVd1Z4?=
 =?utf-8?B?ZHltSG13QXh5NHdHNVBHQlU1VlFGU09PZk9GVUhmM1VSRmluT2h4MG9iMFZK?=
 =?utf-8?B?ei9zeWV1M3l4cWt4UjFwdWIrNUgzK3dTTG1QZU5OR0F3cXN1cGY1ODRxektz?=
 =?utf-8?B?QVlSZFF0enBuK3U0T1pSa3NKbFpGd0R1UDQrdi9NUkhCVENjZTBUdmpobnd2?=
 =?utf-8?B?OGttZ1JqNUhhSUdPQlFONXFIamVmcFNHRm5temFUR3E5aTk5cGdpV1dNcHdS?=
 =?utf-8?Q?feCVSIqF80PM9L0GWU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <59A45DD0FC552C41B4CECEC74268AAD3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3ccaff-a9e5-4128-c288-08d984a027aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 05:56:04.3422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dkAHJtaoq2LVVc1R8Ra0qQO0lHBWR+5l/239JhROx52kTASbCSBG2QpEKZmwquFVLTg1da5mlhklvE1C19ffKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0093
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOS8zMC8yMDIxIDU6NTYgQU0sIE1pbmcgTGVpIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbDog
VXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IEFkZCB0
d28gQVBJcyBmb3Igc3RvcHBpbmcgYW5kIHN0YXJ0aW5nIGFkbWluIHF1ZXVlLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTWluZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+DQoNCg0KdGhpcyBwYXRj
aCBsb29rcyBnb29kIHRvIG1lLCBidXQgZnJvbSB0aGUgZmVlZGJhY2sgSSd2ZSByZWNlaXZlZCBp
biBwYXN0IA0Kd2UgbmVlZCB0byBhZGQgdGhlIG5ldyBmdW5jdGlvbnMgaW4gdGhlIHBhdGNoIHdo
ZXJlIHRoZXkgYXJlIGFjdHVhbGx5IA0KdXNlZCB0aGFuIGFkZGluZyBpdCBpbiBhIHNlcGFyYXRl
IHBhdGNoLg0KDQoNCg==
