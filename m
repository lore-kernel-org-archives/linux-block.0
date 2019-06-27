Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D739C48BD6
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 00:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D771D216C8
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 00:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fCuMjfJi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d6a6E9rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfF0AVb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:21:31 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20087 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfF0AVa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 20:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561594890; x=1593130890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kuc6xiHGf+KqMNgdWwZO7me3KjbnPD5h1/e5nmvDb6E=;
  b=fCuMjfJiMZ+YjSaxt1HaiLcGMtR/6LNtehx8JPg11w564WYcS0fhp8AG
   rF6dKQ1bVe5gNbSCbpNHB76tvmO2AYnmUHxj2okrYIhFrshRupN8VQ4j7
   ndPgpeEOWh2OsIVnnORJNS4tGYTIglKBISw1tgpE7OAjxo7qjksGFcM0f
   he6fIWR9FXZvSb/pgvjTTjBbfNZPpO/jOGAOA5QuvD2zzx0H5v6e/yiAs
   9kNttNixqONqzbiJSP4xReZUuJai+dvIVVofS1op39tWQSYekm588cbL0
   KhrQx2FFYvyoHD6LFpLAGdxSxKmZjHqWTx/Lf87wskzxrMWijEk3KGxCe
   g==;
X-IronPort-AV: E=Sophos;i="5.63,421,1557158400"; 
   d="scan'208";a="111636283"
Received: from mail-sn1nam04lp2059.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.59])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 08:21:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=JZl03FoSCEFkyW7IJfOyyAoOGQQrFZi2aOGX3DmgVH/1rioNUavB6kXtTUA9zw2xR8v8Ltc3xkYzgf/YuvcvAqDosS5f71MOOM4rg7/8bXcFpShC5T0ktmOO0Vysktq5tCPSbnZL+KjGVwr/M+7H4X1uA+Td8fEcEfx4KeJCcww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kuc6xiHGf+KqMNgdWwZO7me3KjbnPD5h1/e5nmvDb6E=;
 b=Qpdj03c770tFOhJW29zGtYnlpQnslxdAOSuBWJf7Ik66IWFLvMHOJahYWgFXPwBjTM0bcDGlSz8TmVbS902D8AslvipV0eJRMjxgUJAEGvqX19ugtpWQjxA3ATvhj9QFI/WvNqa5GWua9Un+H1ynKN91CVow4guMQUn754mU+Hk=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kuc6xiHGf+KqMNgdWwZO7me3KjbnPD5h1/e5nmvDb6E=;
 b=d6a6E9rx0zILvQJs/1ZOa1568GsIAAD5J9gKVGThM9E2WObaWTOylSf1tckVxFRElUkTB5dtEAQ6Qo5HZPO34m6gaPYC0VqUDqDWYiUSSg/GSFPM4WU4coS247k2ZC6EC6nkzzB8dqnJuVgKPnf0zaI3LaiRTVrJ8oo3wXnyn2Y=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4357.namprd04.prod.outlook.com (20.176.251.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Thu, 27 Jun 2019 00:21:28 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.018; Thu, 27 Jun 2019
 00:21:28 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>, Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/9] block: optionally mark pages dirty in
 bio_release_pages
Thread-Topic: [PATCH 2/9] block: optionally mark pages dirty in
 bio_release_pages
