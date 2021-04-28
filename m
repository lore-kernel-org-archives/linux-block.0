Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20630C433ED
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 15:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE4E16143C
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 15:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhD1PZR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 11:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230527AbhD1PZP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 11:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619623469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cqMOGmANzATjOI+ghzWTGgsYAewfXGrqm4953AfmwYc=;
        b=J0RJcNCSPIate5OU2YM/BlJQVzXhevdTWqJSHGrDj4m9Zbt4BOqmKsr/Ch6+Va8esj1Lo9
        1tEKWSlYQa1qum90EsYTy2pwXTnMuyZYxYTK/S8JD/E7/vZcFE3Yw++MeZZydGOf2mrSft
        Fp6tYK33Kgkw4R87i7OVkKdutQ9f+j0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-ZJu83LfJOzOM1bpOImXleA-1; Wed, 28 Apr 2021 11:24:26 -0400
X-MC-Unique: ZJu83LfJOzOM1bpOImXleA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBC868014C1;
        Wed, 28 Apr 2021 15:24:24 +0000 (UTC)
Received: from T590 (ovpn-13-131.pek2.redhat.com [10.72.13.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FA166C32C;
        Wed, 28 Apr 2021 15:24:19 +0000 (UTC)
Date:   Wed, 28 Apr 2021 23:24:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     David Jeffery <djeffery@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V3 3/3] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <YIl+K0p0jzE/ilo0@T590>
References: <20210427151058.2833168-1-ming.lei@redhat.com>
 <20210427151058.2833168-4-ming.lei@redhat.com>
 <20210428143013.GA31155@redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428143013.GA31155@redhat>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 28, 2021 at 10:30:13AM -0400, David Jeffery wrote:
> On Tue, Apr 27, 2021 at 11:10:58PM +0800, Ming Lei wrote:
> > 
> > refcount_inc_not_zero() in bt_tags_iter() still may read one freed
> > request.
> > 
> > Fix the issue by the following approach:
> > 
> > 1) hold a per-tags spinlock when reading ->rqs[tag] and calling
> > refcount_inc_not_zero in bt_tags_iter()
> > 
> 
> This method of closing the race still in my original patch is very nice.
> It's a great improvement.
> 
> > 2) clearing stale request referred via ->rqs[tag] before freeing
> > request pool, the per-tags spinlock is held for clearing stale
> > ->rq[tag]
> > 
> > So after we cleared stale requests, bt_tags_iter() won't observe
> > freed request any more, also the clearing will wait for pending
> > request reference.
> > 
> > The idea of clearing ->rqs[] is borrowed from John Garry's previous
> > patch and one recent David's patch.
> >
> 
> However, when you took my original cmpxchg patch and merged my separate
> function to do the cmpxchg cleaning into blk_mq_clear_rq_mapping, you
> missed why it was a separate function.  Your patch will clean out the
> static_rqs requests which are being freed, but it doesn't clean out the
> special flush request that gets allocated individually by a
> request_queue.  The flush request can be put directly into the rqs[]
> array so it also needs to be cleaned when a request_queue is being
> torn down.  This was the second caller of my separated cleaning function.

It can be covered just in one calling of the cleaning function,
see the following patch:

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index e1e997af89a0..fb9eeb03d6a0 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -500,7 +500,8 @@ static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
 	unsigned int flags = set->flags & ~BLK_MQ_F_TAG_HCTX_SHARED;
 
 	if (hctx->sched_tags) {
-		blk_mq_free_rqs(set, hctx->sched_tags, hctx_idx);
+		blk_mq_free_rqs(set, hctx->sched_tags, hctx_idx,
+				hctx->fq->flush_rq);
 		blk_mq_free_rq_map(hctx->sched_tags, flags);
 		hctx->sched_tags = NULL;
 	}
@@ -611,7 +612,8 @@ void blk_mq_sched_free_requests(struct request_queue *q)
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->sched_tags)
-			blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i);
+			blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i,
+					hctx->fq->flush_rq);
 	}
 }
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9329b94a9743..757e0e652ce7 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -277,9 +277,15 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	if (iter_static_rqs)
 		rq = tags->static_rqs[bitnr];
 	else {
+		unsigned long flags;
+
+		spin_lock_irqsave(&tags->lock, flags);
 		rq = tags->rqs[bitnr];
-		if (!rq || !refcount_inc_not_zero(&rq->ref))
+		if (!rq || !refcount_inc_not_zero(&rq->ref)) {
+			spin_unlock_irqrestore(&tags->lock, flags);
 			return true;
+		}
+		spin_unlock_irqrestore(&tags->lock, flags);
 	}
 	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
 	    !blk_mq_request_started(rq))
