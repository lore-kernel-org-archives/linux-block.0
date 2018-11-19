Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBCAC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 18:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E043D206BA
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 18:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SFTEtq1A";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eFpBxBp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E043D206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbeKTEmd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:42:33 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58006 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbeKTEmd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 23:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542651473; x=1574187473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/ug4+/z6MGGPbZzadRqbM/BYdHA33BN8DodkUP2hnuY=;
  b=SFTEtq1AW6IorqPEl2kZgh/Bsgiz+03Q7su1RkvTCVTvzI/2FndH0Lzp
   erVf6P6w363G2FAAWmudgmFKbfI8+m6kZzGvgL9gEq41APemV4vS3fSfh
   7FneF7myYK5XN7Td9NkC/uisJJGjC+4L3SPzLIxUFk6clKOxOffSKRQBm
   C++Dz1w0LPB19wlzacBl8AIArNArMTUUGtwO9CMHnSdsUVBmJls9HnnEC
   hfvXDEtg8gqds0BnnhFiTjjaH5/zxArlqIlE+2ik0MIoMnO6K6NzAHj4C
   zbk+DsCxxXLWwjhpi04aq0JS777J3q1OSOk47COcQk4UmTuLq3b3+POol
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="99426599"
Received: from mail-bn3nam04lp0114.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([216.32.180.114])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 02:17:52 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ug4+/z6MGGPbZzadRqbM/BYdHA33BN8DodkUP2hnuY=;
 b=eFpBxBp442BPocog9jQ112nUKMXEGeY6RGANJiT4e27HB5B7wbLndHI0XQklRr690kQq1CN+pgwwTppxLSTGf5hXj5Dft010c572n9OwMKQqc96yjuEO2yG7KM2OJrmlGFdZUaRtWuYyUWiml3w0mZQb0eCuIElIJF1/ybJAoLo=
Received: from BYAPR04MB4357.namprd04.prod.outlook.com (20.176.251.147) by
 BYAPR04MB4488.namprd04.prod.outlook.com (52.135.237.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Mon, 19 Nov 2018 18:17:51 +0000
Received: from BYAPR04MB4357.namprd04.prod.outlook.com
 ([fe80::6dba:5dd:bbae:474b]) by BYAPR04MB4357.namprd04.prod.outlook.com
 ([fe80::6dba:5dd:bbae:474b%3]) with mapi id 15.20.1294.048; Mon, 19 Nov 2018
 18:17:51 +0000
From:   Adam Manzanares <Adam.Manzanares@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/7] block: Introduce get_current_ioprio()
Thread-Topic: [PATCH 4/7] block: Introduce get_current_ioprio()
Thread-Index: AQHUf7sxxqnJndASLUikf5SZtrSeT6VXaOSA
Date:   Mon, 19 Nov 2018 18:17:51 +0000
Message-ID: <bd285dac47cfe5bdc7b5182763e86fdd0bda543f.camel@wdc.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
         <20181119035131.11255-5-damien.lemoal@wdc.com>
