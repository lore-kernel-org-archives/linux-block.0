Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB08DC6FA8E
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 05:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjCBFBA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 00:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBFA6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 00:00:58 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7888B2A6E2
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 21:00:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZ0FJAvmGnuDWe9UwaO5xuXz9YCJKfMwRWhxP8/LKoLB9wv+T5c/019vTIgdMi4sf9Qw+CwdW+juEbLJmWd6HX8NqP5IzZwIV+BafbG/c9AHFtOfaolqWOVYXyxWm3czHUJ1/k6v6QbrFodoSPfuwhcsoY7VgpqrdNJ81QyIxmaYHTFQRsEUP9nj8XbC47uKfD6L9TjBZ6seCI3BiHGFpdmseHBVq1QWobuQc/ElnRGLigXq+Upfl2XsJo3y06CyXOIptydFNMmdqsobGl1N1ueAJa5CHl2QLCoIv7gF3GAerW0JHTZFnsYlZWsb2ljxwZc+dQSTLJP8f0Mo7Fsn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhpppYX1llmbbmvJzJfXwTUZ9jkM19H7HvhqB76NxJ8=;
 b=aqJg7I1Cess8x1h7ZcpUQ5Ya7LjKZMhs5SFohohIAzz6DseWOU4Poj/t92Z3eerPvuLD9tzlHKpMDuFEehIO/Z06Skx+3fJlQ7vjQNtBXvPjD46YyrdYDr8SF19No0Mnxx424ROVvRQyEKx/+lZrVHlAUDFoYI3tII1J9WUbpH5pzC+UHEygPia8HZ0/cj2ZuiBAV3cx9ZoRYUxBdkNJy05GD463Q/e5ptVU9BWQMzuWKQBLfVFxIuP/ojvoVEkHByygaEJLqT1VD+0MBwWZ1N9wr92+fUeD82b796kiV6Ic+gcFcHsJmONOK74YHUsKvT+IgHSPMg45+un4C49dMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhpppYX1llmbbmvJzJfXwTUZ9jkM19H7HvhqB76NxJ8=;
 b=GGaPxaclFz+khRf25eNNsvXYliVZ7tCPdXNo9tgBr0joK0arHvldQNoR0+DqoMUbIYyTbnRGDaUqf1dCQYYcR9VG3HW53UhJAhjH3sPzDn0evGHgm5QLOZnzYnOmM7lSsnaJJcxQCT9CHGezKO5JWXWO1lUKLU0whCW5YfCY8czpkdN2EvgR18sSVAojA04t1NLPHWOs9fWeBBzAdJLHGYHSiHhIKGThoy6vYpvjCj2yKAmSJ9YAPoB9VVQBPfZbfz4jvvvZd5jXQU/6xJ00SCb/9iA7rPEahkuaeEfZv7bad+g3Knrr/sPYL8VvITTmqbvI4EgmyYyhtLhXKhyJSg==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 05:00:55 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::386a:2802:5f3c:bfaf]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::386a:2802:5f3c:bfaf%6]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 05:00:55 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH blktests v4 0/2] blktests: add mini ublk source and
 blktests/033
Thread-Topic: [PATCH blktests v4 0/2] blktests: add mini ublk source and
 blktests/033
