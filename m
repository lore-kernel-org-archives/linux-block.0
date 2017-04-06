Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 2/5] blk-mq: Restart a single queue if tag sets are
 shared
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <20170406181050.12137-1-bart.vanassche@sandisk.com>
 <20170406181050.12137-3-bart.vanassche@sandisk.com>
 <4f5ecfba-f2c9-8b54-f879-86b84f407599@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e5c27abd-d3ad-ac21-2a37-d20999d459f5@kernel.dk>
Date: Thu, 6 Apr 2017 13:21:28 -0600
MIME-Version: 1.0
In-Reply-To: <4f5ecfba-f2c9-8b54-f879-86b84f407599@kernel.dk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/06/2017 01:12 PM, Jens Axboe wrote:
> On 04/06/2017 12:10 PM, Bart Van Assche wrote:
>> +		for (i = 0; i < queue->nr_hw_queues; i++) {
>> +			j = (i + hctx->queue_num + 1) % queue->nr_hw_queues;
>> +			h = queue->queue_hw_ctx[j];
>> +			if (h->tags == tags && blk_mq_sched_restart_hctx(h))
>> +				break;
> 
> I'm pretty sure that doing:
> 
> 	j = i + hctx->queue_num + 1;;

And 'i' too many there of course:

 	j = hctx->queue_num + 1;;

-- 
Jens Axboe
