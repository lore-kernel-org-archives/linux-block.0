Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695C2C2BA4C
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 05:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiAZFMC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 00:12:02 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:50784
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231416AbiAZFMB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 00:12:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3y0TP69FdzH45whGQOFTdGQgYawPYMJG5bqbjMzsyYyw02lPQorr46Vzy0U0KWBVoO2gomLTmhJzfQrnEKPxF7OAUY4Wn7Wdhbd2WODtNTi1UdMRCkkiO9BcL9L54uuLpAm6Azv7YqMjGLHiEajCIXVLc7XIBadK0Xwo9EKn7D2gZfvy+mGJidLyceBkF1Q6SJc5Mqo5zSvgn52akcVJOjb1YgazlO8XGK3nvaFZuvKmzs7RM2/3QB4qpWiaGInPGN7Z6yvlQ1uxfhv6b9ggT0tcbjypw7tMItI1AiL2olqj7TivTKzi7rzaEzHeEnwYz9EzOAD+bHKQEtuk8rGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mTIgrQ+y15gMgDbf8a7bYRnaUjFd1wbrwKbqw8GX8s=;
 b=gkY/N26vbgJ/0YorbN8P42yDKGQQe4S7AQILU39qfdA3mBbuYOQlHqmDuOVjghDBYvMgm6ePXwCTQxmEcq0SpKyee0utHWKDg7OIqMIHeugBG1CyV1DKHnAiFiDOATBpSYoDNxWmTLf1BpbsKf7Ho4fctcE6mzxYxsM3bHjdIf9H6B7ZKAhSGQpzo/4dhJEOALV8n7KutYNlMIuSKsWhsUmGO3Yq3TlfwSFWA8qseW4NXuXh7KSLWQGeHHwAfKw/gdBrthP50KogBxtYyiDHcBdLZBndf5eoDXmUnzQ5chIE3JcVByPUuDaLIDoQXtL6gbJIrSaEMW1SqU8B3xOdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mTIgrQ+y15gMgDbf8a7bYRnaUjFd1wbrwKbqw8GX8s=;
 b=agIKajW/1HbAs1pMUFt7OqxLBHLshzLl+l2Z1x2m54ThZnkHmu7B4+RPtcTYyzWOAq4UJ+jm4PkHNLr1PrSBoMBDb+IcgbmHCCn+ES33n8Lo7izWlS9b/iJPE1OYzbDApvQf3/9mwvB+EpT4S8m+KMj1Fug9S7Rt+FVnh6l4W8GGkw7+5YgmT0aAFHIEOo073z4bL/6uarkHnZ4Sf1uS0imy5wKlS3DV0n6UEBh2dDxtfjncoqbvbf5hSy2jI9w4rUeueH1IxwSSS0kWONU9uIImBrVbpyoYmjaFUNlD7FcmiPxsM3DOmpMk9XaSFQxRZr0rEixQYF+obhMBVEz6hw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BYAPR12MB4613.namprd12.prod.outlook.com (2603:10b6:a03:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Wed, 26 Jan
 2022 05:12:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 05:12:00 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] block: move blk_drop_partitions to blk.h
Thread-Topic: [PATCH 2/3] block: move blk_drop_partitions to blk.h
Thread-Index: AQHYEQZJKIMusTSYfk+tgrLWNEN2/6x0xHCA
Date:   Wed, 26 Jan 2022 05:11:59 +0000
Message-ID: <9bb3f4c6-4e21-e1d7-b4e1-f65d273cd3f8@nvidia.com>
References: <20220124093913.742411-1-hch@lst.de>
 <20220124093913.742411-3-hch@lst.de>
