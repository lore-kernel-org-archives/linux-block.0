Return-Path: <prvs=6650905ae=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH 4/6] block: pass an explicit gfp_t to get_request
Date: Mon, 14 May 2018 15:28:44 +0000
Message-ID: <37bffee5b400e82f22ea1306052d4fbef4da2b0e.camel@wdc.com>
References: <20180509075408.16388-1-hch@lst.de>
	 <20180509075408.16388-5-hch@lst.de>
In-Reply-To: <20180509075408.16388-5-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA1LTA5IGF0IDA5OjU0ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gYmxrX29sZF9nZXRfcmVxdWVzdCBhbHJlYWR5IGhhcyBpdCBhdCBoYW5kLCBhbmQgaW4g
YmxrX3F1ZXVlX2Jpbywgd2hpY2gNCj4gaXMgdGhlIGZhc3QgcGF0aCwgaXQgaXMgY29uc3RhbnQu
DQoNClJldmlld2VkLWJ5OiBCYXJ0IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHdkYy5jb20+
DQoNCg0K
