Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC16C433FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097A46135E
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhJSV0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhJSV0w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607E1C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m42so14503458wms.2
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmS2BrUPNwMr2Y8HxTQBRF6ZuyMtaRKKrMwww/yn8fo=;
        b=BQnydNyPc66of3LhwBEG7A9vhE00L2Uq1MS3CleGgMJ1xoeXsjHoSyLQS+EqT5MRdt
         zR+SoHV0ugMBsnXhKbpfswnah+k0//RC+SP8q++c1p04TX0GQtoMJHgmL2fZwJyh2ctK
         iLsTj3TNXFhEqytd2/3CI6+F68Jbty8/OZa17a5Lp39H8tAzOKYK6mv1gOuL8sDOgeWk
         yXw/ucpZ6lAfsNnY1EAOMjO7pF76hkhYYNBkD2OPEyV5ZJgpdg3Jvgk0aCvBUIwsUsSl
         K9PhYosMdMQlnCdW7ZWmWhQivB5A7dIJ6e3WnVQ16CIOZhZ6UWqoSY8lLnWbLsGqpl+r
         f2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmS2BrUPNwMr2Y8HxTQBRF6ZuyMtaRKKrMwww/yn8fo=;
        b=ZbwOuLSO3Y0cfe7CGGJsSFPtY7saxpAwKgcIC9KGoiGP+MnvDkS8UXbLsUX8b4igL+
         2C1otfmYi/uUyddWvAMvtnwMBc3fHh113xK5YRsHxYSPB4ZMvvFWwTDVdCWW6LAX0yxn
         uYjPcq/yC0E1y1bKoeQsW931LIeLrVNTlrCNEjKPsgtohRfFKbL/ZhtccywOqB7qbfu9
         bHaqXnKqUmTH5IEUMC0o/l/cNjMdq9kL2yFw6tW6reLScfl+bfHk9Kps+ilqpuP2XXyg
         ytE58+YsJrdjOfoIa/3fazxI7LaZG0fGxVDro3O41IA3vEUpoY6E96XdO0R4qpExvyoq
         9FgQ==
X-Gm-Message-State: AOAM531ZJVXtB95MIT7ETcxhQHoxQMe+0SudQ4aaYFYwAMlBN9MfDgG2
        rhI9C0iP4GkROhjibkrDQM9YRux2il9NIg==
X-Google-Smtp-Source: ABdhPJyq7NDN5PohfTveUeopo8wyJfjgP2SRZO4OZXII9CwbN0WmxrkH/zvB9acXTq1/JskO4Qj0xA==
X-Received: by 2002:a1c:750b:: with SMTP id o11mr8988542wmc.5.1634678677785;
        Tue, 19 Oct 2021 14:24:37 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:37 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 06/16] block: clean up blk_mq_submit_bio() merging
Date:   Tue, 19 Oct 2021 22:24:15 +0100
Message-Id: <4772d0d2111972ed5db4bc667e68e7416f809b57.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Combine blk_mq_sched_bio_merge() and blk_attempt_plug_merge() under a
common if, so we don't check it twice. Also honor bio_mergeable() for
blk_mq_sched_bio_merge().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq-sched.c |  2 +-
 block/blk-mq-sched.h | 12 +-----------
 block/blk-mq.c       | 13 +++++++------
 3 files changed, 9 insertions(+), 18 deletions(-)

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
index bab1fccda6ca..218bfaa98591 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2482,12 +2482,13 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		goto queue_exit;
 
-	if (!is_flush_fua && !blk_queue_nomerges(q) &&
-	    blk_attempt_plug_merge(q, bio, nr_segs, &same_queue_rq))
-		goto queue_exit;
-
-	if (blk_mq_sched_bio_merge(q, bio, nr_segs))
-		goto queue_exit;
+	if (!blk_queue_nomerges(q) && bio_mergeable(bio)) {
+		if (!is_flush_fua &&
+		    blk_attempt_plug_merge(q, bio, nr_segs, &same_queue_rq))
+			goto queue_exit;
+		if (blk_mq_sched_bio_merge(q, bio, nr_segs))
+			goto queue_exit;
+	}
 
 	rq_qos_throttle(q, bio);
 
-- 
2.33.1

