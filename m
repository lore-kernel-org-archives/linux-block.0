Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C58C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 01:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKBBUC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 21:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBBUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 21:20:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9360925D7
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 18:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeQPdAsttRXWuk2dfpeLOpOxDjQn956IxMLgF9IWV9rQP0GuAM5jzu9hLbn8SIsCJ6dIbaFnNjs/1qbUF+hWzSEnaMbaJnKRvXLtLIFwPEpXHTDKNy3yhJW78h127ld3m1Mp2KZMR6NjsuyBwT9694Q5qgjPz7VIJCP2c4DLRGcQ2p90aj2BWliEZJeF2NU1yVOtsM79xcV/glHHlJYYQBP/+PoeSgszhiNTJXo/B0Qb1f9Y/w1i7S4QtLgjvmYexu7eIoEUlzHoXdzgQWycZqH/P8k56O4UV+cu0vjA+TbOL/rrSkEN7NszexhufUGAq3hR8+5iT+i12jdLHgSdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBCI9JcG3fEquIcqEzpAJKfH2/HYRpQjx0ytFVTi1Tc=;
 b=e13GXq4uT3kdfdJiWfRS6zOzsoMjIUhXgWXK89MEi48U4Qg42XVCVrFtjvI3qdVygdWsxw/wGBEsCQTUOkxWdfdff2uFO9h+kddxHhmvRtD0wq34F/OtKBaZwZKrJXrywCkZjulBbUgRIO2wl+/cYTPkeNpn5g1Pam0r4zmPr8PxkXZWkaIubsEtwQ+sroynozyrVt1HhmKvJz612N5TWhmWT5P3FFIWWiihxD+P5lQZ71kj2vKw1EJuVhIRprAHQIur/w6AelREmnWZZhTMIWeiPSGeEQ+WU/AS9JIv5wtMlppcs/uZWZJZ9CQ3oEzArQz80CE6CCsQYVvSzziNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBCI9JcG3fEquIcqEzpAJKfH2/HYRpQjx0ytFVTi1Tc=;
 b=FfadF/8bIgCtz8PFnXO4VT/q5IktzX+7ZAiw62AFKFINznxFmflJJI8MfXYaeiAte3Mfv221N0QTbOyUJvdWM3I/eGnRkGXl1Zi34N5OJwVVkFg/RCZchQXBUp8IksRRR/FYH6MSJ1mdXO480IZBJrOx9Ezi2+lPtcoVVMSdPRDB29mhYg2zXbNIj/w1Q+iUtdOESMIZRvqCkg3NyXJrFxwE9xkyG98xidiNHh6xLDhpdNuBubPWX+/dEgOgypIwl0kvagrI7AhKvyJbM9F29Gl6IHvGmfhxe4SmwznjFnDmKWugoC7sb4HmY/JcHXT1ts3d+m0gHGm78o51UmJq6w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 01:19:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 01:19:58 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Chao Leng <lengchao@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 02/14] nvme-pci: refactor the tagset handling in
 nvme_reset_work
Thread-Topic: [PATCH 02/14] nvme-pci: refactor the tagset handling in
 nvme_reset_work
