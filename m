Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745D3C433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 05:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiK3FPS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 00:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiK3FOj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 00:14:39 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326C417889
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 21:14:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkA1HpIKDGzCOQAvMXGfTxXNL0qE4qRKRN8FKYqOfAjwoEs6ol4lG/fXnpjNbb+DcXD3tg/C6Km6+oC3LhFmGopo0ASTMJRbG+PwKQ7g8f5l1IA9fP6q8vTEC33GY3uqC/8KDzVQ4Fb+yrkiKo6iJzeOhL4soQghL94IdBERHX10Qqw1FO+GmKR8cChbAtBJsVwPLpQjLkb/uXVqwmdjDw83KK2pL7M1+PhZlMXj2BNjOQ+mxr1wjy9iqRZ38BsSUzPfzI4nEHkyzdVmFAKoovp+5yfG8rniw4x+oP7rxSaF9E5aiXIUG3tnWu6XmcQ1g0bSKr+FtS+ZtVWGT6wCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnJwwQxWl6GPv077GYeyW6hH6EVYwtEfpXsMTZxP6BY=;
 b=MQspHRFzwb+3AnGu2jmny9ueWJtES9DJRPoBbMkrBEneiTgDGxgNWG9N3oKezYxt48kPSSITv+KA94GYwbQsaMs8fd1ECfMHV6jIXz7PoCNyN9acwQRULxsbREKumutfBjca77VX29Dwk7nVjvb+00QyYgm33L6wQiFcEjasKccI7f8y/Z1xUyVihGID18qo0YirdFK1LSORrk4cvhyc4j+hXZ0PGESsS/X2AjFCF/19xwJ+vK+De3oaknHmH9xg4R7m6icZCRtupZXVwXkkVqDasKbDE9jshKNtkqCJp7QQ0twtZfp0nzBvXMaZe8Hm85VSfjUXOcsJxevsMmKT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnJwwQxWl6GPv077GYeyW6hH6EVYwtEfpXsMTZxP6BY=;
 b=GzLX7TD4HttGJXbNE+5xVKhZ9w0q3xULMjInJV1lmsVwQqkhDXVh+ch9NvhCbzJ3e3p9PCvc7zJ00VQjQlRdxhPTCIAEpt99eNt4OJWdXPf2KlA/kvYCFEjK0b79+zwD/p9uTKekzuOAuDLHp5H05VnjgzZM0Zo+kUHsLF8CwAj8HKYCfyvUcYV+QnDaF/LGrgfNtyVnvBYT8S7rKXIx3nVVsOZxP9xCv9PJyKqW81vnk5JxNFYkumzbYv1gvN9s7VoY0Ph3l0u32HB1cgw9Mmh2m0Zdc7gNLTknz09pNMkcMbS03Li8ZBkLNvwKPJTY8Ys3uRyHZCQ/n2n7I6pY6A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.6; Wed, 30 Nov
 2022 05:14:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 05:14:35 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Omar Sandoval <osandov@osandov.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH blktests] block/017: extend IO inflight duration
