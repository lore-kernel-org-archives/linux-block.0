Return-Path: <shli@kernel.org>
Date: Tue, 29 Aug 2017 08:13:39 -0700
From: Shaohua Li <shli@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, Kernel-team@fb.com,
	Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V2 2/2] block/loop: allow request merge for directio mode
Message-ID: <20170829151339.7zc2qv32qsfknpjh@kernel.org>
References: <cover.1503602376.git.shli@fb.com>
 <cafa738c4f61d9b549b7d4675903e8c61962480b.1503602376.git.shli@fb.com>
 <20170829095604.GB32439@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170829095604.GB32439@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 29, 2017 at 05:56:05PM +0800, Ming Lei wrote:
> On Thu, Aug 24, 2017 at 12:24:53PM -0700, Shaohua Li wrote:
> > From: Shaohua Li <shli@fb.com>
> > 
> > Currently loop disables merge. While it makes sense for buffer IO mode,
> > directio mode can benefit from request merge. Without merge, loop could
> > send small size IO to underlayer disk and harm performance.
> 
> Hi Shaohua,
> 
> IMO no matter if merge is used, loop always sends page by page
> to VFS in both dio or buffer I/O.

Why do you think so?
 
> Also if merge is enabled on loop, that means merge is run
> on both loop and low level block driver, and not sure if we
> can benefit from that.

why does merge still happen in low level block driver?

> 
> So Could you provide some performance data about this patch?

In my virtual machine, a workload improves from ~20M/s to ~50M/s. And I clearly
see the request size becomes bigger.

> > 
> > Reviewed-by: Omar Sandoval <osandov@fb.com>
> > Signed-off-by: Shaohua Li <shli@fb.com>
> > ---
> >  drivers/block/loop.c | 66 ++++++++++++++++++++++++++++++++++++++++------------
> >  drivers/block/loop.h |  1 +
> >  2 files changed, 52 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 428da07..75a8f6e 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -213,10 +213,13 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
> >  	 */
> >  	blk_mq_freeze_queue(lo->lo_queue);
> >  	lo->use_dio = use_dio;
> > -	if (use_dio)
> > +	if (use_dio) {
> > +		queue_flag_clear_unlocked(QUEUE_FLAG_NOMERGES, lo->lo_queue);
> >  		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
> > -	else
> > +	} else {
> > +		queue_flag_set_unlocked(QUEUE_FLAG_NOMERGES, lo->lo_queue);
> >  		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
> > +	}
> >  	blk_mq_unfreeze_queue(lo->lo_queue);
> >  }
> >  
> > @@ -464,6 +467,8 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
> >  {
> >  	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
> >  
> > +	kfree(cmd->bvec);
> > +	cmd->bvec = NULL;
> >  	cmd->ret = ret;
> >  	blk_mq_complete_request(cmd->rq);
> >  }
> > @@ -473,22 +478,50 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
> >  {
> >  	struct iov_iter iter;
> >  	struct bio_vec *bvec;
> > -	struct bio *bio = cmd->rq->bio;
> > +	struct request *rq = cmd->rq;
> > +	struct bio *bio = rq->bio;
> >  	struct file *file = lo->lo_backing_file;
> > +	unsigned int offset;
> > +	int segments = 0;
> >  	int ret;
> >  
> > -	/* nomerge for loop request queue */
> > -	WARN_ON(cmd->rq->bio != cmd->rq->biotail);
> > +	if (rq->bio != rq->biotail) {
> > +		struct req_iterator iter;
> > +		struct bio_vec tmp;
> > +
> > +		__rq_for_each_bio(bio, rq)
> > +			segments += bio_segments(bio);
> > +		bvec = kmalloc(sizeof(struct bio_vec) * segments, GFP_KERNEL);
> 
> The allocation should have been GFP_NOIO.

Sounds good. To make this completely correct isn't easy though, we are calling
into the underlayer fs operations which can do allocation.

Thanks,
Shaohua
