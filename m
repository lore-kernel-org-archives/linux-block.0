Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD63CC4321A
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 15:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978EC206BB
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 15:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b="AW0Ntcr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404508AbfFKPLM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:11:12 -0400
Received: from mail-eopbgr660135.outbound.protection.outlook.com ([40.107.66.135]:27136
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404488AbfFKPLL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 11:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector1-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKSn54EE//fpDhEWnnc9FY1Qxy/7sAFBTrS1Jd4jGCk=;
 b=AW0Ntcr8UPeBvjDJ6yhr5JMBCZuhJ+TaKGKjz43wfU/HM7qxiYep7yBz1W9ORU27xT+CS2eFILEOfboYPh21ZzPvTLbgLu51JkbIqzcdV5W5mD6kKQn641KFtw8VhMjp/fMzHIi5paeIoAGrDH1D32ib5P3k1JknAjtxRuHGcJk=
Received: from YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM (52.132.44.17) by
 YTOPR0101MB1706.CANPRD01.PROD.OUTLOOK.COM (52.132.45.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Tue, 11 Jun 2019 15:11:09 +0000
Received: from YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3535:ab58:99bd:516]) by YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3535:ab58:99bd:516%7]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 15:11:09 +0000
From:   "Stephen  Bates" <sbates@raithlin.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
Subject: io_uring: buf_index and registered buffers
Thread-Topic: io_uring: buf_index and registered buffers
Thread-Index: AQHVIGflzE7Eqs5sfE6WYu37PO13oQ==
Date:   Tue, 11 Jun 2019 15:11:08 +0000
Message-ID: <99E68FD7-430D-4D58-920F-8705D823A4F6@raithlin.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1a.0.190609
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com; 
x-originating-ip: [2001:bb6:a2c:ed58:2ca3:41e6:9240:e71d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a07f892-ebab-4bb0-4972-08d6ee7f0899
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:YTOPR0101MB1706;
x-ms-traffictypediagnostic: YTOPR0101MB1706:
x-microsoft-antispam-prvs: <YTOPR0101MB1706A65F0F77916655F7576CAAED0@YTOPR0101MB1706.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(136003)(346002)(396003)(376002)(189003)(199004)(53936002)(58126008)(2501003)(508600001)(6116002)(316002)(7736002)(86362001)(4326008)(99286004)(5660300002)(6512007)(6916009)(6506007)(102836004)(82746002)(6436002)(305945005)(14454004)(6486002)(2351001)(68736007)(36756003)(66946007)(76116006)(14444005)(91956017)(66476007)(25786009)(5640700003)(66446008)(2906002)(186003)(66556008)(64756008)(2616005)(256004)(8676002)(33656002)(81166006)(81156014)(46003)(486006)(73956011)(83716004)(71190400001)(476003)(8936002)(71200400001)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:YTOPR0101MB1706;H:YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: raithlin.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: io0hmdC/9LSP5oieIpKiW4LSwoCMjaadGOb5Z6CNfyxmAVqHqN/nkQlIZgg0w3iPtaw7gRQwcFqpXthFTpUQUDJh1zaw1gDvgkPhl4ooYOLWMYbL1DlFUqoa9QLKCwEuLZDj9zLTmlqH1wFW7xiUgt4Y6EO1cwyKqfwyJafr7Yxo5qbsfnSgTqNF9bhWgD4uGlKJ67z096E3sHXEjpLR5oGSc5Sod+vHcISJY0qWZu2o447IpajATJ+X0nPXo/7b0mYj5Jt35npel6k1AgphCAA/waT6vSyZTJo9yDf9R9Zc1zpj2w5PlgUEeOPTpIlZCA+K1SGUt6QM60gJaXAkVYRSsr1kiJbe6KrXB2+/sG8DcpOg6QZnaBaZq7ym48TkWvHPXVLbUjSkLEdC1+39qJuhthyQUwj6vi1UnWWb6mg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ADAE165CA765F46B086130038134049@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a07f892-ebab-4bb0-4972-08d6ee7f0899
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 15:11:09.0575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbates@raithlin.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1706
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkgSmVucyBhbmQgVGVhbQ0KDQpXaGlsZSBleHBlcmltZW50aW5nIHdpdGggaW9fdXJpbmcgYW5k
IGxpYnVyaW5nIEkgc2VlbSB0byBoYXZlIGhpdCBhbiBpc3N1ZSB3aXRoIHJlZ2lzdGVyZWQgYnVm
ZmVycy4gSSBjYW4ndCBzZWUgYSB3YXkgdGhhdCBlaXRoZXIgaW9fdXJpbmdfcmVnaXN0ZXIoKSBv
ciBsaWJ1cmluZyBjYW4gcmV0dXJuIHRoZSBidWZmZXIgaW5kaWNpZXMgYXNzb2NpYXRlZCB3aXRo
IHJlZ2lzdGVyZWQgYnVmZmVycy4gSW4gYWRkaXRpb24sIHRoZXJlIGlzIG5vIHdheSB0byBzZXQg
c3FlLmJ1Zl9pbmRleCB2aWEgbGlidXJpbmcgcmlnaHQgbm93IHdoZW4gc3VibWl0dGluZyBhbiBJ
TyAoaXQgaXMgbWVtc2V0IHRvIDAgaW4gbGlidXJpbmcuaCkuIFRoZSBlbmQgcmVzdWx0IGlzIHRo
YXQgaW9fdXJpbmcgSU8gc3RhcnQgdG8gZmFpbCB3aGVuIHdlIGRvIHRoZW0gZnJvbSBhIHNldCBv
ZiByZWdpc3RlcmVkIGJ1ZmZlcnMuDQoNCkknZCBiZSBoYXBweSB0byB3b3JrIG9uIGEgcGF0Y2gg
Zm9yIHRoaXMgYnV0IGNvdWxkIGRvIHdpdGggY29uZmlybWF0aW9uIHRoYXQgdGhpcyBhIHByb2Js
ZW0gYW5kIHNvbWUgZ3VpZGFuY2Ugb24gYSBnb29kIGFwcHJvYWNoIHRvIGZpeGluZyB0aGlzIGlu
IGJvdGggdGhlIHN5c3RlbSBjYWxsIGFuZCB0aGUgdXNlci1zcGFjZSBsaWJyYXJ5Lg0KDQpCVFcg
d2hpbGUgbGlidXJpbmcgdGVzdHMgdGhlIGNyZWF0aW9uIG9mIG11bHRpcGxlIHJlZ2lzdGVyZWQg
YnVmZmVycyBpdCBuZXZlciBpc3N1ZXMgSU8gYWdhaW5zdCB0aGVtIHNvIHRoYXQgd291bGQgYmUg
YSBob2xlIEknZCBsaWtlIHRvIGZpbGwgdG9vLg0KDQpDaGVlcnMNCiANClN0ZXBoZW4NCiANCg0K
