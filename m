Return-Path: <SRS0=qpPD=UU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5D7C43613
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 12:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3161121530
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 12:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b="MTAbG2p1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfFUMkF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:40:05 -0400
Received: from mail-eopbgr670117.outbound.protection.outlook.com ([40.107.67.117]:6115
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbfFUMkF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 08:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector1-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPMhbMxm+Q+yqbc1HWE8Z5ZM374l/CewccOdTbnppwI=;
 b=MTAbG2p1cDWfowBWI6KAwy5Y9Mh4hIhCsnfmDfsYXIbOaxkxOd4SaXKyfSYs8S/SUa5U0vhPbQ6p5BSlljqEsaIVxr+W0FCX2vyGXpW25suBEJ+qo6p0STsI1AKJcuK6kRfp2fCMQYSxsQACMAut6YlezpntfBWOd8h5hkJ8OwI=
Received: from QB1PR01MB3124.CANPRD01.PROD.OUTLOOK.COM (52.132.87.149) by
 QB1PR01MB3843.CANPRD01.PROD.OUTLOOK.COM (52.132.86.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 21 Jun 2019 12:40:02 +0000
Received: from QB1PR01MB3124.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::400d:d19c:d963:ff7f]) by QB1PR01MB3124.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::400d:d19c:d963:ff7f%6]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 12:40:02 +0000
From:   "Stephen  Bates" <sbates@raithlin.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "fio-owner@vger.kernel.org" <fio-owner@vger.kernel.org>
Subject: [io_uring]: fio's io_uring engine causing general protection fault
Thread-Topic: [io_uring]: fio's io_uring engine causing general protection
 fault
