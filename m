Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48669 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbdKJQai (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Nov 2017 11:30:38 -0500
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "osandov@fb.com" <osandov@fb.com>, "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH] blk-mq: respect queue dead via blk_mq_quiesce_queue
Date: Fri, 10 Nov 2017 16:30:35 +0000
Message-ID: <1510331434.2905.2.camel@wdc.com>
References: <20171105121008.28180-1-ming.lei@redhat.com>
         <1509896328.2697.4.camel@wdc.com>
In-Reply-To: <1509896328.2697.4.camel@wdc.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU3VuLCAyMDE3LTExLTA1IGF0IDE1OjM4ICswMDAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+IE9uIFN1biwgMjAxNy0xMS0wNSBhdCAyMDoxMCArMDgwMCwgTWluZyBMZWkgd3JvdGU6DQo+
ID4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1jb3JlLmMgYi9ibG9jay9ibGstY29yZS5jDQo+ID4g
aW5kZXggMDQ4YmU0YWE2MDI0Li4wYjEyMWYyOWUzYjEgMTAwNjQ0DQo+ID4gLS0tIGEvYmxvY2sv
YmxrLWNvcmUuYw0KPiA+ICsrKyBiL2Jsb2NrL2Jsay1jb3JlLmMNCj4gPiBAQCAtNjU4LDYgKzY1
OCwxMCBAQCB2b2lkIGJsa19jbGVhbnVwX3F1ZXVlKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQ0K
PiA+ICAJcXVldWVfZmxhZ19zZXQoUVVFVUVfRkxBR19ERUFELCBxKTsNCj4gPiAgCXNwaW5fdW5s
b2NrX2lycShsb2NrKTsNCj4gPiAgDQo+ID4gKwkvKiByZXNwZWN0IHF1ZXVlIERFQUQgdmlhIHF1
aWVzY2UgZm9yIGJsay1tcSAqLw0KPiA+ICsJaWYgKHEtPm1xX29wcykNCj4gPiArCQlibGtfbXFf
cXVpZXNjZV9xdWV1ZShxKTsNCj4gPiArDQo+ID4gIAkvKiBmb3Igc3luY2hyb25vdXMgYmlvLWJh
c2VkIGRyaXZlciBmaW5pc2ggaW4tZmxpZ2h0IGludGVncml0eSBpL28gKi8NCj4gPiAgCWJsa19m
bHVzaF9pbnRlZ3JpdHkoKTsNCj4gDQo+IEhhdmUgeW91IGNvbnNpZGVyZWQgdG8gY2hhbmdlIHRo
ZSBibGtfZnJlZXplX3F1ZXVlX3N0YXJ0KCkgY2FsbCBpbg0KPiBibGtfc2V0X3F1ZXVlX2R5aW5n
KCkgaW50byBhIGJsa19mcmVlemVfcXVldWUoKSBjYWxsPyBUaGF0IGFwcHJvYWNoIGhhcyB0aGUN
Cj4gYWR2YW50YWdlIHRoYXQgbm8gbmV3IGlmIChxLT5tcV9vcHMpIHRlc3QgaGFzIHRvIGJlIGlu
dHJvZHVjZWQuDQoNClRoZXJlIGlzIGFuIGFkZGl0aW9uYWwgcmVhc29uIHdoeSBJIHRoaW5rIGl0
IHdvdWxkIGJlIGJldHRlciB0byBtYWtlDQpibGtfc2V0X3F1ZXVlX2R5aW5nKCkgd2FpdCB1bnRp
bCByZXF1ZXN0cyB0aGF0IGFyZSBpbiBwcm9ncmVzcyBoYXZlIGZpbmlzaGVkLg0KU29tZSBibG9j
ayBkcml2ZXJzLCBlLmcuIHRoZSBtdGlwIGRyaXZlciwgc3RhcnQgY2xlYW5pbmcgdXAgcmVzb3Vy
Y2VzDQppbW1lZGlhdGVseSBhZnRlciBibGtfc2V0X3F1ZXVlX2R5aW5nKCkgaGFzIHJldHVybmVk
LiBTbyBtYWtpbmcNCmJsa19zZXRfcXVldWVfZHlpbmcoKSB3YWl0IHdvdWxkIGZpeCBhIHJhY2Ug
Y29uZGl0aW9uIGluIGF0IGxlYXN0IHRoZSBtdGlwDQpkcml2ZXIuDQoNCkJhcnQu
