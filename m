Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 01/17] sunvdc: convert to blk-mq
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, David Miller <davem@davemloft.net>
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-2-axboe@kernel.dk> <20181015103728.GC31722@ming.t460p>
 <c4ca3697-e7b7-ccdd-5836-e6b6b0f12749@kernel.dk>
Message-ID: <2e9b9df4-944f-aa59-2c68-9cb7b1250cd7@kernel.dk>
Date: Mon, 15 Oct 2018 08:50:51 -0600
MIME-Version: 1.0
In-Reply-To: <c4ca3697-e7b7-ccdd-5836-e6b6b0f12749@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/15/18 8:19 AM, Jens Axboe wrote:
> On 10/15/18 4:38 AM, Ming Lei wrote:
>>> @@ -320,7 +320,7 @@ static void vdc_end_one(struct vdc_port *port, struct vio_dring_state *dr,
>>>  
>>>  	rqe->req = NULL;
>>>  
>>> -	__blk_end_request(req, (desc->status ? BLK_STS_IOERR : 0), desc->size);
>>> +	blk_mq_end_request(req, desc->status ? BLK_STS_IOERR : 0);
>>
>> blk_mq_end_request() may trigger BUG in case of partial completion,
>> however looks it is fine for __blk_end_request().
> 
> True, I'll change this to the blk_update_request() +
> __blk_mq_end_request() combo instead.

I take that back, it's correct as is. This isn't a partial completion,
it's completing the request. The BUG() inside blk_mq_end_request() would
indicate a bug in the internal code, we don't expect a not-done return
when we ask to complete the whole thing.

-- 
Jens Axboe
