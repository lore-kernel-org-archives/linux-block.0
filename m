Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FDFC4332F
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7413D6120D
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhKDSYu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhKDSYt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:24:49 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25986C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:22:11 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id g125so10608412oif.9
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iti7E3gdVChvNtVhy5EwTVGYEQA3wlhNQ6xDbyM+O/w=;
        b=6iq15kKlmbIgg1arTRnnWaGRfNg4923Z4AYUuFHld0XKexkGxV5hLXhtBLnJE8CWVY
         xkaPbITSEQw17W7tJCxWk2aeqe9SDkahnpWA0Z+HWThDCENMMZS/Qne8+F7Kt5Kl5HvZ
         ZruR+7Ma+HD8ZxosHK2PP1Aw6Luj01llm/pGTVg5QySWim3csayEp2ZLKJHfiRggajGB
         GZ4yhV6615wL4g7r/bQvkqHESfb45kLyKpH25GlvEvUjPZAULS9iQhYXBxHj92WAULPW
         jc/9Oyeusjo1exQfwBnK2ngNV7qM7n+tdqkjkOHqrJ6GmIIWxVYUueasjXz0ibAIbLso
         aSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iti7E3gdVChvNtVhy5EwTVGYEQA3wlhNQ6xDbyM+O/w=;
        b=wEhK83uVN8PtUDjcBgYuKtZnsIGCRMhCqjW3gwa8xVww8Js5c+KdPgguGf7OPL+r3a
         nM43tiZ7ha8z6E0Ghwf8xXASA+GNj9xhL/AS5uoV4MeRuro+VTQfFPOu42FcipsxiZWx
         b1eTamnvn5gUSTLl9MqbBC6UaisMuknNPb238dbY43Kd45J7Q6PwVk+vzCohJzMhxMUB
         7zENprFA/RnFR3gv4tpZdGraZKZteOOZP8IR5vnknmZrink3s9tdz7yTleSkgbTOZ9c1
         5JJW8FEGAYfoVDOcxoAjEISGOSAkIOl0aNdL4PdVETbEtVy96/cTilbTR/pZy5Sq+3mG
         iEUw==
X-Gm-Message-State: AOAM532sug96rGSxiU0ZUnknd+fxPcBl9pwFg7a3WNzfOZkVf1JOLVM5
        gY1PQXsWYHPQyITKHubfy5B0swwGRh29yg==
X-Google-Smtp-Source: ABdhPJwuZD4JAjZxn5a5a7vZ1kcAi/5WL+AOGZZcSWK+d+RtH67uwfAJ0Clx73BekDxcR/y6hhghdw==
X-Received: by 2002:aca:3e86:: with SMTP id l128mr17357411oia.111.1636050130284;
        Thu, 04 Nov 2021 11:22:10 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s206sm1595445oia.33.2021.11.04.11.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 11:22:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/5] block: move queue enter logic into blk_mq_submit_bio()
Date:   Thu,  4 Nov 2021 12:22:00 -0600
Message-Id: <20211104182201.83906-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211104182201.83906-1-axboe@kernel.dk>
References: <20211104182201.83906-1-axboe@kernel.dk>
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
 block/blk-core.c     | 25 +++++++++++++------------
 block/blk-mq-sched.c | 13 ++++++++++---
 block/blk-mq.c       | 36 ++++++++++++++++++++++++++----------
 block/blk.h          |  1 +
 4 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e00f5a2287cc..70cfac1d7fe1 100644
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
@@ -864,22 +864,23 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	return false;
 }
 
-static void __submit_bio(struct bio *bio)
+static void __submit_bio_fops(struct gendisk *disk, struct bio *bio)
 {
-	struct gendisk *disk = bio->bi_bdev->bd_disk;
-
 	if (unlikely(bio_queue_enter(bio) != 0))
 		return;
+	if (submit_bio_checks(bio) && blk_crypto_bio_prep(&bio))
+		disk->fops->submit_bio(bio);
+	blk_queue_exit(disk->queue);
+}
 
-	if (!submit_bio_checks(bio) || !blk_crypto_bio_prep(&bio))
-		goto queue_exit;
-	if (!disk->fops->submit_bio) {
+static void __submit_bio(struct bio *bio)
+{
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+
+	if (!disk->fops->submit_bio)
 		blk_mq_submit_bio(bio);
-		return;
-	}
-	disk->fops->submit_bio(bio);
-queue_exit:
-	blk_queue_exit(disk->queue);
+	else
+		__submit_bio_fops(disk, bio);
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
index dcb413297a96..875bd0c04409 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2478,6 +2478,13 @@ static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
 	return BLK_MAX_REQUEST_COUNT;
 }
 
+static inline bool blk_mq_queue_enter(struct request_queue *q, struct bio *bio)
+{
+	if (!blk_try_enter_queue(q, false) && bio_queue_enter(bio))
+		return false;
+	return true;
+}
+
 static struct request *blk_mq_get_new_requests(struct request_queue *q,
 					       struct blk_plug *plug,
 					       struct bio *bio)
@@ -2489,6 +2496,13 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	};
 	struct request *rq;
 
+	if (unlikely(!blk_mq_queue_enter(q, bio)))
+		return NULL;
+	if (unlikely(!submit_bio_checks(bio)))
+		goto put_exit;
+
+	rq_qos_throttle(q, bio);
+
 	if (plug) {
 		data.nr_tags = plug->nr_ios;
 		plug->nr_ios = 1;
@@ -2502,6 +2516,8 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	rq_qos_cleanup(q, bio);
 	if (bio->bi_opf & REQ_NOWAIT)
 		bio_wouldblock_error(bio);
+put_exit:
+	blk_queue_exit(q);
 	return NULL;
 }
 
@@ -2514,8 +2530,11 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
 
 		rq = rq_list_peek(&plug->cached_rq);
 		if (rq) {
+			if (unlikely(!submit_bio_checks(bio)))
+				return NULL;
 			plug->cached_rq = rq_list_next(rq);
 			INIT_LIST_HEAD(&rq->queuelist);
+			rq_qos_throttle(q, bio);
 			return rq;
 		}
 	}
@@ -2546,26 +2565,27 @@ void blk_mq_submit_bio(struct bio *bio)
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
 	rq = blk_mq_get_request(q, plug, bio);
 	if (unlikely(!rq))
-		goto queue_exit;
+		return;
 
 	trace_block_getrq(bio);
 
@@ -2646,10 +2666,6 @@ void blk_mq_submit_bio(struct bio *bio)
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

