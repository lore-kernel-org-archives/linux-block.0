Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>, "00moses.alexander00@gmail.com"
	<00moses.alexander00@gmail.com>, "joseph.qi@linux.alibaba.com"
	<joseph.qi@linux.alibaba.com>
CC: "nborisov@suse.com" <nborisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "shli@fb.com" <shli@fb.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Date: Wed, 11 Apr 2018 16:42:55 +0000
Message-ID: <bd60302129cb89bdc3b4f402ce4e061f41851729.camel@wdc.com>
References: <20180407102148.GA9729@gmail.com>
	 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
	 <20180411101242.GA2322@gmail.com>
	 <20180411142019.GG793541@devbig577.frc2.facebook.com>
	 <20180411142859.GB2322@gmail.com>
	 <20180411144616.GI793541@devbig577.frc2.facebook.com>
	 <20180411145123.GJ793541@devbig577.frc2.facebook.com>
	 <20180411145632.GK793541@devbig577.frc2.facebook.com>
In-Reply-To: <20180411145632.GK793541@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTExIGF0IDA3OjU2IC0wNzAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IEFu
ZCBsb29raW5nIGF0IHRoZSBjaGFuZ2UsIGl0IGxvb2tzIGxpa2UgdGhlIHJpZ2h0IHRoaW5nIHdl
IHNob3VsZA0KPiBoYXZlIGRvbmUgaXMgY2FjaGluZyBAbG9jayBvbiB0aGUgcHJpbnRfYmxrZyBz
aWRlIGFuZCB3aGVuIHN3aXRjaGluZw0KPiBsb2NrcyBtYWtlIHN1cmUgYm90aCBsb2NrcyBhcmUg
aGVsZC4gIElPVywgZG8gdGhlIGZvbGxvd2luZyBpbg0KPiBibGtfY2xlYW51cF9xdWV1ZSgpDQo+
IA0KPiAJc3Bpbl9sb2NrX2lycShsb2NrKTsNCj4gCWlmIChxLT5xdWV1ZV9sb2NrICE9ICZxLT5f
X3F1ZXVlX2xvY2spIHsNCj4gCQlzcGluX2xvY2soJnEtPl9fcXVldWVfbG9jayk7DQo+IAkJcS0+
cXVldWVfbG9jayA9ICZxLT5fX3F1ZXVlX2xvY2s7DQo+IAkJc3Bpbl91bmxvY2soJnEtPl9fcXVl
dWVfbG9jayk7DQo+IAl9DQo+IAlzcGluX3VubG9ja19pcnEobG9jayk7DQo+IA0KPiBPdGhlcndp
c2UsIHRoZXJlIGNhbiBiZSB0d28gbG9jayBob2xkZXJzIHRoaW5raW5nIHRoZXkgaGF2ZSBleGNs
dXNpdmUNCj4gYWNjZXNzIHRvIHRoZSByZXF1ZXN0X3F1ZXVlLg0KDQpJIHRoaW5rIHRoYXQncyBh
IGJhZCBpZGVhLiBBIGJsb2NrIGRyaXZlciBpcyBhbGxvd2VkIHRvIGRlc3Ryb3kgdGhlDQpzcGlu
bG9jayBpdCBhc3NvY2lhdGVkIHdpdGggdGhlIHJlcXVlc3QgcXVldWUgYXMgc29vbiBhcyBibGtf
Y2xlYW51cF9xdWV1ZSgpDQpoYXMgZmluaXNoZWQuIElmIHRoZSBibG9jayBjZ3JvdXAgY29udHJv
bGxlciB3b3VsZCBjYWNoZSBhIHBvaW50ZXIgdG8gdGhlDQpibG9jayBkcml2ZXIgc3BpbmxvY2sg
dGhlbiB0aGF0IGNvdWxkIGNhdXNlIHRoZSBjZ3JvdXAgY29kZSB0byBhdHRlbXB0IHRvDQpsb2Nr
IGEgc3BpbmxvY2sgYWZ0ZXIgaXQgaGFzIGJlZW4gZGVzdHJveWVkLiBJIGRvbid0IHRoaW5rIHdl
IG5lZWQgdGhhdCBraW5kDQpvZiByYWNlIGNvbmRpdGlvbnMuDQoNCkJhcnQuDQoNCg0KDQo=
