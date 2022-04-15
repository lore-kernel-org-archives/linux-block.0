Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27583C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 05:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245553AbiDOF2y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 01:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiDOF2x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 01:28:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ECB972C5
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 22:26:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iORENPT87Kqw38VGkSfQ4wnphi1aJW0gYSdX3w1qnPU6POz0dl5Rm2A6EfOGNdB5yl66119KPhinboT4sXVNrqa0OT5yGTTz5N2t19lqgslfiRzQFjW9/fLNWvxtu5UHw8lLNirlIQz8ZWIC9+Ewxhaal2CytuS4bHqe9/YE86dEao8S6LGiL35aggDRNsOHWwELgMCk355n42mjIR95wlNkSIGONXxgj9nbas0HgB5GYZNPE9DRy7E9Z9wacvqYZqcI4joQWgpcGjngKzb9cjP5rZnrNzt1H/pHaIpQO2jRWlX6GoCtxBuAJ/zMWV0vI3o8JoCa1hFVSljOoNaNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1rYPB2kHJs637kGx16/dwc1qb5a3JqRdMdmk1v4y1Y=;
 b=nSkvuGS3pi/Qx6tCK2oE8AmiadGn8YHJctzXlPkDEv6OzTlnJ/I6493mg+jcxT74Y6tn6Ov8J0FXx8uPvbuOe3q44CASVsOW7R+6+kY3SKwQcAkz1PmKI7ZdX58GTlivDLcop6IfRulBK7KOxHzp3eP+wHL7PTHIdosVw+/KGJxsbxpWL5lSO3tyzAMoT06v1u4daK7wZqtGf79w63orNm9Mlaljv6q22J7vED3qkNJuknafkivolhq7AR2TaBi77ikdrnwn5fWy3v8tRbwFdu9YYrx3bWiQ/JBxqWj7FI817wUmHPZZjHo/NgCrlVzBH8HtGhU0n/DU7IP/w1bYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1rYPB2kHJs637kGx16/dwc1qb5a3JqRdMdmk1v4y1Y=;
 b=Eu33gCdpgfppxmsuQ5tfm0cXvo6jpYVVZPFkr/9GKSrdxcW/T4Mrw8QWRuKFp6gwRlBhO8NGwBL3KTrfOTp5rs7lMlwTLjNLVqBvjv0mkKDnAC0Mr2mUUDADs3DryWV+i+WWBlU7GDFYF39ZgWF8d4fwYFiAzcflo7uzsBEUHvYQBYqdG5pkRn8H5f1PMHwAP4MPOXrRacHcToN0+zokyo87/25u8b+bahtS8TgYy991kXQ/mHkhrJSuGD9F76kfuE0lQqcmEIGOLbQks5LAFaEc3dLDcLHi2g7I8pt6uZ1IOTyGUWDxYCMdB08D15UDxPdbBMjyrzGiKDKB7NC+gw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0093.namprd12.prod.outlook.com (2603:10b6:301:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:26:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:26:25 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] block: fix offset/size check in bio_trim()
