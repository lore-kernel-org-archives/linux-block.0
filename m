Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE53FC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C580F6135E
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhJSV0y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhJSV0x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:53 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403D3C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n40-20020a05600c3ba800b0030da2439b21so5702512wms.0
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IAXLMKPgeBuYZroDLDZ6OvkIHJ1cntN48XfYtV9uC1M=;
        b=j2iELNjZLdpH2n/Ap/lzwkX1uRhJf6xbx4JVzMX3qoVHCRcwgoqRR6NNxL5ay8xE/z
         cj02VUt7zAFEGBE7W6uxDPX6r5mokDoBLVrrye1MXsM71xKlWpFe1hZG68Qexu25V41E
         s2U1q8bdEgW4Tx3akfaBxNzXiwvs7IE6NhJMtk+IiGn+SCFHeOrzf1NBO/mZGX7y3Psy
         dbkfzuMIcZ82vDPdjOY2JScsJmIuzWmy4kwm+GhT0P50vMNbAwELfvg/jpMCxF987RIk
         F5NkkzQywdslOFGeYOn6zOalZXr3e9IYkV/Xz3+TZ7coglVS/ZjaIszxZqAl2+R6u915
         cYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IAXLMKPgeBuYZroDLDZ6OvkIHJ1cntN48XfYtV9uC1M=;
        b=GqrWzpX57RmuOpBtLdvB+ATvk/oZ750euyeWlb7/9iQQEXIu5GNbhLrKjsq4rM/EUs
         6KUDGL6rDYPo42fmWaKaEpGQ1CTDSVTrrasLj7PjLacVC0Yoyi7MD7fkXPmFj+ytwW3/
         BmdKCZrphwCfWc06z7bM2P5fz5Q0DzQm4dUexd29SrNbuojrZx9EI4C9DhNiR6PVsZ6U
         X90zVOcyPQxtepN6M0YUJZQTsQLKRSBWDdgKnXEgir8DmJ0+2b0s6oFtQ2jD3dEAJFo/
         mLbVwYgGqUa6zQ7fkUejdSZoYlaCq50HE+BmyvJrIz5uvZklX8hUfQESSTraRLmP2Qwa
         LJvg==
X-Gm-Message-State: AOAM531mEJ4wXH7FokSoU+/YaiesfVwoOcFx9mfymmAUG6yHiYk3H1C3
        MWFob4XJpx4RWUgCHd9QLwYW6uesmM+XVw==
X-Google-Smtp-Source: ABdhPJzkyU08n71DJAvXVtIuhVXtRdzsdhRK/Y+yF1ZsZ9SzFJVH7weQtCQJ3gqBMy/iRY2J9wp5lw==
X-Received: by 2002:a05:600c:4f92:: with SMTP id n18mr8903342wmq.22.1634678678585;
        Tue, 19 Oct 2021 14:24:38 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:38 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 07/16] blocK: move plug flush functions to blk-mq.c
Date:   Tue, 19 Oct 2021 22:24:16 +0100
Message-Id: <bb6fe6de2fe6bd69ccf9bc8af049ffedcf52bda0.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Flushing is tightly coupled with blk-mq and almost all
blk_flush_plug_list() callees are in blk-mq.c. So move the whole thing
there, so the compiler is able to apply more optimisations and inline.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-core.c       | 27 ---------------------------
 block/blk-mq.c         | 33 +++++++++++++++++++++++++++++----
 block/blk-mq.h         |  1 -
 include/linux/blk-mq.h |  2 --
 4 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 88752e51d2b6..52019b8a1487 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1595,23 +1595,6 @@ void blk_start_plug(struct blk_plug *plug)
 }
 EXPORT_SYMBOL(blk_start_plug);
 
-static void flush_plug_callbacks(struct blk_plug *plug, bool from_schedule)
-{
-	LIST_HEAD(callbacks);
-
-	while (!list_empty(&plug->cb_list)) {
-		list_splice_init(&plug->cb_list, &callbacks);
-
-		while (!list_empty(&callbacks)) {
-			struct blk_plug_cb *cb = list_first_entry(&callbacks,
-							  struct blk_plug_cb,
-							  list);
-			list_del(&cb->list);
-			cb->callback(cb, from_schedule);
-		}
-	}
-}
-
 struct blk_plug_cb *blk_check_plugged(blk_plug_cb_fn unplug, void *data,
 				      int size)
 {
@@ -1637,16 +1620,6 @@ struct blk_plug_cb *blk_check_plugged(blk_plug_cb_fn unplug, void *data,
 }
 EXPORT_SYMBOL(blk_check_plugged);
 
-void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
-{
-	flush_plug_callbacks(plug, from_schedule);
-
-	if (!rq_list_empty(plug->mq_list))
-		blk_mq_flush_plug_list(plug, from_schedule);
-	if (unlikely(!from_schedule && plug->cached_rq))
-		blk_mq_free_plug_rqs(plug);
-}
-
 /**
  * blk_finish_plug - mark the end of a batch of submitted I/O
  * @plug:	The &struct blk_plug passed to blk_start_plug()
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 218bfaa98591..6bdbaa838030 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -604,7 +604,7 @@ void blk_mq_free_request(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
-void blk_mq_free_plug_rqs(struct blk_plug *plug)
+static void blk_mq_free_plug_rqs(struct blk_plug *plug)
 {
 	struct request *rq;
 
@@ -2199,15 +2199,13 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 		blk_mq_commit_rqs(hctx, &queued, from_schedule);
 }
 
-void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
+static void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_hw_ctx *this_hctx;
 	struct blk_mq_ctx *this_ctx;
 	unsigned int depth;
 	LIST_HEAD(list);
 
-	if (rq_list_empty(plug->mq_list))
-		return;
 	plug->rq_count = 0;
 
 	if (!plug->multiple_queues && !plug->has_elevator) {
@@ -2249,6 +2247,33 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	}
 }
 
+static void flush_plug_callbacks(struct blk_plug *plug, bool from_schedule)
+{
+	LIST_HEAD(callbacks);
+
+	while (!list_empty(&plug->cb_list)) {
+		list_splice_init(&plug->cb_list, &callbacks);
+
+		while (!list_empty(&callbacks)) {
+			struct blk_plug_cb *cb = list_first_entry(&callbacks,
+							  struct blk_plug_cb,
+							  list);
+			list_del(&cb->list);
+			cb->callback(cb, from_schedule);
+		}
+	}
+}
+
+void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
+{
+	flush_plug_callbacks(plug, from_schedule);
+
+	if (!rq_list_empty(plug->mq_list))
+		blk_mq_flush_plug_list(plug, from_schedule);
+	if (unlikely(!from_schedule && plug->cached_rq))
+		blk_mq_free_plug_rqs(plug);
+}
+
 static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 		unsigned int nr_segs)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index ebf67f4d4f2e..bab40688e59b 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -121,7 +121,6 @@ extern int __blk_mq_register_dev(struct device *dev, struct request_queue *q);
 extern int blk_mq_sysfs_register(struct request_queue *q);
 extern void blk_mq_sysfs_unregister(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
-void blk_mq_free_plug_rqs(struct blk_plug *plug);
 
 void blk_mq_release(struct request_queue *q);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 6cf35de151a9..e13780236550 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -656,8 +656,6 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
 		unsigned int set_flags);
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
 
-void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule);
-
 void blk_mq_free_request(struct request *rq);
 
 bool blk_mq_queue_inflight(struct request_queue *q);
-- 
2.33.1

