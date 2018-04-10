Return-Path: <ming.lei@redhat.com>
Date: Tue, 10 Apr 2018 23:25:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"maxg@mellanox.com" <maxg@mellanox.com>,
	"tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
Message-ID: <20180410152553.GC22340@ming.t460p>
References: <20180410013455.7448-1-bart.vanassche@wdc.com>
 <20180410084133.GB9133@ming.t460p>
 <b36ea1107be4f32fb04fffdde3ee45a2e0fcc36c.camel@wdc.com>
 <20180410135541.GA22340@ming.t460p>
 <7c4a8b019182d5a9259ef20e6462b3f6a533abed.camel@wdc.com>
 <20180410143007.GB22340@ming.t460p>
 <e2762e359649946543ee22cf6ebf0c08410f7963.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e2762e359649946543ee22cf6ebf0c08410f7963.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 10, 2018 at 03:02:11PM +0000, Bart Van Assche wrote:
> On Tue, 2018-04-10 at 22:30 +0800, Ming Lei wrote:
> > On Tue, Apr 10, 2018 at 02:09:33PM +0000, Bart Van Assche wrote:
> > > Please keep in mind that all synchronize_rcu() does is to wait for pre-
> > > existing RCU readers to finish. synchronize_rcu() does not prevent that new
> > > rcu_read_lock() calls happen. It is e.g. possible that after
> > 
> > That is right, and I also mentioned normal completion can be done between
> > 1) and reset aborted_gstate in 3).
> > 
> > > blk_mq_rq_update_aborted_gstate(req, 0) has been executed that a regular
> > > completion occurs. If that request is not reused before the timer that was
> > > restarted by the timeout code expires, that request will be completed twice.
> > 
> > In this patch, blk_mq_add_timer(req, MQ_RQ_COMPLETE, MQ_RQ_IN_FLIGHT) is
> > called for handling BLK_EH_RESET_TIMER. And after rq's state is changed
> > to MQ_RQ_IN_FLIGHT, normal completion still can come and complete this rq,
> > just like the above you described, right?
> 
> I should have added the following in my previous e-mail: "if the completion
> occurs after blk_mq_check_expired() examined rq->gstate and before it updated
> rq->aborted_gstate".

That is the difference between tj's approach and your patch, but the
difference is just in the timing.

See this patch:

+   if (time_after_eq(jiffies, deadline) &&
+       blk_mq_change_rq_state(rq, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE)) {
+       blk_mq_rq_timed_out(rq, reserved);

Normal completion still can happen between blk_mq_change_rq_state()
and blk_mq_rq_timed_out().

In tj's approach, there is synchronize_rcu() between writing aborted_gstate
and blk_mq_rq_timed_out, it is easier for normal completion to happen during
the big window.

> That race can occur with the current upstream blk-mq
> timeout handling code but not after my patch has been applied.

In theory, the 'race' can occur with your patch too, but the window
is just so small.

If you think my comment is correct, please update your commit log.

-- 
Ming
