Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50D3C4332F
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 18:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30AF60F5A
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 18:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKCSfF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 14:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhKCSfE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 14:35:04 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF3CC061714
        for <linux-block@vger.kernel.org>; Wed,  3 Nov 2021 11:32:27 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u191so5002285oie.13
        for <linux-block@vger.kernel.org>; Wed, 03 Nov 2021 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5R9kzEVPsbqM/N8i22T1YICjNfMAyJqiI/S+Doffh0=;
        b=o4Eh4NLAdm4eP9+e2i1bE1y0s/z+6wxhtw0fxmS+rzGtpuqxuK+qRL6V+yj9f4er/D
         OiIZJfssNSdlQ+xHdsZc9mzpo9esjIhryyTMTNwuPtXqFGCdVSFACyfGgKQADvQdUYW9
         3lWx1piAL09Fvb7X4JyJSHYp+zlz/v0gP9sxGBaEo1lDwZijwYY+wQ5Ud5qt4qcnR8ez
         0AamoZWFtGaOHYxAST3dvagE/KZa+IjgEq++DKeaq3WTlClD7yzp0JV+cB15lZ31Drv0
         gpOpSNilu4eNARzApHW9JpGg1GqvoKVF8WQt84bLpSnJ8jFIJ41GyEs1sNIqpKUT1tIl
         UH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5R9kzEVPsbqM/N8i22T1YICjNfMAyJqiI/S+Doffh0=;
        b=s7T7rQxPCOAj936Bn5jzOMkPxYqzIb7aNfE9cTrtVtcF080uuEGSsAUTYuOfSwA09e
         oLeg9ocCXME91mBQsJYpQgvFScraGjCEfo80BensHmAeJlYRqiGuAV5JVaEiVbJIZ3UV
         VPn/l+WlDDZqBjswOwZ9m3JgG9U/a1uWqkvdzleTTEDS++pP0DjEb1Bk+q6NPpnwKvaD
         fFqS3ii+oery1bpzw7LNN4N3iKl8LPIbNWrnrJvJzsp5F22y5ABZzUrCCA8puR6IOnOM
         iH1qpd0eEdnjHQoDKTNeaLVlOep7qu69s3t2+DvvBWlPOYcTKl23ND7naLr3haGlmKry
         /m1w==
X-Gm-Message-State: AOAM531XMnuYc67Wq0xsdZ7Wri5bP98eVVoNmbrWPP26sN5GrOMZpK82
        ZO+ajsnNdk0Sb2qYAWc10b+Mbh9OmDo1JA==
X-Google-Smtp-Source: ABdhPJyG2wR/7+GkFcWs/b6pmwjexSLLlkfGeFI92z6Z1py3oObQW9NGlk6o/qmDTOnFP+krF7lPUA==
X-Received: by 2002:a05:6808:1493:: with SMTP id e19mr12226625oiw.140.1635964346598;
        Wed, 03 Nov 2021 11:32:26 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i20sm766056otp.18.2021.11.03.11.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:32:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] block: move queue enter logic into blk_mq_submit_bio()
Date:   Wed,  3 Nov 2021 12:32:21 -0600
Message-Id: <20211103183222.180268-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211103183222.180268-1-axboe@kernel.dk>
References: <20211103183222.180268-1-axboe@kernel.dk>
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
 block/blk-core.c     | 14 ++++++--------
 block/blk-mq-sched.c | 13 ++++++++++---
 block/blk-mq.c       | 28 ++++++++++++++++++----------
 3 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e00f5a2287cc..2b12a427ffa6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -868,18 +868,16 @@ static void __submit_bio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 
-	if (unlikely(bio_queue_enter(bio) != 0))
-		return;
-
 	if (!submit_bio_checks(bio) || !blk_crypto_bio_prep(&bio))
-		goto queue_exit;
+		return;
 	if (!disk->fops->submit_bio) {
 		blk_mq_submit_bio(bio);
-		return;
+	} else {
+		if (unlikely(bio_queue_enter(bio) != 0))
+			return;
+		disk->fops->submit_bio(bio);
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
index 5498454c2164..4bc98c7264fa 100644
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
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -2506,21 +2513,20 @@ void blk_mq_submit_bio(struct bio *bio)
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
 	if (plug && plug->cached_rq) {
 		rq = rq_list_pop(&plug->cached_rq);
 		INIT_LIST_HEAD(&rq->queuelist);
+		rq_qos_throttle(q, bio);
 	} else {
 		struct blk_mq_alloc_data data = {
 			.q		= q,
@@ -2528,6 +2534,11 @@ void blk_mq_submit_bio(struct bio *bio)
 			.cmd_flags	= bio->bi_opf,
 		};
 
+		if (unlikely(!blk_mq_queue_enter(q, bio)))
+			return;
+
+		rq_qos_throttle(q, bio);
+
 		if (plug) {
 			data.nr_tags = plug->nr_ios;
 			plug->nr_ios = 1;
@@ -2538,7 +2549,8 @@ void blk_mq_submit_bio(struct bio *bio)
 			rq_qos_cleanup(q, bio);
 			if (bio->bi_opf & REQ_NOWAIT)
 				bio_wouldblock_error(bio);
-			goto queue_exit;
+			blk_queue_exit(q);
+			return;
 		}
 	}
 
@@ -2621,10 +2633,6 @@ void blk_mq_submit_bio(struct bio *bio)
 		/* Default case. */
 		blk_mq_sched_insert_request(rq, false, true, true);
 	}
-
-	return;
-queue_exit:
-	blk_queue_exit(q);
 }
 
 static size_t order_to_size(unsigned int order)
-- 
2.33.1

