Return-Path: <prvs=6650905ae=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH 5/6] block: use GFP_NOIO instead of __GFP_DIRECT_RECLAIM
Date: Mon, 14 May 2018 15:30:22 +0000
Message-ID: <8716105a867b898e4785339de5bef1ab1d1f019c.camel@wdc.com>
References: <20180509075408.16388-1-hch@lst.de>
	 <20180509075408.16388-6-hch@lst.de>
In-Reply-To: <20180509075408.16388-6-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA1LTA5IGF0IDA5OjU0ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gV2UganVzdCBjYW4ndCBkbyBJL08gd2hlbiBkb2luZyBibG9jayBsYXllciByZXF1ZXN0
cyBhbGxvY2F0aW9ucywNCj4gc28gdXNlIEdGUF9OT0lPIGluc3RlYWQgb2YgdGhlIGV2ZW4gbW9y
ZSBsaW1pdGVkIF9fR0ZQX0RJUkVDVF9SRUNMQUlNLg0KDQpSZXZpZXdlZC1ieTogQmFydCBWYW4g
QXNzY2hlIDxiYXJ0LnZhbmFzc2NoZUB3ZGMuY29tPg0KDQoNCg==
