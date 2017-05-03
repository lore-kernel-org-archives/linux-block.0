Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] blk-mq: support to use hw tag for scheduling
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <839682da-f375-8eab-d6f5-fcf1457150f1@fb.com>
 <20170503040303.GA20187@ming.t460p>
 <f52b4478-0d18-a248-3fbf-721216a79f92@fb.com>
 <370fbeb6-d832-968a-2759-47f16b866551@kernel.dk>
 <20170503150351.GA7927@ming.t460p>
 <31bb973e-d9cf-9454-58fd-4893701088c5@kernel.dk>
 <20170503153808.GB7927@ming.t460p> <20170503165201.GB9706@ming.t460p>
 <20170503170315.GD9706@ming.t460p>
 <24ff7ca6-73d6-f8a5-b7d9-e92d0bfdb4b0@kernel.dk>
 <1493831722.3901.19.camel@sandisk.com>
 <d537355e-3581-fc86-62ce-0757a84d9c1a@kernel.dk>
 <1493832921.3901.22.camel@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "osandov@fb.com" <osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <63d4a989-25ac-5ab7-ec5d-e92ebb7976d5@kernel.dk>
Date: Wed, 3 May 2017 11:40:37 -0600
MIME-Version: 1.0
In-Reply-To: <1493832921.3901.22.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/03/2017 11:35 AM, Bart Van Assche wrote:
> On Wed, 2017-05-03 at 11:24 -0600, Jens Axboe wrote:
>> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
>> index 3a779a4f5653..33b5d1382c45 100644
>> --- a/drivers/block/mtip32xx/mtip32xx.c
>> +++ b/drivers/block/mtip32xx/mtip32xx.c
>> [ ... ]
>> @@ -4009,7 +4009,7 @@ static int mtip_block_remove(struct driver_data *dd)
>>  						dd->disk->disk_name);
>>  
>>  	blk_freeze_queue_start(dd->queue);
>> -	blk_mq_stop_hw_queues(dd->queue);
>> +	blk_mq_stop_hw_queues(dd->queue, true);
>>  	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
>>  
>>  	/*
> 
> Hello Jens,
> 
> How about replacing the blk_freeze_queue_start() and blk_mq_stop_hw_queues()
> calls by a single call to blk_set_queue_dying()? I think that would be more
> appropriate in the context of mtip_block_remove().

Looking at all of the drivers, it's somewhat of a mess and a lot of it looks
like it's not even needed. I'm going to propose that we do the below first,
since it fixes the immediate regression and makes us no worse than 4.11
already was. Then we can do a round two of improving the situation, but
I'd prefer not to turn the immediate fix into a huge round of fixes and
driver touching.


>From 66e22c6402af135cdc9913d2e298107629b02cdb Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@fb.com>
Date: Wed, 3 May 2017 11:08:14 -0600
Subject: [PATCH] blk-mq: don't use sync workqueue flushing from drivers

A previous commit introduced the sync flush, which we need from
internal callers like blk_mq_quiesce_queue(). However, we also
call the stop helpers from drivers, particularly from ->queue_rq()
when we have to stop processing for a bit. We can't block from
those locations, and we don't have to guarantee that we're
fully flushed.

Fixes: 9f993737906b ("blk-mq: unify hctx delayed_run_work and run_work")
Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e339247a2570..dec70ca0aafd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -41,6 +41,7 @@ static LIST_HEAD(all_q_list);
 
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
+static void __blk_mq_stop_hw_queues(struct request_queue *q, bool sync);
 
 static int blk_mq_poll_stats_bkt(const struct request *rq)
 {
@@ -166,7 +167,7 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	unsigned int i;
 	bool rcu = false;
 
-	blk_mq_stop_hw_queues(q);
+	__blk_mq_stop_hw_queues(q, true);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->flags & BLK_MQ_F_BLOCKING)
@@ -1218,20 +1219,34 @@ bool blk_mq_queue_stopped(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_mq_queue_stopped);
 
-void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
+static void __blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx, bool sync)
 {
-	cancel_delayed_work_sync(&hctx->run_work);
+	if (sync)
+		cancel_delayed_work_sync(&hctx->run_work);
+	else
+		cancel_delayed_work(&hctx->run_work);
+
 	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
 }
+
+void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
+{
+	__blk_mq_stop_hw_queue(hctx, false);
+}
 EXPORT_SYMBOL(blk_mq_stop_hw_queue);
 
-void blk_mq_stop_hw_queues(struct request_queue *q)
+void __blk_mq_stop_hw_queues(struct request_queue *q, bool sync)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
 	queue_for_each_hw_ctx(q, hctx, i)
-		blk_mq_stop_hw_queue(hctx);
+		__blk_mq_stop_hw_queue(hctx, sync);
+}
+
+void blk_mq_stop_hw_queues(struct request_queue *q)
+{
+	__blk_mq_stop_hw_queues(q, false);
 }
 EXPORT_SYMBOL(blk_mq_stop_hw_queues);
 
-- 
2.7.4

-- 
Jens Axboe
