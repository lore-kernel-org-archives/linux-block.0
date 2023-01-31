Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E3BC38142
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 21:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjAaVmW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 16:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjAaVmV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 16:42:21 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378BB3B0D1
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 13:42:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6j7/ryTM4Hrg/Q0Wuen35NR15b9jBWx+olzmbSUFFzwBku4v9WDPEZkU3UqoC1lmnoaSUMKhZ7q/aIT+t27DjDptaA46kfifrSqpcFFYIn69EAlpTqZ2CdtB+AF1boqZNCJsIvbSBsg9+BTJlAMvO86vkrE/tjythtSyV0681KJQxLO+f+Tk//psbitmKQ4aYzsZ6Y9Vs/l764ijtZ9VUj7hoVrBhS6TM8UUAGwgJFlurK/5IscBowLj8sPulCp72D+NMtqY3JTWRKiKl69ClSFst6iqcHbMhwhXAS+mGfah852g0BOA3obDacPZmrFUyIuHvqnrbxlW7L+14Vw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ST8r4gxSfkOM4JCeySGgoH3CNr6q7lAWoZjO3txfnaA=;
 b=CEXRCJEkmtJAiM6OzQZEzmOQQ/6oI3aC5VCStNQgJdHvzcViD4L/BOYWMxjO8WeynbDKbJaQOUZ7ZTwTmnXMsy0Z2UW31KpmaebqzeaWmBvVLxUe6yTTxInfSeGjhsvU81Ne0F0AskHRe7KTwViQvbcT6/wxATlE0VDyJVIVGHMqD5Ac2O/LTio0+e+ckgKbNUPhB50YmHqAHU539kWdpKdiLYBaUsnHDasy4zMW3yih+sxcxPb9XxlIo1oh4kJjQdWCV5S3fE+Z0FcjkOcoJ+kSbjcnTjWb+NJlF1TW6NB4efRLfhxRfF/M6YWOWejzBKHlAg+wagw6/qta/uUAkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ST8r4gxSfkOM4JCeySGgoH3CNr6q7lAWoZjO3txfnaA=;
 b=QWLuqb4CpjVsI9jiZgs02ru9aftQYWrTY8RRoosiRz8paGYYud3vR8NJ9pbTn0oIuJDNG1eowtjdR4dpkkbfkwgQnR4WS+zr0qDQSEYhqU0+RGaNE7+hSccxXCpHgX0DE45gHdpz/yJa2mNhakQ1Hy0d2HGm7LEEhSx+0ki2Kh/azO3rDeyjOOk3whFJMT0z+jClRbM+KKRIURLxbkLkc6/EIjMSi2YxFLxInU9fWExt3zFZgJ7SeNpWRLugbPeJP+yHMjBelitAEi3lV9XWnuXtdZx/3R5LJnmENuKh4dfd4dmKogwqO59bOxon8orFKgAtSy79XX1JFKx+pImGOA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 21:42:18 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::57ff:d53b:f3e7:d2d5]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::57ff:d53b:f3e7:d2d5%5]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 21:42:18 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] null_blk: Support configuring the maximum segment size
