Return-Path: <prvs=630dc1010=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"israelr@mellanox.com" <israelr@mellanox.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] blk-mq: Fix recently introduced races in the timeout
 handling code
Date: Mon, 9 Apr 2018 21:30:27 +0000
Message-ID: <f1d8af3b1944d8e2db724fa990d1f09da2c75592.camel@wdc.com>
References: <20180409052038.5391-1-bart.vanassche@wdc.com>
	 <20180409164737.GE3126663@devbig577.frc2.facebook.com>
	 <4e32290f8d5901fbd16116d1623d37dbfdc1e1b8.camel@wdc.com>
	 <20180409185616.GG3126663@devbig577.frc2.facebook.com>
In-Reply-To: <20180409185616.GG3126663@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTA0LTA5IGF0IDExOjU2IC0wNzAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBPbiBNb24sIEFwciAwOSwgMjAxOCBhdCAwNTowMzowNVBNICswMDAwLCBCYXJ0IFZhbiBBc3Nj
aGUgd3JvdGU6DQo+ID4gZXhpc3QgdG9kYXkgaW4gdGhlIGJsay1tcSB0aW1lb3V0IGhhbmRsaW5n
IGNvZGUgY2Fubm90IGJlIGZpeGVkIGNvbXBsZXRlbHkNCj4gPiB1c2luZyBSQ1Ugb25seS4NCj4g
DQo+IEkgcmVhbGx5IGRvbid0IHRoaW5rIHRoYXQgaXMgdGhhdCBjb21wbGljYXRlZC4gIExldCdz
IGZpcnN0IGNvbmZpcm0NCj4gdGhlIHJhY2UgZml4IGFuZCBnZXQgdG8gbmFycm93aW5nIC8gY2xv
c2luZyB0aGF0IHdpbmRvdy4NCg0KSGVsbG8gVGVqdW4sDQoNClR3byBtb250aHMgYWdvIGl0IHdh
cyByZXBvcnRlZCBmb3IgdGhlIGZpcnN0IHRpbWUgdGhhdCBjb21taXQgMWQ5YmQ1MTYxYmEzDQoo
ImJsay1tcTogcmVwbGFjZSB0aW1lb3V0IHN5bmNocm9uaXphdGlvbiB3aXRoIGEgUkNVIGFuZCBn
ZW5lcmF0aW9uIGJhc2VkDQpzY2hlbWUiKSBpbnRyb2R1Y2VzIGEgcmVncmVzc2lvbi4gU2luY2Ug
dGhhdCByZXBvcnQgbm9ib2R5IGhhcyBwb3N0ZWQgYQ0KcGF0Y2ggdGhhdCBmaXhlcyBhbGwgcmFj
ZXMgcmVsYXRlZCB0byBibGstbXEgdGltZW91dCBoYW5kbGluZyBhbmQgdGhhdCBvbmx5DQp1c2Vz
IFJDVS4gSWYgeW91IHdhbnQgdG8gY29udGludWUgd29ya2luZyBvbiB0aGlzIHRoYXQncyBmaW5l
IHdpdGggbWUuIEJ1dA0Kc2luY2UgbXkgb3BpbmlvbiBpcyB0aGF0IGl0IGlzIGltcG9zc2libGUg
dG8gZml4IHRoZXNlIHJhY2VzIHVzaW5nIFJDVSBvbmx5DQpJIHdpbGwgY29udGludWUgd29ya2lu
ZyBvbiBhbiBhbHRlcm5hdGl2ZSBhcHByb2FjaC4gU2VlIGFsc28gIltQQVRDSF0NCmJsay1tcTog
Rml4IGEgcmFjZSBiZXR3ZWVuIHJlc2V0dGluZyB0aGUgdGltZXIgYW5kIGNvbXBsZXRpb24gaGFu
ZGxpbmciDQooaHR0cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS9saW51eC1ibG9ja0B2Z2VyLmtl
cm5lbC5vcmcvbXNnMTgwODkuaHRtbCkuDQoNClRoYW5rcywNCg0KQmFydC4NCg0KDQoNCg==
