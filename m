Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>
CC: "hare@suse.de" <hare@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>, "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: Re: [PATCH 4/5] skd: Avoid double completions in case of a timeout
Date: Thu, 24 Aug 2017 15:12:07 +0000
Message-ID: <1503587526.2702.5.camel@wdc.com>
References: <20170823175633.12680-1-bart.vanassche@wdc.com>
	 <20170823175633.12680-5-bart.vanassche@wdc.com>
	 <20170823180837.GF5802@lst.de>
In-Reply-To: <20170823180837.GF5802@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE3LTA4LTIzIGF0IDIwOjA4ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gQWx0aG91Z2ggYXMgYSBmb2xsb3cgb24gSSB3b3VsZCBhbHNvIG1vdmUgdGhlIGRlYnVn
IHByaW50a3MNCj4gZnJvbSBza2RfZW5kX3JlcXVlc3QgdG8gc2tkX3NvZnRpcnFfZG9uZSwgdGhl
biByZW1vdmUgc2tkX2VuZF9yZXF1ZXN0DQo+IGFuZCByZW5hbWUgc2tkX3NvZnRpcnFfZG9uZSB0
byBza2RfY29tcGxldGVfcnEgdG8gZml0IHdoYXQgb3RoZXINCj4gZHJpdmVycyBhcmUgZG9pbmcg
YSBsaXR0bGUgbW9yZSBjbG9zZWx5Lg0KDQpIZWxsbyBDaHJpc3RvcGgsDQoNClRoYW5rcyBmb3Ig
dGhlIHJldmlldyBvZiB0aGlzIHBhdGNoIHNlcmllcy4gSSB3aWxsIGluY2x1ZGUgdGhlIGFib3Zl
IGNoYW5nZXMNCndoZW4gSSBwb3N0IG15IG5leHQgcGF0Y2ggc2VyaWVzIGZvciB0aGUgc2tkIGRy
aXZlci4NCg0KQmFydC4=
