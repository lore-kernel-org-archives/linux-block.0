Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AA4EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 22:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjF1WXZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 18:23:25 -0400
Received: from mail-dm6nam04on2060.outbound.protection.outlook.com ([40.107.102.60]:22784
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229524AbjF1WXY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 18:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgZGSC9Ios3CRznfySgjDHPifRnSQnus4I+aN+sqtUlZapMirmD5r7v4kTe6uolZ1KJUSjl+2SNq8sfAK1OU5U8ovoIwcsg7gFdaoYqCCyCVxVbR5BMRTjhBmd2pjRsl7SL1dNkYxZIbHA57qIB7oxOcGU78PkqN0ygspdLLiEH+JNCq5yhS9IiRoLMZeOOH17Jz8rgBEzZ4f0CAY+dvJyDTxUgxG9IVCGPEExE24G5iHEAPVTcrhpDDgaCuwB8ezww/xuNBxGUHja9okGN92iVpb2Cee2XYRjKT9uytPsAV6pUfaOOA/gnuv1gqTOhdeEZ6Hx3Sr116s6Rr/0210g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dCOpxqCYufHE4Vr66fYkBHXGVBOdpMFJfHqT+GtiF4=;
 b=fBBdznOwSN6L0ru7GAsedFMHYEh5PQZhHwHW/gtiTfUqbNIrfF8xmToyRGvesftxGoELBuomvvgbTjllp0aV2TqwAhAtH8eOT7ukyZQf0PbgWrHJG8mNt2YNOi5HZqfyHpTi4xcwT3Ur69B7Dd1mUmSz5DwuybzUHJ39UxOQmod3ExIakPK2hRcPXWDbAVSSOnyfi9XHTsxRiQ+kYo7hncFVlXD16DpdIX2g5++lEuapc/ugZ5dFewI81esRrwXx1MTvGVaG7pDwuh8dNdwoyBxlTA+PQf3b+M9xnrKIGBAgC8+Qt7fltdJZ7bN5xJ3pqUmeI1jvciXk3DKG3vrPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dCOpxqCYufHE4Vr66fYkBHXGVBOdpMFJfHqT+GtiF4=;
 b=qG8rPl/LePm5DuA8q8Yjb+DRHCrAvKfHX2oqfUkbtncXNlnEPFmvXUO64agjmVXq/CVJtB6nD5Icy7kDnwlKOWceZrrxzGxYof4mFcwLroaMkKcm/mrRfIIjdayXlj0o/WHKykQL3oIyV91Jff8WQ2nN1WgMjeDVQ5MkyWvfVy4RwOzejNpbOAszW9SzFF/dS5SpkUqmzcq6YP8uB94Bgvba6Mz2inrAU4oHNSZRuuD0aLfkEJD56CINWB3Hpdkg0iSmEz5AXLPCozS8jFaN91UKztmip1hz6jPVfHloyJ3KtSUHBuZjCdCEHtVxVzz+KYKTVN9XcDg4SEk44o32og==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 22:23:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 22:23:21 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/rc: specify hostnqn to hostid to nvme
 discover and connect
Thread-Topic: [PATCH blktests] nvme/rc: specify hostnqn to hostid to nvme
 discover and connect
Thread-Index: AQHZqb4vSkBgwK/Kxki5ddgk8sSOwq+gys6A
Date:   Wed, 28 Jun 2023 22:23:21 +0000
Message-ID: <8bdf2fab-50a9-874e-3143-480203842cef@nvidia.com>
References: <20230628124343.2900339-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230628124343.2900339-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH2PR12MB4150:EE_
x-ms-office365-filtering-correlation-id: 109e5510-c034-4309-7c91-08db782647e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k0N7D6w+bcfnZSQbuNOKt2UFQjzEyGhFwfNp4/jWhnWuL2sGW9O2CHuR4heGTispF6EXwGPCVjs0NG6wqaKOamllbO/JRuKGDtYl4Qlwe/1VtBAfkaSUu4UFd6Mp8BAlrLtc3QzCnAU+IUcMo5X0MIOuQwPKxfl+Wmczo60LRs0lLRmXDBeyxWT5DGla9tGmSWPbe0XUktT+ghjkckeJrDzc3etdomqMqOJvCbI3AAZ73jYqW2I2UQH9DDT0XYrFi22aSbsuVsWx0ytIkKfxDFQCk6i+1JGwCAHEwHkkusdso/nHkNj36ghfWEoNfV9WCOGFQEHvYLJb3eC5RBoog3G8qiE8jAqbTlMKS6ohi9hg8PrOubCFSCKA3iaBD4Zo9lOJJ51NmUouUl0CUZYm2dwdOCpEMx0jC9oVgHeMcf9Y7lhya+UtobOlVqG3WO8TysszD7lrpGYgRBytU4RE9RFuTHjMXcs3m627m6F0mlyqp4b8DNf9la9r15biENkTaQc2eddcQ8yRtUytapyxNKufy4FzyTqRCPzQUIfws5IJq5Q2GBpKe9p2rMN7rg/DueBZ/5DCldDU75MuTP6zZ+D4eHRocV9iioGOey3Qk4dgcPX/+EgJ6Z5NttP5r7lHdgrEbc0BJ8wKq1q+5RBC6MJH+VoRYWhNQ4nashsrYgZE7ttC0Xg1FZzuVnMHboRGytR3Zp3zL8MXmYBnr/JvDQxFyy/3K5uQwaUuvXvu9KAhrmvRUEdew46uITQHyH+j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(53546011)(66446008)(966005)(54906003)(6486002)(110136005)(71200400001)(83380400001)(2906002)(2616005)(6512007)(478600001)(6506007)(186003)(5660300002)(64756008)(36756003)(38070700005)(4326008)(31696002)(316002)(76116006)(66946007)(38100700002)(6636002)(8936002)(66556008)(8676002)(86362001)(91956017)(66476007)(122000001)(41300700001)(31686004)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1JpbVZ1bUcvQ2Uyc2trZEo5aERlTHhTZW5ZTXBWSC9BWTNnSG1ENVpLekdF?=
 =?utf-8?B?ZzB3MzJPVVJkMXVUNVNVL256ZDlWUmJwY2JoUUh5RmF4czZGdi9ldzhBOTYz?=
 =?utf-8?B?TEpVNUt4d0NqYmxZTUlDWlkvdVNSVzVzYm91SS9MRmRiNFJLZFlXa1JvSFRF?=
 =?utf-8?B?QUNtR3Bacy9uVHg2aU90Z1Q0c3NZa1lORExUSm10WlFGdDhPV2c1cjB6Z2Jh?=
 =?utf-8?B?RkxKNlZHYWsvMC9odC9Tak9MY0o1YUU5OG1kSDZjbmNzdmtHRzVwSloyUElS?=
 =?utf-8?B?RWpidERuWXQ1TlA5R1JUVnNqVWIxU2dKei9oay96UjZXbVJkdDZjQllTMVE1?=
 =?utf-8?B?N29ZY0JUZk1NdUlHVTFCSFRhdHZLZUw0Y0ZKcmo0MUxRdzBSQ08yZWlQZkI0?=
 =?utf-8?B?RXk4NFdqL3lLdk9RTmlpY3Bpbm5RS25VWG5vdlRLcVB1MFQrMWZVVWhzc25X?=
 =?utf-8?B?ZCtHWFRrVFQ4M0VXZVpjbjhLZmZ1K1Q3L0oyNkcvSDhSNzFLUFRQbUluZWty?=
 =?utf-8?B?WVpzRmt6ZGQ0Z3M1L1RzS2szRXM5MHFIVU1JUHZPSmJpUFdOeTZqaWNiM3dJ?=
 =?utf-8?B?T3ZmeHJuSTNpS3BVUDdZOWxPUmt6SCtrY21tL2VwZmpIaFdOUko1ajNTVGlv?=
 =?utf-8?B?N0F0RldtRndadkwycjFFLzd3aU8rVnFDUDUyTUpObkhkZ01Db044dklnNVJL?=
 =?utf-8?B?OFZ1OEVCeSs1YllURTdDR0Jwc2p4VncrdWE3MmxZSUpab2dRVzN2NW42S2Y3?=
 =?utf-8?B?N2p3ZWJlNlVmYWM5eE1hbUNwVGVNWU1zcm0rZ1p5UHRYUGdWVTk1MGZUYWJl?=
 =?utf-8?B?NXgrOUxHakhEVHQ4TlN1NmN3RGNvbC9nSWQ5SktMUVdKdThTWWdsek9IbC9w?=
 =?utf-8?B?SkcxMEY2WE1FanhvL05kMTBVT2ZBblJLVXJ2UGh3UnViWUIwdzVZczdCNUxi?=
 =?utf-8?B?azVub3FFQnE3MXNtbjRpMXk1TjhGZWtLb090a0F3OStVbzAxak5LNzB2c1ZO?=
 =?utf-8?B?dGtGMHBTaXhJU3kvVkZWUkp5M3FucG1tS3EzZzFOeHhtM1NRSXdpWklRRytH?=
 =?utf-8?B?dGVXZ08zMHowQ0lhSVhheGdnQkMxeFhpbk1BNWd4eW8xUlptV1VWMlpFd2Na?=
 =?utf-8?B?b0Jya3VaUUR3NkhzbU1NZUdXSEVKeXdJTGlpVnNjT2ZCZUtPa2xHUmI1dWJF?=
 =?utf-8?B?Wkd3TmovcHJiNjBGQ1FvUGNaVjZKTzhsaVhMT3B2NjZqdzVieHVrL21xR1ZN?=
 =?utf-8?B?d2RwNng4WlFkRjJrYkhXM1hrSGtiSG4vaWRac29ESjgybDRLVmljY3FuK0J5?=
 =?utf-8?B?cmEzd0dxZlN1RUlxN1lmaUdhdWg4UDVwOEpOQWZJTkFlUGxadjY5bTBPZVVu?=
 =?utf-8?B?ZGhUTWdUQXhQU0hqQno3VTlCV0FlalIyM3d1TWR1cXJ1eWNOMlo4LzRZNVRp?=
 =?utf-8?B?aGh4Mll6UnN2cjZ3Qm9HV0xvR0hYK0t6bzFieHdNVzcwYjhjNDVkMHBFK01v?=
 =?utf-8?B?dUlOZVV2Mnl5MHpLb3hVVi8yTUZwM0ZPNS9oZi9GN2FxaWJ3UVZTK0dTZ0R0?=
 =?utf-8?B?NlFJZjVkMmNpVjF1ZENYSWdDa1RkWmU4U0NLK3F0c0FWVUxCT3hQMFhBYUNr?=
 =?utf-8?B?dytDT0RMVEdWWGcvWlFCajltVTVCeXBJRU43UXZTay9WLzFRcjVSdnRrZWF0?=
 =?utf-8?B?RVFzNUI0NVQzZEIvVjhkLzUzVzJESkdkWXJtNGVKdnliTXdIMWxycmljbjlS?=
 =?utf-8?B?SFBvWVVkajNQeUR6T0F0Z2JvQlAzeW14dk4vcHVYeERLTGUydDhydzdBWlVU?=
 =?utf-8?B?NC9rRWJsbnl6VW5PS3lPampuaWMvS0ZmM0s0WkozenM4c0JoWVJjOWNnQjFZ?=
 =?utf-8?B?SDQvTkhSQTZ1bkx5SFdqcGpqZnVwbEFxN0ZaTU1pbSswdVpQTUNVN3NTbUph?=
 =?utf-8?B?MGRPS091TS9IWmpEN01QYVdDNXc2bEo0OUdJUjB1TWpIZXBWMUFVc3NGUzl3?=
 =?utf-8?B?Q1pYTm85Q3dmeWxIenZOMlYzMUYwZUt0OHhaTnpQVDJxUi9TSGt1YXUvd01r?=
 =?utf-8?B?WXFWZkFTZVpUMm81cnBua0xqS1E3aitTVE93NlFKUWxWSGltaS82cVRmMFNk?=
 =?utf-8?B?S0lkUVdQSVpwNzMvRUc0cDd6NHc3dW1TU1V3d0ZFT2pycnNSaTk1SjFmdk5s?=
 =?utf-8?Q?w5mP2G561CLkYVErw0+tN7m1ZBmKE0bXWEH4O6R55uQH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C8862CC16D86E4E90C44188C559C989@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109e5510-c034-4309-7c91-08db782647e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 22:23:21.2976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEjwqFZu2azNTm0BVbyLdZND+hkH+bJB2xScIHW9zcvChRXs9gw8Uo361Wzi3/8VS+d27jsVE6JxLSbMlob+0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

U2hpbmljaGlyby9NYXgsDQoNCk9uIDYvMjgvMjAyMyA1OjQzIEFNLCBTaGluJ2ljaGlybyBLYXdh
c2FraSB3cm90ZToNCj4gRnJvbTogTWF4IEd1cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4N
Cj4gDQo+IEFmdGVyIHRoZSBrZXJuZWwgY29tbWl0IGFlOGJkNjA2ZTA5YiAoIm52bWUtZmFicmlj
czogcHJldmVudCBvdmVycmlkaW5nDQo+IG9mIGV4aXN0aW5nIGhvc3QiKSwgJ252bWUgZGlzY292
ZXInIGFuZCAnbnZtZSBjb25uZWN0JyBjb21tYW5kcyBmYWlsDQo+IHdoZW4gcGFpciBvZiBob3N0
aWQgYW5kIGhvc3RucW4gaXMgbm90IHByb3ZpZGUuIFRoaXMgY2F1c2VkIGZhaWx1cmUgb2YNCj4g
bWFueSB0ZXN0IGNhc2VzIGluIHRoZSBudm1lIGdyb3VwIHdpdGgga2VybmVsIG1lc3NhZ2VzICJu
dm1lX2ZhYnJpY3M6DQo+IGZvdW5kIHNhbWUgaG9zdGlkIFhYWCBidXQgZGlmZmVyZW50IGhvc3Ru
cW4gWVlZIi4NCj4gDQo+IFRvIGF2b2lkIHRoZSBmYWlsdXJlLCBzcGVjaWZ5IHZhbGlkIGhvc3Ru
cW4gYW5kIGhvc3RpZCB0byB0aGUgbnZtZQ0KPiBjb21tYW5kcyBhbHdheXMuIFByZXBhcmUgZGVm
X2hvc3RucW4gYW5kIGRlZl9ob3N0aWQgZXZlbiB3aGVuDQo+IC9ldGMvbnZtZS9ob3N0bnFuIG9y
IC9ldGMvbnZtZS9ob3N0aWQgaXMgbm90IGF2YWlsYWJsZS4gVXNpbmcgdGhlc2UNCj4gdmFsdWVz
LCBhZGQgLS1ob3N0bnFuIGFuZCAtLWhvc3RpZCBvcHRpb25zIHRvIHRoZSBudm1lIGNvbW1hbmRz
IGluDQo+IF9udm1lX2Rpc2NvdmVyKCkgYW5kIF9udm1lX2Nvbm5lY3Rfc3Vic3lzKCkuDQo+IA0K
PiBSZXBvcnRlZC1ieTogWWkgWmhhbmcgPHlpLnpoYW5nQHJlZGhhdC5jb20+DQo+IExpbms6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52bWUvQ0FIajRjc19xVVd6ZXREMDIwM0VLYkJM
TnYzS0Y9cWdUTHNXTGVITjNQWTdVRTZtem13QG1haWwuZ21haWwuY29tLw0KPiBTaWduZWQtb2Zm
LWJ5OiBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBTaGluJ2ljaGlybyBLYXdhc2FraSA8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMuY29tPg0KDQpU
aGFua3MgZm9yIGZpeGluZyB0aGlzIHF1aWNrbHkuDQoNCkkndmUgdGVzdGVkIHRoaXMgcGF0Y2gg
b24gbXkgc2V0dXAgd2hlcmUgdGhlcmUgd2FzIG5vIGVycm9ycy4NCg0KV2l0aCB0aGlzIHBhdGNo
IGFsbCB0aGUgdGVzdGVjYXNlcyBhcmUgcGFzc2luZyBvbiBteSBub24tYnJva2VuIHNldHVwLA0K
YnV0IHBsZWFzZSB3YWl0IGZvciBZaSdzIFRlc3RlZC1ieSB0YWcgYmVmb3JlIGFwcGx5aW5nIHRo
ZSBwYXRjaC4NCg0Kd2l0aCB0aGF0IDotDQoNClRlc3RlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBu
dmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
