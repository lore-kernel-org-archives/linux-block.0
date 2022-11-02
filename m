Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB014C4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 01:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiKBBVE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 21:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBBVD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 21:21:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8E2BD2
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 18:21:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0OntqvL8hfQ7f+XDD84/+aLeq9m7kX3hZo0d1tfWSpowLwRbcNnu4OdG4w3/CjiRjKOyj2Jc1e7B/m4y2mDFAmi2KZBjDcWf7ibE6wEImXJWxvz43JodYmFfb4DzQyC0Hz4BcRcBew6r5BHyhvEU8PtiG5g6n/0iYTPISaDGRLyzv1OtsGH+SHi8IQ6XzaWC6PMZGskPnbeIrOBX9pM7iCTUV5MjObitd4Kx7CUJajsYacyCa3UIfj2Mk3C1uhFyQaIqwG896WNO0f6AC9IA1BfkW1QVHar6hjkEhTfb93oQnNvetZX/89rMMqkg3Zroj0WLNBvkl6yv6b9P0HE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdQ1gAglA/n8s0GGlgPlOUybtKDg6J2/AkdgAR4EBUs=;
 b=cNMA+YD0cpmv8Ot04IUXSY1lghbSQDeCx2tWOcNJKhaPgkjmQmGXIo3Il7HplW6n6b8vZaez5bOAIwqkPXjOUnFCemIOMz3Ga4Kq6J9r8ebWrKcahIMch/gtu3U23U3MidcPIcYGmWYwpiNzgXnKVoHGYzPylW9i4q85oSo3yUeOxhJSCxQY8yHQXRDRza+Pm7AtV9kpuGXIzxhc47lzS6CyiipnFNxrU/d3R6OVhW0c8Id5m+MrW1pBeQlKasTTldeLQuQsChWdfGVCReIoucUHf8l+wQwXkuvInmiTCVbR3qbm4u7Zrp3zftssm1hhvNYE1SDvNh/N3uoY32jBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdQ1gAglA/n8s0GGlgPlOUybtKDg6J2/AkdgAR4EBUs=;
 b=KidAfOhdrvb+RAk4XelcpRyeQYc+wTB97Hj7weo9+aNMdS2iZqAF2eqOJhnFx7ZXuewMqfqvXHEKx8dJE+GrRKQLoevhb4i4htu9XQD8u6ibj8JpMOAKDQhfeBpoc39GZw1s85U6DBFAN8gp+pb1urDQ1qOJhqF2I1q5pa9u4Fw+0RexR8CYID1maIj9NjU07GHFEqhNo9xTZEik1LAaQMNHNckimltpbPLqpq2R864+R8tL4y2rTfgutyEk7IuF3Dxa15cuCxY0kay5K54jslNzkUMIEm49owzNHq/4gaYBkngT0s4Y83JXtl9FsUOduGngcWpEfJAFyG5ZSE4huA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 01:21:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 01:21:01 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 04/14] nvme: remove the NVME_NS_DEAD check in
 nvme_remove_invalid_namespaces
Thread-Topic: [PATCH 04/14] nvme: remove the NVME_NS_DEAD check in
 nvme_remove_invalid_namespaces
