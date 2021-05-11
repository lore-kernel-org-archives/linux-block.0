Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B44C433ED
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 08:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF4961584
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 08:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhEKIXR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 04:23:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:18712 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhEKIXQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 04:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620721362; x=1652257362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZEMMhCIkyjBeIx5lvFiqssn95qBy8IwJ1vtYySIFx80=;
  b=Ndd2eUQQHGFROMDebaVPKVz4bqhvcQuUSSLkVnv8t7xQjvpyyLfNOJsO
   kwUzbKDruSisZpbDC/E0OgtZ87dM+MnwQkzIjVckX4k3joJmIEgv+weuF
   9DS8ig3jwqoBWJLeuGmhqxcYhbl5Op/Qx6WtTF4rxoj3CsKqpHGXRkl+C
   xa1kD9l/nEsYI+kVVWaMUysyoQmzRVH6/C++gZ5nI2DImCCuvdENJdTMb
   d4/tqG0HXCIva4ugMny30z2sUBDZ6s3upHWoEXSW5RbJzOM+92g/IoFkL
   IZUpVT1AO6K/LpMTvrWXfSyIiXXfE7EViuRlM8hlIo5+SFkC7BITejx01
   Q==;
IronPort-SDR: ZNFPGpfC6kiY4zdv1QDQYsIajZVjSN0UtwuTA8ne0AbpXExyN2AJSiNccLWR7hkJfAJfLcyNNs
 JrZ0Vm4qlgcDUIefMT/hxYcgz3cocbbfdDkwdqF37eUkMsMFzLiJbEx9NjcGaRp56zV4N+aFkQ
 lXop3J7Qrqf5Xp4/4YSMZ2hZ1p1u/HF9GeRJ1kf7DVoRlS81Hce2wenFcY5h2rfwFz33ZgXaTR
 YNrH7SKcgwjr8FeK9tQcu0x20tuJVt3KEzBWIw/Z5V+2qdcDhwksFhIdH2itt+l43preObMlJ/
 e3s=
