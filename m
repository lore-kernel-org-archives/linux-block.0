Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27100C433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC0160F70
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 15:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhKDPYu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 11:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhKDPYt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 11:24:49 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510ACC061203
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 08:22:11 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id o26-20020a4abe9a000000b002b74bffdef0so2018826oop.12
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NgQpkbAg7oIoPNWGhNXHXqucaijPWnEli5+fTBhJ9cA=;
        b=UasxI8YAc97jlkeidOY8HHqYYN+69GhAkOGc/Ldowf5RmKOuoScHq6wP8Eo5Q75Qd+
         BHgwl0VQNM8XQzsfbINMOzQ+OKfP4Erro6aW4Ai3qK5gw99+utGIGFAjjsVbPLhpZBeo
         q/GC9BWIsSpkGWFv8ajYQ5Jg80T744jaTRfG6I9MlYj/UhP2lIfKAsdPTZTH5SMOFiZM
         bN4XAGBQeF2F8KC4ZTOY0t5VmZ5ZI/Bo9l0n1pPjlpJMM2HK7/7Op76rVrbw8VbAA1dK
         dlf1feh59ULwocQHDuvuf25plkGbzikkY7drPuCSkPm0PVAEd68S2PPGjPYZvczPUcEq
         QHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NgQpkbAg7oIoPNWGhNXHXqucaijPWnEli5+fTBhJ9cA=;
        b=Et2DsYAuw+axffAib+WcdvnO+M00JbaWvPJfPyj4ZkFao4WT9t28uWlg5I6jINWbWZ
         mfLUCv2+txAk6x5YgKftI3oDvEbLFtMGyyTS6i3cAy1b6MWLCjkG5g1CVKEDe+Oa8XZK
         O+aG3RECqC+xqL8n2qj4GVslvtTOO1rLS5FOvzk/WfssHHfDqcdA9b8ylQuq02g+1eQt
         D3l2QJFvrdyTQnZXARxG8SOoH3vaRDPkcMk0qdroIN1TxgRZly2pB2v2oaylPAf/7nU4
         Yfuk5vh2wTze9N5hMXs+HsvycXjo8fxwYaayk/AZvjHY37pduD4DHHP+aIGsGsB75//R
         VjTA==
X-Gm-Message-State: AOAM532saxllcOtt2z4Of4wSIQO/BuQkcqfGEO2mYsrDLw+hfB0sDjH4
        /n//MA7/A2ZcQoyO0nUQkQd0MicPlHpQIw==
X-Google-Smtp-Source: ABdhPJwjibcWADUp7PRzc4hBL+q7PJ7pENHGf1UKmputZki4T9mdmin9tt8ZUf7OH+xkXXd68XI06Q==
X-Received: by 2002:a4a:4994:: with SMTP id z142mr4163663ooa.39.1636039330258;
        Thu, 04 Nov 2021 08:22:10 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k2sm1023925oiw.7.2021.11.04.08.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 08:22:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/5] block: move queue enter logic into blk_mq_submit_bio()
Date:   Thu,  4 Nov 2021 09:22:03 -0600
Message-Id: <20211104152204.57360-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211104152204.57360-1-axboe@kernel.dk>
References: <20211104152204.57360-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Retain the old logic for the fops based submit, but for our internal
blk_mq_submit_bio(), move the queue entering logic into the core
function itself.

We need to be a bit careful if going into the scheduler, as a scheduler
or queue mappings can arbitrarily change before we have entered the queue.
Have the bio scheduler mapping do that separately, it's a very cheap
operation compared to actually doing merging locking and lookups.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c     | 17 ++++++---------
 block/blk-mq-sched.c | 13 ++++++++---
 block/blk-mq.c       | 51 +++++++++++++++++++++++++++++---------------
 block/blk.h          |  1 +
 4 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e00f5a2287cc..18aab7f8469a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -746,7 +746,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
