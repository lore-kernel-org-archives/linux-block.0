Return-Path: <prvs=6616f3864=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@intel.com" <keith.busch@intel.com>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"loberman@redhat.com" <loberman@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V4 1/7] block: introduce blk_quiesce_timeout() and
 blk_unquiesce_timeout()
Date: Thu, 10 May 2018 15:01:04 +0000
Message-ID: <4cf98f8d3d763ab3decb5f4bfaee6a4394de5caf.camel@wdc.com>
References: <20180505135905.18815-1-ming.lei@redhat.com>
	 <20180505135905.18815-2-ming.lei@redhat.com>
In-Reply-To: <20180505135905.18815-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gU2F0LCAyMDE4LTA1LTA1IGF0IDIxOjU4ICswODAwLCBNaW5nIExlaSB3cm90ZToNCj4gVHVy
bnMgb3V0IHRoZSBjdXJyZW50IHdheSBjYW4ndCBkcmFpbiB0aW1vdXQgY29tcGxldGVseSBiZWNh
dXNlIG1vZF90aW1lcigpDQo+IGNhbiBiZSB0cmlnZ2VyZWQgaW4gdGhlIHdvcmsgZnVuYywgd2hp
Y2ggY2FuIGJlIGp1c3QgcnVuIGluc2lkZSB0aGUgc3luY2VkDQo+IHRpbWVvdXQgd29yazoNCj4g
DQo+ICAgICAgICAgZGVsX3RpbWVyX3N5bmMoJnEtPnRpbWVvdXQpOw0KPiAgICAgICAgIGNhbmNl
bF93b3JrX3N5bmMoJnEtPnRpbWVvdXRfd29yayk7DQo+IA0KPiBUaGlzIHBhdGNoIGludHJvZHVj
ZXMgb25lIGZsYWcgb2YgJ3RpbWVvdXRfb2ZmJyBmb3IgZml4aW5nIHRoaXMgaXNzdWUsIHR1cm5z
DQo+IG91dCB0aGlzIHNpbXBsZSB3YXkgZG9lcyB3b3JrLg0KPiANCj4gQWxzbyBibGtfcXVpZXNj
ZV90aW1lb3V0KCkgYW5kIGJsa191bnF1aWVzY2VfdGltZW91dCgpIGFyZSBpbnRyb2R1Y2VkIGZv
cg0KPiBkcmFpbmluZyB0aW1lb3V0LCB3aGljaCBpcyBuZWVkZWQgYnkgTlZNZS4NCg0KSGVsbG8g
TWluZywNCg0KVGhlIGRlc2NyaXB0aW9uIG9mIHRoZSBhYm92ZSBwYXRjaCBkb2VzIG5vdCBtb3Rp
dmF0ZSBzdWZmaWNpZW50bHkgd2h5IHlvdSB0aGluaw0KdGhhdCB0aGlzIGNoYW5nZSBpcyBuZWNl
c3NhcnkuIEFzIHlvdSBrbm93IGl0IGlzIGFscmVhZHkgcG9zc2libGUgdG8gd2FpdCB1bnRpbA0K
dGltZW91dCBoYW5kbGluZyBoYXMgZmluaXNoZWQgYnkgY2FsbGluZyBibGtfbXFfZnJlZXplX3F1
ZXVlKCkgKw0KYmxrX21xX3VuZnJlZXplX3F1ZXVlKCkuIEFuIGV4cGxhbmF0aW9uIGlzIG5lZWRl
ZCBvZiB3aHkgeW91IHRoaW5rIHRoYXQgY2FsbGluZw0KYmxrX21xX2ZyZWV6ZV9xdWV1ZSgpICsg
YmxrX21xX3VuZnJlZXplX3F1ZXVlKCkgaXMgbm90IHN1ZmZpY2llbnQgYW5kIHdoeSB5b3UNCmNo
b3NlIHRoZSBzb2x1dGlvbiBpbXBsZW1lbnRlZCBpbiB0aGlzIHBhdGNoLg0KDQpUaGFua3MsDQoN
CkJhcnQuDQoNCg0KDQo=