Thread-Index: AQHVKC5xaAmPJKhZL0mabQnP2ZbTiw==
Date:   Fri, 21 Jun 2019 12:40:02 +0000
Message-ID: <7A8449F0-0E79-43B0-9FDD-45292691F0F2@raithlin.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1a.0.190609
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com; 
x-originating-ip: [2001:bb6:a2c:ed58:8485:be58:c275:994a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 273cee66-4bd0-414f-c5fe-08d6f6459476
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:QB1PR01MB3843;
x-ms-traffictypediagnostic: QB1PR01MB3843:
x-microsoft-antispam-prvs: <QB1PR01MB3843F400D87477B1D4062053AAE70@QB1PR01MB3843.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39830400003)(346002)(376002)(396003)(199004)(189003)(2616005)(53936002)(81166006)(45080400002)(6512007)(316002)(6436002)(2906002)(6506007)(5640700003)(86362001)(6486002)(91956017)(2351001)(99286004)(66556008)(64756008)(6916009)(58126008)(6116002)(76116006)(508600001)(66946007)(7736002)(305945005)(256004)(5660300002)(73956011)(71190400001)(66446008)(102836004)(81156014)(71200400001)(2501003)(36756003)(46003)(186003)(8676002)(68736007)(4326008)(486006)(476003)(54906003)(8936002)(33656002)(25786009)(66476007)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:QB1PR01MB3843;H:QB1PR01MB3124.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: raithlin.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gNe50J4jOVZxOLCA5AUGdo51hYIb0XF7q2XHKRygBtDgJPmvJ7mE9JK0vFFVFUsNKO7SkSSYf5Q2cc3nsft4z/c+dNu2WUxF97rZEzMXPypEBMYCc0zYGwXh8SYogQk0u2TYqA8tnFcAkpddges1wgML9oIoR+1rZ40daQGmZRfM9jRn0XvE7i0ZBDlVrzbBxxJn38rsoQ3SJkNDQOlhOdmAIXq3anN2+xbnavJGievBZgcBx6yvPfZAb9f4CkBptReZi1hGMSSID7jRGTAm3F705fwOUiRjKQPraNRPRsAJVYaWi41VQqIn6myMvPHdKp6i8RyG5J2RMDVXVamXAjpWhxr44cBNs1WHkAuA+DEUmT1MDDnPM4z3cy+SzPTXbcUF+MBTykLWrmIZstkF0oca8h+ibfm3nKUMl1ExNEk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <904BE7E9EB26B9458DA039D40509DC04@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273cee66-4bd0-414f-c5fe-08d6f6459476
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 12:40:02.2022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbates@raithlin.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB3843
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkNCg0KSSBoaXQgdGhlIGZvbGxvd2luZyBHZW5lcmFsIFByb3RlY3Rpb24gRmF1bHQgd2hlbiB0
ZXN0aW5nIGlvX3VyaW5nIHZpYSB0aGUgaW9fdXJpbmcgZW5naW5lIGluIGZpby4gVGhpcyB3YXMg
b24gYSBWTSBydW5uaW5nIDUuMi1yYzUgYW5kIHRoZSBsYXRlc3QgdmVyc2lvbiBvZiBmaW8uIFRo
ZSBpc3N1ZSBvY2N1cnMgZm9yIGJvdGggbnVsbF9ibGsgYW5kIGZha2UgTlZNZSBkcml2ZXMuIEkg
aGF2ZSBub3QgdGVzdGVkIGJhcmUgbWV0YWwgb3IgcmVhbCBOVk1lIFNTRHMuIFRoZSBmaW8gc2Ny
aXB0IHVzZWQgaXMgZ2l2ZW4gYmVsb3cuDQoNCltpb191cmluZ10NCnRpbWVfYmFzZWQ9MQ0KcnVu
dGltZT02MA0KZmlsZW5hbWU9L2Rldi9udm1lMm4xIChub3RlIC9kZXYvbnVsbGIwIGFsc28gZmFp
bHMpDQppb2VuZ2luZT1pb191cmluZw0KYnM9NGsNCnJ3PXJlYWR3cml0ZQ0KZGlyZWN0PTENCmZp
eGVkYnVmcz0xDQpzcXRocmVhZF9wb2xsPTENCnNxdGhyZWFkX3BvbGxfY3B1PTANCg0KWyAgOTY0
LjU0MDM3NF0gZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0OiAwMDAwIFsjMV0gU01QIFBUSQ0KWyAg
OTY0LjU0MjA0MV0gQ1BVOiAwIFBJRDogODcyIENvbW06IGlvX3VyaW5nLXNxIE5vdCB0YWludGVk
IDUuMi4wLXJjNS1jcGFja2V0LWlvLXVyaW5nICMxDQpbICA5NjQuNTQ1NTg5XSBIYXJkd2FyZSBu
YW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyBVYnVudHUt
MS44LjItMXVidW50dTEgMDQvMDEvMjAxNA0KWyAgOTY0LjU0OTc2MV0gUklQOiAwMDEwOmZwdXRf
bWFueSsweDcvMHg5MA0KWyAgOTY0LjU1MTUyMl0gQ29kZTogMDEgNDggODUgZmYgNzQgMTcgNTUg
NDggODkgZTUgNTMgNDggOGIgMWYgZTggYTAgZjkgZmYgZmYgNDggODUgZGIgNDggODkgZGYgNzUg
ZjAgNWIgNWQgZjMgYzMgMGYgMWYgNDAgMDAgMGYgMWYgNDQgMDAgMDAgODkgZjYgPGYwPiA0OCAy
OSA3NyAzOCA3NCAwMSBjMyA1NSA0OCA4OSBlNSA1MyA0OCA4OSBmYiA2NSA0OCBcDQo4YiAzYyAy
NSBjMA0KWyAgOTY0LjU1OTAzMV0gUlNQOiAwMDE4OmZmZmZhZGViODE3ZWJjNTAgRUZMQUdTOiAw
MDAxMDI0Ng0KWyAgOTY0LjU2MTExMl0gUkFYOiAwMDAwMDAwMDAwMDAwMDA0IFJCWDogZmZmZjhm
NDZhZDQ3NzQ4MCBSQ1g6IDAwMDAwMDAwMDAwMDE4MDUNClsgIDk2NC41NjM5MTFdIFJEWDogMDAw
MDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDEgUkRJOiBmMThiNTFiOWEzOTU1MmI1
DQpbICA5NjQuNTY2NTgwXSBSQlA6IGZmZmZhZGViODE3ZWJjNTggUjA4OiBmZmZmOGY0NmI3YTMx
OGMwIFIwOTogMDAwMDAwMDAwMDAwMDE1ZA0KWyAgOTY0LjU2OTEwOV0gUjEwOiBmZmZmYWRlYjgx
N2ViY2U4IFIxMTogMDAwMDAwMDAwMDAwMDAyMCBSMTI6IGZmZmY4ZjQ2YWQ0Y2QwMDANClsgIDk2
NC41NzE2MjNdIFIxMzogMDAwMDAwMDBmZmZmZmZmNyBSMTQ6IGZmZmZhZGViODE3ZWJlMzAgUjE1
OiAwMDAwMDAwMDAwMDAwMDA0DQpbICA5NjQuNTc0MTUzXSBGUzogIDAwMDAwMDAwMDAwMDAwMDAo
MDAwMCkgR1M6ZmZmZjhmNDZiN2EwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQpb
ICA5NjQuNTc3MDIwXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgw
MDUwMDMzDQpbICA5NjQuNTc4OTE3XSBDUjI6IDAwMDA1NTgyOGYwYmJiZjAgQ1IzOiAwMDAwMDAw
MjMyMTc2MDA0IENSNDogMDAwMDAwMDAwMDM2MDZmMA0KWyAgOTY0LjU4MTIyMV0gRFIwOiAwMDAw
MDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDAN
ClsgIDk2NC41ODM1MTFdIERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBm
ZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwDQpbICA5NjQuNTg1ODA4XSBDYWxsIFRyYWNlOg0KWyAg
OTY0LjU4NjYyNl0gID8gZnB1dCsweDEzLzB4MjANClsgIDk2NC41ODc2MTNdICBpb19mcmVlX3Jl
cSsweDIwLzB4NDANClsgIDk2NC41ODg3MzNdICBpb19wdXRfcmVxKzB4MWIvMHgyMA0KWyAgOTY0
LjU4OTc5NV0gIGlvX3N1Ym1pdF9zcWUrMHg0MGEvMHg2ODANClsgIDk2NC41OTA5MTldICA/IF9f
c3dpdGNoX3RvX2FzbSsweDM0LzB4NzANClsgIDk2NC41OTIwOTBdICA/IF9fc3dpdGNoX3RvX2Fz
bSsweDQwLzB4NzANClsgIDk2NC41OTMyNzBdICBpb19zdWJtaXRfc3FlcysweGI5LzB4MTYwDQpb
ICA5NjQuNTk0MzkyXSAgPyBpb19zdWJtaXRfc3FlcysweGI5LzB4MTYwDQpbICA5NjQuNTk1NTY0
XSAgPyBfX3N3aXRjaF90b19hc20rMHg0MC8weDcwDQpbICA5NjQuNTk2NzM3XSAgPyBfX3N3aXRj
aF90b19hc20rMHgzNC8weDcwDQpbICA5NjQuNTk3OTE4XSAgPyBfX3NjaGVkdWxlKzB4M2YyLzB4
NmEwDQpbICA5NjQuNTk5MDE1XSAgPyBfX3N3aXRjaF90b19hc20rMHgzNC8weDcwDQpbICA5NjQu
NjAwNDQ0XSAgaW9fc3FfdGhyZWFkKzB4MWFmLzB4NDcwDQpbICA5NjQuNjAxNTY4XSAgPyBfX3N3
aXRjaF90b19hc20rMHgzNC8weDcwDQpbICA5NjQuNjAyNjU1XSAgPyB3YWl0X3dva2VuKzB4ODAv
MHg4MA0KWyAgOTY0LjYwMzYyNV0gID8gX19zd2l0Y2hfdG8rMHg4NS8weDQxMA0KWyAgOTY0LjYw
NDYzOF0gID8gX19zd2l0Y2hfdG9fYXNtKzB4NDAvMHg3MA0KWyAgOTY0LjYwNTcyNl0gID8gX19z
d2l0Y2hfdG9fYXNtKzB4MzQvMHg3MA0KWyAgOTY0LjYwNjgxMV0gID8gX19zY2hlZHVsZSsweDNm
Mi8weDZhMA0KWyAgOTY0LjYwNzgyN10gIGt0aHJlYWQrMHgxMDUvMHgxNDANClsgIDk2NC42MDg3
MjVdICA/IGlvX3N1Ym1pdF9zcWVzKzB4MTYwLzB4MTYwDQpbICA5NjQuNjA5ODM2XSAgPyBrdGhy
ZWFkKzB4MTA1LzB4MTQwDQpbICA5NjQuNjEwNzgwXSAgPyBpb19zdWJtaXRfc3FlcysweDE2MC8w
eDE2MA0KWyAgOTY0LjYxMTg4N10gID8ga3RocmVhZF9kZXN0cm95X3dvcmtlcisweDUwLzB4NTAN
ClsgIDk2NC42MTMxNThdICByZXRfZnJvbV9mb3JrKzB4MzUvMHg0MA0KWyAgOTY0LjYxNDE0OF0g
TW9kdWxlcyBsaW5rZWQgaW46IGNyY3QxMGRpZl9wY2xtdWwgY3JjMzJfcGNsbXVsIGdoYXNoX2Ns
bXVsbmlfaW50ZWwgYWVzbmlfaW50ZWwgYWVzX3g4Nl82NCBjcnlwdG9fc2ltZCBjcnlwdGQgZ2x1
ZV9oZWxwZXIgam95ZGV2IGlucHV0X2xlZHMgc2VyaW9fcmF3IG1hY19oaWQgc2NoX2ZxX2NvZGVs
IHN1bnJwYyBudWxsX2JsayBcDQppcF90YWJsZXMgeF90YWJsZXMgYXV0b2ZzNCA4MTM5dG9vIHBz
bW91c2UgODEzOWNwIGZsb3BweSBtaWkgaTJjX3BpaXg0IHBhdGFfYWNwaQ0KWyAgOTY0LjYyMDg1
Nl0gLS0tWyBlbmQgdHJhY2UgYmRiYmE4MThiMzEwMjcyYyBdLS0tDQoNCkNoZWVycw0KIA0KU3Rl
cGhlbiANCg0K
