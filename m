Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DAEC77B7A
	for <linux-block@archiver.kernel.org>; Sat, 10 Jun 2023 22:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjFJWwU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Jun 2023 18:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFJWwS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Jun 2023 18:52:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BE526B3
        for <linux-block@vger.kernel.org>; Sat, 10 Jun 2023 15:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vfxa7lRU5LKR/BaFdOuyt9OUetMqDnkmvCcHDRrvfZ7uzEZd92qiqpphIvO4u7hQAAntvDDBoANKhbW22BP58Xz4MZAJwFn/FynkY3zHrq7TTw1mEnvXTiF32xPqv87JH30tMvu3uG4mvGDaL6KXNhfwNR5O4/kLGLLySZpxhSCsaN2+nl3DPW5aHadk+nfacMnI4P7WY5txJvY2VBp09t4mvgvXjn9VjxLTVHnI4xmDnpuSE4d62TUV2g1XKwwKUmVauWIawe/mTmJePlQwrciLHkEuf0J6+FRBA5LOagM4hAroldmP6Slgxd9VBOeuECDh5HOqqPLF+7tz8iRg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oo6HEnDQpvHgutw25lz76PEw3W1EVg4iJFSatIineE=;
 b=i+KnDrkQx3R/Jw2H5R472S31Op/83ua+Do0Rh1DV0cSmmi3AveVJdExLprxd58rqBJvCJ15feC9zrpq84PIjuxD3+J1qpCBEgGxQiAsQGn/umkMStt7yZ9fMJxW6T42Gzg60YYWOCqPi5BELikf1tnPHGmUSJBHzw6DvdCOd2EyLargiy4KElAjI1iLso71Gw+PDRBanPjjJfjr2XBBT1iMZ3cMFG6H7BEydFfwjlMEGPnEV6Tp9v0YFSbXxieiHwT4jvZXhFFtfBREmDA8LIzUCFvO5xXAQFKNcMqBmWJxxqWxgdhbBp5/m3gAoX96NnlUQmQFdx//a8Mx3ABcN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oo6HEnDQpvHgutw25lz76PEw3W1EVg4iJFSatIineE=;
 b=lKfvElV+4+DVkC1pB1jVSO+9XEQ4bi1e0GtsKb0N5gVTMy7tL8ZxoQsrKcgTvOJ7S7yQqslb+1lmxO5qvMLm8+G1IIfFXYRETccprr77Y+RU6TSBKvmxiBOOLPDDTbgosrmTLvrtMimrrjv+evvhkXk9NYpogdPvtrXWmFy9ijxUXbitHgr24G4s4YWOLgIPQE/l8CVfKeZie7RnnV5qyMVDAHVO5hrg678+3hpeOFy9odXwUPOWNa5LBpTIYBSIXwCTSRrGUSVOO5QHRFWYnaE1qh9Gu1vyCtfgcS2Q1Bug5+hPM98kKkFMd8mzFHInp6uu9Ag4ky56GnFxGC1PjQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Sat, 10 Jun
 2023 22:52:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6455.037; Sat, 10 Jun 2023
 22:52:13 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     John Pittman <jpittman@redhat.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "djeffery@redhat.com" <djeffery@redhat.com>,
        "loberman@redhat.com" <loberman@redhat.com>,
        "emilne@redhat.com" <emilne@redhat.com>,
        "minlei@redhat.com" <minlei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: set reasonable default for discard max
Thread-Topic: [PATCH] block: set reasonable default for discard max
Thread-Index: AQHZmv13itcq4nc7jUuoKVpEpNi0xa+Cz5cYgABduICAAXkZAA==
Date:   Sat, 10 Jun 2023 22:52:13 +0000
Message-ID: <a8f75c28-9f17-1a4d-960b-1cc1b1c92d73@nvidia.com>
References: <20230609180805.736872-1-jpittman@redhat.com>
 <yq1legs1nns.fsf@ca-mkp.ca.oracle.com>
 <CA+RJvhzPfmjD0FZxWS5gFeZJWKki5OcdmywZdngqhgSjm6wiFA@mail.gmail.com>
