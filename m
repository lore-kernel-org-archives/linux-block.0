Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D0BECAAD8
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 05:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIUFAb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 01:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIUFA3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 01:00:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024D97CB76
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 22:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdsC7Xm5BskfuEUk+qrw0HajdRW43Zj42eLGHcbAILecw45Y0xGlpqDfUPDSvbvrP+JqihE26pMxLvX5pT2UuYTo3TRUkhsvWWoJqqdnpO7vXZRMBCnudLWSpON06/bmFSENWTqAW/xj2DByRfSEOFXwhQMCpGxn0UHPsbqfydi3lWKdelGaUENQFnqORTQ6FUVxNR5z0jI0w7mWuIlIi+szUN4TTb2haLzLYiSFobc3vHhKGjQh0Z9O2mANQm86WtEy8OYt5f6cXjDXl9B3eo560PHBx5BUo4uGrGL8ktkv4Sm/iUyY1gOnBwdsrEl2bAA94M6MSDNvkOxiUVb71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9fK8/sqfK2UQG3PZcUuncEsWYMWsQBf3sFfTHmRaIs=;
 b=GjPRNwHupI9XZ7XiBGOQXHG99bWu5CzI0dwT6DlGY4ORwLaeI70+QWj7wVevWHCZ1HavgXjceokSp0tTnmTYK+vYO7620xsX2ueiGGsrnD38rnATwvwiAvIwQVx6oRrSTp+hYbOfY1vCh3q8JQqs0JOHTxPuBTJzxsPItx/z5JgMo0xjSMEDCuokw8oerHQkJIhqSmfa14AT9Nq5MviOITj1JkssRoGIyz9B9JEJcjrbmiIoDzIqWA4dauo099z4m0IQjaJBqDOtqASDYeDEdEOpW/diWIcdORUITqWe4NWAKEVRLh+cCWwgoJC8X/fvXrpLCalqbykXXXEYDGkvBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9fK8/sqfK2UQG3PZcUuncEsWYMWsQBf3sFfTHmRaIs=;
 b=VOkyQLeo4PZHhGWLx7+w58f42QC1sS1gFiigAfDbgruDW9FuYQpYibsWDXIBHzDzU/AkxbDkcd20MXO+Xlx/z0wZVRPhrKGnqxvmnFDxwP7B3MU6TXMKAhml5AMZWjGFNAVHJRek6iDozySeQtPctuxGpadDlf0PAZSKe9b0spbpAiarmBg5D4SHnJ69v8MPiaHPp2WOo6zukAIxwf0PdVMKOa0+6geUXRZWEsnwjWGG+sbn7EmD1nLTBLWzYTyw002gTx33w1kn/WiePCFLlGQieR/+xU8/II0U2uZjxGvGmXXvq2U7jBZ/xOUbK4i0EYlB+bi+yJHVQabONHiouQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Wed, 21 Sep
 2022 05:00:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 05:00:27 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH v2 1/4] brd: make brd_insert_page return bool
