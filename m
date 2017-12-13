Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 13 Dec 2017 08:13:12 -0800
From: Tejun Heo <tj@kernel.org>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, oleg@redhat.com,
	peterz@infradead.org, kernel-team@fb.com, osandov@fb.com,
	linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 1/6] blk-mq: protect completion path with RCU
Message-ID: <20171213161312.GS3919388@devbig577.frc2.facebook.com>
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-2-tj@kernel.org>
 <402aea05-8d04-99e2-5e31-803d2423283d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <402aea05-8d04-99e2-5e31-803d2423283d@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Dec 13, 2017 at 11:30:48AM +0800, jianchao.wang wrote:
> > +	} else {
> > +		srcu_idx = srcu_read_lock(hctx->queue_rq_srcu);
> > +		if (!blk_mark_rq_complete(rq))
> > +			__blk_mq_complete_request(rq);
> > +		srcu_read_unlock(hctx->queue_rq_srcu, srcu_idx);
> 
> The __blk_mq_complete_request() could be executed in irq context. There should not be any 
> sleeping operations in it. If just synchronize with the timeout path to ensure the aborted_gstate
> to be seen, only rcu is needed here ,as well as the blk_mq_timeout_work.

Sure, but it's just a lot cleaner to use the same to protect both
issue and completion; otherwise, whoever who wants to synchronize
against them have to do awkward double rcu locking.

Thanks.

-- 
tejun
