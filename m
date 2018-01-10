Return-Path: <prvs=541b0d852=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "osandov@fb.com"
	<osandov@fb.com>, "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH v2 1/2] blk-mq: Reduce the number of if-statements in
 blk_mq_mark_tag_wait()
Date: Wed, 10 Jan 2018 21:03:22 +0000
Message-ID: <1515618201.2745.28.camel@wdc.com>
References: <20180110193919.6886-1-bart.vanassche@wdc.com>
	 <20180110193919.6886-2-bart.vanassche@wdc.com>
	 <8557bbde-0923-e6d3-b1d3-54e429aadb9f@kernel.dk>
In-Reply-To: <8557bbde-0923-e6d3-b1d3-54e429aadb9f@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTAxLTEwIGF0IDEzOjMwIC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biAxLzEwLzE4IDEyOjM5IFBNLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+ID4gVGhpcyBwYXRj
aCBkb2VzIG5vdCBjaGFuZ2UgYW55IGZ1bmN0aW9uYWxpdHkgYnV0IG1ha2VzIHRoZQ0KPiA+IGJs
a19tcV9tYXJrX3RhZ193YWl0KCkgY29kZSBzbGlnaHRseSBlYXNpZXIgdG8gcmVhZC4NCj4gDQo+
IEkgYWdyZWUgaXQgY291bGQgZG8gd2l0aCBhIGNsZWFudXAsIGJ1dCBob3cgYWJvdXQgc29tZXRo
aW5nIGxpa2UgdGhlDQo+IGJlbG93PyBJIHRoaW5rIHRoYXQncyBlYXNpZXIgdG8gcmVhZC4NCj4g
DQo+IFsgLi4uIF0NCg0KSGVsbG8gSmVucywNCg0KVGhhdCBzb3VuZHMgbGlrZSBhIGdvb2QgaWRl
YSB0byBtZS4gSSB3aWxsIHVwZGF0ZSB0aGUgcGF0Y2ggc2VyaWVzLCByZXRlc3QNCml0IGFuZCBy
ZXBvc3QuDQoNCkJhcnQu
