Return-Path: <axboe@kernel.dk>
Subject: Re: blk-mq: make sure that correct hctx->dispatch_from is set
From: Jens Axboe <axboe@kernel.dk>
To: =?UTF-8?B?6IOh5rW3?= <huhai@kylinos.cn>
Cc: "ming.lei" <ming.lei@redhat.com>,
 linux-block <linux-block@vger.kernel.org>
References: <tencent_47349987636D0D2B620828E0@qq.com>
 <6c265e65-d248-f6e0-1be4-e4223f1a4ed6@kernel.dk>
Message-ID: <07c44734-2aeb-79b2-6404-893b575debd5@kernel.dk>
Date: Fri, 18 May 2018 08:31:31 -0600
MIME-Version: 1.0
In-Reply-To: <6c265e65-d248-f6e0-1be4-e4223f1a4ed6@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/18/18 8:27 AM, Jens Axboe wrote:
> On 5/18/18 7:42 AM, 胡海 wrote:
>> Author: huhai <huhai@kylinos.cn>
>> Date:   Fri May 18 17:09:56 2018 +0800
>>
>>     blk-mq: make sure that correct hctx->dispatch_from is set
>>     
>>     When the number of hardware queues is changed, the drivers will call
>>     blk_mq_update_nr_hw_queues() to remap hardware queues, and then
>>     the ctx mapped on hctx will also change, but the current code forgets to
>>     make sure that correct hctx->dispatch_from is set, and hctx->dispatch_from
>>     may point to a ctx that does not belong to the current hctx.
> 
> Looks good, thanks. One minor note for future patches - for cases like this,
> when the patch fixes an issue with a specific commit, add a fixes line.
> For this one, it would be:
> 
> Fixes: b347689ffbca ("blk-mq-sched: improve dispatching from sw queue")

Two more notes... Your patches are still coming through as base64 encoded,
they should just be plain text.

Finally, I think the below is much clearer, since that's the loop where
we clear any existing hctx context.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6c6aef44badd..4cbfd784e837 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2358,6 +2358,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	queue_for_each_hw_ctx(q, hctx, i) {
 		cpumask_clear(hctx->cpumask);
 		hctx->nr_ctx = 0;
+		hctx->dispatch_from = NULL;
 	}
 
 	/*

-- 
Jens Axboe
