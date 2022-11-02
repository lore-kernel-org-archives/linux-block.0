Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FC3C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 05:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiKBFtt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 01:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiKBFto (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 01:49:44 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEAA6386
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 22:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VD74k6cq62nvjo5DH/rqbYn2FxlXhtk+zB2WHnN6s3Jd+PRHNdMRN9vrpDS6uiz9isRvE67gK9SSTHpGAGAfPILrHj1wS7cKgoAhq3N0fvXiMTVv7wU8/W8Q4gdoklEDIfy5cZwo8YwqoFVWND6B/fJvCpXadRDo2WK76jTmVO0p+A3lwqrSHGhqW+uPSkdK0bYAx2xy4WU4eEP86tNkpGwdT2jVBFuMTCPB0nBhJ0vf8pDuzurtCkRL02RnZWTxYqLnmv8dEUBzvJJ2aZoBxrNzdqwk9lREEX6fzeeytuwRb3XuxGySlmK5KBhs3uKMOnWL5/i3DO6LDGdztb2ZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K4bTAndK+DrV9cNnsQtuhXCo0+wTKz5jCLobWyLXxc=;
 b=j1V+cFvtQdaNdgiYBG6RL01yI43bfBvtrMq5qSk8tpFYjaA9HbYL1my3SrNdTBZlJhbawubuXzoK8ntxSmw/pLqo7W+LktcIWSaHOg+fxB21p9QlYCoLE4Wtq4+8EdUpVfGH1nkpmSZKZqCUA8CUr4AOc7Jh+nGr8Y90yOIRjqOX/AXVdYO5dHrMlETshMegbbtVErJqqa+qMOP83W24dmEH4kFb1rpk8TXrXOp7y6KidSzDnpYvj5uesjW4hXyW6fIhTnGITMW+KQZDHTGfpr3F7J4vjtJLZz41G7Zq765alGJYRXXALy+LKo/YaMFGU5yB2cbgwWtLrYckd0Do3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K4bTAndK+DrV9cNnsQtuhXCo0+wTKz5jCLobWyLXxc=;
 b=GxfCKXIVE6Jd4THvCdenbZ2tG2Mco/m9R3xZ2v3Rod5qi4cgAYf6jfyASOw4Z0Rw5y/j4KZ++r7ydbQG9zjvVeiOS3bDfYtp96O8foBofQzI2f5S//Vwjy+pNxtWjcjwbby8Xg6fsDpeREit3lw9FeBcXI1XKPV9Otq8BafduA7BM+2Rt6/i24RNa4LCDOkMjED37HywXXwUpj0vha495yc79fqp9jhlzi4SR6P7Jlgpkw78QiQbGBQuICDKsz4XcQyIRFkVKUJpm8Snxv/8iyxR3JFGd9YhuDcUJeyc5uBva0hOuBJrIyZRMiNPQYi6tpYuEBwQkAD1/g/7CKn4dg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 05:49:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 05:49:39 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 11/14] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Thread-Topic: [PATCH 11/14] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Thread-Index: AQHY7gMCRJk1IrpftEan8q2JyeghOq4rIcMA
Date:   Wed, 2 Nov 2022 05:49:38 +0000
Message-ID: <116fae0b-5764-5e9f-a942-21108e101b0c@nvidia.com>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-12-hch@lst.de>
In-Reply-To: <20221101150050.3510-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB6239:EE_
x-ms-office365-filtering-correlation-id: 6548bcee-c38c-4a1c-fb31-08dabc9607dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EWVNg4urmQIDfFvQGWJf0ZHJdTMAW3rByDbdJg3dbLs69Af/DQimszqGe6EZ5FW+c2cy8nliT4mRu2bpTYGzzlleJZkuYfwGotSWZlkGIerxgk7Wp0wpDAXrQFbyv//zCF/yAhChk+qMzJABioXbh4YQSUFtLN9DDnkIUUz2UAUjpM4SY2srnh8VyRr56npToS/3pm/RJ/gvF2pMFBhwayl9Xvi7C+7V26Phr0OSMLEf18k2f7aGAqn5ocWAvZiWDcZy7RWvPtsYVGOg8YDrHIZo4ezU5KHvWz3dZlVNwyGNdVmVsAfYw6lLtm0u7NSPq9NevSMVfwkWnQDy9K89818+p9LAE/JDFUsitZVq6zRWWzUKLI18Msn3WL90CxUCdHVKmWJg4dNbnP1RdymmidE6KOlxzq3SQkqMMokUFtUmJr4L1gdUFL77FhIB7NdS0IUhT5wGo17GuMC+1IqJIvWcIptOJIOoYJLoUJspsfLxid+MYg2WaOg8sY2D9J98rXBQrJONTpCuJyFx61DlrozVuTNo4/ae4bTnKYgF+W7HRYZ12de3IAVD6L/KNE4sUEH6Qy6D1ZugajOWvJU6plPy7ySy43QIaSQFoxqV7ixyHfFL9PTxbh30a2UygWfYrBDDmXq1ABtXDhMt1j3Ev+PXDtSVEkQup8Ze6u+DU/tV7XPWzMo4J1K0Zc9iYfOWwt1H2bjGsiZKjVmHUHgsnqY/BcqxHr9Kgq/f5V3maryI2+VBFcs96ODTyBvMyMPlpFPQhx+ZxZKyuk7lMgcydcBaqxxk9qd+gvHgfRrNhTHw+pnc5rdwoZUc8RXTMyokVKzFr+JJFmuHkCmSjEIY7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199015)(316002)(110136005)(91956017)(76116006)(53546011)(31686004)(8936002)(54906003)(41300700001)(4326008)(8676002)(64756008)(6506007)(66476007)(66556008)(6512007)(66946007)(71200400001)(66446008)(6486002)(2906002)(186003)(5660300002)(478600001)(4744005)(2616005)(86362001)(36756003)(31696002)(38070700005)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUlNSnM0enZJY1NzSy9SRkxicU5oKzlqUGI0T1EvOERudnpCcm8zY21YcGs4?=
 =?utf-8?B?ZjVXVFR4SnZFVVIyTUovKzVDZ3BScHJOc0Nob3BGMFhZdk9iSTNSbkhCcHdO?=
 =?utf-8?B?THkyekpmNGdEeWpvTHNMS1FvOWQvb085RW1vK2l0WGw5bFZVUklaT3lLWGFj?=
 =?utf-8?B?RHlYRnI4MDUvVjFxRVlMVDB2eTRGbU5ZdVpIUnVpV3N3UGx0Y2piWHRXYlBJ?=
 =?utf-8?B?S0RCa0NYN2czMjBlb05yUG9VVnFMZ25QazZHdXpRa2Y2cnBGREtBM2FTM3pP?=
 =?utf-8?B?UEtYeTJuSC9Ud1RLRHlQT3BZeDhSZWxMVlBickw2RzJybkhyeno2aDFRSWNG?=
 =?utf-8?B?a3YvZkpWUVd2NGgyS1p0SkJ5ZFdGU2FYVE9oME5xNVdpVDBwbXlycDF4RFo5?=
 =?utf-8?B?a3ZWN3NTY29sWUEwNGlQbnNLOXZFb2xSU2FaekQzOWlpbHY4U3BVa3hlcUlO?=
 =?utf-8?B?dllnSWtYb2l3bVJUYmtib0lBSGpnMC9WM05Ga3JiRVZXRmxmWlNqZk1ZYXBB?=
 =?utf-8?B?M3NBV1BXOGtsaUJVR01DMmxuS1QrK05MZlovM2dNS3B2RkJoYkgvdW5EZzlL?=
 =?utf-8?B?ai9rRkJGbG9heEVLR0pCalNxVmFEczU1elpoaytqWGhjWi9WSjJxWVJoc0xt?=
 =?utf-8?B?TGRHdnlDUXd4Q0pudFk4cFdPVWZNNWltL0pJQ25FWkViVWxJUGdueDRKRk00?=
 =?utf-8?B?SldNOHQxaGM5NzZEaVNoNEM0WENIdWlWSXp6WE9qRVg2clBWYysySUJxZk9p?=
 =?utf-8?B?ZnpxVStQRTBZZHN3ajlHUlRna0RYb2h5c1lwcWV5T3NuZ0llNGQrcW5CL05t?=
 =?utf-8?B?UTkxNkVnTG4xRjVkNy9VMWZWczBKbFdSMUFnbmRibmlQYWtLd25wdDE5NlRo?=
 =?utf-8?B?KzlhV0cxYVI1a2hPc1E2NE5USi9EWk5pVGFaZlJnNzJLWTRPSFo4dlRWMW9n?=
 =?utf-8?B?M1YvV1lHUUI0dk1VRHhwdVQvSitDcTg3VkpmR1J3em00cm8yMHpTR3VVVlpW?=
 =?utf-8?B?VUVjcUJ0cndybnY4UW1uYURsRU1lcURqK2dwU3JaUFIyUFRqRjVnOXp3K1di?=
 =?utf-8?B?cWY0TFFVNnZTdCsyYnFvZzMvRU5NdkNicmFHaHpwWXIraEV0bDJrTXB0U1J6?=
 =?utf-8?B?N1hPUkhKRUJQbmgyRGlkczM1blhCWDNNWC9tbmlFMkFabjhyZEgwTVkycUp0?=
 =?utf-8?B?V0k4eHFwckpZR1NpNFg4cCtvSzhocGtDemxNL2VrK2s0NUsrVWprVXV2Z1No?=
 =?utf-8?B?dGNUNFJVOVVVb1FicXk0dlBsWVd4amM3UlN6T2YrMUZGd0tHZlZ5dy9EUFdS?=
 =?utf-8?B?dWhzeUFXV3VrakducUZlWVhScFZQSmoxdCt2cHcrZWpTbU12cFhBSnBsYmpY?=
 =?utf-8?B?cW0zRHFqcXZWMUhkZS9Hb09EaHl3bkx3VnpudTdFaWFLdDJXZWEvNW0yN3Bh?=
 =?utf-8?B?V0ZHVFFtVWJzSXVFMlZwckU3TkFoVDlPcjkzU0RQbS91amVnMnUrQWVQam1X?=
 =?utf-8?B?dHlkcklkSmRmaldpN1pWVVRLUjlyV2kwWmZObXpQZGh4T1JvbGJhN2hyb3hw?=
 =?utf-8?B?dktuaERVZzFBaFpuSU1KdmdCN3U5dUNCMmo5VVY0Tm85ek0rTmdXbk1YSHJH?=
 =?utf-8?B?STluV1pmTnJkMDMvWGFyK2kzcnVzcHF1S2htSlhIWW9vY2F4MGF4Y2dMbUl4?=
 =?utf-8?B?YnZVV3R4MFpCOUZ6UXpraFU3aUkzTG52NzlDN29hejkrWVFuY3U3VlFaKzlU?=
 =?utf-8?B?WEs4OUNIdkpqM3lXbXorWm1XRWxpSFZYVVptcGU2aVZaTmkxeWhUZnRIUy9a?=
 =?utf-8?B?N2dDdG9WcTVSWDRaMmhMc0tzM1B5TkNuRVk4YlBzeVU0dVRCaXE0cGVpSEcv?=
 =?utf-8?B?NDJ3ektUd3p5eEtzT0MwbkVmZTk0dytjczFKOXNwSnphdG5CZHVaMGZERlVs?=
 =?utf-8?B?MFVDOFZFWUNCeHpRU0VyTnpwYWxtRG1oS0hwRHhSVWZzZVErZjlRbXFtUko4?=
 =?utf-8?B?QUdTR3ZoWk5XTUQ2WkQ4cHhhOFk2SG4xR3V4aHhtZnVXbTVIZUxZUUZ2bG5P?=
 =?utf-8?B?WUVLRmJsbnMxbVREOGZuZE9OWHF6RXRzS1ljMkJPdXRrbGR0WW1ib0NUVjJn?=
 =?utf-8?B?cmZJa1V0OU1NZy8wZ3dRK0hiT2tib3NDdzlQOGZqbzRNWlpSNjBKYWExaVZG?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D35AD56508F4994091FEABA1021A8F03@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6548bcee-c38c-4a1c-fb31-08dabc9607dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 05:49:38.8982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLmwJ2orbYK+bFa7g66n6wY4csr/kO5dRMw8HAeLaonbbox/b/6I2Lf8zm37CsqfYkjquIYxSoQ52HOh1qKbBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMS8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFsbCBJL08gc3Vi
bWlzc2lvbnMgaGF2ZSBmYWlybHkgc2ltaWxhciBsYXRlbmNpZXMsIGFuZCBhIHRhZ3NldC13aWRl
DQo+IHF1aWVzY2UgaXMgYSBmYWlybHkgY29tbW9uIG9wZXJhdGlvbi4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogS2Vp
dGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogTWluZyBMZWkgPG1p
bmcubGVpQHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5OiBDaGFvIExlbmcgPGxlbmdjaGFvQGh1
YXdlaS5jb20+DQo+IFJldmlld2VkLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1l
Pg0KPiBSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg0K
