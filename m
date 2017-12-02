Return-Path: <ming.lei@redhat.com>
Date: Sat, 2 Dec 2017 08:36:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 4/7] blk-mq: Avoid that request processing stalls when
 sharing tags
Message-ID: <20171202003625.GA24521@ming.t460p>
References: <20171201000848.2656-1-bart.vanassche@wdc.com>
 <20171201000848.2656-5-bart.vanassche@wdc.com>
 <20171201025803.GA29741@ming.t460p>
 <1512157932.2520.27.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512157932.2520.27.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 01, 2017 at 07:52:14PM +0000, Bart Van Assche wrote:
> On Fri, 2017-12-01 at 10:58 +0800, Ming Lei wrote:
> > On Thu, Nov 30, 2017 at 04:08:45PM -0800, Bart Van Assche wrote:
> > > blk_mq_sched_mark_restart_hctx() must be called before
> > 
> > Could you please describe the theory on commit log? Like, why is it
> > a must? and what is the issue to be fixed? 
> 
> The BLK_MQ_S_SCHED_RESTART test at the end of blk_mq_dispatch_rq_list() can
> only work if BLK_MQ_S_SCHED_RESTART is set before blk_mq_dispatch_rq_list()
> is called.

The theory about using BLK_MQ_S_SCHED_RESTART in current way is that we
mark it after requests are added to hctx->dispatch, then blk_mq_sched_restart() 
can see this request to be revisited.

So in theory, we don't need to set it before each dispatch.

Once .get_budget()/.put_budget() is introduced, things may be a bit
different because we may need to revisit requests in scheduler/SW queue.
But we depend on SCSI's RESTART(scsi_end_request()) to do that. So we
still don't need this patch.

> BTW, without this patch every iteration of my test triggers a
> queue stall. With this patch a queue stall only occurs sporadically so I
> think we really need something like this patch.

We need to root cause your queue stall first, otherwise any change can
be thought as workaround. Could you investigate the issue a bit and get
the exact reason?

> 
> > > blk_mq_dispatch_rq_list() is called. Make sure that
> > > BLK_MQ_S_SCHED_RESTART is set before any blk_mq_dispatch_rq_list()
> > > call occurs.
> > > 
> > > Fixes: commit b347689ffbca ("blk-mq-sched: improve dispatching from sw queue")
> > 
> > We always mark RESTART state bit just before dispatching from ->dispatch_list,
> > this way has been there before b347689ffbca, which doesn't change this
> > RESTART mechanism, so please explain a bit why it is a fix on commit
> > b347689ffbca.
> 
> I'm not completely sure which patch introduced the lockup fixed by this patch
> but I will have another look whether this was really introduced by commit
> b347689ffbca.

Please make sure 'Fixes' tag correct.

-- 
Ming
