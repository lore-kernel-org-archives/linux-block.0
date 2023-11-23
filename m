Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="olny0DvX"
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CA5D59
	for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 12:37:48 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cf88973da5so2495435ad.0
        for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 12:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700771868; x=1701376668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=saR1UBTACQwCAzSfeCdANJokVZaq/XQyfn/U5znceb4=;
        b=olny0DvXR0VqFqlSYo3AfWBzoK/YIHOtO//q4c9pMcrx5hF+zuZA3yIQskDfEVi4Av
         GYXVpB1zX8HDQIiFAV6qp7hdKzlTbHBttSEIjgRYwXrlELV+/B0nUILF+8MX9y4ivEdg
         S7D3Vg5zibVgitl8qbmsQVPIx9ZVirl1p+bQQ9KNFa8TK3JsvlOKdEgpHqK2LjTtlHkG
         rHYrpciJsBnkKFCfYaCypL4jIhIlhuEqR+hL4TF9JAD6lSMpXdkQPgnSxAFX3U3q+iKe
         05bjhU5hN1GllUvKoqZJe2zGDEcB7hrcsq+pRdQzI1rVpMtpRsd7Zf96ZK2OWAAexXXi
         n2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700771868; x=1701376668;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=saR1UBTACQwCAzSfeCdANJokVZaq/XQyfn/U5znceb4=;
        b=Kbouc4EJ5xBashfwl3GpOrauijLoUfrjoU84xsnqKC2ldBE7x9v6PlmAFUC+o5pWwg
         dLtRmD8GKwrz0nh2bSDRlAghCkPmttcYv/PLGrfJEaM+t7Za/0X1BA7vKuTC8ww3AX+F
         c01N3xoNkYcP05EDcPl+cOcwYu3GrbbIMTq+JBmz6SmHcWDVEMAv8NlrPVUuboZNwM2o
         9EbLwhfk1K193jrM6LCD5jqJErcoB7PIFonkNe4LOS89fhW3AB7fAHmZOUcXjmvS00SU
         9rTtRSCdEqq3sPrhtyj2n/Wq4FWbxuIYcFFtAWAqCRaOUzg5EJyQfIb4DjI+pZ01HtQ2
         Nizw==
X-Gm-Message-State: AOJu0YwnUHA/A446RBRdQIXV3X9kzQzJw1U3AXKOxqwocgGtsSvhzme3
	tjtkjYvTy4hx2as7j/NjJ3da4PlZlrfUm0xdDCvVdg==
X-Google-Smtp-Source: AGHT+IE7FEr8FTcOE3jsjLr/7kAnzOCPeWMJxXuDaQyvin1MTu+JPMt7znhPrY5C4pI6LbVdQ3bkTw==
X-Received: by 2002:a17:902:ced0:b0:1cf:658f:d2d with SMTP id d16-20020a170902ced000b001cf658f0d2dmr572932plg.5.1700771868201;
        Thu, 23 Nov 2023 12:37:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090274c800b001c9bc811d4dsm1750354plt.295.2023.11.23.12.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 12:37:47 -0800 (PST)
Message-ID: <fba18f05-ae51-4d46-932a-5f4f9d2aab07@kernel.dk>
Date: Thu, 23 Nov 2023 13:37:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: skip QUEUE_FLAG_STATS and rq-qos for passthrough
 io
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 "kundan.kumar" <kundan.kumar@samsung.com>
Cc: kbusch@kernel.org, linux-block@vger.kernel.org
References: <CGME20231123103102epcas5p2aee268735dc9e0c357e6d3b98d16fe21@epcas5p2.samsung.com>
 <20231123102431.6804-1-kundan.kumar@samsung.com>
 <20231123153007.GA3853@lst.de>
 <85be66ad-0203-6f81-8be0-1190842c9273@samsung.com>
 <37d9ca26-2ec2-4c51-8d33-a736f54ef93f@kernel.dk>
