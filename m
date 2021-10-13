Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D62EC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 20:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8564F61165
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 20:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhJMUCo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbhJMUCk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 16:02:40 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328DCC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 13:00:37 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id x1so1001753ilv.4
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 13:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cyDA/wjlY4C5khtHnpEfMLEC07x5EIVN+MgBdSSAfsc=;
        b=aICV7BE/AW+6lbgGuv1zzlwI4dUhVyT4IRjkEskeDd2EFZvk/qZrNzFp9ntW7+2qEP
         l+Zg+sTWDwNzaPyYrYbQSvTXDBYOxrwo8H7526RQiw6bMGS6c/2uJK2yvLfX6SCByKJE
         35V1KEQ7wdVeVkkMsjOn9jK1KI0nQQoELBawx5V2tZPiufG72n/kM4PezVWZqZgWkNEg
         TN/iUK/M7As+Y9SdfoiV+MXDLuB2/a0K/kqUmA0rUUqaW36KOUSRgWBTiNg3Of+shiBh
         xTryY072wuPZz65VfIJqsQqZzRMFTE3lYmWEENtyk7hWMiTIS9+2T1k/FZh5kpVczeqY
         iVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cyDA/wjlY4C5khtHnpEfMLEC07x5EIVN+MgBdSSAfsc=;
        b=13qVuaXw3uud0rZNNzMLUDjNonrM5qMW79vGDFO3KF83Cq1KaDC8eHjzwSA/qLpQDN
         S4XB6NPpZQfcD+8HTSlX4moD3WHX+Xc+yzJ/PrHgEKf17XsChDG2eTdpQuShJqoHh9cc
         W+Y5w5DihWoJcl09l0KSAX6oYHmwieu6Ezy3BBaCxLagM+c1k4okTRdZE5YjIkVje9HO
         U6+bIaHE2T/kVTi4aFS1ByiMrt50hu72OA5T1FLmsytumPFuHZ9LSB+vZ+fAgU7OMByx
         4disDcRqhlV90CQIeRDobi0UUdwAyld+pnwp/ApH5eHJThqYAJyij/avglL/iALsodde
         rNrg==
X-Gm-Message-State: AOAM532mTmjbHGOLKjGB6MZTvtSvV3nfItEJLcfC2jFS/TL+VDXx8zWy
        NS1LzZdKzygb/tK17Nm7BHgDxFS5LxTfvw==
X-Google-Smtp-Source: ABdhPJwQZRBoLR36zZ1ZTxXaGGRwR9fbNOJvh6IpAQw7C7OJ3cqWtDDb8rH6UTcKUYVsUvbE2Yypsw==
X-Received: by 2002:a05:6e02:661:: with SMTP id l1mr909576ilt.122.1634155236228;
        Wed, 13 Oct 2021 13:00:36 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v18sm210449ilq.77.2021.10.13.13.00.35
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 13:00:35 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] block: remove plug based merging
Message-ID: <fb4e2033-24fb-cd47-5e8d-557c8431097f@kernel.dk>
Date:   Wed, 13 Oct 2021 14:00:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It's expensive to browse the whole plug list for merge opportunities at
the IOPS rates that modern storage can do. For sequential IO, the one-hit
cached merge should suffice on fast drives, and for rotational storage the
IO scheduler will do a more exhaustive lookup based merge anyway.

Just remove the plug based O(N) traversal merging.

With that, there's really no difference between the two plug cases that
we have. Unify them.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

v2: unify the two plug cases in blk_mq_submit_bio() as well

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 14ce19607cd8..28eb0fd2ea02 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1075,62 +1075,6 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
 	return BIO_MERGE_FAILED;
 }
 
