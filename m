Return-Path: <ming.lei@redhat.com>
Date: Sat, 27 May 2017 11:16:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 4/5] blk-mq-debugfs: Show busy requests
Message-ID: <20170527031634.GC20909@ming.t460p>
References: <20170525233810.23211-1-bart.vanassche@sandisk.com>
 <20170525233810.23211-5-bart.vanassche@sandisk.com>
 <20170527005456.GB20421@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170527005456.GB20421@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Sat, May 27, 2017 at 08:54:57AM +0800, Ming Lei wrote:
> On Thu, May 25, 2017 at 04:38:09PM -0700, Bart Van Assche wrote:
> > Requests that got stuck in a block driver are neither on
> > blk_mq_ctx.rq_list nor on any hw dispatch queue. Make these
> > visible in debugfs through the "busy" attribute.
> 
> The name of 'busy' isn't very explicit about this case, and I
> guess you mean the requests are dispatched to hardware, so
> 'dispatched' or sort of name may be more accurate.
> 
> > 
> > Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Omar Sandoval <osandov@fb.com>
> > Cc: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq-debugfs.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index 8b06a12c1461..70a2b955afee 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -370,6 +370,30 @@ static const struct seq_operations hctx_dispatch_seq_ops = {
> >  	.show	= blk_mq_debugfs_rq_show,
> >  };
> >  
> > +struct show_busy_ctx {
> > +	struct seq_file		*m;
> > +	struct blk_mq_hw_ctx	*hctx;
> > +};
> > +
> > +static void hctx_show_busy(struct request *rq, void *data, bool reserved)
> > +{
> > +	const struct show_busy_ctx *ctx = data;
> > +
> > +	if (blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) == ctx->hctx &&
> > +	    test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
> 
> During this small window, the request can be freed and reallocated
> in another I/O path, then use-after-free is caused.
> 
> > +		blk_mq_debugfs_rq_show(ctx->m, &rq->queuelist);
> > +}
> > +
> > +static int hctx_busy_show(void *data, struct seq_file *m)
> > +{
> > +	struct blk_mq_hw_ctx *hctx = data;
> > +	struct show_busy_ctx ctx = { .m = m, .hctx = hctx };
> > +
> > +	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy, &ctx);
> 
> This way is easy to cause use-after-free, so as a debug function,
> you can't affect the normal function.
> 
> But the new fixed blk_mq_quiesce_queue() can be used before calling
> blk_mq_tagset_busy_iter() to avoid the race.
> 
> http://marc.info/?l=linux-block&m=149578610419654&w=2

Actually blk_mq_quiesce_queue can make other cancel cases safe because
blk_mark_rq_complete() is used before canceling.

For this case, we can't use blk_mark_rq_complete(), so there can't
be a safe way to touch the request dispatched to hardware.

Given the dispatched request won't be touched by CPU,
and its state shouldn't be changed, I am just wondering what is
the real motivation for this debug interface, could Bart explain
a bit?

Thanks,
Ming