Thread-Index: AQHVLCYK3/IrCaLUQkidjIP9pyQ0rqauaeuA///E8wA=
Date:   Thu, 27 Jun 2019 00:21:27 +0000
Message-ID: <108F1585-0711-4D2C-9E99-0E404D4E173B@wdc.com>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-3-hch@lst.de> <20190626205247.GH4934@minwooim-desktop>
In-Reply-To: <20190626205247.GH4934@minwooim-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1a.0.190609
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f150ba2e-3fa2-4580-5be1-08d6fa956598
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4357;
x-ms-traffictypediagnostic: BYAPR04MB4357:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4357067D912620E22861E9B186FD0@BYAPR04MB4357.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(33656002)(6116002)(478600001)(186003)(25786009)(53546011)(8936002)(8676002)(3846002)(71200400001)(26005)(71190400001)(54906003)(53936002)(4326008)(5660300002)(64756008)(14444005)(256004)(66556008)(76116006)(73956011)(66946007)(66476007)(76176011)(66446008)(6486002)(99286004)(6436002)(305945005)(446003)(7736002)(72206003)(2616005)(2906002)(486006)(14454004)(476003)(102836004)(316002)(110136005)(58126008)(86362001)(6246003)(68736007)(81156014)(6506007)(81166006)(11346002)(6512007)(36756003)(66066001)(229853002)(14143004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4357;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tLms+hbl1jc2mzBTloc65VvaDdtYECITDnU9B8AuSUZQEQUJxG90g1MCc2+RjXLwsXJ5p9HmuVwYnIrdOJnqz/Xigx99gNheY0ufrGJHpfhjXo/6H9pkGs4sH4oksFv2LwX3STC3HtHdiGfU2UJb+YYExzvvuBVUaqOr9JGbn81hdchkiWxGQDFxm51D4q95TIRFznSUQJElDMGL+0CJ7QcwxKnKMnnBcAJyubvKD5qRNySHhuOYmQAdevvYwVUWYvqqfwBMZX4tziOoKyyLDr6yQA7ChLJsDo3gkekd/6PPvAfHxHhFw68Qb2Waq8f3ef5xHl7MMcp5EPXLUcSGphvfbF5Fcxj1sqg/E+N0ed3/AE1D2uy/FVmSlTuk5Sc/Mp0wIn5T+FR8YmEmRraWQeTvq7OosOPEfpbblcpRkFc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3C4A19DF08F7644B7A84F641F15DF31@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f150ba2e-3fa2-4580-5be1-08d6fa956598
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 00:21:27.9099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4357
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCu+7v09uIDYvMjYvMTksIDE6NTIgUE0sICJsaW51eC1ibG9jay1vd25lckB2Z2VyLmtlcm5l
bC5vcmcgb24gYmVoYWxmIG9mIE1pbndvbyBJbSIgPGxpbnV4LWJsb2NrLW93bmVyQHZnZXIua2Vy
bmVsLm9yZyBvbiBiZWhhbGYgb2YgbWlud29vLmltLmRldkBnbWFpbC5jb20+IHdyb3RlOg0KDQog
ICAgT24gMTktMDYtMjYgMTU6NDk6MjEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KICAgID4g
QSBsb3Qgb2YgY2FsbGVycyBvZiBiaW9fcmVsZWFzZV9wYWdlcyBhbHNvIHdhbnQgdG8gbWFyayB0
aGUgcmVsZWFzZWQNCiAgICA+IHBhZ2VzIGFzIGRpcnR5LiAgQWRkIGEgbWFya19kaXJ0eSBwYXJh
bWV0ZXIgdG8gYXZvaWQgYSBzZWNvbmQNCiAgICA+IHJlbGF0aXZlbHkgZXhwZW5zaXZlIGJpb19m
b3JfZWFjaF9zZWdtZW50X2FsbCBsb29wLg0KICAgID4gDQogICAgPiBTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCiAgICA+IC0tLQ0KICAgID4gIGJsb2NrL2Jp
by5jICAgICAgICAgfCAxMiArKysrKysrLS0tLS0NCiAgICA+ICBpbmNsdWRlL2xpbnV4L2Jpby5o
IHwgIDIgKy0NCiAgICA+ICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCiAgICA+IA0KICAgID4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jpby5jIGIvYmxvY2sv
YmlvLmMNCiAgICA+IGluZGV4IDliYzdkMjhhZTk5Ny4uN2YzOTIwYjZiYWNhIDEwMDY0NA0KICAg
ID4gLS0tIGEvYmxvY2svYmlvLmMNCiAgICA+ICsrKyBiL2Jsb2NrL2Jpby5jDQogICAgPiBAQCAt
ODQ1LDcgKzg0NSw3IEBAIHN0YXRpYyB2b2lkIGJpb19nZXRfcGFnZXMoc3RydWN0IGJpbyAqYmlv
KQ0KICAgID4gIAkJZ2V0X3BhZ2UoYnZlYy0+YnZfcGFnZSk7DQogICAgPiAgfQ0KICAgID4gIA0K
ICAgID4gLXZvaWQgYmlvX3JlbGVhc2VfcGFnZXMoc3RydWN0IGJpbyAqYmlvKQ0KICAgID4gK3Zv
aWQgYmlvX3JlbGVhc2VfcGFnZXMoc3RydWN0IGJpbyAqYmlvLCBib29sIG1hcmtfZGlydHkpDQog
ICAgPiAgew0KICAgID4gIAlzdHJ1Y3QgYnZlY19pdGVyX2FsbCBpdGVyX2FsbDsNCiAgICA+ICAJ
c3RydWN0IGJpb192ZWMgKmJ2ZWM7DQogICAgPiBAQCAtODUzLDggKzg1MywxMSBAQCB2b2lkIGJp
b19yZWxlYXNlX3BhZ2VzKHN0cnVjdCBiaW8gKmJpbykNCiAgICA+ICAJaWYgKGJpb19mbGFnZ2Vk
KGJpbywgQklPX05PX1BBR0VfUkVGKSkNCiAgICA+ICAJCXJldHVybjsNCiAgICA+ICANCiAgICA+
IC0JYmlvX2Zvcl9lYWNoX3NlZ21lbnRfYWxsKGJ2ZWMsIGJpbywgaXRlcl9hbGwpDQogICAgPiAr
CWJpb19mb3JfZWFjaF9zZWdtZW50X2FsbChidmVjLCBiaW8sIGl0ZXJfYWxsKSB7DQogICAgPiAr
CQlpZiAobWFya19kaXJ0eSAmJiAhUGFnZUNvbXBvdW5kKGJ2ZWMtPmJ2X3BhZ2UpKQ0KICAgID4g
KwkJCXNldF9wYWdlX2RpcnR5X2xvY2soYnZlYy0+YnZfcGFnZSk7DQogICAgDQogICAgQ2hyaXN0
b3BoLA0KICAgIA0KICAgIENvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiBhIGJpdCB3aHkgd2Ugc2hv
dWxkIG5vdCBtYWtlIGl0IGRpcnR5IGluIGNhc2UNCiAgICBvZiBjb21wb3VuZCBwYWdlPw0KDQpN
YXliZSBiZWNhdXNlIG9mIFtQQVRDSCA3LzldIGJsb2NrX2RldjogdXNlIGJpb19yZWxlYXNlX3Bh
Z2VzIGluIGJpb191bm1hcF91c2VyIDotDQoNCkBAIC0yNTksMTMgKzI1OCw3IEBAIF9fYmxrZGV2
X2RpcmVjdF9JT19zaW1wbGUoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0
ZXIsDQoJfQ0KCV9fc2V0X2N1cnJlbnRfc3RhdGUoVEFTS19SVU5OSU5HKTsNCi0JYmlvX2Zvcl9l
YWNoX3NlZ21lbnRfYWxsKGJ2ZWMsICZiaW8sIGl0ZXJfYWxsKSB7DQotCQlpZiAoc2hvdWxkX2Rp
cnR5ICYmICFQYWdlQ29tcG91bmQoYnZlYy0+YnZfcGFnZSkpDQotCQkJc2V0X3BhZ2VfZGlydHlf
bG9jayhidmVjLT5idl9wYWdlKTsNCi0JCWlmICghYmlvX2ZsYWdnZWQoJmJpbywgQklPX05PX1BB
R0VfUkVGKSkNCi0JCQlwdXRfcGFnZShidmVjLT5idl9wYWdlKTsNCi0JfQ0KLQ0KKwliaW9fcmVs
ZWFzZV9wYWdlcygmYmlvLCBzaG91bGRfZGlydHkpOw0KDQpJJ2xsIGxldCBDaHJpc3RvcGggY29u
ZmlybSB0aGF0Lg0KDQoNCg0KDQoNCg0KDQogICAgDQoNCg==
