Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9578 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbdE1QKM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 May 2017 12:10:12 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2 4/8] blk-mq: fix blk_mq_quiesce_queue
Date: Sun, 28 May 2017 16:10:09 +0000
Message-ID: <1495987808.2849.5.camel@sandisk.com>
References: <20170527142126.26079-1-ming.lei@redhat.com>
         <20170527142126.26079-5-ming.lei@redhat.com>
         <1495921605.13651.2.camel@sandisk.com> <20170528104400.GB6488@ming.t460p>
In-Reply-To: <20170528104400.GB6488@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU3VuLCAyMDE3LTA1LTI4IGF0IDE4OjQ0ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
U2F0LCBNYXkgMjcsIDIwMTcgYXQgMDk6NDY6NDVQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIFNhdCwgMjAxNy0wNS0yNyBhdCAyMjoyMSArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gPiAgYm9vbCBibGtfbXFfY2FuX3F1ZXVlKHN0cnVjdCBibGtfbXFfaHdfY3R4ICpo
Y3R4KQ0KPiA+ID4gQEAgLTExMDgsMTMgKzExMTksMTUgQEAgc3RhdGljIHZvaWQgX19ibGtfbXFf
cnVuX2h3X3F1ZXVlKHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4KQ0KPiA+ID4gIA0KPiA+ID4g
IAlpZiAoIShoY3R4LT5mbGFncyAmIEJMS19NUV9GX0JMT0NLSU5HKSkgew0KPiA+ID4gIAkJcmN1
X3JlYWRfbG9jaygpOw0KPiA+ID4gLQkJYmxrX21xX3NjaGVkX2Rpc3BhdGNoX3JlcXVlc3RzKGhj
dHgpOw0KPiA+ID4gKwkJaWYgKCFibGtfcXVldWVfcXVpZXNjZWQoaGN0eC0+cXVldWUpKQ0KPiA+
ID4gKwkJCWJsa19tcV9zY2hlZF9kaXNwYXRjaF9yZXF1ZXN0cyhoY3R4KTsNCj4gPiA+ICAJCXJj
dV9yZWFkX3VubG9jaygpOw0KPiA+ID4gIAl9IGVsc2Ugew0KPiA+ID4gIAkJbWlnaHRfc2xlZXAo
KTsNCj4gPiA+ICANCj4gPiA+ICAJCXNyY3VfaWR4ID0gc3JjdV9yZWFkX2xvY2soJmhjdHgtPnF1
ZXVlX3JxX3NyY3UpOw0KPiA+ID4gLQkJYmxrX21xX3NjaGVkX2Rpc3BhdGNoX3JlcXVlc3RzKGhj
dHgpOw0KPiA+ID4gKwkJaWYgKCFibGtfcXVldWVfcXVpZXNjZWQoaGN0eC0+cXVldWUpKQ0KPiA+
ID4gKwkJCWJsa19tcV9zY2hlZF9kaXNwYXRjaF9yZXF1ZXN0cyhoY3R4KTsNCj4gPiA+ICAJCXNy
Y3VfcmVhZF91bmxvY2soJmhjdHgtPnF1ZXVlX3JxX3NyY3UsIHNyY3VfaWR4KTsNCj4gPiA+ICAJ
fQ0KPiA+ID4gIH0NCj4gPiANCj4gPiBTb3JyeSBidXQgSSBkb24ndCBsaWtlIHRoZXNlIGNoYW5n
ZXMuIFdoeSBoYXZlIHRoZSBibGtfcXVldWVfcXVpZXNjZWQoKQ0KPiA+IGNhbGxzIGJlIGFkZGVk
IGF0IG90aGVyIGNvZGUgbG9jYXRpb25zIHRoYW4gdGhlIGJsa19tcV9oY3R4X3N0b3BwZWQoKSBj
YWxscz8NCj4gPiBUaGlzIHdpbGwgbWFrZSB0aGUgYmxvY2sgbGF5ZXIgdW5uZWNlc3NhcnkgaGFy
ZCB0byBtYWludGFpbi4gUGxlYXNlIGNvbnNpZGVyDQo+ID4gdG8gY2hhbmdlIHRoZSBibGtfbXFf
aGN0eF9zdG9wcGVkKGhjdHgpIGNhbGxzIGluIGJsa19tcV9zY2hlZF9kaXNwYXRjaF9yZXF1ZXN0
cygpDQo+ID4gYW5kICpibGtfbXFfKnJ1bl9od19xdWV1ZSooKSBpbnRvIGJsa19tcV9oY3R4X3N0
b3BwZWQoaGN0eCkgfHwgYmxrX3F1ZXVlX3F1aWVzY2VkKHEpLg0KPiANCj4gT25lIGJlbmVmaXQg
aXMgdGhhdCB3ZSBtYWtlIGl0IGV4cGxpY2l0IHRoYXQgdGhlIGZsYWcgaGFzIHRvIGJlIGNoZWNr
ZWQNCj4gaW5zaWRlIHRoZSBSQ1UgcmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb25zLiBJZiB5b3Ug
cHV0IGl0IHNvbWV3aGVyZSwNCj4gc29tZW9uZSBtYXkgcHV0IGl0IG91dCBvZiByZWFkLXNpZGUg
Y3JpdGljYWwgc2VjdGlvbnMgaW4gZnV0dXJlLg0KDQpIZWxsbyBNaW5nLA0KDQpJIHJlYWxseSB3
b3VsZCBsaWtlIHRvIHNlZSB0aGUgYmxrX3F1ZXVlX3F1aWVzY2VkKCkgdGVzdHMgYXMgY2xvc2Ug
YXMgcG9zc2libGUgdG8NCnRoZSBibGtfbXFfaGN0eF9zdG9wcGVkKCkgdGVzdHMuIEJ1dCBJIGFn
cmVlIHRoYXQgd2UgbmVlZCBhIHdheSB0byBkb2N1bWVudCBhbmQvb3INCnZlcmlmeSB0aGF0IHRo
ZXNlIHRlc3RzIG9jY3VyIHdpdGggYW4gUkNVIHJlYWQtc2lkZSBsb2NrIGhlbGQuIEhhdmUgeW91
IGNvbnNpZGVyZWQNCnRvIHVzZSByY3VfcmVhZF9sb2NrX2hlbGQoKSB0byBkb2N1bWVudCB0aGlz
Pw0KDQpUaGFua3MsDQoNCkJhcnQu
