Return-Path: <prvs=5392d374c=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jbacik@fb.com" <jbacik@fb.com>, "tj@kernel.org" <tj@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "clm@fb.com" <clm@fb.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "kernel-team@fb.com" <kernel-team@fb.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jianchao.w.wang@oracle.com"
	<jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 8/8] blk-mq: rename blk_mq_hw_ctx->queue_rq_srcu to ->srcu
Date: Mon, 8 Jan 2018 23:48:00 +0000
Message-ID: <1515455280.2909.46.camel@wdc.com>
References: <20180108191542.379478-1-tj@kernel.org>
	 <20180108191542.379478-9-tj@kernel.org>
In-Reply-To: <20180108191542.379478-9-tj@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTAxLTA4IGF0IDExOjE1IC0wODAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IFRo
ZSBSQ1UgcHJvdGVjdGlvbiBoYXMgYmVlbiBleHBhbmRlZCB0byBjb3ZlciBib3RoIHF1ZXVlaW5n
IGFuZA0KPiBjb21wbGV0aW9uIHBhdGhzIG1ha2luZyAtPnF1ZXVlX3JxX3NyY3UgYSBtaXNub21l
ci4gIFJlbmFtZSBpdCB0bw0KPiAtPnNyY3UgYXMgc3VnZ2VzdGVkIGJ5IEJhcnQuDQoNClJldmll
d2VkLWJ5OiBCYXJ0IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHdkYy5jb20+DQoNCg==
