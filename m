Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2C4C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8009C61039
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhJMEVp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 00:21:45 -0400
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:56608
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229453AbhJMEVo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 00:21:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA5U6rDY2NNLVBBByKyuSqEUTFCSkmIGrtJK/jH/DSV0huh5fCKPtyCIoAgF4l4+FrynKUQswQSjT9OxqI33otrBgAR1/BfLC+zjJO8W//hUyCUh7IxPQL/E2IXEbh5cAK+omESz5r+87je3ECCA9hvgaVoXGGjA8ALg590SkAs932MGkT6FIBVWqXWsQQH4/JS1KN1dbAHewNqExgZfB1dHXU0Hn0LYYH6PP2R85uMJZM2iodOxsZuDWTnz8T3ekoLqX0TodphxyiLikJux7fwhT70wW7MPBwiRFJQ0W6jR1T/Dycr2VR7IcgpHBr1b265E/1F1WKnnl8RO7nMWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN5/hy8qlNpJfWP3fox3lG00Tf2Hrz/MZS2OhFqslqY=;
 b=YRYD84DfMoGxLcYPsEQ+I6IAx+0vdGo2PIerhTTrNgRl4l3rSGhb+mpxKa3br3rw20BW/Tvn5uVZZ1vfO88YKGz8PG9PVmiGoN0p21gbpb/gSxU/wpGFY6RfB3P4DQvnIPuIUN2KI3FwELDX3oeryCXy3/kl8Yck52d66YCnoPR1FlCWTb46zn9T3wO0cPfaC4AL+Lomk/ayG+R5To8YjOeKU2vyEK23JVxFSH4L66a0dNbV52vHRe1j363R3K5dyvcs0CRCIu6ZlqXsewnEJqQaG39auVyswT26Ex3ng/RHG9TsR/AyE+PQ+fMyCPlVNCvYgDKKWd8BwqN1d1b2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN5/hy8qlNpJfWP3fox3lG00Tf2Hrz/MZS2OhFqslqY=;
 b=T+GtSilpKAuJp774jzSXOOTrEW6oOPpGP+nuy9QmUIic+PUnZOOGM1m9u8208JUw4/dq9fe0pC3E10+TIUNjkaIuovaF3xY8dh27ubW4OD2W1CIoH9HnfYpMmlNAddO9SZlpQ5GQqVAwitRTm+sqwUdR5U6h0RbE5g3S4D/5qIJhdtgDJE4fQh2d3SKu6ZsmxcBX+i8fnDQLUKRqjwmyuGYDPFP/x5meBPlhpw0CXzg8N9m2pjxX9jPFeEV43CnbzA5pTKPNGRyfGiW37Ef4HRWYYNJ+gEIwPTRGaEo8LBg8SPWv0yiSbAXSyZX0Y477pp0MXiY88nwyxbMcI/TI/A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 04:19:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 04:19:40 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/8] block: don't include <linux/ioprio.h> in
 <linux/bio.h>
Thread-Topic: [PATCH 2/8] block: don't include <linux/ioprio.h> in
 <linux/bio.h>
Thread-Index: AQHXv4VOz3HpKyYy+kOXnCgywkESI6vQVAwA
Date:   Wed, 13 Oct 2021 04:19:40 +0000
Message-ID: <a272392e-de85-7764-baca-9fe01f978a7c@nvidia.com>
References: <20211012161804.991559-1-hch@lst.de>
 <20211012161804.991559-3-hch@lst.de>
