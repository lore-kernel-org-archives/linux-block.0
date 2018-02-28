Return-Path: <prvs=59071c28a=Damien.LeMoal@wdc.com>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>, Ming Lei
	<ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>, Johannes Thumshirn
	<jthumshirn@suse.de>
Subject: Re: [PATCH 2/2] blk-mq-debugfs: Show zone locking information
Date: Wed, 28 Feb 2018 01:52:38 +0000
Message-ID: <6e2b1ef0-98ff-284a-e77b-61b05b3caf4b@wdc.com>
References: <20180228003214.3194-1-bart.vanassche@wdc.com>
 <20180228003214.3194-3-bart.vanassche@wdc.com>
In-Reply-To: <20180228003214.3194-3-bart.vanassche@wdc.com>
Reply-To: Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

QmFydCwNCg0KT24gMjAxOC8wMi8yNyAxNjozMiwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBX
aGVuIGRlYnVnZ2luZyB0aGUgWkJDIGNvZGUgaW4gdGhlIG1xLWRlYWRsaW5lIHNjaGVkdWxlciBp
dCBpcyB2ZXJ5DQo+IGltcG9ydGFudCB0byBrbm93IHdoaWNoIHpvbmVzIGFyZSBsb2NrZWQgYW5k
IHdoaWNoIHpvbmVzIGFyZSBub3QNCj4gbG9ja2VkLiBIZW5jZSB0aGlzIHBhdGNoIHRoYXQgZXhw
b3J0cyB0aGUgem9uZSBsb2NraW5nIGluZm9ybWF0aW9uDQo+IHRocm91Z2ggZGVidWdmcy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YmFydC52YW5hc3NjaGVAd2RjLmNv
bT4NCj4gQ2M6IE9tYXIgU2FuZG92YWwgPG9zYW5kb3ZAZmIuY29tPg0KPiBDYzogRGFtaWVuIExl
IE1vYWwgPGRhbWllbi5sZW1vYWxAd2RjLmNvbT4NCj4gQ2M6IE1pbmcgTGVpIDxtaW5nLmxlaUBy
ZWRoYXQuY29tPg0KPiBDYzogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IENjOiBK
b2hhbm5lcyBUaHVtc2hpcm4gPGp0aHVtc2hpcm5Ac3VzZS5kZT4NCg0KSXQgd291bGQgYmUgbmlj
ZSB0byBhZGQgdGhlIHNhbWUgdG8gbGVnYWN5IGRlYWRsaW5lIHRvby4NCg0KRm9yIHRoaXMgcGF0
Y2g6DQoNClJldmlld2VkLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9hbEB3ZGMuY29t
Pg0KVGVzdGVkLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9hbEB3ZGMuY29tPg0KDQoN
Ci0tIA0KRGFtaWVuIExlIE1vYWwNCldlc3Rlcm4gRGlnaXRhbCBSZXNlYXJjaA==
