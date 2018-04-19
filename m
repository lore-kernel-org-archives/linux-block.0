Return-Path: <prvs=6401ab460=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"wakko@animx.eu.org" <wakko@animx.eu.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "target-devel@vger.kernel.org"
	<target-devel@vger.kernel.org>, "nab@linux-iscsi.org" <nab@linux-iscsi.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: Re: [PATCH] target: fix crash with iscsi target and dvd
Date: Thu, 19 Apr 2018 03:40:58 +0000
Message-ID: <feaee6199a8b9bcd9e31a276192d3d41e14c5ae7.camel@wdc.com>
References: <20180416094841.30212-1-ming.lei@redhat.com>
	 <20180417151502.GB24654@lst.de> <yq1fu3rnaez.fsf@oracle.com>
In-Reply-To: <yq1fu3rnaez.fsf@oracle.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTE4IGF0IDIzOjI3IC0wNDAwLCBNYXJ0aW4gSy4gUGV0ZXJzZW4gd3Jv
dGU6DQo+IENocmlzdG9waCwNCj4gDQo+ID4gQnR3LCBzZWVtcyBsaWtlIHNvbWVvbmUgbmVlZHMg
dG8gdm9sdW50ZWVyIGZvciBwdXR0aW5nIHRvZ2V0aGVyIGEgcHVsbA0KPiA+IHJlcXVlc3Qgd2l0
aCB0YXJnZXQgZml4ZXMgZm9yIExpbnVzIC0gSSBoYXZlbid0IGhlYXJkIGZyb20gTmljIGZvciBh
DQo+ID4gd2hpbGUsIGFuZCB3ZSd2ZSBnb3QgcXVpdGUgYSBmZXcgZml4ZXMgb3V0IG9uIHRoZSBs
aXN0Lg0KPiANCj4gU3RpbGwgaGFwcHkgdG8gdGFrZSB0aGluZ3MgdGhyb3VnaCBTQ1NJIGlmIE5p
YyBkb2Vzbid0IG1hdGVyaWFsaXplLg0KDQpIZWxsbyBNYXJ0aW4sDQoNCkNhbiB5b3UgaGF2ZSBh
IGxvb2sgYXQgdGhlIGZvbGxvd2luZyBwYXRjaCBzZXJpZXM6ICJbUEFUQ0ggMDAvMTRdIFNDU0kg
dGFyZ2V0DQpwYXRjaGVzIGZvciBrZXJuZWwgdjQuMTciIChodHRwczovL3d3dy5zcGluaWNzLm5l
dC9saXN0cy90YXJnZXQtZGV2ZWwvbXNnMTY1MjMuaHRtbCAvDQpodHRwczovL3BhdGNod29yay5r
ZXJuZWwub3JnL3Byb2plY3QvdGFyZ2V0LWRldmVsL2xpc3QvKS4gUGxlYXNlIGxldCBtZSBrbm93
IGlmIHlvdQ0Kd2FudCBtZSB0byByZXBvc3QgdGhhdCBwYXRjaCBzZXJpZXMuDQoNClRoYW5rcywN
Cg0KQmFydC4NCg0KDQoNCg==
