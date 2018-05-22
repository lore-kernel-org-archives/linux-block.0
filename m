Return-Path: <prvs=673874c89=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@intel.com" <keith.busch@intel.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, "sebott@linux.ibm.com"
	<sebott@linux.ibm.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "jianchao.w.wang@oracle.com"
	<jianchao.w.wang@oracle.com>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v13] blk-mq: Rework blk-mq timeout handling again
Date: Tue, 22 May 2018 20:47:17 +0000
Message-ID: <9289a23b2383c47ce7c8428777f47d3d2a8b968a.camel@wdc.com>
References: <20180522162515.20650-1-bart.vanassche@wdc.com>
	 <20180522203349.GB8961@localhost.localdomain>
	 <632c16e5c06edb13c93d61f9164584da470d8a24.camel@wdc.com>
	 <20180522204412.GB9005@localhost.localdomain>
In-Reply-To: <20180522204412.GB9005@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA1LTIyIGF0IDE0OjQ0IC0wNjAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gVHVlLCBNYXkgMjIsIDIwMTggYXQgMDg6MzY6MjdQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hl
IHdyb3RlOg0KPiA+IA0KPiA+IEhhdmUgeW91IG5vdGljZWQgdGhhdCBpZiBibGtfbXFfY29tcGxl
dGVfcmVxdWVzdCgpIGVuY291bnRlcnMgYSByZXF1ZXN0IHdpdGgNCj4gPiBzdGF0ZSBNUV9SUV9U
SU1FRF9PVVQgdGhhdCBpdCBkb2Vzbid0IGNhbGwgX19ibGtfbXFfY29tcGxldGVfcmVxdWVzdCgp
PyBJIHRoaW5rDQo+ID4gdGhlIGNvZGUgaW4gYmxrX21xX2NvbXBsZXRlX3JlcXVlc3QoKSB0b2dl
dGhlciB3aXRoIHRoZSBhYm92ZSBjb2RlIGd1YXJhbnRlZXMNCj4gPiB0aGF0IF9fYmxrX21xX2Nv
bXBsZXRlX3JlcXVlc3QoKSBpcyBvbmx5IGNhbGxlZCBvbmNlIHBlciByZXF1ZXN0IGdlbmVyYXRp
b24uDQo+IA0KPiBPa2F5LCBub3cgdG8gdGhlIEJMS19FSF9OT1RfSEFORExFRCBjYXNlOiB0aGF0
J3Mgc3VwcG9zZWRseSB0aGUgY29ycmVjdA0KPiBzdGF0dXMgdG8gcmV0dXJuIGlmIHRoZSBkcml2
ZXIga25vd3MgYmxrX21xX2NvbXBsZXRlX3JlcXVlc3QoKSB3YXMgY2FsbGVkDQo+IHByaW9yIHRv
IHJldHVybmluZyBmcm9tIHRoZSB0aW1lb3V0IGhhbmRsZXIsIHNvIHdlIG5lZWQgYSBzaW1pbGlh
ciBjaGVjaw0KPiB0aGVyZSwgcmlnaHQ/DQoNCkdvb2QgY2F0Y2guIFRvIG1lIHRoYXQgc2VlbXMg
bGlrZSB0aGUgcmlnaHQgcGxhY2UgdG8gaGFuZGxlIHRoYXQgY2FzZS4NCg0KQmFydC4=
