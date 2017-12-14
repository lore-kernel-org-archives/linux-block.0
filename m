Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 14 Dec 2017 10:14:01 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"osandov@fb.com" <osandov@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/6] blk-mq: protect completion path with RCU
Message-ID: <20171214181401.GA3919388@devbig577.frc2.facebook.com>
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-2-tj@kernel.org>
 <1513270860.2475.14.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513270860.2475.14.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 14, 2017 at 05:01:06PM +0000, Bart Van Assche wrote:
> On Tue, 2017-12-12 at 11:01 -0800, Tejun Heo wrote:
> > +	} else {
> > +		srcu_idx = srcu_read_lock(hctx->queue_rq_srcu);
> > +		if (!blk_mark_rq_complete(rq))
> > +			__blk_mq_complete_request(rq);
> > +		srcu_read_unlock(hctx->queue_rq_srcu, srcu_idx);
> 
> Hello Tejun,
> 
> The name queue_rq_srcu was chosen to reflect the original use of that structure,
> namely to protect .queue_rq() calls. Your patch series broadens the use of that

Yeah, will add a patch to rename it.

> srcu structure so I would appreciate it if it would be renamed, e.g. into "srcu".
> See also commit 6a83e74d214a ("blk-mq: Introduce blk_mq_quiesce_queue()").

Ah yeah, it'd be nice to have the [s]rcu synchronize calls factored
out.

Thanks.

-- 
tejun