In-Reply-To: <CA+RJvhzPfmjD0FZxWS5gFeZJWKki5OcdmywZdngqhgSjm6wiFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB5602:EE_
x-ms-office365-filtering-correlation-id: 07c69d11-6570-4b63-28b6-08db6a0554c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qqkSWJsCkP/ib7rTAaBrvLYMe2jUuA4UwFbxPhE57oTQT3VdLEHYBsOj+I3K04pCe/v/bKPoJ2X4Oot53oRyZ07WgRk9i2YngaIfcF1H4ARyei7nyUu8KHO0yWBDcl9TdvyM4AaKQJKnSE4uzTio5oQTYwRRy70EP/6gydlFRS6t//Ag9QYr9u+VFFr4TuMrR/fQkdlqYzU7PcOaLsO9P6W3uRx5vNN6J9CP4N/fyX+OXOIMEWgmLth39WBZPxDWttDpurRG88DV92t08O5IYmFNp/1ShlD3EQaY/yZYEZ33nqny1ArRPoyF802/mtiAMllybmKyDdhSsjZnVyKB7lmmHl8RbMtkrrljzFoH4tfxg63OVH76fV8SV4USO7/Rb/DcrgjtoYwoWGhVwJHQ+Z3d9dRkC+rf9Q1evEa1HrAkpxuu2kCn4yqUR/OUd3aLuEYgZOLEXPZ/orYu5mJgz0uBSSB5IUCIXvh7cGdWkR1zEySwX5xYbdfObn8A6BXNorwFaKZWHv+c1kUp518ph38hANrQFJ1jj0I9z4gtV9xuFIY6iZ13ZbFNOws4RgCbsVLSw0FGtaPzs0oz7gwR0mOJkEBFgBeu4Iyj5lLEbBwtuV8U69TnODPQzIhMLouRBvRjBS57EL1yfIXVMCRBxIXDBD75Ab/yvmh9Is0xqBP+vkhLxSiU+1GGKGHZuWTK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(38070700005)(31696002)(86362001)(36756003)(66556008)(54906003)(478600001)(6916009)(4326008)(64756008)(91956017)(76116006)(316002)(71200400001)(66946007)(66446008)(66476007)(6486002)(8936002)(8676002)(41300700001)(5660300002)(4744005)(2906002)(38100700002)(122000001)(2616005)(6512007)(6506007)(26005)(53546011)(186003)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXVmQjdNMWo5WDI0Wm5CSEQrREQyZktPdjdCTGJnejMxS0RCcEFwMzFPdVhH?=
 =?utf-8?B?bjZyeGhCTkZ5emwyZHNyQytXWnI5Y21qT0xLMWdlLzhVclVGeWduWEZaSVJa?=
 =?utf-8?B?RnEwWERHKzVaa2FpN2pkWHVHZHdKQ25CMWFYcGxwMmZrM0ZJY25VbWxXUUdW?=
 =?utf-8?B?QUhzZDd5MkZkSHloSi92SFg3ZEhjU0xWSDZobGFxb0RFa3JDN05GSUxJSS9k?=
 =?utf-8?B?clhSalc0VS9vbGIwZHVXTy82VUNScCtaVG45QVlDdkxRbElGVFp2VTNwandN?=
 =?utf-8?B?aWcrd2UwWjNmZEg5cVU3WWRTYlh6djNMWkU5TzNXeG8wZ0d2Sno2ZCsvaGll?=
 =?utf-8?B?amFZWHlERWQrT1FrM1BQRnphbnAvUHFPdW00RGpzdlNPNmx0L3B4WExubmpj?=
 =?utf-8?B?Qk4zaXhiZVdJMEI0VkQrc2ZkR0lTM2ZwQitrNkRVWVpvUFREbU5uOUVzVUJ0?=
 =?utf-8?B?WXQreTc3WmZzRklNQ1ViSVFWT2x3MmdXTTNacERJQXBTU3hlWTN3SERwNG5u?=
 =?utf-8?B?VGNKc1R1R0JmcktSSk5ZWlM1bitDSCtaTzdjR3k3UzE5TGtyU20vckVEMHRQ?=
 =?utf-8?B?OWJlZ0ZZUzNSd2ZJQ2FONlQwMHhFcDYwM0YrdnRKaUYrY2w1ckowZnQvdjdN?=
 =?utf-8?B?c0lwNXAwL2tTamtwbDQwMGZvdVVyS205c0V1cUYvNlRvWWlydnFFMjlhVTFY?=
 =?utf-8?B?ckZIUmlFaDZ1NHg2K1JTK2dKRWVqL3RCWjVXMWhnUUdkUGdQS0ZBNE53N2Qy?=
 =?utf-8?B?QW1MTVFiRnQvNnRhV05FRkNUZnh4S25XUExEQjlnOE5zeVlkdzUzTkNRUTVP?=
 =?utf-8?B?WHBIOFg2WGp0V1ZKcEE2eDFRbWZteTZzckc3WmNOWU5XbjJqOWJNaWduUXd6?=
 =?utf-8?B?T0U0UmJLVzV4RE9aaXdCRElYRWNoY3ZGcmlvTXBrd1RQWmRvM2hMa1ZZbENi?=
 =?utf-8?B?Z2V1dDM0Y2gwTEJPaDBSdzE0WWFMVFhTUWF3bnZZTzNWenhEdE5aL21PZ2dm?=
 =?utf-8?B?Z2hVV1RqYVY4VWhzQlJJcUdZVE9jUng3OTBlc0VoWlRUUWpCMUo0bllFdGdS?=
 =?utf-8?B?QUl2SjBqQWh6TUhoWTBReXJCZzRtTjJWL2F4SVdJemZDUXhxc01BUis2b3Bt?=
 =?utf-8?B?cm5Db1VTbEp3UUdqdENCY09VRFZoQ0l3Qk53SU81WW52MndFajZiRXV3SWFE?=
 =?utf-8?B?aU94TnJ2Zlk1VGtXaVFMZ0JCUksxTTArc25QTGM1YWRRNDBtT1ZDSjI0VjBC?=
 =?utf-8?B?NHo5WDFvN2ZjbnJNei9IY2dNZ3lJMGwyVVRWVXlkaURZV0pETEd2eERiNkZm?=
 =?utf-8?B?aUdVd1cyMmFUYWJkZmRqTFA2UjduRVhPTDhZNWpJVlowclZJcUdabEh0VldJ?=
 =?utf-8?B?bCtJR0JxY2h1SG11eEdDbnVuRDIyU1JuWCt5STJXM3pBQ2lwRVd0U2xIU1pM?=
 =?utf-8?B?RlJtT01SZitUSDdDaXBCVWlkNStLbzlmMzFVQjRPR2RhK2VWVmxLUDVHb1Zs?=
 =?utf-8?B?c1B4ZWkyNGd4cFViOWtHTnhaRHJkTXlPbUZCOXlSK3M5REN1UmdCUmZnNGlm?=
 =?utf-8?B?ZTQyS3c4dm9kMkJ2VFVHV2hkRlJVSEdsVlBKZ2lzSDcrU01FUmwyVFhsTHdr?=
 =?utf-8?B?TnFBcGl3Rzg4emJqVHBwbVZhT0dkakpic1AvWVQ4alpYcyttTFlGRFNoTGVW?=
 =?utf-8?B?N1dKYXVVWG9nc25pbk5pSUI3U1gxQVZ3anQ5OXc5ZEhJM2EzWFhzbFlaa21p?=
 =?utf-8?B?NUhIMXB3emQ4Y0hJWFFlVkxHVHdUd3hDR3VTSTNPTGFiU0RROWtNQlhhbHJh?=
 =?utf-8?B?bmJ6SkZjUTJEOXdtNE1tb3VpN0Z0SmFPcG1BNG54VllwWTVJUFFaVWZiaEVR?=
 =?utf-8?B?RmRxZzliVC84aVdZUjJLSk9abXFEQWVnQm42R3NqZzdtaXNIVVQ2SXNoanNm?=
 =?utf-8?B?M25ObzdvUGlRSzhCVHFVWnFaVTZLandBclVEOVZPRzhQbHJTZi94SmxwNTNi?=
 =?utf-8?B?aDltR3JEdnIzc21DUStzY2N4a0QxN1UwYUZ1RnFUV1RnemFvY1dtZDFnSk55?=
 =?utf-8?B?amU3VDdadHpadmV0Y080b2JCR0d4QkZHSFprTm56c3B5d0FTaG8yWlZwUDQ5?=
 =?utf-8?Q?S9gXwNfil6LzirSUdxS/Hku28?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C999B603CC841E4996626E929613E9D3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c69d11-6570-4b63-28b6-08db6a0554c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2023 22:52:13.2182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rmr/Pw7PHgQdlMQmlheSB17WkNuV4cMeTsEZpuo+gelwQBhFtRkv8k90uMVulidh1wbZppU0BPSM2bXQ/NGuHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNi85LzIzIDE3OjIyLCBKb2huIFBpdHRtYW4gd3JvdGU6DQo+IFRoYW5rcyBhbG90IGZvciBy