In-Reply-To: <20211012161804.991559-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1073c567-da38-477c-bc96-08d98e00ad1b
x-ms-traffictypediagnostic: MW3PR12MB4396:
x-microsoft-antispam-prvs: <MW3PR12MB43969197C345BEA2633A666EA3B79@MW3PR12MB4396.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +wC6uOQbQ6hmmMbsG+31yNGTejyegg3dN6XWNOrmuEizTDHJJyhmrPW5pu5JKEDnsuss/nLnGzO0yQ3d9T5+IohNQLXx3koXSS7wlndKBlMcUDohM0jgHo/BYz7PRMG6OesEHcAcbZJTejvrVrcZ80VcMRiEJdqJ9gEjJdpw24c6dr55173CiTxrfmDPPNHni0ldqOGasGk4Hi/Wf8Bs1uhJL0Xmncn2eUciTlwKgshjwroI6AU4m8zobg89HizKWHIahx+WbYzI5LMHZ0HYQQ6sAk4H9OcLFgAiAvZ2fcImnr+6ys3mMFRrJCBqra7Y+vJUnIfe3dhzeAGNp2cQiFpTlBpMEDUMmwLydjx9lBTUviG2wFcMHDteAg+TbiJ+pnuEYqLkqCyh1bu+/fxcuuuzCB/c9QMffem24vpPDj41rrIldqO26pXODGEI0aowFY+CEm8w6TzC/xXGnxYWDxnemJ/RXE0a83RSFOusaHUEw8XzgDXsBFQ2cuwZ4jODS9l2rps6pXzh1mkF77FTKcs9F0J1jXHbluu7KyBset1M14g1+1h51XFkq/RlTB5ylnqbdbMmgG3SwR9z56s65LZEdrjtNMrZCQL4tkFzIXvIvdystj1lfl6JMEF1gE5hhWqrtvy+hPSV+xTutdEshIIyQZR2GdwyAMtxG+J6NbQ7e20HHMOjKp6tIZ1QXvr7ZOmrQ1XDFl18LZYWLqtjk+cp8iB0EIfM6y85VrONFjvsW5ek8ZlP1ed5AWT0eqZlVGZPYTvxAjko2F3JwpUS2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66556008)(64756008)(76116006)(66476007)(4326008)(6486002)(36756003)(38070700005)(8936002)(86362001)(186003)(71200400001)(6506007)(91956017)(508600001)(53546011)(66946007)(2906002)(122000001)(110136005)(66446008)(316002)(31696002)(2616005)(38100700002)(558084003)(5660300002)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEY4ZzhmWkIzS2dGb3czSHpNMVROMFFUMG54bjN6d2lOTzhNMnBZcjk0VVha?=
 =?utf-8?B?VnNJK0hpRW1yOEQ0S2RuNEZqSys5QTVJTWlHdUNLb2lmWitFLzI1aXJ5eDhz?=
 =?utf-8?B?UGd2dnMwRm9LamluMnFpQUxtc2NWbzBKWVlKd25kdmphR1J6ZTBRZUtHK1Z5?=
 =?utf-8?B?TFJVaFN3RGw2RUhRRktrWjlEVmtuVGZnS0ovOVQxTE9JN3BnL1RXbUgrc3hk?=
 =?utf-8?B?VE1nUmlOK3hzeVFRazh2Wnd0aHR0eEt4MGZ0MUhHdncwTTgzZy9VV0hFaGVj?=
 =?utf-8?B?SzlmcGJKNnNid3dqbnpIampWNHRjeksrTU43WDRaK0pRMjNxT1dzMytQaHph?=
 =?utf-8?B?c0Q2ZkIzejgxMVVsVlVlQm9ncC9DMnMxUkpndjVIN0tZcEJaWnRMTEw5TmJM?=
 =?utf-8?B?eTV6aHJaSVYvZGMrSEJGL2xCL1c4V21HelpzV2N2dmx0cTRlcy93NVZwVEFQ?=
 =?utf-8?B?RXFyQThKQXAwYmg2UVlHTzBMRWF4Y1EzMGdIbFJweVpYVVdYcnFyVlJwTVNn?=
 =?utf-8?B?b0lFa25TQzA3MHA3bUdHWlk1OVJzdW5weTBVck9KbzhJT1U1VDhuMlVvRXp3?=
 =?utf-8?B?aytQQk1odTVYYzBwQzdXMEhVam5pU1N4YVZ2by9ZWkhPMnUxNzFKamtWYUpi?=
 =?utf-8?B?RmJQUHlhaVhFUEpxVlJGWUtqdFlhYm91QXRSTEIzbUNGamZZSUIrY0tqbnpC?=
 =?utf-8?B?SW0yWUpyWG9RM1pzYkxSU09nVGFadjJGMFNzOEkraFNnRGRhWlFEeC9xdU5W?=
 =?utf-8?B?Z01rOWgrTU1TUG1nempYZVhkSHJHUEFFWU9zdlVidmhtUkNJYVdyMWR4STMx?=
 =?utf-8?B?SFpFb3IycmdLdEEwVExtSmthZkpHVjJaSmt3R1BEbXV6ZlJNSVpRV21VTXpl?=
 =?utf-8?B?bmVnQVR5bVIzUGhKaUwzS0RORTlJa3RWVlUxMzdqZkcxMU9va0NMcE9RWjhh?=
 =?utf-8?B?dVRVMVhwN24wamJRS1Ayc3NQZHlzTmJpUDJKeVB4akdjRDVjR0JiTTN4d1ZG?=
 =?utf-8?B?LzJySmNZYWw1OWZCZUgwZC9menk1azNZNXl3MGZtUmljSXIzYVdua2ErZE5Y?=
 =?utf-8?B?Q3J6c0xaMmlQcjJiUTlaME0yZXgrSFZEOEo5RGtNZDUyQUQyZHBSSytlWFZO?=
 =?utf-8?B?MW5pREhGV3pveFVPM1VBRFl4Z01jcWlCMktEZGhnWk11VWVsamxHcHFBdnpm?=
 =?utf-8?B?QllYVTVPRXBodGthdW5jeWtGMTVFdnc0Nyt3NnhzVmlFMmtrQkEzWkNOWXE3?=
 =?utf-8?B?cyt4eWhoWnMyZFVGRzRqK0R6b0lWQjcvZGVqVmp4S0NzNGpQV1ZHUmZUZGdW?=
 =?utf-8?B?UHdJUzJqdzJjT1dQeW13anBCOEhIalRoZmdEN0ZjVnlBenJnbzhtUHkvN3ZT?=
 =?utf-8?B?RlBDaXQwai9VWUlhOFFSekdJTXNYQTBNRzFoWGtwalJBVnNmdytQdHNlRUFC?=
 =?utf-8?B?di9FVnFkcms0eFhlQ1d5d3VQcGlNL1FYNWU2ZlZiaTk2cHZyTEs2WUp0NXBa?=
 =?utf-8?B?ZFdQWTQzQ3g4dkpGalRTeW1zZ2N6RzFhMEt4d2N3cmtXUjZqUklOdGRFU28r?=
 =?utf-8?B?ZVVwbzhQZTYvRmRBNDNoZ1JCMUVCNDhJdnNxeUxLRWNJUkxNU2FEM3JVcTdN?=
 =?utf-8?B?QkVJLzdmQ0tacHRJR2Zqci84QnV1MXFub3JlREdidjU3TVNCNkZ4YjR2V1Jq?=
 =?utf-8?B?aUIxeHhqR0orcWJKMFFHNFVOdzIvTTZYVlZacldSQlY5QjVhNGtaVTFqdjlV?=
 =?utf-8?B?M1o0S3Z5UGdLK2p4d2tSQ1ppVUtsU3hPK254bVc4bmdIaWdlZVdiQXhVK0Q5?=
 =?utf-8?B?SHk0dlRJSW1VR2cxTTVXNFdSS2hHaXA1eXNEc2JYcXJWRmxPSDltbHVSbkp6?=
 =?utf-8?Q?cdvN82Z2EV2+c?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <690683EAE33C1149A9338113CB9E7A86@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1073c567-da38-477c-bc96-08d98e00ad1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 04:19:40.4286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ntu9we4OElHtcnpzyWvd4aXJTUcjGTAM3ggnbvA/BmE37OtEr7EYrkxVD1rfnatOV40mEc+GFdfKL6cCEOIvjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTIvMjAyMSA5OjE3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gYmlvLmgg
ZG9lc24ndCBuZWVkIGFueSBvZiB0aGUgZGVmaW5pdGlvbnMgZnJvbSBpb3ByaW8uaC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCg0K
DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KDQo=
