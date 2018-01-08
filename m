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
Subject: Re: [PATCH 4/8] blk-mq: use blk_mq_rq_state() instead of testing
 REQ_ATOM_COMPLETE
Date: Mon, 8 Jan 2018 22:03:53 +0000
Message-ID: <1515449032.2909.27.camel@wdc.com>
References: <20180108191542.379478-1-tj@kernel.org>
	 <20180108191542.379478-5-tj@kernel.org>
In-Reply-To: <20180108191542.379478-5-tj@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

T24gTW9uLCAyMDE4LTAxLTA4IGF0IDExOjE1IC0wODAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IGJs
a19tcV9jaGVja19pbmZsaWdodCgpIGFuZCBibGtfbXFfcG9sbF9oeWJyaWRfc2xlZXAoKSB0ZXN0
DQo+IFJFUV9BVE9NX0NPTVBMRVRFIHRvIGRldGVybWluZSB0aGUgcmVxdWVzdCBzdGF0ZS4gIEJv
dGggdXNlcyBhcmUNCj4gc3BlY3VsYXRpdmUgYW5kIHdlIGNhbiB0ZXN0IFJFUV9BVE9NX1NUQVJU
RUQgYW5kIGJsa19tcV9ycV9zdGF0ZSgpIGZvcg0KPiBlcXVpdmFsZW50IHJlc3VsdHMuICBSZXBs
YWNlIHRoZSB0ZXN0cy4gIFRoaXMgd2lsbCBhbGxvdyByZW1vdmluZw0KPiBSRVFfQVRPTV9DT01Q
TEVURSB1c2FnZXMgZnJvbSBibGstbXEuDQoNClJldmlld2VkLWJ5OiBCYXJ0IFZhbiBBc3NjaGUg
PGJhcnQudmFuYXNzY2hlQHdkYy5jb20+DQoNCg==
