Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36970 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdE1QDY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 May 2017 12:03:24 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 6/8] blk-mq: don't stop queue for quiescing
Date: Sun, 28 May 2017 16:03:20 +0000
Message-ID: <1495987400.2849.3.camel@sandisk.com>
References: <20170527142126.26079-1-ming.lei@redhat.com>
         <20170527142126.26079-7-ming.lei@redhat.com>
         <1495921766.13651.4.camel@sandisk.com> <20170528105047.GC6488@ming.t460p>
In-Reply-To: <20170528105047.GC6488@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU3VuLCAyMDE3LTA1LTI4IGF0IDE4OjUwICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
U2F0LCBNYXkgMjcsIDIwMTcgYXQgMDk6NDk6MjdQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIFNhdCwgMjAxNy0wNS0yNyBhdCAyMjoyMSArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLW1xLmMgYi9ibG9jay9ibGstbXEuYw0K
PiA+ID4gaW5kZXggMDMyMDQ1ODQxODU2Li44NGNjZTY3Y2FlZTMgMTAwNjQ0DQo+ID4gPiAtLS0g
YS9ibG9jay9ibGstbXEuYw0KPiA+ID4gKysrIGIvYmxvY2svYmxrLW1xLmMNCj4gPiA+IEBAIC0x
NjgsOCArMTY4LDYgQEAgdm9pZCBibGtfbXFfcXVpZXNjZV9xdWV1ZShzdHJ1Y3QgcmVxdWVzdF9x
dWV1ZSAqcSkNCj4gPiA+ICAJdW5zaWduZWQgaW50IGk7DQo+ID4gPiAgCWJvb2wgcmN1ID0gZmFs
c2U7DQo+ID4gPiAgDQo+ID4gPiAtCV9fYmxrX21xX3N0b3BfaHdfcXVldWVzKHEsIHRydWUpOw0K
PiA+ID4gLQ0KPiA+ID4gIAlzcGluX2xvY2tfaXJxKHEtPnF1ZXVlX2xvY2spOw0KPiA+ID4gIAlx
dWV1ZV9mbGFnX3NldChRVUVVRV9GTEFHX1FVSUVTQ0VELCBxKTsNCj4gPiA+ICAJc3Bpbl91bmxv
Y2tfaXJxKHEtPnF1ZXVlX2xvY2spOw0KPiA+ID4gQEAgLTE5OCw3ICsxOTYsMTIgQEAgdm9pZCBi
bGtfbXFfdW5xdWllc2NlX3F1ZXVlKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQ0KPiA+ID4gIAlx
dWV1ZV9mbGFnX2NsZWFyKFFVRVVFX0ZMQUdfUVVJRVNDRUQsIHEpOw0KPiA+ID4gIAlzcGluX3Vu
bG9ja19pcnEocS0+cXVldWVfbG9jayk7DQo+ID4gPiAgDQo+ID4gPiAtCWJsa19tcV9zdGFydF9z
dG9wcGVkX2h3X3F1ZXVlcyhxLCB0cnVlKTsNCj4gPiA+ICsJLyoNCj4gPiA+ICsJICogRHVyaW5n
IHF1aWVzY2luZywgcmVxdWVzdHMgY2FuIGJlIGluc2VydGVkDQo+ID4gPiArCSAqIHRvIHNjaGVk
dWxlcidzIHF1ZXVlIG9yIHN3IHF1ZXVlLCBzbyB3ZSBydW4NCj4gPiA+ICsJICogcXVldWVzIGZv
ciBkaXNwYXRjaGluZyB0aGVzZSByZXF1ZXN0cy4NCj4gPiA+ICsJICovDQo+ID4gPiArCWJsa19t
cV9zdGFydF9od19xdWV1ZXMocSk7DQo+ID4gPiAgfQ0KPiA+ID4gIEVYUE9SVF9TWU1CT0xfR1BM
KGJsa19tcV91bnF1aWVzY2VfcXVldWUpOw0KPiA+IA0KPiA+IFRoaXMgbG9va3MgcmVhbGx5IHdl
aXJkIHRvIG1lLiBJZiBibGtfbXFfcXVpZXNjZV9xdWV1ZSgpIGRvZXNuJ3Qgc3RvcCBhbnkNCj4g
PiBoYXJkd2FyZSBxdWV1ZXMsIHdoeSBzaG91bGQgYmxrX21xX3VucXVpZXNjZV9xdWV1ZSgpIHN0
YXJ0IGFueSBoYXJkd2FyZQ0KPiA+IHF1ZXVlcz8NCj4gDQo+IFBsZWFzZSBzZWUgdGhlIGFib3Zl
IGNvbW1lbnQsIGVzcGVjaWFsbHkgaW4gZGlyZWN0IGlzc3VlIHBhdGgsIHdlIGhhdmUgdG8NCj4g
aW5zZXJ0IHRoZSByZXF1ZXN0IGludG8gc3cvc2NoZWR1bGVyIHF1ZXVlIHdoZW4gcXVldWUgaXMg
cXVpZXNjZWQsDQo+IGFuZCB0aGVzZSBxdWV1ZWQgcmVxdWVzdHMgaGF2ZSB0byBiZSBkaXNwYXRj
aGVkIG91dCBkdXJpbmcgdW5xdWllc2NpbmcuDQo+IA0KPiBJIGNvbnNpZGVyZWQgdG8gc2xlZXAg
dGhlIGN1cnJlbnQgY29udGV4dCB1bmRlciB0aGlzIHNpdHVhdGlvbiwgYnV0DQo+IHR1cm5zIG91
dCBpdCBpcyBtb3JlIGNvbXBsaWNhdGVkIHRvIGhhbmRsZSwgZ2l2ZW4gd2UgaGF2ZSB2ZXJ5IGxp
bWl0ZWQNCj4gcXVldWUgZGVwdGgsIGp1c3QgbGV0IGFwcGxpY2F0aW9ucyBjb25zdW1lcyBhbGws
IHRoZW4gd2FpdC4NCg0KSGVsbG8gTWluZywNCg0KVGhlIGFib3ZlIHNlZW1zIHRvIG1lIHRvIGJl
IGFuIGFyZ3VtZW50IHRvICpydW4qIHRoZSBxdWV1ZSBmcm9tIGluc2lkZQ0KYmxrX21xX3VucXVp
ZXNjZV9xdWV1ZSgpIGluc3RlYWQgb2YgKnN0YXJ0aW5nKiBzdG9wcGVkIHF1ZXVlcyBmcm9tIGlu
c2lkZQ0KdGhhdCBmdW5jdGlvbi4NCg0KQmFydC4=
