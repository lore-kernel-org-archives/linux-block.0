Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 12 Dec 2017 13:44:32 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"oleg@redhat.com" <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 2/6] blk-mq: replace timeout synchronization with a RCU
 and generation based scheme
Message-ID: <20171212214432.GL3919388@devbig577.frc2.facebook.com>
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-3-tj@kernel.org>
 <1513114630.2999.48.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513114630.2999.48.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Tue, Dec 12, 2017 at 09:37:11PM +0000, Bart Van Assche wrote:
> Have you considered the following instead of introducing MQ_RQ_IDLE and
> MQ_RQ_IN_FLIGHT? I think this could help to limit the number of new atomic
> operations introduced in the hot path by this patch series.

But nothing in the hot paths is atomic.

> static inline bool blk_mq_rq_in_flight(struct request *rq)
> {
> 	return list_empty(&rq->queuelist);
> }

And the fact that we encode the generation number and state into a
single variable contributes to not needing atomic operations.
Breaking up the state and generation like the above would need more
synchronization, not less.

Thanks.

-- 
tejun
