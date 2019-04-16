Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CACC10F0E
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 03:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28ECF2075B
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 03:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LBXOJ17b";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gYWjUdDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfDPDdj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:33:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34757 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDPDdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 23:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555385619; x=1586921619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2f/P6mju1tXXb6WB/wwl5HR3i9vUNrcDdP2UvBN8UGg=;
  b=LBXOJ17bWCQz4kosetIWsyKmoy4CwOx7QGUWQk25VCvVi1O4rDMrD+aW
   a91ghFx/1h2ov1wlTMASxA8fbsiHqgsjjIgh5JvFO8J9VXam0eVAAI8sw
   WWSscGCn6b5D/OlXpmiUeISDNidleFodUSE3/c/2kQZF/IAYSB7rLM4ES
   iROXSUKouGiEC5tGXR7+pSgqqxar7NcGgoV/RAQNmiJu//JKIIF+DP7t5
   KdwwIE5bf3R72NrrUOsVOBDQVyLwaKOWLGAPqispeMGMMcb4sGliy9eNP
   Pqr/yFr6BBIsDgvdVOGYdzAofWlfxJ36fn6E/ZxWsHJhs1r95bv16BG43
   A==;
X-IronPort-AV: E=Sophos;i="5.60,355,1549900800"; 
   d="scan'208";a="106051776"
Received: from mail-by2nam01lp2054.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.54])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2019 11:33:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f/P6mju1tXXb6WB/wwl5HR3i9vUNrcDdP2UvBN8UGg=;
 b=gYWjUdDv95BPel+ZRAN1gQvHuOi/4HYqTMt5kKZVUMix7Rq7Kdh+Oty/CmYnqy4ENKaxtC3LhMguxdThNaa3o5cg2lKpD5x4SkVNFtrpkWfCD1Y1okfz6C0pdwBUQ/m1IrPtCX7aF0VzS9aP6JnGxTBrBTJW8wZES2Z1koGlzJ8=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4750.namprd04.prod.outlook.com (52.135.122.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Tue, 16 Apr 2019 03:33:36 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1792.018; Tue, 16 Apr 2019
 03:33:36 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/3] blk-mq.c: Rework documention of
 blk_mq_init_sq_queue function
Thread-Topic: [PATCH v2 2/3] blk-mq.c: Rework documention of
 blk_mq_init_sq_queue function
Thread-Index: AQHU9AR6hhKY4EnI8Uqykj6wMPpTO6Y9rPaA
Date:   Tue, 16 Apr 2019 03:33:36 +0000
Message-ID: <1D00DC34-FC88-4F47-BB9F-A953A05794FD@wdc.com>
References: <20190416032801.200694-1-marcos.souza.org@gmail.com>
 <20190416032801.200694-2-marcos.souza.org@gmail.com>
