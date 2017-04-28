Subject: Re: [PATCH 5/6] mtip32xx: convert internal command issue to block IO
 path
To: Christoph Hellwig <hch@lst.de>
References: <1493389911-19512-1-git-send-email-axboe@fb.com>
 <1493389911-19512-6-git-send-email-axboe@fb.com>
 <20170428144936.GA1519@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <a9cca6a9-0a61-9a51-2b9a-7fa7351a4234@fb.com>
Date: Fri, 28 Apr 2017 10:43:26 -0600
MIME-Version: 1.0
In-Reply-To: <20170428144936.GA1519@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/28/2017 08:49 AM, Christoph Hellwig wrote:
>> @@ -1088,6 +1088,13 @@ static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout)
>>  	return -EFAULT;
>>  }
>>  
>> +struct mtip_int_cmd {
>> +	int fis_len;
>> +	dma_addr_t buffer;
>> +	int buf_len;
>> +	u32 opts;
>> +};
> 
> I know passing the dma_addr is probably the easier conversion for now,
> but using blk_rq_map_kern would be the cleaner way going forward.
> 
>> +	/* insert request and run queue */
>> +	blk_execute_rq_nowait(rq->q, NULL, rq, true, NULL);
>> +
>> +	wait_for_completion(&wait);
> 
> Why not blk_execute_rq?

The internal requests don't go through the normal end_request part.
We can do that too of course, but I think we should keep it simple
to start to iron the issues out. Goes for using blk_rq_map_kern()
as well.

>> @@ -3770,6 +3803,9 @@ static int mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  
>>  	mtip_init_cmd_header(rq);
>>  
>> +	if (rq->rq_flags & RQF_RESERVED)
> 
> And in fact I don't think we'd even need the helper I suggested before,
> we can just check for REQ_OP_DRV_IN here.

True, we can just use blk_rq_is_passthrough here, I'll do that.

> But while we're at it - one oddity in mtip32xx is that it converts
> discards to an internal command from ->queue_rq, so we end up using
> two requests for it.  Just handling discards here would be a nice
> improvement.  It would also easily allow the driver to support ranged
> trims..
> 
> But I guess I'm simply to picky and we should just fix up the worst issues
> first..

All of these are good suggestions, but yes, I think we should do the
worst issues first, so we can kill the NO_SCHED flag.

-- 
Jens Axboe
