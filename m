Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2623EC7EE26
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 22:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjEWWaZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 18:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjEWWaZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 18:30:25 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6420483
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 15:30:19 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ae408f4d1aso1951755ad.0
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 15:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684881019; x=1687473019;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYdGs/gg7iaa+JSQdOKeMJPmIba/6DN6SaV5Nu7BYzQ=;
        b=b86mggh61Rxg9MXVNfFBr8hvyfM7rD3RFHRt0e1fe4Wy8Q6RD9cRz7bWHIj2BiV+GU
         O/0zsjZIPVUz0PrbX1PFJEba1bOn92ccigXeZDik7gyi4OGiXT6tTAA9u2/hWua6muzJ
         xfra8GWRppyZ49EQhJX7+igRtl9T8umKz8D3dgyTLYgAxBBL4qxxsFX6DRFbiQVZ8JEz
         ze0PAwHk2skoTM+bFFbg+QTk93Fq2FY/Slcg2bCRl5XTIf7AURRZ3iUMjzwZYt9xvMGC
         NyhFW6ST3CUcQtMHdC/2MQrHrkJuq8S49F2V0fDnDkdD29Q3ePqqhkStzhKqzeELRDLL
         0/9A==
X-Gm-Message-State: AC+VfDx2MwRYh/JBNFVW2jPVMqgSOZV6Pyz2OcZvP6bEFz8o7zIUTkgn
        Wjz8ZOnfOd3oJrFKCvPv+S8=
X-Google-Smtp-Source: ACHHUZ5n91oRzP3izj02fSaJpccNK0AsuURvkP/Q3hXSHUB+VElxbhtCDZlpIclx8p8SMnnYPXSbXw==
X-Received: by 2002:a17:902:ce81:b0:1ad:ddf0:131f with SMTP id f1-20020a170902ce8100b001adddf0131fmr19141809plg.51.1684881018623;
        Tue, 23 May 2023 15:30:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:24d2:69cd:ef9a:8f83? ([2620:15c:211:201:24d2:69cd:ef9a:8f83])
        by smtp.gmail.com with ESMTPSA id 9-20020a170902c14900b001adbb8991b3sm7300493plj.89.2023.05.23.15.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 15:30:18 -0700 (PDT)
