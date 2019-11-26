Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD89FC432C3
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 17:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984A520678
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 17:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKZR5I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:57:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41186 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfKZR5H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 12:57:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id t8so8409561plr.8
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2019 09:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9tHZCi3NoBcxdk0wnNtr+GI/gJFOUJ2God40o2P9nxY=;
        b=Pn2j94X14kUHr7kz3npkpQT3RVLV4arObUq+B2K3dBpqoMPtuGAOXwcbUgDdXd+X9H
         p/u8qYsOuq81YD129YxypvkwsM0bIwRjdf1+FzFWB5v/nUWafx/yKCa7rheYqGekBYOh
         WcaFB4FNN5HV+e25YENP8bvYn9nZwNAqSijRih/LO+1stFIU+KwlC3/JcvbeOnA1HvYp
         ASRJ2zOxxGZ4q7Ud3QVZ7YSk2QvZtXP8NAgxZ25bfG7C04GHYQoZBFoeR0C8pWPdIjmR
         fQLjdoSdjLC+zTF+GLDY7UIPjYOXkgWlMa/YpQQDz3FrsBu1SFoaxyv3hAEWPiNuQSK2
         QWQQ==
X-Gm-Message-State: APjAAAVUBOfERMoVWZe6vbXKAJoVIE9R36Er1Twmtle1XXZL81m2iSM9
        X1vI8Sh6ELxIbPbWNYIy4UU=
X-Google-Smtp-Source: APXvYqwdaAqhai3oa+tBNYnXVvVVhObp940ZPbC4DfaGMu6WZOk6ZAsPKSdpUJ3IKSQeQ1u+40WRmA==
X-Received: by 2002:a17:90a:195e:: with SMTP id 30mr425932pjh.60.1574791027311;
        Tue, 26 Nov 2019 09:57:07 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 82sm13178715pfa.115.2019.11.26.09.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 09:57:06 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 1/3] blk-mq: Remove some unused function arguments
Date:   Tue, 26 Nov 2019 09:56:54 -0800
Message-Id: <20191126175656.67638-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191126175656.67638-1-bvanassche@acm.org>
References: <20191126175656.67638-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: John Garry <john.garry@huawei.com>

The hardware queue argument in blk_mq_put_tag(), blk_mq_poll_nsecs(), and
blk_mq_poll_hybrid_sleep() is unused, so remove it.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
[ bvanassche: edited patch description ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-tag.c |  4 ++--
 block/blk-mq-tag.h |  3 +--
 block/blk-mq.c     | 10 ++++------
 block/blk-mq.h     |  2 +-
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index fbacde454718..586c9d6e904a 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -183,8 +183,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	return tag + tag_offset;
 }
 
-void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags,
-		    struct blk_mq_ctx *ctx, unsigned int tag)
+void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
+		    unsigned int tag)
 {
 	if (!blk_mq_tag_is_reserved(tags, tag)) {
 		const int real_tag = tag - tags->nr_reserved_tags;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 15bc74acb57e..d0c10d043891 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -26,8 +26,7 @@ extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsigned int r
 extern void blk_mq_free_tags(struct blk_mq_tags *tags);
 
 extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
-extern void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags,
-			   struct blk_mq_ctx *ctx, unsigned int tag);
+extern void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx, unsigned int tag);
 extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 323c9cb28066..fec4b82ff91c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -477,9 +477,9 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
 	if (rq->tag != -1)
-		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
+		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
-		blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
+		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
 	blk_queue_exit(q);
 }
@@ -3340,7 +3340,6 @@ static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb)
 }
 
 static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
-				       struct blk_mq_hw_ctx *hctx,
 				       struct request *rq)
 {
 	unsigned long ret = 0;
@@ -3373,7 +3372,6 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 }
 
 static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
-				     struct blk_mq_hw_ctx *hctx,
 				     struct request *rq)
 {
 	struct hrtimer_sleeper hs;
@@ -3393,7 +3391,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	if (q->poll_nsec > 0)
 		nsecs = q->poll_nsec;
 	else
-		nsecs = blk_mq_poll_nsecs(q, hctx, rq);
+		nsecs = blk_mq_poll_nsecs(q, rq);
 
 	if (!nsecs)
 		return false;
@@ -3448,7 +3446,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 			return false;
 	}
 
-	return blk_mq_poll_hybrid_sleep(q, hctx, rq);
+	return blk_mq_poll_hybrid_sleep(q, rq);
 }
 
 /**
diff --git a/block/blk-mq.h b/block/blk-mq.h
index eaaca8fc1c28..ba37cd64894c 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -199,7 +199,7 @@ static inline bool blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx *hctx)
 static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 					   struct request *rq)
 {
-	blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
+	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
 	rq->tag = -1;
 
 	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
