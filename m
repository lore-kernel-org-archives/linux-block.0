Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D81EC00144
	for <linux-block@archiver.kernel.org>; Thu,  4 Aug 2022 06:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiHDGrS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Aug 2022 02:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiHDGrR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Aug 2022 02:47:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE33A485
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 23:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9eIqR1H2dmB28ZGKV/NlewVeqDZCswHv7S7UHhSWZapWh7eEf1Qs3vE/LNnp7JPx1qCS4whcg+PJz2PVT7uiCu4qVM9IG2GTQVFfQbVRYLhqGsZ7dvXyLDGx7X+Mn4D13W2Ux5CPm4uxaE7E1RU4INW7eHCKGZXq9Ek42bmQXhmscDkZcDbzEneGVXBpQfDPCcRkFbPeYsLT2RozTynSoN2g3HwPxly8kDSrui1IKeY8R0zHWXipSkI1ny2KPvoGwzjZraM3kogO9lN4pe5/HX46DNINpiGFOL1MqtFCKOoLl6SqNH+Miwq8RUILSb+p41WKlsyNMiAQiNdGg4V4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E3YfbSAojeSnBbyOqATe4IGdGDKKDxsjpNEKjwAwb4=;
 b=UXAuxD5fzTLDeo8gYBtHOB1K00Lu+NQVkN36npKHJ6h4JhsMMaOb5esaBi/BNUXhKSVEtpHls4EywVLAxoM1cjw2XR4gbrKyRWkKXPnGYTrfbJkJcl6jkbayeoSxWWa3QjZmWi3TDD8yUsizG0IAzrwwTT5CKImr+kMUK4StmeE9TyQVm0ganLq2fhaqp/a3STExr9WpV6VsI7dk3Bsw2v6zd3RVbjWUZqUVVj0AVadFUv+KwF0JHQrny4SsNeysJXQyKpZMQXvHuurzUcbPr4sLJsU3kgv0ksdvTD1l5sg0xT1V9B6CLpeo8j5EOappfoMN2g65eQcFk42R9UPT/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E3YfbSAojeSnBbyOqATe4IGdGDKKDxsjpNEKjwAwb4=;
 b=I9A7i/4xzniY3ffZrc7mcmaq2Waort2HZIrEtQNTDQB21fIrjADDtkAKQ8318QBPwe7nMQ6HeRFcj5fZo+Kd6sakoE7SCEgwDGN9Kayza0yK+ZmOJMDFq6RU1+3ap6kLc0f2qM3qRSvdlD79FTDo9C1IEiZ1/HH86OUgt6SlGn6ARmZNPP0H6hTFfN2gM+8nzTNOp1ucLfTTrWrsKsfgroOwjr0EDMIQIUwbTQeaYDXmTiY9zHVEzfskQbKJKn71U0XxMkHOT7xVkJubwirtIvNCcDXO+bUzhqjls13vUgdEVehhf0s6asIS2IzicuuFTWX+oABzEG8Zp7M4AqL66g==
Received: from DM5PR12MB4663.namprd12.prod.outlook.com (2603:10b6:4:a9::26) by
 BN8PR12MB3266.namprd12.prod.outlook.com (2603:10b6:408:6e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.14; Thu, 4 Aug 2022 06:47:12 +0000
Received: from DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051]) by DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051%4]) with mapi id 15.20.5458.024; Thu, 4 Aug 2022
 06:47:12 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests] nvme/040: fix write file path
