Return-Path: <prvs=57171364e=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "dmonakhov@openvz.org" <dmonakhov@openvz.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: pass inclusive 'lend' parameter to
 truncate_inode_pages_range
Date: Fri, 9 Feb 2018 15:12:43 +0000
Message-ID: <1518189162.3280.1.camel@wdc.com>
References: <20180209141551.8927-1-ming.lei@redhat.com>
In-Reply-To: <20180209141551.8927-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTAyLTA5IGF0IDIyOjE1ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gVGhl
ICdsZW5kJyBwYXJhbWV0ZXIgb2YgdHJ1bmNhdGVfaW5vZGVfcGFnZXNfcmFuZ2UgaXMgcmVxdWly
ZWQgdG8gYmUNCj4gaW5jbHVzaXZlLCBzbyBmb2xsb3cgdGhlIHJ1bGUuDQo+IA0KPiBUaGlzIHBh
dGNoIGZpeGVzIG9uZSBtZW1vcnkgY29ycnVwdGlvbiB0cmlnZ2VyZWQgYnkgZGlzY2FyZC4NCj4g
DQo+IEZpeGVzOiAzNTE0OTlhMTcyYzAgKCJibG9jazogSW52YWxpZGF0ZSBjYWNoZSBvbiBkaXNj
YXJkIHYyIikNCg0KU2luY2UgdGhpcyBidWcgZ290IGludHJvZHVjZWQgaW4ga2VybmVsIHY0LjE1
IHBsZWFzZSBhZGQgYSAiQ2M6IHN0YWJsZSIgdGFnLg0KUGxlYXNlIGFsc28gQ2M6IHRoZSBhdXRo
b3Igb2YgdGhlIHBhdGNoLg0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg==
