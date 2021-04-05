Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4B4C433B4
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 21:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DE0613BD
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 21:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbhDEVeY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 17:34:24 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:35837 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhDEVeY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 17:34:24 -0400
Received: by mail-pj1-f42.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so8518047pjb.0
        for <linux-block@vger.kernel.org>; Mon, 05 Apr 2021 14:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l77MOphPERopKKyYXHUqgJk+Mhqy6i9t4Kd7RmBOWKw=;
        b=B1+DqWoFmhdhznBmEKQqcv4p/1rWs7O/FyN2sjXCvzDBdkRIWo4QoHG8kN18VpBTRe
         aglgdHpXxmZymSpO9vCo4ymT6QLNnrYg+EkW6HlGLJpMrkAEfIW57TNX1qRuzEISx4DV
         ZvQLkOAodFPdpyUmLGNk3gqt/Jf6Rd9DWiIUman4/giKO3VwzW0gUmO4J0hADgsPXiR2
         mWYgyxWoIJCFIzVB1ZwgWKsqJF5WQQLrJ87V9RsHZe8J7ngHDmihhFH3OXNY3n5iB6F5
         KFURKS2vjSxPzjayLyCRw2F0OuC4jBPrvgxnl/wy8XUmdQVkuHzMREQ+2trOmfeQxiCc
         b1ZA==
X-Gm-Message-State: AOAM530AOXOqGsWr5MABQeE33UTen37leml5AKjRVT1za0ltrd2arYxX
        3fG+T5D4/LMCN5lrtSP5qb4=
X-Google-Smtp-Source: ABdhPJy1hMAkQwosbFm6ZbTD01NTC6E3jj+Tzl/7rm3BAHx8aj74Yjn/fYl+Z4jW7btspa8uyMxRQw==
X-Received: by 2002:a17:902:a9c2:b029:e7:147f:76a1 with SMTP id b2-20020a170902a9c2b02900e7147f76a1mr26006028plr.5.1617658455986;
        Mon, 05 Apr 2021 14:34:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:20c0:5960:9793:8deb? ([2601:647:4000:d7:20c0:5960:9793:8deb])
        by smtp.gmail.com with ESMTPSA id a204sm16213177pfd.106.2021.04.05.14.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 14:34:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v5 3/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     Khazhy Kumykov <khazhy@google.com>,
        John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20210405002834.32339-1-bvanassche@acm.org>
 <20210405002834.32339-4-bvanassche@acm.org>
 <CACGdZYJh6ZvVekC8eBvz3SmN-TH8hTAmMQrvHtLJsKyL3R_fLw@mail.gmail.com>
