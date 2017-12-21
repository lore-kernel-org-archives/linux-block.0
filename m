Return-Path: <prvs=521789f35=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>,
	"oleg@redhat.com" <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCHSET v2] blk-mq: reimplement timeout handling
Date: Thu, 21 Dec 2017 01:00:47 +0000
Message-ID: <1513818046.2603.39.camel@wdc.com>
References: <20171212190134.535941-1-tj@kernel.org>
	 <1513813261.2603.36.camel@wdc.com>
	 <20171221000805.GC1084507@devbig577.frc2.facebook.com>
In-Reply-To: <20171221000805.GC1084507@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE3LTEyLTIwIGF0IDE2OjA4IC0wODAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBPbiBXZWQsIERlYyAyMCwgMjAxNyBhdCAxMTo0MTowMlBNICswMDAwLCBCYXJ0IFZhbiBBc3Nj
aGUgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDE3LTEyLTEyIGF0IDExOjAxIC0wODAwLCBUZWp1biBI
ZW8gd3JvdGU6DQo+ID4gPiBDdXJyZW50bHksIGJsay1tcSB0aW1lb3V0IHBhdGggc3luY2hyb25p
emVzIGFnYWluc3QgdGhlIHVzdWFsDQo+ID4gPiBpc3N1ZS9jb21wbGV0aW9uIHBhdGggdXNpbmcg
YSBjb21wbGV4IHNjaGVtZSBpbnZvbHZpbmcgYXRvbWljDQo+ID4gPiBiaXRmbGFncywgUkVRX0FU
T01fKiwgbWVtb3J5IGJhcnJpZXJzIGFuZCBzdWJ0bGUgbWVtb3J5IGNvaGVyZW5jZQ0KPiA+ID4g
cnVsZXMuICBVbmZvcnR1bmF0bGV5LCBpdCBjb250YWlucyBxdWl0ZSBhIGZldyBob2xlcy4NCj4g
PiANCj4gPiBIZWxsbyBUZWp1biwNCj4gPiANCj4gPiBBbiBhdHRlbXB0IHRvIHJ1biBTQ1NJIEkv
TyB3aXRoIHRoaXMgcGF0Y2ggc2VyaWVzIGFwcGxpZWQgcmVzdWx0ZWQgaW4NCj4gPiB0aGUgZm9s
bG93aW5nOg0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgdHJ5IHRoZSB2Mz8gIFRoZXJlIHdlcmUgYSBj
b3VwbGUgYnVncyB0aGF0IEkgbWlzc2VkDQo+IHdoaWxlIHRlc3RpbmcgZWFybGllciB2ZXJzaW9u
cy4NCj4gDQo+ICBodHRwOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxNzEyMTYxMjA3MjYuNTE3MTUz
LTEtdGpAa2VybmVsLm9yZw0KDQpXaWxsIGRvLiBCdXQgcGxlYXNlIENjOiBsaW51eC1ibG9jayBp
biBjYXNlIHlvdSB3b3VsZCBwb3N0IGEgdjQgb2YgdGhpcyBwYXRjaA0Kc2VyaWVzLiBJIHNlYXJj
aGVkIHRoZSBsaW51eC1ibG9jayBmb2xkZXIgb2YgbXkgbWFpbGJveCBmb3IgdGhlIGxhdGVzdCB2
ZXJzaW9uDQpvZiB0aGlzIHBhdGNoIHNlcmllcyBhbmQgdGhhdCBpcyBob3cgSSBlbmRlZCB1cCB0
ZXN0aW5nIHYyIGluc3RlYWQgb2YgdjMgLi4uDQoNCkJhcnQu
