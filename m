Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BDBC4332F
	for <linux-block@archiver.kernel.org>; Wed,  9 Nov 2022 19:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiKITrH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiKITqe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 14:46:34 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2138C2ED5B
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 11:46:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8+pfY3+MYEh03y8951zFlhQ89bisMyAWBSSzu4V5/uVo7h24hpZ4Nauaglzj2Rqm4C5bntihyUjDJg0CeKaGZ+zfe6eBTYHKBgzcWiq6aQ+6JfYzFh0PPev8FDDWfadQ3V1gI88z+iKjU9jrLdRZXEOeRX9IF9XaBTmhxqHhbo0TmlQWhtrx/V6jBBf8r9IpnIwh3AWDDbQajJUQq1bKeRNsSsnoWo7wFP6W/azPD/qaHf9aR0YPppxcCuP/ts2eb+l2BF/DH4g5GRAkgAcNKGGWM6W+pN8rjzZJxyJYjSaKoIAIjrZQQmbh+PuO2QaTMT3cmHTCZuZ71gmYLwNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bD9+58LjZo96JxN2qazzR71qmlOS/z6g2H2mX3NUh4=;
 b=JOcfq13nnr171HSM0S2GnP+o6VB9RSIpWCSkMkYg9nLayrVmyP0FcfhA9p1nhAwUcOokhMmOlZ3tlVqiC03ZSOKoMhiJL9W1cp31pH5jXyY/GYzeT0PKa10yLIvAisSnAeZge++UlpLEaicjtYa/dvQPWg6jXHbs7FoWJfKKtPcA9Kb3T0z97L9IKvUtHE271oDoiEJQMSPtq3r0qVtL4P24GvHeoueUrqGSnFQGyhphcjg5ptMtyaqwNHClSItCiuGyaxnUQZA+lRsLJURidZNOduaJxIEzRPHASO1RYA63RUtbfNx4N1SGY4rHtSBtzgcAgVP6x9YYhNglyOmAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bD9+58LjZo96JxN2qazzR71qmlOS/z6g2H2mX3NUh4=;
 b=VzKs6DccTFsNcGeZ7jPnfL0PnxMM1XeSreCAWr3Y+eYJweffS4xSNzCPJvR2KyixEoDX81AafvjMKk5M9ljml35NH4AO9AuPVd6bxfMihpDW/NYEeIQcgc2AMhBR0VZTTuj6xnT0akYvUpAz9WKKWTdret0vroYydSwVUaCzr/65/veuw2Br87RTbSxA1dbx0q8zzm2P28N3D+W6Fz+FqN3Krf1rikrgOtS9aNZTaXW+t6qHggGZblXaINMxzBbAll2h01dl5S20o1oEUUCkJEXoZy6X/nU7YTCvq6zbVsmrKRbmKfRvPRiWhAoi0WFdZZfh+gzdjqg+WySbF8nmFQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Wed, 9 Nov 2022 19:45:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.012; Wed, 9 Nov 2022
 19:45:58 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] blk-mq: simplify blk_mq_realloc_tag_set_tags
Thread-Topic: [PATCH 2/2] blk-mq: simplify blk_mq_realloc_tag_set_tags
Thread-Index: AQHY9CM8vQqZYOkn1EO5pI6tLe02Ma42/4AA
Date:   Wed, 9 Nov 2022 19:45:58 +0000
Message-ID: <fe98a02b-494b-d929-fd35-8aef7b7f52d4@nvidia.com>
References: <20221109100811.2413423-1-hch@lst.de>
 <20221109100811.2413423-2-hch@lst.de>
