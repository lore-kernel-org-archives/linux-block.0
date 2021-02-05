Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9807C433DB
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 17:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E09C64EF0
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 17:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhBEP3D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 10:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbhBEP1Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Feb 2021 10:27:16 -0500
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB371C0617A7
        for <linux-block@vger.kernel.org>; Fri,  5 Feb 2021 08:58:44 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id m4so6945347ejc.14
        for <linux-block@vger.kernel.org>; Fri, 05 Feb 2021 08:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=4GtWCwQDeimvfkN1mTaSptGywDj7eww9UKGtvZYIBUg=;
        b=KBklsWedQU4WWmG49UKX496WNk8xQGJXnMQCKxME7lEcweuC3XA0fTMug2U9c8htls
         2c++B32BAC1MtXZo6OZjeHeOFZ90sT5JzwAbZwjtZM23BcbfMBEDUhKcH3Eo/LpIuzKm
         4wO2OrG5iyTZ+H4nQDjcePBPjpv1CBp8AvOiZyWQ4sJK10khL4FY9ERkg96LxoLSNzQy
         RlvTjuSB61dpR8aCxO9crcD6BTIZ1RdjWWulg1OvWVSiYD4JhbxMJuB1ooMwL4gxuaJM
         RcSD3HGmSkmx7pB+WRYezM+yeaJKpFC23Z1xOeQQOjae9LYy9OwS6eKpRR6qodl5sB9S
         cAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=4GtWCwQDeimvfkN1mTaSptGywDj7eww9UKGtvZYIBUg=;
        b=ZZQQGgHxVk9L0xxr1HbvDhCq3FkdsyaxnHx/HC29NSr7BWj5B7P2O0GG4HDVYHyb2P
         cxyEuEx7kh84ruYtbiiA+IzH39POk1Sysr7DVtuA43rW5/d7xu1Fg3rC2W+l/wzcDPRK
         amdfJwW+dyMOkENgdN1py+IXNdkm8jQdxf8dHk6eT/6rPq/KydIoQdbfA5ocvWAphRF1
         6Yd+wOGJ5t7AwFi0NVE/1tw9P8LFr23/XnWWc81iXK+SUrhLOfY+SINmZ8u3nK0n8MBd
         rS78zsAjhA4zV+1LOx7HVYUND3Ib98jGPNM7zB3uRsi9Ly8Mlnzqe4NE0jgfoslaLese
         K5wA==
X-Gm-Message-State: AOAM53397mVbPFuV53EvSY2BZe6N57k1iGqIGSoXC4YTVF161b1ibVrA
        DoGnZpvK1RYXXy9ha3PyvNx9jYoxaA==
X-Google-Smtp-Source: ABdhPJyg+Z53MiQXPBUdbUaO+0V+VxVmGSyDZvALt8fHclQXS0owRQ1TA0F83a2RbOjfnAR1jb/VTUBYPw==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:c86d:8e60:951e:3880])
 (user=elver job=sendgmr) by 2002:a50:e14d:: with SMTP id i13mr2777193edl.106.1612544323216;
 Fri, 05 Feb 2021 08:58:43 -0800 (PST)
Date:   Fri,  5 Feb 2021 17:58:35 +0100
Message-Id: <20210205165835.821714-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH] blk-mq-debugfs: mark concurrent stats counters as data races
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        syzbot+2c308b859c8c103aae53@syzkaller.appspotmail.com,
        syzbot+44f9b37d2de57637dbfd@syzkaller.appspotmail.com,
        syzbot+49a9bcf457723ecaf1cf@syzkaller.appspotmail.com,
        syzbot+b9914ed52d5b1d63f71d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

KCSAN reports that several of the blk-mq debugfs stats counters are
updated concurrently. Because blk-mq-debugfs does not demand precise
stats counters, potential lossy updates due to data races can be
tolerated. Therefore, mark and comment the accesses accordingly.

Reported-by: syzbot+2c308b859c8c103aae53@syzkaller.appspotmail.com
Reported-by: syzbot+44f9b37d2de57637dbfd@syzkaller.appspotmail.com
Reported-by: syzbot+49a9bcf457723ecaf1cf@syzkaller.appspotmail.com
Reported-by: syzbot+b9914ed52d5b1d63f71d@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
---
Note: These 4 data races are among the most frequently encountered by
syzbot:

  https://syzkaller.appspot.com/bug?id=7994761095b9677fb8bccaf41a77a82d5f444839
  https://syzkaller.appspot.com/bug?id=08193ca23b80ec0e9bcbefba039162cff4f5d7a3
  https://syzkaller.appspot.com/bug?id=7c51c15438f963024c4a4b3a6d7e119f4bdb2199
  https://syzkaller.appspot.com/bug?id=6436cb57d04e8c5d6f0f40926d7511232aa2b5d4