X-IronPort-AV: E=Sophos;i="5.82,290,1613404800"; 
   d="scan'208";a="271714010"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 11 May 2021 16:22:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ad65JucOTRkg6ZNoP30fkuphQoDAL5niq5lQD5LuAwQvDk6IawtxRn3c5XcN3Inoro/SQ9URixf6JMyzlGzMX3WWY/+mhRYxETnYwE2m1yHoAjepo8k5mfL4kkqnfth+Gk0byCMQ4IHa8xXSqRO6GTpRQN7v4bPvIlO9yxI0urrFxn/95dYJ3GQr82JELhfkE0x/IhNFFsPIKM67RwlH23uw3x4t9Y5dxlZk6Mw7ee5hnoyADwxWYvmoSjJHGtqRTXbCVZLlSgEhYOrb2sDVCFSm9PJgpSVovZE9zOicg3H7aIZjkiCOO++qn36CMxLnMdbxAzDXfegg4izyMrQmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEMMhCIkyjBeIx5lvFiqssn95qBy8IwJ1vtYySIFx80=;
 b=BaWurLru4x+YupbMzdmvMVDEwa+AdcP9808wfTdCPt85jlIw+T+QRk+fJTW7L1PNmyb7USGeIBDRoA0AMo+NUz8t7QO/s0VAGIlzNYhGmVc0BgRcR+KT4TwEBcA81MPPgDAHaAVg9inHJTa8/Tt08+EnHvQxq60oGJMp2YpT80rHD30tk0ReW8a6fix1Ntm2fyt1oDNL97jAV5gC1bXIT1ksDjrjaa/oW+rRYHgeKTP8Jaos7gdFlAd65+8Ye3s/RPylsCTNAgKFuPb50kXYZ5eOFXHo+yIoHNwTsKeXgTsKM2mzXnAD9ARd/c2gOYyxjBLSoNqm+b0RvcaHjVzFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEMMhCIkyjBeIx5lvFiqssn95qBy8IwJ1vtYySIFx80=;
 b=JRLreJU0UpxW/UxN2pu+GSN4g2qwZ+tZw8zQmmEJ1dLizPGmAP6qPMiDX8Le4fcrM/HzrxwxeUERbUyvwG/dxrKFzLsB5b38pS5KQW/1UYn1/flHUIAN7N4jvq3CBbo/F5xv6YPW/o3elqrsJqdPF0AYlVsxLr2g0ZJFOxvLLr4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB7132.namprd04.prod.outlook.com (2603:10b6:5:247::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.29; Tue, 11 May 2021 08:22:08 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 08:22:07 +0000
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
Subject: RE: [PATCH 2/2] mmc: core: Add support for cache ctrl for SD cards
Thread-Topic: [PATCH 2/2] mmc: core: Add support for cache ctrl for SD cards
Thread-Index: AQHXQohQmJ5aCkIH3kCczJUde/3xEqrcbNXwgABjSoCAASb7YA==
Date:   Tue, 11 May 2021 08:22:07 +0000
Message-ID: <DM6PR04MB657598D0CCDB34B7BA8AEB73FC539@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210506145829.198823-1-ulf.hansson@linaro.org>
 <20210506145829.198823-3-ulf.hansson@linaro.org>
 <DM6PR04MB6575E3D63982278D2F1CA022FC549@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFrvhNntCAWdyN5Kw8znq4RKE6yQS5G38XYY5iBhqMW0Pw@mail.gmail.com>
In-Reply-To: <CAPDyKFrvhNntCAWdyN5Kw8znq4RKE6yQS5G38XYY5iBhqMW0Pw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb81dc54-0c3d-4f2e-a994-08d91455de06
x-ms-traffictypediagnostic: DM6PR04MB7132:
x-microsoft-antispam-prvs: <DM6PR04MB71325FEC6DC4A04510BE52D3FC539@DM6PR04MB7132.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I1iD50+lh1kzs644MBuQgKt04wWIP3IVOYid3MUotbF8Z0VKsG0SzPylcYoNbA+WJle1hV8u2FaI4ZMMbu6SZUBO6kgyRW7mS8oGvrzvWrESyBoocDbD0ql7D3rniZpU3LYkWKW+znILLVdbO9RT4OYgUYgaU6RCblN/icbUzSKNpFh8F9VvpDzZo4dzUd7cHTY7voXyKTzf5Z7n8BCdLaJfnY8BpyPsSl9exq3ZU05zBC4h9fE3QGky7WKZ0erf66+8CaA0pDzObPnl9RR1A2UHsP4vzGp2y/BZobZ2FxBg6M+8C7igR/SFXpqAwv0tKaSXBmrmqIXac6gKXMuCmi/NKC4LWnQ3POSNPAPyJkSl5DZcNt/1w9rU8y7o9OBTwNjyfY1tBOFp/CvchYGCYj7QBZi5Psfi+XjODHBVlNM5wef4dUCbi4OMZh80trmPE8Unckee08H4cH4NnBlYlysPrbcRvDqlgCe54fivxYGlvsj8uohLoui4lg0V09kwyVyULjkNliuDNIYgI3mF8clk2hoyh4qn/iXNM2ItH1NgyIh95A/81PCoEHYLfIkJmscQlQvSSy6MEPZjMniIezEukT6wwYZ4IXopPfE+aI8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(8936002)(122000001)(4744005)(86362001)(83380400001)(52536014)(6916009)(71200400001)(8676002)(66556008)(55016002)(38100700002)(9686003)(26005)(4326008)(5660300002)(33656002)(186003)(66946007)(498600001)(7696005)(54906003)(76116006)(66476007)(6506007)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZEE1eUIwVURBSU84THRSKzBYTXhEUkdncEZodmlvRVVrVzArcFJ4SzZ3bU40?=
 =?utf-8?B?Rm9rTGxMdTA4bENOa3d1MUcvWTZiY1EyTmdQYitKYzZHYWhobE1zeVc0K0h1?=
 =?utf-8?B?VUJ5STI4dzNRL1FleHNnenEwVGhheUkrUWNQTmFNVUlMNkx3SWppb0ovOUNk?=
 =?utf-8?B?ZWNENkt2RTBTTDE1akd0UjVhSndvd0pRVnVjYzRtaFVXNUV3YWc5aVZWMTRz?=
 =?utf-8?B?TzYwblA4NWRNQmJiSEd4N1BybVhJWDFENFZleWZjS3N6RnIzSWEzblhNOEpa?=
 =?utf-8?B?eGU1TFJJTnBCVW9IeUpFWGpJU1hNa3J4bldkbGF3aHRIUTZFdXhBZDlZd0w5?=
 =?utf-8?B?TFpkVXFuL2tKNk41RVoyYU9tTlU2Skt4VUgyR0ppWEpsaWoxQ2RoeUFCQkth?=
 =?utf-8?B?K3hGRm5YMk9jNmdnbzhjVTdpUGUycmtYSHZtU2s5MGNab3U5SkZKdWZ3NUlK?=
 =?utf-8?B?bGdBZFRmaVhXK25vQmFWVTJqWkFCbGsrRGFmNTE1V1NXYVcwTUIrU3BGc3lp?=
 =?utf-8?B?VlVJSmxNRDF6RkN1dFhWamZzNExwMDU3YlhnNExXd29HMW83UTFkdlB6Skdz?=
 =?utf-8?B?RGVjN3FqN0hnc3Z5VUpQM2J5czhnb3ZsN1ZxUlZ0VHNmcldyUDUwc2ZsdGhM?=
 =?utf-8?B?SHR2WUdUUDJtdE1xdGdMVjV2WHBFNjAxcXJxYjRTK1RwamYyYmZHbXo5aTdQ?=
 =?utf-8?B?T2VkeG8vSkV2T2d4U2UzM1lrT2oveXg2cGg5M2VQc0hEeHNiVWNOWHBWc05t?=
 =?utf-8?B?NFczZDJvNkNSMDJaL2lMallCWURnVkIvRXBtQnNvWlZpdTVRMGhmejNyV3pj?=
 =?utf-8?B?VHVtSWNWdEZJc29FNWJ5d203YlRpeGZaL1kvUGN2aUM2MmlzbVl5cHlYQmdq?=
 =?utf-8?B?RFZCMS93a3NJZjJkKytyazAyMHpoZ0dQVVBKMm13c2Zhd0RqZXJCbDVMaXBS?=
 =?utf-8?B?TlM3T2VvOGVKc3FrL3o2NUU1d1RObVBYTjh1dFpaN2RtOERRdWk4UW9WR2h6?=
 =?utf-8?B?UFk0RE1xWEc0V2lkSERCcnhUdE1SR3YzNGY1M3VoY2JrWWxXV2JhdFNlbUpV?=
 =?utf-8?B?dGxLdVlHUTRlUGg3cmJHYUFxcmZGUVdXR1Z5V0EwbGRhOTlUYjlPa2ordHl3?=
 =?utf-8?B?SWN5TjlnVEdCbi82SFFCVlhlNHZsQXU4bnM4RDM0REpnRjBFSnc0eEJ0emZH?=
 =?utf-8?B?RDhvRnN4bGpxNzlTRm5jUnl3TTZkeXRRZTYrb0grZUE1UVBGV3dJNVNRYU9D?=
 =?utf-8?B?Z2JrUzBXdERYcmY2M25BWDdqUzFPZ3MwbnNGdEVncHk4dEFIR3MwQzFscEM5?=
 =?utf-8?B?VmljNmE4dWpSL3JZVlJDU2xubFMySEFrYmxTSTg3Z004MlNlUk5VZE92dlVl?=
 =?utf-8?B?KytmU1ZDTVVBaXl6UUIzQjFpUHB2cEQyT0pOWnkvdnhZOXNYZjNrT3dILzI4?=
 =?utf-8?B?UGhudm10djVsWS9WTnV4VlJOTVV4ZXZzcmUzYjdGVGlVMnhLMWRuTUJ3ZFJx?=
 =?utf-8?B?NGMrbW5kVUJKaG0rVzZBeDN3dzAycVZ1UURpTUFXUkZqM1pzZ09kVXFLdTNt?=
 =?utf-8?B?MTlURzlnQkN2YkVvK0JXSHhpYzA1MCtIV0dacWFRcGVVOXNubXJQejNmQ2U2?=
 =?utf-8?B?RWxJSkFIVm5CT1RQZXB3bzlFcXhkTGVyZFhlMFVpTEdPQ0VXWmxUQ21JT2I1?=
 =?utf-8?B?REtrZG9BQXhhdmtoK08vaWhPdW4yeU8rWUhoRUZ6bjZsMkZoL0U3cisyUGdT?=
 =?utf-8?Q?nBqzdpPkSgryiSYSv2UqvcddPx0fmDL9M+V2TIk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb81dc54-0c3d-4f2e-a994-08d91455de06
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 08:22:07.8041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7UbVWPgIilBNAPmZmiAJsbouW90B8r1SiteUfWkBKtLBzlKC9aTSPP344oSXrw/beeJJjUUq9ipKyPGPDT3MOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7132
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQo+ID4gSSB3b3VsZCBleHBlY3QgMiBtb3JlIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXM6DQo+ID4g
IC0gZmx1c2ggY2FjaGUgb24gcG93ZXIgZG93bg0KPiANCj4gQWNjb3JkaW5nIHRvIHRoZSBzcGVj
IHRoYXQgc2hvdWxkIG5vdCBiZSBuZWVkZWQsIGJlY2F1c2UgdGhhdCBzaG91bGQNCj4gYmUgbWFu
YWdlZCBpbnRlcm5hbGx5IGluIHRoZSBTRCBjYXJkIHdoZW4gd2Ugc2VuZCBhIHBvd2Vyb2ZmDQo+
IG5vdGlmaWNhdGlvbi4NCj4gDQo+IERpZCBJIGdldCB0aGF0IHdyb25nPyBEbyB5b3UgcHJlZmVy
IHRvIHNlbmQgYSBmbHVzaCBjYWNoZSBhcyB3ZWxsDQo+IGJlZm9yZSB0aGUgcG93ZXJvZmYgbm90
aWZpY2F0aW9uPw0KPiANCj4gPiAgLSBjYWNoZSBkaXNhYmxlbWVudCBldmVudHM/DQo+IA0KPiBU
aGlzIEkgZG9uJ3Qga25vdyBhYm91dC4gQ2FuIHlvdSBlbGFib3JhdGU/DQpBcyBmb3IgdGhlIGFi
b3ZlIDIgcXVlc3Rpb25zIC0gSSBhc2tlZCBpbnRlcm5hbGx5IC0gaXQgbWF5IHRha2UgYSB3aGls
ZSBmb3IgcGVvcGxlIHRvIGdldCBiYWNrIHRvIG1lLg0KTGV0J3MgbGVhdmUgaXQgZm9yIG5vdy4N
Cg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEF2cmkNCj4gDQo+
IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo=
