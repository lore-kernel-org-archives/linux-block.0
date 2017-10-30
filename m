Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:20308 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdJ3UZB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2017 16:25:01 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
        "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Date: Mon, 30 Oct 2017 20:24:57 +0000
Message-ID: <1509395096.27259.15.camel@wdc.com>
References: <20171027044330.11921-1-ming.lei@redhat.com>
         <1509079996.3244.3.camel@wdc.com> <20171027053834.GA12858@ming.t460p>
In-Reply-To: <20171027053834.GA12858@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gRnJpLCAyMDE3LTEwLTI3IGF0IDEzOjM4ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
RnJpLCBPY3QgMjcsIDIwMTcgYXQgMDQ6NTM6MThBTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIEZyaSwgMjAxNy0xMC0yNyBhdCAxMjo0MyArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gPiBUaGUgMXN0IHBhdGNoIHJlbW92ZXMgdGhlIFJFU1RBUlQgZm9yIFRBRy1TSEFS
RUQgYmVjYXVzZSBTQ1NJIGhhbmRsZXMgaXQNCj4gPiA+IGJ5IGl0c2VsZiwgYW5kIG5vdCBuZWNl
c3NhcnkgdG8gd2FzdGUgQ1BVIHRvIGRvIHRoZSBleHBlbnNpdmUgUkVTVEFSVC4NCj4gPiA+IEFu
ZCBSb21hbiBQZW4gcmVwb3J0ZWQgdGhhdCB0aGlzIFJFU1RBUlQgY3V0cyBoYWxmIG9mIElPUFMg
aW4gaGlzIGNhc2UuDQo+ID4gPiANCj4gPiA+IFRoZSAybmQgcGF0Y2ggcmVtb3ZlcyB0aGUgUkVT
VEFSVCB3aGVuIC5nZXRfYnVkZ2V0IHJldHVybnMgQkxLX1NUU19SRVNPVVJDRSwNCj4gPiA+IGFu
ZCB0aGlzIFJFU1RBUlQgaXMgaGFuZGxlZCBieSBTQ1NJJ3MgUkVTVEFSVChzY3NpX2VuZF9yZXF1
ZXN0KCkpIHRvby4NCj4gPiANCj4gPiBUaGVyZSBhcmUgbW9yZSBibG9jayBkcml2ZXJzIHRoYW4g
dGhlIFNDU0kgY29yZSB0aGF0IHNoYXJlIHRhZ3MuIElmIHRoZQ0KPiANCj4gQ291bGQgeW91IHNo
YXJlIHVzIHdoYXQgdGhlIG90aGVyIGluLXRyZWUgZHJpdmVyIHdoaWNoIHNoYXJlIHRhZ3MgaXM/
DQoNCkkgdGhpbmsgdGhlIGZvbGxvd2luZyBpbi10cmVlIGRyaXZlcnMgc3VwcG9ydCBzaGFyZWQg
dGFncyAoaW4gYWxwaGFiZXRpY2FsDQpvcmRlcik6DQoqIG51bGxfYmxrLiBTZWUgYWxzbyB0aGUg
c2hhcmVkX3RhZ3Mga2VybmVsIG1vZHVsZSBwYXJhbWV0ZXIuDQoqIG52bWUuIFNlZSBhbHNvIG52
bWVfYWxsb2NfbnMoKS4NCiogc2NzaS1tcS4NCg0KUGxlYXNlIG5vdGUgdGhhdCB0aGUgcXVldWVf
cnEoKSBmdW5jdGlvbiBvZiAqYWxsKiB0aGVzZSBkcml2ZXJzIGNhbiByZXR1cm4NCkJMS19TVFNf
UkVTT1VSQ0UuDQoNCj4gQWN0dWFsbHkgU0NTSSdzIFJFU1RBUlQgaXMgdmVyeSB0aGluLCBhbmQg
aXQgaXMganVzdCB0aGUgcGVyLWhvc3Qgc3RhcnZlZF9saXN0Lg0KDQpEbyB5b3Ugc2VlIGFueSBy
ZWFzb24gdGhhdCB3b3VsZCBwcmV2ZW50IHRvIG1vdmUgdGhhdCBtZWNoYW5pc20gZnJvbSBzY3Np
LW1xDQppbnRvIHRoZSBibGstbXEgY29yZT8NCg0KVGhhbmtzLA0KDQpCYXJ0Lg==
