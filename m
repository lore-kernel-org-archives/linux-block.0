Return-Path: <prvs=6650905ae=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH 1/6] scsi/osd: remove the gfp argument to
 osd_start_request
Date: Mon, 14 May 2018 15:14:42 +0000
Message-ID: <359319f8f1c26c350dfe1c900ebcf3878ffd384c.camel@wdc.com>
References: <20180509075408.16388-1-hch@lst.de>
	 <20180509075408.16388-2-hch@lst.de>
In-Reply-To: <20180509075408.16388-2-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gV2VkLCAyMDE4LTA1LTA5IGF0IDA5OjU0ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gQWx3YXlzIEdGUF9LRVJORUwsIGFuZCBrZWVwaW5nIGl0IHdvdWxkIGNhdXNlIHNlcmlv
dXMgY29tcGxpY2F0aW9ucyBmb3INCj4gdGhlIG5leHQgY2hhbmdlLg0KDQpUaGlzIHBhdGNoIGRl
c2NyaXB0aW9uIGlzIHZlcnkgYnJpZWYuIFNob3VsZG4ndCB0aGUgZGVzY3JpcHRpb24gb2YgdGhp
cyBwYXRjaA0KbWVudGlvbiB3aGV0aGVyIG9yIG5vdCBhbnkgZnVuY3Rpb25hbGl0eSBpcyBjaGFu
Z2VkIChJIHRoaW5rIG5vIGZ1bmN0aW9uYWxpdHkNCmhhcyBiZWVuIGNoYW5nZWQpPw0KDQpCYXJ0
Lg0KDQoNCg0K