@@ -526,6 +532,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
+	spin_lock_init(&tags->lock);
 
 	if (blk_mq_is_sbitmap_shared(flags))
 		return tags;
@@ -586,7 +593,8 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 			return -ENOMEM;
 		}
 
-		blk_mq_free_rqs(set, *tagsptr, hctx->queue_num);
+		blk_mq_free_rqs(set, *tagsptr, hctx->queue_num,
+				hctx->fq->flush_rq);
 		blk_mq_free_rq_map(*tagsptr, flags);
 		*tagsptr = new;
 	} else {
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 7d3e6b333a4a..f942a601b5ef 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -20,6 +20,9 @@ struct blk_mq_tags {
 	struct request **rqs;
 	struct request **static_rqs;
 	struct list_head page_list;
+
+	/* used to clear rqs[] before one request pool is freed */
+	spinlock_t lock;
 };
 
 extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4bd6c11bd8bc..686f6b210114 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2291,8 +2291,42 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	return BLK_QC_T_NONE;
 }
 
+static size_t order_to_size(unsigned int order)
+{
+	return (size_t)PAGE_SIZE << order;
+}
+
+/* called before freeing request pool in @tags */
+static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
+		struct blk_mq_tags *tags, unsigned int hctx_idx,
+		struct request *flush_rq)
+{
+	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
+	struct page *page;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv_tags->lock, flags);
+	list_for_each_entry(page, &tags->page_list, lru) {
+		unsigned long start = (unsigned long)page_address(page);
+		unsigned long end = start + order_to_size(page->private);
+		int i;
+
+		for (i = 0; i < set->queue_depth; i++) {
+			struct request *rq = drv_tags->rqs[i];
+			unsigned long rq_addr = (unsigned long)rq;
+
+			if ((rq_addr >= start && rq_addr < end) ||
+					rq == flush_rq) {
+				WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
+				cmpxchg(&drv_tags->rqs[i], rq, NULL);
+			}
+		}
+	}
+	spin_unlock_irqrestore(&drv_tags->lock, flags);
+}
+
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
-		     unsigned int hctx_idx)
+		     unsigned int hctx_idx, struct request *flush_rq)
 {
 	struct page *page;
 
@@ -2309,6 +2343,8 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		}
 	}
 
+	blk_mq_clear_rq_mapping(set, tags, hctx_idx, flush_rq);
+
 	while (!list_empty(&tags->page_list)) {
 		page = list_first_entry(&tags->page_list, struct page, lru);
 		list_del_init(&page->lru);
@@ -2368,11 +2404,6 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 	return tags;
 }
 
-static size_t order_to_size(unsigned int order)
-{
-	return (size_t)PAGE_SIZE << order;
-}
-
 static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 			       unsigned int hctx_idx, int node)
 {
@@ -2461,7 +2492,7 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	return 0;
 
 fail:
-	blk_mq_free_rqs(set, tags, hctx_idx);
+	blk_mq_free_rqs(set, tags, hctx_idx, NULL);
 	return -ENOMEM;
 }
 
@@ -2794,7 +2825,7 @@ static void blk_mq_free_map_and_requests(struct blk_mq_tag_set *set,
 	unsigned int flags = set->flags;
 
 	if (set->tags && set->tags[hctx_idx]) {
-		blk_mq_free_rqs(set, set->tags[hctx_idx], hctx_idx);
+		blk_mq_free_rqs(set, set->tags[hctx_idx], hctx_idx, NULL);
 		blk_mq_free_rq_map(set->tags[hctx_idx], flags);
 		set->tags[hctx_idx] = NULL;
 	}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 143afe42c63a..08ef96c181f6 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -53,7 +53,7 @@ void blk_mq_put_rq_ref(struct request *rq);
  * Internal helpers for allocating/freeing the request map
  */
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
-		     unsigned int hctx_idx);
+		     unsigned int hctx_idx, struct request *flush_rq);
 void blk_mq_free_rq_map(struct blk_mq_tags *tags, unsigned int flags);
 struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 					unsigned int hctx_idx,

-- 
Ming

