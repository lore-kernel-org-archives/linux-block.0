Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E42CECAAD4
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 10:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiHaKpp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 06:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHaKpo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 06:45:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEDF7FF8C
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 03:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JipPWF6LcL1Q9An5M5VAJ582xPYQMPn52vV11ywLZircePixDM5jvu5OtvpHGonLtK7neesRtekVZlgbDCnxBPhM2k/WSOmPVN77nUQhJ0GmphT/iK3EXxBH4bda5+wu+eCxR5AXyGTRqNc12g0rHwdIg7N1uQfB4DDLvKKWN4JJD9OLT4dK70oCldx42EcqM1lFtBl4dRKTZXORUQGJaHVVQKzYcg0ez/3kTB6qrdgPyvJz1NbcUoiFKUR6NRS3PcjpNrFlFaG0xnmHQEvOQr39GxX26YxFOCOioNx7SOfwU22prKB2q0cL/SIMgnPMAX33Fs0ZVwXFBbG6VFZV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSj4uHcv/scINmiJcdhUF0Q/vH/V6314Y3+75C8ZSS4=;
 b=G5sTnstSpzIQDzdPa7usXdXxvNHtDn8MkeyW+LQaTRmkxhV/mV85UeUF7z9kwn7P7s17z6d+PCgPgIWG+sG/z+nkYWu/IP8rcAJMe5eFHIWnmmdBtNme0k3sOmPK3Z7RNrFLvkoacRQm5kpIhsYaCEMm2vi+5MtunF3ZAnEACTWjtjUay5s8cd7WjpVLo+f4IayEWufhJhITnfFNvEzzkrtsGxcpRbfWvrbp+9uT9aI+F7w9EZNQDQbC8ILk7dgIHf1HsLQO2wisfHKlt0DxE7KZrosJOLursYNeU0YIPDMYCSgvfWJF0KGgmotYg5v/c+V+Cgbw9jElRhfc9jBGRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSj4uHcv/scINmiJcdhUF0Q/vH/V6314Y3+75C8ZSS4=;
 b=sHFXbjjiw0oSW3mIHOKd8felSmxua2/nkI3GEXJTnxqjbTU3WdmpRGiakaSiLY9wdDOA/x2qkiFsXx0g+Q96zkGbQv4TW1phpkyNApYxJ7IAgrQULZW/A4ME1AMXza96NYZsIOjKd4a9yVCZFYTxi4kmudPw+ZNTmtCOtBttrZcnIH/VNCh4oFpUbCXMi71DPpNkuW/JCruBMgx1VMG+bcER+JZIK4TjoWAGl3BCfTSvVjpPRw3ZVD5Q6haB1guV5l89B5Q36SYy2IS9Xl8mWxbI+Lw/OXqRZ8x7ccvtxkI1sTBYxnQxTaKJu8mtCv2J6xB30jdDbbW18VU9o/QQzw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 10:45:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 10:45:40 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests] nvme/043,044,045: load dh_generic module
