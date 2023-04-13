Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC37FC77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 01:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDMBa1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 21:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjDMBa0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 21:30:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FA340CA
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 18:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOCpJt4aToPTzctizUKE52uTjr4XIMPYsSxPTqDNha7Asi7J8ojgKAWRK+C5ZEhX73l2l+Bt8ziHey17/5iEYa07BztMr9EbX3mL8PXZI2NbvQ73J2upRVvhchb3grKfV+O5bV4ExZNEeQgnz/5T7cQRDIgT3nNuLBzHEJxVQVoUkPHSWKOFAEXMP3TIJBnblpaNhofMNOyViZi4Bv1rowed8ELayR2J1R+Nf60LMm5c9ONv7is5Ij01Klq9x9vMie9wyXwWdOJFAo7wfTSCTFFSdpkaAdJwkTd3s5drSguSC98Q0fO2K5VKhEfrBHmR4eVsfFOkr+TJu7fY3px5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+2HqEAA7pXUI2ayxgENl46TOm43BFxmK2HcDRMs7KE=;
 b=hWbwWpUBgg5XxUSJPIWuGeCMhtPF4FyH9HmqUJ562oes32nM7AqudEuPRcIGhoV7yZtdi8/S8+khe2jzQXTrIXzh0BMwzN7dldjOCGKFYdoRbdc8ed6jqt4RqyP0ybIMw/ByKnU+rYYdtniaVs8i+1iuBys0MoPcfN0DImWwIQMLI6M1DM3Ek2RE7dXNJBy0KiwKkX9z31fsewOHbjnehkuwK9a7FxAGjtY0VU4awSHFxDTyJ+EHfFAfR5a6X8OyseTJEqYTMmSNaFnbb9K6pSO/TsH3QfLcueG8LxMkq/JPEq6/6wHyaiok4FNa3dVqjw5f2YoVYtws91aduclVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+2HqEAA7pXUI2ayxgENl46TOm43BFxmK2HcDRMs7KE=;
 b=IUheq8/r81aZOhUX77As6niOL6PENjhgbWuGvszXTiTTqPBbv2qYO7qnoveKLRD1vzJhvi6uslL9wl1M3tQNivNkH/r8TZ8meLI5ThRVWRr4xmu38oZz58Rcgo+cxyaZkTJRh2R7EcyRKvhvzbtGuI5BP8YK5Df0WrOwszfC+v5kFsengMVbZiN0u/8dxr1fCj6K8ytcVGg0JBnWvkyg3Z6tcIbWzw80AswtOqR+Zt41TewrBlJr/HTJ9DbYrTPt1QOL18aEbVIAMmeJdh+Q6+HkcO7o2xa/pyWcK04vnr+ipei5237Cm89k6KDvf3816D3iAmpDIloRc8hxYCjB5Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 01:30:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 01:30:19 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "error27@gmail.com" <error27@gmail.com>
Subject: Re: [PATCH] null_blk: fix queue mode Oops for membacked
Thread-Topic: [PATCH] null_blk: fix queue mode Oops for membacked
Thread-Index: AQHZbPR8kNoMvVp34Ey+RDJEhoKaG68nZTwAgAEP3oA=
Date:   Thu, 13 Apr 2023 01:30:19 +0000
Message-ID: <d923827b-45ee-8a08-edc8-ebd7d0dd108a@nvidia.com>
References: <20230412040827.8082-1-kch@nvidia.com>
 <CGME20230412091807epcas5p10b99767a999ded5789cb8ffce2189394@epcas5p1.samsung.com>
 <20230412091716.unhpznj4gzjjfehj@green5>
