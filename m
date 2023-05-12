Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EE8C77B7C
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 08:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbjELIek (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 04:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbjELIej (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 04:34:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DDA4682
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 01:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXuWnUfdc41uxuLrF8CwgWss0A9zp7w5YjBkEsYV48GtHpAMSkTf0UXbwFU0vhXeZtRiZHxiRvELogIe4F9DCwFjW9tceX5Y1jOgvFcPNXL0buwAhXILhqWTKN/JiSCQTk77Og0w+hzZl4v9Y5F26zeY/6y91tpnz4dKmiLKKqTv5PTvlFC4MoOxMZvlXgZOe0pQwqoxsC4WfGtYSJl6ACMgavwrj1g1BHctYAMaaMC5h+YQdKqQ0XNlp889dLVCccMspkLJ7478nnmihIA2QZtzNMQJNubGrY7Z4Cz6PRoXFHAnIkxyz1YHruRuvxEt7O+uT02N7bVeDwe8SmaL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ0HbQuMkMoja3f41fTNFftu0gbtwzOVa15LiYODHMY=;
 b=Lu3tS2T5OycTmcMOwiZ1pOYETMjIKpoUVwbqw1eDzo5kdVJTZSbTJSv0g/ND+rCG1141I8HkQ8i55UPmpBpaaQyI0ZcUXPu2/WxgbVW+TYcT3AL/EHk0sW7dIN/ON8wmCin0Kh0OdriNk436sttZ2qeqMOqmJoLyHywe0ZZ2vLr83zAXW5tkTsGl/5L64pNlpNxEP0vMbeUGl6Zxr0YOF93jJrXc8QZmQLAZUgIPTUfXtAq0YEjU30RxwONTmoUqz3L334Ex6DIurQ/2DdOk4ULV4VB+p2a5MNSXAxKLgjyZlQxLHIcudDSY6fEueWLWbgEgTC5PavSuIzEppnM3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ0HbQuMkMoja3f41fTNFftu0gbtwzOVa15LiYODHMY=;
 b=JzO1tDpOgQUBgJmW1bfmVZPUHXkBuM7iPPupKYiXvFztR7TpWoilnNXupuGLJLBMSrsofnjX2CVzpdIglh/Vmwc6g3oIHnHeecWDEsKAn3UXfsUcHUBy9rrNXDKvqQQybbHk4gj8S3aZWBcx+SqM60k8gELiBMfrVKCAMwQCCvUr4XZty8nMTLzIl3g0eCFAbG6llR+alsERIBQCiRNg/DKJQSls2uQ2BemxFKP5Q37y/GfuktqlDKKg1VYZlYOuUjFgSwgOqmn98hOukp/tGICyEKN6J7h6xzxboWKrHpKBjHi6y/Fre/RJNIavzDwSdkpV+teG43bl93ERschVXA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 08:34:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.021; Fri, 12 May 2023
 08:34:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "willy@infradead.org" <willy@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] brd: use XArray instead of radix-tree to index backing
 pages
Thread-Topic: [PATCH] brd: use XArray instead of radix-tree to index backing
 pages
Thread-Index: AQHZhAM6arOvckiW302hDIuLZU+lkq9V15gAgAB00oCAAAS2gA==
Date:   Fri, 12 May 2023 08:34:34 +0000
Message-ID: <19a880f2-9c06-c096-9a76-a30552bfbc78@nvidia.com>
References: <CGME20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1@eucas1p1.samsung.com>
 <20230511121544.111648-1-p.raghav@samsung.com>
 <bf2daf76-ebfd-8ca2-0e40-362bcaecfc3f@nvidia.com>
 <b45b3578-857d-a13b-6fdc-6ceb178ddb84@samsung.com>
In-Reply-To: <b45b3578-857d-a13b-6fdc-6ceb178ddb84@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5097:EE_
x-ms-office365-filtering-correlation-id: 25c3a37d-8080-47e3-18ed-08db52c3b6d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aqZQJj7RP2bDA+cNAUPSjjSGPiMErM91Rl0nagCweKZ+tYLQlU0VDUVpI60BTNDSO9cgdK5j7HEsHbyRa5n+mcZsjD2drUcMuUwT3L81cX70bH8NoPTRxbCJRD2d7Iir7IJsYwCks2SmYWv2K6f3c6Ar09dKZVrekZQ1msvLIBE7MCUVm34SbzMQ2WkizeomvE5rZLXt8F9VlBhRaubi9LTnMfk8OPxL4U7sv67nChC0qPLVfbALIre7xa36jye+h5MOLB4Wz73FWtWoTg6VLUX8PDXgPBdA3SyBm2YuykMWLzlrf6ne4VJY8yKIwWP2mWx02gUC153sGerVc2VUcaBt9qaQQlFhprK4cXvfSDGdEi0y/Ony5F14F2PapZgO6rn9cqYJ5m4pToqh/AlegTt2DBGXbtS60cDxQNWB4oslunutu8JiScxbDQ/iWRkX3mb21dIxG6X61iPneuJ/ZMWs7E9caEisJ7lAUWCq8uBeA9k8gLGcIJJAzGugpTu8DbhtJg95bWQflL0TMt3SuFrUeTRragISVyx65y/nNET8byzTrjYf7ghy6/4k0tcjtnb0RY5lryrOuB4ODAWYj4aPZOnTF6+J7kVNdYYc1fbgi5eMjtmD/o56Zcoxa57YHEJyjKHYQlkEOJqZxUWE3ZMx+Ojw8u/Rt0ulUH0k7BXGaGpoidahok9sE5J2ypwL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199021)(36756003)(31696002)(8676002)(8936002)(38070700005)(5660300002)(4744005)(2906002)(91956017)(4326008)(2616005)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(41300700001)(31686004)(83380400001)(6916009)(86362001)(316002)(53546011)(6506007)(6512007)(186003)(478600001)(54906003)(122000001)(71200400001)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVhvVTY1Y29yM3NCbTN3Y1NXb3RwRTZoYWcwcGhodFRxbjFLK2VEOWVvMGdZ?=
 =?utf-8?B?U2tlb1JBbktTVmkveHpLM0RYUU41THNPc2tvWngreUJQenljRUdpQmpGSU9x?=
 =?utf-8?B?S0lkOStFRXhFL0ZkQ3RCQis1RTZGOWxoSUhpQmQxeWllcHVmWEV1QjFWdUJo?=
 =?utf-8?B?U3RnY1ZSaDVaZVdOU1lIQ1FnR2JkY29Pcm9pTWlCSG9ZL0xteEN3MjJpVU8z?=
 =?utf-8?B?WjNhUjRCUEh6V2p6SGhqaFBrT2FPM2RNZGN2UEVvWi9aaTdrb2tsNHVaL296?=
 =?utf-8?B?SFF3NCtON1h3QnRzUC8yeTk5UEVWUUtCWGszNzRsZDFHaEVVajNYOHZtSFRn?=
 =?utf-8?B?dDQ3alBkZW41VHpRUEsyVDBvSC9ZQWx6b3owY04yNmdzUjdURUliWGQxZ3Vq?=
 =?utf-8?B?YjlaZW53Q0JKVDhnaTlCY0l6aTVDcHUrNUpXRTVNUHNyRE5IU2dON2x5N1Bu?=
 =?utf-8?B?emJYUmI5c1hpbnFiblY3ZzM0Yk54SWdpbjVtaFh2eUoxaXpWQ290cVlWc2ho?=
 =?utf-8?B?UTR5b0NsVjdDT003Z3hWU21ZQjVPNGhMenBZd0RkVHFBMjRYTEx5TDdaL0lV?=
 =?utf-8?B?UmtOVlRDc2RUR2crSDd3RlUzRUp3L3JXUzVFQmZuZmk4cGJIMHRKdHY5UWtT?=
 =?utf-8?B?QndOakM1R2pMMDhWNDZqZXR2V3FtRmh2OVh5ekwrYi9pbWNHUktVSGJXZzlk?=
 =?utf-8?B?YldwZExRVjBmL0FHTWhvaU9YQW1NY0trci9rMG9ZQmd4aFBuVTRqNUdTekNk?=
 =?utf-8?B?VCtpcjB3Q3ZBZ1BUeWVnSHJ3TGVwMTQzVHA5Zjcwa0RzRW9nNXM1Z1NQZEtC?=
 =?utf-8?B?SURFWm9Vd1l0UFdFSy9wL25MZExRa3RwYkIyS2I0SDhzZGZCQ0V3QnFtaFNY?=
 =?utf-8?B?TDlhekkwcEdBT3V3V0NtWDJWL3ZmSCtEZXZLM3FiRlpUM1ZoL1VWSWU4Z0wy?=
 =?utf-8?B?eFRhV1lWakNDZDg1UmI4d3JPd1FpVVpGdG1oVlBMRERtZ1dFSFVObGlwTmtZ?=
 =?utf-8?B?M0RpU2grMW0vekxVVHFvSFdDZnZKN1BIWU05TnlHazRZbEpFL3hMVk4vOXpE?=
 =?utf-8?B?dGZVRE1KUnU5YTNodUh2Syt6VFJtNnRFbkF1MTQxU2Vud3dHU1pldWRmeHBQ?=
 =?utf-8?B?cFhGaU9udG5SSkZqWnAzL3Z3aGlDeXFKL0hlamJtVnJyUkkvK2lvVlF0djMx?=
 =?utf-8?B?NjhlRkZtYW10OG0xa08vVDJvZXVzUkd0RjRaRDBNVjVpbUdBWlBObFF5bG8z?=
 =?utf-8?B?RnRMY21EdUNlUGJNanEzeStCK2lyMlFkcHkyVGJJaWVKbklOeFkrQXppSXNo?=
 =?utf-8?B?MFhaeVREb0tCd20ycXFCWWx1RE9nWjVDME50eEgrV29hOXQ1Wmo4OHpRNHc4?=
 =?utf-8?B?MjRJNExuZVVxbFo5SUs0Vkl4V1YxUHZickZ5TUI0TkpCczdJb29OUFBGSmcx?=
 =?utf-8?B?VkovT3F2ZjBxU3ozVGJyTTVzY0lQK2FDMEQ5clNweWNrVnROTVpUbUhlZTZn?=
 =?utf-8?B?UVdNVitCVlJPZ1ZVTzZHUS81eFNnMDlERnM2dlFYZzFqamRXNjdleS9CWmE0?=
 =?utf-8?B?aVkxY3pQNFljc2lZRnlScUk2c2g3WkMrUHJHc0tReHlzTTVlbWxsaXpTVlJ2?=
 =?utf-8?B?RmRrS3B1NDZHVXJvWlJuZFYwZnZQQzdTU3VYTU9XTUc3ZXFocFpIVG9MT3o0?=
 =?utf-8?B?T2Z4cnRzcHNtYzZFZklQWkJUcSthL1h2eGtpL282Y3BML2JpU0c5em00MWhU?=
 =?utf-8?B?aW92NHM2WEs4YWxpQzZwNjUzK3E0MmVFY2krUHVWd1J0RU5HM1Y0T2Zpanpt?=
 =?utf-8?B?ZDVGRkFGYnh6S1F2WThkdHJuWDV2S0dUUXJYeFBDSU5rS0JwK3pPaWRLS0dS?=
 =?utf-8?B?Y045N0ZidENDVHU3OHpmb0FjWWVkSTkxaUtiOW1xbzZydENIeTE0YTUydVF1?=
 =?utf-8?B?RDh0dWdlNnZQekg0WmVRaWhtN2hDVzl4UlV6Y2lTWExHQ1g5SFZGTjVpZ01i?=
 =?utf-8?B?NXVWS3FtL09aTDRCeEhmbmQzL0dWVGovSVNiNmFtcTVJeEMxaEFnek44bWpy?=
 =?utf-8?B?WnQ4NXRQWjBJNmJoWnI4TWtvVU84WUt6STVTSGwyUmlLU3lVWGtRRG1ZeDI2?=
 =?utf-8?B?d1NKN1o1U09EK1RHQktkajF4b2RrTkdieVRHekhUS0RyMVVDVEVudURFS0xm?=
 =?utf-8?Q?hpZc1K4Ac3Xh1MfW0HGs5P7k6aYDrMIouwpk4LC7Fzfr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <123D56621D1C8841AF9795CF827E6B54@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c3a37d-8080-47e3-18ed-08db52c3b6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 08:34:34.1735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xi4/njM+ouFmAOOvz4+rkwOBcauaKYlseFvECndZ5/8PGERGSizEJsZEgIXTnAe9yon2/niGQCyPiQUh/ilgmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8xMi8yMyAwMToxNywgUGFua2FqIFJhZ2hhdiB3cm90ZToNCj4+PiBbMV0gUGVyZm9ybWFu