Thread-Index: AQHY7gL2BEDnIXlPy0mXOq9Le3l65K4q1mqA
Date:   Wed, 2 Nov 2022 01:19:58 +0000
Message-ID: <0d917231-cb93-31c3-1d3b-3f5ae23020c2@nvidia.com>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-3-hch@lst.de>
In-Reply-To: <20221101150050.3510-3-hch@lst.de>
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
x-ms-office365-filtering-correlation-id: 4ad1f077-c009-44ce-1134-08dabc705b6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pq5iBH8MnBTS03Z+OFRtNtG4IVSV/9P6UfwueHsVK5GQ2Z8KxrE+x5dPAPJp9e8BZ2zuNS/AGGn0rB26lrQVXVWbss8lbKL6fc+B6+ARI8snTTH5DF0Xf9zOhqOQqfm2LWh6SUBJMZloiu7D3Nq4/t9hF8S564q7ZQNfX2Pz5n9pHbz4gGev1vL7kxbemjNUT2X94lPng64RwUaCW7dqJBlnZIMEevQdjgKGakqdvijCtKF2xvHxQGPXV+w9XU8D6s2SnjTvMIBn6JsPMzviOxq89pO3WZknQhm8S591zSJNOkGDwVKy7v3Q6bUbmPMg3rcT+Fu5+SYjSIJsvz1ayVl4xMlKpLtrBF/kw7Q2UZOK6dxxvf04vJ9o/GAOCRcfKv8aNTn/yRyBsNrnRds0Z1CowfP0Wz+zOS+f7NZJax6XGK8g1OxvPS09yA+r/47EWgYPZL4XeuouAEp2vQqFom5HnydPvYW/VrS5yky1+0tmASmDJc5ULwpADznauZYfHzWdKIuMQQValfbhPZA+UIpAaF7o318GzpvdqHbEezu3MSTXCF5dzK9SElS9xguj+KiZRu67AgyHmDiWmnzY6E1YI68f1UEYTZ2fc1tzL+jRs5AeUMT8/PXTwybv1O3mpEphRhpB/8jMgN/x4iEdKwEoEFoQ2BQlDAQ0n+bsvdfUNLMmnuuN9cS2U9t51UyvaSbiVASytuCtgXNoR0DE8Gqmk5RiervzuC7GZUM2Ti28DdqeZwHNzWsTjDDkOX5gjZfXzUXj+ydroWqSJH/U62vFP5pGkXJt3nDDlJyQ+brbaJ4Nt7qk70SEcJihOl2mqmN2YttXHQYwHhbgQ5lcQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(76116006)(66946007)(91956017)(316002)(36756003)(54906003)(66446008)(66556008)(6916009)(2906002)(186003)(122000001)(83380400001)(6512007)(41300700001)(8936002)(53546011)(31696002)(64756008)(6506007)(4326008)(38100700002)(86362001)(8676002)(2616005)(5660300002)(66476007)(38070700005)(4744005)(6486002)(31686004)(478600001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2gxUllHdEdEbHZNWk1VRTIxT3k3ZGM5dEdiczVtSUhaaFg1c3Q5Y2hteGRB?=
 =?utf-8?B?R3R0VlJIdzZ1TE1weVVYWGdBeFZWZFRPUW5VOERoN0FwU3ZuSDg1eFl2Q01w?=
 =?utf-8?B?VWpwZU5oalFKZHRFWUZlM0JNU3ZtTkE0MGs4by9iY0ZoQjNpUjRpWDVQSW9U?=
 =?utf-8?B?VTRNeFZaQUx4cFJQVHQrRi8yUmdRaC9mQlowcUJrTlYvblBCeDhPQXRWT3Rz?=
 =?utf-8?B?Y3AyQ1V1b1VkRkorNmNkZGhGVm9rNFREc05USGtEbldTcDlSMWcvcllac3Bt?=
 =?utf-8?B?Z1gydEd1MmRINXpWRTVycGtQdTdTWUdpWm5ya1g1VGMwYTQrYzJSUW41ckgr?=
 =?utf-8?B?UGZhc0FBSTZxempvU2VKYzZxajNJaEx1dlhXVVMweHpLS1ZwNXRlNzBUYnQ4?=
 =?utf-8?B?M2xsTmJ3U3pURDFnZDZFL2JwSW1udmZhT2lSMGk5b3N0b1RYWlZjZVV6akpw?=
 =?utf-8?B?MVNEZzJrdVBCTFJldU1hcmNxeHBTcHFTRDBidmVzWE1mVmVFSnBMMU13a21Z?=
 =?utf-8?B?YmZCSEFZMG9LUEdFZVMxTWxUVXJWcUJDNmFCUVdMVVdiTm53L3Mzbk1QaEFX?=
 =?utf-8?B?RU1PTGcxV1Z3SWZRR2sraW9VamJ6NUw3V3hGSnNMb2dzSVdkZnRJU0NqUkhk?=
 =?utf-8?B?cHZGZHk1KzREc0Y4Wm5EaTUyYkd0MUdST3VuazBNOW9YclgwdjhnRVVDMFpD?=
 =?utf-8?B?V0ZxV2JRcFNMY1JmWHhaZHNmMWYwZlRSbnhwR1cxUytDQkxJcHdpNVd6bXJD?=
 =?utf-8?B?cnlRMktob05sSFB0ekhhY0kxNDVTQW93aTBHS1l4bEs3d2VPdCt0Y2ZGdHl3?=
 =?utf-8?B?SUVRWGN5cUorNkZ1RG5FR1ZTT1k5WHNXajFXcm5EMzNPT3I2Z3MzdHZnUDkx?=
 =?utf-8?B?MkJPdUc5Y2l0TUhqWStoOWYwTWI3eDAvK0xRUzVTaTZmd05PdkE2SXFvbGVn?=
 =?utf-8?B?MHAyMGRSNjR0MlFoWFgvQXNYQXhXTmJ4WEE1bTBDT2Y5YnZnVGV0SGRFMlEy?=
 =?utf-8?B?OUVPZGVIcy9zeSs1d1E3ZUhjemtFRWhmMm5MQXVoVnJrQ0tuQWh2UVJxY1Bs?=
 =?utf-8?B?eUxKckJBbGFtVDNBVW1SUUhMYUw1MWYwZEVYRTg3Mkt3QlZNUzdzYUgrVTVj?=
 =?utf-8?B?VHBHVGRqWEFEdGtvWU11YXlhYndHOTNOdStPZm1NS0szLzA1NVlVNnJYbFBX?=
 =?utf-8?B?bjBwQUF4Y3p0dEFjT2M5ZDl0aEI3bVZxMDBmSWd4blRTVW9aM05vL3l4NENx?=
 =?utf-8?B?aTFsYTVIMW5XV2dQbWFNeDhnMnVET0tIK0l4Rm1qMEcyWHZIZVJFUDZleFhk?=
 =?utf-8?B?Sy8wMzVLaDdFWEZTanhyekpwUWhtK2o1bHh1ZEFaTmpSNnFYakk0UXBoS09w?=
 =?utf-8?B?UmlXdXdhYlFMYXkvZktSVjA2dUdibExmWUJaN09RS1FKa1ZCNE91RElQUXZn?=
 =?utf-8?B?RlZsd3NBaFBYdlNnZWUyRGwvcEgxNWFRc29VVUl4RnExZW5EbGJHS3ZrZ08w?=
 =?utf-8?B?cU1DMXpwMjhRL0hQS0ZuZnJ2bVlNMTJuZ2h6TDQwS0JHTjhidUdOdEZWZnBt?=
 =?utf-8?B?eUY4N045REF3V0pIaUJRNXRnVDVKZFFZQ2dUOUhFVlI2dEdRdnNlYlRzNUY4?=
 =?utf-8?B?Tm1heDY0c2d5ZC9ZQUgzUkJUOUI0RTZLdXJVVmUrcjVGNStSdkhkMzk4bktU?=
 =?utf-8?B?d1dleDN2SmZCT0FTMGVtNFMxNElxZ2o5MUd1UFpZMHc4eGtqQktiUjVuNVN0?=
 =?utf-8?B?eGdxZFpPY245TXBOaUo3YXlPYTM5a3dnY2dFZ0dkQ0xUM2RiNmRvMVAvMVRW?=
 =?utf-8?B?VktSVVhKME5xQ3ZOenFjbVR3RXpUS3ZaMTRqUU5GNGJXTnJRRy9BY0xyRldz?=
 =?utf-8?B?MWg4aXBnUy9EVVFiUkZ2VTU1aTNOV0FiekEwR1BRbTRoYTFjU29aTU0zWDZo?=
 =?utf-8?B?WVNDK2FlTU9LdGJ6Q3dCNHFWL0t5Y2Y1R3Y1UXdGK0NtQ0ljeEUydW5ySVF1?=
 =?utf-8?B?enREczI4djdzcnNycVB1Y1RZbTFZdEJkekY5RFp5cmR5OEQ5bmNnNmg4eVVq?=
 =?utf-8?B?TnpwM0Qvc1A0d1hOYjIxMERjSW1oeTlkbk1POU1vK0lma08xUXVPMnVBZnMx?=
 =?utf-8?B?T3AzRU1mZFlKWkhmZjc1Y2o4QTMwRmk0NmRMbk1waGtTbVNaNmFmYUZyTTZI?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <527B0D3B19A69F458A033BDF65D063C2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad1f077-c009-44ce-1134-08dabc705b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 01:19:58.2358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTysg8B20iuSpel1MqoMe5ej2n7jFzU91ypg7C8FxZ3t8Q+y2gxigldvJL7CPoxyEJt4b8OunwHwx9CUoEvA4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMS8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZSBjb2RlIHRv
IGNyZWF0ZSwgdXBkYXRlIG9yIGRlbGV0ZSBhIHRhZ3NldCBhbmQgbmFtZXNwYWNlcyBpbg0KPiBu
dm1lX3Jlc2V0X3dvcmsgaXMgYSBiaXQgY29udm9sdXRlZC4gIFJlZmFjdG9yIGl0IHdpdGggYSB0
d28gaGlnaC1sZXZlbA0KPiBjb25kaXRpb25hbHMgZm9yIGZpcnN0IHByb2JlIHZzIHJlc2V0IGFu
ZCBJL08gcXVldWVzIHZzIG5vIEkvTyBxdWV1ZXMNCj4gdG8gbWFrZSB0aGUgY29kZSBmbG93IG1v
cmUgY2xlYXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxz
dC5kZT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
