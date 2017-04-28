Return-Path: <ming.lei@redhat.com>
Date: Sat, 29 Apr 2017 00:02:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "osandov@fb.com" <osandov@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hare@suse.com" <hare@suse.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] blk-mq: Make blk_mq_quiesce_queue() wait for all
 .queue_rq() calls
Message-ID: <20170428160157.GE25592@ming.t460p>
References: <20170427155437.23228-1-bart.vanassche@sandisk.com>
 <20170427155437.23228-2-bart.vanassche@sandisk.com>
 <20170428020038.GA31518@ming.t460p>
 <1493393758.2767.3.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493393758.2767.3.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 28, 2017 at 03:35:59PM +0000, Bart Van Assche wrote:
> On Fri, 2017-04-28 at 10:00 +0800, Ming Lei wrote:
> > On Thu, Apr 27, 2017 at 08:54:32AM -0700, Bart Van Assche wrote:
> > >  void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
> > >  {
> > > -	cancel_work(&hctx->run_work);
> > > -	cancel_delayed_work(&hctx->delay_work);
> > > +	cancel_work_sync(&hctx->run_work);
> > > +	cancel_delayed_work_sync(&hctx->delay_work);
> > 
> > Could you explain it a bit why we need the sync version?
> 
> Because the purpose of this patch is to make blk_mq_quiesce_queue() wait for
> all .queue_rq() calls.

If only .queue_rq() from this queue is waited, blk_mq_freeze_queue() is
enough. If you want to wait .queue_rq() from all queues,
blk_mq_quiesce_queue() can't do that too.

Firstly there shouldn't be a 'struct request_queue' parameter passed to this
function, because you want to wait for .queue_rq() from all queues.

Secondaly your current implementation can't guarantee that point:
	- only hw queues of this queue are stopped in this function, and
	.queue_rq() from other queues still can be run once
	synchronize_rcu() returns.

	- for BLOCKING case, the SRCU is per hctx.

Thirdly I am still not sure why we want to wait for all .queue_rq(),
could you explain it a bit?

At least for mq scheduler switch, looks all schedule data is per request
queue, and we shouldn't have needed to wait all .queue_rq().

> 
> > So I suggest to unity both .run_work and .dealyed_run_work
> > into one work, just as what Jens did in the following link:
> > 
> > 	http://marc.info/?t=149183989800010&r=1&w=2
> 
> That should be done after this patch is upstream otherwise this
> patch won't apply to the stable trees.

OK.

Thanks,
Ming