Message-ID: <639fa0ac-e7b9-2ba7-3d68-3fe1a501e779@acm.org>
Date:   Tue, 23 May 2023 15:30:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v3 2/7] block: Send requeued requests to the I/O scheduler
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-3-bvanassche@acm.org> <20230523071835.GB8758@lst.de>
Content-Language: en-US
In-Reply-To: <20230523071835.GB8758@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/23 00:18, Christoph Hellwig wrote:
> On Mon, May 22, 2023 at 11:38:37AM -0700, Bart Van Assche wrote:
>> Send requeued requests to the I/O scheduler such that the I/O scheduler
>> can control the order in which requests are dispatched.
>>
>> This patch reworks commit aef1897cd36d ("blk-mq: insert rq with DONTPREP
>> to hctx dispatch list when requeue").
> 
> But you need to explain why it is safe.  I think it is because you add
> DONTPREP to RQF_NOMERGE_FLAGS, but that really belongs into the commit
> log.

Hi Christoph,

I will add the above explanation in the commit message.

> 
>> +	list_for_each_entry_safe(rq, next, &requeue_list, queuelist) {
>> +		if (!(rq->rq_flags & RQF_DONTPREP)) {
>>   			list_del_init(&rq->queuelist);
>>   			blk_mq_insert_request(rq, BLK_MQ_INSERT_AT_HEAD);
>>   		}
>>   	}
>>   
>> +	while (!list_empty(&requeue_list)) {
>> +		rq = list_entry(requeue_list.next, struct request, queuelist);
>> +		list_del_init(&rq->queuelist);
>> +		blk_mq_insert_request(rq, 0);
> 
> So now both started and unstarted requests go through
> blk_mq_insert_request, and thus potentially the I/O scheduler, but
> RQF_DONTPREP request that are by definition further along in processing
> are inserted at the tail, while !RQF_DONTPREP ones get inserted at head.
> 
> This feels wrong, and we probably need to sort out why and how we are
> doing head insertation on a requeue first.

The use cases for requeuing requests are as follows:
* Resubmitting a partially completed request (ATA, SCSI, loop, ...).
* Handling connection recovery (nbd, ublk, ...).
* Simulating the "device busy" condition (null_blk).
* Handling the queue full condition (virtio-blk).
* Handling path errors by dm-mpath (DM_ENDIO_REQUEUE).
* Handling retryable I/O errors (mmc, NVMe).
* Handling unit attentions (SCSI).
* Unplugging a CPU.

Do you perhaps want me to select BLK_MQ_INSERT_AT_HEAD for all requeued requests?

>> +		if (q->elevator) {
>> +			if (q->elevator->type->ops.requeue_request)
>> +				list_for_each_entry(rq, &for_sched, queuelist)
>> +					q->elevator->type->ops.
>> +						requeue_request(rq);
>> +			q->elevator->type->ops.insert_requests(hctx, &for_sched,
>> +							BLK_MQ_INSERT_AT_HEAD);
>> +		}
>> +
> 
> None of this is explained in the commit log, please elaborate on the
> rationale for it.  Also:
> 
>   - this code block really belongs into a helper
>   - calling ->requeue_request in a loop before calling ->insert_requests
>     feels wrong  A BLK_MQ_INSERT_REQUEUE flag feels like the better
>     interface here.

Pushing a request back to hctx->dispatch is a requeuing mechanism. I want
to send requeued requests to the I/O scheduler.

Regarding the BLK_MQ_INSERT_REQUEUE suggestion, how about adding the patch
below near the start of this patch series?

Thanks,

Bart.


block: Remove elevator_type.requeue_request()

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 117aec1791c0..319d3c5a0f85 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6232,6 +6232,7 @@ static inline void bfq_update_insert_stats(struct request_queue *q,
  #endif /* CONFIG_BFQ_CGROUP_DEBUG */

  static struct bfq_queue *bfq_init_rq(struct request *rq);
+static void bfq_finish_requeue_request(struct request *rq);

  static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
  			       blk_insert_t flags)
@@ -6243,6 +6244,11 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
  	blk_opf_t cmd_flags;
  	LIST_HEAD(free);

+	if (rq->rq_flags & RQF_REQUEUED) {
+		rq->rq_flags &= ~RQF_REQUEUED;
+		bfq_finish_requeue_request(rq);
+	}
+
  #ifdef CONFIG_BFQ_GROUP_IOSCHED
  	if (!cgroup_subsys_on_dfl(io_cgrp_subsys) && rq->bio)
  		bfqg_stats_update_legacy_io(q, rq);
@@ -7596,7 +7602,6 @@ static struct elevator_type iosched_bfq_mq = {
  	.ops = {
  		.limit_depth		= bfq_limit_depth,
  		.prepare_request	= bfq_prepare_request,
-		.requeue_request        = bfq_finish_requeue_request,
  		.finish_request		= bfq_finish_request,
  		.exit_icq		= bfq_exit_icq,
  		.insert_requests	= bfq_insert_requests,
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1326526bb733..8d4b835539b1 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -58,13 +58,8 @@ static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)

  static inline void blk_mq_sched_requeue_request(struct request *rq)
  {
-	if (rq->rq_flags & RQF_USE_SCHED) {
-		struct request_queue *q = rq->q;
-		struct elevator_queue *e = q->elevator;
-
-		if (e->type->ops.requeue_request)
-			e->type->ops.requeue_request(rq);
-	}
+	if (rq->rq_flags & RQF_USE_SCHED)
+		rq->rq_flags |= RQF_REQUEUED;
  }

  static inline bool blk_mq_sched_has_work(struct blk_mq_hw_ctx *hctx)
diff --git a/block/elevator.h b/block/elevator.h
index 7ca3d7b6ed82..c1f459eebc9f 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -43,7 +43,6 @@ struct elevator_mq_ops {
  	struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
  	bool (*has_work)(struct blk_mq_hw_ctx *);
  	void (*completed_request)(struct request *, u64);
-	void (*requeue_request)(struct request *);
  	struct request *(*former_request)(struct request_queue *, struct request *);
  	struct request *(*next_request)(struct request_queue *, struct request *);
  	void (*init_icq)(struct io_cq *);
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index f495be433276..b1f2e172fe61 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -608,6 +608,10 @@ static void kyber_insert_requests(struct blk_mq_hw_ctx *hctx,

  		spin_lock(&kcq->lock);
  		trace_block_rq_insert(rq);
+		if (rq->rq_flags & RQF_REQUEUED) {
+			rq->rq_flags &= ~RQF_REQUEUED;
+			kyber_finish_request(rq);
+		}
  		if (flags & BLK_MQ_INSERT_AT_HEAD)
  			list_move(&rq->queuelist, head);
  		else
@@ -1022,7 +1026,6 @@ static struct elevator_type kyber_sched = {
  		.prepare_request = kyber_prepare_request,
  		.insert_requests = kyber_insert_requests,
  		.finish_request = kyber_finish_request,
-		.requeue_request = kyber_finish_request,
  		.completed_request = kyber_completed_request,
  		.dispatch_request = kyber_dispatch_request,
  		.has_work = kyber_has_work,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d778cb6b2112..861ca3bb0bce 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -59,6 +59,9 @@ typedef __u32 __bitwise req_flags_t;
  #define RQF_ZONE_WRITE_LOCKED	((__force req_flags_t)(1 << 19))
  /* ->timeout has been called, don't expire again */
  #define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
+/* The request is about to be requeued. */
+#define RQF_REQUEUED		((__force req_flags_t)(1 << 22))
+/* A reserved tag has been assigned to the request. */
  #define RQF_RESV		((__force req_flags_t)(1 << 23))

  /* flags that prevent us from merging requests: */
