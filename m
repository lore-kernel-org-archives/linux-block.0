Return-Path: <ming.lei@redhat.com>
Date: Sat, 2 Dec 2017 09:00:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"hare@suse.de" <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 4/7] blk-mq: Avoid that request processing stalls when
 sharing tags
Message-ID: <20171202010026.GC24521@ming.t460p>
References: <20171201000848.2656-1-bart.vanassche@wdc.com>
 <20171201000848.2656-5-bart.vanassche@wdc.com>
 <20171201025803.GA29741@ming.t460p>
 <1512157932.2520.27.camel@wdc.com>
 <20171202003625.GA24521@ming.t460p>
 <1512175730.2520.29.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512175730.2520.29.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Dec 02, 2017 at 12:48:51AM +0000, Bart Van Assche wrote:
> On Sat, 2017-12-02 at 08:36 +0800, Ming Lei wrote:
> > On Fri, Dec 01, 2017 at 07:52:14PM +0000, Bart Van Assche wrote:
> > > On Fri, 2017-12-01 at 10:58 +0800, Ming Lei wrote:
> > > > On Thu, Nov 30, 2017 at 04:08:45PM -0800, Bart Van Assche wrote:
> > > > > blk_mq_dispatch_rq_list() is called. Make sure that
> > > > > BLK_MQ_S_SCHED_RESTART is set before any blk_mq_dispatch_rq_list()
> > > > > call occurs.
> > > > > 
> > > > > Fixes: commit b347689ffbca ("blk-mq-sched: improve dispatching from sw queue")
> > > > 
> > > > We always mark RESTART state bit just before dispatching from ->dispatch_list,
> > > > this way has been there before b347689ffbca, which doesn't change this
> > > > RESTART mechanism, so please explain a bit why it is a fix on commit
> > > > b347689ffbca.
> > > 
> > > I'm not completely sure which patch introduced the lockup fixed by this patch
> > > but I will have another look whether this was really introduced by commit
> > > b347689ffbca.
> > 
> > Please make sure 'Fixes' tag correct.
> 
> Further tests have shown that the lockup I referred to does not occur before commit
> b347689ffbca but that it occurs with b347689ffbca.

Then you need to root cause it, or

Provide debugfs log and reproduction steps, please.

> I think that shows clearly that commit b347689ffbca introduced this lockup.

That may not be so clearly, maybe it is just triggered easily after this
commit.

-- 
Ming
