Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 9 Apr 2018 09:47:37 -0700
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Fix recently introduced races in the timeout
 handling code
Message-ID: <20180409164737.GE3126663@devbig577.frc2.facebook.com>
References: <20180409052038.5391-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180409052038.5391-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hey, Bart.

On Sun, Apr 08, 2018 at 10:20:38PM -0700, Bart Van Assche wrote:
> If a completion occurs after blk_mq_rq_timed_out() has reset
> rq->aborted_gstate and the request is again in flight when the timeout
> expires then a request will be completed twice: a first time by the
> timeout handler and a second time when the regular completion occurs.

Are we still talking about the same BLK_EH_RESET_TIMER case?  This can
be solved by the two patches which rcu-synchronizes the hand-over to
normal completion path, right?

> Additionally, the blk-mq timeout handling code ignores completions that
> occur after blk_mq_check_expired() has been called and before
> blk_mq_rq_timed_out() has reset rq->aborted_gstate. If a block driver
> timeout handler always returns BLK_EH_RESET_TIMER then the result will
> be that the request never terminates.

And this is the same race window which was always there, right?  I
really don't think reducing or closing this window requires full
synchronization.

Thanks.

-- 
tejun
