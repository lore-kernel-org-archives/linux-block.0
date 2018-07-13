Return-Path: <prvs=725264dfc=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@linux.intel.com" <keith.busch@linux.intel.com>
CC: "hch@lst.de" <hch@lst.de>, "keith.busch@intel.com"
	<keith.busch@intel.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Date: Fri, 13 Jul 2018 23:03:18 +0000
Message-ID: <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
	 <20180521231131.6685-4-keith.busch@intel.com>
	 <c42d13289e38df93bb35e9876b803420e40b03d3.camel@wdc.com>
	 <20180712192437.GA16839@localhost.localdomain>
	 <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
	 <20180713154346.GA18955@localhost.localdomain>
	 <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
	 <20180713184712.GA19419@localhost.localdomain>
In-Reply-To: <20180713184712.GA19419@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gRnJpLCAyMDE4LTA3LTEzIGF0IDEyOjQ3IC0wNjAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gRnJpLCBKdWwgMTMsIDIwMTggYXQgMDM6NTI6MzhQTSArMDAwMCwgQmFydCBWYW4gQXNzY2hl
IHdyb3RlOg0KPiA+IEkgdGhpbmsgdGhhdCBiZWhhdmlvciBjaGFuZ2UgZXZlbiBjYW4gdHJpZ2dl
ciBhIGtlcm5lbCBjcmFzaC4NCj4gDQo+IEkgdGhpbmsgd2UgYXJlIHBhc3QgYWNrbm93bGVkZ2lu
ZyBpc3N1ZXMgZXhpc3Qgd2l0aCB0aW1lb3V0cy4NCg0KSGVsbG8gS2VpdGgsDQoNCkhvdyBkbyB5
b3Ugd2FudCB0byBnbyBmb3J3YXJkIGZyb20gaGVyZT8gRG8geW91IHByZWZlciB0aGUgYXBwcm9h
Y2ggb2YgdGhlDQpwYXRjaCBJIGhhZCBwb3N0ZWQgKGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xp
c3RzL2xpbnV4LWJsb2NrL21zZzI2NDg5Lmh0bWwpLCANCkppYW5jaGFvJ3MgYXBwcm9hY2ggKGh0
dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4LWJsb2NrJm09MTUyOTUwMDkzODMxNzM4KSBvcg0KcGVy
aGFwcyB5ZXQgYW5vdGhlciBhcHByb2FjaD8gTm90ZTogSSB0aGluayBKaWFuY2hhbydzIHBhdGNo
IGlzIGEgZ29vZCBzdGFydA0KYnV0IGFsc28gdGhhdCBpdCBuZWVkcyBmdXJ0aGVyIGltcHJvdmVt
ZW50Lg0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0KDQoNCg0K
