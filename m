Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BE9C4646C
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 03:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2FD206DD
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 03:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFYD2j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 23:28:39 -0400
Received: from mail2.tencent.com ([163.177.67.195]:37401 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfFYD2i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 23:28:38 -0400
Received: from EXHUB-SZMAIL04.tencent.com (unknown [10.14.6.35])
        by mail2.tencent.com (Postfix) with ESMTP id CD15E8E75D;
        Tue, 25 Jun 2019 11:28:36 +0800 (CST)
Received: from EX-SZ006.tencent.com (10.28.6.30) by EXHUB-SZMAIL04.tencent.com
 (10.14.6.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 25 Jun 2019
 11:28:36 +0800
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ006.tencent.com
 (10.28.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 25 Jun
 2019 11:28:36 +0800
Received: from EX-SZ005.tencent.com ([fe80::80ab:5a24:b62e:8246]) by
 EX-SZ005.tencent.com ([fe80::80ab:5a24:b62e:8246%4]) with mapi id
 15.01.1713.004; Tue, 25 Jun 2019 11:28:36 +0800
From:   =?utf-8?B?d2VuYmluemVuZyjmm77mlofmlowp?= <wenbinzeng@tencent.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Wenbin Zeng <wenbin.zeng@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "hare@suse.com" <hare@suse.com>, "osandov@fb.com" <osandov@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] blk-mq: update hctx->cpumask at cpu-hotplug(Internet
 mail)
Thread-Topic: [PATCH] blk-mq: update hctx->cpumask at cpu-hotplug(Internet
 mail)
Thread-Index: AQHVKqDurKLV/sXBPUypS6FtYdqWkaarFq+AgACG9yD//4HzgIAAlnDw
Date:   Tue, 25 Jun 2019 03:28:36 +0000
Message-ID: <22a3941e6ddf468689918c1d15c035a8@tencent.com>
References: <1561389847-30853-1-git-send-email-wenbinzeng@tencent.com>
 <20190625015512.GC23777@ming.t460p>
 <fe4f40e7bbf74311a47c9f3b981f8c53@tencent.com>
 <20190625022706.GE23777@ming.t460p>
In-Reply-To: <20190625022706.GE23777@ming.t460p>
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

SGkgTWluZywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaW5nIExl
aSA8bWluZy5sZWlAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVuZSAyNSwgMjAxOSAx
MDoyNyBBTQ0KPiBUbzogd2VuYmluemVuZyjmm77mlofmlowpIDx3ZW5iaW56ZW5nQHRlbmNlbnQu
Y29tPg0KPiBDYzogV2VuYmluIFplbmcgPHdlbmJpbi56ZW5nQGdtYWlsLmNvbT47IGF4Ym9lQGtl
cm5lbC5kazsga2VpdGguYnVzY2hAaW50ZWwuY29tOw0KPiBoYXJlQHN1c2UuY29tOyBvc2FuZG92
QGZiLmNvbTsgc2FnaUBncmltYmVyZy5tZTsgYnZhbmFzc2NoZUBhY20ub3JnOw0KPiBsaW51eC1i
bG9ja0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gYmxrLW1xOiB1cGRhdGUgaGN0eC0+Y3B1bWFzayBhdCBjcHUtaG90
cGx1ZyhJbnRlcm5ldCBtYWlsKQ0KPiANCj4gT24gVHVlLCBKdW4gMjUsIDIwMTkgYXQgMDI6MTQ6
NDZBTSArMDAwMCwgd2VuYmluemVuZyjmm77mlofmlowpIHdyb3RlOg0KPiA+IEhpIE1pbmcsDQo+
ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBNaW5nIExl
aSA8bWluZy5sZWlAcmVkaGF0LmNvbT4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjUsIDIw
MTkgOTo1NSBBTQ0KPiA+ID4gVG86IFdlbmJpbiBaZW5nIDx3ZW5iaW4uemVuZ0BnbWFpbC5jb20+
DQo+ID4gPiBDYzogYXhib2VAa2VybmVsLmRrOyBrZWl0aC5idXNjaEBpbnRlbC5jb207IGhhcmVA
c3VzZS5jb207DQo+ID4gPiBvc2FuZG92QGZiLmNvbTsgc2FnaUBncmltYmVyZy5tZTsgYnZhbmFz
c2NoZUBhY20ub3JnOw0KPiA+ID4gbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gd2VuYmluemVuZyjmm77mlofmlowpIDx3ZW5i
aW56ZW5nQHRlbmNlbnQuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gYmxrLW1xOiB1
cGRhdGUgaGN0eC0+Y3B1bWFzayBhdA0KPiA+ID4gY3B1LWhvdHBsdWcoSW50ZXJuZXQgbWFpbCkN
Cj4gPiA+DQo+ID4gPiBPbiBNb24sIEp1biAyNCwgMjAxOSBhdCAxMToyNDowN1BNICswODAwLCBX
ZW5iaW4gWmVuZyB3cm90ZToNCj4gPiA+ID4gQ3VycmVudGx5IGhjdHgtPmNwdW1hc2sgaXMgbm90
IHVwZGF0ZWQgd2hlbiBob3QtcGx1Z2dpbmcgbmV3IGNwdXMsDQo+ID4gPiA+IGFzIHRoZXJlIGFy
ZSBtYW55IGNoYW5jZXMga2Jsb2NrZF9tb2RfZGVsYXllZF93b3JrX29uKCkgZ2V0dGluZw0KPiA+
ID4gPiBjYWxsZWQgd2l0aCBXT1JLX0NQVV9VTkJPVU5ELCB3b3JrcXVldWUgYmxrX21xX3J1bl93
b3JrX2ZuIG1heSBydW4NCj4gPiA+DQo+ID4gPiBUaGVyZSBhcmUgb25seSB0d28gY2FzZXMgaW4g
d2hpY2ggV09SS19DUFVfVU5CT1VORCBpcyBhcHBsaWVkOg0KPiA+ID4NCj4gPiA+IDEpIHNpbmds
ZSBodyBxdWV1ZQ0KPiA+ID4NCj4gPiA+IDIpIG11bHRpcGxlIGh3IHF1ZXVlLCBhbmQgYWxsIENQ
VXMgaW4gdGhpcyBoY3R4IGJlY29tZSBvZmZsaW5lDQo+ID4gPg0KPiA+ID4gRm9yIDEpLCBhbGwg
Q1BVcyBjYW4gYmUgZm91bmQgaW4gaGN0eC0+Y3B1bWFzay4NCj4gPiA+DQo+ID4gPiA+IG9uIHRo
ZSBuZXdseS1wbHVnZ2VkIGNwdXMsIGNvbnNlcXVlbnRseSBfX2Jsa19tcV9ydW5faHdfcXVldWUo
KQ0KPiA+ID4gPiByZXBvcnRpbmcgZXhjZXNzaXZlICJydW4gcXVldWUgZnJvbSB3cm9uZyBDUFUi
IG1lc3NhZ2VzIGJlY2F1c2UNCj4gPiA+ID4gY3B1bWFza190ZXN0X2NwdShyYXdfc21wX3Byb2Nl
c3Nvcl9pZCgpLCBoY3R4LT5jcHVtYXNrKSByZXR1cm5zIGZhbHNlLg0KPiA+ID4NCj4gPiA+IFRo
ZSBtZXNzYWdlIG1lYW5zIENQVSBob3RwbHVnIHJhY2UgaXMgdHJpZ2dlcmVkLg0KPiA+ID4NCj4g
PiA+IFllYWgsIHRoZXJlIGlzIGJpZyBwcm9ibGVtIGluIGJsa19tcV9oY3R4X25vdGlmeV9kZWFk
KCkgd2hpY2ggaXMNCj4gPiA+IGNhbGxlZCBhZnRlciBvbmUgQ1BVIGlzIGRlYWQsIGJ1dCBzdGls
bCBydW4gdGhpcyBodyBxdWV1ZSB0bw0KPiA+ID4gZGlzcGF0Y2ggcmVxdWVzdCwgYW5kIGFsbCBD
UFVzIGluIHRoaXMgaGN0eCBtaWdodCBiZWNvbWUgb2ZmbGluZS4NCj4gPiA+DQo+ID4gPiBXZSBo
YXZlIHNvbWUgZGlzY3Vzc2lvbiBiZWZvcmUgb24gdGhpcyBpc3N1ZToNCj4gPiA+DQo+ID4gPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay9DQUNWWEZWTjcyOVNnRlFHVWdtdTFp
TjdQNk12NStwdQ0KPiA+ID4gRTc4U1R6OGhqDQo+ID4gPiA5SjViUzgyOE5nQG1haWwuZ21haWwu
Y29tLw0KPiA+ID4NCj4gPg0KPiA+IFRoZXJlIGlzIGFub3RoZXIgc2NlbmFyaW8sIHlvdSBjYW4g
cmVwcm9kdWNlIGl0IGJ5IGhvdC1wbHVnZ2luZyBjcHVzIHRvIGt2bSBndWVzdHMNCj4gdmlhIHFl
bXUgbW9uaXRvciAoSSBiZWxpZXZlIHZpcnNoIHNldHZjcHVzIC0tbGl2ZSBjYW4gZG8gdGhlIHNh
bWUgdGhpbmcpLCBmb3IgZXhhbXBsZToNCj4gPiAocWVtdSkgY3B1LWFkZCAxDQo+ID4gKHFlbXUp
IGNwdS1hZGQgMg0KPiA+IChxZW11KSBjcHUtYWRkIDMNCj4gPg0KPiA+IEluIHN1Y2ggc2NlbmFy
aW8sIGNwdSAxLCAyIGFuZCAzIGFyZSBub3QgdmlzaWJsZSBhdCBib290LCBoY3R4LT5jcHVtYXNr
IGRvZXNuJ3QNCj4gZ2V0IHN5bmNlZCB3aGVuIHRoZXNlIGNwdXMgYXJlIGFkZGVkLg0KPiANCj4g
SXQgaXMgQ1BVIGNvbGQtcGx1Zywgd2Ugc3VwcG9zZSB0byBzdXBwb3J0IGl0Lg0KPiANCj4gVGhl
IG5ldyBhZGRlZCBDUFVzIHNob3VsZCBiZSB2aXNpYmxlIHRvIGhjdHgsIHNpbmNlIHdlIHNwcmVh
ZCBxdWV1ZXMgYW1vbmcgYWxsDQo+IHBvc3NpYmxlIENQVXMoKSwgcGxlYXNlIHNlZSBibGtfbXFf
bWFwX3F1ZXVlcygpIGFuZCBpcnFfYnVpbGRfYWZmaW5pdHlfbWFza3MoKSwNCj4gd2hpY2ggaXMg
bGlrZSBzdGF0aWMgYWxsb2NhdGlvbiBvbiBDUFUgcmVzb3VyY2VzLg0KPiANCj4gT3RoZXJ3aXNl
LCB5b3UgbWlnaHQgdXNlIGFuIG9sZCBrZXJuZWwgb3IgdGhlcmUgaXMgYnVnIHNvbWV3aGVyZS4N
Cg0KSXQgdHVybnMgb3V0IHRoYXQgSSB3YXMgdXNpbmcgb2xkIGtlcm5lbCwgdmVyc2lvbiA0LjE0
LCBJIHRlc3RlZCB0aGUgbGF0ZXN0IHZlcnNpb24sIGl0IHdvcmtzIHdlbGwgYXMgeW91IHNhaWQu
IFRoYW5rIHlvdSB2ZXJ5IG11Y2guDQoNCj4gDQo+ID4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBw
YXRjaCBhZGRlZCBhIGNwdS1ob3RwbHVnIGhhbmRsZXIgaW50byBibGstbXEsIHVwZGF0aW5nDQo+
ID4gPiA+IGhjdHgtPmNwdW1hc2sgYXQgY3B1LWhvdHBsdWcuDQo+ID4gPg0KPiA+ID4gVGhpcyB3
YXkgaXNuJ3QgY29ycmVjdCwgaGN0eC0+Y3B1bWFzayBzaG91bGQgYmUga2VwdCBhcyBzeW5jIHdp
dGgNCj4gPiA+IHF1ZXVlIG1hcHBpbmcuDQo+ID4NCj4gPiBQbGVhc2UgYWR2aXNlIHdoYXQgc2hv
dWxkIEkgZG8gdG8gZGVhbCB3aXRoIHRoZSBhYm92ZSBzaXR1YXRpb24/IFRoYW5rcyBhIGxvdC4N
Cj4gDQo+IEFzIEkgc2hhcmVkIGluIGxhc3QgZW1haWwsIHRoZXJlIGlzIG9uZSBhcHByb2FjaCBk
aXNjdXNzZWQsIHdoaWNoIHNlZW1zIGRvYWJsZS4NCj4gDQo+IFRoYW5rcywNCj4gTWluZw0KDQo=
