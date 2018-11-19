Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E67C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 19:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE28B20831
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 19:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ol8vLemY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YPVSNFlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE28B20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeKTFdr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:33:47 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25940 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeKTFdr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 00:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542654530; x=1574190530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jJbLXT6ExFWbSnDTs49E/FAY9g+lV0hlbk1mdDXjU64=;
  b=Ol8vLemYZdkTuOMIkHNPo66e6NOSX+Uc9PXnvbTR8f4ab114DCbnFzAg
   Q3vUjG3xXpcQl2uYgDjfFrzSZvn+vnBC80ovIFWVfYoQK5kJsB+iLHcXH
   HAoK0pD3wsbRUdb+/1YFAps6OpyUIWxl9Al32W+LE71IUuq14z8/09BkQ
   U+1WLxCxzL9ulR7CIza4Zax87VjuOZBWX4+z+XNXIilLgOevr3k6V0Are
   44C8PI4mrmNjf7h6GqlpHT1Gdy2+bibrP6BMyXQVCy9vO9onO5S149San
   060rYuRwZnBBazf/LztRFS9+HB7SynZeb2A5hU58x2yBrdydo04Qw0I0Q
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="96340616"
Received: from mail-sn1nam02lp0023.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([216.32.180.23])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 03:08:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJbLXT6ExFWbSnDTs49E/FAY9g+lV0hlbk1mdDXjU64=;
 b=YPVSNFlEsdMekLmeVKkg0th5LitxlH7aalch0DnClI5ZcFXaF7R6iN34EfEsU/RGwYMkjHxnr0hKOt6PLetGZTksZDq00Wo5b+xfbLIhHCxcjYpjbIgTLRcOw8xXDvEdW5aRD3MZYpW7cyj9oAZ3Kd+Vd0IrDvUXoqYpK8th1O4=
Received: from BYAPR04MB4357.namprd04.prod.outlook.com (20.176.251.147) by
 BYAPR04MB4360.namprd04.prod.outlook.com (20.176.251.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Mon, 19 Nov 2018 19:08:47 +0000
Received: from BYAPR04MB4357.namprd04.prod.outlook.com
 ([fe80::6dba:5dd:bbae:474b]) by BYAPR04MB4357.namprd04.prod.outlook.com
 ([fe80::6dba:5dd:bbae:474b%3]) with mapi id 15.20.1294.048; Mon, 19 Nov 2018
 19:08:47 +0000
From:   Adam Manzanares <Adam.Manzanares@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5/7] aio: Fix fallback I/O priority value
Thread-Topic: [PATCH 5/7] aio: Fix fallback I/O priority value
Thread-Index: AQHUf7s0kO9t2g9EzUSSPAMikODcwaVXdx+A
Date:   Mon, 19 Nov 2018 19:08:47 +0000
Message-ID: <e75935b758935f500c31e92ddf8adf602ea4e5bd.camel@wdc.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
         <20181119035131.11255-6-damien.lemoal@wdc.com>