Thread-Topic: [PATCH blktests] block/017: extend IO inflight duration
Thread-Index: AQHZBGUZwB92Gm3yUUS8+FZjH3pal65W7HuA
Date:   Wed, 30 Nov 2022 05:14:35 +0000
Message-ID: <6cdd3f9e-af36-00a6-a3de-793972a383f2@nvidia.com>
References: <20221130024012.2313090-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20221130024012.2313090-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB8273:EE_
x-ms-office365-filtering-correlation-id: c486f1d4-bfe2-4b7a-11b8-08dad291c5b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yP6iuYGpSx7Ozfzt+J/k0cewj0T9I/cbRvJNnaStrkdOMwQZ50Ob33EDOvWQGpeJEhK2w8qmOb/cs10+IknwXnL9AKvLF/bSxXkP4V7VjfjF+Fyf2rKVrxQodsRrAUYRx6OXtbV+BUrOaJlCVxmGDPxAOxxJSmVPTJjQnFFwGW10XqIFckZDm6NNXfYBiZSVNwA89kYCidi7pjuBebjb08YUh0TPoOKmC0bjp3QZK1ij6Dg817TleJK/fpATSUEgLCP4bgneHbQR+hWIHOMa2vtVGritcmzY2CkBMLUVZ9jogfQVtdjDeKspslfyo8bvaKTzgCe7ZVpDMSv4eTuzUZKaSeGHB/cISBIMVR5X9T5wJEjE+I2r6u4eTR3K/ZQjodapAUbHnpkZ3zsMa2lYECkK1mcYFNOp3cKh88JTBgZfTtUkRh1F/Mt8a9/zJVjqcC1lrtcaHNM3lGezCw6L4TbfAfTvXc+Fl5GVbQEfXXefhElaIEa50uK1BlSg0Z4Xg4aM/0BgjGRpIQUXJDuq4pctp26HfjAD6hHmvlf6Xj7CrOrUeKySHECrt7dt1IJSfJguKW+f2SlPNYDHfPE0Rp5vCJwGzjoPOD05ke3Us8JN4FxUpCOVX6iu0AklQjLkP0nP36FmFouw1eHP7w+o/Q0ZHFt22deauO5Nbq9XdAAPk+/tw4IR1jZnCSkL24JkidjBjnkAcaIXWLS/8+SGPO1Etn5P4qjImM4GEsuMcQvYIt+5wqsyQ9nf4yZfnHbm8NrNLsbV2+70mUen/oclVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199015)(478600001)(4001150100001)(2906002)(31686004)(54906003)(41300700001)(76116006)(8936002)(316002)(5660300002)(91956017)(4326008)(66556008)(8676002)(66946007)(66446008)(64756008)(66476007)(53546011)(6486002)(36756003)(2616005)(6506007)(186003)(6512007)(110136005)(71200400001)(38100700002)(86362001)(38070700005)(83380400001)(122000001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUpZbmhzc3lQWUZpQTUvbUcxaVFySDJWQWkrZXM0K21Ca1VyTDBEODA1dWdU?=
 =?utf-8?B?YUxhcHl1NkpuSGVhTkR0Um5janhXRHJjMmRCejZrRW9SYXJkWkV5S3lNNzVi?=
 =?utf-8?B?ZW5JdlYxaGpENzZIeHo1RThXOWdEMXZsSldRcXFaZURER3RQeDR4Yi9IM1lG?=
 =?utf-8?B?SFNsTFdEVWt0R1J1d0Z4Y0tXR1FtZUNwVWdreDNNbXdVTXRUL3VLNW02RVRl?=
 =?utf-8?B?QUhKWFdsbnoyRmJCSkFmYUpQNGF4U0FEZzhkSkFiSzc3UDI0WUtFSGRvMGNR?=
 =?utf-8?B?NFBGcFc0UEFwM0RoNkVsZXNzS2JXUmhBOS9CeG4zbE5XWmpLOElaOFZ5Q3Yw?=
 =?utf-8?B?Nkk0WjZuSWdpdEVtZUxsN1IrWDU3M2pjY01xQkVHVStFaXVDV1BldkJhTERB?=
 =?utf-8?B?ZndBRTFRY2k5OWdyVllZdkxPWXRsS01nRlpUdWQvTEdYQUYyUjAyR0RwdVNu?=
 =?utf-8?B?eVJQNUVRaWNaanQ2WGRUQkpRR2ZSM3hROEZUOTAyYURCV3NLbDVDdGsxRWpN?=
 =?utf-8?B?UzRmL3Z4NHJwSGdndzllUUZYdE4xTklzR3FWdVZtVkdOdGpnT0h6Ti9QY0Nx?=
 =?utf-8?B?MzBFRUVoNzhGR3I5TmFaVDVlU2l1WTB2TVFKY25Cb1BGZ0tGSnFUaGhPSmtL?=
 =?utf-8?B?djExWkVpTWxnaUg5VGo0RjNHWi81U0VqazFQSk1YdVlFVWJrZG5wU054RlI3?=
 =?utf-8?B?MXBUd0xjaWE4MEpUQXR3ZDBzV0xVZDNBTlYvWFF4SHFsQXRCdjB4a0VsT1JY?=
 =?utf-8?B?dEx5b0E2MGJIZDZNd0RQaU1aa0NCZ2N6a1BGczRtMHpqNFJ2UWVCOXpEQWlJ?=
 =?utf-8?B?RVFhY1lJNjRwTkxzNG41dDBzKzBDaGxyRjNxcGlMMnFrUUJKcDkyTFlIQmJI?=
 =?utf-8?B?MGpSV0NvRGpHNU1HbjhFS2pNTVU5YzY3T2J2aXlMVTJLS0ZXYUxwbDlRcEsy?=
 =?utf-8?B?UW5hb1dzcXpJN0ZSQzhYZUc4aGxvdEF2N0NyMTVvMzdMZlR6aVFBNzZMUjhQ?=
 =?utf-8?B?VFc5U29kZXgxWGp2NVF4SllyNFpiOGFyUjhrL2Vtc3lObkNDQ2V3R2JiOHJ0?=
 =?utf-8?B?dEgvTEIzT0g4T0RsN2V3Mm9Md04vcUVrcmJhNXlIdzhZb3pSNEtET0xobE9H?=
 =?utf-8?B?NnViNW1YdW1VSnovY2k3RXFBeHZhTkRzWmU3K0lXVk5sK2NPR1hEZld3aU8w?=
 =?utf-8?B?QnA4aHlQVmdiN3JzckZDaUhyYjcrUjFkTFhESG9ReUlubkVSS2ZpMWNLR0Nw?=
 =?utf-8?B?WmVFa2oyazRYT0gySSthdGF2ckZRUXBmQUFOSEJmT3VVSjdsdm00c1JJazBo?=
 =?utf-8?B?ZSs3OTRESmt6MVlzT1BhcWVoRSs0SFY1R2pxc1Q5Tys2Y09nY3dxUURFbUI4?=
 =?utf-8?B?SllKc0xTOHdQUXlKUk02MTFXbEhPUjd5QnYxUEFaVHpNQWNxUFYyZmZOWWxu?=
 =?utf-8?B?dTVoZzZGeGhXNUxscU94WkVERVdYdytRMDJ3WFhNTDNIcXpEak44UkFCOXVU?=
 =?utf-8?B?MExTNlRiZDl1b09uKzhZd1ZrUEZnMWFiNjA2VUliNzRGL2NGUjJEQmFwT0Q2?=
 =?utf-8?B?blFMUEcxa1dqYU03NFhFUXl5emxxVHJCM2RZTUprbTBvUms1ZmIwSHVwaGtH?=
 =?utf-8?B?THByeVZzTXNzajhrT0pubEw5dmg1eXYzbUlaOFZBSWg1YmxiRG1kY1FJd0Qx?=
 =?utf-8?B?bWd3S1dPTzI5THJtdzlXa2pKUVE4OUJrclE4dUdmTXp2cFN3ODg4TWJtZFVo?=
 =?utf-8?B?Ti9iTmZlTEVYL3ZUbXl2Y3NNakJVSGNTRnVERnlyNytUUzFQU202YVhjeVNV?=
 =?utf-8?B?Rm1yZmxpbjlWUHlEbXQ0U1V3a2xBWmRkK2tVNnFGaEVuL1dmbjBVTmRXc3pm?=
 =?utf-8?B?MVB3MlVNT2RaUUtNS0tBdTRiVnlmS3Z0VFRSUTBWVWRnNHpUNGtoVTFoQmtz?=
 =?utf-8?B?cXpQSzJHVk1uYzhQK2d1L09UK1ROZjJDUUVnMStINXl4RTZpaFliSVVLSC9J?=
 =?utf-8?B?SkZzM1ZHdHVzTzl4ZWc0V2V1Wkx2S1B0amFWQ0VhVVZWRjNKQU5icEhYNFJB?=
 =?utf-8?B?UnMxa3FNL29rS0xqcEJtRkw2aHhOQWdycnpNMzhDRWVPdldhdHVVcGVzeWoy?=
 =?utf-8?B?aXhiZHp1YU9qc3VIbmxRYnFWc01mYkVrdC9SZnFMK3JXeVB0Q2cxaC9na0hV?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CDE5035D210FA4EB85B8854D023D0E4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c486f1d4-bfe2-4b7a-11b8-08dad291c5b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 05:14:35.5259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WM+TCbylLIAX4loSZxsD30dZ4XybD/6aWPEo2KXmxYqub4vNVg8tgrIBHSncJDalmx4Fm0OWfmVzyc/De/1aCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMjkvMjIgMTg6NDAsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBUaGUgdGVz
dCBjYXNlIGJsb2NrLzAxNyBvZnRlbiBmYWlscyBvbiBzbG93IHRlc3Qgc3lzdGVtcy4gV2hlbiBp
dCBydW5zDQo+IG9uIFFFTVUgYW5kIGtlcm5lbCB3aXRoIExPQ0tERVAsIGl0IGZhaWxzIGFyb3Vu
ZCA1MCUgYnkgY2hhbmNlIHdpdGgNCj4gZXJyb3IgbWVzc2FnZSBhcyBmb2xsb3dzOg0KPiANCj4g
YmxvY2svMDE3IChkbyBJL08gYW5kIGNoZWNrIHRoZSBpbmZsaWdodCBjb3VudGVyKSAgICAgICAg
ICAgIFtmYWlsZWRdDQo+ICAgICAgcnVudGltZSAgMS43MTVzICAuLi4gIDEuNzI2cw0KPiAgICAg
IC0tLSB0ZXN0cy9ibG9jay8wMTcub3V0ICAgICAyMDIyLTExLTE1IDE1OjMwOjUxLjI4NTcxNzY3
OCArMDkwMA0KPiAgICAgICsrKyAvaG9tZS9zaGluL2t0cy9rZXJuZWwtdGVzdC1zdWl0ZS9zcmMv
YmxrdGVzdHMvcmVzdWx0cy9ub2Rldi9ibG9jay8wMTcub3V0LmJhZCAgIDIwMjItMTEtMjUgMTY6
MjM6NTAuNzc4NzQ3MTY3ICswOTAwDQo+ICAgICAgQEAgLTYsNyArNiw3IEBADQo+ICAgICAgIHN5
c2ZzIGluZmxpZ2h0IHJlYWRzIDENCj4gICAgICAgc3lzZnMgaW5mbGlnaHQgd3JpdGVzIDENCj4g
ICAgICAgc3lzZnMgc3RhdCAyDQo+ICAgICAgLWRpc2tzdGF0cyAyDQo+ICAgICAgK2Rpc2tzdGF0
cyAxDQo+ICAgICAgIHN5c2ZzIGluZmxpZ2h0IHJlYWRzIDANCj4gICAgICAgc3lzZnMgaW5mbGln
aHQgd3JpdGVzIDANCj4gICAgICAuLi4NCj4gDQo+IFRoZSB0ZXN0IGNhc2UgaXNzdWVzIG9uZSBy
ZWFkIGFuZCBvbmUgd3JpdGUgdG8gYSBudWxsX2JsayBkZXZpY2UsIGFuZA0KPiBjaGVja3MgdGhh
dCBpbmZsaWdodCBjb3VudGVycyByZXBvcnRzIGNvcnJlY3QgbnVtYmVycyBvZiBpbmZsaWdodCBJ
T3MuDQo+IFRvIGtlZXAgSU9zIGluZmxpZ2h0IGR1cmluZyB0ZXN0LCBpdCBwcmVwYXJlcyBudWxs
X2JsayBkZXZpY2Ugd2l0aA0KPiBjb21wbGV0aW9uX25zZWMgcGFyYW1ldGVyIDAuNSBzZWNvbmQu
IEhvd2V2ZXIsIHdoZW4gdGVzdCBzeXN0ZW0gaXMgc2xvdywNCj4gaW5mbGlnaHQgY291bnRlciBj
aGVjayB0YWtlcyBsb25nIHRpbWUgYW5kIHRoZSByZWFkIGNvbXBsZXRlcyBiZWZvcmUgdGhlDQo+
IGNoZWNrLiBIZW5jZSB0aGUgZmFpbHVyZS4NCj4gDQo+IFRvIGF2b2lkIHRoZSBmYWlsdXJlLCBl
eHRlbmQgdGhlIGluZmxpZ2h0IGR1cmF0aW9uIG9mIElPcy4gUHJlcGFyZSBhDQo+IG51bGxfYmxr
IGRldmljZSB3aXRob3V0IGNvbXBsZXRpb25fbnNlYyBwYXJhbWV0ZXIgYW5kIG1lYXN1cmUgdGlt
ZSB0bw0KPiBjaGVjayB0aGUgaW5mbGlnaHQgY291bnRlcnMuIFByZXBhcmUgbnVsbF9ibGsgZGV2
aWNlIGFnYWluIHNwZWNpZnlpbmcNCj4gY29tcGxldGlvbl9uc2VjIHBhcmFtZXRlciAwLjUgc2Vj
b25kcyBwbHVzIHRoZSBtZWFzdXJlZCB0aW1lIG9mIGluZmxpZ2h0DQo+IGNvdW50ZXIgY2hlY2su
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2FraSA8c2hpbmljaGlyby5r
YXdhc2FraUB3ZGMuY29tPg0KDQpvdmVyYWxsIGl0IGxvb2tzIGdvb2QgdG8gbWUsIEkgdHJ1c3Qg
dGhhdCB5b3UgaGF2ZSB0ZXN0ZWQgdGhpcyBvbiB0aGUNCmZhc3QgbWFjaGluZSBhbHNvIGFuZCBt
YWtlIHN1cmUgaXQgZG9lc24ndCByZWdyZXNzLCB3aXRoIHRoYXQgc2FpZCA6LQ0KDQpSZXZpZXdl
ZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==
