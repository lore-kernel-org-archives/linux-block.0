Return-Path: <byungchul.park@lge.com>
From: =?utf-8?B?67CV67OR7LKgL+yEoOyehOyXsOq1rOybkC9TVyBQbGF0Zm9ybSjsl7ApQU9U?=
 =?utf-8?B?7YyAKGJ5dW5nY2h1bC5wYXJrQGxnZS5jb20p?= <byungchul.park@lge.com>
To: Coly Li <i@coly.li>, Michael Lyle <mlyle@lyle.org>, Coly Li
	<colyli@suse.de>
CC: "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, Eric Wheeler
	<bcache@lists.ewheeler.net>, Byungchul Park <byungchul.park@lge.com>, Kent
 Overstreet <kent.overstreet@gmail.com>, "kernel-team@lge.com"
	<kernel-team@lge.com>
Date: Tue, 26 Sep 2017 16:16:54 +0900
Subject: RE: [PATCH 04/12] bcache: Don't reinvent the wheel but use existing
 llist API
Message-ID: <F6531D8286A0B34FBC858F176F70796281EEB2@LGEVEXMBHQSVC1.LGE.NET>
References: <20170906062602.50497-1-colyli@suse.de>
 <20170906062602.50497-5-colyli@suse.de>
 <CAJ+L6qfHB7vAAXUrnjXUQqLE6k+v4yukL58DDzRBBKA+aONLmA@mail.gmail.com>
 <761ebe34-99c3-8865-3fc6-c4f7e6e3b29a@coly.li>
In-Reply-To: <761ebe34-99c3-8865-3fc6-c4f7e6e3b29a@coly.li>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb2x5IExpIFttYWlsdG86aUBj
b2x5LmxpXQ0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMTcgNDowOSBQTQ0KPiBU
bzogTWljaGFlbCBMeWxlOyBDb2x5IExpDQo+IENjOiBsaW51eC1iY2FjaGVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGF4Ym9lQGtlcm5lbC5kazsgRXJp
YyBXaGVlbGVyOyBCeXVuZ2NodWwgUGFyazsgS2VudCBPdmVyc3RyZWV0DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMDQvMTJdIGJjYWNoZTogRG9uJ3QgcmVpbnZlbnQgdGhlIHdoZWVsIGJ1dCB1c2Ug
ZXhpc3RpbmcNCj4gbGxpc3QgQVBJDQo+IA0KPiBPbiAyMDE3LzkvMjYg5LiL5Y2IMTI6MzgsIE1p
Y2hhZWwgTHlsZSB3cm90ZToNCj4gPiBJIGJlbGlldmUgdGhpcyBpbnRyb2R1Y2VzIGEgY3JpdGlj
YWwgYnVnLg0KPiA+DQo+ID4gY2wtPmxpc3QgaXMgdXNlZCB0byBsaW5rIHRvZ2V0aGVyIHRoZSBs
bGlzdHMgZm9yIGJvdGggdGhpbmdzIHdhaXRpbmcsDQo+ID4gYW5kIGZvciB0aGluZ3MgdGhhdCBh
cmUgYmVpbmcgd29rZW4uDQo+ID4NCj4gPiBJZiBhIGNsb3N1cmUgdGhhdCBpcyB3b2tlbiBkZWNp
ZGVzIHRvIHdhaXQgYWdhaW4sIGl0IHdpbGwgY29ycnVwdCB0aGUNCj4gPiBsbGlzdCB0aGF0IF9f
Y2xvc3VyZV93YWtlX3VwIGlzIHVzaW5nLg0KPiA+DQo+ID4gVGhlIHByZXZpb3VzIGl0ZXJhdGlv
biBzdHJ1Y3R1cmUgZ2V0cyB0aGUgbmV4dCBlbGVtZW50IG9mIHRoZSBsaXN0DQo+ID4gYmVmb3Jl
IHdha2luZyBhbmQgaXMgdGhlcmVmb3JlIHNhZmUuDQo+ID4NCj4gDQo+IEhpIE1pa2UsDQo+IA0K
PiBHb29kIGNhdGNoISBJIHNlZSBsbGlzdF9kZWxfYWxsKCkgYnV0IGZvcmdldCBjbC0+bGlzdCBj
YW4gYmUgbW9kaWZpZWQgaW4NCj4gY2xvc3VyZV93YWl0KCkuIFllcyB0aGVyZSBpcyBwb3RlbnRp
YWwgY2hhbmNlIHRvIG1pc2xlYWQNCj4gbGxpc3RfZm9yX2VhY2hfZW50cnkoKSB0byBpdGVyYXRl
IHdyb25nIGxpc3QuDQo+IGxsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoKSBzaG91bGQgYmUgdXNl
ZCBoZXJlLiBJIHdpbGwgc2VuZCBhIGZpeCB0bw0KPiBKZW5zLCBob3BlIHRvIGNhdGNoIHVwIDQu
MTQgc3RpbGwuDQoNCkkgc2VlLiBZb3UgaGF2ZSBhIHBsYW4gdG8gZG8gaXQuIFBsZWFzZSBmaXgg
aXQuDQoNClRoYW5rIHlvdS4NCg0KPiBUaGFua3MhDQo+IC0tDQo+IENvbHkgTGkNCg==