In-Reply-To: <20181119035131.11255-6-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4360;6:Qc2d/n8jiA3HNOFQimtVj3kPOCNj2mUcLKAwB43tqEJ4CEvcgpG1Jw5YNWvChByD7ob+MiMqsgojRsuNpb5qEn1fTfEjk7ea6NlxhuswLDwsfJU4Zg2rW7+KC2WzpnwhnjFrpzJ69fbyp7r4akiKcvE1KkAWwiZQuQjP/Mwwwylhdc/Zvz/b2bLghi1C7WyHEiugdhGLvKlZ1pbR1vRVKI3aTG49SkU+hYTWQjQAmrBc74dzNC42JovhfNZJr+b29vKHFx/g/oA1hOeoDRW8ZnGgHJQnVvSlvCO2/0godBZhL8oeK4MEzW+fuWSpQ1HFRFotBpXJh3+I+yhIOmd3KjpsqPxkU5t/HWyHHs3qU0gh+/iMytjNmF/MHz31rgjwRyDrXBuWqSWEWqeITd3FBxp+5iwpPbDzXElvPwCpGAR7c6LFPcvA6Y8FViUtOEBE8pnJUkZHV4BPd3vJsy45Yg==;5:tYir1I0sNMnXzfOKa9UmbGvbJeP5HuX0/ezslj1ygMs0dXZGqGo8RUAl3oWJc6+EVi+SoAZrsg+rKLbdy8yEtrCTPC7qRz/c1skqII85g64w8bRwXNL9dAs5V/qKfdRfwOhAItcZDGaVQYM1a/qUKcT03wgA8WT8mrsiVRTkv9Y=;7:mXERejJ3B35pn5RC34SmXPT+OQ4a3kkeCl2gar8TGm/UZ/kWwtMLBl6oZUx1zod/fCzN1R0a8TFZ+OjnFb1EMqjMcJ5qPuwNr2S3VMEZelGBpEEYe613JHKLc3GnHIhJMFnsYkrjjKtP9+DuodsUEw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: a850c9b8-7295-4761-4887-08d64e526f00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4360;
x-ms-traffictypediagnostic: BYAPR04MB4360:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB43604EB803CA881962E53E84F0D80@BYAPR04MB4360.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR04MB4360;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB4360;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(305945005)(102836004)(26005)(99286004)(6506007)(316002)(6436002)(6486002)(76176011)(2501003)(7736002)(72206003)(2906002)(478600001)(5660300001)(6246003)(105586002)(106356001)(6116002)(3846002)(25786009)(4326008)(2900100001)(8936002)(36756003)(81156014)(81166006)(186003)(8676002)(118296001)(14454004)(53936002)(6512007)(66066001)(97736004)(54906003)(486006)(4001150100001)(256004)(14444005)(68736007)(71190400001)(71200400001)(2616005)(11346002)(229853002)(476003)(446003)(86362001)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4360;H:BYAPR04MB4357.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SMDHxkHbSypRkAuIUPOEAK46gVxMblJ7fnr6+teKnZAEHVLS5AEAktll9fONB8c4nkBPY3ecbVLkXje/4qRkUiENreG5Ff9kIWCh4Y0RPsXSiZ1BLUyNP44mLr2qg/Dt7SEAaYqIhQkBzBuaJVR5xqtxz4CmSYp2BA83Em/RR20LNZ3EbdyI8gs5/KmyaASiMhs8EPvw20WZKenkwtjwNvxLC42MqIM5BS5Tr2PA7enT6ci1IOKQIfRgjp+MM022jNdvGw8CgaLh0gIfUg4eXMF526iq8cdR8xR1IXN+UVAQhRvmdM1CrkorMe5O+dcD4aVbV/Unq/+hhfDqeQ82rm2W1D4pGOw7WWduQJfeXdc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6270FEFDA59A3846AFFB4FA439853779@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a850c9b8-7295-4761-4887-08d64e526f00
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 19:08:47.5627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4360
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTE5IGF0IDEyOjUxICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToN
Cj4gRm9yIGNhc2VzIHdoZW4gdGhlIGFwcGxpY2F0aW9uIGRvZXMgbm90IHNwZWNpZnkgYWlvX3Jl
cXByaW8gZm9yIGFuDQo+IGFpbywNCj4gZmFsbGJhY2sgdG8gdXNlIGdldF9jdXJyZW50X2lvcHJp
bygpIHRvIG9idGFpbiB0aGUgdGFzayBJL08gcHJpb3JpdHkNCj4gbGFzdCBzZXQgdXNpbmcgaW9w
cmlvX3NldCgpIHJhdGhlciB0aGFuIHRoZSBoYXJkY29kZWQNCj4gSU9QUklPX0NMQVNTX05PTkUN
Cj4gdmFsdWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxl
bW9hbEB3ZGMuY29tPg0KDQpMb29rcyBnb29kLA0KDQpSZXZpZXdlZC1ieTogQWRhbSBNYW56YW5h
cmVzIDxhZGFtLm1hbnphbmFyZXNAd2RjLmNvbT4NCg0KPiAtLS0NCj4gIGZzL2Fpby5jIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZnMvYWlvLmMgYi9mcy9haW8uYw0KPiBpbmRleCAzMDFlNjMxNDE4M2Iu
LmI5ODQ5MThiZTRiNyAxMDA2NDQNCj4gLS0tIGEvZnMvYWlvLmMNCj4gKysrIGIvZnMvYWlvLmMN
Cj4gQEAgLTE0NDEsNyArMTQ0MSw3IEBAIHN0YXRpYyBpbnQgYWlvX3ByZXBfcncoc3RydWN0IGtp
b2NiICpyZXEsDQo+IHN0cnVjdCBpb2NiICppb2NiKQ0KPiAgDQo+ICAJCXJlcS0+a2lfaW9wcmlv
ID0gaW9jYi0+YWlvX3JlcXByaW87DQo+ICAJfSBlbHNlDQo+IC0JCXJlcS0+a2lfaW9wcmlvID0g
SU9QUklPX1BSSU9fVkFMVUUoSU9QUklPX0NMQVNTX05PTkUsDQo+IDApOw0KPiArCQlyZXEtPmtp
X2lvcHJpbyA9IGdldF9jdXJyZW50X2lvcHJpbygpOw0KPiAgDQo+ICAJcmV0ID0ga2lvY2Jfc2V0
X3J3X2ZsYWdzKHJlcSwgaW9jYi0+YWlvX3J3X2ZsYWdzKTsNCj4gIAlpZiAodW5saWtlbHkocmV0
KSkNCg==
