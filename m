Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>
CC: "hch@lst.de" <hch@lst.de>, "tj@kernel.org" <tj@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "cl@linux.com"
	<cl@linux.com>, "neilb@suse.com" <neilb@suse.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: Re: [PATCH 1/5] percpu-refcount: Introduce
 percpu_ref_switch_to_atomic_nowait()
Date: Mon, 11 Sep 2017 16:10:54 +0000
Message-ID: <1505146253.2802.23.camel@wdc.com>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
	 <20170908235226.26622-2-bart.vanassche@wdc.com>
	 <20170911084249.rrwccvjqxj4zyudf@linux-x5ow.site>
In-Reply-To: <20170911084249.rrwccvjqxj4zyudf@linux-x5ow.site>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE3LTA5LTExIGF0IDEwOjQyICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IE9uIEZyaSwgU2VwIDA4LCAyMDE3IGF0IDA0OjUyOjIyUE0gLTA3MDAsIEJhcnQgVmFu
IEFzc2NoZSB3cm90ZToNCj4gPiArLyoqDQo+ID4gKyAqIHBlcmNwdV9yZWZfc3dpdGNoX3RvX25v
d2FpdCAtIHN3aXRjaCBhIHBlcmNwdV9yZWYgdG8gYXRvbWljIG1vZGUNCj4gDQo+IFRoaXMgc2hv
dWxkIHByb2JhYmx5IHJlYWQgcGVyY3B1X3JlZl9zd2l0Y2hfdG9fYXRvbWljX25vd2FpdCwgc2hv
dWxkbid0IGl0Pw0KDQpJbmRlZWQuIFRoYW5rcyBmb3IgaGF2aW5nIGNhdWdodCBhbmQgcmVwb3J0
ZWQgdGhpcy4gSSB3aWxsIGFkZHJlc3MgdGhpcw0Kd2hlbiBJIHJlc3VibWl0IHRoaXMgcGF0Y2gg
c2VyaWVzLg0KDQpCYXJ0Lg==
