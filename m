Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4 4/6] blk-mq: Introduce blk_mq_delay_run_hw_queue()
To: Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>
References: <20170407181654.27836-1-bart.vanassche@sandisk.com>
 <20170407181654.27836-5-bart.vanassche@sandisk.com>
 <20170410071219.GD5559@lst.de>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Long Li <longli@microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <601a809a-b552-3084-b41d-a89767ba5c84@kernel.dk>
Date: Mon, 10 Apr 2017 09:02:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170410071219.GD5559@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/10/2017 01:12 AM, Christoph Hellwig wrote:
>> +	if (msecs == 0)
>> +		kblockd_schedule_work_on(blk_mq_hctx_next_cpu(hctx),
>> +					 &hctx->run_work);
>> +	else
>> +		kblockd_schedule_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
>> +						 &hctx->delayed_run_work,
>> +						 msecs_to_jiffies(msecs));
>> +}
> 
> I'd rather make run_work a delayed_work (again) and use
> kblockd_schedule_delayed_work_on with a timeout of zero for the immediate
> run case instead of having two competing work structs.

Yeah that's a good point, it'd have to be an incremental patch at this
point though. Also note that blk_mq_stop_hw_queue() isn't currently
canceling the new ->delayed_run_work, that looks like a bug.

And looking at it, right now we have 3 (three!) work items in the
hardware queue. The two delayed items differ in that one of them only
runs the queue it was previously stopped, that's it. The non-delayed one
is identical to the non stopped checking delayed variant.

I'll send out a patch.

-- 
Jens Axboe
