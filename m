Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEB3C4646C
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 02:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A8E20644
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 02:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbfFYCaK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 22:30:10 -0400
Received: from mail4.tencent.com ([183.57.53.109]:42768 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfFYCaK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 22:30:10 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2019 22:30:08 EDT
Received: from EXHUB-SZMAIL04.tencent.com (unknown [10.14.6.35])
        by mail4.tencent.com (Postfix) with ESMTP id BD2515032A;
        Tue, 25 Jun 2019 10:21:48 +0800 (CST)
Received: from EX-SZ012.tencent.com (10.28.6.36) by EXHUB-SZMAIL04.tencent.com
 (10.14.6.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 25 Jun 2019
 10:21:48 +0800
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ012.tencent.com
 (10.28.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 25 Jun
 2019 10:21:47 +0800
Received: from EX-SZ005.tencent.com ([fe80::80ab:5a24:b62e:8246]) by
 EX-SZ005.tencent.com ([fe80::80ab:5a24:b62e:8246%4]) with mapi id
 15.01.1713.004; Tue, 25 Jun 2019 10:21:47 +0800
From:   =?utf-8?B?d2VuYmluemVuZyjmm77mlofmlowp?= <wenbinzeng@tencent.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        Wenbin Zeng <wenbin.zeng@gmail.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "hare@suse.com" <hare@suse.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] blk-mq: update hctx->cpumask at cpu-hotplug(Internet
 mail)
Thread-Topic: [PATCH] blk-mq: update hctx->cpumask at cpu-hotplug(Internet
 mail)
Thread-Index: AQHVKqDurKLV/sXBPUypS6FtYdqWkaarD7cAgACLCoA=
Date:   Tue, 25 Jun 2019 02:21:47 +0000
Message-ID: <2421555d500d4efcad07956eead119cc@tencent.com>
References: <1561389847-30853-1-git-send-email-wenbinzeng@tencent.com>
 <d69e96cf-8f58-3b2a-d8d4-7b77589aefbd@oracle.com>
In-Reply-To: <d69e96cf-8f58-3b2a-d8d4-7b77589aefbd@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.14.87.251]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkgRG9uZ2xpLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERvbmds
aSBaaGFuZyA8ZG9uZ2xpLnpoYW5nQG9yYWNsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUg
MjUsIDIwMTkgOTozMCBBTQ0KPiBUbzogV2VuYmluIFplbmcgPHdlbmJpbi56ZW5nQGdtYWlsLmNv
bT4NCj4gQ2M6IGF4Ym9lQGtlcm5lbC5kazsga2VpdGguYnVzY2hAaW50ZWwuY29tOyBoYXJlQHN1
c2UuY29tOyBtaW5nLmxlaUByZWRoYXQuY29tOw0KPiBvc2FuZG92QGZiLmNvbTsgc2FnaUBncmlt
YmVyZy5tZTsgYnZhbmFzc2NoZUBhY20ub3JnOw0KPiBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHdlbmJpbnplbmco5pu+5paH5paMKQ0K
PiA8d2VuYmluemVuZ0B0ZW5jZW50LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYmxrLW1x
OiB1cGRhdGUgaGN0eC0+Y3B1bWFzayBhdCBjcHUtaG90cGx1ZyhJbnRlcm5ldCBtYWlsKQ0KPiAN
Cj4gSGkgV2VuYmluLA0KPiANCj4gT24gNi8yNC8xOSAxMToyNCBQTSwgV2VuYmluIFplbmcgd3Jv
dGU6DQo+ID4gQ3VycmVudGx5IGhjdHgtPmNwdW1hc2sgaXMgbm90IHVwZGF0ZWQgd2hlbiBob3Qt
cGx1Z2dpbmcgbmV3IGNwdXMsDQo+ID4gYXMgdGhlcmUgYXJlIG1hbnkgY2hhbmNlcyBrYmxvY2tk
X21vZF9kZWxheWVkX3dvcmtfb24oKSBnZXR0aW5nDQo+ID4gY2FsbGVkIHdpdGggV09SS19DUFVf
VU5CT1VORCwgd29ya3F1ZXVlIGJsa19tcV9ydW5fd29ya19mbiBtYXkgcnVuDQo+ID4gb24gdGhl
IG5ld2x5LXBsdWdnZWQgY3B1cywgY29uc2VxdWVudGx5IF9fYmxrX21xX3J1bl9od19xdWV1ZSgp
DQo+ID4gcmVwb3J0aW5nIGV4Y2Vzc2l2ZSAicnVuIHF1ZXVlIGZyb20gd3JvbmcgQ1BVIiBtZXNz
YWdlcyBiZWNhdXNlDQo+ID4gY3B1bWFza190ZXN0X2NwdShyYXdfc21wX3Byb2Nlc3Nvcl9pZCgp
LCBoY3R4LT5jcHVtYXNrKSByZXR1cm5zIGZhbHNlLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRl
ZCBhIGNwdS1ob3RwbHVnIGhhbmRsZXIgaW50byBibGstbXEsIHVwZGF0aW5nDQo+ID4gaGN0eC0+
Y3B1bWFzayBhdCBjcHUtaG90cGx1Zy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlbmJpbiBa
ZW5nIDx3ZW5iaW56ZW5nQHRlbmNlbnQuY29tPg0KPiA+IC0tLQ0KPiA+ICBibG9jay9ibGstbXEu
YyAgICAgICAgIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVk
ZS9saW51eC9ibGstbXEuaCB8ICAxICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLW1xLmMgYi9ibG9jay9ibGst
bXEuYw0KPiA+IGluZGV4IGNlMGY1ZjQuLjJlNDY1ZmMgMTAwNjQ0DQo+ID4gLS0tIGEvYmxvY2sv
YmxrLW1xLmMNCj4gPiArKysgYi9ibG9jay9ibGstbXEuYw0KPiA+IEBAIC0zOSw2ICszOSw4IEBA
DQo+ID4gICNpbmNsdWRlICJibGstbXEtc2NoZWQuaCINCj4gPiAgI2luY2x1ZGUgImJsay1ycS1x
b3MuaCINCj4gPg0KPiA+ICtzdGF0aWMgZW51bSBjcHVocF9zdGF0ZSBjcHVocF9ibGtfbXFfb25s
aW5lOw0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgYmxrX21xX3BvbGxfc3RhdHNfc3RhcnQoc3Ry
dWN0IHJlcXVlc3RfcXVldWUgKnEpOw0KPiA+ICBzdGF0aWMgdm9pZCBibGtfbXFfcG9sbF9zdGF0
c19mbihzdHJ1Y3QgYmxrX3N0YXRfY2FsbGJhY2sgKmNiKTsNCj4gPg0KPiA+IEBAIC0yMjE1LDYg
KzIyMTcsMjEgQEAgaW50IGJsa19tcV9hbGxvY19ycXMoc3RydWN0IGJsa19tcV90YWdfc2V0ICpz
ZXQsIHN0cnVjdA0KPiBibGtfbXFfdGFncyAqdGFncywNCj4gPiAgCXJldHVybiAtRU5PTUVNOw0K
PiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBibGtfbXFfaGN0eF9ub3RpZnlfb25saW5lKHVu
c2lnbmVkIGludCBjcHUsIHN0cnVjdCBobGlzdF9ub2RlICpub2RlKQ0KPiA+ICt7DQo+ID4gKwlz
dHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eDsNCj4gPiArDQo+ID4gKwloY3R4ID0gaGxpc3RfZW50
cnlfc2FmZShub2RlLCBzdHJ1Y3QgYmxrX21xX2h3X2N0eCwgY3B1aHBfb25saW5lKTsNCj4gPiAr
DQo+ID4gKwlpZiAoIWNwdW1hc2tfdGVzdF9jcHUoY3B1LCBoY3R4LT5jcHVtYXNrKSkgew0KPiA+
ICsJCW11dGV4X2xvY2soJmhjdHgtPnF1ZXVlLT5zeXNmc19sb2NrKTsNCj4gPiArCQljcHVtYXNr
X3NldF9jcHUoY3B1LCBoY3R4LT5jcHVtYXNrKTsNCj4gPiArCQltdXRleF91bmxvY2soJmhjdHgt
PnF1ZXVlLT5zeXNmc19sb2NrKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4g
PiArfQ0KPiA+ICsNCj4gDQo+IEFzIHRoaXMgY2FsbGJhY2sgaXMgcmVnaXN0ZXJlZCBmb3IgZWFj
aCBoY3R4LCB3aGVuIGEgY3B1IGlzIG9ubGluZSwgaXQgaXMgY2FsbGVkDQo+IGZvciBlYWNoIGhj
dHguDQo+IA0KPiBKdXN0IHRha2luZyBhIDQtcXVldWUgbnZtZSBhcyBleGFtcGxlIChyZWdhcmRs
ZXNzIGFib3V0IG90aGVyIGJsb2NrIGxpa2UgbG9vcCkuDQo+IFN1cHBvc2UgY3B1PTIgKG91dCBv
ZiAwLCAxLCAyIGFuZCAzKSBpcyBvZmZsaW5lLiBXaGVuIHdlIG9ubGluZSBjcHU9MiwNCj4gDQo+
IGJsa19tcV9oY3R4X25vdGlmeV9vbmxpbmUoKSBjYWxsZWQ6IGNwdT0yIGFuZCBibGtfbXFfaHdf
Y3R4LT5xdWV1ZV9udW09Mw0KPiBibGtfbXFfaGN0eF9ub3RpZnlfb25saW5lKCkgY2FsbGVkOiBj
cHU9MiBhbmQgYmxrX21xX2h3X2N0eC0+cXVldWVfbnVtPTINCj4gYmxrX21xX2hjdHhfbm90aWZ5
X29ubGluZSgpIGNhbGxlZDogY3B1PTIgYW5kIGJsa19tcV9od19jdHgtPnF1ZXVlX251bT0xDQo+
IGJsa19tcV9oY3R4X25vdGlmeV9vbmxpbmUoKSBjYWxsZWQ6IGNwdT0yIGFuZCBibGtfbXFfaHdf
Y3R4LT5xdWV1ZV9udW09MA0KPiANCj4gVGhlcmUgaXMgbm8gbmVlZCB0byBzZXQgY3B1IDIgZm9y
IGJsa19tcV9od19jdHgtPnF1ZXVlX251bT1bMywgMSwgMF0uIEkgYW0NCj4gYWZyYWlkIHRoaXMg
cGF0Y2ggd291bGQgZXJyb25lb3VzbHkgc2V0IGNwdW1hc2sgZm9yIGJsa19tcV9od19jdHgtPnF1
ZXVlX251bT1bMywNCj4gMSwgMF0uDQo+IA0KPiBJIHVzZWQgdG8gc3VibWl0IHRoZSBiZWxvdyBw
YXRjaCBleHBsYWluaW5nIGFib3ZlIGZvciByZW1vdmluZyBhIGNwdSBhbmQgaXQgaXMNCj4gdW5m
b3J0dW5hdGVseSBub3QgbWVyZ2VkIHlldC4NCj4gDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcGF0Y2gvMTA4ODkzMDcvDQo+IA0KPiANCj4gQW5vdGhlciB0aGluZyBpcyBkdXJpbmcg
aW5pdGlhbGl6YXRpb24sIHRoZSBoY3R4LT5jcHVtYXNrIHNob3VsZCBhbHJlYWR5IGJlZW4NCj4g
c2V0IGFuZCBldmVuIHRoZSBjcHUgaXMgb2ZmbGluZS4gV291bGQgeW91IHBsZWFzZSBleHBsYWlu
IHRoZSBjYXNlIGhjdHgtPmNwdW1hc2sNCj4gaXMgbm90IHNldCBjb3JyZWN0bHksIGUuZy4sIGhv
dyB0byByZXByb2R1Y2Ugd2l0aCBhIGt2bSBndWVzdCBydW5uaW5nDQo+IHNjc2kvdmlydGlvL252
bWUvbG9vcD8NCg0KTXkgc2NlbmFyaW8gaXM6DQpBIGt2bSBndWVzdCBzdGFydGVkIHdpdGggc2lu
Z2xlIGNwdSwgZHVyaW5nIGluaXRpYWxpemF0aW9uIG9ubHkgb25lIGNwdSB3YXMgdmlzaWJsZSBi
eSBrZXJuZWwuDQpBZnRlciBib290LCBJIGhvdC1hZGQgc29tZSBjcHVzIHZpYSBxZW11IG1vbml0
b3IgKEkgYmVsaWV2ZSB2aXJzaCBzZXR2Y3B1cyAtLWxpdmUgY2FuIGRvIHRoZSBzYW1lIHRoaW5n
KSwgZm9yIGV4YW1wbGU6DQoocWVtdSkgY3B1LWFkZCAxDQoocWVtdSkgY3B1LWFkZCAyDQoocWVt
dSkgY3B1LWFkZCAzDQoNCkluIHN1Y2ggc2NlbmFyaW8sIGhjdHgtPmNwdW1hc2sgZG9lc24ndCBn
ZXQgdXBkYXRlZCB3aGVuIHRoZXNlIGNwdXMgYXJlIGFkZGVkLg0KDQo+IA0KPiBEb25nbGkgWmhh
bmcNCg0K
