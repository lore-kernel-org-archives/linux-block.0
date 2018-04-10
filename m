Return-Path: <ming.lei@redhat.com>
Date: Tue, 10 Apr 2018 22:30:08 +0800
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
Message-ID: <20180410143007.GB22340@ming.t460p>
References: <20180410013455.7448-1-bart.vanassche@wdc.com>
 <20180410084133.GB9133@ming.t460p>
 <b36ea1107be4f32fb04fffdde3ee45a2e0fcc36c.camel@wdc.com>
 <20180410135541.GA22340@ming.t460p>
 <7c4a8b019182d5a9259ef20e6462b3f6a533abed.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7c4a8b019182d5a9259ef20e6462b3f6a533abed.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 10, 2018 at 02:09:33PM +0000, Bart Van Assche wrote:
> On Tue, 2018-04-10 at 21:55 +0800, Ming Lei wrote:
> > Then I have same question with Jianchao, what is the actual double
> > complete in linus tree between BLK_EH_RESET_TIMER and normal completion?
> > 
> > Follows my understanding:
> > 
> > 1) when timeout is detected on one request, its aborted_gstate is
> > updated in blk_mq_check_expired().
> > 
> > 2) run synchronize_rcu(), and make sure all pending completion is done
> > 
> > 3) run blk_mq_rq_timed_out()
> > - ret = ops->timeout
> > - blk_mq_rq_update_aborted_gstate(req, 0)
> > - blk_add_timer(req);
> > 
> > If normal completion is done between 1) and reset aborted_gstate in 3),
> > blk_mq_complete_request() will be called, and found that aborted_gstate
> > is set, then the rq won't be completed really.
> > 
> > If normal completion is done after reset aborted_gstate in 3), it should
> > be same with applying this patch.
> 
> Hello Ming,
> 
> Please keep in mind that all synchronize_rcu() does is to wait for pre-
> existing RCU readers to finish. synchronize_rcu() does not prevent that new
> rcu_read_lock() calls happen. It is e.g. possible that after

That is right, and I also mentioned normal completion can be done between
1) and reset aborted_gstate in 3).

> blk_mq_rq_update_aborted_gstate(req, 0) has been executed that a regular
> completion occurs. If that request is not reused before the timer that was
> restarted by the timeout code expires, that request will be completed twice.

In this patch, blk_mq_add_timer(req, MQ_RQ_COMPLETE, MQ_RQ_IN_FLIGHT) is
called for handling BLK_EH_RESET_TIMER. And after rq's state is changed
to MQ_RQ_IN_FLIGHT, normal completion still can come and complete this rq,
just like the above you described, right?


Thanks,
Ming
