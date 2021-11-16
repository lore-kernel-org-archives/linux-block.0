Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2DEC433F5
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 01:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3416D61AD2
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 01:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbhKPBgc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Nov 2021 20:36:32 -0500
Received: from mail-mw2nam12on2042.outbound.protection.outlook.com ([40.107.244.42]:47840
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354770AbhKPBdT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Nov 2021 20:33:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ey/Allre+Nityf7IKdku/pmUAiSLg2y6AM9jGD5otsSL4v/lkQBI+87S2oAX/0KDsky91wTqiV2sva8/dvGdoxOPZW429VFQHENil1Qmt1GOjqy24ptQCo0Cv3alUQV7HPdXA4QJE5viVodxIK/tDNot5SlsX/ao6TnfG8e9gpUfixxhCG4r4HXcSQm1PnL+lu13GCMbLHPquvfsukAg085oH6ZI6+HETbpXL5yzN9/arYpsRArisQj+cwu9OlIqr8N99Ra7STyFpmzTF0KlWJ2PPNaw22D99f2q47DRUMAY1bMdgeZ6+WneLmp2sZRzABMKT6myxlIGWoYbYjYrbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzAj0ZsrUiNqPqImQEnSa35AwZEMb1KlV77pE8eY5iw=;
 b=JcqvZdMHGB8fWYCwEHZF/t1Pu39YLp9c/d2tArGDywA4tFwM2l1xu9NZminSaUj3Rf8Ir5ng1NCEsoiHOGLSbQLJvE5yAzovjCINWPIJgaRMGmohWtaJiNYTY9SPjmIkWsZbzrM+iFAYc1juZFre5ZihM/rzF9PFQQ/Dg+ioLA09QsnV2sLZ85L8Km3IytqN5ozFJTJgcq53hjp9XQLjd7dErLwI90rJcW987qoy8gBesD42w6ev9aSOy4/FGy0F0P9ajm94pQ3LCtITUl+o8e+wY2gf6bbTYr1vCvqgUJbdFN3Qys4UoyK9smgi+ra6hrLTAoG1UrtU1oqbHPCOyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzAj0ZsrUiNqPqImQEnSa35AwZEMb1KlV77pE8eY5iw=;
 b=H41LI1S4L73VBpwWIKy+7D1lQh4HOoDeqH1V7ZydNuTQkJwWumjXXvDHbd3wsL60hg/mCPFHgTBOG6jYNTcjsVRdKTErKKmAyIR/KBFAa8CJVB6Djh5B0A1AhCmWEV3hkWAVKJsAMygSvootmvddH0g057DP7yGkTQjnASw/+Nvah6WRKEKl65WhH/3hUcpC4zrsSAsxhcYut5spHj7n3fTG9gIOBx8yooDl8N+LpGV3HEmNcsmDjDgWPicvLotuP57Jg77p/bvuZp4jLfEkfeIysQkI+rweJRG5W02pQxkW8cGRP0fgM03iwS4b376CrmGMqlor9hb4RQU79cRwMg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB2556.namprd12.prod.outlook.com (2603:10b6:300:e3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Tue, 16 Nov
 2021 01:30:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 01:30:11 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bean Huo <huobean@gmail.com>
CC:     Bean Huo <beanhuo@micron.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Use REQ_OP_WRITE instead of its integer constant 1
 in op_is_write()
Thread-Topic: [PATCH] block: Use REQ_OP_WRITE instead of its integer constant
 1 in op_is_write()
Thread-Index: AQHX2nQbysTbh0jIFECsGu9Dy3s/tqwFXhcA
Date:   Tue, 16 Nov 2021 01:30:11 +0000
Message-ID: <2a239998-2bab-c1ad-dcb9-6e51c8a5d05f@nvidia.com>
References: <20211115215819.28787-1-huobean@gmail.com>
In-Reply-To: <20211115215819.28787-1-huobean@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 609d6c5e-5e1c-4faa-1532-08d9a8a0a1e5
x-ms-traffictypediagnostic: MWHPR1201MB2556:
x-microsoft-antispam-prvs: <MWHPR1201MB2556DA039B53C3820E124CFCA3999@MWHPR1201MB2556.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +y97CQc88Y10mtYbqbuzuRKsR7p4qpcl1qO2vdK0j9RLFvpHbhEhblSw8O9WUCs1oA+L+rIuQn80Ci5SAD4jUQKvAS7wU5XcwOPhlPc0JOdoEi6vhy68bYA7chuvcJnyOj+12b0AX1i4r+xIVshwE/mQW4GssRun59iGppTIwu9RbtvlaadP9u5QtfkC04kPHwlCLfsR45ft1ra4cyQyKWmd7zMrJpm9wx7H3R1PxXogvSa7H/2QXjCuaurHdXTqoCOQ8f6pgQmOuuWPa/V6seFvBW05dlxlLP5/+u5mRQ7N6+Tx7TEeMiG/pL1ITxBMmvKUoeTsMOZWPPuHozf7e7wyiJhqAVCpV6uLVG1XVgDfg05+QH6kI/w3sLhXNpjZPJ+WcVW6T4LOtfn9N4s6U40w3jtVnGeDl2zZ2BVFBFuuPSabgK5juQ4F5dqtXabTer+Qyrr1HcHRSWgiWQiiynwiCgARJcflZLvIbS6az2/F8uE6UW6rABZ1LTilL3kIxrKhvuB6QGiCULfufQ8dCdxXt05HeNFeewxHd41sNGPwSqTYQ4JbIBjIFe+FUJ1K+iJAhcVpODPNkUjWADHVk2oeQeQLbaojmQqw+zkK4euS2Jzv6h1J4ZLbAckdoEd9H7s5Xn30uE0Of8YIMnRfmgShif5f7brRgmMwtnc/fVJMjfh0k3UraUh8hch9n4QTOSX+1a+zuQA21abJlf087zRYOGvwxw1XoM2oLKmYs9UWd313CVoAmScEuVwd0suOCKdo8r9wSSRhTUm3bPWxYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(2906002)(558084003)(316002)(83380400001)(54906003)(6512007)(6916009)(26005)(186003)(6506007)(508600001)(36756003)(71200400001)(2616005)(8936002)(5660300002)(86362001)(66476007)(4326008)(91956017)(64756008)(66446008)(66556008)(66946007)(76116006)(31696002)(31686004)(6486002)(122000001)(8676002)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVduTjJ2TW96WXBZbm8yQmkwN0RnZ3I4cFdhRXNjNEY5d2hzeVo1clhNdUJD?=
 =?utf-8?B?eGJLZnppSjY3blJJM3kzeXlreGJZZFo4azFIY1UxdmJFS0RVWmJERG9QWVg5?=
 =?utf-8?B?RGxMbFNPR0JnWHBwb0J0RHZBVGs4cjFZN2x4cW1qY1FHVExHSXFwQytBQzBR?=
 =?utf-8?B?ajhJWWEvYjlFZTlqQnB2KytnZXFZbk5JSDRzUWZzZ3ZKVSt5MG0yaXpnMzRG?=
 =?utf-8?B?elYza3NSWE9rS1doYlRydEU5anNuL2dIQnJZbFFIUVZCSnlnUWFKdVpWSFBt?=
 =?utf-8?B?aHIrQlJIYjNQTEZhY1hmcStVSE03T3ZNTVB1SURac3dSWVdJVlIzK1ZnUVFl?=
 =?utf-8?B?ZjJuRnFuUmhlampVYnVETG5yVGNFNE1jRzJJdVMvU05Jb1RYWDQwc2tqS3F4?=
 =?utf-8?B?Mm9CRjZERlkyZGFxb3ErZStnUjdmU0l2RUk3K1UyMTFNY00rVk9rcVUzZHE5?=
 =?utf-8?B?OEUya2RYQzNHSnZQY0swTXNSeS9CQXE1bUs0S1k4RDV2cHJoNDJvcTFmTEFB?=
 =?utf-8?B?K2svNUE2dUphSGFXYXhpZlRLTS9sWjg4dmY3SGJsQlFhMjJ3bktxUkxmTGgw?=
 =?utf-8?B?a3RWMFkraW9CaHBteW53RzVwVzhXNVpXUkh1WFB5cHJSWWtHaExpNGxiQi84?=
 =?utf-8?B?WXo3cWx6MjBZYmJnY1JJeitTd1ppVTFsNkdUb2k5NVIwdEd0VmtoN2hxUzgx?=
 =?utf-8?B?QVQwYWJ1NU10WVhiVWZvblVtakJVNS9GWFZNVzdSU2dmWWdDTlRpMzZsQmpG?=
 =?utf-8?B?REp0Nm1USkpPdFg4YzVWemZlcFRJK1poS0p0a3lLM0FrazJkRGMwU2N5NFBW?=
 =?utf-8?B?ZzF6WXA5Qjd2M21FMVBGL2tYNlBTUyt4M3hDK0JCb0wycis0K1F3WGF4OGZO?=
 =?utf-8?B?ZFc2QnM4VkpUdkFsdk5iWVljRGdTS2pEUFBXZGl0TW5qT0Z4WHI3VnBmaFNM?=
 =?utf-8?B?OXh2NjJqT2dFSTdZOTc4bDdGZGVqR093bWVGUFV1VXJVbDdIb2F6OE5wVkow?=
 =?utf-8?B?V0pmcTZCQXJLdzBya29ldkdtN1R5ZHVnaHVGTldnbFpLQUg4SEFtVG1xWlBF?=
 =?utf-8?B?ODZNa1VSb1lZSUFsRDFmMW96bHVkdlBZLzlDS013b09SVGV4L0U5d0g4M1dm?=
 =?utf-8?B?QW8wci9QNjU0cDVTVGJsOGJaOGpveGU0RlZrVklvK3dZRWY2Qy9oN040cnBW?=
 =?utf-8?B?SXgvbjNWU3R4WTFQM3dCMTR2ZVk4ZlpKeVN4VGxsODhoZG9XNURENzJqWXkw?=
 =?utf-8?B?NHROYmFyQWhqN01CTGRkQXl4YllEY3p6S1RyaGNDNmRITkI3QllWSTY1cHVR?=
 =?utf-8?B?d1Flc08vTmgrZ3FMaWJZRWlRbWRiMHNaZFZNd3E2K05abnZrUjFrbWt6d0hU?=
 =?utf-8?B?Rmp1NUUxUWtvVUNJcDM0MkhYdWRRQ2o3QmM4TWhjMDA1azBJMVpIWnhsNjNv?=
 =?utf-8?B?aDM5ckx5dVlIaTRFY3JiWW9KT0FqYThYZHp5QkJvU1RRSEE4bVlNbThteEF1?=
 =?utf-8?B?cmJyaENlZVRhdWkveFhSclp2RG1LNVVUNnVLeGdjdStOaEZIZEo4dWdWK3F3?=
 =?utf-8?B?bjlUSVpneHFBK0ZPNlliRjVoRHlzZWpXVWpGRmR3bVNqeUZIZnBLbmlMaktn?=
 =?utf-8?B?WHA2emEwM2prMzd3cHJ2U1orQ25WSHZlT1VUeWhoeks3eTR6ekJha2dVL3Qy?=
 =?utf-8?B?Z09ocHJFamxDdzVZRHB5d09IVkxpcm1qNU9MSW9pVGJJajkvUGhvbThJblE2?=
 =?utf-8?B?Rk5hdTltaVozcDlOaU9qWlIxQ01zVWw0aHovNklqQzNoNVhtT0szRGFHbGtj?=
 =?utf-8?B?NVVZZm84SThFZ0E4czNUWUdUYm9mVjQvcXlXSGcvZFRJalJrTG9BbzNPaFFZ?=
 =?utf-8?B?dTRBRit3UW5uVXJ4WWFNaGJaZzNwNUN2Mkx2aWxSWG5wVGVDcmhpbG15d2dH?=
 =?utf-8?B?Z010WndjWGptYm1SWCtvaHZlUis1bitpQzRpdnpja1ozVWZWc3F2TzdCeGE5?=
 =?utf-8?B?WlJEMmg3b1pMN2pxUkNwbzNpaVhFOEI5aGl5eGlueUxkcXlXVWdSUzdzQzZZ?=
 =?utf-8?B?bVdNUU16R2c0anF1THBoTU1vb3FsK0tVQVozUk0zUTRYNU1nY2t3eSs1RWU3?=
 =?utf-8?B?aVJpYkZENnpUaEIvaG1KRU04VHhhNGVRczJSNjIvTit5Z0N1YitYM2djR05D?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55A505AE20F74E43825782380E6E90C1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609d6c5e-5e1c-4faa-1532-08d9a8a0a1e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 01:30:11.3324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnlI1p/Uvd1EGkG8JvsyVzru4WnFXCWMNOpGAjXNuHZFXs87y2liop4rWkXlV2KY7WJR//StuYicO5Y+cYRdzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2556
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

QmVhbiwNCg0KPiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBvcF9pc193cml0ZSh1bnNpZ25lZCBpbnQg
b3ApDQo+ICAgew0KPiAtICAgICAgIHJldHVybiAob3AgJiAxKTsNCj4gKyAgICAgICByZXR1cm4g
KG9wICYgUkVRX09QX1dSSVRFKTsNCj4gICB9DQoNCkFzIHBvaW50ZWQgb3V0IGJ5IERhbWllbiBp
dCBzdXBwb3NlZCB0byBpbmRpY2F0ZSBkYXRhIG91dCBhbmQgbm90DQpvbmx5IHdyaXRlIHJlcXVl
c3QgUkVRX09QX1dSSVRFLg0KDQo+IA0KPiAgIC8qDQo+IC0tDQo+IDIuMjUuMQ0KPiANCg==
