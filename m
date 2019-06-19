Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23AAC31E49
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 13:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9452166E
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 13:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b="KXo75s9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfFSNS0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:18:26 -0400
Received: from mail-eopbgr670102.outbound.protection.outlook.com ([40.107.67.102]:23618
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727068AbfFSNS0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 09:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector1-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaU6e0mOGxTAAbaCvpdcD+pzpmUUcsNEkaS0VmQ6XFc=;
 b=KXo75s9STdOIToisTZU82+HTtBPHXZLmdL4FJT9+ZkC/sn+olX+ue4Xa4UpYCxzSl6geDL6wzjloWl4oGDiIkaL6e1rod1G/T8sn/J+/vSnd+rn8aCkmGwnSuwzGOALe3fmgc48wIQG2D0yzcAklRcRlxZddRNDpldVczhGR3bc=
Received: from YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM (52.132.44.17) by
 YTOPR0101MB1612.CANPRD01.PROD.OUTLOOK.COM (52.132.44.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 19 Jun 2019 13:18:22 +0000
Received: from YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3535:ab58:99bd:516]) by YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::3535:ab58:99bd:516%7]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 13:18:22 +0000
From:   "Stephen  Bates" <sbates@raithlin.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: io_uring: buf_index and registered buffers
Thread-Topic: io_uring: buf_index and registered buffers
Thread-Index: AQHVIGflzE7Eqs5sfE6WYu37PO13oaaZRRKAgAnNygA=
Date:   Wed, 19 Jun 2019 13:18:22 +0000
Message-ID: <7F7B5F79-410A-4E3A-8EB6-97BB665A4A91@raithlin.com>
References: <99E68FD7-430D-4D58-920F-8705D823A4F6@raithlin.com>
 <4510f6eb-9165-f239-7770-65b1596a7e18@kernel.dk>
In-Reply-To: <4510f6eb-9165-f239-7770-65b1596a7e18@kernel.dk>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1a.0.190609
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com; 
x-originating-ip: [2a00:23c0:9680:6a00:b1a0:a0b8:f5c2:d7fa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa87cb31-e82c-493c-2e9a-08d6f4b89ad4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:YTOPR0101MB1612;
x-ms-traffictypediagnostic: YTOPR0101MB1612:
x-microsoft-antispam-prvs: <YTOPR0101MB1612E1F6BE9FE92E77E1D860AAE50@YTOPR0101MB1612.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(39830400003)(396003)(189003)(199004)(66556008)(8936002)(476003)(64756008)(6436002)(186003)(5660300002)(102836004)(66446008)(86362001)(36756003)(6506007)(486006)(6116002)(2616005)(99286004)(25786009)(46003)(11346002)(446003)(33656002)(81156014)(73956011)(66946007)(81166006)(14454004)(6512007)(7736002)(6486002)(8676002)(71200400001)(305945005)(508600001)(91956017)(110136005)(316002)(76116006)(256004)(6246003)(71190400001)(58126008)(2906002)(229853002)(68736007)(53936002)(4744005)(2501003)(76176011)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:YTOPR0101MB1612;H:YTOPR0101MB0793.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: raithlin.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LZ5YRiVvDEKWZY7R6yoxTgNmQHvcHEQTR0DcXgxJmgvlFBtsHr83rZ/UWUok/QjAUyIa8jIANuh3b56IUW4UNAMMxaoXYfpZbwvovoPSPqUysPObNE6LIwrBAO010Pj2XG3C41RXc+bKJUl3kefmjRO1GUnb3PPxZ1x0iMRwIoWXpbQziOD7dI3bwP5SnIlP15SV0Tjh58AxJ/Xbi6JeEuX0yUIdVBb3tx1wqwj3zLJQ3FpzcIXDIIOlsmAwMH0JGNLg554BisCkYu3WxtLtSieezzSDspmWXWw/RVCm3oaMYxazmKvnRsYAMDUpg8je2KfN2L/3LE4nhWHK5bkmpVbfpWm8LQBe+vbvb1NDNusK9N7rDGqzu1tQLXydd0dl3BenO2cMLAVJRVV4YtjuNEmcMwf5YhC9Xe/BCIXq/C8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AD498091F643446AA7A3F4C173BBABB@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa87cb31-e82c-493c-2e9a-08d6f4b89ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 13:18:22.6821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbates@raithlin.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1612
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pj4gV2hpbGUgZXhwZXJpbWVudGluZyB3aXRoIGlvX3VyaW5nIGFuZCBsaWJ1cmluZyBJIHNlZW0g
dG8gaGF2ZSBoaXQgYW4NCj4+IGlzc3VlIHdpdGggcmVnaXN0ZXJlZCBidWZmZXJzLiBJIGNhbid0
IHNlZSBhIHdheSB0aGF0IGVpdGhlcg0KPj4gaW9fdXJpbmdfcmVnaXN0ZXIoKSBvciBsaWJ1cmlu
ZyBjYW4gcmV0dXJuIHRoZSBidWZmZXIgaW5kaWNpZXMNCj4+IGFzc29jaWF0ZWQgd2l0aCByZWdp
c3RlcmVkIGJ1ZmZlcnMuIEluIGFkZGl0aW9uLCB0aGVyZSBpcyBubyB3YXkgdG8NCj4gICAgDQo+
ICAgIFdoeSB3b3VsZCBpdCBuZWVkIHRvIHJldHVybiB0aGVtPyBUaGUgaW5kaWNlcyBhcmUgdGhl
IGluZGV4IGludG8gdGhlDQo+ICAgIGFycmF5IHlvdSBwYXNzZWQgaW4gZm9yIHJlZ2lzdHJhdGlv
bi4NCg0KQWggdGhpcyBpcyB0aGUgcGFydCBJIHdhcyBtaXNzaW5nLiBJIGRpZCBub3Qga25vdyB3
ZSBjb3VsZCBiZSBhc3N1cmVkIHRoZSBpbmRpY2VzIHBhc3NlZCBiYWNrIHdlcmUgaWRlbnRpY2Fs
IHRvIHRob3NlIHBhc3NlZCBpbi4NCg0KPiBGaW8gdXNlcyB0aGVtLCBhcyBkb2VzIHQvaW9fdXJp
bmcgZnJvbSBmaW8uIEkndmUgZG9uZSBsb3RzIG9mIHRlc3RpbmcNCj4gICAgd2l0aCByZWdpc3Rl
cmVkIGJ1ZmZlcnMsIGFsbCB0aGUgcGVyZm9ybWFuY2UgbnVtYmVycyBkb25lIHdlcmUgd2l0aCB0
aGF0DQo+ICAgIGVuYWJsZWQgKHVubGVzcyBvdGhlcndpc2Ugbm90ZWQpLg0KPiAgICANCj4gICAg
QnV0IHllcywgYSB0ZXN0IGNhc2UgaXMgYWx3YXlzIGEgZ3JlYXQgaWRlYSENCg0KQ29vbC4gSSB3
aWxsIGdvIGxvb2sgYXQgd2hhdCB0aGUgdGVzdCBpbiBmaW8gZG9lcyBhbmQgc2VlIGlmIGEgdGVz
dGNhc2UgaW4gbGlidXJpbmcgbWFrZXMgc2Vuc2UuDQoNCkNoZWVycw0KDQpTdGVwaGVuICAgIA0K
DQo=
