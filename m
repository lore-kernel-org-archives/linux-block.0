Return-Path: <prvs=5014e5409=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH] blk-mq: improve tag waiting setup for non-shared tags
Date: Fri, 1 Dec 2017 17:09:43 +0000
Message-ID: <1512148182.2520.14.camel@wdc.com>
References: <3649d84b-978d-ce1b-a8bc-5735b07296a7@kernel.dk>
In-Reply-To: <3649d84b-978d-ce1b-a8bc-5735b07296a7@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE3LTExLTA5IGF0IDE2OjAwIC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiAr
CQlzcGluX2xvY2soJnRoaXNfaGN0eC0+bG9jayk7DQo+ICsJCWlmICghbGlzdF9lbXB0eSgmd2Fp
dC0+ZW50cnkpKSB7DQo+ICsJCQlzcGluX3VubG9jaygmdGhpc19oY3R4LT5sb2NrKTsNCj4gKwkJ
CXJldHVybiBmYWxzZTsNCj4gKwkJfQ0KPiAgDQo+IC0Jd3MgPSBidF93YWl0X3B0cigmdGhpc19o
Y3R4LT50YWdzLT5iaXRtYXBfdGFncywgdGhpc19oY3R4KTsNCj4gLQlhZGRfd2FpdF9xdWV1ZSgm
d3MtPndhaXQsIHdhaXQpOw0KPiArCQl3cyA9IGJ0X3dhaXRfcHRyKCZ0aGlzX2hjdHgtPnRhZ3Mt
PmJpdG1hcF90YWdzLCB0aGlzX2hjdHgpOw0KPiArCQlhZGRfd2FpdF9xdWV1ZSgmd3MtPndhaXQs
IHdhaXQpOw0KPiArCX0NCg0KSGVsbG8gSmVucywNCg0KTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0
IGFsbCBjb2RlIHRoYXQgYWRkcyBhIGRpc3BhdGNoX3dhaXQgZW50cnkgdG8gYSB3YWl0DQpxdWV1
ZSBvciByZW1vdmVzIGl0IGZyb20gYSB3YWl0IHF1ZXVlIGlzIHByb3RlY3RlZCBieSB3cy0+d2Fp
dC5sb2NrLiBDYW4geW91DQpleHBsYWluIHdoeSB0aGUgYWJvdmUgbGlzdF9lbXB0eSgpIGNoZWNr
IGlzIHByb3RlY3RlZCBieSB0aGlzX2hjdHgtPmxvY2s/DQoNClRoYW5rcywNCg0KQmFydC4=