In-Reply-To: <20220124093913.742411-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1c6f269-2492-42a6-5098-08d9e08a61ce
x-ms-traffictypediagnostic: BYAPR12MB4613:EE_
x-microsoft-antispam-prvs: <BYAPR12MB4613CA07D1ACBF34D71CCC58A3209@BYAPR12MB4613.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:451;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jQOiF9SwmnzaOf1m4MeLBL+xEs9iCTrq6y57vao7j9Q/xqMIQvOR6sMZtY7bR7GmGIKmgHSHl0nzHbubkXjyebpVrjI94QAvleccuPubsg7i8F7UcFm+Ow88kx+j6AqyAfOSOkASH1mwv3B9bEROxYYbcXYP8pZ/+H1KkiVYY5R7aWRYl2vXty3Kk4RdThTvK8gpZVFfuLf9KqaJM3bAH5iDiGimEQdSpbaC5zfsmu+vgSfs1X/3SEA3TUDwCead9M+WqD6bHUDjuoBbOZ2OHS1fuBG2nZ4QQiMAqDJZjr/YYVnd5VX1Z3XMlp7KTJMdNjmrNectx16kEMCvwmYWW2DInCp2RZ45JH+MGLCHR2u8Lq2NaMJv6Yua38Ci1xZMg1sYvHkJBiFheAcxBvSTfwFyO8BrWUG/eZ//7BmSkhJNjOWTstwCIUZIE4kXF1IoY0OuaaRScjdbAUbtUYuIf/gAGx4iFO85eCj3BPhXrbnEzXxqC9uddAUhuNG42rRr/Ic5Ryw3CacZXfldph0dAZvJZRkU+K32E+HOHtMygm7UPCv3/OwI9gd4F2oUfqM5t56ElN1NisLb/dghEyQif80KVGfoC8Nqu9ydBGNycU3OVVdkw4k95dPfdPYdVHsu8u+HJYEfAYyFPBgj4v3nOklQ5SwxtQApEeOaJhh/Z2HbL5ofg0+SSxE2Pf+Nk6uSxI41N1fJJaaJafTq1AVtSq6ONSLactRSzHcaJkW8vG8tuG0wOJ67i1W6udvvlIBUKQ8ek6a2RnjT7014rbt5Dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(6512007)(6916009)(31696002)(2616005)(2906002)(38100700002)(54906003)(316002)(508600001)(53546011)(8936002)(558084003)(4326008)(76116006)(66946007)(66446008)(186003)(36756003)(86362001)(8676002)(66476007)(91956017)(66556008)(38070700005)(71200400001)(6506007)(31686004)(5660300002)(64756008)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0lzQkRKeExlUzc1WXQydzhtL3VXeDc2eEU4Sno5VThKNCtta0lPdWJqd1hZ?=
 =?utf-8?B?S3lHSFpZeTR5ZFdDTGJlekNLd2JSTUxKM2dRYkNRSVJuUzl6VTh2a0tGRTFk?=
 =?utf-8?B?c1hGRnJYdXU5MkxPM0E5QzdrT01iOVdDMXM4M3lvK2NlRVpkQ25iWnFTK3VW?=
 =?utf-8?B?N0tRVExWMVdaYXBSTFhjbmRlUlF4MkhxSzlPRkRYcE42QjRoSW5pa2pMNWoy?=
 =?utf-8?B?alIrMjJkbjlpY1dJMkcyNVhzRnFsVlE4dm1uT3ZGcmx0SW9iOWNNaTZoQ09D?=
 =?utf-8?B?V2tzYlJmMjg4bnlNbDluWFRneVRhYmpJOXc1NDNKQ3hBVzY0Y1YrRmRiTGpL?=
 =?utf-8?B?Mm44dThhOUx3aTkrUmpCSG0vZnJKWGU3bUhsU1VTVVB0dnpQdVB6cFlaYUh1?=
 =?utf-8?B?c3k1VUFuZ0FvRGVsaENraFl3akhra1BHYUE2VHA0dm4rM2QwVFA4ZmJGWERS?=
 =?utf-8?B?R2FsdHFXRUZ5UUZqSzBqNUw2Q09LTVloNDhUZmQyaUYvdEN5cVE5cjM0K1ll?=
 =?utf-8?B?d3czMUNBSTV3ajlQc0pXalpiNEJiOTN0c0I4MkJKRHFNZW5uc1RQVjA1VVpC?=
 =?utf-8?B?cFh2eEVKaUltRXNzeTQ3L1NDSk9jcnFPSCttOS9nbDVtbFlmTXlnN3BsdDZp?=
 =?utf-8?B?MWE5ZXZWY2NRaGtUamZzQ1VoS2xnYlNMVEUzWXpxOExmWXVzakN5UmQvbmpk?=
 =?utf-8?B?UlE3UTdmTmptenFBTENtdHhwYVBJL2JWdnpWSXB1YlBOa242WmUyUVJneGh6?=
 =?utf-8?B?a1p5WlVWaWlyVTczazh6L0M2NWx3MmgxMXM3T1V3OGc0NEVneURQMUJ5dkF1?=
 =?utf-8?B?aXNzcHloYW45VU43TUxDTkRxUThPWDFIVXphcUNIRHlYUk5hYTJwTSt3d21z?=
 =?utf-8?B?Lzc1Y2lWMmhnTnpHc2hRV0RnOHZ4ZFdDb0dPTE43V3ZyQTBqSWNIT0Z2R290?=
 =?utf-8?B?OThac3dSSmdkUHZMYUhqUGlnbTN0T0luSVNrYklON0VrOTFaN3VuMVhJdGM5?=
 =?utf-8?B?RzlWV2lsVmdEc0dXRmNIbmczUTM4UjVGSU9tdGVlOURXUnIwaG1YNFY3R2li?=
 =?utf-8?B?SGg2TDNtYUxkWmNyQWNMcDhnT1l2aWxoZlRsaHFLdmU4UENvc1Z1TzJqQTVF?=
 =?utf-8?B?K2lTL1lYNENMdFFESHIwd1U4NGhGcmZwSm1MQWlGQjdUWTY5dk0wL3Z1ZXNj?=
 =?utf-8?B?M0p0L1FTaVZWR2thUXVnZGEwcTNlcEVkVUNLN0orMDgxQXBURTYwa1k1T2pE?=
 =?utf-8?B?NjZCc1VWZy9lQVhnVTQ5bHdZbUcwTHBnQzA4SGJsQW9KUEhydXVRb1NkdldY?=
 =?utf-8?B?cEZGbFJMTW1EUVUxbkV2bjNkbXRSdVFjTTRLbG5vazRLcHByMldmNFpJMnIv?=
 =?utf-8?B?OCtBYlJZTzNtVHlsSXFGVlVjeHhJYm1FK3kwdC85MVBib3JIYlNYV1FDQno5?=
 =?utf-8?B?dHpaVGxldTBRY1c5ZmFUWnozZmJ3SDdVOVJNTTJrVm9SV3JKeGxFY3I3Ym4w?=
 =?utf-8?B?M2hOWG1obUx5Qnh4cTdpalpzM21LZ2h4L21hbEhiVVJYZ2VPNjJVdCt6cU5K?=
 =?utf-8?B?VVg2NnplOEs3Y3lRUUFuTFMzdm9PMzNwUzhkQVIzWlV3K2lmdnExYkIyM2dv?=
 =?utf-8?B?UldOc0RzVyt5RU5mOVdIdWVkYjdXclNEb0wzUk9maGVRREZCTS9VTFVhK1g4?=
 =?utf-8?B?bjVhSGIrdm1zd2pKWDF2eEFYdTRQb2lSTzZKYzFiV2lHdjBlMmZ5MUNtTG1h?=
 =?utf-8?B?dUd3eG5UZU1veGlQaXp2djdSeVNpdFQzWnFKQ0hSbjZ2NlplZ2Y4ajYrQVZv?=
 =?utf-8?B?Zi9kazF6LzUvMjJvSVFxSkZHOE5BbUdHc2NLZGVmWDlsSi9RK3NUdUxSdDUr?=
 =?utf-8?B?UFBscEFBR0taemFKRUtRUVZPNERVUlAxbW1sdnQwamhGaGxhZjh3NWE2Mnh1?=
 =?utf-8?B?VmY4QzFCcWZuVUhWcFhnaDZWdDFUN2RhT1phZ2pTUTF0WDFER3VreU5WYm5p?=
 =?utf-8?B?RlhLR1lFUTd3YkNIZkJNb1ZqQmtPd1FpZlR1clAvTmhwTm1iVXZvdVc5QWg4?=
 =?utf-8?B?UlNjNmc4L1A4Um9FUU0wRGt4N0g4N2F6Qjh4elpaT0VjeGpuVFNHN0g4dXRv?=
 =?utf-8?B?WUVxVjcvaDhoUDVITkFtakdoeTlXeWsxdHRxZm9YYU1WendQZG1Lbys2cnRo?=
 =?utf-8?Q?AaL1h6RGSJzsDJ3+ErwZ4tGImT5bGdi4arvv+WfQneSC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E003E95D28B3034C91128495A2729824@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c6f269-2492-42a6-5098-08d9e08a61ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 05:11:59.9874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fly7pgAc7F4z+pO2/CKy2om9WofhTPK5wS/ep0RcndB5EzLR2ICVgeu8hq/+09a92k/ji1SYMaLJboWzmqtYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4613
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMS8yNC8yMiAxOjM5IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gTm8gbmVlZCB0
byBoYXZlIHRoaXMgZGVjbGFyYXRpb24gaW4gYSBwdWJsaWMgaGVhZGVyLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpMb29rcyBn
b29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cg0KDQo=
