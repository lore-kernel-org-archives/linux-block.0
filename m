Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7653C433B4
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 10:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B64613AF
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 10:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhEJKN0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 May 2021 06:13:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:18941 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhEJKNV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 May 2021 06:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620641537; x=1652177537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ycsnPzRUFqMGDZlGyI0dmxX+FlDFtyxHNvmwsvNdag0=;
  b=GZUjj7fxB7dimFhCQLmRoCtrrF0hHCPLAUeEoW2nL39pzH5ncsvpW97D
   4df4xEFqbQgOSk6Kmn83iKZIpLyVVkgdx2v+W0ESyCTm420NCK/zmVh45
   PXIAdmq1fxT4Ds03WcjGFl0x/HWtKAnxAzjI9hoinfxHJHtYef1433GEv
   VClfzJsONXnxnRmfMX8eobZqAzsbXdTxMQGUdQbjjuuWCLg7V0cbDJeU7
   WsLMI+ORDd8Sw9g90lks6a6B4Iwcojm+DlXDNeDAdkUf7NcK194IA1avR
   jiHAyfwMGMV+QLB+a7JLZjF3shE/3r0WKRg/zzmsDcoun//ppGu360Uuz
   g==;
IronPort-SDR: uACQpdQxsDeuadhylJqmxAEXfecRxGhtuCpPaJTbAZICwu5ZSPOmDlffA8T6QrdbV2P0wU98Go
 Zpg/GZXruOd7Gm0k0uwgP3CN7nfocaVInxZ4kJqmPLEzvqblQ1GcnJR8kHeR5G9GogyZaKRTrh
 FwP6rg6KeFnQQ4Xq3f4DGSZYEptcCVKlVrwFH7Gecbwd3k0/OMttxmxbGGqecipWP+G7w21Ee1
 Pyx0N2g4VcOFZJ9Rnn9D7i2e1wVUnNndOAWI4Ptfm+q3CCKEp/KwHw0WE2ODIin08fY4oOcyti
 baI=
X-IronPort-AV: E=Sophos;i="5.82,287,1613404800"; 
   d="scan'208";a="167623179"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2021 18:12:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eee9cTYoAPYvEMbn8z1Yr67U/uHmrQZzh/Gb/pkjUslzguOWreZtnWQPXt+F8LI9vmKePHy9+r5JULYk3J/BkPmHutVOg8rHPwLR2h5WeAVTfG+1MQN1pHhFw/EwkJA46KLGb0mCtkZAISU3PBVIPM0pvpvr3R5xqXRP5AlAIlPnEOh2QE2m2W9/4h6wjIZtTcuZxch7zzO5Z07lx0erON25yZsBXBcpKUclQ2nxqihlzW25l5UjYktbQPS9H5rHalpJIteMTR/FiFdB9b7kj2Get9GySvvGrRfLXZbSP7c5uPTjjwsnF7K59k2waLNiWW1EC8VirL7N1oMunNqYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycsnPzRUFqMGDZlGyI0dmxX+FlDFtyxHNvmwsvNdag0=;
 b=kW1PLD1e+SG9lVnX0QtXXEhBbxvVy90ZIQ4L13cdCe1qF5pP99myoOsQYKAw4fUjuaOubVi4AtcmBVlcGYHfmj9CTtwR+asPjkjMeEAQbYSs6uqmdC3Dz+Fl3jh7mEcVGTlbbK7UH5BBDfZawnx2XU8nRBKvzkyOf7w+jg7gTCK74Mn6CIGdOi8K53tTnpEl0YCjBS1cvkQSumFKg/yvAMp/UfhkLtDHFaJ+4KWVaF6YVgyWO/8uLt4g9fcqpzRiLiLbz8HhWRq/2Ruq38DplAOxyceDLD/v/l3r+ZHiesrK8YWxzNVV1ztDowgTkrsO/3an8lYMe/cmtw3zYh/Mqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycsnPzRUFqMGDZlGyI0dmxX+FlDFtyxHNvmwsvNdag0=;
 b=ZNWsOEYl4CQTytB8qNB67tsZ4AGNNTRGS9nirT4a4KEPeqtOcJm1QD7LOU1RyIAJOna+8XdO7H1nX9Uw9WiBMxaV/owkOjSYeHvCXxe2qKSeQOfP0MMKjdfIXGhZVzTudxIabSON/YJeNNizvKgnidMCXMoI1OqPHj6dalfoflM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4490.namprd04.prod.outlook.com (2603:10b6:5:22::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31; Mon, 10 May 2021 10:12:14 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 10:12:14 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] mmc: core: Implement support for cache ctrl for SD
 cards
