Return-Path: <prvs=630dc1010=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>
CC: "tj@kernel.org" <tj@kernel.org>, "israelr@mellanox.com"
	<israelr@mellanox.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] blk-mq: Fix recently introduced races in the timeout
 handling code
Date: Mon, 9 Apr 2018 14:58:22 +0000
Message-ID: <a7972bb84efa3313b87ecbaf37112b360346bdfe.camel@wdc.com>
References: <20180409052038.5391-1-bart.vanassche@wdc.com>
	 <20180409093744.GC10405@lst.de>
In-Reply-To: <20180409093744.GC10405@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTA0LTA5IGF0IDExOjM3ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gVGhpcyBsb29rcyBzZW5zaWJsZSwgYnV0IEknbSB3b3JyaWVkIGFib3V0IHRha2luZyBh
IHdob2xlIHNwaW5sb2NrDQo+IGZvciBldmVyeSByZXF1ZXN0IGNvbXBsZXRpb24sIGluY2x1ZGlu
ZyBpcnEgZGlzYWJsaW5nLiAgSG93ZXZlciBpdCBzZWVtcw0KPiBsaWtlIHlvdXIgbmV3IHVwZGF0
ZWQgcGF0dGVybiB3b3VsZCBmaXQgdXNlIG9mIGNtcHhjaGcoKSB2ZXJ5IG5pY2VseS4NCg0KSGVs
bG8gQ2hyaXN0b3BoLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuIEkgaGFkIGEgbG9vayBhdCB0
aGUgc3BpbiBsb2NrIGltcGxlbWVudGF0aW9uIG9uDQp4ODYgYW5kIGFwcGFyZW50bHkgb24geDg2
IHNwaW4gbG9ja3MgYXJlIGltcGxlbWVudGVkIGFzIHFzcGlubG9ja3MNCihpbmNsdWRlL2FzbS1n
ZW5lcmljL3FzcGlubG9jay5oKS4gcXVldWVkX3NwaW5fbG9jaygpIGFscmVhZHkgdXNlcw0KYXRv
bWljX2NtcHhjaGdfYWNxdWlyZSgpLiBBcmUgeW91IHN1cmUgdGhhdCByZXBsYWNpbmcgdGhlIHNw
aW4gbG9jaw0KYnkgY21weGNoZygpIHdpbGwgeWllbGQgYSBwZXJmb3JtYW5jZSBpbXByb3ZlbWVu
dD8NCg0KVGhhbmtzLA0KDQpCYXJ0Lg0K
