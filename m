Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD8EC761AF
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 18:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjDES5y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 14:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjDES5x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 14:57:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF6759E2
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 11:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhnrnxzYM4zLQKq/EOhnXuXjT67R+i39JY0SmHcJoHlWBZZXOVgCmJJsmWf6+JsVWgmYF26LVsB4u+kKNay+MC/EvtiIDShGZ4QtYVUaKmvaaWdoPFlbYcv2ERGICZ+ZL5kBj9ycd04mM2nTIsEc+FlaDfkJv4ljWjqLnQapJcxZ7CIRyvVMh7ThFSNuEm+yfq7qogCDGil9T8sx1WuwZnExQVPT5uWfFdWVlVXrINWGwYvhXsXxQwHnnF3xbwNIN1on7zAAtHEgvGj1hiZAxLZhjxSMZh93i2zVIEATAf03YjkZDd0Z8kkJUrBAq82cOiokaKKrRM0kbv02iGPNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyWIGBPJT/akG3k7+nuOpJ9ndY9qdcuUAW65BHEneOc=;
 b=PwP+W15JIRZlt3r6spDp/fuos8MZO7h2Ddrb9ARS2v/YAxUH2MfG8fLsRHHGeAxXVgy/2Sx0rY15KZ7j22zyb4lp3tdfRR0LJNf+XWN4uNdsD7T1UUMypJy55OMwzQ6IsOsjnQVODD9xOG480EGAGC87v5aVY4DsS6YS/a0+J6mcN1ex/jrNAzo81H0UslPhJrMnri4lNvPonFQ0f4cub/+Eq+QXWf48+doB5MZMQb/Hk0AMdW1vHSSIjPX1Gy4gY/pEOojK4Ig9sPxCGcjsQ5+LM4laFdtlhOuh159ISYKEpcgHy3UB8SscQq62Lzd8FFkJzRyecufIwWam42b3Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyWIGBPJT/akG3k7+nuOpJ9ndY9qdcuUAW65BHEneOc=;
 b=ZH+aU3i6EsFAY79cbLD6cqFcflujgBHxLPpOIf9YD8enqc+US1oX5uXs89iYfbRJt6ejdGAna1Zb1Cau9TvGwSZtFABF+FDjfVsyTgti9n3gjuXogXfRsmvVYJMDoNqQYtTjsRIRAHQWm37MEFwsKC1YDSBIsmkTISZmgnbLPZeoW6p8rKM+xQRapZIE+3nLMrmztTuc1U9qnweIdaiz8T4q4s2Bjnp3+YmpB9/T1YEGdNbZAJd5VGTph5mKlCaBqU0ILv8F0JNkRutykZSRIx5J54ERxTX8d9Rx8e2bZj2K6K6nn7iMFjF5irSE+n90qEYYqNjb1dGTfierNGyE4w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Wed, 5 Apr
 2023 18:57:49 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 18:57:49 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v5 4/4] nvme/048: test queue count changes on
 reconnect
Thread-Topic: [PATCH blktests v5 4/4] nvme/048: test queue count changes on
 reconnect
Thread-Index: AQHZZ9X5/fquS5aXZUWrqdtzWxsMWq8dEVyA
Date:   Wed, 5 Apr 2023 18:57:49 +0000
Message-ID: <b469de5e-0005-b123-8473-6b95661e78d7@nvidia.com>
References: <20230405154630.16298-1-dwagner@suse.de>
 <20230405154630.16298-5-dwagner@suse.de>
