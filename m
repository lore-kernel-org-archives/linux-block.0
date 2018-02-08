Return-Path: <prvs=570d9c77a=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>
CC: "hch@lst.de" <hch@lst.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"idanb@mellanox.com" <idanb@mellanox.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: Re: [PATCH rfc 3/5] irq_poll: wire up irq_am
Date: Thu, 8 Feb 2018 01:28:25 +0000
Message-ID: <1518053304.2870.95.camel@wdc.com>
References: <20180205220316.30236-1-sagi@grimberg.me>
	 <20180205220316.30236-4-sagi@grimberg.me>
In-Reply-To: <20180205220316.30236-4-sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTAyLTA2IGF0IDAwOjAzICswMjAwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0K
PiArdm9pZCBpcnFfcG9sbF9pbml0X2FtKHN0cnVjdCBpcnFfcG9sbCAqaW9wLCB1bnNpZ25lZCBp
bnQgbnJfZXZlbnRzLA0KPiArICAgICAgICB1bnNpZ25lZCBzaG9ydCBucl9sZXZlbHMsIHVuc2ln
bmVkIHNob3J0IHN0YXJ0X2xldmVsLCBpcnFfcG9sbF9hbV9mbiAqYW1mbikNCj4gK3sNCj4gKwlp
b3AtPmFtZm4gPSBhbWZuOw0KPiArCWlycV9hbV9pbml0KCZpb3AtPmFtLCBucl9ldmVudHMsIG5y
X2xldmVscywgc3RhcnRfbGV2ZWwsIGlycV9wb2xsX2FtKTsNCj4gK30NCg0KVGhpcyBmdW5jdGlv
biBoYXMgYSBsYXJnZSBudW1iZXIgb2YgcGFyYW1ldGVycyBhbmQgbW9zdCBvZiB0aGVtIGFyZSBw
YXNzZWQgdmVyYmF0aW0gdG8NCmlycV9hbV9pbml0KCkuIFBsZWFzZSBjb25zaWRlciB0byBpbnRy
b2R1Y2UgYSBzdHJ1Y3R1cmUgZm9yIHRoZXNlIHBhcmFtZXRlcnMgc3VjaCB0aGF0DQp0aGUgbnVt
YmVyIG9mIGZ1bmN0aW9uIGFyZ3VtZW50cyBzdGF5cyByZWFzb25hYmxlLg0KDQpUaGFua3MsDQoN
CkJhcnQuDQoNCg0KDQo=
