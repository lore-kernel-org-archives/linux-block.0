Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCA9C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 19:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83A22086A
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 19:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DoCNTIKJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P1JLAJsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83A22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeKTFgx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:36:53 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24403 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeKTFgx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 00:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542654716; x=1574190716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dIpf06GrqUQYfCxQfd3HIdWwmTf6z1jFRIe2eQaTRaU=;
  b=DoCNTIKJPaNK/5/M2Oxi9H0BNAlAERkfefv7pERREqXR2wOEM+C/i/W4
   r+MeYxARl4RLCG1es+VlhtwcRQHL7ayZWfaEH4g4yWWip9jknnFVUQjQd
   KdpBJSZhcohCjnfCKj15beRmA/L6Uw5+AEAJ57f88rgd01YFHK0sTivJC
   SxZ3bHbYYDuZRu8Psdjof9Q1Ti6sDshp3LoK4ILKhc0yYjuAZf/UkndMq
   TgkS5gwj9fKG8NZH1Fq5HTnQrTKl70y1A6kiMIJd93R7OKdsvvdZ397vN
   nECf4QdBmOKbEy29BBQt4rXN8DR5xQZgjP6otHVwyQnhxvN6YxF71Ps7t
   A==;
X-IronPort-AV: E=Sophos;i="5.56,253,1539619200"; 
   d="scan'208";a="95791092"
Received: from mail-by2nam01lp0181.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([216.32.181.181])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 03:11:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIpf06GrqUQYfCxQfd3HIdWwmTf6z1jFRIe2eQaTRaU=;
 b=P1JLAJszb6HTHh4k6CixXNVgyrSXdQjAFUqdZt3jMHqsjREApm4ALld9l6SWr5Q8KKqR36v8tG4J9Y/XSuIQ1dlMLZtwrG7Inadb8E7qprf2nSUZiyublSIBpEA3cJH2NLu/r1TzMtZQKFRGPJJ0OK/KXBf0zb8Ely6/nq8I0Ic=
Received: from BYAPR04MB4357.namprd04.prod.outlook.com (20.176.251.147) by
 BYAPR04MB4950.namprd04.prod.outlook.com (52.135.232.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 19 Nov 2018 19:11:53 +0000
Received: from BYAPR04MB4357.namprd04.prod.outlook.com
 ([fe80::6dba:5dd:bbae:474b]) by BYAPR04MB4357.namprd04.prod.outlook.com
 ([fe80::6dba:5dd:bbae:474b%3]) with mapi id 15.20.1294.048; Mon, 19 Nov 2018
 19:11:53 +0000
From:   Adam Manzanares <Adam.Manzanares@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 7/7] block: Initialize BIO I/O priority early
Thread-Topic: [PATCH 7/7] block: Initialize BIO I/O priority early
Thread-Index: AQHUf7s2D79rFV1Ef0aMRSvKDKEjR6VXd/wA
Date:   Mon, 19 Nov 2018 19:11:53 +0000
Message-ID: <d0ea8395e43bd634a9001d9cf96bc807cdb688d7.camel@wdc.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
         <20181119035131.11255-8-damien.lemoal@wdc.com>
