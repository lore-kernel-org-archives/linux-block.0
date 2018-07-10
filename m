Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:32935 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbeGJVrj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jul 2018 17:47:39 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v3 0/6] Add SRP initiator driver tests
Date: Tue, 10 Jul 2018 21:46:34 +0000
Message-ID: <81be4ea2488b868e59d37a71a657a8cae755063c.camel@wdc.com>
References: <20180709225643.10537-1-bart.vanassche@wdc.com>
         <20180710195703.GA16252@vader>
         <9bbbda38b53c49a803088131f677f15b96669e2f.camel@wdc.com>
In-Reply-To: <9bbbda38b53c49a803088131f677f15b96669e2f.camel@wdc.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTEwIGF0IDIwOjQwICswMDAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAxOC0wNy0xMCBhdCAxMjo1NyAtMDcwMCwgT21hciBTYW5kb3ZhbCB3cm90
ZToNCj4gPiBBcyBhIGZ1cnRoZXIgaW1wcm92ZW1lbnQsIGlzIGl0IHBvc3NpYmxlIHRvIGNvbmZp
Z3VyZSBtdWx0aXBhdGhkIHRvIHJlYWQNCj4gPiBmcm9tIGEgY3VzdG9tIGNvbmZpZ3VyYXRpb24g
cGF0aD8gVGhhdCB3YXkgd2UgY291bGQsIGUuZy4sIGR1bXAgdGhlDQo+ID4gcmVxdWlyZWQgbXVs
dGlwYXRoLmNvbmYgaW4gJFRNUERJUiBpbnN0ZWFkIG9mIHJlcXVpcmluZyB0aGUgc3lzdGVtLWxl
dmVsDQo+ID4gY29uZmlndXJhdGlvbi4NCj4gDQo+IFRvIG15IG93biBzdXJwcmlzZSwgbm90IHll
dC4gVGhlIC9ldGMvbXVsdGlwYXRoLmNvbmYgcGF0aCBpcyBoYXJkY29kZWQgaW4NCj4gbXVsdGlw
YXRoZC4gSSBjYW4gbG9vayBpbnRvIG1ha2luZyB0aGlzIHBhdGggY29uZmlndXJhYmxlIGJ1dCBJ
J20gYWZyYWlkIGl0DQo+IHdpbGwgdGFrZSBhIHdoaWxlIGJlZm9yZSB0aGF0IHBhdGNoIGVuZHMg
dXAgaW4gdGhlIG1ham9yaXR5IG9mIHRoZSBMaW51eA0KPiBkaXN0cm8ncy4NCj4gDQo+ID4gSWYg
bm90LCBjYW4geW91IHBsZWFzZSBtYWtlIHRoZSBncm91cF9yZXF1aXJlcyBhdXRvbWF0aWNhbGx5
IG1ha2UgdGhlDQo+ID4gc3ltbGluayBpbnN0ZWFkIG9mIHJlcXVpcmluZyBpdD8gT2J2aW91c2x5
IGNoZWNraW5nIGlmIHRoZXJlIHdhcyBhbHJlYWR5DQo+ID4gYSBwcm9kIGNvbmZpZyBmaWxlIHRo
ZXJlLg0KPiANCj4gT0ssIHdpbGwgZG8uDQo+IA0KPiA+IEkgYWxzbyBoYWQgdG8gYXBwbHkgdGhl
IGZvbGxvd2luZyBwYXRjaDoNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvdGVzdHMvc3JwLzAwMiBi
L3Rlc3RzL3NycC8wMDINCj4gPiBpbmRleCBjMDdlNzZmLi43NGM1ZmVlIDEwMDc1NQ0KPiA+IC0t
LSBhL3Rlc3RzL3NycC8wMDINCj4gPiArKysgYi90ZXN0cy9zcnAvMDAyDQo+ID4gQEAgLTQ1LDYg
KzQ1LDcgQEAgdGVzdF9kaXNjb25uZWN0X3JlcGVhdGVkbHkoKSB7DQo+ID4gIH0NCj4gDQo+IFRo
YW5rcywgSSB3aWxsIGFwcGx5IHRoaXMgcGF0Y2guDQoNCkhlbGxvIE9tYXIsDQoNClRoZXNlIGNo
YW5nZXMgaGF2ZSBiZWVuIGltcGxlbWVudGVkIGFuZCB0aGUgY29ycmVzcG9uZGluZyBwdWxsIHJl
cXVlc3QgaGFzDQpiZWVuIHVwZGF0ZWQgKGh0dHBzOi8vZ2l0aHViLmNvbS9vc2FuZG92L2Jsa3Rl
c3RzL3B1bGwvMjQpLiBQbGVhc2UgbGV0IG1lDQprbm93IGlmIHlvdSB3b3VsZCBsaWtlIG1lIHRv
IHJlcG9zdCB0aGlzIHBhdGNoIHNlcmllcy4NCg0KVGhhbmtzLA0KDQpCYXJ0Lg0KDQoNCg0K