In-Reply-To: <20230405154630.16298-5-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB8538:EE_
x-ms-office365-filtering-correlation-id: 2e0ccb63-4772-4674-5b86-08db3607a6e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: irZOJGxnahI5acdS/F6PlnaT0SkWnRr0vMkbZrFMYRxOXLiiZeobX67YHixdF6OAJoaur8XOZpErwDgl60tKBPGl1Et/IISJXzfKzuEkt1E2HyQQONodjmY4h8NeLdwo/udTIA/F5C7Xk5sGuhoqh92lUN1oKweQpyQZoYDIpHYE3Bj/+vkqfdpKNu/10enMZbbjCk1jQ3YjEo/KIf7Y0WVIYBo4VUUmlv6Jv3R5Uq3AVshnam1n+vQUP6CRMo6RVPcWFxlrZwflSshIw79JOmemugiaUst3zNXb2PgIHKL04J7fnc76V15d1iq1ZfFHucEIF9yU1Hj+cmCAlSSxg/nOOQ0eNrWLb0Gop9vE//jgfJbY7xojL6lfmU8i+RaSU6vuoiDYQQ22XVSl3mp6JDVAEtWaB3xjAkmFN+10E5C92+z3lI1zSCYmzhEF5KbBhfMTqUCMxJ21Dxbhw0o3ucFH8hCupxgOf/7uEpDoStxq0ZfT6UHWgXiMQOTOE+NlSS7MwIexdBLANfdx1QTOVWkrPUs6lTipoP8d5NixPjPzvjec23e/efhdgRPjR9wvFa+/sd/nXeTU6VtoduH2/D35OYaAcDEKmoNuCZ+RvGyy6nyT5VOj0gcNj5Tkhts6iP1+QuDavyZG1+bVxn7TXRiW/fBzTavNtp4CjXZASeQgcswl7XCHLFLcWRL6RvYN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(36756003)(110136005)(8676002)(66946007)(91956017)(64756008)(6486002)(66446008)(76116006)(54906003)(66556008)(316002)(66476007)(41300700001)(478600001)(122000001)(8936002)(2906002)(86362001)(6512007)(38070700005)(5660300002)(31696002)(71200400001)(4326008)(2616005)(186003)(83380400001)(38100700002)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVc1SVplbUMvVU40enE2V0RCQzdtRDR1OEp2OU5mbmFnMndYMnhHSkMyRmYr?=
 =?utf-8?B?SlFKY25rRHNzVDVWWEdST2c5S251dkFSR0hwMFlwaU9QN0YyMXc0bFRxQzUy?=
 =?utf-8?B?NmFXWmdRYUxlUGZyUy9BNFFsSVJrNnRDSVJKZzdBeUtwYWZYelFtczcyVHdM?=
 =?utf-8?B?d1JPNzdFWmNISHdSYUZzWHBrcW42SFhDekthTVRlL2xaNEtXQmx0Q2xnQWxZ?=
 =?utf-8?B?WTQvR1J4TkpzY0M0WXVkRGJpM2xMYkpHSGI2aG51VEprS1pNV211NjBNaGVl?=
 =?utf-8?B?QjA1M0ZMWG5zMkp4Y09ZT0R6emVoZUZ2UU05L0xwazdDOG9jNld4K2kxTy9a?=
 =?utf-8?B?U3lRcnN6bWc5SjB6SW5sbHg1U2d0QldFN2xlQWVoejhPeEcwc2dHdTE5R3U5?=
 =?utf-8?B?Z3E2NHB3bWc2czAzdjBOZzI3TGpKVm0xS0hqS3lJM1Ztbk9IajYrNndlc25m?=
 =?utf-8?B?WEcrSFkyQi9VVER2NUpvNFljSExMbzBRWFgybUpac21GdUN2eHhjVGVHVDM4?=
 =?utf-8?B?a3h0QVltNktTZ3g0Q2RyQU44QStCRWJyV3VGTWV0emNnekJ0NDkzdjV2TWJQ?=
 =?utf-8?B?K2JaU1kvLzRpY20xTnNXTER6MGVVcDRiVnNjVHRHU1dWa1h0Ukh4RTZZTTBn?=
 =?utf-8?B?czl4Wi9nc3lQQ3lKMGkyekVKS3RGN25Gd1BDcW12dEVJRHc3L1R3bkhkVlJ1?=
 =?utf-8?B?MUZ1TGxHWmhwUFVxMDlwQmhJbFJWTEVFaWxkMGs1M0JuTkhSenBnN08xTlp0?=
 =?utf-8?B?MjZScEdPdDh3bFBHLzZKenRDYkJNU05ZMStZWEo0TkpOMTZlWkpyNktSZWg3?=
 =?utf-8?B?MFJVakkvTDFoK2NKNGNnVXJwRDVHNThyY2E2Z2RsbzBVcWxxZnRrSkVzbFdv?=
 =?utf-8?B?YzN1N1JXeUhPcDJPcjJBREZ4TzRXbUhYR3RWV00wdTIyRHRtUkFwOURQWWhs?=
 =?utf-8?B?VUVlZ3Vjc3AyRS9LMkM3Wlc3TE1hVklIOWlaVW1ock1iYUdmQkhSUWhnUnpp?=
 =?utf-8?B?a0NGTXd0MHgvTVlzaFEwQTBDY2ppQlNYaFNmamV5WTI3YXlWNWlib0JKenFP?=
 =?utf-8?B?UE10Rkt0Tis4QVVWWnFBWEh2dFllNHBPcytBOHBXZ0FKVnpFQUxmb0paeng0?=
 =?utf-8?B?ZDZwRnpWQnA0MGNYaGlsWVJVMnBaQ0g1MWI3ck1KNVk4SGJjUGhYaEJMV0Zt?=
 =?utf-8?B?YmduWlZGeHpjTTRmNDBBVXhWb2JXY1RzVjVnY0lLT2NKR2MzQkZOejhBVENn?=
 =?utf-8?B?UU5lR2I1dmtXQ3RsYzhMQnJtMGtRVVIxc1AyTFpYSzNHdzdPSklrWm5Ud2xm?=
 =?utf-8?B?a2FQcXMrcmZTbHJyaCtpeVBoSmtXeTZMdVVhTTBSNkFKTDBua21XU0NGdUpm?=
 =?utf-8?B?WUQwK1JOL3VERmxOMzI0RHBrZFFWa0JJRlpQQWgvZnNaSHduRXpZNnNIRmUw?=
 =?utf-8?B?MjNSSlpjT0xGNWF2THJWa01mYTJTbnFzb2F1Z3dZRzkvbEhMRG8wWXd4UEFx?=
 =?utf-8?B?U1Bqa2pabVJOdG1kVDBUdTQ2azB0WGJDNThabTNFekI0U2QzL3NNVHBqQTBq?=
 =?utf-8?B?SjRzOFJuNWJUeDZrUWYxdnBRRTYyQ3RMV2JWelBJbGhKSVJrZUJQVCtzSFQy?=
 =?utf-8?B?aEtnZ25NWUhZbFAwOVpGMHAyNmNrS3ozcXJkRGI3SjFCdmZmTHBMK09UZTFR?=
 =?utf-8?B?VWt2UnBVdDM4RmdEd20vWmRNWnFrNURvK0loVG84c2FxaGI1T2tiR3ZFUDBa?=
 =?utf-8?B?SzlzVWxEdXJqR2NSb21jbkR0eW00TmZHNFhtKzJnNUY2cEZtOElNdloyQnd5?=
 =?utf-8?B?R2hlRE8zc0RWTkVTTGN3V1pUWUpoaGNhMXlaeWxGNHQ2MFY4Z2c1UVplMTdr?=
 =?utf-8?B?Y0VzV3c2YVVCSjJEdU5MT1hQVkNkeFRmWUFYanBqS0hsNGdQeGRFRStUTWFK?=
 =?utf-8?B?QU5INDBWc1VQSjlEeHI0ZWN5dHhnTVE1NEFZUW9mTzMwUGRuSUlvQmEzMnhn?=
 =?utf-8?B?RTZUV2NZVzV2M0FZeE9rNzZ3VDQ0WGFsOGRndW5qbXRiaUJLdUZ3bzZaOWNa?=
 =?utf-8?B?REYxcCt6UXB1Q0hiS3V1NE16aWlBSHVabXJYa0lvT0NkeWM3MXp6bkpZQ1pQ?=
 =?utf-8?B?Y3FlWmJXbFRSRzNLT0RuNCsrbkFBbitoL1NUMU9SK2ZuL2RvUk1uYllEVEdC?=
 =?utf-8?Q?NgF8XxmVbvspHwejZ6h/LRouq9lexVKj98wsPE4t6SS1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DACBCA37CC66464593FF9B2C6AECA4E6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0ccb63-4772-4674-5b86-08db3607a6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 18:57:49.5784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycTBSTQmzqt/lAdO3ZM/NayhPjAmwu+c9tt7Aa7vfF/AQewV9wPPDmhtf/Jzc+p45kR8dESqJwejdNMDCkArbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+ICsJaWYgISBfZGV0ZWN0X252bWV0X3N1YnN5c19hdHRyICJhdHRyX3FpZF9tYXgiOyB0aGVu
