Return-Path: <sebott@linux.ibm.com>
Date: Tue, 15 May 2018 15:49:40 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Tejun Heo <tj@kernel.org>, Jianchao Wang <jianchao.w.wang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v9 2/2] blk-mq: Rework blk-mq timeout handling again
In-Reply-To: <20180514184634.2160-3-bart.vanassche@wdc.com>
References: <20180514184634.2160-1-bart.vanassche@wdc.com> <20180514184634.2160-3-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1805151542370.1605@schleppi>
List-ID: <linux-block@vger.kernel.org>

On Mon, 14 May 2018, Bart Van Assche wrote:
> Recently the blk-mq timeout handling code was reworked. See also Tejun
> Heo, "[PATCHSET v4] blk-mq: reimplement timeout handling", 08 Jan 2018
> (https://www.mail-archive.com/linux-block@vger.kernel.org/msg16985.html).
> This patch reworks the blk-mq timeout handling code again. The timeout
> handling code is simplified by introducing a state machine per request.
> This change avoids that the blk-mq timeout handling code ignores
> completions that occur after blk_mq_check_expired() has been called and
> before blk_mq_rq_timed_out() has reset rq->aborted_gstate. If a block
> driver timeout handler always returns BLK_EH_RESET_TIMER then the result
> will be that the request never terminates.
> 
> Fix this race as follows:
> - Replace the __deadline member of struct request by a new member
>   called das that contains the generation number, state and deadline.
>   Only 32 bits are used for the deadline field such that all three
>   fields occupy only 64 bits. This change reduces the maximum supported
>   request timeout value from (2**63/HZ) to (2**31/HZ).
> - Remove all request member variables that became superfluous due to
>   this change: gstate, gstate_seq and aborted_gstate_sync.
> - Remove the request state information that became superfluous due to
>   this patch, namely RQF_MQ_TIMEOUT_EXPIRED.
> - Remove the code that became superfluous due to this change, namely
>   the RCU lock and unlock statements in blk_mq_complete_request() and
>   also the synchronize_rcu() call in the timeout handler.
> 
> Notes:
> - A spinlock is used to protect atomic changes of rq->das on those
>   architectures that do not provide a cmpxchg64() implementation.
> - Atomic instructions are only used to update the request state if
>   a concurrent request state change could be in progress.
> - blk_add_timer() has been split into two functions - one for the
>   legacy block layer and one for blk-mq.
> 

I tested your patch on top of block/for-next (with forced timeouts) -
works as expected. The lockdep warnings with regard to gstate_seq are
gone (surprise with gstate_seq gone) - thanks for that!

Regards,
Sebastian
