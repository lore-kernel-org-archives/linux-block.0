Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas
	<bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy
	<maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
	=?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 04/10] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Date: Thu, 1 Mar 2018 18:54:01 +0000
Message-ID: <0D05579B-789C-4A19-B3A2-C1A630BE31C0@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-5-logang@deltatee.com>
 <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

VGhhbmtzIGZvciB0aGUgZGV0YWlsZWQgcmV2aWV3IEJqb3JuIQ0KDQo+PiAgDQo+PiArCSAgRW5h
YmxpbmcgdGhpcyBvcHRpb24gd2lsbCBhbHNvIGRpc2FibGUgQUNTIG9uIGFsbCBwb3J0cyBiZWhp
bmQNCj4+ICsJICBhbnkgUENJZSBzd2l0Y2guIFRoaXMgZWZmaWN0aXZlbHkgcHV0cyBhbGwgZGV2
aWNlcyBiZWhpbmQgYW55DQo+PiArCSAgc3dpdGNoIGludG8gdGhlIHNhbWUgSU9NTVUgZ3JvdXAu
DQoNCj4NCj4gIERvZXMgdGhpcyByZWFsbHkgbWVhbiAiYWxsIGRldmljZXMgYmVoaW5kIHRoZSBz
YW1lIFJvb3QgUG9ydCI/DQoNCk5vdCBuZWNlc3NhcmlseS4gWW91IG1pZ2h0IGhhdmUgYSBjYXNj
YWRlIG9mIHN3aXRjaGVzIChpLmUgc3dpdGNoZXMgYmVsb3cgYSBzd2l0Y2gpIHRvIGFjaGlldmUg
YSB2ZXJ5IGxhcmdlIGZhbi1vdXQgKGluIGFuIE5WTWUgU1NEIGFycmF5IGZvciBleGFtcGxlKSBh
bmQgd2Ugd2lsbCBvbmx5IGRpc2FibGUgQUNTIG9uIHRoZSBwb3J0cyBiZWxvdyB0aGUgcmVsZXZh
bnQgc3dpdGNoLg0KDQo+IFdoYXQgZG9lcyB0aGlzIG1lYW4gaW4gdGVybXMgb2YgZGV2aWNlIHNl
Y3VyaXR5PyAgSSBhc3N1bWUgaXQgbWVhbnMsDQo+IGF0IGxlYXN0LCB0aGF0IGluZGl2aWR1YWwg
ZGV2aWNlcyBjYW4ndCBiZSBhc3NpZ25lZCB0byBzZXBhcmF0ZSBWTXMuDQoNClRoaXMgd2FzIGRp
c2N1c3NlZCBkdXJpbmcgdjEgWzFdLiBEaXNhYmxpbmcgQUNTIG9uIGFsbCBkb3duc3RyZWFtIHBv
cnRzIG9mIHRoZSBzd2l0Y2ggbWVhbnMgdGhhdCBhbGwgdGhlIEVQcyBiZWxvdyBpdCBoYXZlIHRv
IHBhcnQgb2YgdGhlIHNhbWUgSU9NTVUgZ3JvdXBpbmcuIEhvd2V2ZXIgaXQgd2FzIGFsc28gYWdy
ZWVkIHRoYXQgYXMgbG9uZyBhcyB0aGUgQUNTIGRpc2FibGUgb2NjdXJyZWQgYXQgYm9vdCB0aW1l
ICh3aGljaCBpcyBkb2VzIGluIHYyKSB0aGVuIHRoZSB2aXJ0dWFsaXphdGlvbiBsYXllciB3aWxs
IGJlIGF3YXJlIG9mIGl0IGFuZCB3aWxsIHBlcmZvcm0gdGhlIElPTU1VIGdyb3VwIGZvcm1hdGlv
biBjb3JyZWN0bHkuDQogICAgDQo+IEkgZG9uJ3QgbWluZCBhZG1pdHRpbmcgdGhhdCB0aGlzIHBh
dGNoIG1ha2VzIG1lIHByZXR0eSBuZXJ2b3VzLCBhbmQgSQ0KPiBkb24ndCBoYXZlIGEgY2xlYXIg
aWRlYSBvZiB3aGF0IHRoZSBpbXBsaWNhdGlvbnMgb2YgdGhpcyBhcmUsIG9yIGhvdw0KPiB0byBj
b21tdW5pY2F0ZSB0aG9zZSB0byBlbmQgdXNlcnMuICAiVGhlIHNhbWUgSU9NTVUgZ3JvdXAiIGlz
IGEgcHJldHR5DQo+IGFic3RyYWN0IGlkZWEuDQogICAgDQpBbGV4IGdhdmUgYSBnb29kIG92ZXJ2
aWV3IG9mIHRoZSBpbXBsaWNhdGlvbnMgaW4gWzFdLg0KDQpTdGVwaGVuIA0KDQpbMV0gaHR0cHM6
Ly9tYXJjLmluZm8vP2w9bGludXgtcGNpJm09MTUxNTEyMzIwMDMxNzM5Jnc9Mg0KDQo=
