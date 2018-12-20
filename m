Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168B7C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D0F21903
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kmTbnt0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390074AbeLTVsz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:48:55 -0500
Received: from mail-it1-f180.google.com ([209.85.166.180]:51623 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbeLTVsy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 16:48:54 -0500
Received: by mail-it1-f180.google.com with SMTP id w18so4234272ite.1
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 13:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jRO/UbTw8HbuTIn4YrOnp30M5hpMWbRVxOShDvCrTYg=;
        b=kmTbnt0ZKhI23HNq9lSRmV/2M0uxtk2jFMU6YvoFKznZHahnMetu7zmlcoGRHGd972
         EcljGgiHApkA50c5a1sPNHQpTwSe5YiqY9nSvsf6YbmiFY6SvZzuRCSFfh2rxjSK8Zfc
         DCKu2yb8PphQkqlEDObju7BEH98IfdCV6G6bxkaHbd+dre2lmguUrCBY5yo2vAVSAADX
         5Ogt9dQ7EJvr9mdRxr6NQsWxDyyqqKfLmPosvlXE3fxN/GBnDjlhFW6aaPl8KKOmKNaQ
         qUqVtqRm7dz9E7YVyhOMNGhiIwlXLiR0vGyD844/VulnBgq11r8IMESVoZR/6ePjN1sj
         uOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jRO/UbTw8HbuTIn4YrOnp30M5hpMWbRVxOShDvCrTYg=;
        b=L/OBtHtVP6NGWb9ggqTdBfxuCgTqJ6/pLrJJwK66cWoDToZFh/Dt+0SY/VFWbIzTNL
         dcZRXVZq/Lr7HuKUyz+ULrbCbuYJozGvaA46bKEfMkoccVbUvuet6orC/iKp9+jvhjyc
         2RdIwL+aLYgdbr4nWSvZDZY9RSjlqfNHEIc0ktKDNrhdztXDR5Zy2tVQOquEJCUEJEq0
         EFF3kmHAU6RrqYhzlki6Q3YevKjfjxXbkd2RjJKJYh71x+at9Z/MyMXxyCpZD7RCIBRk
         In/SWOYouU2o+NPRD4MT9o1Ku3nn7um9IY0H0naPw0IX9ODWC5xydzQMKLtz+/9JPOft
         fkPA==
X-Gm-Message-State: AA+aEWaCRFaIEVHhep7KWmD+u6qKayYy3nr62hf66N1P/p7vndKzLnK3
        xOQZ6ylR8P7eWK+fiqGwnngB8DCMJajH+Q==
X-Google-Smtp-Source: ALg8bN78m0COHGEPBn+LKbb+uuHcwud2YiBKJ7ig50KvKiW6DDHoFfvoSmedhfOXPC3+M4447FXNLA==
X-Received: by 2002:a24:5015:: with SMTP id m21mr306533itb.2.1545342532771;
        Thu, 20 Dec 2018 13:48:52 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h64sm5553562itb.14.2018.12.20.13.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 13:48:51 -0800 (PST)
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1545261885.185366.488.camel@acm.org>
 <1545265001.185366.496.camel@acm.org>
 <1ca5cd37-87ce-8cff-6cb4-1fdb29bd4da2@kernel.dk>
 <0560802f-efc0-e9ec-99f7-4bdbdbc234f8@oracle.com>
 <c078750c-ff6b-4939-281b-7556d31dc74d@kernel.dk>
 <fe9dfe60-3cfc-9cfa-56c3-1365cbe8ec53@oracle.com>
 <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
 <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com>
 <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
 <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
 <1545328865.185366.508.camel@acm.org>
 <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk>
 <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
 <1545339362.185366.511.camel@acm.org>
 <e7d6d857-b20a-245c-c6c7-fb9b110215e9@kernel.dk>
 <1545340987.185366.515.camel@acm.org>
 <120bb59a-af93-7d8c-9afc-7087973632bf@kernel.dk>
 <1545341470.185366.519.camel@acm.org>
 <61515137-0565-e3b7-e6de-554af7d49753@kernel.dk>
 <1545342043.185366.523.camel@acm.org>
 <60b4819c-4c19-a4e3-41f3-e21b0544c9a4@kernel.dk>
Message-ID: <68c73daa-10e7-29da-b890-bf167ec164c2@kernel.dk>
Date:   Thu, 20 Dec 2018 14:48:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <60b4819c-4c19-a4e3-41f3-e21b0544c9a4@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 2:44 PM, Jens Axboe wrote:
> On 12/20/18 2:40 PM, Bart Van Assche wrote:
>> On Thu, 2018-12-20 at 14:34 -0700, Jens Axboe wrote:
>>> Yeah, I don't think it's bullet proof either, it just closes the gap.
>>> I'm fine with fiddling with the tag iteration. On top of what I sent, we
>>> could have tag iteration hold the RCU read lock, and then we just need
>>> to ensure that the tags are freed with RCU.
>>
>> Do you mean using call_rcu() to free tags? Would that require to add a
>> struct rcu_head to every request? Would it be acceptable to increase the
>> size of struct request with an rcu_head? Additionally, could that reduce
>> the queue depth if the time between grace periods is larger than the time
>> between I/O submissions?
> 
> No no, the requests are out of full pages, we just need one per blk_mq_tags.
> Something like the below... And then the tag iteration needs to grab the
> RCU read lock to prevent the page freeing from happening.
> 
> This should essentially be free, as rcu read lock for tag iteration is
> basically a no-op.
> 
> Need to handle the flush request on top of this as well.

With FQ handled as well.


diff --git a/block/blk-flush.c b/block/blk-flush.c
index a3fc7191c694..23e1f5fb091f 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -491,12 +491,22 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 	return NULL;
 }
 
