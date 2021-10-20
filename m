Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134A7C433FE
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 19:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7DA61212
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 19:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhJTTDS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhJTTDQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 15:03:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CEEC06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 12:01:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r10so327553wra.12
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NtkUFXEZ3cCtmtJBjgq+OZhnXnQWqbS57zg+x9RTvH0=;
        b=NTu0maTFIBGFbB2rt4KHid6OO6mmPc7RGqllfYz4qfd+e3t5Cmx6+oIKxukYYsUbCb
         C/zcUoCiWQX1FzFOh5M7L4bbQrXUQ2m595/mjlBB6s8axr2svIG34S1RuFUSqnvPGSFR
         aB50hxTkKNoxpdspaey1lJHsAaDGdCRbiCfvXlLMn0W5Qc7LVAQjQk2zmqx6F509+uXu
         0g/wonGIbnKK39GFvLD1aztJLoXageA0wZfGzOiBqZxlZdCtMpG4GRnwcLAuFJF5M3Mp
         pHLYWrHuViTol3L3KPSv2O8CVkNwwxxUuAHM16ljojlRITkZepGqbvoRJJPMU3GoRxeP
         1W3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtkUFXEZ3cCtmtJBjgq+OZhnXnQWqbS57zg+x9RTvH0=;
        b=OBCOA3DfMmDYbMVdH4VxNzUgNrjZ+A92VZ5Jh9DiDQW9B26/ooguGV2cH28g2UfLRS
         dh1I5a80RJIOAoCJdMOQO973No1jxYVz2Kwf2BLfGZ7HGrfgJ5j3X4DCGETpSXNcM0n5
         d2fOMo7/cMcB/Eq07B8SSJuLWlCsKSxTC49PETvfmoaVLyilGVPJPmqHCYaigSLiOow4
         WRl7k+xy/s2rk2EiA5keXmtHRyCh9NYT24RfusxAYe9rgYycqIIJj6rbWm8QO3ZZdxva
         OK2hdD+HfOHhqzZgnttroqBb9Fy/hdDKSqSjh1M06vTZlt0jLNeipUOV3U+1qOmCHDCu
         +c6A==
X-Gm-Message-State: AOAM531BDb58xdgQ6PV6j90xy6tW58jChLqR5uyPP++JKylHziBptA8o
        qeQJZrfUipQWSMJjCOIXtfQhfalC5m47Jw==
X-Google-Smtp-Source: ABdhPJxQwqG5Qz/w813/VdFLyRwHM1VVsAT8p8TQrN3+kgHBDUurrwFmCOPXLqL9yCrQuaewh6yCSA==
X-Received: by 2002:a5d:4dd1:: with SMTP id f17mr1272018wru.226.1634756459400;
        Wed, 20 Oct 2021 12:00:59 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.206])
        by smtp.gmail.com with ESMTPSA id j11sm2743880wmi.24.2021.10.20.12.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 12:00:59 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 2/3] block: clean up blk_mq_submit_bio() merging
Date:   Wed, 20 Oct 2021 20:00:49 +0100
Message-Id: <daedc90d4029a5d1d73344771632b1faca3aaf81.1634755800.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634755800.git.asml.silence@gmail.com>
References: <cover.1634755800.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Combine blk_mq_sched_bio_merge() and blk_attempt_plug_merge() under a
common if, so we don't check it twice.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq-sched.c |  2 +-
 block/blk-mq-sched.h | 12 +-----------
 block/blk-mq.c       | 15 +++++++--------
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index e85b7556b096..5b259fdea794 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -361,7 +361,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	}
 }
 
-bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
+bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
 	struct elevator_queue *e = q->elevator;
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 98836106b25f..25d1034952b6 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -12,7 +12,7 @@ void blk_mq_sched_assign_ioc(struct request *rq);
 
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **merged_request);
-bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
+bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs);
 bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
 				   struct list_head *free);
@@ -42,16 +42,6 @@ static inline bool bio_mergeable(struct bio *bio)
 	return !(bio->bi_opf & REQ_NOMERGE_FLAGS);
 }
 
-static inline bool
-blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
-		unsigned int nr_segs)
-{
-	if (blk_queue_nomerges(q) || !bio_mergeable(bio))
-		return false;
-
-	return __blk_mq_sched_bio_merge(q, bio, nr_segs);
-}
-
 static inline bool
 blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
 			 struct bio *bio)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a71aeed7b987..f159d007a015 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2481,7 +2481,6 @@ void blk_mq_submit_bio(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	const int is_sync = op_is_sync(bio->bi_opf);
-	const int is_flush_fua = op_is_flush(bio->bi_opf);
 	struct request *rq;
 	struct blk_plug *plug;
 	bool same_queue_rq = false;
@@ -2495,12 +2494,12 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		goto queue_exit;
 
-	if (!is_flush_fua && !blk_queue_nomerges(q) &&
-	    blk_attempt_plug_merge(q, bio, nr_segs, &same_queue_rq))
-		goto queue_exit;
-
-	if (blk_mq_sched_bio_merge(q, bio, nr_segs))
-		goto queue_exit;
+	if (!blk_queue_nomerges(q) && bio_mergeable(bio)) {
+		if (blk_attempt_plug_merge(q, bio, nr_segs, &same_queue_rq))
+			goto queue_exit;
+		if (blk_mq_sched_bio_merge(q, bio, nr_segs))
+			goto queue_exit;
+	}
 
 	rq_qos_throttle(q, bio);
 
@@ -2543,7 +2542,7 @@ void blk_mq_submit_bio(struct bio *bio)
 		return;
 	}
 
-	if (is_flush_fua && blk_insert_flush(rq))
+	if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
 		return;
 
 	if (plug && (q->nr_hw_queues == 1 ||
-- 
2.33.1

