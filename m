Return-Path: <prvs=6043d9405=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>
CC: "jiufei.xue@linux.alibaba.com" <jiufei.xue@linux.alibaba.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: bio_check_eod() needs to consider partition
Date: Wed, 14 Mar 2018 15:08:49 +0000
Message-ID: <1521040128.3006.0.camel@wdc.com>
References: <20180313091819.26881-1-hch@lst.de>
	 <7c4181b7-788f-bf90-8397-c09beceedcb7@kernel.dk>
	 <1520958339.2638.8.camel@wdc.com> <20180314130322.GA1299@lst.de>
In-Reply-To: <20180314130322.GA1299@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTAzLTE0IGF0IDE0OjAzICswMTAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBj
YW4geW91IHRlc3QgdGhlIHZlcnNpb24gYmVsb3c/DQoNCkhlbGxvIENocmlzdG9waCwNCg0KVGhl
IHNhbWUgVk0gdGhhdCBmYWlsZWQgdG8gYm9vdCB3aXRoIHYyIG9mIHRoaXMgcGF0Y2ggYm9vdHMg
ZmluZSB3aXRoIHRoaXMNCnBhdGNoLg0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0KDQo=
