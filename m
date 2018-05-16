Return-Path: <prvs=667b6aabf=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"maxg@mellanox.com" <maxg@mellanox.com>, "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v9 2/2] blk-mq: Rework blk-mq timeout handling again
Date: Wed, 16 May 2018 18:06:16 +0000
Message-ID: <4797ba1736ce53e799a799846704a53af05d2035.camel@wdc.com>
References: <20180515225124.20428-1-bart.vanassche@wdc.com>
	 <20180515225124.20428-6-bart.vanassche@wdc.com>
	 <20180516125110.GA32078@lst.de>
	 <8058d72fef475caffa78c962bc4220f5f8fa3dde.camel@wdc.com>
	 <20180516162432.GA4398@lst.de>
	 <bd17181940994eb459e84e4d5940b1af8a725ded.camel@wdc.com>
	 <20180516173158.GA6022@lst.de>
In-Reply-To: <20180516173158.GA6022@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA1LTE2IGF0IDE5OjMxICswMjAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBP
biBXZWQsIE1heSAxNiwgMjAxOCBhdCAwNDo0Nzo1NFBNICswMDAwLCBCYXJ0IFZhbiBBc3NjaGUg
d3JvdGU6DQo+ID4gSSB0aGluayB5b3VyIHBhdGNoIGNoYW5nZXMgdGhlIG9yZGVyIG9mIGNoYW5n
aW5nIHRoZSByZXF1ZXN0IHN0YXRlIGFuZA0KPiA+IGNhbGxpbmcgbW9kX3RpbWVyKCkuIEluIG15
IHBhdGNoIHRoZSByZXF1ZXN0IHN0YXRlIGFuZCB0aGUgZGVhZGxpbmUgYXJlDQo+ID4gdXBkYXRl
ZCBmaXJzdCBhbmQgbW9kX3RpbWVyKCkgaXMgY2FsbGVkIGFmdGVyd2FyZHMuIEkgdGhpbmsgeW91
ciBwYXRjaA0KPiA+IGNoYW5nZXMgdGhlIG9yZGVyIG9mIHRoZXNlIG9wZXJhdGlvbnMgaW50byB0
aGUgZm9sbG93aW5nOg0KPiA+ICgxKSBfX2Jsa19tcV9zdGFydF9yZXF1ZXN0KCkgc2V0cyB0aGUg
cmVxdWVzdCBkZWFkbGluZS4NCj4gPiAoMikgX19ibGtfbXFfc3RhcnRfcmVxdWVzdCgpIGNhbGxz
IF9fYmxrX2FkZF90aW1lcigpIHdoaWNoIGluIHR1cm4gY2FsbHMNCj4gPiAgICAgbW9kX3RpbWVy
KCkuDQo+ID4gKDMpIF9fYmxrX21xX3N0YXJ0X3JlcXVlc3QoKSBjaGFuZ2VzIHRoZSByZXF1ZXN0
IHN0YXRlIGludG8gTVFfUlFfSU5fRkxJR0hULg0KPiA+IA0KPiA+IEluIHRoZSB1bmxpa2VseSBl
dmVudCBvZiBhIHNpZ25pZmljYW50IGRlbGF5IGJldHdlZW4gKDIpIGFuZCAoMykgaXQgY2FuDQo+
ID4gaGFwcGVuIHRoYXQgdGhlIHRpbWVyIGZpcmVzIGFuZCBleGFtaW5lcyBhbmQgaWdub3JlcyB0
aGUgcmVxdWVzdCBiZWNhdXNlDQo+ID4gaXRzIHN0YXRlIGRpZmZlcnMgZnJvbSBNUV9SUV9JTl9G
TElHSFQuIElmIHRoZSByZXF1ZXN0IGZvciB3aGljaCB0aGlzDQo+ID4gaGFwcGVuZWQgdGltZXMg
b3V0IGl0cyB0aW1lb3V0IHdpbGwgb25seSBiZSBoYW5kbGVkIHRoZSBuZXh0IHRpbWUNCj4gPiBi
bGtfbXFfdGltZW91dF93b3JrKCkgaXMgY2FsbGVkLiBJcyB0aGlzIHRoZSBiZWhhdmlvciB5b3Ug
aW50ZW5kZWQ/DQo+IA0KPiBXZSBjYW4gbW92ZSB0aGUgdGltZXIgbWFuaXB1bGF0aW9uIGFmdGVy
IHRoZSBjaGFuZ2UgZWFzaWx5IEkgdGhpbmsuDQo+IEl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gYWRk
IGNvbW1lbnRzIGV4cGxhaW5pbmcgdGhlIG9yZGVyaW5nLg0KDQpIZWxsbyBDaHJpc3RvcGgsDQoN
CkknbSBhZnJhaWQgdGhhdCBjb3VsZCBsZWFkIHRvIG1vZF90aW1lcigpIGJlaW5nIGNhbGxlZCBp
biBhbm90aGVyIG9yZGVyIHRoYW4NCmludGVuZGVkLiBJZiBlLmcuIHRoZSBjb2RlIHRoYXQgaGFu
ZGxlcyBCTEtfRUhfUkVTRVRfVElNRVIgY2hhbmdlcyB0aGUgcmVxdWVzdA0Kc3RhdGUgZmlyc3Qg
dG8gaW4tZmxpZ2h0IGFuZCBuZXh0IGNhbGxzIG1vZF90aW1lcigpIHRoZW4gaXQgY2FuIGhhcHBl
biB0aGF0DQphbm90aGVyIGNvbnRleHQgY29tcGxldGVzIGFuZCByZXN0YXJ0cyB0aGUgcmVxdWVz
dCwgcmVzdWx0aW5nIGluIGEgY29uY3VycmVudA0KbW9kX3RpbWVyKCkgY2FsbC4gSSdtIG5vdCBz
dXJlIHJlb3JkZXJpbmcgb2YgdGhlIG1vZF90aW1lcigpIGNhbGxzIHdvdWxkIHJlc3VsdA0KaW4g
Y29ycmVjdCBiZWhhdmlvci4NCg0KQmFydC4NCg0KDQo=