Thread-Topic: [PATCH blktests] nvme/040: fix write file path
Thread-Index: AQHYouBIsQSsPz2wk0O91u/5qZDi262eVkwA
Date:   Thu, 4 Aug 2022 06:47:12 +0000
Message-ID: <d7371c19-5586-4182-9f7d-268aadd0024b@nvidia.com>
References: <20220729001505.1489933-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220729001505.1489933-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a933364-6abe-466b-4f18-08da75e5295c
x-ms-traffictypediagnostic: BN8PR12MB3266:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPOlyQfu4U7y/8ModkLjJ9NMz67MAK7+mnBR9xBt6pHhCZoi2Pt1PutxheXea7BXs2W4xjZPfSKwsD7x0lobsvuDFd5RYKUf4OMBacgcDMArJ0Od7yVCcixlDMEkzKALisaSps1rCQK6E6SCTDrd4/SV9nbA64xtIcnxXXjqg+gShTpYrXbr5RyQD8fcIhagEFWuWnlDeqzugxVJBgmUYiKwzX5cWuUSn3C/Y+EDL28NvXFinQwsUh82G0QSoPQiAIiOFOml3Xxvisnwu3U5RQc9GzPCdgYdmUAQ3PR7HtQdk+8Wtn4WwkRBtahNkmMRIAiwZ6PbqP7AzvvaTYdDh329xQVZvba1tqbrHz8FgibZ6u2gpKzRoON2+894pp8V6mpog4CH9Yi/0IIkauW4orAyYIy17+cGx9mkGkqU/z+6amouWUW8HHXlTqavmDZhdlFs/iy+YFGdcpAoGMU+9CE32g/J1t+hYIuoH9WMYnd9ZpY9OSY8gZ9O/Z5+JGYGN1LJzjX22w9z9UV4f4d/MmmYFCeZouKZA2vdO8tpmRBneShNhwERUvMP4pU3SLJRYTfu8WHvWlt4/k3P/akv3pVSN9oohN2uD5L9h60bp/2GIqPh7stvKS4d2Cxfr14qnxNfb2Xh/fxWSPkawBfv5DunHby2BuEXcXcSbOJH8v4zh+A+zxPgtEIUCnuIalrdawfVYu4QREywrOrBuvBSjQ5SlN3i6q8RZEJa0bQFwhKSbMdSVUkuRfJh8jcJ+QWCOoZGt+r/NnNxZ9WjgJyG2jdxLQvUbUIwOagqr0bj/EaSLPnFeW16z+d3r71Ow0tTlqkN1ombYIFMAZCTPT6Au/yHGUg9rLwj4g6cMrleXZQ1H0CtWw+bfmZe8D/mixb1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB4663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(31686004)(478600001)(122000001)(38100700002)(31696002)(316002)(6512007)(71200400001)(6486002)(186003)(110136005)(2616005)(8936002)(41300700001)(36756003)(53546011)(6506007)(4744005)(76116006)(2906002)(8676002)(64756008)(66946007)(66556008)(86362001)(91956017)(66476007)(5660300002)(66446008)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWR3WWlRY1JtSVdoSE8raEVoOVlmRmkvdHdEWmxGK3dQR3JjZllDYWFFK3RB?=
 =?utf-8?B?Z24zWUpwVkI3SmJtQ0oxMElxaDg4dm9GR1Y2bVk3UDUyUXR5UUdMZ0Z0Q2xB?=
 =?utf-8?B?VGNtMUxpckhUZERZajhGTzFjVzlSQ3o2T0hveDdzaHRwUmU1dytsZldheHhW?=
 =?utf-8?B?L3RpOXRtY3BRTElieWtRQ25SSDcvUFU5aW5lWGFjbUVTVDQ4RUx2SHYyRUtH?=
 =?utf-8?B?WmJHMmprWVpOLzY4aHZQcVM2bGFDeXUvc2FnQkhhZWMvbzBuUFlnampmMnJJ?=
 =?utf-8?B?YTFkUFcwS1B6ZTFRbTMwMTdNQUxiMUdnSnZVNGdWN1pxdCt6Ry9QdXJaSGU4?=
 =?utf-8?B?MlVqckgrSGM0TndBL2VvWlpBWENRaUNaYTJqNHo2NnU5bmYyaGRoaGtjcXR0?=
 =?utf-8?B?WjQzQURqODNlWmNoVXhvOFVzTCtycEp5N2JUckZLdDk2WWpzNXdFNmx4QTFR?=
 =?utf-8?B?Q0tkZTlJcHdJZS9JaDMvaTVpTHRHR2hoNm84QmN5anptNWhWd1NFaU5TcnNT?=
 =?utf-8?B?RDNLSmlEcXRWbXZOcUlaTmw5dlRtRTJsVCt6MU51WUVKYWJ1UXlsVDQ0dCtq?=
 =?utf-8?B?OEVHTVZxcWFIZGNPNjVXSUNVZ2V0TmJ6eXBiTHpvek9tcEVvRlZOaTFjbDU3?=
 =?utf-8?B?STFGQW1sT1U5ekJIRFFDYXM3RUpHZlV1VUxIRXpud3RMdXljQmw2UmpUOXRM?=
 =?utf-8?B?dXhGMk13QmNhOVJEcjdLaHJNYWZKdjA0L0FYbUxhMTdBVzlyMjBlS2k3VDNi?=
 =?utf-8?B?NDMzdVVZMGxsckN0ODNJdG85WlFkQWtEdjJPcHhHWjJiMExPUkxtcnJ4cGN3?=
 =?utf-8?B?RjNaaXZpRzVaNFQyeUdrSTVYUkdST0liKzBLcnl3U0ljeXh1YzNLKys4UVNy?=
 =?utf-8?B?Y2lFakkzZ0Z5L2VFZTliL01qb05qcVZSVFFZZVBoRTd2NUF0bkQrY285Smg0?=
 =?utf-8?B?VE9QM3pPMXZPREhCcHl1RzdYM01QbjhPMUpjVS9wa2FOVDZKZS8wbGw5Wlk5?=
 =?utf-8?B?Qml2YUxQWDdNZVFaK1JtY3hwcXZUbDVWZG5xNHhZUjJyM2k3WHB2ZkNtN3VY?=
 =?utf-8?B?WGIydzNYR3R4ZlNJYjc0RHNKUlM1d1FkSnVqcU5SVjYwQW91b2ZFYjZNQ2l1?=
 =?utf-8?B?MWk1VWFaQ0hzVFNIdktQYlB1azhpUTVhTWM3STdBRFIrMWU0SVh5TGFHanAy?=
 =?utf-8?B?eEl6VXM4UFpVUTRBQ0pROUwwTTZ5WmVNdEZWRHZpalA2R2ltM3k5SW1lSElN?=
 =?utf-8?B?enFDOXUzSllvR0ZzZ1VxK0MxN3pEVWg4ZUtyRFE2bUhnVkd3REY3TmlzYndQ?=
 =?utf-8?B?N0w2MnNqa2lGK0ZtNmFjVlFKYTF6N052KzAvejBBVFhvZmgxQmkzVnBaWWhi?=
 =?utf-8?B?VmE5YThBUjBVYnhjSmk4R2xkaGtqOHl2SlZOUzdYTXBnYlhxUHNXakE3RXhV?=
 =?utf-8?B?blByYWE2TXZ6UlZPYVVQa0dFZjJ1SkFRVEVBa3hsUEZ4TWxjVVdVVmJYRXI4?=
 =?utf-8?B?YXJQZ05PMmxjUlpVYUdOeVlSc3RNQ01KQzYxdVRmOUdSbW9pTWtubGxIOVVL?=
 =?utf-8?B?NVEzKzI3QWl5aHF6TStpQUEraCtkQVpZMVA0bGphVFBNVWl3VnVxc1BUN2Ro?=
 =?utf-8?B?SVRQVXI2WmxyMDM0emVidGtuWXd6L3UwZUplYXIxMjQzdGZ5YStlZmx6WUl2?=
 =?utf-8?B?eGtlYjhHNnVnTmY4SE5vRkJ0a1gvOUxCZ3Z3THUramg2UWRjYVQwbForRlg2?=
 =?utf-8?B?NDFlalo5SEpncTBtOXRqRVY1dE8wekd2KzI0YkEybHNuajNBNDJPdmxhcUQ2?=
 =?utf-8?B?bzlUZkZ3aEE5dzA2U2czcjM1K3dVMGFVMSs5d2ZQUFlrb2lMREZEM0xza25L?=
 =?utf-8?B?ckJvT1gyQUl4L2lZRm9sMzBXNHg3Y0xML28xYi9WKzFlT3c0VTRqYXl3TTk5?=
 =?utf-8?B?UU5hZGRBdk5YMVpqZDhwUFY1UU5YWUM4NVRpKyswMkQyUS8wMVJVdVZCQlVE?=
 =?utf-8?B?aFp4blpsL1Uwa2FxUlMybzU0T1cxQXhQemI3WjRGYWxGbGFabnhHbXpsNnVR?=
 =?utf-8?B?OTgvR005L3F6VTNSOStPdERlQ3BDb1dBWFJLeU5OaCtObmR1RGVsNmJQK0c5?=
 =?utf-8?B?RFNqTXRZV2dDS0g0L2VJZ0RZbkJZWEtGS3d1eHNsQ21FT2dsM29oMUduRnh1?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A9B79751CCA664DBFFF6809B373637A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a933364-6abe-466b-4f18-08da75e5295c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 06:47:12.7753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Bhe3Zg5sfvNyNRm8TYHAwjrsJC1X1HgUKBoszfNKsC1xqjizqbZYfk+GdJKqxcj2LkeofdYmJzFfFiClIB+Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3266
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNy8yOC8yMiAxNzoxNSwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFRoZSB0ZXN0
IGNhc2UgbnZtZS8wNDAgcGVyZm9ybXMgSS9PIHRvIGEgbnZtZiBkZXZpY2UgZmlsZS4gSG93ZXZl
ciwgaXQNCj4gc3BlY2lmaWVzIHdyb25nIHBhdGggdG8gdGhlIGRldmljZSBmaWxlIHRoZW4gdGhl
IEkvTyBpcyBkb25lIHRvIGENCj4gcmVndWxhciBmaWxlLiBIZW5jZSBmaXggdGhlIHBhdGguDQo+
IA0KPiBGaXhlczogZWJmMTk3ZDFhZWE0ICgibnZtZTogYWRkIG52bWYgcmVzZXQvZGlzY29ubmVj
dCBkdXJpbmcgdHJhZmZpYyB0ZXN0IikNCj4gU2lnbmVkLW9mZi1ieTogU2hpbidpY2hpcm8gS2F3
YXNha2kgPHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCj4gLS0tDQoNCkxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQot
Y2sNCg0KDQoNCg==
