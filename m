Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A58C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CEAF60C4B
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhJLSOn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhJLSOm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:14:42 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87EFC061745
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:12:40 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h196so11935719iof.2
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=en69FUDE0a4W5H0NqOm3I6EaSYFWLXHHuCLRZz08r7U=;
        b=p9BxJV00yvawkljPNjxRoHvxtSYZUuv2w3irsHr35hFltxfS9ijbApmV5xaKBjBuyO
         VVbBnoAP4Rs9mxk8SRK3SzIrSHq5txC6FV3QNCrcNaW3lqskQg7ui1MYKcWsnbNscc4A
         LVGCd2LciUF5eOq2xo6547OWqgnn/etlgkYTcOXWQd2JLvv8AdpBiVVweJpvl/eFAJtb
         MHl7Ogkt492PDXDVwPCS1TjUG8VaIll+7Uk5R1oyF4ptAoN8CsT2XE7Ps8tYa6pZ4YUu
         B2txHHWrnqNqoHVzk5gvlTPA0MfmtxGZQh+p1Jd9Jca/olt1k/3BJJ/zkYeb16pWTpiH
         wlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=en69FUDE0a4W5H0NqOm3I6EaSYFWLXHHuCLRZz08r7U=;
        b=xVoYQ8qEgDcLfqU+tsw6uI40Tmvqi6e+Ym7q/N7EPhxhJTVQp8TTNhX5kmGclaVXAl
         EYF1I5gzmD6jaDcUQ4ogGVykL/2i+P8RhFT5yd6Q5oR1a70pFfHkwvjj2+6WCM0m9Sh5
         kF7KC3LA3C3NDdUujYljOwwiuZSU94cYxcKXs7aQ8U+TfDwnqEXTn0GSWw8PxfUGtqB2
         Xq6f/d4DqWXYJZGGcOM0zVeaSrbuKu/f1W4y0PdN/FCYL6Zu/PN+ibspuk9/Y/eLyr1M
         Pg51Wo2CWnlZUkmCqA5+EdiAtg4Mtffmz/nNlbeMQDZAmKdRR8nQDalTnDSW3wR0eo/L
         yGcw==
X-Gm-Message-State: AOAM532m9J3pASSuynXl4CqTY1Wr5jxB7C/ngm5QLdwrFCO4ouP2Ds3Q
        Z8wgDaqpy4OiM7i4CqeZctjwjS2d4px5fA==
X-Google-Smtp-Source: ABdhPJyJSpy7pBGQ4AxaPlXpfiqx31z21YP+LVfUj3jiJxU1ro6ic/cSjo6aFG9lL2TfHlcsbNrb1w==
X-Received: by 2002:a02:6027:: with SMTP id i39mr23594682jac.91.1634062360030;
        Tue, 12 Oct 2021 11:12:40 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z5sm5694733ilh.9.2021.10.12.11.12.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 11:12:39 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: remove plug based merging
Message-ID: <f17bf111-d625-88a1-238c-842e11b10c55@kernel.dk>
Date:   Tue, 12 Oct 2021 12:12:39 -0600
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

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 762da71f9fde..e10f49decd06 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1043,62 +1043,6 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
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
index 5777064f1174..4c5b34787bbf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2323,10 +2323,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		goto queue_exit;
 
-	if (!is_flush_fua && !blk_queue_nomerges(q) &&
-	    blk_attempt_plug_merge(q, bio, nr_segs, &same_queue_rq))
-		goto queue_exit;
-
 	if (blk_mq_sched_bio_merge(q, bio, nr_segs))
 		goto queue_exit;
 
diff --git a/block/blk.h b/block/blk.h
index fa23338449ed..0afee3e6a7c1 100644
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

