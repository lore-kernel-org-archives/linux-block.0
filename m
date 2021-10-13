Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7954C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E1461040
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhJMEWx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 00:22:53 -0400
Received: from mail-bn8nam11on2072.outbound.protection.outlook.com ([40.107.236.72]:38081
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229453AbhJMEWw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 00:22:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS2QC8z4f+RAELE40PrS4Pa2UmHdPuCrtYYyZy9KQZx6kXpamLEadDRXThRqcMM8w0uIdpW3JWHoz2+6u8TlMBM6Z46dldvKHSzbsFZlxDoF7YBtV++55h9wPllztD9fiGkPm4QmKQiu4+8/LJSXRnSfLVL3ueYF01DGltxeREqm2Z+0ru1EvjeP8oKMJMzAbdCSepLuvDEgDxQZRw7T4xC8uYypz9vQru9ZpE7DrWNE7/K4Kd6hZMd/E4x/yieLS9IbYDGqYLo8OU6OcIwwtJ3jJG31ud/rntNAbwnldiER2BPuyCaVPjPjkahkYfL9dwvyF+NREJd3FVbfFVSaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISxQfIK0b5xjfCXSlSf/dt3QWElpTx3vBU11gZyv2eI=;
 b=fsSQMccuSP840zJ8keysMhZJETnZFER9E3poxQiCtxEDQNFLaXmp7og8VYjtrHM0dCZYuKRbgG+EPzvURTPaxzZjGkU02uG20iCpO6miHbOdfzf6ZhqCRtMzcjjuWknnBX9QXvvsqMx5R6RuZBQrBes4P89H+rBHbTEVNim9zr3hfjHfZJeJATDFx0/Tkg2YX7yKjs78JSjXYg7+NTpGqb+dCmxCRVO51d/ZNuySVlozD9+0dosFe6FNOJWc8S5NiQCir/6YXefxWQmHg6xYrkMasYXd9PtkSGX8UPhhjS9FZ5Vy9aQYrPr5FWux7f2ju3JoSwesl6BCzLytSSrsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISxQfIK0b5xjfCXSlSf/dt3QWElpTx3vBU11gZyv2eI=;
 b=cpVCAWnT381L6ObU77ud8aM02hTmj9dDLhEzFBoBUGiN+XovEw2sM9pW6oxqa6AmabEeu4vH55HK9KUUKDjj1egh0FMIlB5pELc7P612Yi+36HsXTr2aF8kXePAj81GFrWZqxsjWxtUzs7GNvc91QTk1lPNQb32qzvOJhFHShZjEUUN3BTvuDsDRSnbBg6u5lf91Mc2/dtJrQhD4lbu6eqHc4gt6nPLCxZukGIBxdi6O0eAfg0SkYiitsL9JQ0toR9/3qj2rQ1FJOEo4+QJce+4eff3Ai85usjUTrHbCkHldMd4ElMgZQ5XgwgvknZ09FRwEufQivmw7U+nLx4KzUg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 04:20:48 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 04:20:48 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 5/8] block: move bio_full out of bio.h
Thread-Topic: [PATCH 5/8] block: move bio_full out of bio.h
Thread-Index: AQHXv4W08meRq1gYokOSu4I6dZ524KvQVFwA
Date:   Wed, 13 Oct 2021 04:20:48 +0000
Message-ID: <05921b34-f2e1-9557-5f4d-d89f9fc7eec6@nvidia.com>
References: <20211012161804.991559-1-hch@lst.de>
 <20211012161804.991559-6-hch@lst.de>