Message-ID: <9e13694e-9888-1938-953b-ffceabd2e35d@acm.org>
Date:   Mon, 5 Apr 2021 14:34:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACGdZYJh6ZvVekC8eBvz3SmN-TH8hTAmMQrvHtLJsKyL3R_fLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/21 11:08 AM, Khazhy Kumykov wrote:
> On Sun, Apr 4, 2021 at 5:28 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 116c3691b104..e7a6a114d216 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -209,7 +209,11 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>
>>         if (!reserved)
>>                 bitnr += tags->nr_reserved_tags;
>> -       rq = tags->rqs[bitnr];
>> +       /*
>> +        * Protected by rq->q->q_usage_counter. See also
>> +        * blk_mq_queue_tag_busy_iter().
>> +        */
>> +       rq = rcu_dereference_check(tags->rqs[bitnr], true);
> 
> maybe I'm missing something, but if this tags struct has a shared
> sbitmap, what guarantees do we have that while iterating we won't
> touch requests from a queue that's tearing down? The check a few lines
> below suggests that at the least we may touch requests from a
> different queue.
> 
> say we enter blk_mq_queue_tag_busy_iter, we're iterating with raised
> hctx->q->q_usage_counter, and get to bt_iter
> 
> say tagset has 2 shared queues, hctx->q is q1, rq->q is q2
> (thread 1)
> rq = rcu_deref_check
> (rq->q != hctx->q, but we don't know yet)
> 
> (thread 2)
> elsewhere, blk_cleanup_queue(q2) runs (or elevator_exit), since we
> only have raised q_usage_counter on q1, this goes to completion and
> frees rq. if we have preempt kernel, thread 1 may be paused before we
> read rq->q, so synchonrize_rcu passes happily by
> 
> (thread 1)
> we check rq && rq->q == hctx->q, use-after-free since rq was freed above
> 
> I think John Garry mentioned observing a similar race in patch 2 of
> his series, perhaps his test case can verify this?
> 
> "Indeed, blk_mq_queue_tag_busy_iter() already does take a reference to its
> queue usage counter when called, and the queue cannot be frozen to switch
> IO scheduler until all refs are dropped. This ensures no stale references
> to IO scheduler requests will be seen by blk_mq_queue_tag_busy_iter().
> 
> However, there is nothing to stop blk_mq_queue_tag_busy_iter() being
> run for another queue associated with the same tagset, and it seeing
> a stale IO scheduler request from the other queue after they are freed."
> 
> so, to my understanding, we have a race between reading
> tags->rq[bitnr], and verifying that rq->q == hctx->q, where if we
> schedule off we might have use-after-free? If that's the case, perhaps
> we should rcu_read_lock until we verify the queues match, then we can
> release and run fn(), as we verified we no longer need it?

Hi Khazhy,

One possibility is indeed to protect the RCU dereference and the rq->q
read with an RCU reader lock. However, that would require an elaborate
comment since that would be a creative way to use RCU: protect the
request pointer dereference with an RCU reader lock until rq->q has been
tested and protect the remaining time during which rq is used with
q_usage_counter.

Another possibility is the patch below (needs to be split). That patch
protects the entire time during which rq is used by bt_iter() with either
an RCU reader lock or with the iter_rwsem semaphores. Do you perhaps have
a preference for one of these two approaches?

Thanks,

Bart.

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index e7a6a114d216..a997fc2aa2bc 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -209,12 +209,8 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)

 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
-	/*
-	 * Protected by rq->q->q_usage_counter. See also
-	 * blk_mq_queue_tag_busy_iter().
-	 */
-	rq = rcu_dereference_check(tags->rqs[bitnr], true);
-
+	rq = rcu_dereference_check(tags->rqs[bitnr],
+				   lockdep_is_held(&tags->iter_rwsem));
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assigning ->rqs[].
@@ -453,6 +449,63 @@ void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)
 }
 EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);

+static void __blk_mq_queue_tag_busy_iter(struct request_queue *q,
+					 busy_iter_fn *fn, void *priv)
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		struct blk_mq_tags *tags = hctx->tags;
+
+		/*
+		 * If no software queues are currently mapped to this
+		 * hardware queue, there's nothing to check
+		 */
+		if (!blk_mq_hw_queue_mapped(hctx))
+			continue;
+
+		if (tags->nr_reserved_tags)
+			bt_for_each(hctx, tags->breserved_tags, fn, priv, true);
+		bt_for_each(hctx, tags->bitmap_tags, fn, priv, false);
+	}
+}
+
+/**
+ * blk_mq_queue_tag_busy_iter_atomic - iterate over all requests with a driver tag
+ * @q:		Request queue to examine.
+ * @fn:		Pointer to the function that will be called for each request
+ *		on @q. @fn will be called as follows: @fn(hctx, rq, @priv,
+ *		reserved) where rq is a pointer to a request and hctx points
+ *		to the hardware queue associated with the request. 'reserved'
+ *		indicates whether or not @rq is a reserved request. @fn must
+ *		not sleep.
+ * @priv:	Will be passed as third argument to @fn.
+ *
+ * Note: if @q->tag_set is shared with other request queues then @fn will be
+ * called for all requests on all queues that share that tag set and not only
+ * for requests associated with @q.
+ *
+ * Does not sleep.
+ */
+void blk_mq_queue_tag_busy_iter_atomic(struct request_queue *q,
+				       busy_iter_fn *fn, void *priv)
+{
+	/*
+	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
+	 * while the queue is frozen. So we can use q_usage_counter to avoid
+	 * racing with it.
+	 */
+	if (!percpu_ref_tryget(&q->q_usage_counter))
+		return;
+
+	rcu_read_lock();
+	__blk_mq_queue_tag_busy_iter(q, fn, priv);
+	rcu_read_unlock();
+
+	blk_queue_exit(q);
+}
+
 /**
  * blk_mq_queue_tag_busy_iter - iterate over all requests with a driver tag
  * @q:		Request queue to examine.
@@ -466,13 +519,18 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
  * Note: if @q->tag_set is shared with other request queues then @fn will be
  * called for all requests on all queues that share that tag set and not only
  * for requests associated with @q.
+ *
+ * May sleep.
  */
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv)
 {
-	struct blk_mq_hw_ctx *hctx;
+	struct blk_mq_tag_set *set = q->tag_set;
+	struct blk_mq_tags *tags;
 	int i;

+	might_sleep();
+
 	/*
 	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
 	 * while the queue is frozen. So we can use q_usage_counter to avoid
@@ -481,20 +539,19 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;

-	queue_for_each_hw_ctx(q, hctx, i) {
-		struct blk_mq_tags *tags = hctx->tags;
-
-		/*
-		 * If no software queues are currently mapped to this
-		 * hardware queue, there's nothing to check
-		 */
-		if (!blk_mq_hw_queue_mapped(hctx))
-			continue;

-		if (tags->nr_reserved_tags)
-			bt_for_each(hctx, tags->breserved_tags, fn, priv, true);
-		bt_for_each(hctx, tags->bitmap_tags, fn, priv, false);
+	for (i = 0; i < set->nr_hw_queues; i++) {
+		tags = set->tags[i];
+		if (tags)
+			down_read(&tags->iter_rwsem);
 	}
+	__blk_mq_queue_tag_busy_iter(q, fn, priv);
+	for (i = set->nr_hw_queues - 1; i >= 0; i--) {
+		tags = set->tags[i];
+		if (tags)
+			up_read(&tags->iter_rwsem);
+	}
+
 	blk_queue_exit(q);
 }

