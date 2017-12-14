Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 14 Dec 2017 11:19:35 -0800
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
Message-ID: <20171214191935.GB3919388@devbig577.frc2.facebook.com>
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-3-tj@kernel.org>
 <1513277469.2475.43.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513277469.2475.43.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Dec 14, 2017 at 06:51:11PM +0000, Bart Van Assche wrote:
> On Tue, 2017-12-12 at 11:01 -0800, Tejun Heo wrote:
> > rules.  Unfortunatley, it contains quite a few holes.
>           ^^^^^^^^^^^^^
>           Unfortunately?
> 
> > While this change makes REQ_ATOM_COMPLETE synchornization unnecessary
>                                             ^^^^^^^^^^^^^^^
>                                             synchronization?

lol, believe it or not, my english spelling is a lot better than my
korean.  Will fix them.

> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -126,6 +126,8 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
> >  	rq->start_time = jiffies;
> >  	set_start_time_ns(rq);
> >  	rq->part = NULL;
> > +	seqcount_init(&rq->gstate_seq);
> > +	u64_stats_init(&rq->aborted_gstate_sync);
> >  }
> >  EXPORT_SYMBOL(blk_rq_init);
> 
> Sorry but the above change looks ugly to me. My understanding is that 
> blk_rq_init() is only used inside the block layer to initialize legacy block
> layer requests while gstate_seq and aborted_gstate_sync are only relevant
> for blk-mq requests. Wouldn't it be better to avoid that blk_rq_init() is
> called for blk-mq requests such that the above change can be left out? The
> only callers outside the block layer core of blk_rq_init() I know of are
> ide_prep_sense() and scsi_ioctl_reset(). I can help with converting the SCSI
> code if you want.

This is also used by flush path.  We probably should clean that up,
but let's worry about that later cuz flush handling has enough of its
own complications.

> > +	write_seqcount_begin(&rq->gstate_seq);
> > +	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
> > +	blk_add_timer(rq);
> > +	write_seqcount_end(&rq->gstate_seq);
> 
> My understanding is that both write_seqcount_begin() and write_seqcount_end()
> trigger a write memory barrier. Is a seqcount really faster than a spinlock?

Write memory barrier has no cost on x86 and usually pretty low cost
elsewhere too and they're likely in the same cacheline as other rq
fields.

> > @@ -792,6 +811,14 @@ void blk_mq_rq_timed_out(struct request *req, bool reserved)
> >  		__blk_mq_complete_request(req);
> >  		break;
> >  	case BLK_EH_RESET_TIMER:
> > +		/*
> > +		 * As nothing prevents from completion happening while
> > +		 * ->aborted_gstate is set, this may lead to ignored
> > +		 * completions and further spurious timeouts.
> > +		 */
> > +		u64_stats_update_begin(&req->aborted_gstate_sync);
> > +		req->aborted_gstate = 0;
> > +		u64_stats_update_end(&req->aborted_gstate_sync);
> 
> If a blk-mq request is resubmitted 2**62 times, can that result in the above
> code setting aborted_gstate to the same value as gstate? Isn't that a bug?
> If so, how about setting aborted_gstate in the above code to e.g. gstate ^ (2**63)?

A request gets aborted only if the state is in-flight, 0 isn't that.
Also, how many years would 2^62 times be?

> > +	struct u64_stats_sync aborted_gstate_sync;
> > +	u64 aborted_gstate;
> > +
> >  	unsigned long deadline;
> >  	struct list_head timeout_list;
> 
> Why are gstate and aborted_gstate 64-bit variables? What makes you think that
> 32 bits would not be enough?

Because 32 bits puts it in the rance where a false hit is still
theoretically possible in a reasonable amount of time.

Thanks.

-- 
tejun
