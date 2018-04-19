Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v6] blk-mq: Avoid that a completion can be ignored for
 BLK_EH_RESET_TIMER
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Israel Rukshin <israelr@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, stable@vger.kernel.org
References: <20180419164353.13561-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bbac4047-d806-d670-4363-ea70ad9b8aa4@kernel.dk>
Date: Thu, 19 Apr 2018 13:06:31 -0600
MIME-Version: 1.0
In-Reply-To: <20180419164353.13561-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/19/18 10:43 AM, Bart Van Assche wrote:
> The blk-mq timeout handling code ignores completions that occur after
> blk_mq_check_expired() has been called and before blk_mq_rq_timed_out()
> has reset rq->aborted_gstate. If a block driver timeout handler always
> returns BLK_EH_RESET_TIMER then the result will be that the request
> never terminates.
> 
> Fix this race as follows:
> - Use the deadline instead of the request generation to detect whether
>   or not a request timer fired after reinitialization of a request.
> - Store the request state in the lowest two bits of the deadline instead
>   of the lowest two bits of 'gstate'.
> - Rename MQ_RQ_STATE_MASK into RQ_STATE_MASK and change it from an
>   enumeration member into a #define such that its type can be changed
>   into unsigned long. That allows to write & ~RQ_STATE_MASK instead of
>   ~(unsigned long)RQ_STATE_MASK.
> - Remove all request member variables that became superfluous due to
>   this change: gstate, gstate_seq and aborted_gstate_sync.
> - Remove the request state information that became superfluous due to this
>   patch, namely RQF_MQ_TIMEOUT_EXPIRED.
> - Remove the code that became superfluous due to this change, namely
>   the RCU lock and unlock statements in blk_mq_complete_request() and
>   also the synchronize_rcu() call in the timeout handler.

I like this approach, it's simpler and easier to understand. Net
reduction in code is nice too. I've run it through the testing and it
passes. Unless people holler loudly, I'd like to include this in 4.17.

-- 
Jens Axboe
