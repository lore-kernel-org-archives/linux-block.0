Return-Path: <prvs=465790858=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"dann.frazier@canonical.com" <dann.frazier@canonical.com>
Subject: Re: [PATCH v2] virtio_blk: Fix an SG_IO regression
Date: Thu, 26 Oct 2017 04:44:26 +0000
Message-ID: <1508993064.8734.5.camel@wdc.com>
References: <20171025095617.7315-1-bart.vanassche@wdc.com>
	 <11a35a46-dc51-c32f-cb64-793d9dd02c53@kernel.dk>
	 <1508959556.5073.1.camel@wdc.com>
	 <83926138-e6aa-6792-5275-31f5c1330c90@kernel.dk>
In-Reply-To: <83926138-e6aa-6792-5275-31f5c1330c90@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE3LTEwLTI1IGF0IDEyOjM0IC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biAxMC8yNS8yMDE3IDEyOjI1IFBNLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gT24gV2Vk
LCAyMDE3LTEwLTI1IGF0IDExOjIzIC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiA+ID4gT24g
MTAvMjUvMjAxNyAwMjo1NiBBTSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiA+ID4gPiBBdm9p
ZCB0aGF0IHN1Ym1pdHRpbmcgYW4gU0dfSU8gaW9jdGwgdHJpZ2dlcnMgYSBrZXJuZWwgb29wcyB0
aGF0DQo+ID4gPiA+IGlzIHByZWNlZGVkIGJ5Og0KPiA+ID4gPiANCj4gPiA+ID4gdXNlcmNvcHk6
IGtlcm5lbCBtZW1vcnkgb3ZlcndyaXRlIGF0dGVtcHQgZGV0ZWN0ZWQgdG8gKG51bGwpICg8bnVs
bD4pICg2IGJ5dGVzKQ0KPiA+ID4gPiBrZXJuZWwgQlVHIGF0IG1tL3VzZXJjb3B5LmM6NzIhDQo+
ID4gPiANCj4gPiA+IFNlZW1zIEkgc2F3IGEgbm90ZSBvbiBhIHJ1bnRpbWUgb29wcyB0cmlnZ2Vy
ZWQgYnkgdGhpcyBwYXRjaCB5ZXN0ZXJkYXksDQo+ID4gPiBidXQgbm93IEkgY2FuJ3Qgc2VlbSB0
byBmaW5kIGl0Li4uIERpZCB5b3Ugc2VlIGl0Pw0KPiA+IA0KPiA+IERvIHlvdSBwZXJoYXBzIHdh
bnQgbWUgdG8gYWRkIHRoZSBzdGFjayB0cmFjZSBmcm9tIHRoZSBmb2xsb3dpbmcgZS1tYWlsIHRv
DQo+ID4gdGhlIHBhdGNoIGRlc2NyaXB0aW9uOiBodHRwczovL21hcmMuaW5mby8/bD1saW51eC1h
cm0ta2VybmVsJm09MTUwODU0MDEwMzIxODMzID8NCj4gDQo+IEl0IHdhcyBhbiBvb3BzIHJlcG9y
dGVkIGFnYWluc3QgdGhlIGN1cnJlbnQgcGF0Y2gsIHVubGVzcyBJJ20gbWlzdGFrZW4uIEhhcmQN
Cj4gdG8gc2F5LCB3aGVuIEkgY2FuJ3QgZmluZCB0aGUgZW1haWwgdGhpcyBtb3JuaW5nLCBtYXkg
aGF2ZSBiZWVuIGRlbGV0ZWQuLi4NCj4gVGhhdCdzIHdoeSBJIGFza2VkIGlmIHlvdSBzYXcgaXQu
DQoNCkp1c3QgZm91bmQgaXQ6IGE1NzA4NDNlZTkgKCJ2aXJ0aW9fYmxrOiBGaXggYW4gU0dfSU8g
cmVncmVzc2lvbiIpOiBrZXJuZWwgQlVHIGF0DQppbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0Lmg6
OTIhIChodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNy8xMC8yNC8xMTE3KS4gV2lsbCBoYXZlDQph
IGxvb2suDQoNCkJhcnQuDQo=