+static void blk_fq_rcu_free(struct work_struct *work)
+{
+	struct blk_flush_queue *fq = container_of(to_rcu_work(work),
+							struct blk_flush_queue,
+							rcu_work);
+
+	kfree(fq->flush_rq);
+	kfree(fq);
+}
+	
 void blk_free_flush_queue(struct blk_flush_queue *fq)
 {
 	/* bio based request queue hasn't flush queue */
 	if (!fq)
 		return;
 
-	kfree(fq->flush_rq);
-	kfree(fq);
+	INIT_RCU_WORK(&fq->rcu_work, blk_fq_rcu_free);
+	queue_rcu_work(system_wq, &fq->rcu_work);
 }
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2089c6c62f44..c39b58391ae8 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -228,13 +228,15 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
-	rq = tags->rqs[bitnr];
+	if (tags->rqs[bitnr].queue != hctx->queue)
+		return true;
 
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assigning ->rqs[].
 	 */
-	if (rq && rq->q == hctx->queue)
+	rq = tags->rqs[bitnr].rq;
+	if (rq)
 		return iter_data->fn(hctx, rq, iter_data->data, reserved);
 	return true;
 }
@@ -263,7 +265,9 @@ static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
 		.reserved = reserved,
 	};
 
+	rcu_read_lock();
 	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
+	rcu_read_unlock();
 }
 
 struct bt_tags_iter_data {
@@ -287,7 +291,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assining ->rqs[].
 	 */
-	rq = tags->rqs[bitnr];
+	rq = tags->rqs[bitnr].rq;
 	if (rq && blk_mq_request_started(rq))
 		return iter_data->fn(rq, iter_data->data, reserved);
 
@@ -317,8 +321,11 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
 		.reserved = reserved,
 	};
 
-	if (tags->rqs)
+	if (tags->rqs) {
+		rcu_read_lock();
 		sbitmap_for_each_set(&bt->sb, bt_tags_iter, &iter_data);
+		rcu_read_unlock();
+	}
 }
 
 /**
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..bdd1bfc08c21 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -4,6 +4,11 @@
 
 #include "blk-mq.h"
 
+struct rq_tag_entry {
+	struct request_queue *queue;
+	struct request *rq;
+};
+
 /*
  * Tag address space map.
  */
@@ -16,9 +21,11 @@ struct blk_mq_tags {
 	struct sbitmap_queue bitmap_tags;
 	struct sbitmap_queue breserved_tags;
 
-	struct request **rqs;
+	struct rq_tag_entry *rqs;
 	struct request **static_rqs;
 	struct list_head page_list;
+
+	struct rcu_work rcu_work;
 };
 
 
@@ -78,7 +85,8 @@ static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 static inline void blk_mq_tag_set_rq(struct blk_mq_hw_ctx *hctx,
 		unsigned int tag, struct request *rq)
 {
-	hctx->tags->rqs[tag] = rq;
+	hctx->tags->rqs[tag].queue = hctx->queue;
+	hctx->tags->rqs[tag].rq = rq;
 }
 
 static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2de972857496..4decd1e7d2d9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -298,13 +298,16 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		rq->tag = -1;
 		rq->internal_tag = tag;
 	} else {
-		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
+		struct blk_mq_hw_ctx *hctx = data->hctx;
+
+		if (hctx->flags & BLK_MQ_F_TAG_SHARED) {
 			rq_flags = RQF_MQ_INFLIGHT;
-			atomic_inc(&data->hctx->nr_active);
+			atomic_inc(&hctx->nr_active);
 		}
 		rq->tag = tag;
 		rq->internal_tag = -1;
-		data->hctx->tags->rqs[rq->tag] = rq;
+		hctx->tags->rqs[rq->tag].queue = hctx->queue;
+		hctx->tags->rqs[rq->tag].rq = rq;
 	}
 
 	/* csd/requeue_work/fifo_time is initialized before use */