Thread-Topic: [PATCH blktests] nvme/043,044,045: load dh_generic module
Thread-Index: AQHYvPphn0PEpPtD4Ea8UQKZLCXHs63I06oA
Date:   Wed, 31 Aug 2022 10:45:40 +0000
Message-ID: <cffbbd55-0560-4ec7-7f88-aae0d71676a9@nvidia.com>
References: <20220831052729.202997-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220831052729.202997-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2f7b89e-cbb0-401d-8b9a-08da8b3df29f
x-ms-traffictypediagnostic: MN2PR12MB4110:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHkputhDSwvTCCuY4L2Jrg7+HVQ53L9x4xmWottzU7CXVXWJvFfiaSdkwE2y2XnJ+RKOURYADRlBUEIMLaD/Yr8OWil5k+7X8NBLjVPqY4Nb6j/F4X6FqxRL3oNgR0lGvCfbcMD4ypsKIwlRpvQ+tPMoteY5aSCWvELw8pekr/rFz1GQKzW+Sx9AntcDHQBLQSdCkjDeaHBEBf9u6T7N8MXsSyEoN6SbWmSevxmJrqxId+5FhZB7LuTEbIKJmA1TCgQrSG5oSrdQLujLRETOzgDJDmcSRYy8MGW/s29cr5tl3jWc/Gf32KY+sd2evebKWTIVfggQhjCJ+kQgSIicTVlHgfOc+x07rDT257U25sQEvILdnxeZ3ymu+SeUMRUCb7JzYC+szM0tuiVJoig3k8Ork+wV/JBbA0nP92CvociDiAioHo0qmafxEzWNLNCWETgZSSwc8hRTjGPjjWuh+TjcpFhKO86qBMmrn8548VCjT9QwbKJhCpvKcJlCZZz6FqvNSpLOicw6Kkc0A3z9ia5Ks2n+tY//Rm9tNmRguLpaul7HE6C6l34DN1vVKYo/TI2DMnPXN6KXpDf33vE89z0FmxzsAYth10Aij8e9Jbn2wY7sxf+1KSqLlpAnPYrWtl8hd0c3lVlY28EXQVwZjylqKGKZhNa+dBD4LQV6Z9kfpzpX7NJcOKN+E5IyY3Elpp6BGcgyZo7KA9KY2SmOtw56PHwEYAssbt8MfboU4uU510qIvLIaF8aGZZOTFv5uvTtno9s6+32H640UA7lm6LuXbwo4TsoXmr0Yov+/9RBg+XfZ+viEfCj/ZDnRLZO+dyxS+z5du30qdrGUoh55pg2MjW+/S7ySbGSKPb1p+8ESTLYlueC+qBErD5Mr9jM2MovMn9cZyg/VkM4gquaBW0ehx5Jj07vZVIdaVxa6l5w/OvQ92ASYtC2o0F4PnRoS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(8676002)(31686004)(4326008)(64756008)(110136005)(66476007)(66446008)(91956017)(36756003)(66556008)(316002)(2906002)(2616005)(5660300002)(8936002)(76116006)(66946007)(478600001)(71200400001)(966005)(6486002)(41300700001)(6506007)(53546011)(86362001)(31696002)(6512007)(186003)(38070700005)(83380400001)(122000001)(38100700002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0tyd1VYRzc5V2NMTklkVzF5aEVqQlFWNGZ2cjU3VlpSWjFtUzdPMTBNcmo5?=
 =?utf-8?B?bmoyenZVMENvZm9EeUl4dTRUWXlZcGVkdjVHZ3dyQTk3MzE5TCt0TmNsdzVK?=
 =?utf-8?B?UllTam10QnMxTW9TclFGWXhENWhVYkRtY2FGZDVhOEt6ejQrZ0dVKzV0Vys3?=
 =?utf-8?B?MEhQLzBOWE1XbHErVUVtcEZONURySmJmSXRzeStYUGt1Qm0zRmZUbVluZG1i?=
 =?utf-8?B?YWQ2ZGhlcWNYTXBFZWdMNzlrWjJwdUJzQkxoRnJOMmNHbE1ESlZlZGp1amlu?=
 =?utf-8?B?YllHZk1MamJqWFRMcmpSbnVwR3RtNElpckE5bE9DcTd3Znc0bHA4cU9weGV2?=
 =?utf-8?B?L01sak8rdlVYV0hTS0ZXakFYMDJQMGRValRUbWtURkI0WkJ5cW9ETXhzenJ5?=
 =?utf-8?B?R2ZqZG1KRHdLVHQ1eEYwa3c4cUwwYU1jbXUzRnVzN2hZM3pEajRpTkh2Ymxu?=
 =?utf-8?B?dGxHYWIzTDdjZU1sTlhkK05KUm52Q2JVUXBuTkJSRExEb3A1SnpvQ3IwOGx2?=
 =?utf-8?B?Mm1OLzl4cjRpQkRUSVdhSHVUZnpyYmlKbktHQ1NBQ0RyKy9HOTFhRXRFdzEy?=
 =?utf-8?B?VUw4TmhVTkZjZmtKOUlqQUt6ZlVPd3lpQXVLcjMwWFBGakFEMFJNT1hDbk5O?=
 =?utf-8?B?anNVSFB5MnJ6blc0YURBUFR0US9IaDFJeVFDcFA2SUJPUWFYdVRqR2lpSTkr?=
 =?utf-8?B?UVl6SE9kOHJYZFA2Z3lZdFhIeTI4VjM1RGpiRFQ2OUxrNEkxeFRxbmd3cmRo?=
 =?utf-8?B?aVZoQitUYS91UDhQQlJOaXlSdm5RQVpLd04weEdRMXB0ZUN2QTY1aDZ2T2Q3?=
 =?utf-8?B?WG5rbEx6TlNZTDJ3a3R5TFp1ZnBBU3RyVFE1dFFGRjVRUDBXTXcxZU1DbmtR?=
 =?utf-8?B?cmxtWUtzUHViSGtRQ0lQWDJMb0Z3SW1XUG1qYkMwTVNyRFVtMlZMaG1GdUsz?=
 =?utf-8?B?T29NTGd1Q3ErN05aNUVNRnVvZnhpTmo4UXVGNllzWTVLczNNR01CeHBIRG43?=
 =?utf-8?B?cVF2VU1ZZGNyUEhLUThIdkJUM1VrM0hBQ1RpMEo2MlhBVk1pOFVIMW13VlNO?=
 =?utf-8?B?cUZGV2dQZ0dCWWE0SmszSGI3Z0E3ajBlSmJlRzNteGRnb1NYVm1WTGR5UHM0?=
 =?utf-8?B?U1M3c0hlK2VRaHJpdUpQamt6QkxaRmNWZTk0MmVQOXlLUk1CbFBNYjRqcmJm?=
 =?utf-8?B?am5XOWUwU2NUNFNXT0F4NGYybisxbDVYcUd3VDNHQ0RvMHlBSy9SZWZ4aURF?=
 =?utf-8?B?WUN2T1hvUE9NS29JSWlHU0xhelJSRHFDWlZOM09GQ1ovajNXWnlkcnJnc0FY?=
 =?utf-8?B?OVZJQ2hIWTZtZW5EM2k2MWROdXlwOEVNREpsOE5LamV3SlZqdlFHNkIzOEgy?=
 =?utf-8?B?ZDMwOTl3a1h5bnp1VjB2VDFhSXRqRjd6QmEyV2tBNjNFQXpxRnZ4MHRUbHUx?=
 =?utf-8?B?NHRhWThRUzh0eXhVTUZUS0FiUG9lV3ZVVEo3aWpkeGs4RG1GSzJLWVMrMFRx?=
 =?utf-8?B?M1EvOXZtUEdEejU5QWsxSFJQY1h6NmgzaTVBMmgzcHFvNElvOFJXaFhTakJa?=
 =?utf-8?B?Y1FNRTZ6RkNVV0JOWmxHVVBRN2hzREh1ak44SFFDdmpJbTFySGIrYmNlTWhx?=
 =?utf-8?B?eDFqQWlRdkZDQnZPV09HTW4yK3BiRXBjUjFLbnh2WkJEbTJJcm1MSjVZSCs1?=
 =?utf-8?B?eUpzWEQ0TzdwL0VHTlFiQytZaHZ6M2YvZUlGTkhVMG5XK2x0YzU5S0lOVDZR?=
 =?utf-8?B?TWNCcjdjWkMzNFZ6eC9JWkVGZmNwTWYyM0pmcm15SHBVM0h3L2ErbU1XbmMz?=
 =?utf-8?B?eUhWVlNaelFOZUxOcERvY3VBaFJDbkdUc2sxQUdmNFBqSnI3Tmc3b0NxbDRT?=
 =?utf-8?B?cUpmSlNnT29RMjRTL0k0eXh0TUpqZjVSMWxjSUtlZzZtS2Y4T0hNN2JKS24y?=
 =?utf-8?B?Q3FlM1V6SmFyM1ZPWlVZNC9wdVNianh3Qnhac2lFYStnQUZsQ0svcmVhSFNh?=
 =?utf-8?B?ODlVNTRlaXlrSG42c1JndFRiRGxYZ3VMR2hFSmFjTHJpd1NhY1BacTFvTXdm?=
 =?utf-8?B?WUlLYUJCaWJucnhVckozb0l6Wk5qM0xkdHJyWFJraGpqRmxWbnI2RjZadVhr?=
 =?utf-8?B?VjBoVG1QcHFMRnBhRlFoMGR6RUR5QmdXOHEyc0lja0pJVzlQZGZCakEzeGNx?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <402A053EEBDE574CB267176D25AAC778@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f7b89e-cbb0-401d-8b9a-08da8b3df29f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 10:45:40.5842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alQbZNRRLnrw1yPaKF19Z5Xt1sazlpmDztBm0RjDA7hwUgEonbzhIG1cJBNPv1jN3k1fMNSiJ2FcRA/5v/pgVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8zMC8yMiAyMjoyNywgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFRlc3QgY2Fz
