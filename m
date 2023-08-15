Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646DDC001B0
	for <linux-block@archiver.kernel.org>; Tue, 15 Aug 2023 01:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjHOBAt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Aug 2023 21:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjHOBAZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Aug 2023 21:00:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CC0171B
        for <linux-block@vger.kernel.org>; Mon, 14 Aug 2023 18:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9nPyTuSCH02lVN+XFVF8/2aLanLPk0DmuJN0gfJL0Cf/6yvixRrj3o6rrE+7A+EGFnHZhfcCEmxUh8D3eK8jIq7AJRCWYwLS61rdzc7wQIDrSUZmDFdTyenor0CppxTqITUGPj/Ad0hXKwbhsXQpZD/HuCsxIpNMfolqTcstFEe3ozZ9GghREXuojoWwbuE2zvZdFk3zCJLGikfZ12TfhAhAvT6tW5uM6fuSIWFYNIopAf6Mba7yFWTKR0IHe2xGBhq7TGYkiA4MX0Ks/GaJGvXLm/UbCsHd0pDzuCGFoQFJtYHDFgR+eiu3UYWW7c6ZEHE5DrSkNx/9YdQEjuWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9jBLogBkphKvMw68+SInINRwAdRplFmdnFahaR63vE=;
 b=m//00+qJWWYOaAOcI5puZGOxPsowgx2JnJ1OkfqMVFbXRDaRE5H1Sgs23oSsWoevO9d7Dr1g6RMOjXJPfbzBXBfeeLWTZc1e8tCcQB8gTMW0BRvdSiW071ch9jvV1w9Wf+3xm9kLY4b8TZyHmdOVsdHo4sSWVL6elytXPbwnUDb2uNnMylVfEEkG4WeKO6FMZ08KdIJ3DNQjVudF3HtH/FeJ4B+vYtHB88SRo2TWjupGRQf1hJ6bu9J8FB51udxRi+Ab/aGPVfLqlNpwUPw2qjpGYgOglwOiTIuae0TjAL8cfNL6CGJPuB4tEIcgbpERNAVS8QPe144A5x2KBIme9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9jBLogBkphKvMw68+SInINRwAdRplFmdnFahaR63vE=;
 b=e33kpP8Kd3UKZ9ttFOs5wb6/OZgmUf4psX7+4D4VDyMEpBIc29EqXQwG816ryik5SCrhYdKf/aLGyR+Pk/l65vZpBqSN35Ao2ypUBcwtPI0TRR1fbJAJki8d7UvgmZDAC2hz+EK4g5mHhOyu/uxtW3E3TyMcT2D3lmCttDSzYxQs5I+Nxv71qyJgjEDNwf0Aduc3FEP5EkDLFVVE8Vf+fMmX+OqFpg/8eyE+/jQ7Upm3PsIz/Cj3zApFPhiJAnvts7Lt9C7m4aK+BA7heiPVQcrw1Rf0kXNsoIe4AA9qGUFpLuqJ1GocSmP2CjMx6I5YlPJqBpQgAmHMv280EF52zA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by SA1PR12MB7410.namprd12.prod.outlook.com (2603:10b6:806:2b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 01:00:18 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::29b:43f7:7030:6be3]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::29b:43f7:7030:6be3%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 01:00:18 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Igor Pylypiv <ipylypiv@google.com>,
        Damien Le Moal <dlemoal@kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: uapi: Fix compilation errors using ioprio.h with
 C++
Thread-Topic: [PATCH] block: uapi: Fix compilation errors using ioprio.h with
 C++
Thread-Index: AQHZzvqfcNN4kdqfsUyr7wrttORX+q/qYT+AgAAohIA=
Date:   Tue, 15 Aug 2023 01:00:18 +0000
Message-ID: <6aafb857-aadd-f151-87f3-1c1a6a319bd6@nvidia.com>
References: <20230814215833.259286-1-dlemoal@kernel.org>
 <ZNqsJ5KkUwl8XsqG@google.com>