Thread-Topic: [PATCH] null_blk: Support configuring the maximum segment size
Thread-Index: AQHZMrPK2gDTbmCbwU2CQVjx2fYr/K65FF+A
Date:   Tue, 31 Jan 2023 21:42:18 +0000
Message-ID: <a38ee732-7195-9a64-8985-93988b581663@nvidia.com>
References: <20230128005926.79336-1-bvanassche@acm.org>
In-Reply-To: <20230128005926.79336-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|PH7PR12MB7162:EE_
x-ms-office365-filtering-correlation-id: 4a2fff47-b8ae-4375-33ba-08db03d40695
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EtADJSUDmX3zD5qfJd2Q8LTt0e/U5XGssjXxqyUwLmvnnh3UrEMJDt0bXY1n9jivVg7CTrRzjgHIvw8GZ/XKzb4ID4jkz8zupF/MYjrVpiG6T3qZP2hCb/G3Wpd8JNV3/+QLeiGfn2+hh0dBPDkVR8Ozy61d/9Zs6KfkrXqPkEjuXs5YhAklpm2Qtq6GTKDPrVsC85G9t6FkhmrAQjxHv5s2VpR9o0ySQE5Hfg8kIUxDch8mPivK0ob5sK4T/juHmnjQG/BIj54iWBuRaHhr7l4TMav7uLSuXEB6ArccE0y6LPdtAiLYnIaa05Qau6TxXrTrvNQhviQ8+SiBGAxRdaiJKEWGdQLg+JJXWl+Wzh+A3dDDZeTuq6egf0Ip52+F8pl+IUr5qHLqbV1AWTaHg8NHsy+5hyRv+NA1FRq6O2g+oSLxarT17AQRbgTonLs/J0YsevTMDDKKhzsKAt6OxCdh0X8VJnccdjyxfskfuVpgVY1wWqFp1ggyTPOOnJ+cIiV4a3h7iPGBi3/C1mlSPwqLJ5V9zsbBzksPDpF2c9lVovZtVrYx5s+9U5/Q3OEZQocUkf8r5Bz2fa8vhuTC6o+HJrnuARb2n9CM19vxhip5nVzkViRRFkxDvdoKqQG5PqtKI8DobKJLFrnJfP4rwL0+zZX0qjBSQd4xZcFrzM4algVDnc+BxLCx7UtMMCDkYcW6hV1tgmud08spq4V99AEz+B5tiuoaDE8ATMpijjqXg3nHacqrJaLISIwNOJdQDzVMvlYckB8hoQiiAvOwFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199018)(31696002)(71200400001)(31686004)(66556008)(66446008)(66476007)(64756008)(76116006)(41300700001)(66946007)(8936002)(91956017)(83380400001)(8676002)(86362001)(4326008)(478600001)(122000001)(2906002)(38100700002)(316002)(6486002)(6506007)(186003)(53546011)(4744005)(6512007)(107886003)(5660300002)(38070700005)(110136005)(54906003)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0JCYk5ySVdNVnRQeWZZK2cxUzBWUnZ3YmdwcEZwR0lqakhmUEptQ1k2b3Vt?=
 =?utf-8?B?ZmtUWXVVTkhuUmpsWVErMG0vYTdkYjYxdlczS04yKzBjeEVoWWRLRTdtcnFj?=
 =?utf-8?B?ODlHVVBtcDFlVTc4YndGK0NYcWxGVWx1algya1d0dzNkWDBDZ21lNjhkTmc2?=
 =?utf-8?B?b2FObWNLOTZ1Y2VDOVMxSy9EN25DN0l4SU9GWkV5MzdnbnFmZFV3NmtrWVU4?=
 =?utf-8?B?d0FXaklBVGk0c2FuMHpVRVJJbU9QcVErbjhmWkJIb1FYOURiVEMvR1cwNkwx?=
 =?utf-8?B?UlhlNDhlbUVHTFJ6THRYdzR1RnRrdDc0L2Rpd1FDS3YvYzd5SkVMVXNzNFlt?=
 =?utf-8?B?dWZlQnBhaEo1eWRnR0pidzFZOXVpUWRPRTBBeVdJVDFSYi9EdzlpOWFPVnRt?=
 =?utf-8?B?SU9UWVNZY1JJTU9vbFBGRDBZVzRHdGg3U3UyUldxTHoyVUo4cHJZWE52OThu?=
 =?utf-8?B?V2h4SS9JV1c5K0huQjRTTkltZUxORDJiMlhLU0k0OEtIWDlrd0p2N0tmUDI1?=
 =?utf-8?B?OTdvZU81MGdEcndPTzBHaTF2MzNRNHF2VjZIKzgyRUswd2VIaThaV0ZreFIw?=
 =?utf-8?B?MS9WcDNINzB5ZThWMFd0ZzE5aGx5cHpLelRzUWFkTGhCU2xIMjkrOThqdzln?=
 =?utf-8?B?L3c1Q25SMWRZcHJPdkdvQkRLdDJDWCtLdkw0RzFRTzNhRndSc1E5d08rK0Zw?=
 =?utf-8?B?YnYwWVE5cHYzWnpOanFZQ3ZkWGNTQTd4azBrNnZIRmp3RS9qemRka3dXck9C?=
 =?utf-8?B?SUtPU2tSZWMxMWZHcGc3TXd0OEFzUW5rOHl5Ykc5dWY0Qk5NYUV2cUl1UWpH?=
 =?utf-8?B?WDNtOS9aT2JySmxXR2RVbTcxdUorY2ZkT3kxNDNtZDhoeFUrejZ0WlZEcmEz?=
 =?utf-8?B?T25ZNTRtOTY4elJxKzBTNG9oRXhxcVZyN2RSd3pVeWZDVFFjTTdkM2JTeHdz?=
 =?utf-8?B?a0xDYjAvdDFqTzRhemxXKzA4dDMxenVQUVNnNWNETkNIQ0krbC9Ob25TOEIy?=
 =?utf-8?B?UmxHSW1GREdTQ24yeDUzZi9leEl0LzFXRkVmTURpVjNTREU3VnhoOG9tMjNu?=
 =?utf-8?B?YlJ3YTZGemJPV3ZoMW0yWmJwRm5tOFR1aVphT0hOTEZJNjFDLzQzaFltOEsv?=
 =?utf-8?B?UExiQ1hpTFJNSk9oUGFTOWFsZFZ2SithL3V3QjQzbVJTL1FFNDJrN3FoRHlp?=
 =?utf-8?B?NjNlTmlhbmJwOFVkS3BEY0dCb2RtRXNaZXp1YzBwaFM3cWI0cFB2TXRhMU9F?=
 =?utf-8?B?dG03alkyQWQ4RTZqM2wwWVBVZlhLYm5yNVhRTThiaWhBU1lhdUM2VndORnUy?=
 =?utf-8?B?blRzUGtnZXZvcGxUamJzbmFtNi9TeDlLT2JmMWtZR3phSC9kVk1vVEd1VGt6?=
 =?utf-8?B?cW5seWorcmhLTHNybnpsZWc0WURsRVVtL0RjZ3kyTTMrNTVjV2MydDJSaTZU?=
 =?utf-8?B?R0tZeXJUaStuRVh1Tmx3NzZtelVzNWNidnpia0grelpNczFxTXQ3WHhnYW93?=
 =?utf-8?B?MHUrSHhVaTZVRUdBVW5ZQUdXTDJ4a0lXZ2lmeUgwRzNrdU1WM1RTMU1HOHVz?=
 =?utf-8?B?dFNJdTJmNzdEMWpCNklDQnpINGNSUVk3RUJ3SlNNL2xEMVhGM3EwNGJnWEpu?=
 =?utf-8?B?MTVXUGJQa1pDQndyZ2JRWnZJN2xWY1RwNTZPdmJ3KzFhMGtieTQvaC9iUmhw?=
 =?utf-8?B?YjNuSkVnMXZKS0pQeGhvNnJ3YWVwaEx0NDlhYmZQb1p1NzNGRUZtdjdmM3p6?=
 =?utf-8?B?TlMwaWh6Tlp4ajBzVXVJNDFISGtqTTk0a3lDWU5XbzY2N3BPdmZidm5rbjVy?=
 =?utf-8?B?TkYvOUJTdkhQMVRsQU50cjVGYlMvVEJWeU9Nald2YlZzRllKRysrS1pJU3VU?=
 =?utf-8?B?eVh1TEdudVBGTFhZRlVmMEx1VnVpOEFSVGg4eTREQWI2VXdlZ0N6Nk9vYkJH?=
 =?utf-8?B?TGMyMXVzTldYM0lNUVZXVDJUbFRUSlJlbmMzZ21Ib1NuZ3B6TUcyRVlJUWF1?=
 =?utf-8?B?UGVYeTNEdFQySDNBa3h3bUNVTERJNTFUN1h1WWVCVFBUZWVvajBXVlBaQmhN?=
 =?utf-8?B?NEFFQ1g5VTJiSVlOVDF6SXYzMlR3V0pqTlRuTUtIRFAxdFJWVWVGUTNHRU8w?=
 =?utf-8?B?bXRMNU4zY1BsdGYrRnRiYXF1OWI0eGRIWHJXOEJUYWZkUnZ3czdGaG1SYU5Q?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D666F404BE5C34BB04D743D7BE5EF1B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2fff47-b8ae-4375-33ba-08db03d40695
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 21:42:18.0979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ley/9vVaT/FsP3g73yeFlxGbsY57gmuhXPF8VfgmLXYro1QP3WvgLrdYc9dRmSa6ST4P5xADvUm9QYiY+RWfUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMS8yNy8yMyAxNjo1OSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBBZGQgc3VwcG9ydCBm
b3IgY29uZmlndXJpbmcgdGhlIG1heGltdW0gc2VnbWVudCBzaXplLg0KPiANCj4gQWRkIHN1cHBv
cnQgZm9yIHNlZ21lbnRzIHNtYWxsZXIgdGhhbiB0aGUgcGFnZSBzaXplLg0KPiANCj4gVGhpcyBw
YXRjaCBlbmFibGVzIHRlc3Rpbmcgc2VnbWVudHMgc21hbGxlciB0aGFuIHRoZSBwYWdlIHNpemUg
d2l0aCBhDQo+IGRyaXZlciB0aGF0IGRvZXMgbm90IGNhbGwgYmxrX3JxX21hcF9zZygpLg0KPiAN
Cj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBDYzogTWluZyBMZWkgPG1p
bmcubGVpQHJlZGhhdC5jb20+DQo+IENjOiBEYW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9hbEBv
cGVuc291cmNlLndkYy5jb20+DQo+IENjOiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9y
Zz4NCj4gLS0tDQo+ICAgZHJpdmVycy9ibG9jay9udWxsX2Jsay9tYWluLmMgICAgIHwgMTkgKysr
KysrKysrKysrKysrKy0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