ZXNwb25kaW5nIE1hcnRpbi4gIEZvcmdpdmUgbXkgaWdub3JhbmNlOyBqdXN0IHRyeWluZw0KPiB0
byBnYWluIHVuZGVyc3RhbmRpbmcuICBGb3IgZXhhbXBsZSwgaWYgd2UgZmluZCBhIGRldmljZSB3
aXRoIGEgMlRpQg0KPiBtYXggZGlzY2FyZCAod2F5IHRvbyBoaWdoIGZvciBhbnkgZGV2aWNlIHRv
IGhhbmRsZSByZWFzb25hYmx5IGZyb20NCj4gd2hhdCBJJ3ZlIHNlZW4pLCBhbmQgd2UgbWFrZSBh
IHF1aXJrIGZvciBpdCB0aGF0IGJyaW5ncyB0aGUgbWF4DQo+IGRpc2NhcmQgZG93biwgaG93IGRv
IHdlIGRlY2lkZSB3aGF0IHZhbHVlIHRvIGJyaW5nIHRoYXQgZG93biB0bz8NCj4gV291bGQgd2Ug
YXNrIHRoZSBoYXJkd2FyZSB2ZW5kb3IgZm9yIGFuIG9wdGltYWwgdmFsdWU/ICBJcyB0aGVyZSBz
b21lDQo+IHdheSB3ZSBjb3VsZCBkZWNpZGUgdGhlIHZhbHVlPyAgVGhhbmtzIGFnYWluIGZvciBh
bnkgaGVscC4NCg0KYXNraW5nIGEgSC9XIHZlbmRvciBpcyBkZWZpbml0ZWx5IGdvb2Qgc3RhcnQs
IGJ1dCB5b3UgaGF2ZSB0byB0ZXN0IHRoYXQNCnZhbHVlIGFuZCBtYWtlIHN1cmUgaXQgaXMgd29y
a2luZyBiZWZvcmUgYWRkaW5nIGEgcXVpcmsgaXMgcmlnaHQgd2F5DQp0byBnbywgYmVjYXVzZSBz
b21ldGltZXMgdGhvc2UgdmFsdWVzIHdvbid0IHdvcmsgZnJvbSBteSBleHBlcmllbmNlIC4uLg0K
DQpBbHNvLCBpbiBhYnNlbmNlIG9mIGluZm9ybWF0aW9uIGZyb20gSC9XIHZlbmRvciBJJ2QgcnVu
IGZldyBleHBlcmltZW50cw0Kd2l0aCB0aGUgcmFuZ2Ugb2YgdGhpcyB2YWx1ZXMgdG8gZXN0YWJs
aXNoIHRoZSBjb3JyZWN0bmVzcyB0aGF0IHdpbGwgbm90DQpiZSB0b28gbG93IHRvIHNpZ25pZmlj
YW50bHkgZGVncmFkZSB0aGUgcGVyZm9ybWFuY2Ugb3IgdG8gaGlnaCB0byBjcmVhdGUNCnBvdGVu
dGlhbCBwcm9ibGVtcy4NCg0KLWNrDQoNCg0K
