Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B15CC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C696112E
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhKDSYt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhKDSYs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:24:48 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77237C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:22:10 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id bk26so9370795oib.11
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i123JyQi/pUuomVIg1CZI/8txZY5o6al1mihVVzVbw4=;
        b=psWuQ83Zimpc3+yaCD3Gk5kLmle/G8Iq39jbvu9859ntkzxUHLQsFRP5NCa8NeplgT
         MIvrhlB0Nk3piheMYWTNsMRHxx0i3aawNNnXndZNN7myc9H3UQ9Vd/mkn7Umh9qbrH9a
         NnT163Y8zkIb2ecAY7c60bNerP7rBkSEq7tXYdc4bHRqI2h+o0dEt3A0MmWzcA9wpPUc
         W6nOTM1r8xFuvU2xRVWOoq6VZIKskoaoC9WE1l/WAjv2d6x5o0AsXlwmOC1dyJYsuCSH
         y33ZsRtcbGRKEX6s/oJBLvjUnoV0g/xMNMUdnsCMcJwdktBU/jX76tE9NW89WraQfDEz
         E+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i123JyQi/pUuomVIg1CZI/8txZY5o6al1mihVVzVbw4=;
        b=8KnsCy9glo85XXUBwF24NSN2vh2gsQWcSm+ZUEOrhppt9DVTDu9/JhOt+PU7yN8KE2
         l0jnHsY+NhIyJHr1mmjUslid5ocK4i9PpAivNwKA+hg6vVFXssYmkHeMdJvC4KW9yLyq
         2OqZpMDMM5oYQtPldaR9s0No0k6Noxxlc7hMmQb6uUxxTfgz9Y+q7xocHQqq5nQheOe9
         7AjkP/+y+Cf3Q80h+wQv0R3XJCUz0+a3u7F4wSoistD55N4b4YJS1mjy0nqQ3O8Amq7m
         8iBoKSKz8XtAfYrGuu6G9Gvhrvj+GKvAGwbpvIvsHsmcYuYVGNgpumCQQqltTJoHs6bI
         FbEg==
X-Gm-Message-State: AOAM531PgnhO00fQr8BoxOWsZnHye3Wqx5U84wTv6J4e3yq1IzuFNK5D
        eMNRl3kogsOqY76lv1bpPu80A50ZQE9f9Q==
X-Google-Smtp-Source: ABdhPJzfzR7FpeYgTz5fQgKwzg/KwKgUVxafLIt0mlrev6h2lWtmQkX0lqzpRIGR2d0Ud6jYrosODg==
X-Received: by 2002:a05:6808:154:: with SMTP id h20mr8952285oie.0.1636050129612;
        Thu, 04 Nov 2021 11:22:09 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s206sm1595445oia.33.2021.11.04.11.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 11:22:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] block: make blk_try_enter_queue() available for blk-mq
Date:   Thu,  4 Nov 2021 12:21:59 -0600
Message-Id: <20211104182201.83906-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211104182201.83906-1-axboe@kernel.dk>
References: <20211104182201.83906-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just a prep patch for shifting the queue enter logic. This moves the
expected fast path inline, and leaves bio_queue_enter() as an
out-of-line function call. We don't want to inline the latter, as it's
mostly slow path code.

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

