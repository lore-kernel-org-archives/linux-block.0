Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24AEC43218
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 13:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620BB20896
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 13:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b="Qh8BFIIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404082AbfFKNh1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:37:27 -0400
Received: from mail-eopbgr670137.outbound.protection.outlook.com ([40.107.67.137]:41824
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403885AbfFKNh1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 09:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector1-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYDBg/b/j0kffkGycmizFS4zMTV9rbEvCDNSCdQvOPU=;
 b=Qh8BFIIUxV2dPBeLzrKRnlvvEE08IyVC1ib2IxpoW3tX0NTa3ObjvTYtMWiRc3lftS9tP5942h1uWFpMbiT28nKAXaOPPqQiDFk6HDTKTH0MKMt1N4LTH/4iOon2et+sadBqRx8vzSIp3D5HWbEpwIL/GmDsvx39gkhccb/UrJk=
Received: from YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM (52.132.44.17) by
 YTOPR0101MB1116.CANPRD01.PROD.OUTLOOK.COM (52.132.50.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Tue, 11 Jun 2019 13:37:25 +0000
Received: from YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3535:ab58:99bd:516]) by YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3535:ab58:99bd:516%7]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 13:37:25 +0000
From:   "Stephen  Bates" <sbates@raithlin.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH liburing] example/io_uring-test.c: Fix iovecs increment
Thread-Topic: [PATCH liburing] example/io_uring-test.c: Fix iovecs increment
Thread-Index: AQHVIFrNExpuICTltEa5BqjpHmdcjg==
Date:   Tue, 11 Jun 2019 13:37:25 +0000
Message-ID: <5C501554-CE72-443C-88B1-FED5AC810554@raithlin.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1a.0.190609
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com; 
x-originating-ip: [2001:bb6:a2c:ed58:2ca3:41e6:9240:e71d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a605cfba-35f2-498f-c1a7-08d6ee71f0a7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:YTOPR0101MB1116;
x-ms-traffictypediagnostic: YTOPR0101MB1116:
x-microsoft-antispam-prvs: <YTOPR0101MB111672CAB718EC4B1A7B4A32AAED0@YTOPR0101MB1116.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39830400003)(376002)(346002)(189003)(199004)(316002)(2616005)(53936002)(2906002)(476003)(4744005)(6486002)(508600001)(86362001)(6512007)(6116002)(83716004)(102836004)(82746002)(71200400001)(36756003)(256004)(8936002)(71190400001)(8676002)(33656002)(81166006)(7736002)(6506007)(305945005)(68736007)(81156014)(58126008)(66946007)(46003)(186003)(5640700003)(66446008)(76116006)(486006)(6436002)(2501003)(5660300002)(66556008)(14454004)(2351001)(91956017)(4326008)(66476007)(73956011)(99286004)(25786009)(6916009)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:YTOPR0101MB1116;H:YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: raithlin.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nyXdCAsmwgSh6FMEAe3WqLZZLv4ND+8UaL7wweoiT+L7R4dZiQ8lhbWmBprQSF7IQSv12qTKNN8IBCEG3dgE67R57kEpowiMT3wmcYJpUzmP+HyfK0tGXqhJeUfwjqumiZuGdRvw4oc8ChO/hwMmMX4TkbsHTRXmNUzGoOo5lUyqEwFPmYBWGbebAfnTFnV6hvzgWOIGPGXOU+08Mb56ZCHZ51RdKNV0sjlNloyUYD+NRHEK1N4FVjGat6vwqc7Npgg1m47EpsSrmPnENccy82LitkldlUvwqIWDp2m/15boIvubAeYTyvLYETg8bjO7D2GzzAYQaFPNQG660E4XyN9BossV7b0SZTDURMsq498RvCJvryLRPVhbrBE8LhzyBlYM9CMXJawcPdRLEPCaF5nO108m8KWQSyodPCtaMqg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAC5202C223A0B48B0FDC5796A212A61@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a605cfba-35f2-498f-c1a7-08d6ee71f0a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 13:37:25.4595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbates@raithlin.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1116
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

VGhpcyBleGFtcGxlIG1pc3NlcyBhbiBpbmNyZW1lbnQgdGhvdWdoIHRoZSBpb3ZlY3MgYXJyYXku
IFRoaXMgY2F1c2VzDQp0aGUgc2FtZSBidWZmZXIgdG8gYmUgZmlsbGVkIGZyb20gdGhlIGJsb2Nr
IGRldmljZSBldmVyeSB0aW1lLiBJdCB3b3VsZCANCmJlIGdvb2QgdG8gZml4IHRoaXMgc2luY2Ug
aXQgaXMgb25lIG9mIHRoZSBmaXJzdCBleGFtcGxlcyBhIG5ldy1jb21lciB0bw0KaW9fdXJpbmcg
aXMgZXhwb3NlZCB0b28uDQoNClNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gQmF0ZXMgPHNiYXRlc0By
YWl0aGxpbi5jb20+DQotLS0NCiBleGFtcGxlcy9pb191cmluZy10ZXN0LmMgfCAxICsNCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2V4YW1wbGVzL2lvX3Vy
aW5nLXRlc3QuYyBiL2V4YW1wbGVzL2lvX3VyaW5nLXRlc3QuYw0KaW5kZXggYmJhYzNhNy4uMGI5
NzVhZCAxMDA2NDQNCi0tLSBhL2V4YW1wbGVzL2lvX3VyaW5nLXRlc3QuYw0KKysrIGIvZXhhbXBs
ZXMvaW9fdXJpbmctdGVzdC5jDQpAQCAtNTYsNiArNTYsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqYXJndltdKQ0KIAkJCWJyZWFrOw0KIAkJaW9fdXJpbmdfcHJlcF9yZWFkdihzcWUsIGZk
LCAmaW92ZWNzW2ldLCAxLCBvZmZzZXQpOw0KIAkJb2Zmc2V0ICs9IGlvdmVjc1tpXS5pb3ZfbGVu
Ow0KKwkJaSsrOw0KIAl9IHdoaWxlICgxKTsNCiANCiAJcmV0ID0gaW9fdXJpbmdfc3VibWl0KCZy
aW5nKTsNCi0tIA0KMi4xNy4xDQogDQoNCg==
