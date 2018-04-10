Return-Path: <ming.lei@redhat.com>
Date: Tue, 10 Apr 2018 21:55:47 +0800
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
Message-ID: <20180410135541.GA22340@ming.t460p>
References: <20180410013455.7448-1-bart.vanassche@wdc.com>
 <20180410084133.GB9133@ming.t460p>
 <b36ea1107be4f32fb04fffdde3ee45a2e0fcc36c.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b36ea1107be4f32fb04fffdde3ee45a2e0fcc36c.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 10, 2018 at 12:58:04PM +0000, Bart Van Assche wrote:
> On Tue, 2018-04-10 at 16:41 +0800, Ming Lei wrote:
> > On Mon, Apr 09, 2018 at 06:34:55PM -0700, Bart Van Assche wrote:
> > > If a completion occurs after blk_mq_rq_timed_out() has reset
> > > rq->aborted_gstate and the request is again in flight when the timeout
> > 
> > Given rq->aborted_gstate is reset only for BLK_EH_RESET_TIMER, I
> > think you are addressing the race between normal completion and
> > the timeout of BLK_EH_RESET_TIMER.
> 
> Yes, that's correct. I will make this more explicit.
> 
> > > expires then a request will be completed twice: a first time by the
> > > timeout handler and a second time when the regular completion occurs.
> > 
> > This patch looks simpler, and more like the previous model of
> > using blk_mark_rq_complete().
> 
> That's also correct.
> 
> > I have one question:
> > 
> > - with this patch, rq's state is updated atomically as cmpxchg. Suppose
> > one rq is timed out, the rq's state is updated as MQ_RQ_COMPLETE by
> > blk_mq_check_expired(), then ops->timeout() is run and
> > BLK_EH_RESET_TIMER is returned, so blk_mq_add_timer(req, MQ_RQ_COMPLETE,
> > MQ_RQ_IN_FLIGHT) is called to update rq's state into MQ_RQ_IN_FLIGHT.
> > 
> > Now the original normal completion still may occur after rq's state
> > becomes MQ_RQ_IN_FLIGHT, and seems there is still the double completion
> > with this patch? Maybe I am wrong, please explain a bit.
> 
> That scenario won't result in a double completion. After the timer has
> been reset the block driver blk_mq_complete_request() call will change
> the request state from MQ_RQ_IN_FLIGHT into MQ_RQ_COMPLETE. The next
> time blk_mq_check_expired() is called it will execute the following code:
> 
> 	blk_mq_change_rq_state(rq, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE);
> 
> That function call only changes the request state if the current state is
> IN_FLIGHT. However, the blk_mq_complete_request() call changed the request
> state into COMPLETE. Hence, the above blk_mq_change_rq_state() call will
> return false and the blk-mq timeout code will skip this request. If the
> request would already have been reused and would have been marked again as
> IN_FLIGHT then its deadline will also have been updated and the request
> will be skipped by the timeout code because its deadline has not yet
> expired.

OK.

Then I have same question with Jianchao, what is the actual double
complete in linus tree between BLK_EH_RESET_TIMER and normal completion?

Follows my understanding:

1) when timeout is detected on one request, its aborted_gstate is
updated in blk_mq_check_expired().

2) run synchronize_rcu(), and make sure all pending completion is done

3) run blk_mq_rq_timed_out()
- ret = ops->timeout
- blk_mq_rq_update_aborted_gstate(req, 0)
- blk_add_timer(req);

If normal completion is done between 1) and reset aborted_gstate in 3),
blk_mq_complete_request() will be called, and found that aborted_gstate
is set, then the rq won't be completed really.

If normal completion is done after reset aborted_gstate in 3), it should
be same with applying this patch.

> 
> > And synchronize_rcu() is needed by Tejun's approach between marking
> > COMPLETE and handling this rq's timeout, and the time can be quite long,
> > I guess it might be easier to trigger?
> 
> I have done what I could to trigger races between the regular completion
> path and the timeout code in my tests. Without this patch if I run the
> srp-test software I see crashes being reported in the rdma_rxe driver but
> with this patch applied I don't see any crashes with my tests.

I believe this patch may fix this issue, but I think the idea behind
should be understood.

Thanks,
Ming
