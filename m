Return-Path: <sbates@raithlin.com>
From: "Stephen  Bates" <sbates@raithlin.com>
To: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>, "osandov@osandov.com"
	<osandov@osandov.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/2] blk-stat: add a poll_size value to the request_queue
 struct
Date: Tue, 28 Mar 2017 19:58:55 +0000
Message-ID: <C52E2CE3-0F92-40EA-902F-A9B70B145F1A@raithlin.com>
References: <1490494692-2416-1-git-send-email-sbates@raithlin.com>
 <1490494692-2416-3-git-send-email-sbates@raithlin.com>
 <44296e0a-fb04-888b-aa00-a9b01709e1b8@grimberg.me>
 <25CE7F43-DD1B-42D6-A891-A3D916BD0877@raithlin.com>
 <88815dc6-04b2-0915-597d-1e335b6d2ba2@kernel.dk>
In-Reply-To: <88815dc6-04b2-0915-597d-1e335b6d2ba2@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Pj4gDQo+PiBUaGFua3MgZm9yIHRoZSByZXZpZXcgU2FnaS4gSeKAmWQgYmUgT0sgZ29pbmcgd2l0
aCA8PTAgYXMgdGhlIGV4YWN0DQo+PiBtYXRjaCB3b3VsZCBub3JtYWxseSBiZSBmb3IgbWluaW1h
bCBJTyBzaXplcyAod2hlcmUgPD0gYW5kID0gYXJlIHRoZQ0KPj4gc2FtZSB0aGluZykuIEkgd2ls
bCBzZWUgd2hhdCBvdGhlciBmZWVkYmFjayBJIGdldCBhbmQgYWltIHRvIGRvIGENCj4+IHJlc3Bp
biBzb29u4oCmDQo+DQo+IE5vIHR1bmFibGVzIGZvciB0aGlzLCBwbGVhc2UuIFRoZXJlJ3MgYWJz
b2x1dGVseSBubyByZWFzb24gd2h5IHdlIHNob3VsZA0KPiBuZWVkIGl0Lg0KDQpKZW5zIOKAkyBi
eSB0aGlzIHlvdSBtZWFuIHlvdSB3YW50IHRvIG9ubHkgYnVja2V0IElPIHRoYXQgYXJlIGV4YWN0
bHkgdGhlIG1pbmltdW0gYmxvY2sgc2l6ZSBzdXBwb3J0ZWQgYnkgdGhlIHVuZGVybHlpbmcgYmxv
Y2sgZGV2aWNlPyBJIHdhcyBlbnZpc2lvbmluZyB3ZSBtaWdodCB3YW50IHRvIHJlbGF4IHRoYXQg
aW4gY2VydGFpbiBjYXNlcyAoZS5nLiBidWNrZXQgNEtCIGFuZCBiZWxvdyBnb2luZyB0byBhIDUx
MkIgZGV2aWNlKS4NCg0KU3RlcGhlbg0KDQoNCg==