In-Reply-To: <20190416032801.200694-2-marcos.souza.org@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.17.1.190326
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:a40c:71d7:63f8:b285]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 442fc6dc-0dd1-436a-f2be-08d6c21c4f4c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4750;
x-ms-traffictypediagnostic: SN6PR04MB4750:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4750EB18AA551F40F44E387486240@SN6PR04MB4750.namprd04.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(136003)(346002)(366004)(199004)(189003)(6246003)(14454004)(5660300002)(2906002)(6486002)(58126008)(316002)(86362001)(68736007)(33656002)(54906003)(110136005)(53936002)(4326008)(25786009)(14444005)(6116002)(256004)(6436002)(6512007)(82746002)(229853002)(2501003)(305945005)(478600001)(81156014)(81166006)(72206003)(97736004)(11346002)(2616005)(476003)(36756003)(446003)(46003)(102836004)(76176011)(186003)(8936002)(99286004)(71200400001)(71190400001)(83716004)(8676002)(6506007)(105586002)(106356001)(486006)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4750;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r9xguGLRJQ/hYQ77+aVZM+1P10rOyJEgMy+4mkeU8np92fF9/L06zV8fGdlRXcfSlFurHbQ7nKvzRL9j00qZd9QEzquM7y/BHpg7Ubx0Ey3U+uilyIA3Nhx2xQ0Qxo3G70aknBq4jsCKptA+Qdis5+4IvrXdQXLQZfn20Mzq1H3hci0t1jHuFZr607j6B8pfb8ctBgyZDjDsNIizuL+MyCPZbo6LUBdN0GunfqRPqeADDqCx5DQDX6uNvSNIeW3+kh9qxd7We3bdEGPRD3hoQbkGdAxkIkzjKBQ25iW00VPXq5i+ugJLmbsAhmn0Blnqwt887InATRu24+vKIgQR9/Ah/tShKNM8YhInrF4lUXoTAvt8hwffgw0rd7j6SYtWPpqlAS76dwsTWN0v5puyS6Ivo3NVNBvRjzxL5qWdzMU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14CAA8AA9B8E42408F7A58C6F632547F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442fc6dc-0dd1-436a-f2be-08d6c21c4f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 03:33:36.3338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4750
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlh
Lmt1bGthcm5pQHdkYy5jb20+DQoNCu+7v09uIDQvMTUvMTksIDg6MjggUE0sICJsaW51eC1ibG9j
ay1vd25lckB2Z2VyLmtlcm5lbC5vcmcgb24gYmVoYWxmIG9mIE1hcmNvcyBQYXVsbyBkZSBTb3V6
YSIgPGxpbnV4LWJsb2NrLW93bmVyQHZnZXIua2VybmVsLm9yZyBvbiBiZWhhbGYgb2YgbWFyY29z
LnNvdXphLm9yZ0BnbWFpbC5jb20+IHdyb3RlOg0KDQogICAgRGVzY3JpYmluZyBiZXR0ZXIgd2hh
dCB0aGUgZnVuY3Rpb24gZG9lcywgd2hhdCB0aGUgYXJndW1lbnRzIGFyZSBtZWFudCBmb3IsIGFu
ZA0KICAgIHdoYXQgU1Egc3RhbmRzIGZvci4NCiAgICANCiAgICBTaWduZWQtb2ZmLWJ5OiBNYXJj
b3MgUGF1bG8gZGUgU291emEgPG1hcmNvcy5zb3V6YS5vcmdAZ21haWwuY29tPg0KICAgIC0tLQ0K
ICAgIA0KICAgICBDaGFuZ2VzIGZyb20gdjE6DQogICAgICogQ2hhbmdlICJTUSIgdG8gIm9ubHkg
b25lIGh3X3F1ZXVlIChTUSkiIGluIHRoZSBmdW5jdGlvbiBzaWduYXR1cmUNCiAgICAgCWRvY3Vt
ZW50YXRpb24gKHN1Z2dlc3RlZCBieSBDaGFpdGFueWEpDQogICAgDQogICAgIGJsb2NrL2Jsay1t
cS5jIHwgMTcgKysrKysrKysrKysrKystLS0NCiAgICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQogICAgDQogICAgZGlmZiAtLWdpdCBhL2Jsb2NrL2Js
ay1tcS5jIGIvYmxvY2svYmxrLW1xLmMNCiAgICBpbmRleCA0YTgyNzdhNTRjMDMuLjNmMTNjZmI0
N2NmMCAxMDA2NDQNCiAgICAtLS0gYS9ibG9jay9ibGstbXEuYw0KICAgICsrKyBiL2Jsb2NrL2Js
ay1tcS5jDQogICAgQEAgLTI2NzUsOSArMjY3NSwyMCBAQCBzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAq
YmxrX21xX2luaXRfcXVldWUoc3RydWN0IGJsa19tcV90YWdfc2V0ICpzZXQpDQogICAgIH0NCiAg
ICAgRVhQT1JUX1NZTUJPTChibGtfbXFfaW5pdF9xdWV1ZSk7DQogICAgIA0KICAgIC0vKg0KICAg
IC0gKiBIZWxwZXIgZm9yIHNldHRpbmcgdXAgYSBxdWV1ZSB3aXRoIG1xIG9wcywgZ2l2ZW4gcXVl
dWUgZGVwdGgsIGFuZA0KICAgIC0gKiB0aGUgcGFzc2VkIGluIG1xIG9wcyBmbGFncy4NCiAgICAr
LyoqDQogICAgKyAqIGJsa19tcV9pbml0X3NxX3F1ZXVlIC0gQ3JlYXRlIGEgbmV3IHJlcXVlc3Qg
cXVldWUgd2l0aCBvbmx5IG9uZSBod19xdWV1ZSAoU1EpDQogICAgKyAqIEBzZXQ6IHRhZyBzZXQg
dG8gYmUgYXNzb2NpYXRlZCBieSB0aGUgbmV3bHkgY3JlYXRlZCByZXF1ZXN0IHF1ZXVlDQogICAg
KyAqIEBvcHM6IG9wZXJhdGlvbnMgdG8gYmUgYXNzb2NpYXRlZCB3aXRoIEBzZXQNCiAgICArICog
QHF1ZXVlX2RlcHRoOiBudW1iZXIgb2YgdGFncyBvZiBAc2V0DQogICAgKyAqIEBzZXRfZmxhZ3M6
IGZsYWdzIG9mIEBzZXQNCiAgICArICoNCiAgICArICogRGVzY3JpcHRpb246DQogICAgKyAqIEBz
ZXQgaXMgaW5pdGlhbGl6ZWQgdXNpbmcgQG9wcywgQHF1ZXVlX2RlcHRoLCBAc2V0X2ZsYWdzLCBh
bmQgdXNpbmcgb25seSBvbmUNCiAgICArICogaHdfcXVldWUgKFNRKS4gTGF0ZXIgb24gYmxrX21x
X2FsbG9jX3RhZ19zZXQoKSBpcyBjYWxsZWQgdG8gdmFsaWRhdGUgYW5kL29yDQogICAgKyAqIGFk
anVzdCB2YWx1ZXMgb2YgdGhlIHRhZyBzZXQuIGJsa19tcV9pbml0X3F1ZXVlKCkgaXMgY2FsbGVk
IHBhc3NpbmcgQHNldCBhcw0KICAgICsgKiBhcmd1bWVudCwgcmV0dXJuaW5nIGEgbmV3IHJlcXVl
c3QgcXVldWUgd2l0aCBAc2V0IGFzc29jaWF0ZWQuDQogICAgKyAqDQogICAgKyAqIFJldHVybnMg
dGhlIG5ld2x5IGNyZWF0ZWQgcmVxdWVzdCBxdWV1ZSBvbiBzdWNjZXNzLCBvciBFUlJfUFRSKCkg
b24gZmFpbHVyZS4NCiAgICAgICovDQogICAgIHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpibGtfbXFf
aW5pdF9zcV9xdWV1ZShzdHJ1Y3QgYmxrX21xX3RhZ19zZXQgKnNldCwNCiAgICAgCQkJCQkgICBj
b25zdCBzdHJ1Y3QgYmxrX21xX29wcyAqb3BzLA0KICAgIC0tIA0KICAgIDIuMTYuNA0KICAgIA0K
ICAgIA0KDQo=