In-Reply-To: <37d9ca26-2ec2-4c51-8d33-a736f54ef93f@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/23 1:19 PM, Jens Axboe wrote:
> On 11/23/23 11:12 AM, Kanchan Joshi wrote:
>> On 11/23/2023 9:00 PM, Christoph Hellwig wrote:
>>> The rest looks good, but that stats overhead seems pretty horrible..
>>
>> On my setup
>> Before[1]: 7.06M
>> After[2]: 8.29M
>>
>> [1]
>> # taskset -c 2,3 t/io_uring -b512 -d256 -c32 -s32 -p1 -F1 -B1 -O0 -n2 
>> -u1 -r4 /dev/ng0n1 /dev/ng1n1
>> submitter=0, tid=2076, file=/dev/ng0n1, node=-1
>> submitter=1, tid=2077, file=/dev/ng1n1, node=-1
>> polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=256
>> Engine=io_uring, sq_ring=256, cq_ring=256
>> polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=256
>> Engine=io_uring, sq_ring=256, cq_ring=256
>> IOPS=6.95M, BW=3.39GiB/s, IOS/call=32/31
>> IOPS=7.06M, BW=3.45GiB/s, IOS/call=32/32
>> IOPS=7.06M, BW=3.45GiB/s, IOS/call=32/31
>> Exiting on timeout
>> Maximum IOPS=7.06M
>>
>> [2]
>>   # taskset -c 2,3 t/io_uring -b512 -d256 -c32 -s32 -p1 -F1 -B1 -O0 -n2 
>> -u1 -r4 /dev/ng0n1 /dev/ng1n1
>> submitter=0, tid=2123, file=/dev/ng0n1, node=-1
>> submitter=1, tid=2124, file=/dev/ng1n1, node=-1
>> polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=256
>> Engine=io_uring, sq_ring=256, cq_ring=256
>> IOPS=8.27M, BW=4.04GiB/s, IOS/call=32/31
>> IOPS=8.29M, BW=4.05GiB/s, IOS/call=32/31
>> IOPS=8.29M, BW=4.05GiB/s, IOS/call=31/31
>> Exiting on timeout
>> Maximum IOPS=8.29M
> 
> It's all really down to how expensive getting the current time is on
> your box, some will be better and some worse
> 
> One idea that has been bounced around in the past is to have a
> blk_ktime_get_ns() and have it be something ala:
> 
> u64 blk_ktime_get_ns(void)
> {
> 	struct blk_plug *plug = current->plug;
> 
> 	if (!plug)
> 		return ktime_get_ns();
> 
> 	if (!plug->ktime_valid)
> 		plug->ktime = ktime_get_ns();
> 
> 	return plug->ktime;
> }
> 
> in freestyle form, with the idea being that we don't care granularity to
> the extent that we'd need a new stamp every time.
> 
> If the task is scheduled out, the plug is flushed anyway, which should
> invalidate the stamp. For preemption this isn't true iirc, so we'd need
> some kind of blk_flush_plug_ts() or something for that case to
> invalidate it.
> 
> Hopefully this could then also get away from passing in a cached value
> that we do in various spots, exactly because all of this time stamping
> is expensive. It's also a bit of a game of whack-a-mole, as users get
> added and distro kernels tend to turn on basically everything anyway.

Did a quick'n dirty (see below), which recoups half of the lost
performance for me. And my kernel deliberately doesn't enable all of the
gunk in block/ that slows everything down, I suspect it'll be a bigger
win for you percentage wise:

IOPS=121.42M, BW=59.29GiB/s, IOS/call=31/31
IOPS=121.47M, BW=59.31GiB/s, IOS/call=32/32
IOPS=121.44M, BW=59.30GiB/s, IOS/call=31/31
IOPS=121.47M, BW=59.31GiB/s, IOS/call=31/31
IOPS=121.45M, BW=59.30GiB/s, IOS/call=32/32
IOPS=119.95M, BW=58.57GiB/s, IOS/call=31/32
IOPS=115.30M, BW=56.30GiB/s, IOS/call=32/31
IOPS=115.38M, BW=56.34GiB/s, IOS/call=32/32
IOPS=115.35M, BW=56.32GiB/s, IOS/call=32/32


