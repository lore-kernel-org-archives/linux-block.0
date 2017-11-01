Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39609 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbdKAQrK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Nov 2017 12:47:10 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
        "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Date: Wed, 1 Nov 2017 16:47:06 +0000
Message-ID: <1509554825.2530.32.camel@wdc.com>
References: <20171027044330.11921-1-ming.lei@redhat.com>
         <1509079996.3244.3.camel@wdc.com> <20171027053834.GA12858@ming.t460p>
         <1509395096.27259.15.camel@wdc.com> <20171031014728.GA12070@ming.t460p>
         <1509508448.2604.4.camel@wdc.com> <20171101040755.GB9527@ming.t460p>
In-Reply-To: <20171101040755.GB9527@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gV2VkLCAyMDE3LTExLTAxIGF0IDEyOjA4ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
V2VkLCBOb3YgMDEsIDIwMTcgYXQgMDM6NTQ6MDlBTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIFR1ZSwgMjAxNy0xMC0zMSBhdCAwOTo0NyArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gPiBPbiBNb24sIE9jdCAzMCwgMjAxNyBhdCAwODoyNDo1N1BNICswMDAwLCBCYXJ0
IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgMjAxNy0xMC0yNyBhdCAxMzozOCAr
MDgwMCwgTWluZyBMZWkgd3JvdGU6DQo+ID4gPiA+ID4gT24gRnJpLCBPY3QgMjcsIDIwMTcgYXQg
MDQ6NTM6MThBTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24g
RnJpLCAyMDE3LTEwLTI3IGF0IDEyOjQzICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gPiA+ID4g
PiA+ID4gVGhlIDFzdCBwYXRjaCByZW1vdmVzIHRoZSBSRVNUQVJUIGZvciBUQUctU0hBUkVEIGJl
Y2F1c2UgU0NTSSBoYW5kbGVzIGl0DQo+ID4gPiA+ID4gPiA+IGJ5IGl0c2VsZiwgYW5kIG5vdCBu
ZWNlc3NhcnkgdG8gd2FzdGUgQ1BVIHRvIGRvIHRoZSBleHBlbnNpdmUgUkVTVEFSVC4NCj4gPiA+
ID4gPiA+ID4gQW5kIFJvbWFuIFBlbiByZXBvcnRlZCB0aGF0IHRoaXMgUkVTVEFSVCBjdXRzIGhh
bGYgb2YgSU9QUyBpbiBoaXMgY2FzZS4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFRo
ZSAybmQgcGF0Y2ggcmVtb3ZlcyB0aGUgUkVTVEFSVCB3aGVuIC5nZXRfYnVkZ2V0IHJldHVybnMg
QkxLX1NUU19SRVNPVVJDRSwNCj4gPiA+ID4gPiA+ID4gYW5kIHRoaXMgUkVTVEFSVCBpcyBoYW5k
bGVkIGJ5IFNDU0kncyBSRVNUQVJUKHNjc2lfZW5kX3JlcXVlc3QoKSkgdG9vLg0KPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiBUaGVyZSBhcmUgbW9yZSBibG9jayBkcml2ZXJzIHRoYW4gdGhlIFND
U0kgY29yZSB0aGF0IHNoYXJlIHRhZ3MuIElmIHRoZQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IENv
dWxkIHlvdSBzaGFyZSB1cyB3aGF0IHRoZSBvdGhlciBpbi10cmVlIGRyaXZlciB3aGljaCBzaGFy
ZSB0YWdzIGlzPw0KPiA+ID4gPiANCj4gPiA+ID4gSSB0aGluayB0aGUgZm9sbG93aW5nIGluLXRy
ZWUgZHJpdmVycyBzdXBwb3J0IHNoYXJlZCB0YWdzIChpbiBhbHBoYWJldGljYWwNCj4gPiA+ID4g
b3JkZXIpOg0KPiA+ID4gPiAqIG51bGxfYmxrLiBTZWUgYWxzbyB0aGUgc2hhcmVkX3RhZ3Mga2Vy
bmVsIG1vZHVsZSBwYXJhbWV0ZXIuDQo+ID4gPiA+ICogbnZtZS4gU2VlIGFsc28gbnZtZV9hbGxv
Y19ucygpLg0KPiA+ID4gPiAqIHNjc2ktbXEuDQo+ID4gPiANCj4gPiA+IEZvciBib3RoIG51bGxf
YmxrIGFuZCBudm1lLCB3ZSBkb24ndCBuZWVkIHRvIGRlYWwgd2l0aCBjcm9zcy1xdWV1ZSBSRVNU
QVJULA0KPiA+ID4gYmVjYXVzZSBCTEtfTVFfU19UQUdfV0FJVElORyBoYXMgaGFuZGxlZCBpdCBh
bHJlYWR5Lg0KPiA+IA0KPiA+IGJsa19tcV9kaXNwYXRjaF93YWl0X2FkZCgpIHJldHVybnMgaW1t
ZWRpYXRlbHkgaWYgQkxLX01RX1NfVEFHX1dBSVRJTkcgaXMNCj4gPiBhbHJlYWR5IHNldC4gQXJl
IHlvdSByZWFsbHkgc3VyZSB0aGF0IHJlbW92aW5nIHRoZSByZXN0YXJ0IG1lY2hhbmlzbSBkb2Vz
bid0DQo+ID4gYnJlYWsgdGhlIE5WTWUgZHJpdmVyIGlmIHRoZXJlIGFyZSBtdWx0aXBsZSBuYW1l
c3BhY2VzPz4gDQo+IElmIHRoaXMgZmxhZyBpcyBzZXQsIHRoYXQgbWVhbnMgYmxrX21xX2Rpc3Bh
dGNoX3dha2UoKSB3aWxsIGJlIHJ1biB3aGVuDQo+IGRyaXZlciB0YWcgaXMgYXZhaWxhYmxlLCBz
byB0aGUgaHcgcXVldWUgd2lsbCBiZSBydW4gYXQgdGhhdCB0aW1lLg0KDQpUaGUgb25seSBodyBx
dWV1ZSB0aGF0IHdpbGwgYmUgcmVydW4gaWYgQkxLX01RX1NfVEFHX1dBSVRJTkcgaXMgc2V0IGlz
IHRoZSBodw0KcXVldWUgZm9yIHdoaWNoIHRoYXQgZmxhZyB3YXMgc2V0LiBTb3JyeSBidXQgSSBk
b24ndCB0aGluayB0aGF0IG1lY2hhbmlzbSBieQ0KaXRzZWxmIGlzIHN1ZmZpY2llbnQgdG8gYXZv
aWQgcXVldWUgbG9ja3VwcyB3aXRoIHRoZSBOVk1lIGRyaXZlciBpbiBjYXNlIG9mDQpzaGFyZWQg
bmFtZXNwYWNlcy4gU2VlIGFsc28gdGhlIGRlc2NyaXB0aW9uIG9mIGNvbW1pdCBkYTU1ZjJjYzc4
NDEgKCJibGstbXE6DQp1c2Ugc2JxIHdhaXQgcXVldWVzIGluc3RlYWQgb2YgcmVzdGFydCBmb3Ig
ZHJpdmVyIHRhZ3MiKS4NCg0KQmFydC4=
