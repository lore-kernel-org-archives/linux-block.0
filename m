Return-Path: <prvs=6650905ae=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH 6/6] block: consistently use GFP_NOIO instead of
 __GFP_NORECLAIM
Date: Mon, 14 May 2018 15:35:17 +0000
Message-ID: <f8876c76af1cbf22a2247de624f614d26b5654ac.camel@wdc.com>
References: <20180509075408.16388-1-hch@lst.de>
	 <20180509075408.16388-7-hch@lst.de>
In-Reply-To: <20180509075408.16388-7-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA1LTA5IGF0IDA5OjU0ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gU2FtZSBudW1lcmljYWwgdmFsdWUgKGZvciBub3cgYXQgbGVhc3QpLCBidXQgYSBtdWNo
IGJldHRlciBkb2N1bWVudGF0aW9uDQo+IG9mIGludGVudC4NCg0KVGhlcmUgaXMgYSB0eXBvIGlu
IHRoZSBzdWJqZWN0IG9mIHRoaXMgcGF0Y2g6IF9fR0ZQX05PUkVDTEFJTSBzaG91bGQgYmUNCmNo
YW5nZWQgaW50byBfX0dGUF9SRUNMQUlNLiBPdGhlcndpc2U6DQoNClJldmlld2VkLWJ5OiBCYXJ0
IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHdkYy5jb20+DQoNCg0KDQo=