@@ -576,7 +633,9 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,

 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
-	init_rwsem(&tags->iter_rwsem);
+	lockdep_register_key(&tags->iter_rwsem_key);
+	__init_rwsem(&tags->iter_rwsem, "tags->iter_rwsem",
+		     &tags->iter_rwsem_key);

 	if (flags & BLK_MQ_F_TAG_HCTX_SHARED)
 		return tags;
@@ -594,6 +653,7 @@ void blk_mq_free_tags(struct blk_mq_tags *tags, unsigned int flags)
 		sbitmap_queue_free(tags->bitmap_tags);
 		sbitmap_queue_free(tags->breserved_tags);
 	}
+	lockdep_unregister_key(&tags->iter_rwsem_key);
 	kfree(tags);
 }

diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index d1d73d7cc7df..e37f219bd36a 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -22,6 +22,7 @@ struct blk_mq_tags {
 	struct list_head page_list;

 	struct rw_semaphore iter_rwsem;
+	struct lock_class_key iter_rwsem_key;
 };

 extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
@@ -43,6 +44,8 @@ extern void blk_mq_tag_resize_shared_sbitmap(struct blk_mq_tag_set *set,
 					     unsigned int size);

 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
+void blk_mq_queue_tag_busy_iter_atomic(struct request_queue *q,
+		busy_iter_fn *fn, void *priv);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
 void blk_mq_all_tag_iter_atomic(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d6c9b655c0f5..f5e1ace273e2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -117,7 +117,7 @@ unsigned int blk_mq_in_flight(struct request_queue *q,
 {
 	struct mq_inflight mi = { .part = part };

-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+	blk_mq_queue_tag_busy_iter_atomic(q, blk_mq_check_inflight, &mi);

 	return mi.inflight[0] + mi.inflight[1];
 }
@@ -127,7 +127,7 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
 {
 	struct mq_inflight mi = { .part = part };

-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
+	blk_mq_queue_tag_busy_iter_atomic(q, blk_mq_check_inflight, &mi);
 	inflight[0] = mi.inflight[0];
 	inflight[1] = mi.inflight[1];
 }
@@ -881,7 +881,7 @@ bool blk_mq_queue_inflight(struct request_queue *q)
 {
 	bool busy = false;

-	blk_mq_queue_tag_busy_iter(q, blk_mq_rq_inflight, &busy);
+	blk_mq_queue_tag_busy_iter_atomic(q, blk_mq_rq_inflight, &busy);
 	return busy;
 }
 EXPORT_SYMBOL_GPL(blk_mq_queue_inflight);
