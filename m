Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "tj@kernel.org" <tj@kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "maxg@mellanox.com"
	<maxg@mellanox.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] blk-mq: fix race between complete and BLK_EH_RESET_TIMER
Date: Wed, 11 Apr 2018 22:49:51 +0000
Message-ID: <2ed5dc7a4d1553c7ba3f9bbe43aac313eba29dc8.camel@wdc.com>
References: <20180411205529.31145-1-ming.lei@redhat.com>
In-Reply-To: <20180411205529.31145-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE4LTA0LTEyIGF0IDA0OjU1ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gK2Fn
YWluOg0KPiAgCXN3aXRjaCAocmV0KSB7DQo+ICAJY2FzZSBCTEtfRUhfSEFORExFRDoNCj4gIAkJ
X19ibGtfbXFfY29tcGxldGVfcmVxdWVzdChyZXEpOw0KPiAgCQlicmVhazsNCj4gIAljYXNlIEJM
S19FSF9SRVNFVF9USU1FUjoNCj4gIAkJWyAuLi4gXQ0KPiArCQlzcGluX2xvY2tfaXJxc2F2ZShy
ZXEtPnEtPnF1ZXVlX2xvY2ssIGZsYWdzKTsNCj4gKwkJaWYgKGJsa19tcV9ycV9zdGF0ZShyZXEp
ICE9IE1RX1JRX0NPTVBMRVRFX0lOX1JFU0VUKSB7DQo+ICsJCQlibGtfbXFfcnFfdXBkYXRlX2Fi
b3J0ZWRfZ3N0YXRlKHJlcSwgMCk7DQo+ICsJCQlibGtfYWRkX3RpbWVyKHJlcSk7DQo+ICsJCX0g
ZWxzZSB7DQo+ICsJCQlibGtfbXFfcnFfdXBkYXRlX3N0YXRlKHJlcSwgTVFfUlFfSU5fRkxJR0hU
KTsNCj4gKwkJCXJldCA9IEJMS19FSF9IQU5ETEVEOw0KPiArCQkJZ290byBhZ2FpbjsNCj4gKwkJ
fQ0KPiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKHJlcS0+cS0+cXVldWVfbG9jaywgZmxhZ3Mp
Ow0KDQpEb2VzIHRoZSBhYm92ZSBjaHVuayBpbnRyb2R1Y2UgYSBiYWNrd2FyZHMgZ290byBmcm9t
IGluc2lkZSBhIHJlZ2lvbiBhcm91bmQNCndoaWNoIGEgc3BpbmxvY2sgaXMgaGVsZCB0byBvdXRz
aWRlIHRoYXQgcmVnaW9uPyBDYW4gc3VjaCBhIGdvdG8gcmVzdWx0IGluDQphbnl0aGluZyBlbHNl
IHRoYW4gYSBkZWFkbG9jaz8NCg0KVGhhbmtzLA0KDQpCYXJ0Lg0KDQoNCg0K
