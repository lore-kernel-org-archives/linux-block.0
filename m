Return-Path: <prvs=6335d9f7e=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "00moses.alexander00@gmail.com"
	<00moses.alexander00@gmail.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] block: Ensure that a request queue is dissociated from
 the cgroup controller
Date: Thu, 12 Apr 2018 18:56:26 +0000
Message-ID: <22e0bba319877407a0abccf292ef0b22454db04d.camel@wdc.com>
References: <20180412015852.26014-1-bart.vanassche@wdc.com>
	 <20180412135149.GX793541@devbig577.frc2.facebook.com>
	 <af6dafea-d754-8a0d-b96b-81716f2ea24d@wdc.com>
	 <20180412153748.GB793541@devbig577.frc2.facebook.com>
	 <beafd7bc4f2fdb7e672ad97e57ff4f82464182da.camel@wdc.com>
	 <20180412161247.GD793541@devbig577.frc2.facebook.com>
	 <f98af37ea6755119177c26fbb73b0071ddef90b8.camel@wdc.com>
	 <20180412181121.GA1911913@devbig577.frc2.facebook.com>
In-Reply-To: <20180412181121.GA1911913@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVGh1LCAyMDE4LTA0LTEyIGF0IDExOjExIC0wNzAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiAqIFJpZ2h0IG5vdywgYmxrX3F1ZXVlX2VudGVyL2V4aXQoKSBkb2Vzbid0IGhhdmUgYW55IGFu
bm90YXRpb25zLg0KPiAgIElPVywgdGhlcmUncyBubyB3YXkgZm9yIHBhdGhzIHdoaWNoIG5lZWQg
ZW50ZXIgbG9ja2VkIHRvIGFjdHVhbGx5DQo+ICAgYXNzZXJ0IHRoYXQuICBJZiB3ZSdyZSBnb25u
YSBwcm90ZWN0IG1vcmUgdGhpbmdzIHdpdGggcXVldWUNCj4gICBlbnRlci9leGl0LCBpdCBnb3R0
YSBiZSBhbm5vdGF0ZWQuDQoNCkhlbGxvIFRlanVuLA0KDQpPbmUgcG9zc2liaWxpdHkgaXMgdG8g
Y2hlY2sgdGhlIGNvdW50IGZvciB0aGUgbG9jYWwgQ1BVIG9mIHEtPnFfdXNhZ2VfY291bnRlcg0K
YXQgcnVudGltZSwgZS5nLiB1c2luZyBXQVJOX09OX09OQ0UoKS4gSG93ZXZlciwgdGhhdCBtaWdo
dCBoYXZlIGEgcnVudGltZQ0Kb3ZlcmhlYWQuIEFub3RoZXIgcG9zc2liaWxpdHkgaXMgdG8gZm9s
bG93IHRoZSBleGFtcGxlIG9mIGtlcm5mcyBhbmQgdG8gdXNlDQphIGxvY2tkZXAgbWFwIGFuZCBs
b2NrZGVwX2Fzc2VydF9oZWxkKCkuIFRoZXJlIG1pZ2h0IGJlIG90aGVyIGFsdGVybmF0aXZlcyBJ
DQpoYXZlIG5vdCB0aG91Z2h0IG9mLg0KDQpCYXJ0Lg0KDQoNCg0K