Thread-Index: AQHZSE3exRWNlmw1H02JclbSW33OMa7m91SA
Date:   Thu, 2 Mar 2023 05:00:55 +0000
Message-ID: <fafd397d-0590-b6ce-121a-365877596ee1@nvidia.com>
References: <20230224124502.1720278-1-ming.lei@redhat.com>
In-Reply-To: <20230224124502.1720278-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|DS0PR12MB8442:EE_
x-ms-office365-filtering-correlation-id: b74e28ef-f491-4ec5-9496-08db1adb1afe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V3QlFyLNoHzX2auywYBrTdeOcFXOn0TSICUtZKQKtbcXUKwZQfvqaV+LH8Rm+5pO3JngNpyU+8ClnyDq79A3V4gloHqi9mUJWhSzmU4gDc8CJfc2/sRth8K9d9vwX1nHsRY3qclcMIGXK9S39FdRkB/iVbu0nZi4XFf41F95YchSGK2kbsbLbzomBthByK99Fe+qoAoH+NuYn9JXaWMeRyWKmBfdzRYM42K8vPllRj0nOI+OXgeeYCdsrHJdcxXXsX0dKeW8JmM1YH9ed8oQ/FhdkBktjfb98+QLlnwkMOPrQx1CTSCxGPbGSelwQ12H6NM5R0wAx5jJnLpYlForxZvvOTfZGYfovWxTdfSkMNJOabKcoed9ISZjITKsoY52Eq+1VO6AzvLN0CxtQHgTatNZm6/QQ/7iSsdUHH6ysX3bJXxwO5XK2jH/9/OhSdNG8tDjrO+caD/hoAHrnAP3LofM72G9Z6t4a2N8Tsg1d1hmEv7qq0MPQRYSWhGnK1U6zEAyzJCZUxEvE5cC2VrOD8XBLqzvkt5kjWVw1L5rSSlOgIPzEYpKw5FkGrK45Zmxp02BdAoxLsq8XcVBcsId2sjZ6k+OOXjI8vzhN/nUzwhP6Btu5VuIesk0lLpriXKTe/JHuzEro47eTDZaqcnrha8bOLtDeCJvN6yMFy1A/kGUbkwcOQ32m+nuE3+zxoQWmJJ2atb0/8pPKX1XyznfS2+cZtUm5Vi/PQOcIYPU76BwVzhH/nyHUOjC4PCqmSgN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199018)(122000001)(38100700002)(4326008)(38070700005)(31696002)(36756003)(558084003)(86362001)(2906002)(66446008)(66946007)(66556008)(64756008)(5660300002)(66476007)(41300700001)(8676002)(8936002)(76116006)(53546011)(6506007)(2616005)(6512007)(186003)(110136005)(91956017)(316002)(478600001)(31686004)(54906003)(6486002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVc2MW5OQkZ6Y1RnLy9hT1RCZ3NPMWUvTWFKa2djNHdKSjJBSjNwd1JPeWJv?=
 =?utf-8?B?aGdURDBHNWRBZU91bWtXcFI4TmxJQ2NWaUp4Rk1aN2hQSjdHU0xpcDlDU2lu?=
 =?utf-8?B?UGlrQWdUYnFJc1crNWl4d0tjUjJGbnkyejgxSUpYcjRjaXVXK25qc1JpdEJo?=
 =?utf-8?B?bmV6TFNqNnpIbmJadU8xem1uUUdXSlB4emQzbm1kbU1VK2o3WFh4SDJ6dDFq?=
 =?utf-8?B?dFNmV0tpVWxGRDM5Z2dvL0p4RjgzcTNrM0YzdEQyL0NlemFwMm0rbWt4Z1Vz?=
 =?utf-8?B?V2dTZzdZZTU1dlVpNmFndEZIWU10c1gxeTZ0T3B0bEZuK04xWWdLZElFZDhp?=
 =?utf-8?B?TDJPU0EyUEJ2WDRTd3BkVEVzclFkeGFuejhSWURXWkFMQ3VJelV4SlRRNmZR?=
 =?utf-8?B?Q0J4dXVyd3BQNlB2WUNlQnREektJdnZXSUJRNEtSTHZLK3h5OXpsMUxNVWg5?=
 =?utf-8?B?UW1IWmJRWDljMjNLQ3YvMCtUTFpGS2xRMXNna0owRFV0QjNYanROQjIrdDZ1?=
 =?utf-8?B?ZldWcEhmcjFrd3A3eFF5YzRmMTl6aVNRZ0x4R1c0QXNGY3hzODFtYlpSQndZ?=
 =?utf-8?B?UHZwUTlNZFEvY3Rwc0lBdUdOQVdQVEtaNHo3MWpBZldBZFF5S0tjS094ZGxv?=
 =?utf-8?B?MmM1UUlyeDNSRVptUzY4YlYvMm1JUlVTOS9lUTc2SytkbWpHR2ZGNExCY1NH?=
 =?utf-8?B?R3A5RHlLbkZKdUVLQ0c1Um53QUgxTGxxUWk0RXJOVVdwcHZPdFBMRjRTSUJp?=
 =?utf-8?B?anprOGFlOGlUMkVSUG9Ea3FCVEFlR2JkS28xTU1WeENnMWtQWklqSnR4dWlU?=
 =?utf-8?B?MDVQR3lPcEJKOG56bFJPMGhuRjhUdkNWR3RSR2gwUXgyM3hwWlJjQVVoVGhv?=
 =?utf-8?B?UDBkQ1pZM1BMZlFJK1lra3hYYXBwWXNMTjZRbDNtcm8xV1hKOVJhQWRrdlRx?=
 =?utf-8?B?aElEVHNXd3VRUkhwQmVZclhLTzF1V29yT1BNNVdOQXNxbWM1WmVzeDg2RGw5?=
 =?utf-8?B?T1BLMnJLNFhQOXBjU09CdFV4dHZXclQ0N3hxeUFGV1NSRVM2dUdBd3RrNU9G?=
 =?utf-8?B?NEt3NVNmTUhKbDJIUC9TY0JEUFp3Sm5meWpBTDFWUVNTUGl4QmRCS1VUb3c2?=
 =?utf-8?B?dlZnNFp0RGJwNkRQdHFlSjg2MTR5T1hHK2NJcG1qT05qQStEWmdiKzVzOGFS?=
 =?utf-8?B?RHRUakd3NklJZmpnS3h1Y3hGQWkyaVZCSjhQOVl1MGJDb0xzOHp5WEUvWU1v?=
 =?utf-8?B?L0kxMG5mdWtjR0tjQlUyY3pEaGVFY08vUGREZjdKcmtkSGsrbFd2QlNSUU8y?=
 =?utf-8?B?ZHZJQ05la1NuY2t0MVkyK2syeXhrWmxSSHhmWmdNelVldFU5VldRK25hS1Zv?=
 =?utf-8?B?YUZtVkltMzN1SjlVZDBtOEVsMUdaK3kvUVVFUUJoRUh5djIvMDlIRC9XaHFo?=
 =?utf-8?B?cjNneVkxVWl1aEdleERtRkt5M2prMS9BZTFXMzRZQUJWT1FCRFFza0NoMlVk?=
 =?utf-8?B?bGNDa0ZGV09DT0VpS0lSNklIbklRa1NDNk5FaStFaTUzR2pWQjJmMVVOSTZn?=
 =?utf-8?B?VXZUaFZ6L3BMZGk2c0NjRzF3V0krd0FJWUJ6Q0orWCtUTjlIZ1BIOUlXSlNn?=
 =?utf-8?B?VlJ5d1F1K1ArbU9QaUlpK1ptK21NTytkVExSVlNKa0ZHWHNaRmNOQmlUdkJv?=
 =?utf-8?B?TE5OdGx3aW1jcmRSRnlCN1RUSTNpTmsyeDRwT1Rwa1dFWStUUUVIWDU0NXlu?=
 =?utf-8?B?MGtrN096UmdJNU5IRHU1SG5hdUc3MDhhYlhJQ1RtYWpzWHZvQndIanRNWW5G?=
 =?utf-8?B?MVUySGFZWm1tZmN1TmxRYWlvTVNDNXN0VVBSWU52MkE1Q29ScG5XbnM0U2o1?=
 =?utf-8?B?cVA0dVRoQjlja1BYQnZQRTdWVmszT21CZTZKblowZDhHaGc3NEhoVHJSNjls?=
 =?utf-8?B?WWRtTm52Y3k1cUJOb0R5NER3eHhockV6cCsrZXdheEJUcmgxT0gwVkhNQ1JY?=
 =?utf-8?B?OXQ0eFpyL2tPTk02dlEweThoOTlJeFZPeUJmUGlMUjJyWnJLd2VuaVh5YXIy?=
 =?utf-8?B?eWFCRDJEUWJGUjduQWNVNUxrczc4NkFyYi9uekdjRkxNVmxqVmM2OTZXZjM2?=
 =?utf-8?B?MDFkYmhjVUNkTHRHVUJ3d3U2UGhjUDAxeVNFSDVBblF6MlRPeW1VMWVOdUh1?=
 =?utf-8?Q?wEam9gAa3gcNvaXomCfEVTfLWcUbavCYhjojxqIwIuk3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18BC59252655ED4C92C04EB1EC221205@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74e28ef-f491-4ec5-9496-08db1adb1afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 05:00:55.5484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvnV62Xk6R9Oy1752YORqUku8o7iReVfce9OjrTUuntR8oUwWXn6K0y7fs2F0hPoWoH3DPxPNkKKGC4JupJXJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8yNC8yMDIzIDQ6NDUgQU0sIE1pbmcgTGVpIHdyb3RlOg0KPiBIZWxsbywNCj4gDQo+IFRo
ZSAxc3QgcGF0Y2ggYWRkcyBvbmUgbWluaSB1YmxrIHByb2dyYW0sIHdoaWNoIG9ubHkgc3VwcG9y
dHMgbnVsbCAmDQo+IGxvb3AgdGFyZ2V0cy4NCj4gDQo+IFRoZSAybmQgcGF0Y2ggYWRkIGJsa3Rl
c3RzLzAzMyBmb3IgY292ZXJpbmcgZ2VuZGlzayBsZWFrIGlzc3VlLg0KPg0KDQpMb29rcyBnb29k
IHRvIG1lLCBmZWVsIGZyZWUgdG8gbWVyZ2UgaXQuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEg
S3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
