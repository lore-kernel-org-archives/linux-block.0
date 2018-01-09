Return-Path: <prvs=540be3476=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/4] block: add accessors for setting/querying request
 deadline
Date: Tue, 9 Jan 2018 18:40:34 +0000
Message-ID: <1515523233.2721.16.camel@wdc.com>
References: <1515522422-21596-1-git-send-email-axboe@kernel.dk>
	 <1515522422-21596-3-git-send-email-axboe@kernel.dk>
In-Reply-To: <1515522422-21596-3-git-send-email-axboe@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTAxLTA5IGF0IDExOjI3IC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiAr
c3RhdGljIGlubGluZSB2b2lkIGJsa19ycV9zZXRfZGVhZGxpbmUoc3RydWN0IHJlcXVlc3QgKnJx
LCB1bnNpZ25lZCBsb25nIHRpbWUpDQo+ICt7DQo+ICsJcnEtPl9fZGVhZGxpbmUgPSB0aW1lICYg
fjB4MTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGJsa19ycV9k
ZWFkbGluZShzdHJ1Y3QgcmVxdWVzdCAqcnEpDQo+ICt7DQo+ICsJcmV0dXJuIHJxLT5fX2RlYWRs
aW5lICYgfjB4MTsNCj4gK30NCg0KSGVsbG8gSmVucywNCg0KVGhlIHR5cGUgb2YgcnEtPl9fZGVh
ZGxpbmUgaXMgInVuc2lnbmVkIGxvbmciIGJ1dCB0aGUgdHlwZSBvZiB0aGUgcmlnaHQtaGFuZA0K
c2lkZSBjb25zdGFudCBpcyBpbnQuIFNob3VsZG4ndCBhbiAiVUwiIHN1ZmZpeCBiZSBhZGRlZCB0
byB0aGUgUkhTIGNvbnN0YW50Pw0KDQpUaGFua3MsDQoNCkJhcnQu
