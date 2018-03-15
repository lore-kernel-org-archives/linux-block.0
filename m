Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7234 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbeCORGI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 13:06:08 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "colyli@suse.de" <colyli@suse.de>,
        "mlyle@lyle.org" <mlyle@lyle.org>,
        "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 13/16] bcache: Make bch_dump_read() fail if copying to
 user space fails
Date: Thu, 15 Mar 2018 17:06:05 +0000
Message-ID: <1521133564.2834.10.camel@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
         <20180315150814.9412-14-bart.vanassche@wdc.com>
         <f72260be-9288-37c3-c7c8-a6f9a7d3955d@suse.de>
In-Reply-To: <f72260be-9288-37c3-c7c8-a6f9a7d3955d@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE4LTAzLTE2IGF0IDAxOjAwICswODAwLCBDb2x5IExpIHdyb3RlOg0KPiBPbiAx
NS8wMy8yMDE4IDExOjA4IFBNLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gY29weV90b191
c2VyKCkgcmV0dXJucyB0aGUgbnVtYmVyIG9mIHJlbWFpbmluZyBieXRlcy4gQXZvaWQgdGhhdA0K
PiA+IGEgbGFyZ2VyIHZhbHVlIGlzIHJldHVybmVkIHRoYW4gdGhlIG51bWJlciBvZiBieXRlcyB0
aGF0IGhhdmUNCj4gPiBiZWVuIGNvcGllZCBieSByZXR1cm5pbmcgLUVGQVVMVCBpZiBub3QgYWxs
IGJ5dGVzIGhhdmUgYmVlbiBjb3BpZWQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQmFydCBW
YW4gQXNzY2hlIDxiYXJ0LnZhbmFzc2NoZUB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L21kL2JjYWNoZS9kZWJ1Zy5jIHwgNSArKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21kL2JjYWNoZS9kZWJ1Zy5jIGIvZHJpdmVycy9tZC9iY2FjaGUvZGVidWcuYw0KPiA+IGluZGV4
IGFmODk0MDhiZWZlOC4uMzc2ODk5Y2ZjYmYxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWQv
YmNhY2hlL2RlYnVnLmMNCj4gPiArKysgYi9kcml2ZXJzL21kL2JjYWNoZS9kZWJ1Zy5jDQo+ID4g
QEAgLTE3NSw5ICsxNzUsOCBAQCBzdGF0aWMgc3NpemVfdCBiY2hfZHVtcF9yZWFkKHN0cnVjdCBm
aWxlICpmaWxlLCBjaGFyIF9fdXNlciAqYnVmLA0KPiA+ICAJCXN0cnVjdCBrZXlidWZfa2V5ICp3
Ow0KPiA+ICAJCXVuc2lnbmVkIGJ5dGVzID0gbWluKGktPmJ5dGVzLCBzaXplKTsNCj4gPiAgDQo+
ID4gLQkJaW50IGVyciA9IGNvcHlfdG9fdXNlcihidWYsIGktPmJ1ZiwgYnl0ZXMpOw0KPiA+IC0J
CWlmIChlcnIpDQo+ID4gLQkJCXJldHVybiBlcnI7DQo+ID4gKwkJaWYgKGNvcHlfdG9fdXNlcihi
dWYsIGktPmJ1ZiwgYnl0ZXMpKQ0KPiA+ICsJCQlyZXR1cm4gLUVGQVVMVDsNCj4gPiAgDQo+IA0K
PiBIaSBCYXJ0LA0KPiANCj4gSSBhbSBub3Qgc3VyZSB3aGV0aGVyIHRoaXMgY2hhbmdlIGlzIGNv
cnJlY3QuIC1FRkFVTFQgc2VlbXMgbm90IGFuDQo+IGV4cGVjdGVkIHJldHVybiB2YWx1ZSBvZiBy
ZWFkKDIpLCB3aGlsZSAtMSBpcyB0aGUgZXhwZWN0ZWQgcmV0dXJuIHZhbHVlDQo+IHdoZW4gZXJy
b3Igb2NjdXJzLg0KPiANCj4gTWF5YmUgaWYgY29weV90b191c2VyKCkgcmV0dXJucyB2YWx1ZSBp
biAoMCwgc2l6ZV0sICJyZXQgKyAoc2l6ZSAtIGVycikiDQo+IHNob3VsZCBiZSByZXR1cm5lZC4g
QW4gZXhjZXB0aW9uIGlzIHdoZW4gY29weV90b191c2VyKCkgcmV0dXJucyAwIGFuZA0KPiByZXQg
aXMgMCB0b28sIGluIHRoaXMgc2l0dWF0aW9uIC0xIHNob3VsZCBiZSByZXR1cm5lZC4NCj4gDQo+
IENvcnJlY3QgbWUgaWYgSSBhbSB3cm9uZy4NCg0KSGVsbG8gQ29seSwNCg0KSSdtIG5vdCBmYW1p
bGlhciBlbm91Z2ggd2l0aCBiY2FjaGUgdG8gcHJvdmlkZSB0aGUgYW5zd2VyIHRvIHlvdXIgcXVl
c3Rpb24gc28NCkkgd2lsbCBkcm9wIHRoaXMgcGF0Y2ggZnJvbSB0aGlzIHNlcmllcy4NCg0KVGhh
bmtzLA0KDQpCYXJ0Lg0KDQoNCg==
