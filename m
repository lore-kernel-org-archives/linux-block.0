Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A14DC28CF5
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 05:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiAZFjQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 00:39:16 -0500
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:37015
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233744AbiAZFjQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 00:39:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoWgGPME2NiiAdwsiMNq7PgZ4NbWYPyEqrtWTdr6Trc3IFdaayh2mYWXYZzQ7Foe+xN05TW6ABa2WqNkSCL2WWLx+mB9zbFCLuN19emUIIn28xZOQzH6OTSYlkJp6I74uoKI6mhppVpX7V8/l08Mt4DTTwTRaCz0P26zq+LwwsAnOqrwepNnEQQkyB8sTu0Z1yQl/t0vyDaAMEDTi6xW6Ik8OaykCb3l6QaYKFs/QkGXZr/E310j6PYJzNcAi4A2jZBNos4/6P607ZhaJQCBInI1+QcjDc3MZyZiCbXrWHD2LFAkzTd+UsbvnPSUj5OAPk0n6cA2BxLxcq1tw0AUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQVOlrGd+mblF/EaCf45HX+o+aBzj+NskoNDH6aNCIE=;
 b=IcDILAu9aJMYscKWg8gGZSk0nzp7oRI67S0hdIYdHvfLu+CalH1/r2B0oU+l4HTjC5FAVEVWDS0aOQEjTC1eSXMg+gb3U/5BDD8wREehwQcE0V2SKUuDWhi5RSXepnAWSBpHoT64dx4L3sPyltgDc0cQyk4BhKtheaP+6D1eKkmeyKn+JIGG1bNI/zJOiE4unSa8ljMNcVqvk5sCkyTt+DETT5bFKHQQAtW1/9xynaa6NPLEMsTK8uQBSowdf6hjhs/Vdi1d2zv7xS4j93Nu5funmtpKxYholZaS/wqxi0LvyUbn9CLLWG+T+hrTeaaju/uAn20jvGtw0vy0MPn15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQVOlrGd+mblF/EaCf45HX+o+aBzj+NskoNDH6aNCIE=;
 b=oDSLSLEZAeqdSVPsnAAkG+ll7SR19Z4c35EkogUJVcuWacoHnOqfkiCOKk3QxlkT/8sN9QAz9r9y9uj5hKMT4CaJ/6VCq4iHCOJ2EtDyJLxLxeI6Gx8j8ZbcAT2haHPzorrUKpFvbb85eFIqxQjNyiH9y2yVB0OWfXigeLouaruJQPfoe2XODz7JSrpfhbGnZd7MpV9ZutVgXQMeRuZCr5zNs9M0JHHlSZOjU2XDDw+x5wY0qISejlZCBgt7affTLM4OuoXvXHfMN0HYH/Q/dnBnd8n5E5N2KSnb+SW7GV3PtD1J9j7aUdIdyXx1HkPfbr2VZt1sKgeTe8kCN9GGew==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4006.namprd12.prod.outlook.com (2603:10b6:610:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 05:39:14 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 05:39:14 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "dwagner@suse.de" <dwagner@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] blktests: replace module removal with patient module
 removal
Thread-Topic: [PATCH] blktests: replace module removal with patient module
 removal