Thread-Topic: [PATCH v2 1/4] brd: make brd_insert_page return bool
Thread-Index: AQHYzRoBcQF0rUJmnkWwxj9tGPOk0a3pU+sA
Date:   Wed, 21 Sep 2022 05:00:27 +0000
Message-ID: <bcfc8027-11fe-a3e5-f0f5-2ddf1f0c03bb@nvidia.com>
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2209201352580.26058@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2209201352580.26058@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB7336:EE_
x-ms-office365-filtering-correlation-id: e455fea1-5ccb-4b56-07c3-08da9b8e3318
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /I/SN5gnGvjitFhjeqqZADXMnviK8WKUUgAvZYZRBTEowy4gNMwcRQsHGs2i+OTcvK5dnEsOSJDNd+qUrQvYauK/vaZ9j0LfiqTAsoGZhMTahomdMXAiLTiAIqP7BL7extMd0qEY45xnDoF+3np1+L+tNp5NNi4bDIDmPw6GYJuwNAfonhzDGsRzMN5NKZs7bXIrg3o+WOEESjbwZQECVVpDFp6FYI9eK7hd9l293IklKNkW6CQpqHCgIGjnGMDRaZ5s2xSYZj9UkbO/J1dLLyfteCSl2P98Tbn67avVBue+CWBEAuiwynwBIjKfM6AQcy7GGBhd07VfUonJGbV9qNWxMoLnfK5/Vkvf1079l7IFj3C/XHrT2T9XeXKriIKF3Mid8M0kSYePZaeIaUsdcq5NsF9delcLQWq2BkynpF4oQ0DOg7lcvtZAeyAT+F3d4rMH7mH4os/SJL1CBGEQktzn4jvebmYJSbx7YLReKUhOkTrJB8uIZa1t8ZlIQBtd0+wSz/JxhZ++1YNQLxMvoyZJLO0R5/L5rmI94XUXmY5TzuRkRUzCXRbaepbLMYnZB9zhdVjeJj7RdekNQ01/wM/wUPdcbbKOZ85YY3bY2owtRFzbLOpU1o0f1dV6DIGIDMfYB8ab7FXq3Qp9H42x8bz281D/Jtseu26JgHZ5Y4HGetQNtYMNd+DF/8hAs9V5fG6gSO1BLqTNco3V7CyKxY0ddY/TsKW3zRra+DdjFkPFbYaYOSLv5stU1xUU9IGmP8zUaX45JJKau0TtKePCIunVE6j9l67N+5t6Vd7+x6q0kDmQ+vw432Id/qpoilm2cbSH1Nc/fEHqoD1DxnSUmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(86362001)(38070700005)(31696002)(122000001)(5660300002)(4326008)(4744005)(76116006)(64756008)(110136005)(66476007)(66556008)(66446008)(8676002)(316002)(6486002)(54906003)(41300700001)(2906002)(478600001)(186003)(2616005)(6512007)(6506007)(91956017)(38100700002)(66946007)(71200400001)(53546011)(31686004)(8936002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUNsRVB6QjFmTm9WNDZucDIzelllTUxGandncm1qZzRZdWlMVnRLWHowbHRS?=
 =?utf-8?B?UGdsdzc0TTdwQ09ERlJ3WE0zT014WXpuNHgrRzNnYUp3SWtyRWxJSTd5cGR6?=
 =?utf-8?B?WldmcVEwUlZHcmVodmYrOGpsTkJUcDd2K1JxM2hqd2tMQUZBbHBHNDlrOHFP?=
 =?utf-8?B?V2FTUzNYcWpCMnBCRVlkeVBmY3phR1UwNEdSMjhTOC9GK1VjbENMK0llbUI1?=
 =?utf-8?B?b1VzT2VWQXRkcEZINE5VTTk5b3lnM0tEMThjeHJWL0NueERRMVFTeUwyQlJi?=
 =?utf-8?B?UndGUWNrNGF1Z29iTmhQK01RcGl0a0JkQUJFYlo2UVJyTk51c0oyRjhUWk1V?=
 =?utf-8?B?WXVOcDhvamt2emhTNzlSNGdWYTNwTnpMcW9vdG9BM0ErdmYzM2dPZWZ5cWpI?=
 =?utf-8?B?UTFBdlVzemFQYWhYalBkd1ZwRkVhK3RHZlhDN3JmQnJzVnRnSHB0SlBDcGxa?=
 =?utf-8?B?RU5lc2NTZlNCWjYwYmlqdi8weHVSMlhXaXMxVGpVWVBXVlNYcU03YjVDQ0xH?=
 =?utf-8?B?RlVlU3BEWWxVcmZVNVM1TUZMK3UvR3AzcVNvUTh6MWdnNjRJSG5wd2dBdmpD?=
 =?utf-8?B?dXdmTEkwOFVQSm9IR1RKclpCRGJzZkpiZHpXTnJNOTZhcDFtNzk3R1YrQUVL?=
 =?utf-8?B?WEwzRUpCV3NhNWVWdFVxZVAwVDVFS2FSeStLM1dZT1M3ZGN4OTRacHhGY1pG?=
 =?utf-8?B?emRMMkdIQlZ0V1VYalRxMlc0MzAyeS9Ma25qeDlwdi9oS0ZuQWN5a3VqQS8z?=
 =?utf-8?B?WlhzZGZ5TXJaN0FTTTlxYlhRSHRLNEo4ZGFoMzkzTHFCVmtlbnFXdHdnUXU4?=
 =?utf-8?B?TDdYU1JVMitMZjNUTXhNYThvaDQ1YU9VZ0k1RzJRZFJCbnp1SFFQZTZFM0NF?=
 =?utf-8?B?UFdPL2NHQkhsY2VXcE0rZUx4blZMWjBBNEZlS0EwWUlyS0hSVjBvZ2dMTnR2?=
 =?utf-8?B?MDY3T3lISStFUndxanJXRWY2TE11V3F1TENtcklZUklDMkNMckFhaWtkSmYw?=
 =?utf-8?B?emhzdklXc1JpV3cyY0dVVmtTdXROSHlKOFR0ZklpSDU5S1VDTXpYQUFteUdB?=
 =?utf-8?B?VWxPb2ZKcTYrc0gvU1Z6cHcrSkZsSmp3UHlQeHR5eFdycjZmUlJBUEV4OGY3?=
 =?utf-8?B?TC9rZ1FNaGJ1UkxnUXJ4MWhGUzdMbFBZeHZ6MHNkN0p6ZDFsTW0wNlZxaHdL?=
 =?utf-8?B?Y0kxUWNKd0krMVdJeHVJdFNLY1pyS0xIMnRKbEpXRDVsZENHa2ZDTW5ZazFr?=
 =?utf-8?B?bWNsK3ErNTVteWUraDFDQVBoV3QzMzNUeUhURGZZbWZQeUswRlBFclZiRVVZ?=
 =?utf-8?B?Y3VXajJaVHVlVDJ4RlBRT0dSTlp6QXdydktsSG5hYWg3bmI1MloySlY4QnNk?=
 =?utf-8?B?aGZKbysrRDRaMVNQRC8yK1ZuRUg5Mzg0MFBTeVRYWWh0K2E5ck9PMEZ0c3B4?=
 =?utf-8?B?N3VndEFTeWVwUnVRaUd6czExcy81WklYNzRocWRBMFNkeVY1VDlUVkFOeUIy?=
 =?utf-8?B?dEVtU3lWU0VXU3dnWTMydGdyd1NVdFp0a2ltZmFXblRqb2o1SmdHNDBaMGxs?=
 =?utf-8?B?aVF5TkdROVMzcUxZcE52UFJwYW1yM09CMFlGTUM4eHVpc3UwQUZFMXkvZEFN?=
 =?utf-8?B?U2lQVlo0QVdSSU5lcldwSVJkUUh1YTRBWVRqOHc2cU8wMVJkVW5yRkM2VElu?=
 =?utf-8?B?OGthRHBPK3FtcDJ0ODhpN1d0Z3oyOCtqdzlGaVdLU1MyYkhtdTgyQmtTdUJL?=
 =?utf-8?B?dGdlVEM3L3dENW92MUVnU25hRHVsWVVyQjlmM3dPbWtSQ29JSTJSWGdBTTFa?=
 =?utf-8?B?QXhSV21pVUw4cldESnhCelFyR3BxY0d2b2pGNWxwOWNEZUgxcHVKbUsvUUg1?=
 =?utf-8?B?aDNxbFM2cGh0b24rRnU1bEJ0MktETlQ1d01YaVFCQVRiMktpemhpLzB6TWR3?=
 =?utf-8?B?RVdtQ2cvMzJOREdtTWYzNUswWG4xSzVUSjhUU21adEhBdmVoWjJlWmwvL3VO?=
 =?utf-8?B?U2RZSUZBSnNtSmIzbTUvVXROY1hqL0UvejF1WFZxWEhIbnNEL1BpTE9MTnR2?=
 =?utf-8?B?bUxyR0ZrZEZvUWJiZnFlNmRqcUl0ellvWTV1enBpYnVpdmtVWjI2NCs5eEJB?=
 =?utf-8?B?K0ZXb2dvT2hlTXFTbHVKc2o4Nlova3djYmU1SkdybGRadlV0cVg2aDZ3WU9x?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7F8697709A97F47BE8FC75BD42F90BB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e455fea1-5ccb-4b56-07c3-08da9b8e3318
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 05:00:27.0595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dn/AltCF5vPZZ2INR6+1N9lK4Jx2eQ4ujvcSNwPEIQVBneThlyfMf4pqHnmw7NhU+Ck2iTqInAKSPVzL15iBuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOS8yMC8yMiAxMDo1MywgTWlrdWxhcyBQYXRvY2thIHdyb3RlOg0KPiBicmRfaW5zZXJ0X3Bh
Z2UgcmV0dXJucyBhIHBvaW50ZXIgdG8gc3RydWN0IHBhZ2UsIGhvd2V2ZXIgdGhlIHBvaW50ZXIg
aXMNCj4gbmV2ZXIgdXNlZCAoaXQgaXMgb25seSBjb21wYXJlZCBhZ2FpbnN0IE5VTEwpLCBzbyB0
byBjbGVhbi11cCB0aGUgY29kZSwgd2UNCj4gbWFrZSBpdCByZXR1cm4gYm9vbC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IE1pa3VsYXMgUGF0b2NrYSA8bXBhdG9ja2FAcmVkaGF0LmNvbT4NCj4gUmV2
aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiANCj4gLS0tDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQo=
