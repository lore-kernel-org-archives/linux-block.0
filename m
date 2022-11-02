Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4761AC4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 00:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiKBAwL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 20:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiKBAwJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 20:52:09 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C753F1BE87
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 17:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWz8m0dDucde2wB5T3ffb2vcoH7KB/jkDvsppXA+HMtfkm2vd9xkP6DnDpUxM4Eezfn1gCjT7qu8oyPNrU9RHLkQqtRyX7ag3todFzxGwK788EHx3ZOhTJvY1MKHZwRsdJ+moiLVOMpY8Oyy6FVXvcHkfZZXBXSzi114lNGeMjLCMuo1ivXxuF1LTbX1Aku3rOs/7AIL6govvh3odYpLcNA96JSxDx6TFKOCRT0d6stn+rBXumBJw4XHFYswx+BKQusETg69iYBLwibI4A9uIt56prdMpVkAIBK5J1TKvZjv2UgL7aU03uw4lPYHHLRQhfu1+rXiTF/ci10d1QoXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BPPLvJmnlxeWYmHG9hR2Eapu3fbhISMNdzu+syyPRo=;
 b=TcWy2r6ix4iWzmpP4GDAxjSSAK3QjFL41iCuKmm8THdRg4do3Iz56jzbx1OacrMDsch/4PHRdz8L/b1PodtewA5iOEVWS1sv9/n31rtXdFTm7itPUOcN7hUPiha/XalYHZ4bdgZjXqnAa7qsOS0tk4iTNV1P67nFttv4Hku8DA4x/0hD17Hx8PnIV2efaqmCrel55r8VSq0SHUlwZ4g/tOsD921lLkll3B3rWBet4pjUhJeXvgysbTbcB5tY0c6kj/eNzyUb52m7WCrIejeU+RizxVEUtggulFF8vQkq84Uqct6S5ne2GfAysH5mqpgXeJAfcpEXQy4rghHpPC2iVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BPPLvJmnlxeWYmHG9hR2Eapu3fbhISMNdzu+syyPRo=;
 b=QEyudezMafNLPpYlBDFsoPqaJfAWStrEuBO25inl0kEr0shtx6X7EXX+aDs4PXku98pJFmKlOvUvagfG/p9mmoWcwPbaCC25tgxEkbvO4aHUe4xotTrHkakGDLzwpy+T5DkltkQ/tzV3uLiMX4CafBT47y/mkgWyNyAMlHcGWvmC/0wso0xHoDBUGPn+e3tWQJOrgX5pFjw5cGyo/J+f2qdJHjDfMi7YE6KhsDGB/dBrHAG8xUjl5pcKf6Sl1beXOKuzpBsdta+cw6maPS7vwfu4UVfZzAO/8MKRAkBzTaAjxJ/ifz2pEjl78qXVS1IJPLJ2pk+zLAyfVtAcNPurqA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 00:52:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 00:52:07 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Vincent Fu <vincent.fu@samsung.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Thread-Topic: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Thread-Index: AQHY2UFEkIAKE36ytU6H0HwdEAigoa4izReAgAgrDgA=
Date:   Wed, 2 Nov 2022 00:52:06 +0000
Message-ID: <6270de4e-9f4a-fcfc-c4f1-d0ede32352bb@nvidia.com>
References: <20221006050514.5564-1-kch@nvidia.com>
 <CGME20221027200756uscas1p206196106ee2224a7653f1f2bc7ba31e9@uscas1p2.samsung.com>
 <20221027200654.147600-1-vincent.fu@samsung.com>