In-Reply-To: <20221109100811.2413423-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6423:EE_
x-ms-office365-filtering-correlation-id: 26c76eb4-f039-43ac-15c1-08dac28b0619
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y3NMGvDgcr9BRIWsb2Lznod0iN9cKF/BFFJhVjuQVhqZ7+kZPQRlE/kbosKOV9s5qZHoejaJkjeGMolXHXi7wrubMJU58fpCXh8BZlNkrVZESonZC3QXh7vbQsNSYsY9YCGcIn+I5evcBvQbMqo3+K6MqrlyVq8rc0Xcd5ncTOHJ6ya8yc3JtGiKm8m5ynLf5t1lA6PsOR3luM/xUZ/vr5NL4P693GjS8wnVHcza1DEa13xq6UM+/pNmkLZ/WDiPgjvLTxHlRsfboSQXnyob/uWBr0teUPc5h6qaR16I4ruE6bHpt6dVHUUoYPeCok53xS8p2hAKtSbRuc2erBu6gFwGbtweRZeTBVH+jkUANN4tQf00JlAFI5XPybbVaLB5MQLu/EYsR7+FX8xQxSU7zJV0NslsjzS5oAAVZ5fPu5Cyovz7xgS/DOneAfwVDot+p8yDvn/rJ6thor2V3xDeMvTYC0D2XCrEOnDgSHoZJEvButC4NL229N5odkw3Zkm4ueyu64hGrpDNVDVQqrOmtUWMNvP20yEvxOjHoiV8hHPezLbRT+GA9arqajOstYzOcY6BGMl9t0QmaC509iqSUt7EgzzO6CZQGVdyI5FPeeUMlisFuEZbhTzncEaRDHoiaGrQvc4SGustCxmxkpkQCoZBsblQQ3Yzhfi48vx60nicVjRp4CL8nX7yNuq2Tlox3mxh8bkdfPWwgYxtGDVGitKgjU/sohyumGZ0eOQ/AuCfDL7RpFT51kkUo5DRBI61/3SA0AuP6wDj1kLq4OK37kudMDjGxV4hAcUe2eyPg2QFmHhPMNGnYpZaJN9z5GanyHZ0mXmTYoWN+FZZ1tiIhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(66476007)(64756008)(66556008)(4326008)(66446008)(8676002)(31696002)(91956017)(38100700002)(76116006)(53546011)(66946007)(316002)(83380400001)(6506007)(2906002)(558084003)(41300700001)(186003)(86362001)(6512007)(5660300002)(122000001)(2616005)(8936002)(36756003)(71200400001)(6486002)(478600001)(31686004)(38070700005)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1dsSzBKU2taSUZWMFluSW9RM0JUYUd1b3JvcTIvMFY3YXBCMy9ibzhvd1VY?=
 =?utf-8?B?Wk5jLys0SjdLWk9yQ1BmUDNkK091Q3NTZW9WSER0OWt5cS9NaUlwMnM4eW1a?=
 =?utf-8?B?bXhpSG1IU09zbEY5ZEtJZ3lsdHpJV0Q5MUdzUzRYT3RIYUl5QzMxWUpWRng4?=
 =?utf-8?B?eTh4cSs3dzBjSnNuSmhyQ2NZdU52ZG85Ri92RnpTOUpLMngrMmxJVEw4VXJS?=
 =?utf-8?B?eFJUWDZGQmJvUUkrdjFjZnE5a1QwVzV4WTlWMFdhOWN5UWFwYS95cnRWbkVv?=
 =?utf-8?B?Zkk3V2ROUytJeHVlTjBLbTNZQzF5eTNua2dWamFaMFQxMkp3WTdlM05PYXFW?=
 =?utf-8?B?UmxKeHU0TXRYbGpWMTc5aWxjbG91cVV2alY0YUFPalJrZzRDMGFQQzRydmQx?=
 =?utf-8?B?T2JlenNDb1JqZFVKNGs4WFhqaWc2MEdLc08zc2hqTU83MUFaVTNYeEdNVm9u?=
 =?utf-8?B?cFd2VzlPTEtqVWhEZXhzS09DeGY5YnM3TEI3U1U2TldVUnUyck81Um5oZk1H?=
 =?utf-8?B?T3ZpK0RtbzgwU1o3Vm9waFZUOEJ2ZDhhTWhUbTkvREMzR1lsbXlRaEI5SFpu?=
 =?utf-8?B?SU8rQVkva1JOVHBWMHR3SnVTdVB1V2dmYWtiZzU2VkJBZ1pRdFc1bjlMK3RO?=
 =?utf-8?B?ZFFVY3JlUTBMdmZEeWtIVXovM0lISUQvMXorZGpZeGR2NHYzcU13RmVKOGh0?=
 =?utf-8?B?ZDBPVkRkYjRPbTJ1eWprLzRIT3FOQzEzd1Uxa0JGSzc3SWJYVWl4amg3N09r?=
 =?utf-8?B?Nzh2ZUNnOUY1SzkrcUxRZUxrbTRtclNLeHRBRkp4WENETmc4aE85UTY2aUZD?=
 =?utf-8?B?NnVZQXMwQW9ZanorVS9ZMmZvRDFnYkt5akhjZWhBWlRQQmZjWDluK0NvT2VG?=
 =?utf-8?B?MmV5K01jcUxiOXdwbVI5WGp5K3l2QjFFdEdkbWdiNjBOZXlGanJ4NjBlVk8x?=
 =?utf-8?B?ZXU4S0tOWFJjZWlnSXowT29nWW9MNXpTL2JHWE5sOUdLbmFHdXJRS3cwTElS?=
 =?utf-8?B?L1JBMWozbFBabmF4SGEyWnpUL0xPbUlMTXlaOVU1SHNaa0kxL3ZaM053R0R5?=
 =?utf-8?B?Q1huU2gxU2RsYjIzekFERUlRY3JUSVRMQU5ESXB6dUlYNWhnYTUvaUhzT1NZ?=
 =?utf-8?B?cTZLM1hNY2pNZ2JrYllJZFhNR0tRaFFDTVMxTWRjRzc1WHFGMEwzaEl5R1BY?=
 =?utf-8?B?SStXeWk4MFFJcW5ZalRXS3l0aStCNXR4Mzh4OTA3eXFRTkFHNWh5U0FTWHNh?=
 =?utf-8?B?VDc5RWRKTmJVMHZLODlweDl2Q2VmSk82UWNzbE5NMTN0dEQ1dHd1dFFueEtu?=
 =?utf-8?B?aUNBSEhMNTQ2S25HR0FYZVc4STBzZTlZSTY2YVFnTnFjb1hGcFlSUWxXaXpz?=
 =?utf-8?B?ckVXV1pRWC91YWZmS0J6eC90czR5TjZoMjBDb0h4bGFWN2diZkp3eWswcnYw?=
 =?utf-8?B?MnplZElvNVB4eW9vRE1NWlRWQnlyeTlSSnNkdnZudHpySnA0RVI3ajZEYUlv?=
 =?utf-8?B?UE9xaElpdXhxRUIzaUcrbGFBMnM2YVNpSk5RVEFpcHdhUXVHYlpQR0FmYW9P?=
 =?utf-8?B?WWNWd0M4WS9WOFl5dUpNVDVORVhzRHVuVkFFa0d0UTEycmZYdXRBLzdoUHR1?=
 =?utf-8?B?dmJka0haR0RqTlJpSjVyM2FKMVM1WVFVQzIvWEdnM1M0cDd4bWtSR1ZnN252?=
 =?utf-8?B?em5CbjcrSjdFSnBjVnd3ZU9iN2NKaFRTMThHTTlJd1VuRXZkM29heTVkeWJQ?=
 =?utf-8?B?UU1ESVpGdjIvY0k2bnlTR3o4Z3pxSmlVaEx6cTEyazh0SzlxN1pDeFdiZ2NM?=
 =?utf-8?B?aEEyUkpwdmhuY2pqYll4NDZaaTFOTStobEl0ODR0WDFSUld1eXUwRU9KZXZF?=
 =?utf-8?B?cDFjZDFIMUxoR29hOXFzbUNYR1BQdFl5NU1NVnIwSWZiMEt2TWIxS1J0aUFP?=
 =?utf-8?B?QlFSTmVac0JqV3JtbXdaTG9CRzY5cWkzM1A3cGVUUVRBM0F6T1Zzb1doWFlS?=
 =?utf-8?B?eGoxWHpkUXg4T2RjQmQyemUrbkhDSDFSL1JISFp6QlBGUlAxMnRNUDhuOEtw?=
 =?utf-8?B?OWlKUE9RZjBIZGc3dCtiQmJUN0ppNkJOemc3T0M5TXlrV3pyb1VvYlpSZUxG?=
 =?utf-8?B?NVdZVUdLNEE2TjkwSGpId0ZZSUJPNWpHT002MFQvQUV2Tk50WlNKSjkzeS91?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADB895BFEB64D641ACE6CAB6B4252881@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c76eb4-f039-43ac-15c1-08dac28b0619
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 19:45:58.4740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlzGSWfi5Ta3rnfg/yRU1HT6hYapSlG49kCrjaG10QKI2041I3pfCkyroOVvu2ULI03lHd9KGaH32SpTfGH7xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvOS8yMiAwMjowOCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSBzZXQtPm5y
X2h3X3F1ZXVlcyBmb3IgdGhlIGN1cnJlbnQgbnVtYmVyIG9mIHRhZ3MsIGFuZCByZW1vdmUgdGhl
DQo+IGR1cGxpY2F0ZSBzZXQtPm5yX2h3X3F1ZXVlcyB1cGRhdGUgaW4gdGhlIGNhbGxlci4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==
