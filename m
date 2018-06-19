Return-Path: <prvs=701cef09f=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
Date: Tue, 19 Jun 2018 15:20:39 +0000
Message-ID: <2409013d789ca266879d24c815b76c2193e23fe3.camel@wdc.com>
References: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA2LTE5IGF0IDE1OjAwICswODAwLCBKaWFuY2hhbyBXYW5nIHdyb3RlOg0K
PiBDdXJyZW50bHksIHRoZSBrb2JqZWN0X2RlbCBmb3Iga29ianMgb2YgbXEsIGhjdHggYW5kIGN0
eCBpcyBpbnZva2VkDQo+IHVuZGVyIHN5c2ZzX2xvY2ssIGxvY2sgaW52ZXJzaW9uIHdpbGwgY29t
ZSB1cCB3aGVuIG90aGVyIG9uZSBpcw0KPiBhY2Vzc2luZyB0aGUgYXNzb2NpYXRlZCBzeXNmcyBm
aWxlIGFuZCB0cnlpbmcgdG8gYWNxdWlyZSB0aGUNCj4gc3lzZnNfbG9jay4gVG8gZml4IGl0LCB1
c2UgbXV0ZXhfdHJ5bG9jayBpbiBibGtfbXFfc3lzZnNfb3BzIGFuZA0KPiBibGtfbXFfaHdfc3lz
ZnNfb3BzLCBpZiB0aGUgbG9jayBpbiBvbiBjb250ZW5kaW5nLCByZXR1cm4gLUVBR0FJTi4NCg0K
SXMgdGhpcyBhIHRoZW9yZXRpY2FsIGlzc3VlIG9yIHNvbWV0aGluZyB5b3UgYWN0dWFsbHkgcmFu
IGludG8/IFdoaWNoIGxvY2sNCm90aGVyIHRoYW4gc3lzZnNfbG9jayBkbyB5b3UgdGhpbmsgaXMg
aW52b2x2ZWQgaW4gdGhlIGxvY2sgaW52ZXJzaW9uPw0KDQpCYXJ0Lg0KDQoNCg0K
