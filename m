Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3834 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852AbcEHSmv (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Sun, 8 May 2016 14:42:51 -0400
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"xfs@oss.sgi.com" <xfs@oss.sgi.com>,
	"linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"axboe@fb.com" <axboe@fb.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"david@fromorbit.com" <david@fromorbit.com>,
	"jack@suse.cz" <jack@suse.cz>, "matthew@wil.cx" <matthew@wil.cx>
Subject: Re: [PATCH v4 5/7] fs: prioritize and separate direct_io from dax_io
Date: Sun, 8 May 2016 18:42:37 +0000
Message-ID: <1462732956.3006.4.camel@intel.com>
References: <1461878218-3844-1-git-send-email-vishal.l.verma@intel.com>
	 <1461878218-3844-6-git-send-email-vishal.l.verma@intel.com>
	 <5727753F.6090104@plexistor.com> <20160505142433.GA4557@infradead.org>
	 <CAPcyv4gdmo5m=Arf5sp5izJfNaaAkaaMbOzud8KRcBEC8RRu1Q@mail.gmail.com>
	 <20160505152230.GA3994@infradead.org> <1462484695.29294.7.camel@intel.com>
	 <20160508090115.GE15458@infradead.org>
In-Reply-To: <20160508090115.GE15458@infradead.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

T24gU3VuLCAyMDE2LTA1LTA4IGF0IDAyOjAxIC0wNzAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gT24gVGh1LCBNYXkgMDUsIDIwMTYgYXQgMDk6NDU6MDdQTSArMDAwMCwgVmVybWEsIFZp
c2hhbCBMIHdyb3RlOg0KPiA+IA0KPiA+IEknbSBub3Qgc3VyZSBJIGNvbXBsZXRlbHkgdW5kZXJz
dGFuZCBob3cgdGhpcyB3aWxsIHdvcms/IENhbiB5b3UNCj4gPiBleHBsYWluDQo+ID4gYSBiaXQ/
IFdvdWxkIHdlIGhhdmUgdG8gZXhwb3J0IHJ3X2J5dGVzIHVwIHRvIGxheWVycyBhYm92ZSB0aGUg
cG1lbQ0KPiA+IGRyaXZlcj8gV2hlcmUgZG9lcyBnZXRfdXNlcl9wYWdlcyBjb21lIGluPw0KPiBB
IERBWCBmaWxlc3lzdGVtIGNhbiBkaXJlY3RseSB1c2UgdGhlIG52ZGltbSBsYXllciB0aGUgc2Ft
ZSB3YXkgYnR0DQo+IGRvZSxzIHdoYXQncyB0aGUgcHJvYmxlbT8NCg0KVGhlIEJUVCBkb2VzIHJ3
X2J5dGVzIHRocm91Z2ggYW4gaW50ZXJuYWwtdG8tbGlibnZkaW1tIG1lY2hhbmlzbSwgYnV0DQpy
d19ieXRlcyBpc24ndCBleHBvcnRlZCB0byB0aGUgZmlsZXN5c3RlbSwgY3VycmVudGx5Li4gVG8g
ZG8gdGhpcyB3ZSdkDQpoYXZlIHRvIGVpdGhlciBhZGQgYW4gcndfYnl0ZXMgdG8gYmxvY2sgZGV2
aWNlIG9wZXJhdGlvbnMuLi5vcg0Kc29tZXRoaW5nLg0KDQpBbm90aGVyIHRoaW5nIGlzIHJ3X2J5
dGVzIGN1cnJlbnRseSBkb2Vzbid0IGRvIGVycm9yIGNsZWFyaW5nIGVpdGhlci4NCldlIHN0b3Jl
IGJhZGJsb2NrcyBhdCBzZWN0b3IgZ3JhbnVsYXJpdHksIGFuZCBsaWtlIERhbiBzYWlkIGVhcmxp
ZXIsDQp0aGF0IGhpZGVzIHRoZSBjbGVhcl9lcnJvciBhbGlnbm1lbnQgcmVxdWlyZW1lbnRzIGFu
ZCB1cHBlciBsYXllcnMNCmRvbid0IGhhdmUgdG8gYmUgYXdhcmUgb2YgaXQuIFRvIG1ha2Ugcndf
Ynl0ZXMgY2xlYXIgc3ViLXNlY3RvciBlcnJvcnMsDQp3ZSdkIGhhdmUgdG8gY2hhbmdlIHRoZSBn
cmFudWxhcml0eSBvZiBiYWQtYmxvY2tzLCBhbmQgbWFrZSB1cHBlcg0KbGF5ZXJzIGF3YXJlIG9m
IHRoZSBjbGVhcmluZyBhbGlnbm1lbnQgcmVxdWlyZW1lbnRzLg0KDQpVc2luZyBhIGJsb2NrLXdy
aXRlIHNlbWFudGljIGZvciBjbGVhcmluZyBoaWRlcyBhbGwgdGhpcyBhd2F5Lg0KDQo+IA0KPiBS
ZSBnZXRfdXNlcl9wYWdlcyBteSBpZGVhIHdhcyB0byBzaW1wbHkgdXNlIHRoYXQgdG8gbG9jayBk
b3duIHRoZQ0KPiB1c2VyDQo+IHBhZ2VzIHNvIHRoYXQgd2UgY2FuIGNhbGwgcndfYnl0ZXMgb24g
aXQuwqDCoEhvdyBlbHNlIHdvdWxkIHlvdSBkbw0KPiBpdD/CoMKgRG8NCj4gYSBrbWFsbG9jLCBj
b3B5X2Zyb21fdXNlciBhbmQgdGhlbiBhbm90aGVyIG1lbWNweT8=
