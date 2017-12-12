Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 12 Dec 2017 14:22:04 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"osandov@fb.com" <osandov@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 6/6] blk-mq: remove REQ_ATOM_STARTED
Message-ID: <20171212222204.GM3919388@devbig577.frc2.facebook.com>
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-7-tj@kernel.org>
 <1513117238.2999.54.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513117238.2999.54.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Dec 12, 2017 at 10:20:39PM +0000, Bart Van Assche wrote:
> The above code should show all requests owned by the block driver. Patch
> "blk-mq-debugfs: Also show requests that have not yet been started" (not yet
> in Jens' tree) changes the REQ_ATOM_STARTED test into list_empty(&rq->queuelist).
> Can that change be supported with the existing MQ_RQ_* states or will a new
> state have to be introduced to support this? See also
> https://marc.info/?l=linux-block&m=151252188411991.

If list_empty() test was correct before, it'd be correct now too.

Thnaks.

-- 
tejun
