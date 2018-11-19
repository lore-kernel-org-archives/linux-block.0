Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD91C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 19:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1E72089F
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 19:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OK+tsUYA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ji69Mqm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1E72089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbeKTFcR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:32:17 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13735 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeKTFcR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 00:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542654441; x=1574190441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q8qyuM22V+zizEA/gJLbupocgpQednHc3+HURfPmEMA=;
  b=OK+tsUYAZ9dnI2nsa7DVXtJJ90KagCTszt4RxLS0QESaDM1stJcr34dd
   HsX4+N5rdbpuhokzUrKwmQVmSM/zY1k7AWyP5ukweoKpkOQClsdMl8TR+
   eNZWoTebMEod22LbPw35mdRVvl0z1sCCPxpynFQTaQkH/2IYqUgm7xPTI
   sYLVh+R2mLCECx6HBlHTqqAExClkhSKW5BBqfoVkJgaTBF8VRxv1xQllQ
   k6MyNEVAfu0734CpJcLhvIvFRWi9GHtLAl18HfeDXLoXLMibsCurIqSFk
   lSuoo2jMeMnAheBvnnc7rAid2GCxfSm8HFzWJXN/cbUquQyzEBci5Pk1q
   w==;
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="94625539"
Received: from mail-by2nam05lp0244.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([216.32.181.244])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 03:07:20 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8qyuM22V+zizEA/gJLbupocgpQednHc3+HURfPmEMA=;
 b=Ji69Mqm6PEIe8zkt22KjwoiANWgFjOxvMGZYxa3K2+l/IVaJhOGsDipwmCqcAgtuOBD5mb0NxoQHodgzAeIfyOrwD/XXCm/KQHOVS0b6y0G6FnysbxoFS9Um47lKr34pQZFXOwPkIPkK9E2+0AviU2gM13G6c/ZcNt7KsGPWtHU=
Received: from BYAPR04MB4357.namprd04.prod.outlook.com (20.176.251.147) by
 BYAPR04MB4360.namprd04.prod.outlook.com (20.176.251.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Mon, 19 Nov 2018 19:07:18 +0000
Received: from BYAPR04MB4357.namprd04.prod.outlook.com
 ([fe80::6dba:5dd:bbae:474b]) by BYAPR04MB4357.namprd04.prod.outlook.com
 ([fe80::6dba:5dd:bbae:474b%3]) with mapi id 15.20.1294.048; Mon, 19 Nov 2018
 19:07:18 +0000
From:   Adam Manzanares <Adam.Manzanares@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/7] block: Remove bio->bi_ioc
Thread-Topic: [PATCH 2/7] block: Remove bio->bi_ioc
Thread-Index: AQHUf7svA7wauaKyfEOgoHNsqLuuDqVXdrUA
Date:   Mon, 19 Nov 2018 19:07:18 +0000
Message-ID: <cd28e72b1a597f1915948e280fe3e2468e44f524.camel@wdc.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
         <20181119035131.11255-3-damien.lemoal@wdc.com>
