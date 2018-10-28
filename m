Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 13/28] bsg: convert to use blk-mq
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
 Benjamin Block <bblock@linux.vnet.ibm.com>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-14-axboe@kernel.dk>
 <20181028160712.GC1559@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0f806e82-4a04-3320-d214-47cbe94e45ce@kernel.dk>
Date: Sun, 28 Oct 2018 17:25:16 -0600
MIME-Version: 1.0
In-Reply-To: <20181028160712.GC1559@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/28/18 10:07 AM, Christoph Hellwig wrote:
>> +static enum blk_eh_timer_return bsg_timeout(struct request *rq, bool reserved)
>> +{
>> +	enum blk_eh_timer_return ret = BLK_EH_DONE;
>> +	struct request_queue *q = rq->q;
>> +
>> +	if (q->rq_timed_out_fn)
>> +		ret = q->rq_timed_out_fn(rq);
>> +
>> +	return ret;
> 
> This is pretty awkward.  I guess it is ok as an intermediate step,
> but I really don't want to keep rq_timed_out_fn to just for bsg.

Me neither.

> I think we should do something like this ontop of your series to move
> all the bsg-lib bits outside struct request_queue:

Looks good to me, I'll queue this up after this patch to clean things
up nicely.

I added this incremental on top, you missed some error handling and
cleanup bits. Care to send as a proper patch?


diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 21dccaf8399e..f01f11048d5e 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -299,12 +299,13 @@ static void bsg_exit_rq(struct blk_mq_tag_set *set, struct request *req,
 
 void bsg_remove_queue(struct request_queue *q)
 {
-	struct blk_mq_tag_set *set = q->tag_set;
+	struct bsg_set *bset =
+		container_of(q->tag_set, struct bsg_set, tag_set);
 
 	bsg_unregister_queue(q);
 	blk_cleanup_queue(q);
-	blk_mq_free_tag_set(set);
-	kfree(set);
+	blk_mq_free_tag_set(&bset->tag_set);
+	kfree(bset);
 }
 EXPORT_SYMBOL_GPL(bsg_remove_queue);
 
@@ -382,7 +383,7 @@ struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 out_queue:
 	blk_mq_free_tag_set(set);
 out_tag_set:
-	kfree(set);
+	kfree(bset);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(bsg_setup_queue);

-- 
Jens Axboe
