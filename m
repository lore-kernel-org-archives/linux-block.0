Return-Path: <prvs=630dc1010=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "joseph.qi@linux.alibaba.com"
	<joseph.qi@linux.alibaba.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [block regression] kernel oops triggered by removing scsi device
 dring IO
Date: Mon, 9 Apr 2018 23:07:15 +0000
Message-ID: <51a76a84b453ed2c5760de2ddfdbc8bb2302064d.camel@wdc.com>
References: <20180408042112.GB19128@ming.t460p>
	 <678220c26fa1677ab162006620b345ea4f38c86b.camel@wdc.com>
	 <44abf88a-ded4-bbf5-8410-6692ee5ebabb@linux.alibaba.com>
	 <f7dd2dceb3767a0f1fad571b57f5f8e09afb3c3e.camel@wdc.com>
	 <d31f4b4f-5f8f-a247-7c4b-a88d9895681d@kernel.dk>
In-Reply-To: <d31f4b4f-5f8f-a247-7c4b-a88d9895681d@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTA0LTA5IGF0IDE2OjU4IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBU
aGlzIGVuZHMgdXAgYmVpbmcgbnV0dHkgaW4gdGhlIGdlbmVyaWNfbWFrZV9yZXF1ZXN0KCkgY2Fz
ZSwgd2hlcmUgd2UNCj4gZG8gdGhlIGV4YWN0IHNhbWUgZW50ZXIvZXhpdCBsb2dpYyByaWdodCBh
ZnRlci4gVGhhdCBuZWVkcyB0byBnZXQgdW5pZmllZC4NCj4gTWF5YmUgbW92ZSB0aGUgcXVldWUg
ZW50ZXIgaW50byBnZW5lcmljX21ha2VfcmVxdWVzdF9jaGVja3MoKSwgYW5kIGV4aXQNCj4gaW4g
dGhlIGNhbGxlcj8NCg0KSGVsbG8gSmVucywNCg0KVGhlcmUgaXMgYSBjaGFsbGVuZ2U6IGdlbmVy
aWNfbWFrZV9yZXF1ZXN0KCkgc3VwcG9ydHMgYmlvIGNoYWlucyBpbiB3aGljaA0KZGlmZmVyZW50
IGJpbydzIGFwcGx5IHRvIGRpZmZlcmVudCByZXF1ZXN0IHF1ZXVlcyBhbmQgaXQgYWxzbyBzdXBw
b3J0IGJpbw0KY2hhaW5zIGluIHdoaWNoIHNvbWUgYmlvJ3MgaGF2ZSB0aGUgZmxhZyBSRVFfV0FJ
VCBzZXQgYW5kIG90aGVycyBub3QuIElzDQppdCBzYWZlIHRvIGRyb3AgdGhhdCBzdXBwb3J0Pw0K
DQpUaGFua3MsDQoNCkJhcnQuDQoNCg0K