Thread-Topic: [PATCH 0/2] mmc: core: Implement support for cache ctrl for SD
 cards
Thread-Index: AQHXQohNKxu4RT1OFEWqz8n335r4pKrcWPlggAAkBACAAAegYA==
Date:   Mon, 10 May 2021 10:12:14 +0000
Message-ID: <DM6PR04MB6575269203C4A8099C2527D3FC549@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210506145829.198823-1-ulf.hansson@linaro.org>
 <DM6PR04MB657511CDCE94264D080F006CFC549@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFqQe5aYqF6iNppY66EfkVNPce_sRF6NJgSn26Rs=_=jxw@mail.gmail.com>
In-Reply-To: <CAPDyKFqQe5aYqF6iNppY66EfkVNPce_sRF6NJgSn26Rs=_=jxw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71405fc5-1942-4fef-21c9-08d9139c15ac
x-ms-traffictypediagnostic: DM6PR04MB4490:
x-microsoft-antispam-prvs: <DM6PR04MB4490ED8F08FBA82B880E971EFC549@DM6PR04MB4490.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4WbqdFe7CkAXRTiCkf/Ito3HYIlGY1dubc+xndYOKCiPrBpDzOhfqfwBOsvKJEFkGlj7FjNQ0P6zDqx8hASbiU26KJhYiJt8TQwszvADLgHtK/8H+Sy3VcRhmevKUlmHgKvKVW+/wLUX9KWY3eQL0EDkijacqOxrb8858k65xdYoqNeXbtoGnBteQhUpxVrxnhU4O6DtdIfzc888Yu5U7zkeGzxVW5rR/wWzHQ6pw39B6zYrbjvFdkUvHmsbTiTH1Dp9UK5d/jHC3otrMKhmiCvqp+QF9Zbz2m/h3tpDb18uRdesGc1x5XM8vWCb04Rdy4mIgG/efcengDSWIkuXgPWLWa6ATYhWW4rUricjk7jT7n8MzfiBgA4Cb7bj1bDEJi568fhkEVPF1FGhjXfDDNWbmlcQsDKLFSZu+hijldcAwIBhWkZNzExV0fEMOSq5RwDWL76ex6NujhkJhQnIMwgG7L2qJFAqR9JYLVMaF2pH+eNAKOxjOr23hg3KsokVyXMHuX7sAsvg6eaQUpdxsBZfgEymDBZ1nUX2f7j2hZGp4WITcNG8r3pAKzbtNy8BmR1yGHYLmIolM2vNaiNKGupZBAzWIp3EhNhyfHV2Wmw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(376002)(366004)(346002)(66556008)(66476007)(8676002)(66446008)(64756008)(8936002)(26005)(6916009)(55016002)(76116006)(38100700002)(5660300002)(122000001)(66946007)(9686003)(52536014)(186003)(4326008)(71200400001)(86362001)(316002)(478600001)(2906002)(7696005)(6506007)(54906003)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eUlCQit3aGdtWDVKd3k2UExTLzNpcEc5QmZ2VGw3RnpsTGp5ZXFYUS9DdC9M?=
 =?utf-8?B?SGFGa3JZZzFVbXNnTjg5L0IvcDE1WTkxK0x0SHJPSDA0N2Y2Uk1CeThyeHVD?=
 =?utf-8?B?MllPTkJhc29hUGVmQkxMMFlTREc5OG84TldYenhzdHM0L1diakF6UzI1ODkr?=
 =?utf-8?B?ZjZFSWhCdlhmdzEzQUZ2VlRCWm9tMkhSNmhjdjVtMTloTUFUekxnckNnMXJs?=
 =?utf-8?B?bE9QZ2ovREpCZ0o5ZGxVWUV4Um9RRjRpYnQ5NXF3WjhzajZRTEE1ZXVrK04w?=
 =?utf-8?B?cjhlU2gvTnN2R2hzOTFtTHJDdUdTVGlwcUpFMW42SmI2dGQ4Z2FtSk5nSU1V?=
 =?utf-8?B?bzVlNWtLVFlVajJ1S0o5RnZRTE8zNmc2bnlLT0NUZnpCREtPNFYzUGJJOEc3?=
 =?utf-8?B?dDd5M2l2REF0TUcwUEkwMVAzRitXUExsUi9qTGM1WDhKeWtpVHJ3Y3Ird0ZC?=
 =?utf-8?B?OTZmMXBkZHo2b2ducmVhblBPY01CaFRhNUo5WTd1enpzaEtFaUJWL0o5YVJU?=
 =?utf-8?B?elNzOTNjd2ZnVWhlZUl2QjM5TmhBeThvRlpHQUJ3T1VZdlVXK3B4UjhncU9x?=
 =?utf-8?B?WWkrRHNFNUhSQTI3TnNTU25ydGpFMUJ6VlNDSFVoM1JYcG1qNnVHMEo0QmRw?=
 =?utf-8?B?eVpEOHJkTXZXTkFwVXZjVGthMDBJWFhEWGlIYU5kZnd2SjlVVDFEV05Bd2Z0?=
 =?utf-8?B?VFpKUXo4QUZ4MHZQVHplMFk4cmRYRmx5S2VKSEJQWHc1QTRvQWdxcHV5TVB4?=
 =?utf-8?B?ZjFkZHlSMHFkOElvNGxBZEZXdVFraCtab04zRForR2phUGVrNE5PNGFlNm1K?=
 =?utf-8?B?cnEwcmFWaEg1a3ZrT2hHNVRDVmZMcFBWWXZpT3Z3QkpoaWY2dFFyTHNSQlFR?=
 =?utf-8?B?SmF4dlRlTG5mdU1McXltUHhZNGlPbFZadkx0K0dIY3pRcTFKM0k1anpSVHVS?=
 =?utf-8?B?T0xlRllQYWY2cjNjVHZWZEhwcWovMGViQWw3ZHoyOGpMR0VxWG5Qd2tWMFZZ?=
 =?utf-8?B?dmtDbGN1Tk1IMmRTMlBZUVVVSDJXNjJDRzUyVHdzVVpjbERHYkhLaG1ia1FB?=
 =?utf-8?B?VUt5R3lIcGhXWVlGYnhTbVFHN2xrU1VEWmhHUnZ3b2lJbi82K2hDRHBBL2JQ?=
 =?utf-8?B?UDM1MEJHRWRJaXlMS1lmVUV1L0JVeWk2ODllK0JPZmJBYTJnZFlEb2IvU3py?=
 =?utf-8?B?UjVZQnBWRjBjWWJLTTg3aU9ydjAwTWJxS1pobVlkcGRuNFVSZDZNM1RyR3RB?=
 =?utf-8?B?Z3E4ay9VODErc0N0b3pQaEo0OXZEUGpiTGZ1czFyY2ErdHhwU0oyeUpYU2Z4?=
 =?utf-8?B?eER6RExDU0tnMkt6NWZ2UDZsRHRFQXgyTk5Tell3czM2L052c2RUT2FKQnhH?=
 =?utf-8?B?dTdXWXpseVdUUlRaQ1Z1a050b1ZrVXZzTEhBZThWaDRSTEZRdi9najBXV2s1?=
 =?utf-8?B?MCtZYkNENFVjTWR6TWhTaXJESmdVamx2aGJkV2VvK2pWWjdLTDY3WWdhZkpL?=
 =?utf-8?B?NmhrT1RUQXowZWdGWTBBbFlzcmRhNUxzcjZDU2RYQjI3eFdUV0dBdXlpem01?=
 =?utf-8?B?anlCVWdVUVNQckZzZFQ1eUNHcXhkc3VodytCRTM5OEZYblNCVHYyQ0pMMGhK?=
 =?utf-8?B?aHArcHZHVVlTdDR0alkvdUM4aTZyV2RuQndjRU5JbVkvcEllUWZNWHQ0YUZU?=
 =?utf-8?B?c0FDeTdmSERSbThwdGp2VXpTa0x1QmcyRWUvRWVrZEtvWlAyVGV3ZGh5Y1Jk?=
 =?utf-8?Q?WuZ6bf+Tid5ptfrsg60aCgjMXUz3G5qiUyX91vL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71405fc5-1942-4fef-21c9-08d9139c15ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 10:12:14.8446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjBSSTGdSDcVNOA1p9P9Pkx2ogEt6XKCxI+uwTVIyv1t44N0zHjcnLy7jKqs26L4TpYMWd+2ht8dk+kwJ57CWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4490
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiBPbiBNb24sIDEwIE1heSAyMDIxIGF0IDA5OjQwLCBBdnJpIEFsdG1hbiA8QXZyaS5BbHRtYW5A
d2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IEluIHRoZSBTRCBzcGVjIHY2LnggdGhlIFNEIGZ1
bmN0aW9uIGV4dGVuc2lvbiByZWdpc3RlcnMgZm9yIHBlcmZvcm1hbmNlDQo+ID4gPiBlbmhhbmNl
bWVudHMgd2VyZSBpbnRyb2R1Y2VkLiBBcyBhIHBhcnQgb2YgdGhpcyBhbiBvcHRpb25hbCBpbnRl
cm5hbA0KPiBjYWNoZQ0KPiA+ID4gb24NCj4gPiA+IHRoZSBTRCBjYXJkIGNhbiBiZSB1c2VkIHRv
IGltcHJvdmUgcGVyZm9ybWFuY2UuDQo+ID4gSnVzdCB0byB2ZXJpZnkgdGhhdCB5b3UgYXJlIGF3
YXJlIG9mIHRoYXQ6DQo+ID4gSW4gYWRkaXRpb24gdG8gdGhlIGV4dGVuc2lvbiBSZWdpc3RlcnMg
dGhhdCB3ZXJlIGRlZmluZWQgaW4gdGhlIHBoeXNpY2FsDQo+IGNvcmUgc3BlYywNCj4gPiB0aGVy
ZSB3YXMgYSBzZXBhcmF0ZSBkb2N1bWVudCB0aGF0IHdhcyByZWxlYXNlZCB0aGF0IHN1Z2dlc3Qg
YSBjb21tb24NCj4gT1MgQVBJJ3MgdG8gdGhvc2UgcmVnaXN0ZXJzLg0KPiA+IEl0IGlzIGNhbGxl
ZCAiU0Qgc3BlY2lmaWNhdGlvbiBwYXJ0IEE1LCBTRCBFeHRlbnNpb25zIEFQSSBzcGVjaWZpY2F0
aW9uIi4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHBvaW50ZXIhDQo+IA0KPiBJIGRpZCBoYXZlIGEg
dmVyeSBicmllZiBsb29rIGF0IHRoaXMuIFRoZSBjb25jbHVzaW9uIEkgbWFkZSBpcyB0aGF0DQo+
IHRoaXMgaXMgd2F5IG92ZXIgZGVzaWduZWQgdG8gZW5hYmxlIHN1cHBvcnQgZm9yIGZlYXR1cmVz
IGxpa2UgY2FjaGUNCj4gYW5kIHBvd2Vyb2ZmIG5vdGlmaWNhdGlvbi4gSG93ZXZlciwgdGhlcmUg
bWF5IGJlIG90aGVyIHVzZSBjYXNlcyB0aGF0DQo+IGNvdWxkIGJlbmVmaXQgZnJvbSBhIHVzZXIg
c3BhY2UgbGlicmFyeSwgYWxvbmcgdGhlIGxpbmVzIG9mIHRoZSBTRA0KPiBFeHRlbnNpb25zIEFQ
SSwgYnV0IEkgY2FuJ3QgcmVhbGx5IHRlbGwuDQo+IA0KPiBEbyB5b3UgaGF2ZSBhbiBpbnRlcmVz
dCBhcm91bmQgdGhpcyB0aGF0IHlvdSBjYW4gc2hhcmU/DQpOb3QgYXQgdGhlIG1vbWVudC4gU3Rp
bGwgdGhpbmtpbmcgYWJvdXQgdGhpcy4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiBUaGFua3Mg
Zm9yIHJldmlld2luZyENCj4gDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo=
