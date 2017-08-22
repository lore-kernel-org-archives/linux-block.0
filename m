Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34771 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752477AbdHVUoA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 16:44:00 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 11/20] blk-mq: introduce helpers for operating
 ->dispatch list
Date: Tue, 22 Aug 2017 20:43:12 +0000
Message-ID: <1503434591.2508.20.camel@wdc.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
         <20170805065705.12989-12-ming.lei@redhat.com>
In-Reply-To: <20170805065705.12989-12-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU2F0LCAyMDE3LTA4LTA1IGF0IDE0OjU2ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gK3N0
YXRpYyBpbmxpbmUgYm9vbCBibGtfbXFfaGFzX2Rpc3BhdGNoX3JxcyhzdHJ1Y3QgYmxrX21xX2h3
X2N0eCAqaGN0eCkNCj4gK3sNCj4gKwlyZXR1cm4gIWxpc3RfZW1wdHlfY2FyZWZ1bCgmaGN0eC0+
ZGlzcGF0Y2gpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgYmxrX21xX2FkZF9y
cV90b19kaXNwYXRjaChzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCwNCj4gKwkJc3RydWN0IHJl
cXVlc3QgKnJxKQ0KPiArew0KPiArCXNwaW5fbG9jaygmaGN0eC0+bG9jayk7DQo+ICsJbGlzdF9h
ZGQoJnJxLT5xdWV1ZWxpc3QsICZoY3R4LT5kaXNwYXRjaCk7DQo+ICsJYmxrX21xX2hjdHhfc2V0
X2Rpc3BhdGNoX2J1c3koaGN0eCk7DQo+ICsJc3Bpbl91bmxvY2soJmhjdHgtPmxvY2spOw0KPiAr
fQ0KPiArDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgYmxrX21xX2FkZF9saXN0X3RvX2Rpc3BhdGNo
KHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4LA0KPiArCQlzdHJ1Y3QgbGlzdF9oZWFkICpsaXN0
KQ0KPiArew0KPiArCXNwaW5fbG9jaygmaGN0eC0+bG9jayk7DQo+ICsJbGlzdF9zcGxpY2VfaW5p
dChsaXN0LCAmaGN0eC0+ZGlzcGF0Y2gpOw0KPiArCWJsa19tcV9oY3R4X3NldF9kaXNwYXRjaF9i
dXN5KGhjdHgpOw0KPiArCXNwaW5fdW5sb2NrKCZoY3R4LT5sb2NrKTsNCj4gK30NCj4gKw0KPiAr
c3RhdGljIGlubGluZSB2b2lkIGJsa19tcV9hZGRfbGlzdF90b19kaXNwYXRjaF90YWlsKHN0cnVj
dCBibGtfbXFfaHdfY3R4ICpoY3R4LA0KPiArCQkJCQkJICAgIHN0cnVjdCBsaXN0X2hlYWQgKmxp
c3QpDQo+ICt7DQo+ICsJc3Bpbl9sb2NrKCZoY3R4LT5sb2NrKTsNCj4gKwlsaXN0X3NwbGljZV90
YWlsX2luaXQobGlzdCwgJmhjdHgtPmRpc3BhdGNoKTsNCj4gKwlibGtfbXFfaGN0eF9zZXRfZGlz
cGF0Y2hfYnVzeShoY3R4KTsNCj4gKwlzcGluX3VubG9jaygmaGN0eC0+bG9jayk7DQo+ICt9DQo+
ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBibGtfbXFfdGFrZV9saXN0X2Zyb21fZGlzcGF0Y2go
c3RydWN0IGJsa19tcV9od19jdHggKmhjdHgsDQo+ICsJCXN0cnVjdCBsaXN0X2hlYWQgKmxpc3Qp
DQo+ICt7DQo+ICsJc3Bpbl9sb2NrKCZoY3R4LT5sb2NrKTsNCj4gKwlsaXN0X3NwbGljZV9pbml0
KCZoY3R4LT5kaXNwYXRjaCwgbGlzdCk7DQo+ICsJc3Bpbl91bmxvY2soJmhjdHgtPmxvY2spOw0K
PiArfQ0KDQpTYW1lIGNvbW1lbnQgZm9yIHRoaXMgcGF0Y2g6IHRoZXNlIGhlbHBlciBmdW5jdGlv
bnMgYXJlIHNvIHNob3J0IHRoYXQgSSdtIG5vdA0Kc3VyZSBpdCBpcyB1c2VmdWwgdG8gaW50cm9k
dWNlIHRoZXNlIGhlbHBlciBmdW5jdGlvbnMuDQoNCkJhcnQu