In-Reply-To: <20221027200654.147600-1-vincent.fu@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA1PR12MB5671:EE_
x-ms-office365-filtering-correlation-id: 6faf1f0b-f145-445f-6d02-08dabc6c7750
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +/CV5XwDUCY1suyczRDx85vnqoqq3CA75b34xHCVghi0mtoYpW5pFqGjjrs2KrpeIDxGwA5k5rPOauCHNGdqHOCo0CwD9ei0c/4s5ZpvU0QYNZZ5nVnszSJI4r3lPXzXVK2auA5zJzC9GDn1iwST+P9tYOBiMpS6VZGo5/JOFe6zWjYGnPYpou9TKJJ/r7Bax7sl7mHa21xfqvq02PUOfAyCmb8jOMJPFZafFpqiGFfenbbqsbpYFy0NWDohUbzF0E8rWHdvO2owQzx/hFAzibH7s7UrmevL0UfGXCEbPWBOae25Tymm5ZuWuhj+h5c2BEZyGND2xvutjVgVfyJ4yGuGpSSGpjuiSPrB6Tp4/ppsq8uLyZ7S2TTCLZXkG3QvPbse9ngMqBjaYs6+MbL5GmN1klutA3y/oSRCZ/BWPpDWhYHlC0OodwDPKQtIRFGRBXB6WiG8tZnsFtnU8X2Q1kIZmOq8+XLp9cMY6nai5J0EDW7B3exSSQ34z2b4mzhXE3fBY2lK523y5rImae5Sh9zylajv+fctwQMPuNzVIv8SEFWOR9o9P+ev5xowVEZttVz0THiX2veCFhY1e9HP4z+cPlX1H7FRkNpsg5kLTVZh7sJmYDwEkOyWfGckcFUOLpjkbWPDt5ujanyK7yqDSmcKWbhBK0qZPKGJetxu1qly4yXebiV/dAcZ3ImloKg1bWum73a3FIR1+v+728ZLib6P6co0JOvOWjm4p2uCRWwF6xlTlvTAP6Z0fEiyhTW9eilLOKxS+a54t2Jn+Jun/I4pD+C2JC8SEdFwb8wYQWpundZnIO9ETy/UFs5nCRjlmwR6UhPRiXGxaqsVz5bzjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199015)(2906002)(83380400001)(186003)(2616005)(4744005)(31686004)(5660300002)(6486002)(41300700001)(122000001)(6512007)(86362001)(31696002)(110136005)(316002)(38070700005)(38100700002)(66446008)(478600001)(76116006)(66556008)(91956017)(71200400001)(8676002)(66476007)(64756008)(8936002)(36756003)(66946007)(6506007)(4326008)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OERxSjhHeUhpbHRPTkhqYVJ2MUhBL1ZuVHN5WXdlOHVRQnQyU2dWOVBsV2hY?=
 =?utf-8?B?b1dVazRwV1E0aWo2eEszTEZGMTMwRFM2U0U2RHlLb0tyWjhQYU5OVmZSczRi?=
 =?utf-8?B?TnB3bGJvUDBlcWlBRGs5S2pkQ2ZVbXF5Y1BnMjdOZUpYL1JVbUJRMkV6OStU?=
 =?utf-8?B?ZkRlbGVHaW12OFVxT2xJWWJJODhoQkh5UUN6L1hZUGtXdHhqTWtmN1pSenRX?=
 =?utf-8?B?bUR2anpLaStaS05nZkE3ckdSM2V0RVZhRWdxWFFVQlBlNHd5dDNRRkhOSVAr?=
 =?utf-8?B?ZnREa2Y1NmYrdVY5VUlBUXRCQ2FlVE5jZUZoVzlBbzNmK3F5UHpIL2dJNVgv?=
 =?utf-8?B?ZFlYRlZZQkxtTVdYMnZjOC9YM05zazI4cUNTMzhHaVFLNGhKNUJ2M0ZTY3hL?=
 =?utf-8?B?NHlJYmNCeU9tL1QzYkxOYkdobE1hNzRPZUtQcTgxb0hSMlIyYytjR1p6S1ds?=
 =?utf-8?B?dzM4L0E1Ky9EeWg1SGhtMXVtVlJlMHVyK2E1WW5mYkNzdEE3NFFBcG00bk1t?=
 =?utf-8?B?Q1Q3bkJIdmlGc3poeU5ZZ0RESkxqcW8wWFdWcUJpTkg3S1BQdkhIWWREcTY2?=
 =?utf-8?B?bW1jeUo1TTlMakt1aldLaFhxNW1wajdFMm9ZRWxSek5jSTZWME9jODZQa254?=
 =?utf-8?B?a0FJaHg4Sko4Vkh6bytRYytGcnIrL1pZMzMwOTlMb1FWUHljckc0anVQRlZL?=
 =?utf-8?B?OGZxa1pIVGZ4TGdHZ1RoSFJ0c3Q0bW1JNm5BRUJYSFV3N3hpd2htVlZub1pi?=
 =?utf-8?B?cHZZTUhxTHhicWlWMTFDM2E2cVd1N0NIT2ZJbG5wOUFEVlBsbzV2WWlsQ3FZ?=
 =?utf-8?B?bXhqZm5mOVRGSHo3N0s3eTMxKzFPN2QxYWpOT2FHT3BlR1JoRThDN1Z6cCsz?=
 =?utf-8?B?QkxHc3ByS01GWTFwTkRMUXdjSGxLVUpiY0hjekd0QnMvSmljdGhTbmNydG5P?=
 =?utf-8?B?WXdOQXN6cmwxVXByb2prejNEaFg4d0pWbktTWFdEMmFTdGFkcnBOQm80TWVV?=
 =?utf-8?B?cFlMY3dzNVo0ZzY1V0hDVjhqbVZBK0JLSkVoVWVZV1NCOTlMUFJzeno5WStr?=
 =?utf-8?B?THhkRWhyWU9FRDBKem42N0xpZmVJVUtkeXJ5Wklnd0psNkJjbXF4aHMzTVFF?=
 =?utf-8?B?YkNhQVZKOFFpaWJhbjdHSDJUTmNxT1pndWptbWFlSFk4MW1BNThxaGVidks0?=
 =?utf-8?B?VFUzdEhFckRyODBlVnBaRzRkY045ODA4VzJiU1hCRGlnOEVmcXJxMW1Vckl1?=
 =?utf-8?B?ZEtzYTVFOFRCbkFkdDIyK3FwZ1lhbEMwZWZPaTBWaHNDaGJ2T1hpY08rNGdN?=
 =?utf-8?B?aHIyQk5EeTZmZy9LaDVSN1FVK3BHVmc3ODMrMzMzYm5LdElDNmw3Q2w0eXFt?=
 =?utf-8?B?R0docnU3ZWFYQUdVeDNzNTM0UTkxZGpJOTBBdDVvZHFKY0JDcUNjcDE5TnR4?=
 =?utf-8?B?MW5sMXU2cG9pSlBxcnNFNk4xK0JucFA3Ylg4b1JqK2lMdi9NNHpSWjZ0UkhT?=
 =?utf-8?B?MFFHM2FCLytUNmNYV2wrWTM3WnRJMmphcEt3cTJneFpFUW9wR3dxSlhuNlJq?=
 =?utf-8?B?WmlXaWEwRFZtNy9lWGFuUWkwTnlCWUMxTlU2c2k1YTlsMkVNMDBwMStON1ZT?=
 =?utf-8?B?NDV3VlZ1WnJZY1FENU9kQXB0b0lhYW5FV3lxbXRyelZVM1BvY2NUS3V3c0to?=
 =?utf-8?B?UUpLYmg0L1pwbVBTTDVBZ1hGdjNvU1AzNEJjd2xGSG9wNW0wN000WFdERDZj?=
 =?utf-8?B?NjJicWZGOTF0RHFRZE1obmQ3VmY1eXlDaUNrbWxqbWdVeXJJbE5HZHpJVmtl?=
 =?utf-8?B?ZVQybVNOaTdnMHo1bHlyVitwb2hJclNqeWl2Y3Q2aWhLSHQxRkFCem9LanBl?=
 =?utf-8?B?UFhzWnNuVzg4cTRiWE94M0N4NUd5bnRJTm85NTZweVFrbDFURmNCbFIreCtT?=
 =?utf-8?B?SjdIaEZPVENMNU1Dd2hPK1ZOeXJaY1htQVdMZEhOWEFJT1lFRUNnY25zMG83?=
 =?utf-8?B?WFVZcUFzZ0NoeUVHZWJkMGhaNFU4WHJDZWpzNUwvRTdwUXJONkVGbW8yUlZt?=
 =?utf-8?B?eGtJTnQ4OWxmY0x0WjBkY1RGcHlhOUhxa012TWZMN1h3KzdXQldkSGxDUUlS?=
 =?utf-8?B?bFJlMDN2Y0NkdzJ6OE5mcC9wR0ZYS2hyOFZDWG1MTFU0aGJ3N3pSQjh5dm1C?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88ADC3806E0EB94E95853009EA2095BD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6faf1f0b-f145-445f-6d02-08dabc6c7750
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 00:52:07.0439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XayO4RVZoBAJb3/JvXhRw3Zl2SMA5+QqOK0y8A8OtMqUonIXV0nGY8QqKELK6oKTvgE3ceWSeMFsvsyEk2tCHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMjcvMjIgMTM6MDcsIFZpbmNlbnQgRnUgd3JvdGU6DQo+IE9uIFdlZCwgT2N0IDA1LCAy
MDIyIGF0IDEwOjA1OjEzUE0gLTA3MDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEZv
ciBhIFpvbmVkIEJsb2NrIERldmljZSB6b25lIHJlc2V0IGFsbCBpcyBlbXVsYXRlZCBpZiB1bmRl
cmxheWluZw0KPj4gZGV2aWNlIGRvZXNuJ3Qgc3VwcG9ydCBSRVFfT1BfWk9ORV9SRVNFVF9BTEwg
b3BlcmF0aW9uLiBJbiBudWxsX2Jsaw0KPj4gWm9uZWQgbW9kZSB0aGVyZSBpcyBubyB3YXkgdG8g
dGVzdCB6b25lIHJlc2V0IGFsbCBlbXVsYXRpb24gcHJlc2VudCBpbg0KPj4gdGhlIGJsb2NrIGxh
eWVyIHNpbmNlIHdlIGVuYWJsZSBpdCBieSBkZWZhdWx0IDotDQo+Pg0KPj4gYmxrZGV2X3pvbmVf
bWdtdCgpDQo+PiBibGtkZXZfem9uZV9yZXNldF9hbGxfZW11bGF0aW9uKCkgPC0tLQ0KPj4gYmxr
ZGV2X3pvbmVfcmVzZXRfYWxsKCkNCj4+DQo+PiBBZGQgYSBtb2R1bGUgcGFyYW1ldGVyIHpvbmVf
cmVzZXRfYWxsIHRvIGVuYWJsZSBvciBkaXNhYmxlDQo+PiBSRVFfT1BfWk9ORV9SRVNFVF9BTEws
IGVuYWJsZSBpdCBieSBkZWZhdWx0IHRvIHJldGFpbiB0aGUgZXhpc3RpbmcNCj4+IGJlaGF2aW91
ci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KPiANCj4gRm9yIHRoZSBzYWtlIG9mIGNvbXBsZXRlbmVzcyB3b3VsZCBpdCBiZSByZWFz
b25hYmxlIHRvIGFsc28gcHJvdmlkZSBhDQo+IG1lYW5zIHRvIHNldCB0aGlzIG9wdGlvbiB2aWEg
Y29uZmlnZnM/DQo+IA0KPiBWaW5jZW50DQoNCkkgZGVsaWJlcmF0ZWx5IGF2b2lkZWQgdGhhdCBh
cyBJIGRvbid0IHNlZSBhbnkgbmVlZCBmb3IgaXQgYXMgb2Ygbm93Lg0KYnV0IGlmIGl0IGlzIGEg
aGFyZCByZXF1aXJlbWVudCBJIENhbiBjZXJ0YWlubHkgc2VuZCBWMiB3aXRoIGNvbmZpZ2ZzDQpw
YXJhbS4NCg0KLWNrDQoNCg==
