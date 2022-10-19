Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E355C4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 06:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJSGQG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 02:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJSGQG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 02:16:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0D4604B1
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 23:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aak9tBKqVMFgNUEyJL8ZFix4Y0TNqZ1HJTmFhkwQIc/RpzkqMAuAT55VS4AP/09XcAbW0P8CySf8JCmNjFoRN8XV+hMGVG5KKq3owywmcSqtEJaZ/LJh/+TAZrcFSUrPX6lrwIdFu8n/wOCRDEadunjQrJskR6klFaNrkGjKmsDAWSSju2N7cDI/dCbeQjw3mE4NUQcuYabhfgDJEEKRsR/4R6b1L2mEzcTM0Vkrg7o+f9gSe1OsOpke3D2APZEAtSwS9yCeM4wcc7MKMGaQ8EfkElOC/wDtgeMstXICn8m3G27YOYdkdkHTisIOERbpZz0mItWdBAA6lahF29ORKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYkmHicgsJYt9iEDNER1XBfHNVoqaaCoCWr2kl0D8iU=;
 b=LYk5bL4oFBr7J3ILIthajpFQ4T6H9+9nTSl7I7VP8RJ4vvabMMrdc5ClQ1eFYZnuTK+JVuiEAX6hTO3Tb9Q7609RU6Kk8K+HS6fAGVXJHzGstankqgfj5bJHRgnLRBJmHFCsrR/kh2sbx/LdKcEBk61mxEvx2NsYlairslelh8/LOXeAU1z2XH8NPvxbA0fvjQn5DhEHIvG3u8XR+9S1Jm3jq3ty6US4oUcOylWtxEnK5eRKXszhlT/CbZ213TubHiA4UvySDJaQmPXhSHtERmClVDRjsBDy2JEOnzaQ1pvU+lrHu4jg5HHc081FinPJTpnR2+4m+/QRsBg/Z0VziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYkmHicgsJYt9iEDNER1XBfHNVoqaaCoCWr2kl0D8iU=;
 b=m/OWzolVFKKjGTE6VA2sLpSH5NurniQ6v+qgqgHErutm1tNGGLewmAKlE+2r4YwXvX5l4YcmcDQNpWw+CjcPK7AZjp/uB/l+6oHL9vtDMcmUbmmbcKHqrElGxa8fHB7s4pX/7FaT7F2KedsWAgsJpgoUWrC/QZWLHYhWTy7nTj9dFVps8oz6pp8FV0eYCM1AGFieku7mJtMTjyyY7ANkns8+rtzIevX1jJOcohKpY8WgmzFIDo6C9LcKAkp8X8QplGSp1hWLxljo4GKbLokKIDIjxVCW1VCV2m2J6vgAhM7OpJj4+WE+mYO2vOaWueZfCkJeQBgr1+mZSD3dukcIdQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 06:16:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 06:16:03 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Yi Zhang <yi.zhang@redhat.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sandeen@sandeen.net" <sandeen@sandeen.net>