@@ -797,8 +800,8 @@ EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 {
 	if (tag < tags->nr_tags) {
-		prefetch(tags->rqs[tag]);
-		return tags->rqs[tag];
+		prefetch(tags->rqs[tag].rq);
+		return tags->rqs[tag].rq;
 	}
 
 	return NULL;
@@ -809,10 +812,11 @@ static bool blk_mq_rq_inflight(struct blk_mq_hw_ctx *hctx, struct request *rq,
 			       void *priv, bool reserved)
 {
 	/*
-	 * If we find a request that is inflight and the queue matches,
-	 * we know the queue is busy. Return false to stop the iteration.
+	 * We're only called here if the queue matches. If the rq state is
+	 * inflight, we know the queue is busy. Return false to stop the
+	 * iteration.
 	 */
-	if (rq->state == MQ_RQ_IN_FLIGHT && rq->q == hctx->queue) {
+	if (rq->state == MQ_RQ_IN_FLIGHT) {
 		bool *busy = priv;
 
 		*busy = true;
@@ -1049,11 +1053,14 @@ bool blk_mq_get_driver_tag(struct request *rq)
 	shared = blk_mq_tag_busy(data.hctx);
 	rq->tag = blk_mq_get_tag(&data);
 	if (rq->tag >= 0) {
+		struct blk_mq_hw_ctx *hctx = data.hctx;
+
 		if (shared) {
 			rq->rq_flags |= RQF_MQ_INFLIGHT;
 			atomic_inc(&data.hctx->nr_active);
 		}
-		data.hctx->tags->rqs[rq->tag] = rq;
+		hctx->tags->rqs[rq->tag].queue = hctx->queue;
+		hctx->tags->rqs[rq->tag].rq = rq;
 	}
 
 done:
@@ -2020,11 +2027,27 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	return cookie;
 }
 
-void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
-		     unsigned int hctx_idx)
+static void blk_mq_rcu_free_pages(struct work_struct *work)
 {
+	struct blk_mq_tags *tags = container_of(to_rcu_work(work),
+						struct blk_mq_tags, rcu_work);
 	struct page *page;
 
+	while (!list_empty(&tags->page_list)) {
+		page = list_first_entry(&tags->page_list, struct page, lru);
+		list_del_init(&page->lru);
+		/*
+		 * Remove kmemleak object previously allocated in
+		 * blk_mq_init_rq_map().
+		 */
+		kmemleak_free(page_address(page));
+		__free_pages(page, page->private);
+	}
+}
+
+void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+		     unsigned int hctx_idx)
+{
 	if (tags->rqs && set->ops->exit_request) {
 		int i;
 
@@ -2038,16 +2061,9 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		}
 	}
 
-	while (!list_empty(&tags->page_list)) {
-		page = list_first_entry(&tags->page_list, struct page, lru);
-		list_del_init(&page->lru);
-		/*
-		 * Remove kmemleak object previously allocated in
-		 * blk_mq_init_rq_map().
-		 */
-		kmemleak_free(page_address(page));
-		__free_pages(page, page->private);
-	}
+	/* Punt to RCU free, so we don't race with tag iteration */
+	INIT_RCU_WORK(&tags->rcu_work, blk_mq_rcu_free_pages);
+	queue_rcu_work(system_wq, &tags->rcu_work);
 }
 
 void blk_mq_free_rq_map(struct blk_mq_tags *tags)
@@ -2077,7 +2093,7 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 	if (!tags)
 		return NULL;
 
-	tags->rqs = kcalloc_node(nr_tags, sizeof(struct request *),
+	tags->rqs = kcalloc_node(nr_tags, sizeof(struct rq_tag_entry),
 				 GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
 				 node);
 	if (!tags->rqs) {
diff --git a/block/blk.h b/block/blk.h
index 848278c52030..785207fc8a30 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -29,6 +29,8 @@ struct blk_flush_queue {
 	 */
 	struct request		*orig_rq;
 	spinlock_t		mq_flush_lock;
+
+	struct rcu_work		rcu_work;
 };
 
 extern struct kmem_cache *blk_requestq_cachep;

-- 
Jens Axboe

