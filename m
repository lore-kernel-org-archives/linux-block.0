Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9A9C77B7F
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 20:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjEPUa1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 16:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEPUaY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 16:30:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430D0AA
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 13:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJgEevyIxG2+mgwFc+/2YUkB+vxQPow2iTtaeECJGoyVNOaPj1Af/jzgE0YjUc7efh7J8V0xxH1bPBQmjmN+Fo1oGeVDwurw4O0SW5SwtegT199ZC4ScabKmg9UnIW9rinhyQltQxyxoIQodU8dcuAB/4Bz2tHEdZMsW2oUlFAVhewPoIcMIeFEUI9BPhThGIxuWVQCTu1nrmPLZRxyblbCuVI11sJ55b/0Aww+8cZXXPhlZ0YegfENoYEMScUh/XpjPwqVT6n2+g1YPdFHMg7D+9IMg4LrpAhUhoQ/0qEyDW2LIlWrY73bMYof9Kp0QZHtT3ZX8vVpUyRxLFYez6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=293BXZCfA+coxauy1yJQ90cNdrNzbYypJy8iJrjfG88=;
 b=Mn7KA9vzt+TAbzMH3zb05ecR0rAK3JpevEhSKEZa3qHFs4+43J8TtYIIuuCtO0+myrcyTIgnjoOqm+05qjJIxPyQqzFNVVbaO/oKQimqt/wzwQKB/MbToVl1gTnXR3qyGvz8RMN3UD4SHJ4Ybp/w3/vmLfT4rmPVcg0UZEknnZBPkIedgIEx986BPnnZGIPJ1G391Mj+88W8mUb9IMjCJRAdcpG73IgvmQm5AfU69upCdr+zEhIW/SK7k9K8qNLG0hOIignUKHyBhoMQjIdFm9VkBMInCBsg6Z2qIp9oH97/NZTJOyLPADPN9Rkh3whGYfeRVBwPyoQAEeaSegVsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=293BXZCfA+coxauy1yJQ90cNdrNzbYypJy8iJrjfG88=;
 b=IcqPb4pQhNM4CinbO76akIowZS5iXI6GRYjJLstP8saDSCQR66mvivU3WSPP9toyy1Rzy4QD3q+sgXNPZqyWRoKQBjtaZ+hzmBULdH4jmzHq2q2l5C8PPCyIZd+oidwwNG2ezGBbtpl2gCbfQ4Y9ozr3y8Oc4JLO7My/LbmL/nPC+iAt+c3iWvemfI/mRYHCOKPizA9Fo8r8+6Wm+VvnMg8D+iepRjaRFb3nY8m+WYYoaqp2nPQLKDcS0XPkhz1tPbUz9wO+m/k12Pv00ruF0vxIfY/7rXR+h/HXzNRUb4XpR4m6u01Qwl8yeXkKsiac9q0/iETMw5pCwgNqEGnScA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 20:30:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 20:30:17 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] block: Decode all flag names in the debugfs output
