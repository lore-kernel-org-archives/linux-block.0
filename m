Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C21C4332F
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 08:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJQImQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 04:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiJQImO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 04:42:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7832B198
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 01:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn1EB9krTyzd1b6mL2qcwrFeFpOT9lI2ojyDvhJoo0nn6T8A8a0FeU6yXQLq0SjpUjpBQySF0FkS/ySNu23s2/iYx7/JjGMujL3KdwQvyNOs6Ho+wB7pP39KCOL3QMDPN2vjsIJnQHTKmdTqDHh6xGT9kJKVR0vYBH6OGOBH6sd6abt/bTFIhkUUpU6c6J6AszQYyQSYrvWnXjxueYh2q5G08Z3KdLcyuBKAS+HYWGnKrDWmUiMFBHMoCdUjFsMqADPjr+fWu7V2KqQxu8f79fvPDBMxUtW8Uzytz347mnC71y4nwx3c6bq2YF+2Caap4/2WQe+YMdlSq4z+Iff/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+UypPpju+U6ix8XFm+7x7gO6tFQf0wnQSM1Lp1yGJs=;
 b=Gi9pHPUjbe98HA0li6rTqPZQkNsJ5INtsiDmzcEYK67KMyLFjFwWVvm4dtWEadMVpz9Y/DgK4LTjWhddU4X7pC2PC7CsE8nJ1yJyJuR2Lvi9Z+izxyu8++rnp3gApxBiCmrThfw0DEQfLjhZh03/b922HbrLnlw7NCo1kP0O9/MlBcKrGlUlXRLLWokXJiQUkJuRjuWdimvElpbLuBWkHjWYPsrwRSCEDIMBPAOpMrliUEc95vNZDg032BPvDU5ivAZaJ1FMPg2D0CF0zIVA0q6p/KB4d/ESMi/e4/C/gFpQPFCkXaV1yPIqkAwj/wpZ/nd5RzO7nJ/Au/3BouEAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+UypPpju+U6ix8XFm+7x7gO6tFQf0wnQSM1Lp1yGJs=;
 b=He9QnFppyDj1Q12jLCcd5Vpu8wwWwMnbStU/n1Q+BuzsFplS2kSQf5uWxq0c3HHTWTDCmlKCN5UcHbh/cmuGd36a3bQyPJL4EVWFBRZQW0PK3xV7mVAjJAJEBMRC3SVts4ujeTdr2v69CsizJvTweewmiygxpc7lFdIjm9gva61Lx5xpPmvQcH0XbsnvGwKFIo/muPkrSzQ5cQsjN9IQ9kmguvC1RYiCuBWwgfSHk5xWK4TavsSkfC5c77LNOTO3t+EeKowQW4hGQkbnGqunseAaFsV8OZ7N2bijZNCmHNbwUYGYOq6tRderxxgyKNsyV1wv2qDweHzEU8XHbxnXRw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB5017.namprd12.prod.outlook.com (2603:10b6:610:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 08:42:10 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 08:42:10 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH] null_blk: allow teardown on request timeout
Thread-Topic: [PATCH] null_blk: allow teardown on request timeout
Thread-Index: AQHY4R8DFU2LJu/Wy0udZZqXPfzvLK4RzLiAgAB5ugA=
Date:   Mon, 17 Oct 2022 08:42:10 +0000
Message-ID: <c6867c78-d8aa-c02b-544e-f777e73d5064@nvidia.com>
References: <20221016052006.11126-1-kch@nvidia.com>
 <1636ebe1-68eb-b754-fc1f-00d8be7b728b@opensource.wdc.com>
