Return-Path: <ming.lei@redhat.com>
Date: Tue, 10 Apr 2018 16:41:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
Message-ID: <20180410084133.GB9133@ming.t460p>
References: <20180410013455.7448-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180410013455.7448-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 09, 2018 at 06:34:55PM -0700, Bart Van Assche wrote:
> If a completion occurs after blk_mq_rq_timed_out() has reset
> rq->aborted_gstate and the request is again in flight when the timeout

Given rq->aborted_gstate is reset only for BLK_EH_RESET_TIMER, I
think you are addressing the race between normal completion and
the timeout of BLK_EH_RESET_TIMER.

> expires then a request will be completed twice: a first time by the
> timeout handler and a second time when the regular completion occurs.

This patch looks simpler, and more like the previous model of
using blk_mark_rq_complete().

I have one question:

- with this patch, rq's state is updated atomically as cmpxchg. Suppose
one rq is timed out, the rq's state is updated as MQ_RQ_COMPLETE by
blk_mq_check_expired(), then ops->timeout() is run and
BLK_EH_RESET_TIMER is returned, so blk_mq_add_timer(req, MQ_RQ_COMPLETE,
MQ_RQ_IN_FLIGHT) is called to update rq's state into MQ_RQ_IN_FLIGHT.

Now the original normal completion still may occur after rq's state
becomes MQ_RQ_IN_FLIGHT, and seems there is still the double completion
with this patch? Maybe I am wrong, please explain a bit.

And synchronize_rcu() is needed by Tejun's approach between marking
COMPLETE and handling this rq's timeout, and the time can be quite long,
I guess it might be easier to trigger?

Thanks,
Ming