Thread-Topic: [PATCH] block: Decode all flag names in the debugfs output
Thread-Index: AQHZiByxDDOruFwTlEmmJbKbWn+uta9dWjkA
Date:   Tue, 16 May 2023 20:30:17 +0000
Message-ID: <18c36ee2-f1e1-5052-2525-2d011f0e2841@nvidia.com>
References: <20230516173426.798414-1-bvanassche@acm.org>
In-Reply-To: <20230516173426.798414-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA3PR12MB9159:EE_
x-ms-office365-filtering-correlation-id: 5f479410-4402-4ac1-39c3-08db564c5c7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QsxLQ+imfGdwgIUDl0jaSky85CDWcsd+qAJ5TENs619O+oIOwlj5ZHH69uMyQuCz3tcakwlS2DMaAi6yG1t1ykAkHqILxYrCOhRhDGz2Vqqg1EOrJuWxRmxXjcQhFMde4OxcmhLFq2rejctXRdGsFrfhZepwZBubSc1cc4xytHcvhTmOtSYALCqDtw4Tm+yNjqLVRVhoLLzXr9SrwWS7hox/5K/HO1ZWtKqxCXM+mF2K0RcFAgnH+1UoGwDRrkGH5at9oQKPD/UozJUZvbaiqcYIIGrmKJEkb2mxdL3/y2JAI6lnTZtmw7BMsitUtIAcVF7zQENOkvftNkMBkGmsXhGfJampNWDVDtINmJv2J3cymCjPul45zbk+/gmOEQu/ECX+pDvXFlqZeuZPtX/aFgnQYcvAdltobiTLiAmVb8qzvUMh6xFVXPcFXUDo5nFgXdlNIwMDWO0U0Ifj2IA9YwY70aiP7Y4nO3FcNmWsIxiCDvqpEDMN43+JMo84odYM9C22Ki1l9nO6TVCAna+Y6J0oBCVVvx7m00WMxcMhz7QPrRHJoRgwX/DnvO+TCSQMp+GQ06RxgHYrnBEvmfqWURgWTz8hgQkX/J7V5tAESFOgsDvR0O+8ohVPqVMk0nYeS5sBBKlIJyFZ1ZO6n6ndc+9b8FpYLnas5dcUEaB33xKmyJ9exfPv3luydcYjwo6H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(86362001)(4744005)(2906002)(38070700005)(38100700002)(8936002)(316002)(41300700001)(122000001)(5660300002)(8676002)(36756003)(31696002)(71200400001)(478600001)(6512007)(6506007)(53546011)(186003)(6486002)(2616005)(31686004)(66446008)(66556008)(66946007)(4326008)(76116006)(66476007)(91956017)(64756008)(110136005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2EvS3NIdHQ5TjUzdFk0RU5La1dYeHordTliYU1kU2R3SnRSckNZL09pYzdQ?=
 =?utf-8?B?a1kyaTZVK0tGRHQvWC9nSkRydHJrMFFPQ3VWczdwMlVMUW9KY0V4NVUxaW5B?=
 =?utf-8?B?Ym5Ib202QkNUZmRHaTUwbHU3aU4xL0hGdWI1SUdBeEdKdWVlTXRlOVZsNkNi?=
 =?utf-8?B?SHJKd05Kak11OVBVeUVqT1luTlhiTDJ3MnZuQW5sYktWcjQ0OHpGVzdzL0xG?=
 =?utf-8?B?dTN1OW5nTXRsT2ZkKzc0bVFuRnFEREdlZERubnlPdUZXUUNFRGJSWGlhbm9s?=
 =?utf-8?B?ajVFOXh6bXdOY2NuQ1hMYXRUYkNkTnRQMUxDMlVuN3RGNFlJRVBiREV5Y1FZ?=
 =?utf-8?B?SFhURXhCZUxTMUJ6VzhBcnJxOUFxN1NSRjB4d05hTVprWjZDSEdyaW5MUjl0?=
 =?utf-8?B?Qmw3WEdFaThLb1p2TythYTkxM3FyLy8wK0I5cFA2SmZ4NllaOTlpVm8xQjh3?=
 =?utf-8?B?SlFqclhYUzU3OHJKNDU0QzRkRVprNUQ1STlGNU9xY05ZenF2a3J2R3JieUdx?=
 =?utf-8?B?MXBxbkdNREZvWVV2TFBtcjhMRUVxS2xOZWpYN0dubDhlL0ZDL1JKU1RQNG9L?=
 =?utf-8?B?UVp4N05ORDR3RmFuZGtHQWJIelk1WFFJSjk2OXRIQ1pWZnAya2VEYzlkc1pL?=
 =?utf-8?B?L0ZhZGpCeE1DSjF0a0RYZ1NYMmdRYjVubjFFaXJXMGV6VStQelFpNHBLS1Zy?=
 =?utf-8?B?MUxSRG9sUm4rNW80dVlMb3ZuR0dUMEpncUNzMjJMdnBLVDVwdTQyOVZ6MXJs?=
 =?utf-8?B?VDhVdlFHN1BFVWhnVkhseUpTVTI2aG9tU3ZpWEFxSGM0NDNoWXN3WHFqWXBu?=
 =?utf-8?B?MmpjMWdleWxERGphVFZWYjN4eXF2ZWhFMmZUQ1lHTTR6TWxjRFE3N1BwNTUv?=
 =?utf-8?B?NlNiWmwwd2w4VWFEanpoamRrem4yQ0FYcnRnQmhMVXgzRFZIOE5xemxEeFFj?=
 =?utf-8?B?bnQraFlmUkgxeTR5UFdBMjFoU1YvSWVRc2t6ZHEwTHhlOTRCNUxRSm9vNUEz?=
 =?utf-8?B?VnNIQitkUFUrdDJUQVFvb2tTSE9IbUFUQko2cDRkN1VpcDJwbER3YXdhM2Y3?=
 =?utf-8?B?SkYrT2hGNzgxOHF5UTVQb09HMDlBUU4wdmMvUDN1Y1NtRWprVnV2NkM4UDRi?=
 =?utf-8?B?dnNRK2VQL0VkQXZ6RVpVMVNURThWcURtSkxicFlWR0xMcloxRFYzS0JKdzVy?=
 =?utf-8?B?eDBFQXZHbDdKUk9xT3Z4NkNLTmxlL1lMYU5lZVg4OW9FdDV2Rm1SRkpiL2tn?=
 =?utf-8?B?RldXeU9PRC9RdjVKTUlYR0hVcGNyaWN5QXhjWXRrU0FHYkFWUmFSTmd2RXBn?=
 =?utf-8?B?MjNJUnl3R3pRRitnSlc1cysrMmxLbkFGaXFHQjdLeGVkS3FBeUoxcHRVa3lB?=
 =?utf-8?B?Y01MZFM5SG1KWXJ3WlROQUIzQjNTRllNamtuaERFbEs2QzZwQlJDUGU5MnhT?=
 =?utf-8?B?L1hrOFFkUlVsSVhyRTYzcnp2aW9ZS2ozVXV0RVd0OG1PQ1U0UFMzSW5ROHJF?=
 =?utf-8?B?QUMwaDB2bEVJcUUvOEhERjJRb3RCUmpTYjBGVXJEaXpHZk02czdpV1c2Q3Zv?=
 =?utf-8?B?YzJvN01BOVowK2Y3RUhnbEYrR0toRGc5dGw5a2J3MWlsUWJaNFdXRTI4Ly94?=
 =?utf-8?B?anRtdW03aVJ4dEtvRkpBaW41WHY0ODY5OFM5VFBpY1JnRDFpVlJoU3pSTWM5?=
 =?utf-8?B?NVlwYklLVmVuVUZCSkZvT1ZQSmIzM25LbUo5ZkhwcmJMb0xsUHRoRTZ5aXIz?=
 =?utf-8?B?ZHk1WGdabytvVUdHSFBBOURuVk9wajJLdkRzK0lNak1ZSHh3eGg2Sjh4OGpB?=
 =?utf-8?B?dDZkVG56SU9uZ0pzekxUR214WGZtK1lwclZFYURJNjc0NjB5NU1PSzI1d1kx?=
 =?utf-8?B?VDBmekVPM0pYbGRINktkVkJ4ZVVGcEhKa2duYXIzSC9NM3BWTXVoazRIcCs5?=
 =?utf-8?B?K1JUUUdCYjBFbkRIR0IrREFYN1luYi9zYUl2YUloUytMZFR6b1RaYmd0TTFD?=
 =?utf-8?B?aksxUjZlSDhFdUw4eWloRVkwb3doN0RUTTh3YVRCSnhva001bnU0TVh1R3lj?=
 =?utf-8?B?eFpIbDh5QURoWmxaaWhJV0JSTnNXUE1hTVcvSzFCVzRHU1laRnZ0c2ZXelJM?=
 =?utf-8?B?UWRCUEZJdENGNEkxaWdsSVZFa0E2QS8vdllUdlJvRVVFZkRPV3NEaXE0NGFX?=
 =?utf-8?Q?3rjpk+DttUdwzj1RARQE4GzlTkK1BPhIl8q4cNPwF2vM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <142E2A1B1A58FA4E9AE109A683A503DF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f479410-4402-4ac1-39c3-08db564c5c7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 20:30:17.1808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PsumRQtrelMdpSPA9b6C2ffyew2zi3V5NhnwOJab3x8iFj/L9ojg/q4uEPTbw98Wh3yVxW3dp4/a1iyniSqsNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8xNi8yMyAxMDozNCwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBTZWUgYWxzbzoNCj4g
KiBDb21taXQgNGQzMzdjZWJjYjFjICgiYmxrLW1xOiBhdm9pZCB0byB0b3VjaCBxLT5lbGV2YXRv
ciB3aXRob3V0IGFueSBwcm90ZWN0aW9uIikuDQo+ICogQ29tbWl0IDQxNGRkNDhlODgyYyAoImJs
ay1tcTogYWRkIHRhZ3NldCBxdWllc2NlIGludGVyZmFjZSIpLg0KPg0KPiBDYzogQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IENjOiBEYW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9h
bEBvcGVuc291cmNlLndkYy5jb20+DQo+IENjOiBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+
DQo+IC0tLQ0KPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