Thread-Topic: [PATCH] block: fix offset/size check in bio_trim()
Thread-Index: AQHYT9v7H7lYHYD3ZUi94ZO759zrOazwcvkA
Date:   Fri, 15 Apr 2022 05:26:25 +0000
Message-ID: <e99bdb69-8e04-4d77-2fa7-325c25b7c691@nvidia.com>
References: <20220414084443.1736850-1-ming.lei@redhat.com>
In-Reply-To: <20220414084443.1736850-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 242832e3-be71-4de6-546d-08da1ea07c1e
x-ms-traffictypediagnostic: MWHPR1201MB0093:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB0093360D07712E3A23A7E6F1A3EE9@MWHPR1201MB0093.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yaPMpu75XoP2zYaphZg8er40bT66TmxOI8x74Ohl2L+TX7bxw8uCQw/qH2aWMb4HLqSiPf0k2l9izyWnGlNJB21DVYuipvs6jnQqDKNJTi7tetktJjLkbj4sizQvEkjpyl1sW86NgUrwPmkE2p/PhN+WBNj5D/jzpcKmJ5VqUn7fDbCK4Nz7axSw3RQz5FhBrFVsLc7BUMB+aGLUHR0S5gpuhbAkBXYaeulf59+TPz5evXDdAapXXpqMacyot8uUjXAeE1JA4ge5TJylK5ZZhyljC5oG6NJExx95Vl4GbmQTB7DGIeXvoZ07il6f2sIwIvBenct0i161ZVN6ppH4m2r1TrwQutOc83rroyEgR5or5040QqUl6ne7s25qevf6MeA717V0/0q7/aSVT0eEBx8N64JcYWDMXPLkEru1QKFc0LjX1+152YPIWKUohYzRNBUoweqZMQ4SlidOnEix09w5B319zI2wPB6C4wBGPYnoNdHwUkRkHt4AB0foIQ+s/XQHGPsQLxCzbK2pzJv07cNdKkBCiNyEGp1yT2HnmHmJaD1LUc0pc+vqoJ7hRWEjYqBmkJf/e1ZkkzUR19saYSlfcVO22LBC39rtZPHEVInom/42oJccoEfkXmql1yvhCKOtat/fl3FeOq8J4oMBfO7A8uRsLS+MWf4f519pzqgBgMvE3s26y1UOQwDfuQo+zyVTbnlPXNhYybIJxsHZqpgpN6LPCdu4nzNf6fl5ozmlyMHotC8owX/fDV8ntXfUL7SXFUBWDm5KsFOkbe8uIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(6486002)(186003)(71200400001)(38070700005)(31696002)(86362001)(316002)(54906003)(66556008)(64756008)(66446008)(66476007)(110136005)(8676002)(76116006)(66946007)(4326008)(8936002)(122000001)(38100700002)(508600001)(6512007)(2906002)(91956017)(2616005)(4744005)(36756003)(5660300002)(53546011)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDdEaTZwcWttNmdXM0FucGFkQVdYSkYxK1lVZlFyZmJCVGVkRGM3SmZFdnlz?=
 =?utf-8?B?U2tJcjlvbUdPd2w4dFJGb01JT0kzNUpMU283cTRyVk5EMlZ5QUlnbW5lT3Z1?=
 =?utf-8?B?WlBROXZxZEhJVEVlckZNQkI0MWkyRWd2b21BVTJLOGR5V3BYNnpiMGQxL0xE?=
 =?utf-8?B?Y2dLeTh2MXVmaGhXUG9oTTJ2KzNLV1ZZSEkrejdYUGtGOEZTTHBDRExtOXFG?=
 =?utf-8?B?VjhyaHBGQmpmMjZhWEtlQ0RnZW1hY0tGbmxjdW02WlVWMnlXaXQvSGRDaU1Y?=
 =?utf-8?B?L3AyaUgvVnNEMWJUY2d3TUVGTTM4V3RzVkVVU0lpRWV2THlidkF6LzNFQ2gv?=
 =?utf-8?B?UHlJOHRlKzdxU2pjalpwTFBSdXp6L0pOKy83aHlMM0owUCsrbW9BdGNnc0R5?=
 =?utf-8?B?R3AwUTNMcHkra0tSeE1LWnc2UzQ3L0djbU1mUk91MklwcUNwSGRwaDFwaVNG?=
 =?utf-8?B?OWhCWG1uY3RGVFNOUUszd2srQ2trckJweTdzTHE1RyszNGU1Y1lTTXdENGNn?=
 =?utf-8?B?V0pKMDVIUkVLMSttVUFkK1p1Nk4xNThNZU9xVkxZS0JmWG1taEhoVlJGNStn?=
 =?utf-8?B?RnJNR050dlNOL1ZxT2FEOENOVm9uTy9JSnd0TjlVbmtma2dBd09UN1MzUTEx?=
 =?utf-8?B?M05Nb3JSZEl4aFBQMktjRGw1WDd0d2lBc08vckhyM2N1UG1RUzVwUEV3Y1lp?=
 =?utf-8?B?ZDZBdHVaYkdGQmthWjdkZlFtQ1czRTB6ZmkycFN0ZCs3VjQ0YkRxeENOVFBw?=
 =?utf-8?B?QWhxOG1SZ1VwT2szN0U2eEtiUWFRMXZkQnRuZEpzbk04ZUZHRWFMT2lZdkUx?=
 =?utf-8?B?OGJWU0RDcElVNzdSbHpwWXBITkdaSllaQ2NOTFdseEhodndjZ2xud0RqeENq?=
 =?utf-8?B?eDBXbkNFRXc5SmpqVzJ2NlFneXlIMVVrSkRXOGF4R0tXMFlXdlNHUzRCVzJq?=
 =?utf-8?B?eXpOMFNOdWRPMElBRWtTZE9zSDJwWHR3RjN3RitEKzdPSGV1WXJleDlnV3FO?=
 =?utf-8?B?RnViMDJZWVNZSzUyeWd1ZkhITndPdzNPMjM3ejVIK2J4dUF5aUZHeGFyNE4x?=
 =?utf-8?B?bHZhNVMwUWc3NEN1cTZqVkVqcTVkSVh0d0EvTU1yQ0RLZkx5V0NMSWVYam5a?=
 =?utf-8?B?N09VcGwyVkp2L1JSaUtPeEJyeHllUnpBTFNIR2dseVlzK1JMUXJDQVRyWmxF?=
 =?utf-8?B?VGYyUTVRVWFObG92QnVmYUZSVjBNakNjUitIdnlzUVVEaFhvaW44N1Z2WlF1?=
 =?utf-8?B?dW0zKy9tZ2c3VEhjaUVIbGgvbi85TjFpTTVISVMwR3NUcDdHMm9LSWdvMkRk?=
 =?utf-8?B?TEo2VmEza0tvbU9lRmZ1blNZT1YzL3VxYlRvc2xtTEdiM3habUxVSWwyT014?=
 =?utf-8?B?dGZ2Mml5eU5kREd4V1lKUVhkM0xEbXc1Ky9jcEovTDExdWlRbWZ3VlFtb2pI?=
 =?utf-8?B?OWRDZnJuTmpNc0tnQnJ1UDE5MWVyOTdWdzBCQ3YxOElvWGtIYXFjaU1ZQmtX?=
 =?utf-8?B?cUtQbVQrTDJ5NU9mdisrdGhFZHBDa2djc2NYMVFwb2JoVWVjSmdUTzhDSzFw?=
 =?utf-8?B?L0lRWEZtTlR2L28zMUQ3U2FuTGxJREpSMkkzb01tOWVoN0QvQmQ3UFc5WDVS?=
 =?utf-8?B?QzRGRTcrbTBubEpBaG9JcVRvQkYxQzBrY3NVbmhwT2FhL2NyWlJ6Vk93QXN4?=
 =?utf-8?B?dkZHenVRNlgxTVJNTGtiR2ZXOGFWYXZ1aFdZOGZRb2tSNHREL3ZYbC8zVlhy?=
 =?utf-8?B?RE1KV2RLU3drbmZHamZxUG9odnIwK2ZuSGNCdVQ5Z2RIK2pQMkJpQk05elJh?=
 =?utf-8?B?ZThtU0VZM0pKem05d21ZWEtJU0gwaFlzb3QwNjhPUVB6cjJlYXRtaUR0TVJu?=
 =?utf-8?B?VzNvL0I5eXZLa1FrZGJHa29GZ2NMMzJkUmZQSHlWS0RZbnF3Tm4rMHI0NlNQ?=
 =?utf-8?B?QXNOcFgydWJZdFRNMGduSFRFZFFtczQvcUF6d2R3MTVJODR5SENUVkNVTGlL?=
 =?utf-8?B?NHhBSFBTbmNMbENrV1Q2UWpaTXFnaG50S09FdVFLYjlOR0VLcW00M1hKemtl?=
 =?utf-8?B?K29Ibnk4T3lpb3dDc3psSDQ4R3dDUlQ5RHpJc0Vad0VYVFQ4R1l4YzFqUEJV?=
 =?utf-8?B?aTJmWVd5WXJPVGtJM1NSS0RjRHRzalBSdzg5R1VsRzlTR0lrQkdaRDlrbjc2?=
 =?utf-8?B?Slg0aEJDZ2s1MUFBblhsYW9adUNPS1hjTkdFOEl4Mm9HUXMzWjEzR3VXc1J6?=
 =?utf-8?B?M0o0dDYwNG9qaWE2UlhSQTcrQ1l1Rk1zamdsNm5LQUg0RVJiTmtSUTlVS1Q5?=
 =?utf-8?B?dVdMbEw3d3U1QWkvSytJSGZTOWxBdVFkUm51dEtlNXU5ZXFYdStQcXhia3ps?=
 =?utf-8?Q?uhuwpqmDJCejFfdM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5884C18EEAB73A40A5BA50253991B8B7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242832e3-be71-4de6-546d-08da1ea07c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:26:25.1215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKwJZm7O8QtBgoAe525txPU9y9yU3Bq+VSg450a8Iygbg53l76qZ6wMrCwGnYp5ANiTG/eDiyUUmABuG+8jO7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0093
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xNC8yMiAwMTo0NCwgTWluZyBMZWkgd3JvdGU6DQo+IFVuaXQgb2YgYmlvLT5iaV9pdGVy
LmJpX3NpemUgaXMgYnl0ZXMsIGJ1dCB1bml0IG9mIG9mZnNldC9zaXplDQo+IGlzIHNlY3Rvci4N
Cj4gDQo+IEZpeCB0aGUgYWJvdmUgaXNzdWUgaW4gY2hlY2tpbmcgb2Zmc2V0L3NpemUgaW4gYmlv
X3RyaW0oKS4NCj4gDQo+IEZpeGVzOiBlODM1MDJjYTVmMWUgKCJibG9jazogZml4IGFyZ3VtZW50
IHR5cGUgb2YgYmlvX3RyaW0oKSIpDQo+IENjOiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55
YS5rdWxrYXJuaUB3ZGMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNaW5nIExlaSA8bWluZy5sZWlA
cmVkaGF0LmNvbT4NCj4gLS0tDQoNCg0KVGhhbmtzIGEgbG90IGZvciB0aGlzIGZpeC4NCg0KLWNr
DQoNCg0K
