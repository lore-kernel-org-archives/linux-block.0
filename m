Return-Path: <prvs=599e16e30=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "sbates@raithlin.com" <sbates@raithlin.com>,
	"logang@deltatee.com" <logang@deltatee.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"jgg@mellanox.com" <jgg@mellanox.com>, "hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jglisse@redhat.com" <jglisse@redhat.com>, "maxg@mellanox.com"
	<maxg@mellanox.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"keith.busch@intel.com" <keith.busch@intel.com>, "benh@kernel.crashing.org"
	<benh@kernel.crashing.org>
Subject: Re: [PATCH v2 08/10] nvme-pci: Add support for P2P memory in requests
Date: Fri, 9 Mar 2018 05:08:36 +0000
Message-ID: <1520572115.11647.3.camel@wdc.com>
References: <20180228234006.21093-1-logang@deltatee.com>
	 <20180228234006.21093-9-logang@deltatee.com>
	 <c6639530-48ba-4655-c772-7d88a030e37e@grimberg.me>
	 <1CE68E79-E5FD-4EE2-BD88-B3EE57E43ACE@raithlin.com>
In-Reply-To: <1CE68E79-E5FD-4EE2-BD88-B3EE57E43ACE@raithlin.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE4LTAzLTAxIGF0IDE1OjU4ICswMDAwLCBTdGVwaGVuICBCYXRlcyB3cm90ZToN
Cj4gPiBBbnkgcGxhbnMgYWRkaW5nIHRoZSBjYXBhYmlsaXR5IHRvIG52bWUtcmRtYT8gU2hvdWxk
IGJlDQo+ID4gc3RyYWlnaHQtZm9yd2FyZC4uLiBJbiB0aGVvcnksIHRoZSB1c2UtY2FzZSB3b3Vs
ZCBiZSByZG1hIGJhY2tlbmQNCj4gPiBmYWJyaWMgYmVoaW5kLiBTaG91bGRuJ3QgYmUgaGFyZCB0
byB0ZXN0IGVpdGhlci4uLg0KPiANCj4gTmljZSBpZGVhIFNhZ2kuIFllcyB3ZSBoYXZlIGJlZW4g
c3RhcnRpbmcgdG8gbG9vayBhdCB0aGF0LiBUaG91Z2ggYWdhaW4gd2UNCj4gd291bGQgcHJvYmFi
bHkgd2FudCB0byBpbXBvc2UgdGhlICJhdHRhY2hlZCB0byB0aGUgc2FtZSBQQ0llIHN3aXRjaCIg
cnVsZQ0KPiB3aGljaCBtaWdodCBiZSBsZXNzIGNvbW1vbiB0byBzYXRpc2Z5IGluIGluaXRpYXRv
ciBzeXN0ZW1zLiANCj4gDQo+IERvd24gdGhlIHJvYWQgSSB3b3VsZCBhbHNvIGxpa2UgdG8gZGlz
Y3VzcyB0aGUgYmVzdCB3YXkgdG8gdXNlIHRoaXMgUDJQDQo+IGZyYW1ld29yayB0byBmYWNpbGl0
YXRlIGNvcGllcyBiZXR3ZWVuIE5WTWUgbmFtZXNwYWNlcyAob24gYm90aCBQQ0llIGFuZA0KPiBm
YWJyaWMgYXR0YWNoZWQgbmFtZXNwYWNlcykgd2l0aG91dCBoYXZpbmcgdG8gZXhwb3NlIHRoZSBD
TUIgdXAgdG8gdXNlcg0KPiBzcGFjZS4gV2Fzbid0IHNvbWV0aGluZyBsaWtlIHRoYXQgZG9uZSBp
biB0aGUgU0NTSSB3b3JsZCBhdCBzb21lIHBvaW50DQo+IE1hcnRpbj8NCg0KQXJlIHlvdSBwZXJo
YXBzIHJlZmVycmluZyB0byB0aGUgZm9sbG93aW5nIHBhdGNoIHNlcmllczogIkNvcHkgT2ZmbG9h
ZCINCihodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1zY3NpL21zZzc0NjgwLmh0
bWwgLw0KaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzU5MjA5NC8pPyBJIHdpbGwgY29udGFjdCBN
YXJ0aW4gb2ZmLWxpc3QgYW5kIGluDQpjYXNlIGhlIHdvdWxkbid0IGhhdmUgdGhlIHRpbWUgbXlz
ZWxmIHRvIHJldml2ZSB0aGF0IHBhdGNoIHNlcmllcyB0aGVuIEkNCndpbGwgZnJlZSB1cCBzb21l
IHRpbWUgdG8gd29yayBvbiB0aGlzLg0KDQpCYXJ0Lg0KDQoNCg0KDQo=