In-Reply-To: <20181119035131.11255-8-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4950;6:sfpdFdLYB7Xk3AnhOdqzP4CyvaD+23RWEJoY7xt3RGH1isWqijz6fBeZgDXsqqzqRvfMDHwXC9XXJdPFJLzL24y3soLc4xKfY2vrYuDL4JrkUWHU7yR5I7TYVxcLm3yzLcw5OER/qj79rZfek/4NUIWQbvQAodQHM0BkJnJfFB0JsqBw9U26jVY48qDKrvzlpSneksZylpYvVdA9qGbHdrOyKudqHBVAjtflb6HzxZeW6WjQbx7rXyfLPNmDKTR2rIVUX6HhJXi6dW0BBr8/hPLru5Vjbk7+5E8Z0CBludmOGIdOm8W0EhmcELTSK2UTUG8R8BbHD1LpXVtXiCgVwow9ze6MX6dmX9XdWLVcq3KXKNzA1M3ajYYKJcupEn7MQiKDm/HoG2bkxIgyazJ+EXwDaM01SzZMSyA0qoJ4Ci5djgonqUxR9lyGvqxg5lxtx/ostBEU57Gv7k3V9UdXSQ==;5:NmUvF03qUNoCe+qZznQ6gTCV6Ruulm7or6Y+eLqUW5N7LX6DRlJPi9SPy5RUL5ItVXMsnzsghccGOhdd/akEi34P2QYthIR4LqK7ADGg4IfeqUDOlxArBHHd3B00C6AJza0JD3MQPH4oE7MMxC9xLBxs7M+OG1riirk3O8Bev0I=;7:w0gCg6XmUTt4Kfx4R0vrDXlin8lfLPOZ6y35FSLrRsDRzLADlKY5EvQbuw0+8oWfO72swRQmDekdC0uXuxB9f4U3FJ52mThY9lk1F9K5BFA8iujt524u+EZ3WJrzxGt8oRpSaEoQVUAgYC9bzj+qXQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 0d3ea726-32a4-40a4-3a03-08d64e52dde9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4950;
x-ms-traffictypediagnostic: BYAPR04MB4950:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB49507D4193E0708EDB637573F0D80@BYAPR04MB4950.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR04MB4950;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB4950;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(39860400002)(396003)(199004)(189003)(6436002)(105586002)(5660300001)(106356001)(316002)(8936002)(486006)(6116002)(3846002)(118296001)(2616005)(476003)(446003)(86362001)(11346002)(72206003)(71190400001)(71200400001)(54906003)(110136005)(53936002)(229853002)(478600001)(2501003)(26005)(14454004)(25786009)(305945005)(186003)(97736004)(76176011)(8676002)(2906002)(4326008)(6486002)(66066001)(81166006)(14444005)(256004)(6512007)(81156014)(102836004)(99286004)(4001150100001)(68736007)(2900100001)(6506007)(36756003)(7736002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4950;H:BYAPR04MB4357.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: yIeI8RtReY0mZJyyPJigKk+qMozXHsJgk11sig4iM69til88LhwJEfMupVZDQLeciVWUeeydNjcuenzzFWre89047fUOF48iXGoD8K6IC6v41mE/ec8L8o0XIc/fJvc3uzz7TnUlZs4z/WIPfxQK11ZvHTfYx3VB1BmA4XPum2x7PD3hbs6ndzOFaAxeJzN5/8uoQHBr4kAA0x5nPbhpkHTIfwTUhDXHaJX6rlYbF+fu+zX6D7h/RG+lNsOwpNw7xRPNlGrovH0eBUprDP/8lj406mRbnCVCHS0kuxFN8vnu2R3PjyWOywt2RvBpJ0FrG493MHqVK8buFnCvKlKm9STAoVCjGLWgsHj0pWO+esY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B7675B0B91DCD48863AC25D2EFF4FFE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3ea726-32a4-40a4-3a03-08d64e52dde9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 19:11:53.6307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4950
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTE5IGF0IDEyOjUxICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToN
Cj4gRm9yIHRoZSBzeW5jaHJvbm91cyBJL08gcGF0aCBjYXNlIChyZWFkKCksIHdyaXRlKCkgZXRj
IHN5c3RlbSBjYWxscyksDQo+IGENCj4gQklPIEkvTyBwcmlvcml0eSBpcyBub3QgaW5pdGlhbGl6
ZWQgdW50aWwgdGhlIGV4ZWN1dGlvbiBvZg0KPiBibGtfaW5pdF9yZXF1ZXN0X2Zyb21fYmlvKCkg
d2hlbiB0aGUgQklPIGlzIHN1Ym1pdHRlZCBhbmQgYSByZXF1ZXN0DQo+IGluaXRpYWxpemVkIGZv
ciB0aGUgQklPIGV4ZWN1dGlvbi4gVGhpcyBpcyBkdWUgdG8gdGhlIGtpX2lvcHJpbyBmaWVsZA0K
PiBvZg0KPiB0aGUgc3RydWN0IGtpb2NiIGRlZmluZWQgb24gc3RhY2sgYmVpbmcgYWx3YXlzIGlu
aXRpYWxpemVkIHRvDQo+IElPUFJJT19DTEFTU19OT05FLCByZWdhcmRsZXNzIG9mIHRoZSBjYWxs
aW5nIHByb2Nlc3MgSS9PIGNvbnRleHQNCj4gaW9wcmlvDQo+IHZhbHVlIHNldCB3aXRoIGlvcHJp
b19zZXQoKS4gVGhpcyBsYXRlIGluaXRpYWxpemF0aW9uIGNhbiByZXN1bHQgaW4NCj4gdGhlDQo+
IEJJTyBiZWluZyBtZXJnZWQgdG8gcGVuZGluZyByZXF1ZXN0cyBldmVuIHdoZW4gdGhlIEkvTyBw
cmlvcml0aWVzDQo+IGRpZmZlci4NCj4gDQo+IEZpeCB0aGlzIGJ5IGluaXRpYWxpemluZyB0aGUg
a2lfaW9wcmlvcml0eSBmaWVsZCBvZiBvbiBzdGFjayBzdHJ1Y3QNCj4ga2lvY2IgdXNpbmcgdGhl
IGdldF9jdXJyZW50X2lvcHJpbygpIGhlbHBlciwgZW5zdXJpbmcgdGhhdCBhbGwgQklPcw0KPiBh
bGxvY2F0ZWQgYW5kIHN1Ym1pdHRlZCBmb3IgdGhlIHN5c3RlbSBjYWxsIGV4ZWN1dGlvbiBzZWUg
dGhlIGNvcnJlY3QNCj4gaW50ZW5kZWQgSS9PIHByaW9yaXR5IGVhcmx5LiBXaXRoIHRoaXMsIHNp
bmNlIGEgQklPIEkvTyBwcmlvcml0eSBpcw0KPiBhbHdheXMgc2V0IHRvIHRoZSBpbnRlbmRlZCBl
ZmZlY3RpdmUgdmFsdWUgZm9yIGJvdGggdGhlIHN5bmMgYW5kDQo+IGFzeW5jDQo+IHBhdGgsIGJs
a19pbml0X3JlcXVlc3RfZnJvbV9iaW8oKSBjYW4gYmUgc2ltcGxpZmllZC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQHdkYy5jb20+DQoNCk5pY2Ug
Y2xlYW51cCwgbG9va3MgZ29vZC4gVGhhbmtzIERhbWllbi4NCg0KUmV2aWV3ZWQtYnk6IEFkYW0g
TWFuemFuYXJlcyA8YWRhbS5tYW56YW5hcmVzQHdkYy5jb20+DQoNCg0KPiAtLS0NCj4gIGJsb2Nr
L2Jsay1jb3JlLmMgICB8IDUgKy0tLS0NCj4gIGluY2x1ZGUvbGludXgvZnMuaCB8IDIgKy0NCj4g
IDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1jb3JlLmMgYi9ibG9jay9ibGstY29yZS5jDQo+IGluZGV4
IGRkZTMwYjA4YWExNC4uMDRmNWJlNDczNjM4IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9ibGstY29y
ZS5jDQo+ICsrKyBiL2Jsb2NrL2Jsay1jb3JlLmMNCj4gQEAgLTgxNCwxMCArODE0LDcgQEAgdm9p
ZCBibGtfaW5pdF9yZXF1ZXN0X2Zyb21fYmlvKHN0cnVjdCByZXF1ZXN0DQo+ICpyZXEsIHN0cnVj
dCBiaW8gKmJpbykNCj4gIAkJcmVxLT5jbWRfZmxhZ3MgfD0gUkVRX0ZBSUxGQVNUX01BU0s7DQo+
ICANCj4gIAlyZXEtPl9fc2VjdG9yID0gYmlvLT5iaV9pdGVyLmJpX3NlY3RvcjsNCj4gLQlpZiAo
aW9wcmlvX3ZhbGlkKGJpb19wcmlvKGJpbykpKQ0KPiAtCQlyZXEtPmlvcHJpbyA9IGJpb19wcmlv
KGJpbyk7DQo+IC0JZWxzZQ0KPiAtCQlyZXEtPmlvcHJpbyA9IGdldF9jdXJyZW50X2lvcHJpbygp
Ow0KPiArCXJlcS0+aW9wcmlvID0gYmlvX3ByaW8oYmlvKTsNCj4gIAlyZXEtPndyaXRlX2hpbnQg
PSBiaW8tPmJpX3dyaXRlX2hpbnQ7DQo+ICAJYmxrX3JxX2Jpb19wcmVwKHJlcS0+cSwgcmVxLCBi
aW8pOw0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mcy5oIGIvaW5jbHVkZS9s
aW51eC9mcy5oDQo+IGluZGV4IGM5NWMwODA3NDcxZi4uYTFhYjIzM2U2NDY5IDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9mcy5oDQo+IEBA
IC0yMDIxLDcgKzIwMjEsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaW5pdF9zeW5jX2tpb2NiKHN0
cnVjdCBraW9jYg0KPiAqa2lvY2IsIHN0cnVjdCBmaWxlICpmaWxwKQ0KPiAgCQkua2lfZmlscCA9
IGZpbHAsDQo+ICAJCS5raV9mbGFncyA9IGlvY2JfZmxhZ3MoZmlscCksDQo+ICAJCS5raV9oaW50
ID0ga2lfaGludF92YWxpZGF0ZShmaWxlX3dyaXRlX2hpbnQoZmlscCkpLA0KPiAtCQkua2lfaW9w
cmlvID0gSU9QUklPX1BSSU9fVkFMVUUoSU9QUklPX0NMQVNTX05PTkUsIDApLA0KPiArCQkua2lf
aW9wcmlvID0gZ2V0X2N1cnJlbnRfaW9wcmlvKCksDQo+ICAJfTsNCj4gIH0NCj4gIA0K
