Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19368C432C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 16:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7EA20721
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 16:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKVQ2I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:28:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:2323 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVQ2I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 11:28:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 08:28:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="201569537"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2019 08:28:05 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.229]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.246]) with mapi id 14.03.0439.000;
 Fri, 22 Nov 2019 08:28:07 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "Rajashekar, Revanth" <revanth.rajashekar@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>
Subject: Re: [PATCH] block: sed-opal: Cleanup trivial patch
Thread-Topic: [PATCH] block: sed-opal: Cleanup trivial patch
Thread-Index: AQHVoVCoF6jc+E42tkSeJY1BEYKM76eX5x2A
Date:   Fri, 22 Nov 2019 16:28:06 +0000
Message-ID: <45c05efa3fb1947de41a47f6cb6fc043fa904f65.camel@intel.com>
References: <20191122161854.70939-1-revanth.rajashekar@intel.com>
In-Reply-To: <20191122161854.70939-1-revanth.rajashekar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.147]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCDFBD3858463A42A1486452B35D76C9@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

QWNrZWQtYnk6IEpvbiBEZXJyaWNrIDxqb25hdGhhbi5kZXJyaWNrQGludGVsLmNvbT4NCg0KT24g
RnJpLCAyMDE5LTExLTIyIGF0IDA5OjE4IC0wNzAwLCBSZXZhbnRoIFJhamFzaGVrYXIgd3JvdGU6
DQo+IFRoaXMgcGF0Y2ggYWltcyBhdCBsaW5lIGxlbmd0aCBhbmQgdHJpdmlhbCBjbGVhbnVwcyBm
b3INCj4gc2VkLW9wYWwgY29kZSByZXBvcnRlZCBieSBjaGVja3BhdGNoIHNjcmlwdC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFJldmFudGggUmFqYXNoZWthciA8cmV2YW50aC5yYWphc2hla2FyQGlu
dGVsLmNvbT4NCj4gLS0tDQo+ICBibG9jay9vcGFsX3Byb3RvLmggfCAgMiArLQ0KPiAgYmxvY2sv
c2VkLW9wYWwuYyAgIHwgMjMgKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hh
bmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYmxvY2svb3BhbF9wcm90by5oIGIvYmxvY2svb3BhbF9wcm90by5oDQo+IGluZGV4IDMyNWNi
YmEyNDY1Zi4uNmI3NTAxOGRkNGIzIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9vcGFsX3Byb3RvLmgN
Cj4gKysrIGIvYmxvY2svb3BhbF9wcm90by5oDQo+IEBAIC00MDQsNyArNDA0LDcgQEAgc3RydWN0
IGQwX3NpbmdsZV91c2VyX21vZGUgew0KPiAgfTsNCj4gIA0KPiAgLyoNCj4gLSAqIEFkZGl0b25h
bCBEYXRhc3RvcmVzIGZlYXR1cmUNCj4gKyAqIEFkZGl0aW9uYWwgRGF0YXN0b3JlcyBmZWF0dXJl
DQo+ICAgKg0KPiAgICogY29kZSA9PSAweDAyMDINCj4gICAqLw0KPiBkaWZmIC0tZ2l0IGEvYmxv
Y2svc2VkLW9wYWwuYyBiL2Jsb2NrL3NlZC1vcGFsLmMNCj4gaW5kZXggODgwY2M1N2E1ZjZiLi44
ZGE4ZWY4NjZmMzYgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL3NlZC1vcGFsLmMNCj4gKysrIGIvYmxv
Y2svc2VkLW9wYWwuYw0KPiBAQCAtMTQyLDkgKzE0Miw5IEBAIHN0YXRpYyBjb25zdCB1OCBvcGFs
dWlkW11bT1BBTF9VSURfTEVOR1RIXSA9IHsNCj4gIAlbT1BBTF9NQlJdID0NCj4gIAkJeyAweDAw
LCAweDAwLCAweDA4LCAweDA0LCAweDAwLCAweDAwLCAweDAwLCAweDAwIH0sDQo+ICAJW09QQUxf
QVVUSE9SSVRZX1RBQkxFXSA9DQo+IC0JCXsgMHgwMCwgMHgwMCwgMHgwMCwgMHgwOSwgMHgwMCwg
MHgwMCwgMHgwMCwgMHgwMH0sDQo+ICsJCXsgMHgwMCwgMHgwMCwgMHgwMCwgMHgwOSwgMHgwMCwg
MHgwMCwgMHgwMCwgMHgwMCB9LA0KPiAgCVtPUEFMX0NfUElOX1RBQkxFXSA9DQo+IC0JCXsgMHgw
MCwgMHgwMCwgMHgwMCwgMHgwQiwgMHgwMCwgMHgwMCwgMHgwMCwgMHgwMH0sDQo+ICsJCXsgMHgw
MCwgMHgwMCwgMHgwMCwgMHgwQiwgMHgwMCwgMHgwMCwgMHgwMCwgMHgwMCB9LA0KPiAgCVtPUEFM
X0xPQ0tJTkdfSU5GT19UQUJMRV0gPQ0KPiAgCQl7IDB4MDAsIDB4MDAsIDB4MDgsIDB4MDEsIDB4
MDAsIDB4MDAsIDB4MDAsIDB4MDEgfSwNCj4gIAlbT1BBTF9FTlRFUlBSSVNFX0xPQ0tJTkdfSU5G
T19UQUJMRV0gPQ0KPiBAQCAtMTU0LDExICsxNTQsMTEgQEAgc3RhdGljIGNvbnN0IHU4IG9wYWx1
aWRbXVtPUEFMX1VJRF9MRU5HVEhdID0gew0KPiAgDQo+ICAJLyogQ19QSU5fVEFCTEUgb2JqZWN0
IElEJ3MgKi8NCj4gIAlbT1BBTF9DX1BJTl9NU0lEXSA9DQo+IC0JCXsgMHgwMCwgMHgwMCwgMHgw
MCwgMHgwQiwgMHgwMCwgMHgwMCwgMHg4NCwgMHgwMn0sDQo+ICsJCXsgMHgwMCwgMHgwMCwgMHgw
MCwgMHgwQiwgMHgwMCwgMHgwMCwgMHg4NCwgMHgwMiB9LA0KPiAgCVtPUEFMX0NfUElOX1NJRF0g
PQ0KPiAtCQl7IDB4MDAsIDB4MDAsIDB4MDAsIDB4MEIsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDF9
LA0KPiArCQl7IDB4MDAsIDB4MDAsIDB4MDAsIDB4MEIsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDEg
fSwNCj4gIAlbT1BBTF9DX1BJTl9BRE1JTjFdID0NCj4gLQkJeyAweDAwLCAweDAwLCAweDAwLCAw
eDBCLCAweDAwLCAweDAxLCAweDAwLCAweDAxfSwNCj4gKwkJeyAweDAwLCAweDAwLCAweDAwLCAw
eDBCLCAweDAwLCAweDAxLCAweDAwLCAweDAxIH0sDQo+ICANCj4gIAkvKiBoYWxmIFVJRCdzIChv
bmx5IGZpcnN0IDQgYnl0ZXMgdXNlZCkgKi8NCj4gIAlbT1BBTF9IQUxGX1VJRF9BVVRIT1JJVFlf
T0JKX1JFRl0gPQ0KPiBAQCAtMTY4LDcgKzE2OCw3IEBAIHN0YXRpYyBjb25zdCB1OCBvcGFsdWlk
W11bT1BBTF9VSURfTEVOR1RIXSA9IHsNCj4gIA0KPiAgCS8qIHNwZWNpYWwgdmFsdWUgZm9yIG9t
aXR0ZWQgb3B0aW9uYWwgcGFyYW1ldGVyICovDQo+ICAJW09QQUxfVUlEX0hFWEZGXSA9DQo+IC0J
CXsgMHhmZiwgMHhmZiwgMHhmZiwgMHhmZiwgMHhmZiwgMHhmZiwgMHhmZiwgMHhmZn0sDQo+ICsJ
CXsgMHhmZiwgMHhmZiwgMHhmZiwgMHhmZiwgMHhmZiwgMHhmZiwgMHhmZiwgMHhmZiB9LA0KPiAg
fTsNCj4gIA0KPiAgLyoNCj4gQEAgLTE5MDQsNyArMTkwNCw4IEBAIHN0YXRpYyBpbnQgYWN0aXZh
dGVfbHNwKHN0cnVjdCBvcGFsX2RldiAqZGV2LCB2b2lkICpkYXRhKQ0KPiAgCQlhZGRfdG9rZW5f
Ynl0ZXN0cmluZygmZXJyLCBkZXYsIHVzZXJfbHIsIE9QQUxfVUlEX0xFTkdUSCk7DQo+ICAJCWZv
ciAoaSA9IDE7IGkgPCBvcGFsX2FjdC0+bnVtX2xyczsgaSsrKSB7DQo+ICAJCQl1c2VyX2xyWzdd
ID0gb3BhbF9hY3QtPmxyW2ldOw0KPiAtCQkJYWRkX3Rva2VuX2J5dGVzdHJpbmcoJmVyciwgZGV2
LCB1c2VyX2xyLCBPUEFMX1VJRF9MRU5HVEgpOw0KPiArCQkJYWRkX3Rva2VuX2J5dGVzdHJpbmco
JmVyciwgZGV2LCB1c2VyX2xyLA0KPiArCQkJCQkgICAgIE9QQUxfVUlEX0xFTkdUSCk7DQo+ICAJ
CX0NCj4gIAkJYWRkX3Rva2VuX3U4KCZlcnIsIGRldiwgT1BBTF9FTkRMSVNUKTsNCj4gIAkJYWRk
X3Rva2VuX3U4KCZlcnIsIGRldiwgT1BBTF9FTkROQU1FKTsNCj4gQEAgLTIxNjEsNyArMjE2Miw3
IEBAIHN0cnVjdCBvcGFsX2RldiAqaW5pdF9vcGFsX2Rldih2b2lkICpkYXRhLCBzZWNfc2VuZF9y
ZWN2ICpzZW5kX3JlY3YpDQo+ICBFWFBPUlRfU1lNQk9MKGluaXRfb3BhbF9kZXYpOw0KPiAgDQo+
ICBzdGF0aWMgaW50IG9wYWxfc2VjdXJlX2VyYXNlX2xvY2tpbmdfcmFuZ2Uoc3RydWN0IG9wYWxf
ZGV2ICpkZXYsDQo+IC0JCQkJCSAgIHN0cnVjdCBvcGFsX3Nlc3Npb25faW5mbyAqb3BhbF9zZXNz
aW9uKQ0KPiArCQkJCQlzdHJ1Y3Qgb3BhbF9zZXNzaW9uX2luZm8gKm9wYWxfc2Vzc2lvbikNCj4g
IHsNCj4gIAljb25zdCBzdHJ1Y3Qgb3BhbF9zdGVwIGVyYXNlX3N0ZXBzW10gPSB7DQo+ICAJCXsg
c3RhcnRfYXV0aF9vcGFsX3Nlc3Npb24sIG9wYWxfc2Vzc2lvbiB9LA0KPiBAQCAtMjMyNyw3ICsy
MzI4LDggQEAgc3RhdGljIGludCBvcGFsX2FkZF91c2VyX3RvX2xyKHN0cnVjdCBvcGFsX2RldiAq
ZGV2LA0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBpbnQgb3BhbF9yZXZl
cnR0cGVyKHN0cnVjdCBvcGFsX2RldiAqZGV2LCBzdHJ1Y3Qgb3BhbF9rZXkgKm9wYWwsIGJvb2wg
cHNpZCkNCj4gK3N0YXRpYyBpbnQgb3BhbF9yZXZlcnR0cGVyKHN0cnVjdCBvcGFsX2RldiAqZGV2
LCBzdHJ1Y3Qgb3BhbF9rZXkgKm9wYWwsDQo+ICsJCQkgICBib29sIHBzaWQpDQo+ICB7DQo+ICAJ
LyogY29udHJvbGxlciB3aWxsIHRlcm1pbmF0ZSBzZXNzaW9uICovDQo+ICAJY29uc3Qgc3RydWN0
IG9wYWxfc3RlcCByZXZlcnRfc3RlcHNbXSA9IHsNCj4gQEAgLTI1NDcsNyArMjU0OSw4IEBAIGJv
b2wgb3BhbF91bmxvY2tfZnJvbV9zdXNwZW5kKHN0cnVjdCBvcGFsX2RldiAqZGV2KQ0KPiAgCQl9
DQo+ICANCj4gIAkJaWYgKGRldi0+bWJyX2VuYWJsZWQpIHsNCj4gLQkJCXJldCA9IF9fb3BhbF9z
ZXRfbWJyX2RvbmUoZGV2LCAmc3VzcGVuZC0+dW5say5zZXNzaW9uLm9wYWxfa2V5KTsNCj4gKwkJ
CXJldCA9IF9fb3BhbF9zZXRfbWJyX2RvbmUoZGV2LA0KPiArCQkJCQkgICAgICAmc3VzcGVuZC0+
dW5say5zZXNzaW9uLm9wYWxfa2V5KTsNCj4gIAkJCWlmIChyZXQpDQo+ICAJCQkJcHJfZGVidWco
IkZhaWxlZCB0byBzZXQgTUJSIERvbmUgaW4gUzMgcmVzdW1lXG4iKTsNCj4gIAkJfQ0K