In-Reply-To: <20230412091716.unhpznj4gzjjfehj@green5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ1PR12MB6289:EE_
x-ms-office365-filtering-correlation-id: a9168bd4-1acf-432e-cdd0-08db3bbea4a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sYwTR7mXFWzUtiPR9J7J239hqKbOEQaSmS0lYP726qSVPcLrpapAJlpOcu4bsGO3R/Z1zAy8OYZ6BJH4HILDNJQ3/VcKEVOOr86g3H4t7DnOif6KkcWpfWhuy6l9ejHjRxB5EhuvQN41jFNlHSsqOemKueHNWDV8eUgGW9PyEpBX6h3IHsnJ3oDulYa013ZhdUbTNcrCvK2qEixPUrHwrbLL3++BYOCD0U18BSzWQ8kNfQ/Ddv7NhnWhljJFu4AQsddW9vVTgg6lmn3PSTPgJhda7V6UCq2yjDgNx2LVO6u2t1IHBABBt/QodVL65StICAU93oVDg0pwLmMPT0MSuG67FfMaGAH0A63cyte5dSXj50sfiUbZ1ONF+TIN6lUeCd7L8zrtgShgbqQanuwAzX1qxZMKFU03FsBsH3juB+2cQofI7tgvYbTPsrs4LIh2qrHXjPTPrBeCx20L6ytlRfIk6wVHZ737x9qfLO2qXOF8KPJbiSLAK5U7kF8LHb/vDhrakXDRGR6KsOFyXFwGjnH38H+zvhRNT+YctsJeByzL4VW9Cg1E8ap9b/Id1OGW33HCl3NjQGiFhQ9ctV06td9tgQSmM+6YejMbYsApVmn/Q9UnwlVN0xu3aE/mQDMYxWZolnAZOwNfn7cYjQY1DgymbUGE1Wmqzc3sgxX5jssMwk7f5k9M1AHYDkIbtKaG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(38070700005)(6512007)(6506007)(186003)(53546011)(54906003)(478600001)(122000001)(2906002)(8676002)(8936002)(4744005)(83380400001)(41300700001)(2616005)(5660300002)(4326008)(6916009)(38100700002)(316002)(66946007)(66556008)(91956017)(76116006)(66476007)(64756008)(66446008)(86362001)(31696002)(6486002)(31686004)(71200400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3ltK2NGWmEybUpsRTZmdFc5NWFGOERqQmNtWUFBMGl6T2QwVXo2S1gzR29D?=
 =?utf-8?B?YW45QjZ0TCtma3FrRTdBbjFZbGpEc1dyOW83S3VQc2VTa2RyYVJGZXRIbnB2?=
 =?utf-8?B?NndRVGVLRktyZTZBYUljUmpsVXpYQWVOanJhb3FHaGZQRkVhdXliVjByb3U5?=
 =?utf-8?B?d3ZXK3hiS3RiTVJPcGVMejVPc2loZmFrVkVpSXdoaE5hM0RGQkJrTGpFR0hS?=
 =?utf-8?B?cEhSeW55b0JrY293NDFxK3NucDdYdGdSUlVQdnZxWkxaUGFhbFhPaUdnWHRz?=
 =?utf-8?B?L2lXUEJWZkZPbXgyeU1EbVl0ZWZqaEs1UTFVbktBN2ROdlF5MjBLMlB6c2RQ?=
 =?utf-8?B?cXBHUUNtTHZRdlQ0YkZCN2lva2h4ZDJ5aFp5MVRuMk1sempoRUxBSW5nQkpi?=
 =?utf-8?B?TDZ4eVdmNnZpdy9MbzJoTkVrVEIwWlp4cDZzbmVwOU9XV0IwR2hneHV6SlNV?=
 =?utf-8?B?OVJnMjFYbHhvd2FyZ2NEdDVqbHRnSytSTUU1QSszRWh2MWYwckxvaE9VaEo2?=
 =?utf-8?B?TVlKVGV2VGJCQ21LWlc0YTlZWkF4OTA0NHdDcmNoSEs0ekFvYUFwM2ZKREx4?=
 =?utf-8?B?YnZ6TGI2Q0VLZjdTMDdjZ1BvbVpsTVIzcndDMUNsZlpIRXlYYzJDaUVUZ08z?=
 =?utf-8?B?cndyUkxnZUVVK1dvRkpEV1M5M05mSUxpOERESjFQM0tyMTM3VTA5NnZyVksx?=
 =?utf-8?B?bEdQc2hIdTlOdSt0QnEzcW9LaUJyS2xENHc2TmZwdnZRU1RtZyttOUNLMTRT?=
 =?utf-8?B?OHd1ZkNSaFRUOCtvYm1xYWdBOXVZdFNUV1l2TkN1bXI3aHJhTnRYa3VvQUI2?=
 =?utf-8?B?TUFxV3lQT25tQ2RCZ0l0RkxVTGptUSt5SVdrZEQ2UFVZMi9XdzB2UmduMTly?=
 =?utf-8?B?Q2FPQ012cEk3eDRhVWRWcDdMeHNQM24vQUQ5YnlnL21KaGlsUXpLcFYwMnBk?=
 =?utf-8?B?TGhWMGQ5VDFsSUxnWjRDNUhhT3VqTmp2cFJDbjluREdjVy82WStJeEJYRTVh?=
 =?utf-8?B?UmNtMEZLYml5bnVSWEZVRm1waWQ3SklidnBsdVZhZTFnSkV2QXNBcUd4SVo4?=
 =?utf-8?B?WG5QRm56SkgvMjdFcy9YTDR4Um9ObFhIanhIM3NXNm0wSFVkZE9CTU5EZHhl?=
 =?utf-8?B?ZzhHNHpjM2RCamlzMHlnaVJkeXgycVQwNG81Y3kxeExaV2xVY0YvV3lPb0E1?=
 =?utf-8?B?OFVPSCtGRTdmMm5YRWcrVmVpTjd0T21YWW9OUVB4SzVoYlRPdVQxU216L1Bn?=
 =?utf-8?B?dDZPVXVTZERVbmRLN1VtMEQwTDlXdHNvbTlLUUhVVDAyekE0UmhmQjk4Z0Vj?=
 =?utf-8?B?dVVwbUl0eHhSQ2svSGdiRllUN0I4dE5Sbm0wejFCVjdvNFJoeVVLNWM3MkhW?=
 =?utf-8?B?N24zSWtUZWVFVlQ4NDdUek4zVGF3eFRibmk3ZXBteExUdUNMS3JwN3JqSTVD?=
 =?utf-8?B?UU5QUGY5RnQ0N1N1T3N0ZGdYcE5KanhBbEF1V0pzVHpMdGU4UDIrMGtpUUxR?=
 =?utf-8?B?YmdhOTBwS3hQbDBWWjZCOFNwdGNlN3pJR0pvYzVSa2ZaT1R5RVpuTkNZMnFi?=
 =?utf-8?B?Q1RuNElxYVJhOGFmQkhPZGxVN2tPSExVZEsxS0NYeUdBSmlxcWxYR2JlbXpW?=
 =?utf-8?B?VkFDeVlIMXZtbzNHRVJvQ1gyZjU1WUg1SFBkS1RhUFJZZHFFc0xTWFM3MFk0?=
 =?utf-8?B?Qm9tQlZkeStKNDBnSkVKZ283aExuMm1SallkanVUOWFUNWR6c2NVRVBvTG5L?=
 =?utf-8?B?dGRKem5jRytpa0tTMkpzRGdtRkwyVzBWdjdBNWhaaW45cTZjQ1VWQmdLTm1Z?=
 =?utf-8?B?YTArdGxobExSd3ljKzFReEQrejc5L3V2d3J1R3lPSWNMSE9VVUU3RkpRUk9V?=
 =?utf-8?B?R2FKOEd2all6QWVPMFZFMTJaUThLYll2OXd4OHRBS1l4bUI2MUducmpEbGRi?=
 =?utf-8?B?ZTlyOGRleC9ibHk3NWVnbEwxUmh5M0toSFduOGw0ZkhoL2VaWnM5SXVwOElo?=
 =?utf-8?B?cFJteStEV3duVUNIbzNlTzVPNU1PanZTTUNZMU5BY0hVUmY0TG9DMjlDcVA1?=
 =?utf-8?B?REVYalFkNWhLMGRINXp0SmkxTFhXZWFROEYrcEtLRHFCMTNqK3UzZTd6VjA2?=
 =?utf-8?B?RGpKRENmbUJOVHgrWWNMeGp4NEcwNTkrY2JYSFROTkh4TDJKSkpud2Y2bnhk?=
 =?utf-8?Q?rsItPqjUddJ2JKiy30YhfbdGjQasKMU1uLWpjvDw+a7T?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C04AA20EF7B6864D9B9305D7111743D1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9168bd4-1acf-432e-cdd0-08db3bbea4a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 01:30:19.4730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8WZsGXMq1/7irTv0smd+2J9hqV9NONXYM/QVdoS1rx7gqPiHO0ND4OEdszs5iMY1L4j+mntJ6dt/UTCZ8ABMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xMi8yMyAwMjoxNywgTml0ZXNoIFNoZXR0eSB3cm90ZToNCj4gT24gMjMvMDQvMTEgMDk6
MDhQTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gTWFrZSBzdXJlIHRvIGNoZWNrIGRl
dmljZSBxdWV1ZSBtb2RlIGluIHRoZSBudWxsX3ZhbGlkYXRlX2NvbmYoKQ0KPj4gYW5kIHJldHVy
biBlcnJvciBmb3IgTlVMTF9RX1JRIGFzIHdlIGRvbid0IGFsbG93IGxlZ2FjeSBJL08gcGF0aCwN
Cj4NCj4gQ2FuJ3Qgd2UgZG8gYXdheSB3aXRoIE5VTExfUV9SUSBkZWZpbmF0aW9uIGl0c2VsZiA/
DQo+IEkgbWVhbiwgc2luY2UgSSBzZWUgaW4gY29kZSB3ZSBhcmUgbm90IHVzaW5nIE5VTExfUV9S
USBhbnl3aGVyZSwNCj4gaWYgd2UgY2FuIHJlbW92ZSBOVUxMX1FfUlEgZGVmaW5hdGlvbiBmcm9t
IGVudW0gaW4gbnVsbF9ibGsuaCwNCj4gd2UgY2FuIHJlbW92ZSB5b3VyIHN1Z2dlc3RlZCBjaGVj
aywgYXMgd2VsbCBhcyBjaGVjayBpbiBudWxsX2luaXQuDQo+DQo+IC0tTml0ZXNoIFNoZXR0eQ0K
Pg0KDQpQbGVhc2UgZG9uJ3QgZG8gdGhhdC4NCg0KLWNrDQoNCg0K
