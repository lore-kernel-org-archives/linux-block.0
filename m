Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH v5] blk-mq: Avoid that a completion can be ignored for
 BLK_EH_RESET_TIMER
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "hch@lst.de" <hch@lst.de>, "tj@kernel.org" <tj@kernel.org>,
 "israelr@mellanox.com" <israelr@mellanox.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "maxg@mellanox.com" <maxg@mellanox.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20180410210157.30477-1-bart.vanassche@wdc.com>
 <255b84ff-3fe5-1269-70a8-3ab5cc89c1ef@grimberg.me>
 <6684d4b3049397cbbabbee3008f96d80b48c0a17.camel@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <34fcf710-5e0a-9830-bc60-71c4086a0df5@grimberg.me>
Date: Wed, 11 Apr 2018 17:32:36 +0300
MIME-Version: 1.0
In-Reply-To: <6684d4b3049397cbbabbee3008f96d80b48c0a17.camel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>>>    static void __blk_mq_requeue_request(struct request *rq)
>>>    {
>>>    	struct request_queue *q = rq->q;
>>> +	enum mq_rq_state old_state = blk_mq_rq_state(rq);
>>>    
>>>    	blk_mq_put_driver_tag(rq);
>>>    
>>>    	trace_block_rq_requeue(q, rq);
>>>    	wbt_requeue(q->rq_wb, &rq->issue_stat);
>>>    
>>> -	if (blk_mq_rq_state(rq) != MQ_RQ_IDLE) {
>>> -		blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
>>> +	if (old_state != MQ_RQ_IDLE) {
>>> +		if (!blk_mq_change_rq_state(rq, old_state, MQ_RQ_IDLE))
>>> +			WARN_ON_ONCE(true);
>>>    		if (q->dma_drain_size && blk_rq_bytes(rq))
>>>    			rq->nr_phys_segments--;
>>>    	}
>>
>> Can you explain why was old_state kept as a local variable?
> 
> Hello Sagi,
> 
> Since blk_mq_requeue_request() must be called after a request has completed
> the timeout handler will ignore requests that are being requeued. Hence it
> is safe in this function to cache the request state in a local variable.

I understand why it is safe, I just didn't understand why it is needed.

>>> +static inline bool blk_mq_change_rq_state(struct request *rq,
>>> +					  enum mq_rq_state old_state,
>>> +					  enum mq_rq_state new_state)
>>>    {
>>> -	u64 old_val = READ_ONCE(rq->gstate);
>>> -	u64 new_val = (old_val & ~MQ_RQ_STATE_MASK) | state;
>>> -
>>> -	if (state == MQ_RQ_IN_FLIGHT) {
>>> -		WARN_ON_ONCE((old_val & MQ_RQ_STATE_MASK) != MQ_RQ_IDLE);
>>> -		new_val += MQ_RQ_GEN_INC;
>>> -	}
>>> +	unsigned long old_val = (READ_ONCE(rq->__deadline) & ~RQ_STATE_MASK) |
>>> +				old_state;
>>> +	unsigned long new_val = (old_val & ~RQ_STATE_MASK) | new_state;
>>>    
>>> -	/* avoid exposing interim values */
>>> -	WRITE_ONCE(rq->gstate, new_val);
>>> +	return cmpxchg(&rq->__deadline, old_val, new_val) == old_val;
>>>    }
>>
>> Can you explain why this takes the old_state of the request?
> 
> Can you clarify your question? The purpose of this function is to change
> the request state only into @new_state if it matches @old_state. I think
> that is also what the implementation of this function does.

I misread the documentation of this. never mind. thanks.