ZXMgbnZtZS8wNDMsIDA0NCBhbmQgMDQ1IHVzZSBESCBncm91cCB3aGljaCByZWxpZXMgb24gZGhf
Z2VuZXJpYw0KPiBtb2R1bGUuIFdoZW4gdGhlIG1vZHVsZSBpcyBidWlsdCBhcyBhIGxvYWRhYmxl
IG1vZHVsZSwgdGhlIHRlc3QgY2FzZXMNCj4gZmFpbCBzaW5jZSB0aGUgbW9kdWxlIGlzIG5vdCBs
b2FkZWQgYXQgdGVzdCBjYXNlIHJ1bnMuDQo+IA0KPiBUbyBhdm9pZCB0aGUgZmFpbHVyZXMsIGxv
YWQgdGhlIGRoX2dlbmVyaWMgbW9kdWxlIGF0IHRoZSBwcmVwYXJhdGlvbg0KPiBzdGVwIG9mIHRo
ZSB0ZXN0IGNhc2VzLiBBbHNvIHVubG9hZCBpdCBhdCB0ZXN0IGVuZCBmb3IgY2xlYW4gdXAuDQo+
IA0KPiBSZXBvcnRlZC1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gRml4
ZXM6IDM4ZDdjNWU4NDAwZiAoIm52bWUvMDQzOiB0ZXN0IGhhc2ggYW5kIGRoIGdyb3VwIHZhcmlh
dGlvbnMgZm9yIGF1dGhlbnRpY2F0ZWQgY29ubmVjdGlvbnMiKQ0KPiBGaXhlczogNjNiZGY5YzE2
YjE5ICgibnZtZS8wNDQ6IHRlc3QgYmktZGlyZWN0aW9uYWwgYXV0aGVudGljYXRpb24iKQ0KPiBG
aXhlczogNzY0MDE3NmVmN2NjICgibnZtZS8wNDU6IHRlc3QgcmUtYXV0aGVudGljYXRpb24iKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2FraSA8c2hpbmljaGlyby5rYXdhc2Fr
aUB3ZGMuY29tPg0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay9h
NWMzYzhlNy00YjBhLTk5MzAtOGY5MC1lNTM0ZDJhODJiZGZAZ3JpbWJlcmcubWUvDQo+IC0tLQ0K
PiAgIHRlc3RzL252bWUvMDQzIHwgNCArKysrDQo+ICAgdGVzdHMvbnZtZS8wNDQgfCA0ICsrKysN
Cj4gICB0ZXN0cy9udm1lLzA0NSB8IDQgKysrKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL252bWUvMDQzIGIvdGVzdHMvbnZt
ZS8wNDMNCj4gaW5kZXggMzgxYWU3NS4uZGJlOWQzZiAxMDA3NTUNCj4gLS0tIGEvdGVzdHMvbnZt
ZS8wNDMNCj4gKysrIGIvdGVzdHMvbnZtZS8wNDMNCj4gQEAgLTQwLDYgKzQwLDggQEAgdGVzdCgp
IHsNCj4gICANCj4gICAJX3NldHVwX252bWV0DQo+ICAgDQo+ICsJbW9kcHJvYmUgLXEgZGhfZ2Vu
ZXJpYw0KPiArDQo+ICAgCXRydW5jYXRlIC1zIDUxMk0gIiR7ZmlsZV9wYXRofSINCj4gICANCj4g
ICAJX2NyZWF0ZV9udm1ldF9zdWJzeXN0ZW0gIiR7c3Vic3lzX25hbWV9IiAiJHtmaWxlX3BhdGh9
Ig0KDQppdCBhY3R1YWxseSBtYWtlcyBzZW5zZSB0byBtb3ZlIGFib3ZlIGNhbGxzIGludG8gY29t
bW9uIGhlbHBlcg0KY2FsbGVkIG52bWVfYXV0aF90ZXN0X3NldHVwKCkgYW5kIHNpbWlsYXIgY29k
ZSBmb3IgdGhlIHRlYXJkb3duDQpudm1lX2F1dGhfdGVhcmRvd24oKSBmb3IgbnZtZS1hdXRoIHRl
c3RjYXNlcyBpbnN0ZWFkIG9mDQpkdXBsaWNhdGluZyB0aGUgY29kZS4NCg0KLWNrDQoNCg0K
