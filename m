Return-Path: <prvs=6487dbab9=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"snitzer@redhat.com" <snitzer@redhat.com>, "hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "hare@suse.de"
	<hare@suse.de>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"don.brace@microsemi.com" <don.brace@microsemi.com>,
	"james.bottomley@hansenpartnership.com"
	<james.bottomley@hansenpartnership.com>, "osandov@fb.com" <osandov@fb.com>,
	"loberman@redhat.com" <loberman@redhat.com>, "kashyap.desai@broadcom.com"
	<kashyap.desai@broadcom.com>
Subject: Re: [PATCH 0/3] scsi: scsi-mq: don't hold host_busy in IO path
Date: Fri, 27 Apr 2018 15:48:27 +0000
Message-ID: <647b4fe833fdf001f724cfa0803c9e3a79d78b13.camel@wdc.com>
References: <20180420065742.8043-1-ming.lei@redhat.com>
	 <87619135ac0bfefa07f510170024b609e641db0c.camel@wdc.com>
	 <607c4d2f-28e7-4152-dbf5-7fb4387e9413@kernel.dk>
In-Reply-To: <607c4d2f-28e7-4152-dbf5-7fb4387e9413@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTA0LTI3IGF0IDA5OjM5IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBi
bGtfbXFfdGFnc2V0X2J1c3lfaXRlcigmc2hvc3QtPnRhZ19zZXQsIHNjc2lfaG9zdF9jaGVja19p
bl9mbGlnaHQsDQo+IAkJCSZpbl9mbGlnaHQpOw0KPiByZXR1cm4gaW5fZmxpZ2h0LmNudCArIGF0
b21pY19yZWFkKCZzaG9zdC0+aG9zdF9idXN5KTsNCj4gDQo+IFRoZSBhdG9taWMgcmVhZCBpcyBi
YXNpY2FsbHkgZnJlZSwgb25jZSB3ZSBnZXQgcmlkIG9mIHRoZSBkaXJ0eSBvZiB0aGF0DQo+IHZh
cmlhYmxlIG9uIGVhY2ggSU8uDQoNCkhlbGxvIEplbnMsDQoNCldoYXQgbWFrZXMgeW91IHRoaW5r
IHRoYXQgIiArIGF0b21pY19yZWFkKCZzaG9zdC0+aG9zdF9idXN5KSIgaXMgbmVjZXNzYXJ5Pw0K
SSBhbSBub3QgYXdhcmUgb2YgYW55IGNvZGUgb3V0c2lkZSB0aGUgU0NTSSBjb3JlIHRoYXQgbW9k
aWZpZXMgdGhlIGhvc3RfYnVzeQ0KbWVtYmVyLg0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0KDQo=
