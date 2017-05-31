Return-Path: <prvs=3177d4db0=eduval@lab126.com>
Date: Wed, 31 May 2017 16:27:51 -0700
From: Eduardo Valentin <eduval@amazon.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
CC: "eduval@amazon.com" <eduval@amazon.com>, "hch@lst.de" <hch@lst.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com"
	<osandov@fb.com>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2 3/4] blk-mq-debugfs: Show busy requests
Message-ID: <20170531232751.GA29638@u40b0340c692b58f6553c.ant.amazon.com>
References: <20170531213050.30276-1-bart.vanassche@sandisk.com>
 <20170531213050.30276-4-bart.vanassche@sandisk.com>
 <20170531214327.GD7903@u40b0340c692b58f6553c.ant.amazon.com>
 <1496267153.2608.17.camel@sandisk.com>
 <20170531214955.GA13443@u40b0340c692b58f6553c.ant.amazon.com>
 <1496267650.2608.19.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1496267650.2608.19.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 31, 2017 at 09:54:11PM +0000, Bart Van Assche wrote:
> On Wed, 2017-05-31 at 14:49 -0700, Eduardo Valentin wrote:
> > On Wed, May 31, 2017 at 09:45:54PM +0000, Bart Van Assche wrote:
> > > On Wed, 2017-05-31 at 14:43 -0700, Eduardo Valentin wrote:
> > > > On Wed, May 31, 2017 at 02:30:49PM -0700, Bart Van Assche wrote:
> > > > > +static void hctx_show_busy(struct request *rq, void *data, bool reserved)
> > > > > +{
> > > > > +	const struct show_busy_params *params = data;
> > > > > +
> > > > > +	if (blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) == params->hctx &&
> > > > > +	    test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
> > > > > +		__blk_mq_debugfs_rq_show(params->m,
> > > > > +					 list_entry_rq(&rq->queuelist));
> > > > > +}
> > > > > +
> > > > > +static int hctx_busy_show(void *data, struct seq_file *m)
> > > > > +{
> > > > > +	struct blk_mq_hw_ctx *hctx = data;
> > > > > +	struct show_busy_params params = { .m = m, .hctx = hctx };
> > > > > +
> > > > > +	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy, &params);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > 
> > > > Why not making the two above one single function?
> > > > hctx_busy_show vs. hctx_show_busy seams a bit confusing, and I could not see
> > > > where they get reused in your patch set..
> > > 
> > > Hello Eduardo,
> > > 
> > > If I would open-code blk_mq_tagset_busy_iter() then I would be able to implement
> > > the above two functions as a single function. However, blk_mq_tagset_busy_iter()
> > > expects a function pointer as third argument. That's why the above functionality
> > > has been split over two functions.
> > 
> > Yeah, my bad here. I misread the functions. But still the naming doesnt seam
> > too suggestive? how about s/hctx_show_busy/hctx_busy_entry/g?
> 
> Hello Eduardo,
> 
> Since that function shows information about a single request, how about
> hctx_show_busy_rq()?

Sounds good to me.

> 
> Bart.

-- 
All the best,
Eduardo Valentin