diff --git a/block/blk-core.c b/block/blk-core.c
index fdf25b8d6e78..6e74af442b94 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1055,6 +1055,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
 	plug->rq_count = 0;
 	plug->multiple_queues = false;
 	plug->has_elevator = false;
+	plug->cur_ktime = 0;
 	INIT_LIST_HEAD(&plug->cb_list);
 
 	/*
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 3f4d41952ef2..e4e9f7eed346 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -143,7 +143,7 @@ static void blk_account_io_flush(struct request *rq)
 	part_stat_lock();
 	part_stat_inc(part, ios[STAT_FLUSH]);
 	part_stat_add(part, nsecs[STAT_FLUSH],
-		      ktime_get_ns() - rq->start_time_ns);
+		      blk_ktime_get_ns() - rq->start_time_ns);
 	part_stat_unlock();
 }
 
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 089fcb9cfce3..d06cea625462 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -829,7 +829,7 @@ static int ioc_autop_idx(struct ioc *ioc, struct gendisk *disk)
 
 	/* step up/down based on the vrate */
 	vrate_pct = div64_u64(ioc->vtime_base_rate * 100, VTIME_PER_USEC);
-	now_ns = ktime_get_ns();
+	now_ns = blk_ktime_get_ns();
 
 	if (p->too_fast_vrate_pct && p->too_fast_vrate_pct <= vrate_pct) {
 		if (!ioc->autop_too_fast_at)
@@ -1044,7 +1044,7 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
 	unsigned seq;
 	u64 vrate;
 
-	now->now_ns = ktime_get();
+	now->now_ns = blk_ktime_get();
 	now->now = ktime_to_us(now->now_ns);
 	vrate = atomic64_read(&ioc->vtime_rate);
 
@@ -2810,7 +2810,7 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
 		return;
 	}
 
-	on_q_ns = ktime_get_ns() - rq->alloc_time_ns;
+	on_q_ns = blk_ktime_get_ns() - rq->alloc_time_ns;
 	rq_wait_ns = rq->start_time_ns - rq->alloc_time_ns;
 	size_nsec = div64_u64(calc_size_vtime_cost(rq, ioc), VTIME_PER_NSEC);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 900c1be1fee1..9c96dee9e584 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -323,7 +323,7 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	RB_CLEAR_NODE(&rq->rb_node);
 	rq->tag = BLK_MQ_NO_TAG;
 	rq->internal_tag = BLK_MQ_NO_TAG;
-	rq->start_time_ns = ktime_get_ns();
+	rq->start_time_ns = blk_ktime_get_ns();
 	rq->part = NULL;
 	blk_crypto_rq_set_defaults(rq);
 }