Subject: Re: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Topic: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
Thread-Index: AQHY43l60hl7Fc9KsUGQcUgAzbInn64VPZMA
Date:   Wed, 19 Oct 2022 06:16:03 +0000
Message-ID: <122cec5e-5374-e98f-a8e7-b063d9c413fc@nvidia.com>
References: <20221019051244.810755-1-yi.zhang@redhat.com>
In-Reply-To: <20221019051244.810755-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5247:EE_
x-ms-office365-filtering-correlation-id: 5db3b729-4e7a-496d-6308-08dab199664e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7J/26q/inc188iv3BuRs2IrqVy4NzGopaXLyHrMI+id5WcVn8g7RqudZSdywmuOI31DVtQwLIumXrrt2s+0bRPBaFF/UQoOLEQh+RplmUBE5EFD4rFy6264r4TlIB2NC3d5GzoIFvRn71mjZWg3O0vNqK5RoLQhXW8K6ASQoEMGMhXi9jG1wTimpwrhiHVV0cJnzExESw6jJZes6dJtljQDWCuJEGTlaw2Q1sBfmZCXLjIhQzk1kf1iEE18DrRwlIrZQVkm7zP6uc+uwLBlT7chO6yRRhfIp9YUvwjq0lPtRcdKdxJWIcbwkzTmBpgq+nI7mzfIgSIVRcxerb4vS9QHsmhJ2RBSz5EbjewSKc5Ww3agA5fc4/mxqMt0pGiUUL9WBgylVtKrTPuvvLbCF0llZbxEcl1TbjaK3CkQms69UsuHTXpcsBviShBBOSCxInqHYvxno+onl+B9sQJ2ZDqUUcpQ5MW3YDKHsXI0EYzA72OkkDI3GmmEHfe0Pu7xPFyUgv+qOrwlqsyl/hmwkheoL7aEUcV6MEJ+RsIyTNLeuJ1DE1XpbbwplIb22FrXPwyq5tBkkZZATfV2u1yqGIIPGmQkpahwDQG9z2O//MsPBHUoI92WCCpiqi8khTHtvVRWCpDml+UPit+g22c2zbyoL+NJC7EoStj28QgfZLXtC1QNjJg+mpYGPJk+a6ZIgBsAecHaUvJVLcB/Y/3yLdnohn+z9/QhN258Q4JBWy0MvWQAx6uPmJWltnIAF1jfBK1+9W6uFEoMXm52RgizMrg6LUAXa5eZ8lCfmpCo3/WkCuqBWXNQs7Lse0B1EXs650KOp34/4HqU9qHNsNGHag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(31686004)(478600001)(71200400001)(86362001)(31696002)(6486002)(76116006)(66946007)(36756003)(91956017)(66476007)(66556008)(53546011)(66446008)(8676002)(6506007)(316002)(41300700001)(6512007)(8936002)(110136005)(4326008)(54906003)(5660300002)(2616005)(2906002)(186003)(558084003)(64756008)(122000001)(38070700005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enVvcWtuUU8vc3RGMmRFUTYyc3ZKSFRBTDI1NG1yRE96dFh1V0dQZkpJV08x?=
 =?utf-8?B?Tk5zaUszalp4QXk2a3ZDNk40eG9FMGprRkUxNC9sRzZWZTk3ZlVoNll2R1Rs?=
 =?utf-8?B?d3Z3MTNaY0Z5UTg1YzRLQXNLczhQWkpwMCtmK0JiaWpDSFQ4OG1qK3lSODhG?=
 =?utf-8?B?NGovaVZEREZuUERWaDhjK2VOUUloQitQUjVSL3NNRXYyTjA1WjBSOXl2REd6?=
 =?utf-8?B?aERRWStmUnJMc09qZzhCUmZzVHlIUERoUEdyQVlrUm1ZNGZPWDlqbUhjL3V0?=
 =?utf-8?B?ckxMdXkrYVZITHM4NVJYdVJlalkxOUE0VlFKRm16d0lXdDRDVW0wcDhHVE9m?=
 =?utf-8?B?aW9DTkJPcmhxeEIvdG1OOTFZM0kwRmtwT0FHWEdUeUNuQmZldHhnQXZvMmow?=
 =?utf-8?B?bHozVHlndlRrQmNZekZZNXFBSFFFcmJ1Z2hMakJsSnQxTWN6bmc3THlNK213?=
 =?utf-8?B?WHYwUWQzRExrQ0dlZUtROWxwTHRTOS9UQ0FPR1ZpVUQzSWE4bWprcVA0T2Z1?=
 =?utf-8?B?QUVOTzk4cUpIeU1wanZ3QmRpOEhXWFA4bTUrYVhVSlBCanVkNGZ5VU1VTVNx?=
 =?utf-8?B?c1pqZFVjUUxUTThsL2FoaDdLRk1qM3RwbFlMQUVieEZXZXhCSW5iTTFjZEFY?=
 =?utf-8?B?NUR6eVlRRVpVdzhhTXE3UzAzWjhkUDcrLzhwNnpCM3k4N2dWU2lxbkZMOFRs?=
 =?utf-8?B?VDFGZGxnaGhOcGd0UkhmbGFxalo1Q2Fnd2NNNHExM3hqQ0RDNC9tbDV2UEdV?=
 =?utf-8?B?WE5ZRGFEeWN5NTBiRFQ0Q3BjMi9WemQxNkJZLzdhTW0xNHBoenIySEN0MmQw?=
 =?utf-8?B?VUJBbktkeFN4L1o3U043UTkzdUlHWnJlTjdFNDBXKzBCcURTL1dtaEZ6QWh6?=
 =?utf-8?B?U1YrcUlkYURmRHVXSm5VYVhxZFQ0eDJiODY3WS9nV09HMlRsQ29LV0t3dVdM?=
 =?utf-8?B?cGZVSkgxSFRaa1hpcEl4d2FWY0grMCtENzJiR3d3U25meGdWZzJQdnhRakR1?=
 =?utf-8?B?WEIyN29KdDI1bytVekF4dldpNlpDRnFLdUhhQzBzUUhLUHNyamw3NEFYcTJy?=
 =?utf-8?B?U3ZlNHBNV3ZEMXNqMm4vaTRISVNzOHBqN2VEbmR3em93WTZyN1pFd1c5Um15?=
 =?utf-8?B?eVNjMUFZa2kyZExzM0RXNTBkWDhVQmVkL0lSTGZodUQ4VHJrZVZvbjY0bnlK?=
 =?utf-8?B?dURxNXk3OHA5NWMzcmRFekI2dmdHMTJwcDM0Yk1xdnFaMGlxLzFCUnF0NS9X?=
 =?utf-8?B?WlZRUUkwK3huQVE1OXhtckIrMW9xMTVXQjhaNUdTdTVZMTJyUy9WbjExOUtk?=
 =?utf-8?B?S080UDBhck1hL093R2RyL3lSNWFINTR2Qk1PQXJFR1dhOWJHdzBWTEFtd0ZS?=
 =?utf-8?B?ejRWNHhpRHhBMkdONzdYYllWZEdvSnhaclVVMzZpOWpkRFdGaVpaYnRhT3R4?=
 =?utf-8?B?R3lLeGZIY1hLUmNXQ2RzQ3krOVhiV1RoSHlEVzJFY3MwQ2FCTDJtdXU4cThm?=
 =?utf-8?B?SFJDTmg4NVNPeGtkbmRoU001c3dkeGJ2MW01VmxiSUxvdWowYXFWZTh0c0dX?=
 =?utf-8?B?ejFSeTR6NHdXeWUzd0duL09oaVZSdW5VQ05aL0NJZktnRFJVa1ZnbHRxVUpJ?=
 =?utf-8?B?SWlXTXpFcytzeHYvd1M1Q0p3bzlLbGZmT2wzR000SkNhdWdGd3NMU0tudE1Q?=
 =?utf-8?B?ZmhXOEs2WWoyYlVlMDdWY0JVVW9zOUFkL0VSTGhpRWxTREN4SllPT2xnYTZ2?=
 =?utf-8?B?RndFWk5RbmZtZUd2TWJPMkpzQ2FjRDJ3MVNwZjVML2tsQzRzdlBXd0t0S3lw?=
 =?utf-8?B?TjltNFJ5TVgwdncwTnhhV1RhQnQ5VmhRRUJwQUtBS2xlelJkUDVyWWxMZjNX?=
 =?utf-8?B?dVQxTGNvWUNRL3NkbWJNTEpYbzBDUHRaaVdIT3J0ZHRpV21VZSt0cTVYTTJC?=
 =?utf-8?B?dnF2TGtnWGdFa2ZiMmpNWHFsZlJ6M3YvNitpRkpvdTN2dTBLV2dGckhBbFpk?=
 =?utf-8?B?c1RkaGtSV3cxcTgvbkxKbWdLWUt6amlDaS9NZTRJdU0xRERZdHg3Y2VoM0xa?=
 =?utf-8?B?OWJPc0t1N1ljUkl6elVDbElWOE5WaU1nUmRsM2VTL21IdlBSdTl3UlZkR3N5?=
 =?utf-8?B?a3B5TEc5K1BoM005TmpTQTZXMjFPaTE5c2ExVU4rb3RBT21MZHZJSmNkK0pW?=
 =?utf-8?Q?yY+yPkXyh3eNzyTvA5fH4xBw/BwlktZEqvTcEjl3AQYc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <193CFA46AF29B249ADF0F05CA1EAA023@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db3b729-4e7a-496d-6308-08dab199664e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 06:16:03.0716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/IVBszTvCMLl7tQD3rwnPTqBHncEEOpiZcbfEqLiw9QRreJpi6NHxUUJjPSnGmGMz1kecNlWpLV8AxtIwB51g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTgvMjIgMjI6MTIsIFlpIFpoYW5nIHdyb3RlOg0KPiBUaGUgbmV3IG1pbmltdW0gc2l6
ZSBmb3IgdGhlIHhmcyBsb2cgaXMgNjRNQiB3aGljaCBpbnRyb3VkY2VkIGZyb20NCj4geGZzcHJv
Z3MgdjUuMTkuMCwgbGV0J3MgaWdub3JlIGl0LCBvciBudm1lLzAxMyB3aWxsIGJlIGZhaWxlZCBh
dDoNCj4gDQoNCmluc3RlYWQgb2YgcmVtb3ZpbmcgaXQgc2V0IHRvIDY0TUIgPw0KDQotY2sNCg0K
DQoNCg==