In-Reply-To: <1636ebe1-68eb-b754-fc1f-00d8be7b728b@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH2PR12MB5017:EE_
x-ms-office365-filtering-correlation-id: 21f6323c-8316-4340-39dd-08dab01b7b61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kipDBPhqpfmRQ1c0k1y9vQMf0QiSClGMCz1y2gcSsJdsxZ22BBWyxA0cWA/aFECSK74o4yNx6X/NS/ODjM0M1J2xZ1cEJr7HM9EPHUBj5ALb1gPwE74DPd3Ir+2R5fUubFkK0SJi3xgW6jXeJ4vb5s/nasZ6/7KJmGv/pJlg8aXKHSRl9QgCG2+8fMIdAKnvLQKqNvsLMwgQNaNO6LkXpB1F2ZXcxmjo5f/B1TWOgjMK/0cE6Z5wjirUM/Z7IjI+6lsW781AsfMbaO2heK4TVxh6NjwLvckLJ03AsbSJbzoMM8ecnPjzC3gd1YsW81nW+QxS1s7hbup2rbwqyfkAPDCrNuSwNZn3iAqdEgJl3sBbSNA9f1Yb3UsOFcZ+r0Xk4XZDdLZGHCtKeGRTCMwxrxjkKWNORWQuOfmYVDp7xQI42E9865tLuIqu6YCJXb4kRoiOGEdhPSLGeeFbvjDyz+D29rl5Lnc4ty5FiVocM93PdbAlNP1M3uuphrq2FjFEDDdQ0ZIlP8AsfL8Gr5/N8r/U4+RQ4oIdBwQzYtCX+RcDyP7uTyrazbJsjscgxEP5fKepLZ7zy9ujgkrax/vbOb79HAbx1GxFHtGGlYYRLjFyXzgnuXBERyk7otsCJ4Qxkqsf2U8kmNx9wyKPni1dvwSViNvlz7ZA/cTKlC6pp1rOSeYsMnvDGUEHNU651w1NNQ2lXPzWZbjBBtfox90GvzumoFBA01pReFs7uAAqxRL98b43K3DCb0orHLIykNEl3TFyorylOPLEWR+T3K4+Nhu+k5xsIdSlhhoJqYIuWaVtaAB0/fmLJKiHSY8rSfVkgS5K0X4MjXyHUDMB9xt9Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199015)(38070700005)(36756003)(86362001)(31696002)(38100700002)(83380400001)(122000001)(91956017)(66946007)(76116006)(64756008)(66476007)(316002)(31686004)(110136005)(54906003)(66446008)(8676002)(5660300002)(8936002)(6486002)(186003)(71200400001)(2906002)(2616005)(6506007)(66556008)(4326008)(478600001)(6512007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wkl4Q1pxWlM1aEFCUEVOT0hqcVpxeHRtTkJDNUx5Z0kyVzYvRFFOSno4a3c3?=
 =?utf-8?B?Y1RNVWRxVHQ0YVRwN3hjd3grUEZtYUNtL3liWHFuTzJEemlmS0txcUtleVdu?=
 =?utf-8?B?blBpYkY1UCtFWnVIVDVvSGlrSmM4ZE9CNXpHTCtYL2w4RkJyM3FmZlBtSEJD?=
 =?utf-8?B?NnFSMzBIU0kyRHdHeFVBUUx2ZGZMTVpxUGExUmRlTWczdmduWVpmS1RLeGEv?=
 =?utf-8?B?QXhuVzA0aGZ4dWVKWldvd0RPdDFIVEJtbzhmWTloUVRlZnNoNGhZSys3Qkx2?=
 =?utf-8?B?WkNwSSs4aW1SVDcwV3hVMWwzc3EzcEtmR0t1OWtzdmtLS1dQUFpWeTArRFkv?=
 =?utf-8?B?bzlVK0hjd1pkUWQyM2xBNVA1eFAyTzVRbklybVozYUtqaWZqT05ZeUhNTUgr?=
 =?utf-8?B?YytTY2grU0xKZGdZb3dPYXpUVEdWV2dFa0FBVHZrNEUxMHNNNVpyZHhQU1gr?=
 =?utf-8?B?bkVQOEFSTFlZS3ZRY1ZYOW5oOEQ2djJGWEJLTVZpL2ZFejh1TFdnMUtvVXFa?=
 =?utf-8?B?a3drWDhqQjN6VEptZTUvYnBMUGdFQkxjNm0wSkwwVXZwZHRRNGMxanhYbWpK?=
 =?utf-8?B?RVJVUkdTVmw3VWRQNis5TWdHZWlaZHczQ3Z1emwyTFYrMm94UFJENFAzU3dq?=
 =?utf-8?B?RTJMdkxud2hncWg2czBCUHhNOEZYSWI2TkhseHdibllBc1RzLytlWFhOUDho?=
 =?utf-8?B?TkhBaG16aXc4dVhVQ0pyR0hiU0V0QTFLRzNFc0xQV1VjM2RGa0FJazBHVmpP?=
 =?utf-8?B?Rjh6TDZVRU1CekN0T05Va3V6ZlJYOTdQL1Y4eGtHZWlaQklReHZLamR1cWxl?=
 =?utf-8?B?VUFRU2I5ZWYxRDE3ZFp4cVJlVTJweXJsakdlWldaYjZQRDU2ay9DbnlySFVD?=
 =?utf-8?B?SzVTMXpCcU8yWERRSWMzdzJ2QThHOURyRit5V2FOV2p6cExaTk4wZGNXV2tv?=
 =?utf-8?B?dEl2N0duYzJiM0NoU3diK2g4cm5UYTMyS2FjdTdva1lHZlJYQkxQaTdWK2Uw?=
 =?utf-8?B?Z012aU16ZGZ3cDFMV2Jmc1JzaExuazhrd3Jid3RwZFBVbWhsNzFvTlZQZCto?=
 =?utf-8?B?QUVlT1piVFJLejBDMzFmUU1ZQkxGQS9nRVowcW5Uclk3QkRsVThUcW1HWkJz?=
 =?utf-8?B?dldqaTNDT1J5WmsxcFkya3RqMGZjZWttQkloN2pCMVU3MUMyV2c3SzNXaDFt?=
 =?utf-8?B?Qjl4TXE1ZnJWdjVOR1Q3YS9KS1lMQ050RHBEMzEvUmttMlBqWHVKRDdlMS9o?=
 =?utf-8?B?YUxpT211VzgzTFJycG82TWlKT2VuSXd4clFSQlJZU2hLdit6NmwrT2pLdUFO?=
 =?utf-8?B?TmxtT011ekZPMmxPb2phREpPSitlbW5iZnZsV0J2MCs1cytZUXVrcllTVWQv?=
 =?utf-8?B?MDhkOUlCWXVDWGZnUkMyNzB2angvNXdrY2lkd29LOEdFa3MwK1pCdTBNZ2Rl?=
 =?utf-8?B?VEUyb09rVWIvQXJYMDNKeXp1KzNjeGhzYmxFdjVsandwb2ZNakcxSElQeS9O?=
 =?utf-8?B?Q0VGalFWemw3cG1OUEhCWXhIdGg5anZDU0prbEZzY0ZkMUJYdE1mNStsaktR?=
 =?utf-8?B?eGc3bXIzNnAzUUdnTk1UTVlJZDlnYnQzbVJsbmJmdHdYRmdiQTMzUkJoeERZ?=
 =?utf-8?B?dEg1aTZRUlVKOWZrT3BGVURYSVBGTElUaVlaOHJaYzQxblNvKys1cjk5akpO?=
 =?utf-8?B?Q3dMc3hxc3Bzbi9YNnZPeWxtVm5GdFhEV3ZreWxORDdmUDZJQVFEUGRpM1Zi?=
 =?utf-8?B?cXMrSTI4Y1M0dkxFOHpDK1pURjdGSUo0WmFNdXVxUWw0UmJxTm9CYlZWSy95?=
 =?utf-8?B?dWVYdWRKNGVXN3FHelk2M2pLWkpRWTFGVDZRREJZZTQxSDlGWWU4Uk1hTUtk?=
 =?utf-8?B?ZmN6TGg3S2JFRnZIY3ZlN2Q3MlpUaGRERE5zNzlzSklpVlcrbHM4WXpyNzJw?=
 =?utf-8?B?MHBoUGliY2djYk9ZNGpsMi9FUTFCT25GSEdwdlFyRkoyWEZOSlMrYXJhYlZh?=
 =?utf-8?B?VGlvczgvTVI2TWlJVFl4Y29oREgycjU1ZjhKM2RmbzZ4QlRpcHhEbmpka1Zt?=
 =?utf-8?B?bUNCZ0c0ZzQxZUQwczVWS2tFT25vTE9lZVViSmZUdkJPYmpSdVBkSUJyQWdG?=
 =?utf-8?B?a3JWM2pQbk5rSXc5VG1SSXgrQnNUY2NCbzI5M0VnNlRjcVRxUHFSc2NCWDUw?=
 =?utf-8?Q?ZzcA8rLm1qFQDFJwEpITakhTWPAh8K0qe7ZxHo79qb+c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29197B76E9CABF45B56C160FD6FA7C82@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f6323c-8316-4340-39dd-08dab01b7b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 08:42:10.6452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9WP0GC0dXyABjZo06fp9jw9zcrYl3CfAddbvLPRqEiBE+40KyRIE5WCv30ctU2/bYPiGJFskFc07qALQKv4XcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5017
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pj4gICBkcml2ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYyAgICAgfCA5MCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tDQo+PiAgIGRyaXZlcnMvYmxvY2svbnVsbF9ibGsvbnVsbF9ibGsu
aCB8IDEwICsrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA5NyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL251bGxfYmxrL21h
aW4uYyBiL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jDQo+PiBpbmRleCAxZjE1NGY5MmY0
YzIuLjUyZGI2Yjk5YjQ0OCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsv
bWFpbi5jDQo+PiArKysgYi9kcml2ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYw0KPj4gQEAgLTc3
LDYgKzc3LDEwIEBAIGVudW0gew0KPj4gICAJTlVMTF9JUlFfVElNRVIJCT0gMiwNCj4+ICAgfTsN
Cj4+ICAgDQo+PiArc3RhdGljIHVuc2lnbmVkIGludCBnX3JxX2Fib3J0X2xpbWl0ID0gNTsNCj4+
ICttb2R1bGVfcGFyYW1fbmFtZWQocnFfYWJvcnRfbGltaXQsIGdfcnFfYWJvcnRfbGltaXQsIHVp
bnQsIDA2NDQpOw0KPj4gK01PRFVMRV9QQVJNX0RFU0MocnFfYWJvcnRfbGltaXQsICJyZXF1ZXN0
IHRpbWVvdXQgdGVhcmRvd24gbGltaXQuIERlZmF1bHQ6NSIpOw0KPiANCj4gTnVtYmVyIG9mIHJl
cXVlc3QgdGltZW91dCB0byB0cmlnZ2VyIGRldmljZSB0ZWFyZG93biA/DQo+IA0KPiBUaGF0IHdv
dWxkIGEgbG90IGNsZWFyZXIgaW4gbXkgb3Bpbmlvbi4NCg0Kb2theSwgd2lsbCBhZGQgaXQgdG8g
VjIuDQoNCj4gDQo+PiArDQo+PiAgIHN0YXRpYyBib29sIGdfdmlydF9ib3VuZGFyeSA9IGZhbHNl
Ow0KPj4gICBtb2R1bGVfcGFyYW1fbmFtZWQodmlydF9ib3VuZGFyeSwgZ192aXJ0X2JvdW5kYXJ5
LCBib29sLCAwNDQ0KTsNCj4+ICAgTU9EVUxFX1BBUk1fREVTQyh2aXJ0X2JvdW5kYXJ5LCAiUmVx
dWlyZSBhIHZpcnR1YWwgYm91bmRhcnkgZm9yIHRoZSBkZXZpY2UuIERlZmF1bHQ6IEZhbHNlIik7
DQo+PiBAQCAtMjQ3LDYgKzI1MSw3IEBAIHN0YXRpYyB2b2lkIG51bGxfZGVsX2RldihzdHJ1Y3Qg
bnVsbGIgKm51bGxiKTsNCj4+ICAgc3RhdGljIGludCBudWxsX2FkZF9kZXYoc3RydWN0IG51bGxi
X2RldmljZSAqZGV2KTsNCj4+ICAgc3RhdGljIHN0cnVjdCBudWxsYiAqbnVsbF9maW5kX2Rldl9i
eV9uYW1lKGNvbnN0IGNoYXIgKm5hbWUpOw0KPj4gICBzdGF0aWMgdm9pZCBudWxsX2ZyZWVfZGV2
aWNlX3N0b3JhZ2Uoc3RydWN0IG51bGxiX2RldmljZSAqZGV2LCBib29sIGlzX2NhY2hlKTsNCj4+
ICtzdGF0aWMgdm9pZCBudWxsX2Rlc3Ryb3lfZGV2KHN0cnVjdCBudWxsYiAqbnVsbGIpOw0KPj4g
ICANCj4+ICAgc3RhdGljIGlubGluZSBzdHJ1Y3QgbnVsbGJfZGV2aWNlICp0b19udWxsYl9kZXZp
Y2Uoc3RydWN0IGNvbmZpZ19pdGVtICppdGVtKQ0KPj4gICB7DQo+PiBAQCAtNTc4LDYgKzU4Mywx
OCBAQCBjb25maWdfaXRlbSAqbnVsbGJfZ3JvdXBfbWFrZV9pdGVtKHN0cnVjdCBjb25maWdfZ3Jv
dXAgKmdyb3VwLCBjb25zdCBjaGFyICpuYW1lKQ0KPj4gICB7DQo+PiAgIAlzdHJ1Y3QgbnVsbGJf
ZGV2aWNlICpkZXY7DQo+PiAgIA0KPj4gKwlpZiAoZ19ycV9hYm9ydF9saW1pdCkgew0KPj4gKwkJ
LyoNCj4+ICsJCSAqIGFib3J0X29uX3RpbWVvdXQgcmVtb3ZlcyB0aGUgbnVsbF9ibGsgYW5kIHJl
c291cmNlcy4gV2hlbg0KPiANCj4gLi4udGhlIG51bGxfYmxrIGRldmljZSBhbmQgaXRzIHJlc291
cmNlcy4gV2hlbiB0aGUgbnVsbF9ibGsgZGV2aWNlIGlzDQo+IGNyZWF0ZWQgdXNpbmcgY29uZmln
ZnMsIC4uLg0KPiANCj4gVGhlIHJlbWFpbmluZyBvZiB0aGUgc2VudGVuY2UgZG9lcyBub3QgcGFy
c2UgYXQgYWxsLg0KDQpva2F5LCB3aWxsIHJlcGhyYXNlIGl0IGluIFYyLg0KDQo+IA0KPj4gKwkJ
ICogbnVsbF9ibGsgaXMgY3JlYXRlZCB1c2luZyBjb25maWdmcyBlbnRyeSBieSB1c2VyIHdlIHdp
bGwgYWxzbw0KPj4gKwkJICogbmVlZCB0byBjbGVhbnVwIHRoZSB0aG9zZSBlbnRyaWVzIHdoZW4g
YWJvcnRfb25fdGltZW91dCBpcyBzZXQNCj4+ICsJCSAqIGZyb20gbnVsbF9hYm9ydF93b3JrKCkg
YW5kIHRoYXQgd2Ugc2hvbGQgbm90IGRvIGl0LCBzaW5jZQ0KPj4gKwkJICogbWFudXB1bGF0aW5n
IHVzZXIncyBlbnRyaWVzIGZyb20ga2VybmVsIGNhbiBjcmVhdGUgY29uZnVzaW9uLA0KPj4gKwkJ
ICogc28ganVzdCBkb24ndCBhbGxvdyBpdC4NCj4+ICsJCSAqLw0KPj4gKwkJcHJfZXJyKCJkb24n
dCB1c2UgZ19hYm9ydF9vbl90aW1lb3V0IHdpdGggY29uZmlnZnMgZW50cmllc1xuIik7DQo+PiAr
CQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4+ICsJfQ0KPj4gICAJaWYgKG51bGxfZmluZF9k
ZXZfYnlfbmFtZShuYW1lKSkNCj4+ICAgCQlyZXR1cm4gRVJSX1BUUigtRUVYSVNUKTsNCj4+ICAg
DQo+PiBAQCAtNjE0LDcgKzYzMSw3IEBAIHN0YXRpYyBzc2l6ZV90IG1lbWJfZ3JvdXBfZmVhdHVy
ZXNfc2hvdyhzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0sIGNoYXIgKnBhZ2UpDQo+PiAgIAkJCSJw
b2xsX3F1ZXVlcyxwb3dlcixxdWV1ZV9tb2RlLHNoYXJlZF90YWdfYml0bWFwLHNpemUsIg0KPj4g
ICAJCQkic3VibWl0X3F1ZXVlcyx1c2VfcGVyX25vZGVfaGN0eCx2aXJ0X2JvdW5kYXJ5LHpvbmVk
LCINCj4+ICAgCQkJInpvbmVfY2FwYWNpdHksem9uZV9tYXhfYWN0aXZlLHpvbmVfbWF4X29wZW4s
Ig0KPj4gLQkJCSJ6b25lX25yX2NvbnYsem9uZV9zaXplXG4iKTsNCj4+ICsJCQkiem9uZV9ucl9j
b252LHpvbmVfc2l6ZSxhYm9ydF9vbl90aW1lb3V0LHJxX2Fib3J0X2xpbWl0XG4iKTsNCj4gDQo+
IFdoZXJlIGlzIGFib3J0X29uX3RpbWVvdXQgZGVmaW5lZCA/IE5vd2hlcmUgdG8gYmUgc2Vlbi4g
RG9lcyB0aGlzIHBhdGNoDQo+IGV2ZW4gY29tcGlsZSA/IEFsc28sIGFzc3VtaW5nIHRoaXMgaXMg
YSBib29sZWFuLCB3aHkgaW50cm9kdWNlIGl0ID8NCg0KUGxlYXNlIG5vdGUgdGhhdCB0aGlzIHBh
dGNoIGlzIGNvbXBsaWVkIGFuZCB0ZXN0ZWQgd2l0aCB0aGUgdGVzdCByZXBvcnQNCm9mIGFwcGx5
aW5nIHRoaXMgcGF0Y2ggc2VlIGFib3ZlIGZvciB0aGUgZ2l0IGFtLCBjb21waWxlIGFuZCBydW5u
aW5nIGZpbyANCiAgbiBkZCBjb21tYW5kcyB0byB0cmlnZ2VyIG11bHRpcGxlIHRpbWVvdXRzIGFu
ZCB0ZWFyZG93bi4NClRoZSBhYm9ydCBvbiB0aW1lb3V0IG5lZWRzIHRvIGJlIHJlbW92ZWQgc2lu
Y2UgSSBnb3QgY29uZnVzZWQgYmV0d2Vlbg0Kd2hhdCBuYW1lIHNob3VsZCBiZSB1c2VkLi4uDQoN
Cj4gV291bGRuJ3QgdXNpbmcgInJxX2Fib3J0X2xpbWl0ID4gMCIgYmUgZXF1aXZhbGVudCA/DQo+
IA0KDQp0aGlzIGlzIGV4YWN0bHkgd2hhdCBpdCBpcyBkb2luZyByaWdodCBub3csIHVubGVzcyBJ
IG1pc3NlZCB0aGF0Li4uDQoNClsuLi5dDQoNCj4+ICsJLyoNCj4+ICsJICogbnVsbF9ibGsgcmVx
dWVzdCB0aW1lb3V0IHRlYXJkb3duIGxpbWl0IHdoZW4gZGV2aWNlIGlzIGluIHRoZQ0KPj4gKwkg
KiBzdGFibGUgc3RhdGUsIGkuZS4gb25jZSB0aGlzIGxpbWl0IGlzIHJlYWNoZWQgaXNzdWUNCj4+
ICsJICogbnVsbF9hYm9ydF93b3JrKCkgdG8gdGVhcmRvd24gdGhlIGRldmljZSBmcm9tIGJsb2Nr
IGx5YWVyDQo+PiArCSAqIHJlcXVlc3QgdGltZW91dCBjYWxsYmFjayBhbmQgY2xlYW51cCByZXNv
dXJjZXMgc3VjaCBhcw0KPj4gKwkgKiBtZW1vcnkgYW5kIHBhdGhuYW1lLg0KPiANCj4gcy9pc3N1
ZS9leGVjdXRlDQo+IHMvbHlhZXIvbGF5ZXINCj4gDQo+IEJ1dCBJIHRoaW5rIHRoaXMgY2FuIGJl
IHNpbXBsaWZpZWQgdG8gc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAvKg0KPiAgICogTnVtYmVyIG9m
IHJlcXVlc3RzIHRpbWVvdXQgZmFpbHVyZXMgYWxsb3dlZCBiZWZvcmUgdHJpZ2VycmluZw0KPiAg
ICogYSBkZXZpY2UgdGVhcmRvd24gZnJvbSB0aGUgYmxvY2sgbGF5ZXIgcmVxdWVzdCB0aW1lb3V0
IGNhbGxiYWNrLg0KPiAgICovDQo+DQoNCk9rYXksIGlmIHRoYXQgd29ya3MgZm9yIGV2ZXJ5b25l
IHdpbGwgYWRkIHRvIFYyLg0KDQo+PiArCSAqLw0KPj4gKwlhdG9taWNfdCBycV9hYm9ydF9jb3Vu
dDsNCj4+ICsJLyogdGVhciBkb3duIHdvcmsgdG8gYmUgc2NoZWR1bGVkIGZyb20gYmxvY2sgbGF5
ZXIgcmVxdWVzdCBoYW5kbGVyICovDQo+IA0KPiBUaGlzIGNvbW1lbnQgaXMgbm90IHJlYWxseSB1
c2VmdWwuDQo+IA0KPj4gKwlzdHJ1Y3Qgd29ya19zdHJ1Y3QgYWJvcnRfd29yazsNCj4+ICAgCWNo
YXIgZGlza19uYW1lW0RJU0tfTkFNRV9MRU5dOw0KPj4gICB9Ow0KPj4gICANCj4gDQoNCnRoYW5r
cyBmb3IgdGhlIGNvbW1lbnRzLCB3aWxsIHNlbmQgb3V0IFYyIHdpdGggY29tbWVudHMgZml4ZWQu
DQoNCi1jaw0KDQo=
