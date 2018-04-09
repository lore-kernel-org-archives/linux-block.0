Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 9 Apr 2018 09:49:12 -0700
From: Tejun Heo <tj@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Fix recently introduced races in the timeout
 handling code
Message-ID: <20180409164912.GF3126663@devbig577.frc2.facebook.com>
References: <20180409052038.5391-1-bart.vanassche@wdc.com>
 <3f0d4950-4ef1-a24f-0ad1-b274aa885f73@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3f0d4950-4ef1-a24f-0ad1-b274aa885f73@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

Hello, Sagi.

On Mon, Apr 09, 2018 at 11:37:15AM +0300, Sagi Grimberg wrote:
> 
> >If a completion occurs after blk_mq_rq_timed_out() has reset
> >rq->aborted_gstate and the request is again in flight when the timeout
> >expires then a request will be completed twice: a first time by the
> >timeout handler and a second time when the regular completion occurs.
> >
> >Additionally, the blk-mq timeout handling code ignores completions that
> >occur after blk_mq_check_expired() has been called and before
> >blk_mq_rq_timed_out() has reset rq->aborted_gstate. If a block driver
> >timeout handler always returns BLK_EH_RESET_TIMER then the result will
> >be that the request never terminates.
> 
> OK, now I understand how we can complete twice. Israel, can you verify
> this patch solves your double completion problem?
> 
> Given that it is, the change log of your patches should be modified to
> the original bug report it solves.
> 
> Thread starts here:
> http://lists.infradead.org/pipermail/linux-nvme/2018-February/015848.html

Can you please see whether the following two patches fix the problem
you've been seeing?

 http://lkml.kernel.org/r/20180402190053.GC388343@devbig577.frc2.facebook.com
 http://lkml.kernel.org/r/20180402190120.GD388343@devbig577.frc2.facebook.com

Thanks.

-- 
tejun
