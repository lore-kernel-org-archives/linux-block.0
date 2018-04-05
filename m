Return-Path: <prvs=626873699=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tytso@mit.edu" <tytso@mit.edu>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: BUG: KASAN: use-after-free in bt_for_each+0x1ea/0x29f
Date: Thu, 5 Apr 2018 16:25:25 +0000
Message-ID: <610fe6871f69610388690b7f23b3baa3ac0bd295.camel@wdc.com>
References: <20180404232808.GB12299@ming.t460p>
	 <6c6c1fc0-09c1-cc8c-9dc0-3d8b9b36925b@kernel.dk>
In-Reply-To: <6c6c1fc0-09c1-cc8c-9dc0-3d8b9b36925b@kernel.dk>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA0LTA0IGF0IDE5OjI2IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBM
ZWF2aW5nIHRoZSB3aG9sZSB0cmFjZSBoZXJlLCBidXQgSSdtIGhhdmluZyBhIGhhcmQgdGltZSBt
YWtpbmcgc2Vuc2Ugb2YgaXQuDQo+IEl0IGNvbXBsYWlucyBhYm91dCBhIHVzZXItYWZ0ZXItZnJl
ZSBpbiB0aGUgaW5mbGlnaHQgaXRlcmF0aW9uLCB3aGljaCBpcyBvbmx5DQo+IHdvcmtpbmcgb24g
dGhlIHF1ZXVlLCByZXF1ZXN0LCBhbmQgb24tc3RhY2sgbWkgZGF0YS4gTm9uZSBvZiB0aGVzZSB3
b3VsZCBiZQ0KPiBmcmVlZC4gVGhlIGJlbG93IHRyYWNlIG9uIGFsbG9jYXRpb24gYW5kIGZyZWUg
aW5kaWNhdGVzIGEgYmlvLCBidXQgdGhhdCBpc24ndA0KPiB1c2VkIGluIHRoZSBpbmZsaWdodCBw
YXRoIGF0IGFsbC4gSXMgaXQgcG9zc2libGUgdGhhdCBrYXNhbiBnZXRzIGNvbmZ1c2VkIGhlcmU/
DQo+IE5vdCBzdXJlIHdoYXQgdG8gbWFrZSBvZiBpdCBzbyBmYXIuDQoNCkhlbGxvIEplbnMsDQoN
CkluIHRoZSBtYW55IGJsb2NrIGxheWVyIHRlc3RzIEkgcmFuIHdpdGggS0FTQU4gZW5hYmxlZCBJ
IGhhdmUgbmV2ZXIgc2Vlbg0KYW55dGhpbmcgbGlrZSB0aGlzIG5vciBoYXZlIEkgc2VlbiBhbnl0
aGluZyB0aGF0IG1hZGUgbWUgd29uZGVyIGFib3V0IHRoZQ0KcmVsaWFiaWxpdHkgb2YgS0FTQU4u
IE1heWJlIHNvbWUgY29kZSBvdXRzaWRlIHRoZSBibG9jayBsYXllciBjb3JlIGNvcnJ1cHRlZA0K
YSByZXF1ZXN0IHF1ZXVlIGRhdGEgc3RydWN0dXJlIGFuZCB0cmlnZ2VyZWQgdGhpcyB3ZWlyZCBy
ZXBvcnQ/DQoNCkJhcnQuDQoNCg0KDQo=
