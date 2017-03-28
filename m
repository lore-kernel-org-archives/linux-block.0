Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Sagi Grimberg <sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>, "osandov@osandov.com"
	<osandov@osandov.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/2] blk-stat: add a poll_size value to the request_queue
 struct
Date: Tue, 28 Mar 2017 19:38:33 +0000
Message-ID: <25CE7F43-DD1B-42D6-A891-A3D916BD0877@raithlin.com>
References: <1490494692-2416-1-git-send-email-sbates@raithlin.com>
 <1490494692-2416-3-git-send-email-sbates@raithlin.com>
 <44296e0a-fb04-888b-aa00-a9b01709e1b8@grimberg.me>
In-Reply-To: <44296e0a-fb04-888b-aa00-a9b01709e1b8@grimberg.me>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Pj4NCj4+ICBJbiBvcmRlciB0byBidWNrZXQgSU8gZm9yIHRoZSBwb2xsaW5nIGFsZ29yaXRobSB3
ZSB1c2UgYSBzeXNmcyBlbnRyeQ0KPj4gIHRvIHNldCB0aGUgZmlsdGVyIHZhbHVlLiBJdCBpcyBz
aWduZWQgYW5kIHdlIHdpbGwgdXNlIHRoYXQgYXMgZm9sbG93czoNCj4+DQo+PiAgIDAgICA6IE5v
IGZpbHRlcmluZy4gQWxsIElPIGFyZSBjb25zaWRlcmVkIGluIHN0YXQgZ2VuZXJhdGlvbg0KPj4g
ICA+IDAgOiBGaWx0ZXJpbmcgYmFzZWQgb24gSU8gb2YgZXhhY3RseSB0aGlzIHNpemUgb25seS4N
Cj4+ICAgPCAwIDogRmlsdGVyaW5nIGJhc2VkIG9uIElPIGxlc3MgdGhhbiBvciBlcXVhbCB0byAt
MSB0aW1lIHRoaXMgdmFsdWUuPg0KPg0KPiBJJ2Qgc2F5IHRoYXQgdGhpcyBpcyBhIGZhaXJseSBu
b24tdHJpdmlhbCBzZW1hbnRpYyBtZWFubmluZyB0byB0aGlzLi4uDQo+DQo+IElzIHRoZXJlIGFu
eSB1c2UgZm9yIHRoZSBzaXplIGV4YWN0IG1hdGNoIGZpbHRlcj8gSWYgbm90IHRoZW4NCj4gSSBz
dWdnZXN0IHdlIGFsd2F5cyBtYWtlIGl0ICg8PSkgaW4gaXRzIHNlbWFudGljcy4uLg0KDQpUaGFu
a3MgZm9yIHRoZSByZXZpZXcgU2FnaS4gSeKAmWQgYmUgT0sgZ29pbmcgd2l0aCA8PTAgYXMgdGhl
IGV4YWN0IG1hdGNoIHdvdWxkIG5vcm1hbGx5IGJlIGZvciBtaW5pbWFsIElPIHNpemVzICh3aGVy
ZSA8PSBhbmQgPSBhcmUgdGhlIHNhbWUgdGhpbmcpLiBJIHdpbGwgc2VlIHdoYXQgb3RoZXIgZmVl
ZGJhY2sgSSBnZXQgYW5kIGFpbSB0byBkbyBhIHJlc3BpbiBzb29u4oCmDQoNClN0ZXBoZW4NCg0K
