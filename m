Return-Path: <David.Laight@aculab.com>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Logan Gunthorpe' <logang@deltatee.com>, Sinan Kaya
	<okaya@codeaurora.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>, "Jens
 Axboe" <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, Sagi Grimberg
	<sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe
	<jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>, Dan Williams
	<dan.j.williams@intel.com>, =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?=
	<jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Alex Williamson" <alex.williamson@redhat.com>
Subject: RE: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Date: Wed, 14 Mar 2018 12:16:05 +0000
Message-ID: <6e36d43b0493455a8547bc50c8ec77ba@AcuMS.aculab.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <52cbbbc4-c488-f83f-8d02-14d455b4efd7@codeaurora.org>
 <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
 <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <016dc910-f96a-8a60-4bda-fa24eea98ea5@codeaurora.org>
 <2b152932-2f44-408b-e3ed-b4608d95f82e@deltatee.com>
 <156c24fb-6e27-28f6-0b36-7fd83311ce37@codeaurora.org>
 <932bbf48-9d86-97ec-17bb-052099aff99e@deltatee.com>
In-Reply-To: <932bbf48-9d86-97ec-17bb-052099aff99e@deltatee.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

RnJvbTogTG9nYW4gR3VudGhvcnBlDQo+IFNlbnQ6IDEzIE1hcmNoIDIwMTggMjM6NDYNCi4uLg0K
PiBBcyBTdGVwaGVuIHBvaW50ZWQgb3V0LCBpdCdzIGEgcmVxdWlyZW1lbnQgb2YgdGhlIFBDSWUg
c3BlYyB0aGF0IGENCj4gc3dpdGNoIHN1cHBvcnRzIFAyUC4gSWYgeW91IHdhbnQgdG8gc2VsbCBh
IHN3aXRjaCB0aGF0IGRvZXMgUDJQIHdpdGggYmFkDQo+IHBlcmZvcm1hbmNlIHRoZW4gdGhhdCdz
IG9uIHlvdSB0byBkZWFsIHdpdGguDQoNClRoYXQgc3VycHJpc2VzIG1lICh1bmxlc3MgSSBtaXNz
ZWQgc29tZXRoaW5nIGxhc3QgdGltZSBJIHJlYWQgdGhlIHNwZWMpLg0KV2hpbGUgUDJQIHdyaXRl
cyBhcmUgcmVsYXRpdmVseSBlYXN5IHRvIGhhbmRsZSwgcmVhZHMgYW5kIGFueSBvdGhlciBUTFAg
dGhhdA0KcmVxdWlyZSBhY2tzIGFyZSBhIGNvbXBsZXRlbHkgZGlmZmVyZW50IHByb3Bvc2l0aW9u
Lg0KVGhlcmUgYXJlIG5vIGFkZGl0aW9uYWwgZmllbGRzIHRoYXQgY2FuIGJlIHNldCBpbiB0aGUg
cmVhZCBUTFAgYW5kIHdpbGwgYmUNCnJlZmxlY3RlZCBiYWNrIGluIHRoZSBhY2socykgdGhhbiBj
YW4gYmUgdXNlZCB0byByb3V0ZSB0aGUgYWNrcyBiYWNrIHRvIHRoZQ0KY29ycmVjdCBpbml0aWF0
b3IuDQoNCkknbSBwcmV0dHkgc3VyZSB0aGF0IHRvIHN1cHBvcnQgUDJQIHJlYWRzIGEgc3dpdGNo
IHdvdWxkIGhhdmUgdG8gc2F2ZQ0KdGhlIHJlY2VpdmVkIHJlYWQgVExQIGFuZCAocG9zc2libHkg
bGF0ZXIgb24pIGlzc3VlIHJlYWQgVExQIG9mIGl0cyBvd24NCmZvciB0aGUgcmVxdWlyZWQgZGF0
YS4NCkknbSBub3QgZXZlbiBzdXJlIGl0IGlzIGVhc3kgdG8gaW50ZXJsZWF2ZSB0aGUgUDJQIHJl
YWRzIHdpdGggdGhvc2UNCmNvbWluZyBmcm9tIHRoZSByb290Lg0KVGhhdCByZXF1aXJlcyBhIHBv
dGVudGlhbGx5IGluZmluaXRlIHF1ZXVlIG9mIHBlbmRpbmcgcmVxdWVzdHMuDQoNClNvbWUgeDg2
IHJvb3QgcG9ydHMgc3VwcG9ydCBQMlAgd3JpdGVzIChtYXliZSB3aXRoIGEgYmlvcyBvcHRpb24p
Lg0KSXQgd291bGQgYmUgYSBzaGFtZSBub3QgdG8gYmUgYWJsZSB0byBkbyBQMlAgd3JpdGVzIG9u
IHN1Y2ggc3lzdGVtcw0KZXZlbiB0aG91Z2ggUDJQIHJlYWRzIHdvbid0IHdvcmsuDQoNCihXZSBs
b29rZWQgYXQgdXNpbmcgUDJQIHRyYW5zZmVycyBmb3Igc29tZSBkYXRhLCBidXQgaW4gdGhlIGVu
ZCB1c2VkDQphIGRpZmZlcmVudCBzY2hlbWUuDQpGb3Igb3VyIHVzZSBjYXNlIFAyUCB3cml0ZXMg
d2VyZSBlbm91Z2guDQpBbiBhbHRlcm5hdGl2ZSB3b3VsZCBiZSB0byBhY2Nlc3MgdGhlIHNhbWUg
aG9zdCBtZW1vcnkgYnVmZmVyIGZyb20NCnR3byBkaWZmZXJlbnQgZGV2aWNlcyAtIGJ1dCB0aGVy
ZSBpc24ndCBhbiBBUEkgdGhhdCBsZXRzIHlvdSBkbyB0aGF0LikNCg0KCURhdmlkDQoNCg0K