In-Reply-To: <20181119035131.11255-3-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4360;6:8dUArOAaqUjF7k3IrV9LOFFJzCVKbN4mdauA0Sqd+PDFXQnUA6Mr37UIgXZnqpRos9hWhAcRz57DkxMqyedpVFC5fVPzx/u3cST4nFKbD/U8lMGNrr4Y94kVCTvSeKhnLmztzP3esqvq4FmVCD4I/86ZLCh14ZUi5joiThwq0sUJzzSLfCuw6fTlinHDW/iJyL+MOMox5ESwhT0vANwG331KovP/n622IZ/edULjqSFR8du4n75zcs1RshAE7VHRb6p3O40zQeOumZgE5TsYR8KIGwRxMx6kziwY3E5O7lIHZufFu0RHrWinT/EfI2xqVfNpvgToUrQYbJ+arXtOgwGSZNYviHKzCjdr2M5Hck10pH9buIqFQNExwgW4N+nX8RK2IZh1ga/myqxwCnfPHmAmCwueVJEisTrQWeXcgCotvoGcxcvisO2Xl9Rm5tBgsC0gOGbqG/OMfikmlwGi4w==;5:vm9JXKNEoeOKAVE5cHVUQ89QmlT6jo2VUgsQUCF0IqM87RbggAqkI2J4c3LzoIglCNwv1YD63vuh9UDdauM16kktpNs6qk1PTjNX1exxBl8FwDww+vcSaFDWqbeO08JERkNnhu9tlfZpRU6BX3RVvqjRmjM2F0G1yh0dg/XRV4g=;7:+jbPKJQOuZ1+EI4RKapQmDgYmheARnnZEhbGxLUb73pCvnNa3II8jjnEXHVbJfZ0nPZcWrRADx6U9GPhcfLRhyQlZaYWQEoriSxh//CSaAg1blJTudJClVauVG7dzDSXBfDjGcI7KXqim5Ge3EGesQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: a129be83-208b-470d-b7c3-08d64e5239bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4360;
x-ms-traffictypediagnostic: BYAPR04MB4360:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4360E4FA0A4461156A29C468F0D80@BYAPR04MB4360.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR04MB4360;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB4360;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(305945005)(102836004)(26005)(99286004)(6506007)(316002)(6436002)(6486002)(76176011)(2501003)(7736002)(72206003)(2906002)(478600001)(5660300001)(6246003)(105586002)(106356001)(6116002)(3846002)(25786009)(4326008)(2900100001)(8936002)(36756003)(81156014)(81166006)(186003)(8676002)(118296001)(14454004)(53936002)(6512007)(66066001)(97736004)(54906003)(486006)(4001150100001)(256004)(14444005)(68736007)(71190400001)(71200400001)(575784001)(2616005)(11346002)(229853002)(476003)(446003)(86362001)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4360;H:BYAPR04MB4357.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: EYVj9dK7E3U2VhPibC8flpmdPAjbQoTTYUoNU9xkysZHlpgtz5xUNj/ifmwNrWIvL5P9NK0YClTl3w0I/hJnPB6v5Eqi6jZHBzDVIQ9nJf2s8VF1nnTVR1hFZY2SA5tBVEYoGFVWbps8Xxx8U6dI/sGdunJbSosESO2vEsEAIZL1ElT4/8GK+ylsSWYWIS+9l8YJqi9egTkfJ8K5rwiwhBrNxd9iw8ozKzl4CEflsKFYF335fDUCTxPlx2mFJveaortVxyt95RGBbms+BjQ0sDbEDRBhHZ++MGtdXBcTaKuU9qRbsjF/nag0t3vEeg0NAAVFWJocrPTk2a1tXtrbaLWzpmnv4WkMDDC8ehK36aM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DB79301D175F649B96D503E6F841424@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a129be83-208b-470d-b7c3-08d64e5239bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 19:07:18.1643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4360
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTE5IGF0IDEyOjUxICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToN
Cj4gYmlvLT5iaV9pb2MgaXMgbmV2ZXIgc2V0IHNvIGFsd2F5cyBOVUxMLiBSZW1vdmUgcmVmZXJl
bmNlcyB0byBpdCBpbg0KPiBiaW9fZGlzYXNzb2NpYXRlX3Rhc2soKSBhbmQgaW4gcnFfaW9jKCkg
YW5kIGRlbGV0ZSB0aGlzIGZpZWxkIGZyb20NCj4gc3RydWN0IGJpby4gV2l0aCB0aGlzIGNoYW5n
ZSwgcnFfaW9jKCkgYWx3YXlzIHJldHVybnMNCj4gY3VycmVudC0+aW9fY29udGV4dCB3aXRob3V0
IHRoZSBuZWVkIGZvciBhIGJpbyBhcmd1bWVudC4gRnVydGhlcg0KPiBzaW1wbGlmeSB0aGUgY29k
ZSBhbmQgbWFrZSBpdCBtb3JlIHJlYWRhYmxlIGJ5IGFsc28gcmVtb3ZpbmcgdGhpcw0KPiBoZWxw
ZXIsIHdoaWNoIGFsc28gYWxsb3dzIHRvIHNpbXBsaWZ5IGJsa19tcV9zY2hlZF9hc3NpZ25faW9j
KCkgYnkNCj4gcmVtb3ZpbmcgaXRzIGJpbyBhcmd1bWVudC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQHdkYy5jb20+DQoNCkxvb2tzIGdvb2QsDQoN
ClJldmlld2VkLWJ5OiBBZGFtIE1hbnphbmFyZXMgPGFkYW0ubWFuemFuYXJlc0B3ZGMuY29tPg0K
DQoNClJldmlld2VkIGJ5OiANCj4gLS0tDQo+ICBibG9jay9iaW8uYyAgICAgICAgICAgICAgIHwg
IDQgLS0tLQ0KPiAgYmxvY2svYmxrLWNvcmUuYyAgICAgICAgICB8ICAyICstDQo+ICBibG9jay9i
bGstbXEtc2NoZWQuYyAgICAgIHwgIDQgKystLQ0KPiAgYmxvY2svYmxrLW1xLXNjaGVkLmggICAg
ICB8ICAyICstDQo+ICBibG9jay9ibGstbXEuYyAgICAgICAgICAgIHwgIDQgKystLQ0KPiAgYmxv
Y2svYmxrLmggICAgICAgICAgICAgICB8IDE2IC0tLS0tLS0tLS0tLS0tLS0NCj4gIGluY2x1ZGUv
bGludXgvYmxrX3R5cGVzLmggfCAgMyArLS0NCj4gIDcgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCAyOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9iaW8uYyBi
L2Jsb2NrL2Jpby5jDQo+IGluZGV4IDRmNGQ5ODg0NDQzYi4uMDM4OTVjYzBkNzRhIDEwMDY0NA0K
PiAtLS0gYS9ibG9jay9iaW8uYw0KPiArKysgYi9ibG9jay9iaW8uYw0KPiBAQCAtMjAyNywxMCAr
MjAyNyw2IEBAIGludCBiaW9fYXNzb2NpYXRlX2Jsa2coc3RydWN0IGJpbyAqYmlvLCBzdHJ1Y3QN
Cj4gYmxrY2dfZ3EgKmJsa2cpDQo+ICAgKi8NCj4gIHZvaWQgYmlvX2Rpc2Fzc29jaWF0ZV90YXNr
KHN0cnVjdCBiaW8gKmJpbykNCj4gIHsNCj4gLQlpZiAoYmlvLT5iaV9pb2MpIHsNCj4gLQkJcHV0
X2lvX2NvbnRleHQoYmlvLT5iaV9pb2MpOw0KPiAtCQliaW8tPmJpX2lvYyA9IE5VTEw7DQo+IC0J
fQ0KPiAgCWlmIChiaW8tPmJpX2Nzcykgew0KPiAgCQljc3NfcHV0KGJpby0+YmlfY3NzKTsNCj4g
IAkJYmlvLT5iaV9jc3MgPSBOVUxMOw0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLWNvcmUuYyBi
L2Jsb2NrL2Jsay1jb3JlLmMNCj4gaW5kZXggZDZlOGFiOWNhOTlkLi40OTI2NDhjOTY5OTIgMTAw
NjQ0DQo+IC0tLSBhL2Jsb2NrL2Jsay1jb3JlLmMNCj4gKysrIGIvYmxvY2svYmxrLWNvcmUuYw0K
PiBAQCAtODEzLDcgKzgxMyw3IEBAIHVuc2lnbmVkIGludCBibGtfcGx1Z19xdWV1ZWRfY291bnQo
c3RydWN0DQo+IHJlcXVlc3RfcXVldWUgKnEpDQo+ICANCj4gIHZvaWQgYmxrX2luaXRfcmVxdWVz
dF9mcm9tX2JpbyhzdHJ1Y3QgcmVxdWVzdCAqcmVxLCBzdHJ1Y3QgYmlvICpiaW8pDQo+ICB7DQo+
IC0Jc3RydWN0IGlvX2NvbnRleHQgKmlvYyA9IHJxX2lvYyhiaW8pOw0KPiArCXN0cnVjdCBpb19j
b250ZXh0ICppb2MgPSBjdXJyZW50LT5pb19jb250ZXh0Ow0KPiAgDQo+ICAJaWYgKGJpby0+Ymlf
b3BmICYgUkVRX1JBSEVBRCkNCj4gIAkJcmVxLT5jbWRfZmxhZ3MgfD0gUkVRX0ZBSUxGQVNUX01B
U0s7DQo+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstbXEtc2NoZWQuYyBiL2Jsb2NrL2Jsay1tcS1z
Y2hlZC5jDQo+IGluZGV4IGQwODRmNzMxZDEwNC4uMTNiOGRjMzMyNTQxIDEwMDY0NA0KPiAtLS0g
YS9ibG9jay9ibGstbXEtc2NoZWQuYw0KPiArKysgYi9ibG9jay9ibGstbXEtc2NoZWQuYw0KPiBA
QCAtMzEsMTAgKzMxLDEwIEBAIHZvaWQgYmxrX21xX3NjaGVkX2ZyZWVfaGN0eF9kYXRhKHN0cnVj
dA0KPiByZXF1ZXN0X3F1ZXVlICpxLA0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTF9HUEwoYmxrX21x
X3NjaGVkX2ZyZWVfaGN0eF9kYXRhKTsNCj4gIA0KPiAtdm9pZCBibGtfbXFfc2NoZWRfYXNzaWdu
X2lvYyhzdHJ1Y3QgcmVxdWVzdCAqcnEsIHN0cnVjdCBiaW8gKmJpbykNCj4gK3ZvaWQgYmxrX21x
X3NjaGVkX2Fzc2lnbl9pb2Moc3RydWN0IHJlcXVlc3QgKnJxKQ0KPiAgew0KPiAgCXN0cnVjdCBy
ZXF1ZXN0X3F1ZXVlICpxID0gcnEtPnE7DQo+IC0Jc3RydWN0IGlvX2NvbnRleHQgKmlvYyA9IHJx
X2lvYyhiaW8pOw0KPiArCXN0cnVjdCBpb19jb250ZXh0ICppb2MgPSBjdXJyZW50LT5pb19jb250
ZXh0Ow0KPiAgCXN0cnVjdCBpb19jcSAqaWNxOw0KPiAgDQo+ICAJc3Bpbl9sb2NrX2lycSgmcS0+
cXVldWVfbG9jayk7DQo+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstbXEtc2NoZWQuaCBiL2Jsb2Nr
L2Jsay1tcS1zY2hlZC5oDQo+IGluZGV4IDdmZjU2NzFiZjEyOC4uMGY3MTljODUzMmFlIDEwMDY0
NA0KPiAtLS0gYS9ibG9jay9ibGstbXEtc2NoZWQuaA0KPiArKysgYi9ibG9jay9ibGstbXEtc2No
ZWQuaA0KPiBAQCAtOCw3ICs4LDcgQEANCj4gIHZvaWQgYmxrX21xX3NjaGVkX2ZyZWVfaGN0eF9k
YXRhKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLA0KPiAgCQkJCSB2b2lkICgqZXhpdCkoc3RydWN0
IGJsa19tcV9od19jdHggKikpOw0KPiAgDQo+IC12b2lkIGJsa19tcV9zY2hlZF9hc3NpZ25faW9j
KHN0cnVjdCByZXF1ZXN0ICpycSwgc3RydWN0IGJpbyAqYmlvKTsNCj4gK3ZvaWQgYmxrX21xX3Nj
aGVkX2Fzc2lnbl9pb2Moc3RydWN0IHJlcXVlc3QgKnJxKTsNCj4gIA0KPiAgdm9pZCBibGtfbXFf
c2NoZWRfcmVxdWVzdF9pbnNlcnRlZChzdHJ1Y3QgcmVxdWVzdCAqcnEpOw0KPiAgYm9vbCBibGtf
bXFfc2NoZWRfdHJ5X21lcmdlKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLCBzdHJ1Y3QgYmlvDQo+
ICpiaW8sDQo+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstbXEuYyBiL2Jsb2NrL2Jsay1tcS5jDQo+
IGluZGV4IDMyYjI0NmVkNDRjMC4uNjM2ZjgwYjk2ZmE2IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9i
bGstbXEuYw0KPiArKysgYi9ibG9jay9ibGstbXEuYw0KPiBAQCAtMzg5LDggKzM4OSw4IEBAIHN0
YXRpYyBzdHJ1Y3QgcmVxdWVzdCAqYmxrX21xX2dldF9yZXF1ZXN0KHN0cnVjdA0KPiByZXF1ZXN0
X3F1ZXVlICpxLA0KPiAgCWlmICghb3BfaXNfZmx1c2goZGF0YS0+Y21kX2ZsYWdzKSkgew0KPiAg
CQlycS0+ZWx2LmljcSA9IE5VTEw7DQo+ICAJCWlmIChlICYmIGUtPnR5cGUtPm9wcy5wcmVwYXJl
X3JlcXVlc3QpIHsNCj4gLQkJCWlmIChlLT50eXBlLT5pY3FfY2FjaGUgJiYgcnFfaW9jKGJpbykp
DQo+IC0JCQkJYmxrX21xX3NjaGVkX2Fzc2lnbl9pb2MocnEsIGJpbyk7DQo+ICsJCQlpZiAoZS0+
dHlwZS0+aWNxX2NhY2hlKQ0KPiArCQkJCWJsa19tcV9zY2hlZF9hc3NpZ25faW9jKHJxKTsNCj4g
IA0KPiAgCQkJZS0+dHlwZS0+b3BzLnByZXBhcmVfcmVxdWVzdChycSwgYmlvKTsNCj4gIAkJCXJx
LT5ycV9mbGFncyB8PSBSUUZfRUxWUFJJVjsNCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay5oIGIv
YmxvY2svYmxrLmgNCj4gaW5kZXggODE2YTlhYmI4N2NkLi42MTA5NDgxNTdhNWIgMTAwNjQ0DQo+
IC0tLSBhL2Jsb2NrL2Jsay5oDQo+ICsrKyBiL2Jsb2NrL2Jsay5oDQo+IEBAIC0yNTQsMjIgKzI1
NCw2IEBAIHZvaWQgaW9jX2NsZWFyX3F1ZXVlKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKTsNCj4g
IA0KPiAgaW50IGNyZWF0ZV90YXNrX2lvX2NvbnRleHQoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNr
LCBnZnBfdCBnZnBfbWFzaywNCj4gaW50IG5vZGUpOw0KPiAgDQo+IC0vKioNCj4gLSAqIHJxX2lv
YyAtIGRldGVybWluZSBpb19jb250ZXh0IGZvciByZXF1ZXN0IGFsbG9jYXRpb24NCj4gLSAqIEBi
aW86IHJlcXVlc3QgYmVpbmcgYWxsb2NhdGVkIGlzIGZvciB0aGlzIGJpbyAoY2FuIGJlICVOVUxM
KQ0KPiAtICoNCj4gLSAqIERldGVybWluZSBpb19jb250ZXh0IHRvIHVzZSBmb3IgcmVxdWVzdCBh
bGxvY2F0aW9uIGZvciBAYmlvLiAgTWF5DQo+IHJldHVybg0KPiAtICogJU5VTEwgaWYgJWN1cnJl
bnQtPmlvX2NvbnRleHQgZG9lc24ndCBleGlzdC4NCj4gLSAqLw0KPiAtc3RhdGljIGlubGluZSBz
dHJ1Y3QgaW9fY29udGV4dCAqcnFfaW9jKHN0cnVjdCBiaW8gKmJpbykNCj4gLXsNCj4gLSNpZmRl
ZiBDT05GSUdfQkxLX0NHUk9VUA0KPiAtCWlmIChiaW8gJiYgYmlvLT5iaV9pb2MpDQo+IC0JCXJl
dHVybiBiaW8tPmJpX2lvYzsNCj4gLSNlbmRpZg0KPiAtCXJldHVybiBjdXJyZW50LT5pb19jb250
ZXh0Ow0KPiAtfQ0KPiAtDQo+ICAvKioNCj4gICAqIGNyZWF0ZV9pb19jb250ZXh0IC0gdHJ5IHRv
IGNyZWF0ZSB0YXNrLT5pb19jb250ZXh0DQo+ICAgKiBAZ2ZwX21hc2s6IGFsbG9jYXRpb24gbWFz
aw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaCBiL2luY2x1ZGUvbGlu
dXgvYmxrX3R5cGVzLmgNCj4gaW5kZXggZGJkYmZiZDZhOTg3Li5jMGJhMWEwMzhmZjMgMTAwNjQ0
DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvYmxrX3R5cGVzLmgNCj4gKysrIGIvaW5jbHVkZS9saW51
eC9ibGtfdHlwZXMuaA0KPiBAQCAtMTc0LDEwICsxNzQsOSBAQCBzdHJ1Y3QgYmlvIHsNCj4gIAl2
b2lkCQkJKmJpX3ByaXZhdGU7DQo+ICAjaWZkZWYgQ09ORklHX0JMS19DR1JPVVANCj4gIAkvKg0K
PiAtCSAqIE9wdGlvbmFsIGlvYyBhbmQgY3NzIGFzc29jaWF0ZWQgd2l0aCB0aGlzIGJpby4gIFB1
dCBvbiBiaW8NCj4gKwkgKiBPcHRpb25hbCBjc3MgYXNzb2NpYXRlZCB3aXRoIHRoaXMgYmlvLiAg
UHV0IG9uIGJpbw0KPiAgCSAqIHJlbGVhc2UuICBSZWFkIGNvbW1lbnQgb24gdG9wIG9mIGJpb19h
c3NvY2lhdGVfY3VycmVudCgpLg0KPiAgCSAqLw0KPiAtCXN0cnVjdCBpb19jb250ZXh0CSpiaV9p
b2M7DQo+ICAJc3RydWN0IGNncm91cF9zdWJzeXNfc3RhdGUgKmJpX2NzczsNCj4gIAlzdHJ1Y3Qg
YmxrY2dfZ3EJCSpiaV9ibGtnOw0KPiAgCXN0cnVjdCBiaW9faXNzdWUJYmlfaXNzdWU7DQo=
