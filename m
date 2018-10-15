Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 01/17] sunvdc: convert to blk-mq
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, David Miller <davem@davemloft.net>
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-2-axboe@kernel.dk> <20181015103728.GC31722@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c4ca3697-e7b7-ccdd-5836-e6b6b0f12749@kernel.dk>
Date: Mon, 15 Oct 2018 08:19:02 -0600
MIME-Version: 1.0
In-Reply-To: <20181015103728.GC31722@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/15/18 4:38 AM, Ming Lei wrote:
>> @@ -320,7 +320,7 @@ static void vdc_end_one(struct vdc_port *port, struct vio_dring_state *dr,
>>  
>>  	rqe->req = NULL;
>>  
>> -	__blk_end_request(req, (desc->status ? BLK_STS_IOERR : 0), desc->size);
>> +	blk_mq_end_request(req, desc->status ? BLK_STS_IOERR : 0);
> 
> blk_mq_end_request() may trigger BUG in case of partial completion,
> however looks it is fine for __blk_end_request().

True, I'll change this to the blk_update_request() +
__blk_mq_end_request() combo instead.

> Most of conversions have the above pattern, maybe it is easier to
> introduce the following block API:
> 
> 	struct reuqest_queue *blk_mq_alloc_and_init_sq(set, ops, queue_depth)

Yeah I did consider that, I'll make that addition.

-- 
Jens Axboe
