Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH v5] blk-mq: Avoid that a completion can be ignored for
 BLK_EH_RESET_TIMER
To: Ming Lei <ming.lei@redhat.com>, Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
 Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 stable@vger.kernel.org
References: <20180410210157.30477-1-bart.vanassche@wdc.com>
 <20180411021104.GC4494@ming.t460p>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <41f15d7f-a119-1b00-52cf-e1a34aee9ba8@grimberg.me>
Date: Wed, 11 Apr 2018 16:10:09 +0300
MIME-Version: 1.0
In-Reply-To: <20180411021104.GC4494@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>> The blk-mq timeout handling code ignores completions that occur after
>> blk_mq_check_expired() has been called and before blk_mq_rq_timed_out()
>> has reset rq->aborted_gstate. If a block driver timeout handler always
>> returns BLK_EH_RESET_TIMER then the result will be that the request
>> never terminates.
> 
> Under this situation:
> 
> IMO, if this request has been handled by driver's irq handler, and if
> driver's .timeout still returns BLK_EH_RESET_TIMER, it is driver's bug,
> and the correct return value should be BLK_EH_HANDLED.

Is it possible to guarantee this efficiently if the irq handler
can run concurrently with the timeout handler?