In-Reply-To: <20211012161804.991559-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44b57d87-85fa-495d-efd8-08d98e00d5b0
x-ms-traffictypediagnostic: MW3PR12MB4396:
x-microsoft-antispam-prvs: <MW3PR12MB4396F9EEAF16F7E49EC3623EA3B79@MW3PR12MB4396.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XAVy2LZgZy4LzU+DpY/naF/VlLQmZ5HodFz6gvZgX7yEYcZVkZEbLtpXnxzG8fOl/XA94oMl4tNdaJLHtjrC+XZ2EUcrsUcdFPTmnDzQQcXpduGtP78ArY+pGXmNv8JvOywtRWd6zIJeQigbwn+YpD8kT75ki2dAaBXeiZaiI0WjHjmtOdBLGDjsKgtk/pAiY68YkvFbuwye6nCJSEedYqeK6x0OP+ZXVo7NscebNjFn85bbwTHR7hdFEPvaD0VvlcFxvOwDFXlVFSGE4fHKvgOgOkVfwedyM70Namnx160CuAmNFeyAmwb8EfF9CDQ2Hbwb9kVM+AXW0yP7mtBCpihxaDIDpNZNY3SGqiFIw2BYB/3JKurqfp60Y3vdGaLTB1eFGdGGvbXnullnXI2i60aldFAaIjfA1t18Qhtrh1sdlrb7Ok1oOW+bSA8xKFjykGnr68+jHpIWEfMlWeUKrRzDLx9kJY7ZUp9TFP40PH9s0plt42Zrf8k3fbbGHEMqpvtPAZn60CVzG/WfBWwtXOBa3XMs6M8yUGN9znTesVGvend9yCP9kY0q5jm/0pR1PdmzsIpAjEDnUXSV/XxmKLdqJPnlKzsVz4J8b8sB3HblrsifO9AJ+yokfkLQgdnaVDxU7eUvs1+POV29z5NXcDfU+MxQouM7dclfx5HAYwrUTonIrxbBnT3XKKwKTxUAE125K3dh+Je9+Mz/q+WbNWqsytvVRNizrj0PvHdkJ1UzpwTokFXikwAJsIqrrWDtaJ3CBj3E8nGGF5hUYKZ0oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66556008)(64756008)(76116006)(66476007)(4326008)(6486002)(36756003)(38070700005)(8936002)(86362001)(186003)(71200400001)(6506007)(91956017)(508600001)(53546011)(66946007)(2906002)(122000001)(110136005)(66446008)(316002)(31696002)(2616005)(38100700002)(558084003)(5660300002)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFVsWEdFMG9OeUR2R2V2dVlKMkhsVHdVQ1pGM1UvQmdzRDZLZGp6aXdLV2JV?=
 =?utf-8?B?SmZVVGcxYklnNklXZWxyZm1IUEN2aG82UHNoYTNHZlV4NjlHdGptUTV6VTQ2?=
 =?utf-8?B?alVvQ3hLOXFMUFV5RUZsNDVUbFlUK0tQU252b0R5eFNVZEsrTjBQSllrV3JI?=
 =?utf-8?B?V2E3SVlwSnQzMlp4bVFaMk0vWmhWS2RWVDIvcFQ0ZGhFVXlYM2F3aVZmZEJo?=
 =?utf-8?B?TmdoSVVDclhhZm9hdVROVWl3elVzcnJuTVI1cmVhT2V6b2F4V0dKeGFmUXB6?=
 =?utf-8?B?NWF0ZFJxQk96ZUI2SHA2Wk8zSHhZRkh2NGE5eWxRNG9pMjBiSzBEek9qeWtO?=
 =?utf-8?B?bnF5YVd1SlVnNWJtQkNwbmdOOHZIZXo1OWd4VFlyVytPK0FYOEh2QjEvWExN?=
 =?utf-8?B?aFZBcytQcHRpanlRUTBMRDAvdnREd2xwL1JPQWM4V2tJVGg0MlJvWWNWV3Zs?=
 =?utf-8?B?NDN2dnhUZ1dIS2NBV1kyQm9sSng0TnRGaGs3TlNxRDZ3Q0I1MnpEZTBORW5o?=
 =?utf-8?B?bkN5bXFqOE1sbFVZa3lqdnJJNk5naXR5SDl6Vlo5MGwxS1E3Z2tTRFJDNjBD?=
 =?utf-8?B?UEgvS2U2TzVzMUdDUUhHL2xEd0dOVGJxUFhzblI3RHBncUg2UjVCTUlDYjdk?=
 =?utf-8?B?SUc5dFpXempOOFpVdTNndXoyNXJGOGxKRlVCamx1ZkVLcmZMa1dZWFhSYXdX?=
 =?utf-8?B?NHVDM1ZnS1c5enhKSVdPV0JESStzaXE4OVUzd2JtaitwdldzZm1mMEgrZXJu?=
 =?utf-8?B?WW8wTmZvS1RwSHBtVG8rWW1Td0tyOFFhTlJRSmo4UHVKWGJyWTdVeVhuSUNu?=
 =?utf-8?B?YnkyVXcyMWl1Qk1OUTlXT2I3NmF1YnVES0szY2VGSW5xcG9JNGFSRmxxSFNv?=
 =?utf-8?B?Q3F3WkJIN0d0SmxzY0Y0cDN2UEJBejJMUWNXaHRTamp0eC9XbjBTYlg5RG1K?=
 =?utf-8?B?V1RzMkhFOWhUclJQcmZ2NVp0WmpTaE9CY1haMmZHQjIvSWxUMVpFb3MrUFBU?=
 =?utf-8?B?UHQ4VzdLSVF0ZllQUXFCQXg1dlg5cVg2aFVPYUkydEhXZW9BQWV3Y3dXL3lp?=
 =?utf-8?B?M3dSRkI4T2F3UlkvZmsxUjJ5eG9qbEM2cjJjZzRML1hBZXRBSndGdGM5VUxD?=
 =?utf-8?B?dyt1NWhjTC9teXBWQXhhai9LVmtVY0xNZVl5aWttRmJlWlVEVEFoQWlqWTZ6?=
 =?utf-8?B?cnFYNUJGVmJNZkhFSWZqamYrQzJ2cGQ4UjI4cjZVTTdQZitjQ3lzZ051TDhL?=
 =?utf-8?B?RzRVZ01uRzM5d1pRV1RkaHdMUW5xMnZsT0YvejlVYjVuVUdBd3o5YS80UVhG?=
 =?utf-8?B?U0NVL3NQMVQ0SUNLcWppVmd4N0pwMWhJSG1lNWRpUGhWZGFDWGJRcVJIK3hz?=
 =?utf-8?B?U2k1VVd4VWxnc09vQU1vWGgrQ3NucmROM2pOem5VMWIxbXVFdVp3NXhmSEhp?=
 =?utf-8?B?NFlhSmRtMzlIb0ZpK3E4K3U5SzJ6NllPSkE4SHFhMUJwUk83a2xaYUg1bDVX?=
 =?utf-8?B?RkVxVzJiRnFQZVlrZXZta2lhOTE1cUlwSkhWNHdoZ2dLUnhjRFVURGdSVXZL?=
 =?utf-8?B?LzBIQ08wdks0ZGlscmE0RkVwRWtjVmUvaVVJM016LzdoZ0ZFYzBBOTdaemd3?=
 =?utf-8?B?T01rS1JoVU1iVnZHRENxUmNobnIzamhmK2YyM2pvQ0tpRmgxZWJmVnVJTXpV?=
 =?utf-8?B?MGxGSjlGTDdiaC9Ydm5ESCtYakZpSmZkVGVlR1ExKzkwd0xLbnBjL1VWdGlW?=
 =?utf-8?B?QU1JUitEMVdTQmFoUm1Pei9za09PSlhoL0ZsLzNQZ0hNcUtRaGw3bzNXbWhj?=
 =?utf-8?B?QzQ0TXZMYUZPMkMxREtVb1dEVXJhSEJROVNnY2xIVVZub01PRm1QT3FrMjB4?=
 =?utf-8?Q?xOxZvQTI/+1m0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D37FE0C099EA654786C66C6964CD85AB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b57d87-85fa-495d-efd8-08d98e00d5b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 04:20:48.4363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAevrDEniR+BdIrlPc/K309Lk2WlMCj/sbWfLIu9/etxVj37G/sNcWO6YTboNgR30MefNx381l4m+VyXLuNQ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTIvMjAyMSA5OjE4IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gYmlvX2Z1
bGwgaXMgb25seSB1c2VkIGluIGJpby5jLCBzbyBtb3ZlIGl0IHRoZXJlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQoNCkxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQoNCg==