-/**
- * blk_attempt_plug_merge - try to merge with %current's plugged list
- * @q: request_queue new bio is being queued at
- * @bio: new bio being queued
- * @nr_segs: number of segments in @bio
- * @same_queue_rq: pointer to &struct request that gets filled in when
- * another request associated with @q is found on the plug list
- * (optional, may be %NULL)
- *
- * Determine whether @bio being queued on @q can be merged with a request
- * on %current's plugged list.  Returns %true if merge was successful,
- * otherwise %false.
- *
- * Plugging coalesces IOs from the same issuer for the same purpose without
- * going through @q->queue_lock.  As such it's more of an issuing mechanism
- * than scheduling, and the request, while may have elvpriv data, is not
- * added on the elevator at this point.  In addition, we don't have
- * reliable access to the elevator outside queue lock.  Only check basic
- * merging parameters without querying the elevator.
- *
- * Caller must ensure !blk_queue_nomerges(q) beforehand.
- */
-bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
-		unsigned int nr_segs, struct request **same_queue_rq)
-{
-	struct blk_plug *plug;
-	struct request *rq;
-	struct list_head *plug_list;
-
-	plug = blk_mq_plug(q, bio);
-	if (!plug)
-		return false;
-
-	plug_list = &plug->mq_list;
-
-	list_for_each_entry_reverse(rq, plug_list, queuelist) {
-		if (rq->q == q && same_queue_rq) {
-			/*
-			 * Only blk-mq multiple hardware queues case checks the
-			 * rq in the same queue, there should be only one such
-			 * rq in a queue
-			 **/
-			*same_queue_rq = rq;
-		}
-
-		if (rq->q != q)
-			continue;
-
-		if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
-		    BIO_MERGE_OK)
-			return true;
-	}
-
-	return false;
-}
-
 /*
  * Iterate list of requests and see if we can merge this bio with any
  * of them.
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 68cccb2d1f8c..cfe957ffafa7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2226,7 +2226,6 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
 	struct request *rq;
 	struct blk_plug *plug;
-	struct request *same_queue_rq = NULL;
 	unsigned int nr_segs;
 	blk_qc_t cookie;
 	blk_status_t ret;
@@ -2238,10 +2237,6 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		goto queue_exit;
 
-	if (!is_flush_fua && !blk_queue_nomerges(q) &&
-	    blk_attempt_plug_merge(q, bio, nr_segs, &same_queue_rq))
-		goto queue_exit;
-
 	if (blk_mq_sched_bio_merge(q, bio, nr_segs))
 		goto queue_exit;
 
@@ -2295,9 +2290,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		/* Bypass scheduler for flush requests */
 		blk_insert_flush(rq);
 		blk_mq_run_hw_queue(rq->mq_hctx, true);
-	} else if (plug && (q->nr_hw_queues == 1 ||
-		   blk_mq_is_shared_tags(rq->mq_hctx->flags) ||
-		   q->mq_ops->commit_rqs || !blk_queue_nonrot(q))) {
+	} else if (plug) {
 		/*
 		 * Use plugging if we have a ->commit_rqs() hook as well, as
 		 * we know the driver uses bd->last in a smart fashion.
@@ -2323,28 +2316,6 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	} else if (q->elevator) {
 		/* Insert the request at the IO scheduler queue */
 		blk_mq_sched_insert_request(rq, false, true, true);
-	} else if (plug && !blk_queue_nomerges(q)) {
-		/*
-		 * We do limited plugging. If the bio can be merged, do that.
-		 * Otherwise the existing request in the plug list will be
-		 * issued. So the plug list will have one request at most
-		 * The plug list might get flushed before this. If that happens,
-		 * the plug list is empty, and same_queue_rq is invalid.
-		 */
-		if (list_empty(&plug->mq_list))
-			same_queue_rq = NULL;
-		if (same_queue_rq) {
-			list_del_init(&same_queue_rq->queuelist);
-			plug->rq_count--;
-		}
-		blk_add_rq_to_plug(plug, rq);
-		trace_block_plug(q);
-
-		if (same_queue_rq) {
-			trace_block_unplug(q, 1, true);
-			blk_mq_try_issue_directly(same_queue_rq->mq_hctx,
-						  same_queue_rq, &cookie);
-		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) ||
 		   !rq->mq_hctx->dispatch_busy) {
 		/*
diff --git a/block/blk.h b/block/blk.h
index 6a329e767ab2..0803505da482 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -214,8 +214,6 @@ static inline void blk_integrity_del(struct gendisk *disk)
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
 
-bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
-		unsigned int nr_segs, struct request **same_queue_rq);
 bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
 			struct bio *bio, unsigned int nr_segs);
 
-- 
Jens Axboe

