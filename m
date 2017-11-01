Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:23123 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdKADyM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Oct 2017 23:54:12 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>,
        "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
        "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH V2 0/2] block: remove unnecessary RESTART
Date: Wed, 1 Nov 2017 03:54:09 +0000
Message-ID: <1509508448.2604.4.camel@wdc.com>
References: <20171027044330.11921-1-ming.lei@redhat.com>
         <1509079996.3244.3.camel@wdc.com> <20171027053834.GA12858@ming.t460p>
         <1509395096.27259.15.camel@wdc.com> <20171031014728.GA12070@ming.t460p>
In-Reply-To: <20171031014728.GA12070@ming.t460p>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gVHVlLCAyMDE3LTEwLTMxIGF0IDA5OjQ3ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gT24g
TW9uLCBPY3QgMzAsIDIwMTcgYXQgMDg6MjQ6NTdQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hlIHdy
b3RlOg0KPiA+IE9uIEZyaSwgMjAxNy0xMC0yNyBhdCAxMzozOCArMDgwMCwgTWluZyBMZWkgd3Jv
dGU6DQo+ID4gPiBPbiBGcmksIE9jdCAyNywgMjAxNyBhdCAwNDo1MzoxOEFNICswMDAwLCBCYXJ0
IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgMjAxNy0xMC0yNyBhdCAxMjo0MyAr
MDgwMCwgTWluZyBMZWkgd3JvdGU6DQo+ID4gPiA+ID4gVGhlIDFzdCBwYXRjaCByZW1vdmVzIHRo
ZSBSRVNUQVJUIGZvciBUQUctU0hBUkVEIGJlY2F1c2UgU0NTSSBoYW5kbGVzIGl0DQo+ID4gPiA+
ID4gYnkgaXRzZWxmLCBhbmQgbm90IG5lY2Vzc2FyeSB0byB3YXN0ZSBDUFUgdG8gZG8gdGhlIGV4
cGVuc2l2ZSBSRVNUQVJULg0KPiA+ID4gPiA+IEFuZCBSb21hbiBQZW4gcmVwb3J0ZWQgdGhhdCB0
aGlzIFJFU1RBUlQgY3V0cyBoYWxmIG9mIElPUFMgaW4gaGlzIGNhc2UuDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gVGhlIDJuZCBwYXRjaCByZW1vdmVzIHRoZSBSRVNUQVJUIHdoZW4gLmdldF9idWRn
ZXQgcmV0dXJucyBCTEtfU1RTX1JFU09VUkNFLA0KPiA+ID4gPiA+IGFuZCB0aGlzIFJFU1RBUlQg
aXMgaGFuZGxlZCBieSBTQ1NJJ3MgUkVTVEFSVChzY3NpX2VuZF9yZXF1ZXN0KCkpIHRvby4NCj4g
PiA+ID4gDQo+ID4gPiA+IFRoZXJlIGFyZSBtb3JlIGJsb2NrIGRyaXZlcnMgdGhhbiB0aGUgU0NT
SSBjb3JlIHRoYXQgc2hhcmUgdGFncy4gSWYgdGhlDQo+ID4gPiANCj4gPiA+IENvdWxkIHlvdSBz
aGFyZSB1cyB3aGF0IHRoZSBvdGhlciBpbi10cmVlIGRyaXZlciB3aGljaCBzaGFyZSB0YWdzIGlz
Pw0KPiA+IA0KPiA+IEkgdGhpbmsgdGhlIGZvbGxvd2luZyBpbi10cmVlIGRyaXZlcnMgc3VwcG9y
dCBzaGFyZWQgdGFncyAoaW4gYWxwaGFiZXRpY2FsDQo+ID4gb3JkZXIpOg0KPiA+ICogbnVsbF9i
bGsuIFNlZSBhbHNvIHRoZSBzaGFyZWRfdGFncyBrZXJuZWwgbW9kdWxlIHBhcmFtZXRlci4NCj4g
PiAqIG52bWUuIFNlZSBhbHNvIG52bWVfYWxsb2NfbnMoKS4NCj4gPiAqIHNjc2ktbXEuDQo+IA0K
PiBGb3IgYm90aCBudWxsX2JsayBhbmQgbnZtZSwgd2UgZG9uJ3QgbmVlZCB0byBkZWFsIHdpdGgg
Y3Jvc3MtcXVldWUgUkVTVEFSVCwNCj4gYmVjYXVzZSBCTEtfTVFfU19UQUdfV0FJVElORyBoYXMg
aGFuZGxlZCBpdCBhbHJlYWR5Lg0KDQpibGtfbXFfZGlzcGF0Y2hfd2FpdF9hZGQoKSByZXR1cm5z
IGltbWVkaWF0ZWx5IGlmIEJMS19NUV9TX1RBR19XQUlUSU5HIGlzDQphbHJlYWR5IHNldC4gQXJl
IHlvdSByZWFsbHkgc3VyZSB0aGF0IHJlbW92aW5nIHRoZSByZXN0YXJ0IG1lY2hhbmlzbSBkb2Vz
bid0DQpicmVhayB0aGUgTlZNZSBkcml2ZXIgaWYgdGhlcmUgYXJlIG11bHRpcGxlIG5hbWVzcGFj
ZXM/DQoNCkJhcnQu
