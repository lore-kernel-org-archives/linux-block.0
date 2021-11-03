Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFB1C433FE
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 18:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D0C61156
	for <linux-block@archiver.kernel.org>; Wed,  3 Nov 2021 18:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhKCSfE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhKCSfD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 14:35:03 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE73BC061203
        for <linux-block@vger.kernel.org>; Wed,  3 Nov 2021 11:32:26 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id bg25so4376943oib.1
        for <linux-block@vger.kernel.org>; Wed, 03 Nov 2021 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bsj5ZLlquf/pPLdn6lhiC7/HYQDntfsyVm6vIVzVNlU=;
        b=Swa63GpKQpBSghR1qeumFKO5qqLhiewOsM0bu7kWTodUUnHlGW+wHuIktdcJ6PYCg8
         EPKdZYBVuTWpjfAipaJjYTcQd19qhd0cdRoOgDBhx6IPLyUfgs6hHZ1X2wjowA4gs+U1
         pUgRpNHRrPaFhlVGjpHB4fzzALhpTvwFiwwzhTV8Clxo/bG2bbpB2iHXt21N3Tvo35md
         SOQ7MQLzsb93lRS9Hrazjw6lEAdEwmvpN5Ixxixi+cqzC6N+E7EiGQv/xRW5hJ0G1ZjG
         2U44PnE86XWtdrlNYXhpsxYSQstetIoY8bBNuXrkoRN5Am3MBC/8B8i6dquJ+vdP2Y/O
         tVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bsj5ZLlquf/pPLdn6lhiC7/HYQDntfsyVm6vIVzVNlU=;
        b=PDplI/c/9mNHq+6c60Sdz1Ju4YyNSgm3gZg6Ks5mwpccOzAaQmQiwxnbIRQWjqDgKy
         1NEZURe2+ZRaDf7911acXhLCgUJ8XhcctxI6xj5RYba3nEen/1BEebDMos6tUxsXLzCq
         Rud499B4drPsrqiySrMTp8vpix1JJWK4ia3pQaNL4PbnskFudM+1PE0A/5cpLHuaXr82
         UNzwOyv47mP+7U82QOFmK7s5ubAJuFcebPw2DYEBzfAMT3B72Kjf/yrYRb+sn4OBHl6q
         z2BZ56gWnV9GqEKzB7YdjgolPzLMA3GG3hq7W5q1NEd/wnW38rM/9gLbCE+rDJ+lGlbX
         tTsw==
X-Gm-Message-State: AOAM531+U4FOzLaYjX2FfzVcjKbQHUrh1HpYDcnxjCpKNxmiUg2Pncf8
        5stVKIU9GAeTAYX1u/1EdqzsCbl1ONx0Sg==
X-Google-Smtp-Source: ABdhPJz3szlLyzgsIM6jlRM1dX/5oNRG/ffajYqelPQkYI1OrU1l1SL8/Ptla8HASQa29giRMpNn5g==
X-Received: by 2002:a54:4d89:: with SMTP id y9mr11845941oix.22.1635964345836;
        Wed, 03 Nov 2021 11:32:25 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i20sm766056otp.18.2021.11.03.11.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:32:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] block: make blk_try_enter_queue() available for blk-mq
Date:   Wed,  3 Nov 2021 12:32:20 -0600
Message-Id: <20211103183222.180268-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211103183222.180268-1-axboe@kernel.dk>
References: <20211103183222.180268-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just a prep patch for shifting the queue enter logic.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c | 26 +-------------------------
 block/blk.h      | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c2d267b6f910..e00f5a2287cc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -386,30 +386,6 @@ void blk_cleanup_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_cleanup_queue);
 
-static bool blk_try_enter_queue(struct request_queue *q, bool pm)
-{
-	rcu_read_lock();
-	if (!percpu_ref_tryget_live_rcu(&q->q_usage_counter))
-		goto fail;
-
-	/*
-	 * The code that increments the pm_only counter must ensure that the
-	 * counter is globally visible before the queue is unfrozen.
-	 */
-	if (blk_queue_pm_only(q) &&
-	    (!pm || queue_rpm_status(q) == RPM_SUSPENDED))
-		goto fail_put;
-
-	rcu_read_unlock();
-	return true;
-
-fail_put:
-	blk_queue_exit(q);
-fail:
-	rcu_read_unlock();
-	return false;
-}
-
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
@@ -442,7 +418,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 	return 0;
 }
 
-static inline int bio_queue_enter(struct bio *bio)
+int bio_queue_enter(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 
diff --git a/block/blk.h b/block/blk.h
index 7afffd548daf..f7371d3b1522 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -55,6 +55,31 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 void blk_freeze_queue(struct request_queue *q);
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
+int bio_queue_enter(struct bio *bio);
+
+static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
+{
+	rcu_read_lock();
+	if (!percpu_ref_tryget_live_rcu(&q->q_usage_counter))
+		goto fail;
+
+	/*
+	 * The code that increments the pm_only counter must ensure that the
+	 * counter is globally visible before the queue is unfrozen.
+	 */
+	if (blk_queue_pm_only(q) &&
+	    (!pm || queue_rpm_status(q) == RPM_SUSPENDED))
+		goto fail_put;
+
+	rcu_read_unlock();
+	return true;
+
+fail_put:
+	blk_queue_exit(q);
+fail:
+	rcu_read_unlock();
+	return false;
+}
 
 #define BIO_INLINE_VECS 4
 struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
-- 
2.33.1