Y2UgaW4gS0lPUFM6DQo+Pj4NCj4+PiAgICAgICAgICAgICB8ICByYWRpeC10cmVlIHwgICAgWEFy
cmF5ICB8ICAgRGlmZg0KPj4+ICAgICAgICAgICAgIHwgICAgICAgICAgICAgfCAgICAgICAgICAg
IHwNCj4+PiB3cml0ZSAgICAgfCAgICAzMTUgICAgICB8ICAgICAzMTMgICAgfCAgIC0wLjYlDQo+
Pj4gcmFuZHdyaXRlIHwgICAgMjg2ICAgICAgfCAgICAgMjkwICAgIHwgICArMS4zJQ0KPj4+IHJl
YWQgICAgICB8ICAgIDMzMCAgICAgIHwgICAgIDMzNSAgICB8ICAgKzEuNSUNCj4+PiByYW5kcmVh
ZCAgfCAgICAzMDkgICAgICB8ICAgICAzMTIgICAgfCAgICswLjklDQo+Pj4NCj4+IEkndmUgZmV3
IGNvbmNlcm5zLCBjYW4geW91IHBsZWFzZSBzaGFyZSB0aGUgZmlvIGpvYnMgdGhhdA0KPj4gaGF2
ZSB1c2VkIHRvIGdhdGhlciB0aGlzIGRhdGEgPyBJIHdhbnQgdG8gdGVzdCBpdCBvbiBteQ0KPj4g
c2V0dXAgaW4gb3JkZXIgdG8gcHJvdmlkZSB0ZXN0ZWQtYnkgdGFnLg0KPj4NCj4gVGhhdCB3b3Vs
ZCBiZSBncmVhdC4gVGhpcyBpcyBteSBmaW8gam9iOg0KPg0KPiAkIG1vZHByb2JlIGJyZCByZF9z
aXplPTEwNDg1NzYwIHJkX25yPTENCj4gJCBmaW8gLS1uYW1lPWJyZCAgLS1ydz08dHlwZT4gIC0t
c2l6ZT0xMEcgLS1pb19zaXplPTEwMEcgLS1jcHVzX2FsbG93ZWQ9MSAtLWZpbGVuYW1lPS9kZXYv
cmFtMA0KPiAtLWRpcmVjdD0xIC0taW9kZXB0aD02NCAtLWlvZW5naW5lPWlvX3VyaW5nIC0tbG9v
cD04DQo+DQo+IEkgcmFuIHRoZSBhYm92ZSBqb2IgZm91ciB0aW1lcyBhbmQgYXZlcmFnZWQgaXQg
YXMgSSBub3RpY2VkIHNvbWUgdmFyaWFuY2UuIEkgcmFuIHRoZSB0ZXN0IGluIFFFTVUNCj4gYXMg
d2Ugd2VyZSB1c2luZyBhIGJsb2NrIGRldmljZSB3aGVyZSB0aGUgYmFja2luZyBzdG9yYWdlIGxp
dmVzIGluIFJBTS4NCj4NCg0KUGxlYXNlIGFsc28gc2hhcmUgdGhlIG51bWJlcnMgb24gbm9uLXZp
cnR1YWxpemVkIHBsYXRmb3JtIGkuZS4gd2l0aCBub3QgDQpRRU1VLg0KDQotY2sNCg0KDQo=