In-Reply-To: <20181119035131.11255-5-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com; 
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4488;6:qiHId2dUl8jxqHKx7M8yubY27mGpH2CO7lgYqPken5sMaAURXvJg/gKmYki412FkPlF5tI1XIzNKhF45qssDKBMEDwpBzkOXmqRLcQ3fK/ANMr5odEuinaM8AO6pnbOLISnqX1EvCavvL/bsfmN+SXqCsJ8JgAGtYH/ban6mNUDNCGEXaFzBnlAgf3Dc/o4TFvO4LD4VCm2EVmGv5FUpAGhv0ig9jyNCpGKxKzgwxJZJ5lYoD76BeCMguf2aveaG15Ocm24SR6WSRlH0NQUQSCDwWya8w4OjTSMzh5zceXVf07is+19/Nbup42ixDSVVdCCHBocwz13ypRIB1GPdU8ndm54+yPHXVXdsMPcMZUOjCmRvzy27Ta2myciMLqqhK4S2B/QwrDXUvLRatprYEb/WdbMzdjnD54wXZwSN6a7KrhPtYWOCZRMWZpj4s516uyAzVNTqQ4xSu8ojXGPC8g==;5:EkkJsT2cksEv4w3c7Jm90Nl9VYbOTfzgO4tvmOxY2U9Thq3CF+kcJE9jj+DS/4pdR3oto4XnjmEzKs7vh5SS8K6DnYaWi7KqBiulfr2J10OCVfpGhd7DC7O7zKEyNWE+8avhnqNpC+YghEMtiUUm0bH2eqruKKWDSDEgp2ohjSA=;7:PgHFPhtHAornu279L9O/MHkyVxTFGUmI84nEVCWQgB0StmYFDYRWPs8vJQ3ePa/IHqzX4LlnSzQXRFY1nMZe8ho3v2LBwGm9pN/0/zI+v5Qig6rLd9F/W2RYg96LCBHUQc4wPlJgp9HeINI6sJSzqg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 28b6efef-367b-427b-648a-08d64e4b5155
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4488;
x-ms-traffictypediagnostic: BYAPR04MB4488:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4488596CCE10AB99A9E6CB6DF0D80@BYAPR04MB4488.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR04MB4488;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB4488;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(366004)(396003)(199004)(189003)(4001150100001)(118296001)(25786009)(26005)(106356001)(102836004)(186003)(6436002)(6506007)(71190400001)(305945005)(72206003)(256004)(7736002)(8676002)(476003)(446003)(5660300001)(11346002)(81156014)(3846002)(6116002)(2616005)(8936002)(81166006)(71200400001)(36756003)(2900100001)(486006)(66066001)(478600001)(14444005)(6246003)(97736004)(14454004)(2906002)(229853002)(6486002)(316002)(68736007)(53936002)(4326008)(99286004)(6512007)(76176011)(54906003)(105586002)(86362001)(2501003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4488;H:BYAPR04MB4357.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: EoTNP28pUY47vhurgH2zPjxxQQFKRMcmchVYHlOB7ksCoyxYVd2ytMzRUf8S2SyHyodF41776MWULZY4pl2+iYkt8jgpeQEbKTYG/yVxnF2bTw47p/kucMY29r+jVKblwRpndm7PPcPdOAgSnnWdCbprcyo+gdV+LdWnVClF3Cbt/53pxyZZ+ffYMT/e/GFUgyEFt4I8yPqHq6jLGhKZXcQ9Qa61m53Wbc+AuL6jiblCVae9YDzJcbqaWpu4mH5Hh0GShmsVJkQ3p/IALNlj2nBrcPpzpuG0FSlFaRzOPGwgQ6dx5YhJSSjD4pdJPo8W2DvfxowXNnuB5RFp9hOEgiM+C1pXRnEImTYtFgJIvBE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4053A5D6FB8404409D9E8869A013C4D1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b6efef-367b-427b-648a-08d64e4b5155
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 18:17:51.3228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4488
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTE5IGF0IDEyOjUxICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToN
Cj4gRGVmaW5lIGdldF9jdXJyZW50X2lvcHJpbygpIGFzIGFuIGlubGluZSBoZWxwZXIgdG8gb2J0
YWluIHRoZSBjYWxsZXINCj4gSS9PIHByaW9yaXR5IGZyb20gaXRzIHRhc2sgSS9PIGNvbnRleHQu
IFVzZSB0aGlzIGhlbHBlciBpbg0KPiBibGtfaW5pdF9yZXF1ZXN0X2Zyb21fYmlvKCkgdG8gc2V0
IGEgcmVxdWVzdCBpb3ByaW8uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbCA8
ZGFtaWVuLmxlbW9hbEB3ZGMuY29tPg0KPiAtLS0NCj4gIGJsb2NrL2Jsay1jb3JlLmMgICAgICAg
fCAgNiArLS0tLS0NCj4gIGluY2x1ZGUvbGludXgvaW9wcmlvLmggfCAxMyArKysrKysrKysrKysr
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLWNvcmUuYyBiL2Jsb2NrL2Jsay1jb3JlLmMNCj4g
aW5kZXggNDkyNjQ4Yzk2OTkyLi40NDUwZDNjMDhmMjUgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2Js
ay1jb3JlLmMNCj4gKysrIGIvYmxvY2svYmxrLWNvcmUuYw0KPiBAQCAtODEzLDE4ICs4MTMsMTQg
QEAgdW5zaWduZWQgaW50IGJsa19wbHVnX3F1ZXVlZF9jb3VudChzdHJ1Y3QNCj4gcmVxdWVzdF9x
dWV1ZSAqcSkNCj4gIA0KPiAgdm9pZCBibGtfaW5pdF9yZXF1ZXN0X2Zyb21fYmlvKHN0cnVjdCBy
ZXF1ZXN0ICpyZXEsIHN0cnVjdCBiaW8gKmJpbykNCj4gIHsNCj4gLQlzdHJ1Y3QgaW9fY29udGV4
dCAqaW9jID0gY3VycmVudC0+aW9fY29udGV4dDsNCj4gLQ0KPiAgCWlmIChiaW8tPmJpX29wZiAm
IFJFUV9SQUhFQUQpDQo+ICAJCXJlcS0+Y21kX2ZsYWdzIHw9IFJFUV9GQUlMRkFTVF9NQVNLOw0K
PiAgDQo+ICAJcmVxLT5fX3NlY3RvciA9IGJpby0+YmlfaXRlci5iaV9zZWN0b3I7DQo+ICAJaWYg
KGlvcHJpb192YWxpZChiaW9fcHJpbyhiaW8pKSkNCj4gIAkJcmVxLT5pb3ByaW8gPSBiaW9fcHJp
byhiaW8pOw0KPiAtCWVsc2UgaWYgKGlvYykNCj4gLQkJcmVxLT5pb3ByaW8gPSBpb2MtPmlvcHJp
bzsNCj4gIAllbHNlDQo+IC0JCXJlcS0+aW9wcmlvID0gSU9QUklPX1BSSU9fVkFMVUUoSU9QUklP
X0NMQVNTX05PTkUsIDApOw0KPiArCQlyZXEtPmlvcHJpbyA9IGdldF9jdXJyZW50X2lvcHJpbygp
Ow0KPiAgCXJlcS0+d3JpdGVfaGludCA9IGJpby0+Ymlfd3JpdGVfaGludDsNCj4gIAlibGtfcnFf
YmlvX3ByZXAocmVxLT5xLCByZXEsIGJpbyk7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2lvcHJpby5oIGIvaW5jbHVkZS9saW51eC9pb3ByaW8uaA0KPiBpbmRleCA5ZTMwZWQ2
NDQzZGIuLmU5YmZlNjk3MmFlZCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9pb3ByaW8u
aA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2lvcHJpby5oDQo+IEBAIC03MCw2ICs3MCwxOSBAQCBz
dGF0aWMgaW5saW5lIGludCB0YXNrX25pY2VfaW9jbGFzcyhzdHJ1Y3QNCj4gdGFza19zdHJ1Y3Qg
KnRhc2spDQo+ICAJCXJldHVybiBJT1BSSU9fQ0xBU1NfQkU7DQo+ICB9DQo+ICANCj4gKy8qDQo+
ICsgKiBJZiB0aGUgY2FsbGluZyBwcm9jZXNzIGhhcyBzZXQgYW4gSS9PIHByaW9yaXR5LCB1c2Ug
dGhhdC4NCj4gT3RoZXJ3aXNlLCByZXR1cm4NCj4gKyAqIHRoZSBkZWZhdWx0IEkvTyBwcmlvcml0
eS4NCj4gKyAqLw0KPiArc3RhdGljIGlubGluZSBpbnQgZ2V0X2N1cnJlbnRfaW9wcmlvKHZvaWQp
DQo+ICt7DQo+ICsJc3RydWN0IGlvX2NvbnRleHQgKmlvYyA9IGN1cnJlbnQtPmlvX2NvbnRleHQ7
DQo+ICsNCj4gKwlpZiAoaW9jKQ0KPiArCQlyZXR1cm4gaW9jLT5pb3ByaW87DQo+ICsJcmV0dXJu
IElPUFJJT19QUklPX1ZBTFVFKElPUFJJT19DTEFTU19OT05FLCAwKTsNCg0KU2hvdWxkbid0IHRo
aXMgYmUgSU9QUklPX1BSSU9fVkFMVUUoSU9QUklPX0NMQVNTX0JFLCBJT1BSSU9fTk9STSkgdG8g
YmUNCmNvbnNpc3RlbnQgd2l0aCBwYXRjaCAzPw0KDQoNCj4gK30NCj4gKw0KPiAgLyoNCj4gICAq
IEZvciBpbmhlcml0YW5jZSwgcmV0dXJuIHRoZSBoaWdoZXN0IG9mIHRoZSB0d28gZ2l2ZW4gcHJp
b3JpdGllcw0KPiAgICovDQo=
