Return-Path: <prvs=635ed6ddf=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "tj@kernel.org" <tj@kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "maxg@mellanox.com"
	<maxg@mellanox.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>
Subject: Re: [PATCH V3] blk-mq: fix race between complete and
 BLK_EH_RESET_TIMER
Date: Sat, 14 Apr 2018 15:22:07 +0000
Message-ID: <60846d0eea47181049fe77a0b303d7e04348b951.camel@wdc.com>
References: <20180412115956.16207-1-ming.lei@redhat.com>
	 <4008f36d-c2c4-25b9-4af5-8efbe9d452c0@kernel.dk>
In-Reply-To: <4008f36d-c2c4-25b9-4af5-8efbe9d452c0@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTA0LTEzIGF0IDIxOjA2IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBJ
IGxpa2UgdGhpcyBhcHByb2FjaCBzaW5jZSBpdCBrZWVwcyB0aGUgY29zdCBvdXRzaWRlIG9mIHRo
ZSBmYXN0DQo+IHBhdGguIEFuZCBpdCdzIGZpbmUgdG8gcmV1c2UgdGhlIHF1ZXVlIGxvY2sgZm9y
IHRoaXMsIGluc3RlYWQgb2YNCj4gYWRkaW5nIGEgc3BlY2lhbCBsb2NrIGZvciBzb21ldGhpbmcg
d2UgY29uc2lkZXIgYSByYXJlIG9jY3VycmVuY2UuDQo+IA0KPiBGcm9tIGEgcXVpY2sgbG9vayB0
aGlzIGxvb2tzIHNhbmUsIGJ1dCBJJ2xsIHRha2UgYSBjbG9zZXIgbG9vaw0KPiB0b21ycm93IGFu
ZCBhZGQgc29tZSB0ZXN0aW5nIHRvby4NCg0KU2hvdWxkbid0IHdlIGtub3cgdGhlIHJvb3QgY2F1
c2Ugb2YgdGhlICJSSVA6IHNjc2lfdGltZXNfb3V0KzB4MTciIGNyYXNoIHJlcG9ydGVkIGluDQpo
dHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTE5OTA3NyBiZWZvcmUg
d2UgZGVjaWRlIGhvdyB0byBwcm9jZWVkPw0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0KDQo=