-static noinline_for_stack bool submit_bio_checks(struct bio *bio)
+noinline_for_stack bool submit_bio_checks(struct bio *bio)
 {
 	struct block_device *bdev = bio->bi_bdev;
 	struct request_queue *q = bdev_get_queue(bdev);
@@ -868,18 +868,15 @@ static void __submit_bio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 
-	if (unlikely(bio_queue_enter(bio) != 0))
-		return;
-
-	if (!submit_bio_checks(bio) || !blk_crypto_bio_prep(&bio))
-		goto queue_exit;
 	if (!disk->fops->submit_bio) {
 		blk_mq_submit_bio(bio);
-		return;
+	} else {
+		if (unlikely(bio_queue_enter(bio) != 0))
+			return;
+		if (submit_bio_checks(bio) && blk_crypto_bio_prep(&bio))
+			disk->fops->submit_bio(bio);
+		blk_queue_exit(disk->queue);
 	}
-	disk->fops->submit_bio(bio);
-queue_exit:
-	blk_queue_exit(disk->queue);
 }
 
 /*
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 4a6789e4398b..4be652fa38e7 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -370,15 +370,20 @@ bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 	bool ret = false;
 	enum hctx_type type;
 
-	if (e && e->type->ops.bio_merge)
-		return e->type->ops.bio_merge(q, bio, nr_segs);
+	if (bio_queue_enter(bio))
+		return false;
+
+	if (e && e->type->ops.bio_merge) {
+		ret = e->type->ops.bio_merge(q, bio, nr_segs);
+		goto out_put;
+	}
 
 	ctx = blk_mq_get_ctx(q);
 	hctx = blk_mq_map_queue(q, bio->bi_opf, ctx);
 	type = hctx->type;
 	if (!(hctx->flags & BLK_MQ_F_SHOULD_MERGE) ||
 	    list_empty_careful(&ctx->rq_lists[type]))
-		return false;
+		goto out_put;
 
 	/* default per sw-queue merge */
 	spin_lock(&ctx->lock);
@@ -391,6 +396,8 @@ bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		ret = true;
 
 	spin_unlock(&ctx->lock);
+out_put:
+	blk_queue_exit(q);
 	return ret;
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f7f36d5ed25a..b0c0eac43eef 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2487,12 +2487,21 @@ static inline struct request *blk_get_plug_request(struct request_queue *q,
 	if (!plug)
 		return NULL;
 	rq = rq_list_peek(&plug->cached_rq);
-	if (rq) {
-		plug->cached_rq = rq_list_next(rq);
-		INIT_LIST_HEAD(&rq->queuelist);
-		return rq;
-	}
-	return NULL;
+	if (!rq)
+		return NULL;
+	if (unlikely(!submit_bio_checks(bio)))
+		return ERR_PTR(-EIO);
+	plug->cached_rq = rq_list_next(rq);
+	INIT_LIST_HEAD(&rq->queuelist);
+	rq_qos_throttle(q, bio);
+	return rq;
+}
+
+static inline bool blk_mq_queue_enter(struct request_queue *q, struct bio *bio)
+{
+	if (!blk_try_enter_queue(q, false) && bio_queue_enter(bio))
+		return false;
+	return true;
 }
 
 /**
@@ -2518,31 +2527,41 @@ void blk_mq_submit_bio(struct bio *bio)
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
+	if (unlikely(!blk_crypto_bio_prep(&bio)))
+		return;
+
 	blk_queue_bounce(q, &bio);
 	if (blk_may_split(q, bio))
 		__blk_queue_split(q, &bio, &nr_segs);
 
 	if (!bio_integrity_prep(bio))
-		goto queue_exit;
+		return;
 
 	if (!blk_queue_nomerges(q) && bio_mergeable(bio)) {
 		if (blk_attempt_plug_merge(q, bio, nr_segs, &same_queue_rq))
-			goto queue_exit;
+			return;
 		if (blk_mq_sched_bio_merge(q, bio, nr_segs))
-			goto queue_exit;
+			return;
 	}
 
-	rq_qos_throttle(q, bio);
-
 	plug = blk_mq_plug(q, bio);
 	rq = blk_get_plug_request(q, plug, bio);
-	if (!rq) {
+	if (IS_ERR(rq)) {
+		return;
+	} else if (!rq) {
 		struct blk_mq_alloc_data data = {
 			.q		= q,
 			.nr_tags	= 1,
 			.cmd_flags	= bio->bi_opf,
 		};
 
+		if (unlikely(!blk_mq_queue_enter(q, bio)))
+			return;
+		if (unlikely(!submit_bio_checks(bio)))
+			goto put_exit;
+
+		rq_qos_throttle(q, bio);
+
 		if (plug) {
 			data.nr_tags = plug->nr_ios;
 			plug->nr_ios = 1;
@@ -2553,7 +2572,9 @@ void blk_mq_submit_bio(struct bio *bio)
 			rq_qos_cleanup(q, bio);
 			if (bio->bi_opf & REQ_NOWAIT)
 				bio_wouldblock_error(bio);
-			goto queue_exit;
+put_exit:
+			blk_queue_exit(q);
+			return;
 		}
 	}
 
@@ -2636,10 +2657,6 @@ void blk_mq_submit_bio(struct bio *bio)
 		/* Default case. */
 		blk_mq_sched_insert_request(rq, false, true, true);
 	}
-
-	return;
-queue_exit:
-	blk_queue_exit(q);
 }
 
 static size_t order_to_size(unsigned int order)
diff --git a/block/blk.h b/block/blk.h
index f7371d3b1522..79c98ced59c8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -56,6 +56,7 @@ void blk_freeze_queue(struct request_queue *q);
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 int bio_queue_enter(struct bio *bio);
+bool submit_bio_checks(struct bio *bio);
 
 static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
 {
-- 
2.33.1