Thread-Index: AQHY7gMCjcof1bRoMkqxEqVs9y0fsq4q1raA
Date:   Wed, 2 Nov 2022 01:21:01 +0000
Message-ID: <54e7f151-c3db-58ef-88d9-dbb9592ef38c@nvidia.com>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-5-hch@lst.de>
In-Reply-To: <20221101150050.3510-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5264:EE_
x-ms-office365-filtering-correlation-id: d76692c1-3c4c-426d-0bc9-08dabc708121
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E8XH8/rqdRL42c0bo+MwU8R8wzoGpIuCEaeMzFRPkmf5XcAcprkrH0ShlebAkhjjvnaX4TXA/DtLyYJLE5B/UXc1OT94WSvz2WlkXRayWw/hFK9rKatlZdia2POZFwLG5Pop5k0a9MOqxzQjcGigMjfGoMVg+qm84IApMvSoNNwmacUPWJ7h/6+HXPQZPbRbe+HMeXPhP8KPTSgA9/DRZ6dES6pnscDrQi32jYp0n27Lca+sBfXjE2MGdKNZRAbmy+g1FpCJdiDUjoAtRNK3WUA07Uj8YIcA5CGRjCekLvX5zn259IR2W3lANngXXeNMV87WApiBcCeHaGNnl1ZQArZAYZNpI4l1lD9ENdHJl3TrC4PjjuzVwwtsU4DbdFCCtVOzwDoPkqG6FFMc2Wr8feDzOWB63xTBbetrDG4Tj8Vh1o5b9fsEfIGlfCiQGikdsmCfmFZXaZ8hU0nGxrSoK4Xt3xGxL+L6YPENm5zAgNBzB6koaKa0fetDx8BqqXZ+MwRv+m2hbVBD+zvilGdiC66JM/TkQT/5QkuOKYM7pa5zzvnw8IEagFh4x82K96Qqd3U1B0mbeC0ZKrM2y4vvQNp0hhyxOFnOTHoZcoQbmj2py/CTB90r7/5k2NCIkaXnKWxKyeHoHqIepX03LXiyqUYR68wdHCt8Q9Xu/2yMeyhOr8iDGqoO0XUyeW7UPjzI3zoaRG5iRKQcXo8lDUsIeXu6A9dx9zsAA0WR+yvjDrdQdR5khUI1dbrqPy9WQIYDuFp1LjvVYezcc8TFbCQqCFaZs+K6sdUNbGdXv+fbGnP0w+myJR9vocww1xDV3gfvnNOVjd0Cm+7TdsaIIo8/0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(76116006)(66946007)(91956017)(110136005)(316002)(36756003)(54906003)(66446008)(66556008)(2906002)(186003)(122000001)(83380400001)(6512007)(41300700001)(8936002)(53546011)(31696002)(64756008)(6506007)(4326008)(38100700002)(86362001)(8676002)(2616005)(5660300002)(66476007)(38070700005)(4744005)(6486002)(31686004)(478600001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3cwbUpFamJtN3JwWlF3OThwcjhQaHNISzZ0V1BYVWJmbjdXOUFtWnc0cmdv?=
 =?utf-8?B?LzZSQWxjTEFjNzVjdStjUVZINkk4NnkwUXNHblpFWG1nQmRYa2NjaVNtU3Jx?=
 =?utf-8?B?MU00cUl6Q1JTU3NVRlV3a0xXT093enlNQ21IYTJCTDAvazM2cXltVmw2T3Rl?=
 =?utf-8?B?cnBWV1pGU01uTUNhWllUZ29DQXpXQVI0bHdjbit2eEIwTGVsYWg1YTRJQmRI?=
 =?utf-8?B?Qm15Tm9qSDRKWktWSk1SS3lzVzdvMC9RbGR0T0M2WkpEbGl2S0lJWElXWUtR?=
 =?utf-8?B?RFVtSzB4b0hsbFFRTWM1TXhTOHJ6S1lxTkhyMU4xc3oyeHNDcEYvN2RTeE0x?=
 =?utf-8?B?akZYS090Z0tFMzk3a3BPUXpaY2VuSVlNbHJiR3BXeHBZYktiUXg3NEFjN0Fs?=
 =?utf-8?B?M3d4b0pQTVZFRjk4b2lEK0ZmNk14WVlHUUltdVVIdVVhUEVDYmREd3ByajBV?=
 =?utf-8?B?SzNDdXFBQVllb1M2clpHV3VOVzlid1F2QXNTVmdjSEIzWVYzL2tMcmNTMytL?=
 =?utf-8?B?ZE5FQ2NlSTdRMUFxVTFBYkhRWURienJDQ29jTnFndlkrTHZkazNTQk5DaXNo?=
 =?utf-8?B?cVpRb0xrbTRPTE5hRXduM1UvMmZaVnJ2VWZWOXJ1RUR0a1g3bzhQODZzaDN4?=
 =?utf-8?B?ektTRE5VaU5DMTQxdWpsQUNIaVVLZm91Q3ZiRDd5TndYUXJ0V2s0ejZRV1lV?=
 =?utf-8?B?Y01NZ1h2UnkyeG5NMXZvTXdHbzhaK1JNb05PdUJ0Q3RrckZkRjlIYURjcm94?=
 =?utf-8?B?RHp2YlVWYSs2ZEYybXdmNXlkZk5QVjh0Yjk2N3U2RkRZQTRIRDh4NmNjbFJj?=
 =?utf-8?B?REYvblNPNTA4eGhMdzJPQklsUGdKeC84MFczMFM4cGJ6dmlEQWtiMGVMN0p3?=
 =?utf-8?B?V0J0RmhTSDVwV050eDJseXI3eVIzaFNqUnRVS2NYeThHT3p1UjJmSy9qSTZy?=
 =?utf-8?B?SjNJNTFMSlFJYkdoYUd2c1NObWdqV0FPSDJYaUQxS3pXVGh3UTNUQkhDKzZa?=
 =?utf-8?B?czlkbHFGZ284NEJxZ0JLaU42NkhXMEE2YitxQXcwWEdjV1J4eDlKN2lZaE5l?=
 =?utf-8?B?bDJCK0lHbnZhZkgxNDR3NHFpTEJEVCtDNXFXck9WcG9uZ2Z0cHEwUEZqME9h?=
 =?utf-8?B?SEdId1lmczlhSnIyaWI3Q3NWaUc4SDRuQkRoMjlXZnJ3NzA4cFNPOFY2TWQz?=
 =?utf-8?B?S0JHcFI3Wjl3eWFnS0g2QnJXaGVhTnE1SEwxRTUzaXFadDF4enZCd1ZiTFdJ?=
 =?utf-8?B?a2NlSDhyZncwSmFHL2drKzBoQ3M1VG42MTFDUERnQTFtLzEzQlZrdCttVStR?=
 =?utf-8?B?eU8rOWlyVG4xNnZHVHFBeG1Id0lpWk9mTlRaOFZ3NHNyekVuak9KR3hLWUZE?=
 =?utf-8?B?K1BUa3VFWkZEQnBPWlhaRzViSldnL2RqNEJHUlRqSStiRUp2a1kwa3dFRU1R?=
 =?utf-8?B?ZWk3cGlxVGtTOVdOQVdEbzV6S2xBQnRtUVJwbStMZUR3dGovVEtXSE5ZNHZU?=
 =?utf-8?B?eGY5TDB6YitzU2hXSzR0SjhiTXEyT21kNVo1VW1ReGd4dFVBVWRuT1cwVVJt?=
 =?utf-8?B?SjRUZnhSZTdyMUNVbndqTkM3RkFIT3ZCakhXbXVEbmZ5K3VlZ3dhQVcrcTI1?=
 =?utf-8?B?aXhZSnVJSXhuR0dzNHlMN3pIai9IcFZ6VWV1dWNrY0NQSVAzTkd0WkdnY0Uy?=
 =?utf-8?B?OElqM1UyRkRsL1NBWFAyVStYNFU2QVlranlBQkRHTVE5RlNuZSsrcjJNbHFp?=
 =?utf-8?B?dW1XdC9TYUkyYVFCZFR5TklPbUlCMEhXODEwSzZMakFCbkNhRkk2aGNLMStG?=
 =?utf-8?B?ZkZoSjZ4SmFldWZoNnRLWjBBNkZMclN6eGt5RFd1aGJ2a3grbEdIbmJUeVF2?=
 =?utf-8?B?SWZscXFYSGRST1NGUU1QOXBKTVk4SUV4cmx2T0RFMUZnN3VZbXM0d1FHVE1r?=
 =?utf-8?B?WENhbmRpbjRxMVJmcjUwaDBjRGo1dGlJTHZDR2ZLckhSbDVIZ1FpcERuR01u?=
 =?utf-8?B?My9kdFZGM29oUkFUSTdxcHZ5TXRZazNiTndRNGNlK3dtV2xndXhLZHp6WktN?=
 =?utf-8?B?TFlQSmhkOXB0Ri9tOFhOR0twbndZcXZQbnZNSFB4cGJWL1ZMcHYvRjlPUi9a?=
 =?utf-8?B?b2NVaVJoRWR5TzAzVHRaN2RaZ2w1ZDIwWEJvUnVGUnpYU1VPQnlFbzRCbE5V?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6029AD073F9917458DC55C4490371565@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76692c1-3c4c-426d-0bc9-08dabc708121
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 01:21:01.4507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6H/QQB9qCSO0B8u5GWDYONQNJWz4blkwiwcQzXNeMbQd9rIC3IBxMg4V1IfBWNyvblvmI7XdxA/pmnNE9ShGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMS8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZSBOVk1FX05T
X0RFQUQgY2hlY2sgb25seSBtYWRlIHNlbnNlIHdoZW4gd2UgcmV2YWxpZGF0ZWQgbmFtZXNwYWNl
cw0KPiBpbiBudm1lX3Bhc3N0aHJvdWdoX2VuZCBmb3IgY29tbWFuZHMgdGhhdCBhZmZlY3RlZCB0
aGUgbmFtZXNwYWNlIGludmVudG9yeS4NCj4gVGhlc2UgZGF5cyBOVk1FX05TX0RFQUQgaXMgb25s
eSBzZXQgZHVyaW5nIHJlc2V0IG9yIHdoZW4gdGVhcmluZyBkb3duDQo+IG5hbWVzcGFjZXMsIGFu
ZCB3ZSBhbHdheXMgcmVtb3ZlIGFsbCBuYW1lc3BhY2VzIHJpZ2h0IGFmdGVyIHRoYXQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gUmV2aWV3
ZWQtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+IC0tLQ0KDQpMb29rcyBn
b29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cg0KLWNrDQoNCg0KDQo=
