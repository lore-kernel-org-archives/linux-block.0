Return-Path: <prvs=701cef09f=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"snitzer@redhat.com" <snitzer@redhat.com>
Subject: Re: [PATCH v2] Revert "block: Add warning for bi_next not NULL in
 bio_endio()"
Date: Tue, 19 Jun 2018 18:17:08 +0000
Message-ID: <d843bf23df736e4fe557a960564a180ada187db5.camel@wdc.com>
References: <20180619172640.15246-1-bart.vanassche@wdc.com>
	 <20180619181618.GA19298@kmo-pixel>
In-Reply-To: <20180619181618.GA19298@kmo-pixel>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gVHVlLCAyMDE4LTA2LTE5IGF0IDE0OjE2IC0wNDAwLCBLZW50IE92ZXJzdHJlZXQgd3JvdGU6
DQo+IEkgdGFrZSBpdCBpZiB3ZSBoYWQgYSB0ZXN0IGZvciByZXF1ZXN0IGJhc2VkIGRtIGluIGJs
a3Rlc3RzIG9yIHNvbWV3aGVyZSB0aGF0DQo+IHByb2JhYmx5IHdvdWxkIGhhdmUgY2F1Z2h0IHRo
aXMgbXVjaCBlYXNpZXIgOi8NCg0KSSdtIHdvcmtpbmcgb24gcG9ydGluZyB0aGUgc3JwLXRlc3Qg
c29mdHdhcmUgdG8gdGhlIGJsa3Rlc3RzIGZyYW1ld29yay4NCg0KQmFydC4NCg0KDQo=