DQo+ICsJCVNLSVBfUkVBU09OUys9KCJtaXNzaW5nIGF0dHJfcWlkX21heCBmZWF0dXJlIikNCj4g
KwkJcmV0dXJuIDENCj4gKwlmaQ0KPiArDQo+ICsJdHJ1bmNhdGUgLXMgNTEyTSAiJHtmaWxlX3Bh
dGh9Ig0KPiArDQo+ICsJX2NyZWF0ZV9udm1ldF9zdWJzeXN0ZW0gIiR7c3Vic3lzX25hbWV9IiAi
JHtmaWxlX3BhdGh9IiBcDQo+ICsJCSJiOTI4NDJkZi1hMzk0LTQ0YjEtODRhNC05MmFlN2QxMTI4
NjEiDQoNCmJ5IGNoZWNraW5nIGZvbGxvd2luZyBhZnRlciBjcmVhdGUgc3Vic3lzdGVtIGluIHRl
c3RjYXNlIGl0c2VsZg0Kd2UgYXZvaWQgd2hvbGUgcHJvY2VzcyBvZiBjcmVhdGluZyBhbmQgZGVs
ZXRpbmcgc3Vic3lzdGVtIGFuZA0KYWRkaXRpb25hbCBmdW5jdGlvbiBpbiB0aGUgcmMgZmlsZSwg
YmVjYXVzZSB3ZSBhcmUgYWxyZWFkeSBjcmVhdGluZw0Kc3Vic3lzdGVtIGFzIGEgcGFydCBvZiB0
aGUgdGVzdGNhc2UgOi0NCg0KbG9jYWwgYXR0cj0iJHtOVk1FVF9DRlN9L3N1YnN5c3RlbXMvJHtz
dWJzeXNfbmFtZX0vYXR0cl9xaWRfbWF4Ig0KDQojYWJvdmUgdG93IHZhcnMgZ28gdG9wIG9mIHRo
aXMgZnVuY3Rpb24NCg0KaWYgWyAtZiAiJHthdHRyfSIgXTt0aGVuDQogwqDCoMKgIFNLSVBfUkVB
U09OUys9KCJtaXNzaW5nIGF0dHJfcWlkX21heCBmZWF0dXJlIikNCiDCoMKgwqAgI2RvIGFwcHJv
cHJpYXRlIGVycm9yIGhhbmRsaW5nIGFuZCBqdW1wIHRvIHVud2luZCBjb2RlDQpmaQ0KDQphZ2Fp
biBwbGVhc2UgaWdub3JlIHRoaXMgY29tbWVudCBpZiBkZWNpc2lvbiBoYXMgYmVlbiBtYWRlIHRv
DQprZWVwIGl0IHRoaXMgd2F5IGZvciBzb21lIHJlYXNvbi4uLg0KDQo+ICsJcG9ydD0iJChfY3Jl
YXRlX252bWV0X3BvcnQgIiR7bnZtZV90cnR5cGV9IikiDQo+ICsJX2FkZF9udm1ldF9zdWJzeXNf
dG9fcG9ydCAiJHtwb3J0fSIgIiR7c3Vic3lzX25hbWV9Ig0KPiArCV9jcmVhdGVfbnZtZXRfaG9z
dCAiJHtzdWJzeXNfbmFtZX0iICIke2hvc3RucW59Ig0KPiArDQoNCi1jaw0KDQoNCg==