In-Reply-To: <ZNqsJ5KkUwl8XsqG@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|SA1PR12MB7410:EE_
x-ms-office365-filtering-correlation-id: 91324dd2-5cac-48dd-d3f1-08db9d2afe93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UPxRpXZT6g3CDF47VtD2i8teJiGu5mrC8bXOoxuttSLaOt0+0F4catpPNfFGQJPqc5D8Vu1K30XfoQbXOOFOt/MaVE9frBCh/HjnvAjYS3SXNvPXVhqlx92DhWtq8L66uenZbtRyroGt4E7K8PIPKEJjKCT287QNaIpJ8SRxsru4Jyu+naSukbodS4nWumkLMGB/T4G6d9P94805MGOGvjScJ85lmWiwrqi4xjhVpkp2H29tSlkYjenUAJH6rBoGflnFVCUnydo7H7Jg/Gu5gFTeoZU6gskqns8e9JHEdlsIUAG+1ttlVxl/BbVSPCNeOecsAJtmX56txQ+n58HeTmh2/yfBuP11U/8o9KROFf5MMZXqsQyuqE6s5u126sdy7T8qNJ5RctrY+c/o7dSoS4vWtTjfvlO5IorJOmpltgEO8cs9oscxzI4R2sh0J2up0Z63pf8U/jJaxpQs0CbkV/UNkRzeukiG3FdgukNLiqB9ChlFtGz/GvKQ7hiZG65MNasU+QAUW+7S/HRDQ/DYKS0sIyQ5OKuboH8vxXyw/KuRArk2CP3b4xcMxVVITHcgiLRMeUvyibNu7Xkp2hvhWvKV0ml+tehOjC1zShC3VNOjX/Y0f3dTrK6x5rYbDsQwzZltCSyqXmKgJODO1su1NBZzpMpc1ENtwsgg867zt/M2VmInVtVHic9XFcC/yNul
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(83380400001)(36756003)(31686004)(31696002)(86362001)(41300700001)(478600001)(38070700005)(91956017)(66946007)(66476007)(54906003)(6512007)(76116006)(64756008)(66556008)(122000001)(316002)(8676002)(66446008)(110136005)(5660300002)(4326008)(8936002)(38100700002)(2616005)(6486002)(2906002)(6506007)(53546011)(4744005)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHoyWDlJYVJiYmlXNzcxc25mczlqMWo3Z3VpLzI4cWtXS0FoVjRoaVVVNlNw?=
 =?utf-8?B?YzNiaktEaWY1ZDRwaGdTSDRVVm9HeVh1d2xuZHp3TFZvU1RZVDBsd2tIOWF3?=
 =?utf-8?B?R3dsS1g5Z0NuZ0NDVTBzdGVBRVBkNEdhaVlxb3FDYzFQWHJtU0V1b3dUbjFQ?=
 =?utf-8?B?YzhNOEFld3BrS3lhcWh5ZmYwUWlEdEZka0NrUVM0RGowWWVpR0FWUCtsTjEz?=
 =?utf-8?B?OUJIb0tZOHA4Y1FXdGc1UVFFZktsTlRIMW9sMVJrRzJzMmk4L08xanRGR3dB?=
 =?utf-8?B?aUtqTjJjb2V1RURab1FLUnBUbFk0VTV6UXhHY29TNWRXb1VqdUdJMjFMa0Ri?=
 =?utf-8?B?ZmxQU1N4TjFDNmhVUWVtWHBOOVpES2Rob2YvNEJzeWNwTGwwV00vZmczVHFD?=
 =?utf-8?B?M1VrcHNnYVp4am9pU0NvRUt1Q0ZqdVNaSTVLWWxSTURvN2NaS0crOG51RkVq?=
 =?utf-8?B?L1JKSkdKeFJRVW5NUHM2Zm8zUURoeXdkTnhNQ0ZSR29XamF0YWJ6V0RjYnN6?=
 =?utf-8?B?c0lDRUNyZXVKS3NoT1p0R0tZbmVuaWFwMjd6UXFCVS8wZHBMVGtUVlZFbjVI?=
 =?utf-8?B?WHZ2eGRLTDFYRndiZElLKzNUb25Xa0hHV1RneHdVUGE0SWpOemxRK2RrZGhy?=
 =?utf-8?B?cUhlUEoyZ1RhU3ByU3MxK0ZSQzJFTFBYQ2xySldyQ0RPYmF5cExzNThLQVNW?=
 =?utf-8?B?blJoUVZHd2UwRlRFL2Q5OXUrVWpDS2Ewcm80YXJFMy9WYlhRMkdoaDJ5UjU4?=
 =?utf-8?B?cERLRGlVZmkzUzhGdHJ5YlE4OFJkb2wzdmpCUEhBa3Z5THBBMnZ6QVVUa3VK?=
 =?utf-8?B?M2lEb3hBSmpZYk1iSHF4UnlaMXRTS3VXc1puajAvRkFVTzBjekFlQ0VMTmhK?=
 =?utf-8?B?eFBiWW9JTEZhUVlGdTlQUVJZMEhJYXp2L3JBUHUvamIyRGZwV1BpcUFOYXFW?=
 =?utf-8?B?MnNaN2RlQlI5VWF0ZGZuVTU2bitnamVaTXQyWk5DTGp6Wnhta2NKMWF1aVJr?=
 =?utf-8?B?Q3ViZkhSMktrcTJIQlFjM216OXJYZSszWGlOZjRvNXZHc1ZKTDZ5TUoxRmxO?=
 =?utf-8?B?WWRIQkZpa25QS2EzUVIvSXN0ZzhkZ0xPNTBPSittQ2pidUN4dVhTdys4cXRK?=
 =?utf-8?B?aVBTSk56VjFiRkFaOXkzUWM0aWJqaFZra1JZeUJ6UWhMaVkrVDVhZ29xUGJp?=
 =?utf-8?B?QUZWdHp4a1QwRGNCcU9keC9ZYjZkOXZzNFJVamFkeVNXRGFVSHJnS2UvZjh0?=
 =?utf-8?B?N1RXZEQ3alJ2WW1VL01aV21JL3FLdGRJSWVraEdaWkFxVXVJRTYwcVhOVjky?=
 =?utf-8?B?dGM4bDhDTHlnMGRBV2F5c1JQR0VmTzMvYk5EQXNySGd5RjJFOFIvUEQ2a2Fp?=
 =?utf-8?B?eVNKaEhyejF3ckl6ZWo5LzRXVGwybGtjcU12ZG0xTTUyV0VacXhQNWNhK3A3?=
 =?utf-8?B?M1hSazYrVEw5bzJZeHZUTFJPWDhuV2lRb1U5SXBCQUJTdEc2azZyRVdjNzlD?=
 =?utf-8?B?SjA5SnZ3dFRZSDg1WXROZlBTRVhJRTlhUWRVSzUxL0pFb0JKcTNwVVJwMVV6?=
 =?utf-8?B?RlVYQWx1UGJlTXdsSW5TVW43YWk3cDY3enptdVdKdFk0OFJnTHZWVGZqV29U?=
 =?utf-8?B?Y3FSczNMUWx5aW5zR3RUQ2dVSkRKWnlReTVoYnM2N25ZRDRLUkRBM1JYekJ5?=
 =?utf-8?B?MW1nRVpUODhVb3hBcE1wQ04zZVYrNWlhQnVDTjFZUTJBL2pOQlpJbmxNNnpM?=
 =?utf-8?B?YXZKOE9LdWVocGZUL3FKNC8wTmRLUFVKS003VXhJQ2ZBTUJXb2NNV1JnUDNU?=
 =?utf-8?B?Z0g1bmhFdStNWUc2N2k1aGU1d3I1YmlGb0Vkemk4bEx5eEpmamg5S0dWWnBK?=
 =?utf-8?B?MXBObXhvU1M4NzI0VlZDeHJQdHRBNktiNkx4dWxkbHZCVjY4dVRkWUlrc04v?=
 =?utf-8?B?aTdRVXJaMjR1OHRQKy8rWit5d054RWVRb2tLTzl0ZkQvMzJva0xLRlM4bnlL?=
 =?utf-8?B?VHRmOExxSXBkV1ZvVjl1dHg5TFgyOTFoRFpvaysrQnFjMmI0U2JFSFIwWU5j?=
 =?utf-8?B?Tkd5clpWK3dFSnplNkJMWHRBRjV6d3Zyd3NvY05FcGVKc2ZUcVc4SE14TnBO?=
 =?utf-8?B?T2VCSnl6U2pCYXQxZVV2cktoZGhBdW9CdjIwbFBYVW02NTZsOFpXeDIzQisy?=
 =?utf-8?Q?OPBcDAK0uMNCLiEynpbQVTHd3dxh0nyRqKlDXI8q5g/n?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <341FE753E7422C41BEC829A17532A95D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91324dd2-5cac-48dd-d3f1-08db9d2afe93
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 01:00:18.8042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yET+2T+pjOL2n5HK2gJUta1TtBTf5oaZ8/g+6O9HIHD/FdqPhbb+0s7IUzS6+XtxmRrcTQH1cFOxia+XsVy8Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8xNC8yMDIzIDM6MzUgUE0sIElnb3IgUHlseXBpdiB3cm90ZToNCj4gT24gVHVlLCBBdWcg
MTUsIDIwMjMgYXQgMDY6NTg6MzJBTSArMDkwMCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+PiBU
aGUgdXNlIG9mIHRoZSAiY2xhc3MiIGFyZ3VtZW50IG5hbWUgaW4gdGhlIGlvcHJpb192YWx1ZSgp
IGlubGluZQ0KPj4gZnVuY3Rpb24gaW4gaW5jbHVkZS91YXBpL2xpbnV4L2lvcHJpby5oIGNvbmZ1
c2VzIEMrKyBjb21waWxlcnMNCj4+IHJlc3VsdGluZyBpbiBjb21waWxhdGlvbiBlcnJvcnMgc3Vj
aCBhczoNCj4+DQo+PiAvdXNyL2luY2x1ZGUvbGludXgvaW9wcmlvLmg6MTEwOjQzOiBlcnJvcjog
ZXhwZWN0ZWQgcHJpbWFyeS1leHByZXNzaW9uIGJlZm9yZSDigJhpbnTigJkNCj4+ICAgIDExMCB8
IHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgX191MTYgaW9wcmlvX3ZhbHVlKGludCBjbGFzcywgaW50
IGxldmVsLCBpbnQgaGludCkNCj4+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF5+fg0KPj4NCj4+IGZvciB1c2VyIEMrKyBwcm9ncmFtcyBpbmNsdWRp
bmcgbGludXgvaW9wcmlvLmguDQo+Pg0KPj4gQXZvaWQgdGhlc2UgZXJyb3JzIGJ5IHJlbmFtaW5n
IHRoZSBhcmd1bWVudHMgb2YgdGhlIGlvcHJpb192YWx1ZSgpDQo+PiBmdW5jdGlvbiB0byBwcmlv
Y2xhc3MsIHByaW9sZXZlbCBhbmQgcHJpb2hpbnQuIEZvciBjb25zaXN0ZW5jeSwgdGhlDQo+PiBh
cmd1bWVudHMgb2YgdGhlIElPUFJJT19QUklPX1ZBTFVFKCkgYW5kIElPUFJJT19QUklPX1ZBTFVF
X0hJTlQoKSBtYWNyb3MNCj4+IGFyZSBhbHNvIHJlbmFtZWQgaW4gdGhlIHNhbWUgbWFubmVyLg0K
Pj4NCj4+IFJlcG9ydGVkLWJ5OiBJZ29yIFB5bHlwaXYgPGlweWx5cGl2QGdvb2dsZS5jb20+DQo+
PiBGaXhlczogMDE1ODRjMWUyMzM3ICgic2NzaTogYmxvY2s6IEltcHJvdmUgaW9wcmlvIHZhbHVl
IHZhbGlkaXR5IGNoZWNrcyIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxl
bW9hbEBrZXJuZWwub3JnPg0KPiANCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8
a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=