---
 block/blk-mq-debugfs.c | 22 ++++++++++++----------
 block/blk-mq-sched.c   |  3 ++-
 block/blk-mq.c         |  9 ++++++---
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4de03da9a624..687d201f0d7b 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -554,15 +554,16 @@ static int hctx_dispatched_show(void *data, struct seq_file *m)
 	struct blk_mq_hw_ctx *hctx = data;
 	int i;
 
-	seq_printf(m, "%8u\t%lu\n", 0U, hctx->dispatched[0]);
+	seq_printf(m, "%8u\t%lu\n", 0U, data_race(hctx->dispatched[0]));
 
 	for (i = 1; i < BLK_MQ_MAX_DISPATCH_ORDER - 1; i++) {
 		unsigned int d = 1U << (i - 1);
 
-		seq_printf(m, "%8u\t%lu\n", d, hctx->dispatched[i]);
+		seq_printf(m, "%8u\t%lu\n", d, data_race(hctx->dispatched[i]));
 	}
 
-	seq_printf(m, "%8u+\t%lu\n", 1U << (i - 1), hctx->dispatched[i]);
+	seq_printf(m, "%8u+\t%lu\n", 1U << (i - 1),
+		   data_race(hctx->dispatched[i]));
 	return 0;
 }
 
@@ -573,7 +574,7 @@ static ssize_t hctx_dispatched_write(void *data, const char __user *buf,
 	int i;
 
 	for (i = 0; i < BLK_MQ_MAX_DISPATCH_ORDER; i++)
-		hctx->dispatched[i] = 0;
+		data_race(hctx->dispatched[i] = 0);
 	return count;
 }
 
@@ -581,7 +582,7 @@ static int hctx_queued_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
 
-	seq_printf(m, "%lu\n", hctx->queued);
+	seq_printf(m, "%lu\n", data_race(hctx->queued));
 	return 0;
 }
 
@@ -590,7 +591,7 @@ static ssize_t hctx_queued_write(void *data, const char __user *buf,
 {
 	struct blk_mq_hw_ctx *hctx = data;
 
-	hctx->queued = 0;
+	data_race(hctx->queued = 0);
 	return count;
 }
 
@@ -598,7 +599,7 @@ static int hctx_run_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
 
-	seq_printf(m, "%lu\n", hctx->run);
+	seq_printf(m, "%lu\n", data_race(hctx->run));
 	return 0;
 }
 
@@ -607,7 +608,7 @@ static ssize_t hctx_run_write(void *data, const char __user *buf, size_t count,
 {
 	struct blk_mq_hw_ctx *hctx = data;
 
-	hctx->run = 0;
+	data_race(hctx->run = 0);
 	return count;
 }
 
@@ -702,7 +703,8 @@ static int ctx_completed_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_ctx *ctx = data;
 
-	seq_printf(m, "%lu %lu\n", ctx->rq_completed[1], ctx->rq_completed[0]);
+	seq_printf(m, "%lu %lu\n", data_race(ctx->rq_completed[1]),
+		   data_race(ctx->rq_completed[0]));
 	return 0;
 }
 
@@ -711,7 +713,7 @@ static ssize_t ctx_completed_write(void *data, const char __user *buf,
 {
 	struct blk_mq_ctx *ctx = data;
 
-	ctx->rq_completed[0] = ctx->rq_completed[1] = 0;
+	data_race(ctx->rq_completed[0] = ctx->rq_completed[1] = 0);
 	return count;
 }
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index deff4e826e23..71a49835e89a 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -332,7 +332,8 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
 		return;
 
-	hctx->run++;
+	/* data race ok: hctx->run only for debugfs stats. */
+	data_race(hctx->run++);
 
 	/*
 	 * A return of -EAGAIN is an indication that hctx->dispatch is not
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f285a9123a8b..1d8970602032 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -341,7 +341,8 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		}
 	}
 
-	data->hctx->queued++;
+	/* data race ok: hctx->queued only for debugfs stats. */
+	data_race(data->hctx->queued++);
 	return rq;
 }
 
@@ -519,7 +520,8 @@ void blk_mq_free_request(struct request *rq)
 		}
 	}
 
-	ctx->rq_completed[rq_is_sync(rq)]++;
+	/* data race ok: ctx->rq_completed only for debugfs stats. */
+	data_race(ctx->rq_completed[rq_is_sync(rq)]++);
 	if (rq->rq_flags & RQF_MQ_INFLIGHT)
 		__blk_mq_dec_active_requests(hctx);
 
@@ -1419,7 +1421,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	if (!list_empty(&zone_list))
 		list_splice_tail_init(&zone_list, list);
 
-	hctx->dispatched[queued_to_index(queued)]++;
+	/* data race ok: hctx->dispatched only for debugfs stats. */
+	data_race(hctx->dispatched[queued_to_index(queued)]++);
 
 	/* If we didn't flush the entire list, we could have told the driver
 	 * there was more coming, but that turned out to be a lie.

base-commit: 61556703b610a104de324e4f061dc6cf7b218b46
-- 
2.30.0.365.g02bc693789-goog