Thread-Index: AQHX2yYufkOWFyLD/U6HCyiwjjVZiax1N8yA
Date:   Wed, 26 Jan 2022 05:39:13 +0000
Message-ID: <48b1d742-888c-ee14-297e-c63ae3bf37ed@nvidia.com>
References: <20211116172926.587062-1-mcgrof@kernel.org>
In-Reply-To: <20211116172926.587062-1-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5e40c7c-54f2-4f19-a4c8-08d9e08e2fd3
x-ms-traffictypediagnostic: CH2PR12MB4006:EE_
x-microsoft-antispam-prvs: <CH2PR12MB40068FC0864C78BC49AF5A89A3209@CH2PR12MB4006.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yx01i0YJJCbG3IQpuEDkbfP1ZEO0azA+TrMDQXfcPXIVXVJdovoi0yj+9eE2uCJh3aYodlUKkVcq6GpbHyHfwlrFgVivX4tb7K0gKriZ+sk7TyTdfg+0NqyVNgpgYpel1vo2Lo7JJB2QUCdcuNgmg2uTkGx9rZIK7619O1N0l4GfX4QQv7VL2wucKQafdDOVGhfSr58As8510kuzxSG4nsQi+ybF4xgNzRo1gnZ7rDydlFNj7bIDtQ+Bl1+Kpi6T7g/lGpmGbvTRjqxEotHErAgJJ0dqr0L6PwDmVaX8ZewbB7gtm3T/RrGuRjIbvynbtNJSXaumAStyfm8vMvJgREgXWmkaQpRsWDs8w7Zs19MQFB5uOq2Fd5go7xhvQHNQFFCafHpU21OKfNsfzMpkZliZjHZ5JE8Cn1yGcat7ZyxLFlXXkP1F5vl2knkk4bVNXvpgeBZI3howECK1e/rGeBv964fNK2nj8VaSIbyHq3d/83L13x+O9z0b7ifEif4fC8/P6hPGu+bbrX/s5sjzXfvvLsLE4TL+EIm53ktUVsgXv5cjNHccFaKt5EtqMg8TVGxNzf2BKhQGyM+N79U2sTWHfuwCYYcFvw3VpK5y7MuLX8W7v2pf90VKYl/A9tk4QP4EyzPrpWGQEnpIAo1A7cvLXVi9rMrsl6BENQ/3dUX4MIax0AnXUlDalJilr1XyApmgzp6P/pprWUW+XS2a1N7UnXPzWj/T+S7bgm1aFHnxs69Elkess1trtFZalyvVpPWv6kLOk8/W/a2xKNpptDMuZYjNvXs8MG67TkgxTQGLGqy3Op3ISGhcXS7eSbCMC5Qf1yPfpkOtEzGoFw+JPeWqhI7oI5ynWOT3dAyNF/aX73nP8WkiuVmjX4AEEliNi1t8fvUhYZ32MXTjTGL7TA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(6512007)(316002)(508600001)(54906003)(38100700002)(31696002)(2616005)(122000001)(38070700005)(966005)(8676002)(186003)(2906002)(8936002)(6486002)(53546011)(6506007)(4326008)(66446008)(64756008)(66556008)(66476007)(86362001)(91956017)(71200400001)(76116006)(66946007)(31686004)(36756003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEdZMENqeHlLOERsNEh5US9OK3JTR2VaWlo1eEJKdk5XS3BBc0FkSi9rb0Fs?=
 =?utf-8?B?cVVId21uTG5vWmNTemhpK3hlOGo0Z1UwYjN3L3U3Nm9LODdiNWNuVU50RlNG?=
 =?utf-8?B?QVRDT2VNKzhlZElzZDMraGIrL0thL3dXeXJjVXFIVDRKeDlYR1lXa1FuU2JH?=
 =?utf-8?B?N1M2TkVzL1d5NFlyelBxRjRsZkFoVkZwZlg3UC9mL1JmQzdRcDFDcGJLUEx5?=
 =?utf-8?B?RzlBcXg5V2FqVzJwb1hBd0tQZC91MjlobUt0MFNiTkw3SCt0bjkvMElld1Nw?=
 =?utf-8?B?SzBKZTd3YlpleksxMTg3R1crdkxYTE83Rk5Mb2VOdE9BeVpCWGlHaWtSYnpM?=
 =?utf-8?B?UHBXMGdnakYraEx1UUtPbVV3WUd6YS80bi9IKy9NbmpocWpNUnRqMnJ6R25P?=
 =?utf-8?B?bVVFVmttWER3V2dveCtjeEtEbmk4YTVWTDRHR0NmRmU1R3E5eGZmZW1ZZjJy?=
 =?utf-8?B?ZlRpMnJtRkx6aCtSUS93Y1VCUFBIRDVHcmdKeXJ4ZFY2WUxoeEFBeWM5THJh?=
 =?utf-8?B?QnB1MHlsL01DbDhRMm1iVGFyNEtsVHo1MXg4Q0dWOUYwUXFyVE5hN29LM25s?=
 =?utf-8?B?MGZBa1NRaSt0YlloVjQvYk5iaEJPbytaTXA0VUlJMGdGc0pzNkpTNUxQY1E4?=
 =?utf-8?B?Q1V6R0RxU0toOG1TNm1vRFhpUktyai9zeW54M2pNWEdqbU4wMGdCcTlDaVpp?=
 =?utf-8?B?ZkZxTnhFNFc0VHB6Ym1lUlhPcGlqa3dpKzZjTCtmWGdxODVHcmlkTTYrYzlS?=
 =?utf-8?B?dlRMV1E1eHR0ZjhzWC9IY3orNm5NbUtjZlUyY0Nmem5ORUdMdUhaZ3JsdkNR?=
 =?utf-8?B?a1dMcVJBRnRPSHV5ZkhTcFBySkV5SU9CQ3hQOXEzVFpGTUthWUI2cUkvRis0?=
 =?utf-8?B?cDFOT0ZBSUF2QThzR293MTFkSlVXeGE5UVQyOEFESGE3YllEVXpXT3ZUUDZi?=
 =?utf-8?B?SFNVK3ZmY2xEK3JhSVVscXJrM0VHcENpaTE2Smt5ekFYL0Z0TTMzT1dOV293?=
 =?utf-8?B?WEh3bExqb1lwYkZwL0pzaU04VUJxQUx2Tkx5aCtEVFBtQnM4dm9PSnVHOFZH?=
 =?utf-8?B?Q1o5TkZlYS8xK2tFaGRrc1h0aEJ6Mm9SbkhtckZHTXhSUXRsQnhPdGhzUWJ6?=
 =?utf-8?B?TVlXWVFNcW16cjRldk1lRWZtdGt4K1diM2JyTVNnaVhydy9CNmhrRXl3RVVT?=
 =?utf-8?B?aGM5NmZ5ZjFId0tNT0VONk9TQ1o4SzAzd1NGY3huajNpWGxDRklRV2wwNjRx?=
 =?utf-8?B?QmtrVm15N2hzQ1UxUXdFbm4rY3JHRGJYUXluemhkSzhkUVVQZ0h6cGs5bGdN?=
 =?utf-8?B?RXA0OGJNODJTTU9sNjROMmJoMmtxU3RrMktxZGQ1NXpiSnlZMmRLTEtOSFc2?=
 =?utf-8?B?MW9lZ09nWUM1T3o3TnlhY2htUlBOS0c0alI5a2VHNlVkSVUxbTN3N213RXB4?=
 =?utf-8?B?UlgwdjdRTG42SWxhQkFMZkNtUE9ZaytVc2tUTSt1V003TGZqWXU4b2dMTUF5?=
 =?utf-8?B?VVV5eDNRTDhHdGlZeTdyYW16b09rQWFoVDA4RkI1MmZjZmRpS2ZYQjltaGpC?=
 =?utf-8?B?bHVRTFpqVit6azhyUTdLcUpVUUlyOXhUM1B3VmZVRXlBbW1GOS9XNWcySUQ1?=
 =?utf-8?B?M3RNaEdBOEJZR1RiVG1La2xWQ2Y3SXJUZjVqSExnbk5nRGxjTUU5NE9zTW9q?=
 =?utf-8?B?MHZyVlR1UkJSbGlrOEVSMnRhRDB4ZEdrS2QyREhxN0RCRDd4cmJzRFFDekc1?=
 =?utf-8?B?L0haMEg4SDdxTHgvZGZxQU1HS0FraUJIbTBZaUtHeVVpdDk0WEFrVlFiTDJ6?=
 =?utf-8?B?M2drbnVhc25RV1I4SFFpT2Z2SGFVMzhqY1cwek45dmczWHNlZTgrdGhFaXhi?=
 =?utf-8?B?RDdTdFdUOGZsWmNkOXdIMGpwZ01wWFFaVWZsbXdxS1RkUmFwOEUrOUY3SzFV?=
 =?utf-8?B?NmE5L1gxRTI5bTFaZDZHK1NDZ09HVy9vSVowZWlxRHBiaURwQXdHS2xvb0tt?=
 =?utf-8?B?RHhqNEpWVGtlMUFVVnd2bFlhRkRQc2RsWUdIMDFpVkd6YVJZNGt1aDZ3SXky?=
 =?utf-8?B?V3Y3c3FWd3VGdEtCMzY4OFZCV001VlkzUUVlYmdodVNtUzZ2YXU1OUhoN1R5?=
 =?utf-8?B?MWw1VU9ab0Jxa05sNUpuK1MwcGlQZjhhOGhBSkFtZzBLaHM0L3RsaEkyZml0?=
 =?utf-8?Q?b+rhuTUngADng2K9LRVcxFi4MicyPL76cdwaS4QpTQ50?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A65DA63605ABD4AA117B2BC494014D9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e40c7c-54f2-4f19-a4c8-08d9e08e2fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 05:39:14.0919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXhwwdelhxs9eMuf+5LJcKpqJ6+Ndy1gatgnMKKEHzdsqBnOhiTGdF3CIdzbU+RBlby6+pvYM7fESYitxumGcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4006
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMTYvMjEgOToyOSBBTSwgTHVpcyBDaGFtYmVybGFpbiB3cm90ZToNCj4gQSBsb25nIHRp
bWUgYWdvLCBpbiBhIGdhbGF4eSBmYXIsIGZhciBhd2F5Li4uDQo+IA0KPiBJIHJhbiBpbnRvIHNv
bWUgb2RkIHNjc2lfZGVidWcgZmFsc2UgcG9zaXRpdmVzIHdpdGggZnN0ZXN0cy4gVGhpcw0KPiBw
cm9tcHRlZCBtZSB0byBsb29rIGludG8gdGhlbSBnaXZlbiB0aGVzZSBmYWxzZSBwb3NpdGl2ZXMg
cHJldmVudHMNCj4gbWUgZnJvbSBtb3ZpbmcgZm9yd2FyZCB3aXRoIGVzdGFibGlzaGluZyBhIHRl
c3QgYmFzZWxpbmUgd2l0aCBoaWdoDQo+IG51bWJlciBvZiBjeWNsZXMuIFRoYXQgaXMsIHRoaXMg
c3R1cGlkIGlzc3VlIHdhcyBwcmV2ZW5pbmcgY3JlYXRpbmcNCj4gaGlnaCBjb25maWRlbmNlIGlu
IHRlc3RpbmcuDQo+IA0KPiBJIHJlcG9ydGVkIGl0IFswXSBhbmQgZXhjaGFuZ2VkIHNvbWUgaWRl
YXMgd2l0aCBEb3VnLiBIb3dldmVyLCBpbg0KPiB0aGUgZW5kLCBkZXNwaXRlIGVmZm9ydHMgdG8g
aGVscCB0aGluZ3Mgd2l0aCBzY3NpX2RlYnVnIHRoZXJlIHdlcmUNCj4gc3RpbGwgaXNzdWVzIGxp
bmdlcmluZyB3aGljaCBzZWVtZWQgdG8gZGVmeSBvdXIgZXhwZWN0YXRpb25zIHVwc3RyZWFtLg0K
PiBPbmUgb2YgdGhlIGxhc3QgaGFuZ2luZyBmcnVpdCBpc3N1ZXMgaXMgYW5kIGFsd2F5cyBoYXMg
YmVlbiB0aGF0DQo+IHVzZXJzcGFjZSBleHBlY3RhdGlvbnMgZm9yIHByb3BlciBtb2R1bGUgcmVt
b3ZhbCBoYXMgYmVlbiBicm9rZW4sDQo+IHNvIGluIHRoZSBlbmQgSSBoYXZlIGRlbW9uc3RyYXRl
ZCB0aGlzIGlzIGEgZ2VuZXJpYyBpc3N1ZSBbMV0uDQo+IA0KPiBMb25nIGFnbyBhIFdBSVQgb3B0
aW9uIGZvciBtb2R1bGUgcmVtb3ZhbCB3YXMgYWRkZWQuLi4gdGhhdCB3YXMgdGhlbg0KPiByZW1v
dmVkIGFzIGl0IHdhcyBkZWVtZWQgbm90IG5lZWRlZCBhcyBmb2xrcyBjb3VsZG4ndCBmaWd1cmUg
b3V0IHdoZW4NCj4gdGhlc2UgcmFjZXMgaGFwcGVuZWQuIFRoZSByYWNlcyBhcmUgYWN0dWFsbHkg
cHJldHR5IGVhc3kgdG8gdHJpZ2dlciwgaXQNCj4gd2FzIGp1c3QgbmV2ZXIgcHJvcGVybHkgZG9j
dW1lbnRlZC4gQSBzaW1wZSBibGtkZXZfb3BlbigpIHdpbGwgZWFzaWx5DQo+IGJ1bXAgYSBtb2R1
bGUgcmVmY250LCBhbmQgdGhlc2UgZGF5cyBtYW55IHRoaW5nIHNjYW4gZG8gdGhhdCBzb3J0IG9m
DQo+IHRoaW5nLg0KPiANCj4gVGhlIHByb3BlciBzb2x1dGlvbiBpcyB0byBpbXBsZW1lbnQgdGhl
biBhIHBhdGllbnQgbW9kdWxlIHJlbW92YWwNCj4gb24ga21vZCBhbmQgcGF0Y2hlcyBoYXZlIGJl
ZW4gc2VudCBmb3IgdGhhdCBhbmQgdGhvc2UgcGF0Y2hlcyBhcmUNCj4gdW5kZXIgcmV2aWV3LiBJ
biB0aGUgbWVhbnRpbWUgd2UgbmVlZCBhIHdvcmsgYXJvdW5kIHRvIG9wZW4gY29kZSBhDQo+IHNp
bWlsYXIgc29sdXRpb24gZm9yIHVzZXJzIG9mIG9sZCB2ZXJzaW9ucyBvZiBrbW9kLiBJIHNlbnQg
YW4gb3Blbg0KPiBjb2RlZCBzb2x1dGlvbiBmb3IgZnN0ZXN0cyBhYm91dCBzaW5jZSBBdWd1c3Qg
MTl0aCBhbmQgaGFzIGJlZW4gdXNlZA0KPiB0aGVyZSBmb3IgYSBmZXcgbW9udGhzIG5vdy4gTm93
IHRoYXQgdGhhdCBzdHVmZiBpcyBtZXJnZWQgYW5kIHRlc3RlZA0KPiBpbiBmc3Rlc3RzIHdpdGgg
bW9yZSBleHBvc3VyZSwgaXRzIHRpbWUgdG8gbWF0Y2ggcGFyaXR5IG9uIGJsa3Rlc3RzLg0KPiAN
Cj4gSSd2ZSB0ZXN0ZWQgYmxrdGVzdHMgd2l0aCB0aGlzIGZvciB0aGluZ3Mgd2hpY2ggSSBjYW4g
cnVuIHZpcnR1YWxseQ0KPiBmb3IgYSB3aGlsZSBub3cuIE1vcmUgd2lkZXIgdGVzdGlnIGlzIHdl
bGNvbWVkLg0KPiANCj4gWzBdIGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5j
Z2k/aWQ9MjEyMzM3DQo+IFsxXSBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcu
Y2dpP2lkPTIxNDAxNQ0KPiBTaWduZWQtb2ZmLWJ5OiBMdWlzIENoYW1iZXJsYWluIDxtY2dyb2ZA
a2VybmVsLm9yZz4NCj4gLS0tDQoNCg0KVGhpcyBsb29rcyBnb29kIHRvIG1lLCBJJ2Qgd2FpdCBC
YXJ0IChDQ2QgaGVyZSkgdG8gcmV2aWV3IHRoZQ0Kc3JwIHNpZGUuDQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQo=