@@ -333,7 +333,7 @@ EXPORT_SYMBOL(blk_rq_init);
 static inline void blk_mq_rq_time_init(struct request *rq, u64 alloc_time_ns)
 {
 	if (blk_mq_need_time_stamp(rq))
-		rq->start_time_ns = ktime_get_ns();
+		rq->start_time_ns = blk_ktime_get_ns();
 	else
 		rq->start_time_ns = 0;
 
@@ -444,7 +444,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 
 	/* alloc_time includes depth and tag waits */
 	if (blk_queue_rq_alloc_time(q))
-		alloc_time_ns = ktime_get_ns();
+		alloc_time_ns = blk_ktime_get_ns();
 
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
@@ -629,7 +629,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 
 	/* alloc_time includes depth and tag waits */
 	if (blk_queue_rq_alloc_time(q))
-		alloc_time_ns = ktime_get_ns();
+		alloc_time_ns = blk_ktime_get_ns();
 
 	/*
 	 * If the tag allocator sleeps we could get an allocation for a
@@ -1037,7 +1037,7 @@ static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
 	if (blk_mq_need_time_stamp(rq))
-		__blk_mq_end_request_acct(rq, ktime_get_ns());
+		__blk_mq_end_request_acct(rq, blk_ktime_get_ns());
 
 	blk_mq_finish_request(rq);
 
@@ -1080,7 +1080,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 	u64 now = 0;
 
 	if (iob->need_ts)
-		now = ktime_get_ns();
+		now = blk_ktime_get_ns();
 
 	while ((rq = rq_list_pop(&iob->req_list)) != NULL) {
 		prefetch(rq->bio);
@@ -1249,7 +1249,7 @@ void blk_mq_start_request(struct request *rq)
 	trace_block_rq_issue(rq);
 
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
-		rq->io_start_time_ns = ktime_get_ns();
+		rq->io_start_time_ns = blk_ktime_get_ns();
 		rq->stats_sectors = blk_rq_sectors(rq);
 		rq->rq_flags |= RQF_STATS;
 		rq_qos_issue(q, rq);
@@ -3066,7 +3066,7 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 	blk_mq_run_dispatch_ops(q,
 			ret = blk_mq_request_issue_directly(rq, true));
 	if (ret)
-		blk_account_io_done(rq, ktime_get_ns());
+		blk_account_io_done(rq, blk_ktime_get_ns());
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 13e4377a8b28..5919919ba1c3 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1813,7 +1813,7 @@ static bool throtl_tg_is_idle(struct throtl_grp *tg)
 	time = min_t(unsigned long, MAX_IDLE_TIME, 4 * tg->idletime_threshold);
 	ret = tg->latency_target == DFL_LATENCY_TARGET ||
 	      tg->idletime_threshold == DFL_IDLE_THRESHOLD ||
-	      (ktime_get_ns() >> 10) - tg->last_finish_time > time ||
+	      (blk_ktime_get_ns() >> 10) - tg->last_finish_time > time ||
 	      tg->avg_idletime > tg->idletime_threshold ||
 	      (tg->latency_target && tg->bio_cnt &&
 		tg->bad_bio_cnt * 5 < tg->bio_cnt);
@@ -2058,7 +2058,7 @@ static void blk_throtl_update_idletime(struct throtl_grp *tg)
 	if (last_finish_time == 0)
 		return;
 
-	now = ktime_get_ns() >> 10;
+	now = blk_ktime_get_ns() >> 10;
 	if (now <= last_finish_time ||
 	    last_finish_time == tg->checked_last_finish_time)
 		return;
@@ -2325,7 +2325,7 @@ void blk_throtl_bio_endio(struct bio *bio)
 	if (!tg->td->limit_valid[LIMIT_LOW])
 		return;
 
-	finish_time_ns = ktime_get_ns();
+	finish_time_ns = blk_ktime_get_ns();
 	tg->last_finish_time = finish_time_ns >> 10;
 
 	start_time = bio_issue_time(&bio->bi_issue) >> 10;
diff --git a/block/blk.h b/block/blk.h
index 08a358bc0919..4f081a00e644 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -518,4 +518,17 @@ static inline int req_ref_read(struct request *req)
 	return atomic_read(&req->ref);
 }
 
+static inline u64 blk_ktime_get_ns(void)
+{
+	struct blk_plug *plug = current->plug;
+
+	if (!plug)
+		return ktime_get_ns();
+	if (!(plug->cur_ktime & 1ULL)) {
+		plug->cur_ktime = ktime_get_ns();
+		plug->cur_ktime |= 1ULL;
+	}
+	return plug->cur_ktime;
+}
+
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 51fa7ffdee83..081830279f70 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -972,6 +972,9 @@ struct blk_plug {
 	bool multiple_queues;
 	bool has_elevator;
 
+	/* bit0 set if valid */
+	u64 cur_ktime;
+
 	struct list_head cb_list; /* md requires an unplug callback */
 };
 

-- 
Jens Axboe

