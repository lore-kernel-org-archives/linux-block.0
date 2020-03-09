Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C731C10F25
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 20:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69B324654
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 20:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLCLMpFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgCIU76 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:59:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32785 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgCIU76 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 16:59:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id p62so10756984qkb.0
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 13:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lWpcsdSXYANgkq+KXz0TQHKWp+VA9aYVcM8PpNQi+1c=;
        b=JLCLMpFlScIL0GY5jhV9T/f1BtZ5A8LxwcUcjNlXzyvA3jhdzuQKYGrWoZkZL2Tt5A
         MkfzQYxogyWxvUMVQpQdi+k0YhbveYJS9KaPfqBKaTVGN0gGJMFjYNF3rB+r3+rF2KWT
         beWKCNVzxtXONBB5VAB4xjd7Y/xf1nT92c76qEIvht7ppJWp6cz0loQlSmKcrC0LynLd
         wczQskHEN+Nq0FrLgGv5hhaTbb7lzAS7LDW2FjJxBVvARK6kA1nrdqswkAry8a5XaePx
         yK/edweb42TxA0Ak5BnpnnKIeLJ0b8xrciefBDRd4KvuE5Y0UQcmJShfnZOclLhysKqt
         bhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lWpcsdSXYANgkq+KXz0TQHKWp+VA9aYVcM8PpNQi+1c=;
        b=Tmrbt13l5FZn24YojauAJJClnmL8FVuHy2RixfnWR6hi2qAAj+eeYTnOJ83YCXAUeu
         PrVgUq9uwtIURTslDwe4crxAykGo4yY5jEAAAMCtI8U2QTeHy7boIfHQFO+w8SZYNb9U
         JKY4gnVDqdX8/J488IlPwMTp+H4xNmeNaN1iOE1G81u9QgSjJA1tWxGhfr2Uw0ZCtvHt
         D1LyKMefa/iNhnWndvA3nlSwSp3dLrq0rmqXlmMHzetlhcWLIApXTUa90f/PIrn4KuVG
         YAMFzfdiWPY9s/JKcBLI1toS6zbVM7n0ajSnsaVIyNzgFdUOk7qObL5MUsl3SmkCmrp/
         uBpw==
X-Gm-Message-State: ANhLgQ2xft6PKsXLK6IhlHJi84pVbuiDewthH1Be++fERB0ruHsD6wJD
        ulPRCPjsDKrzlwihhQLfwSHGFVU4WFM=
X-Google-Smtp-Source: ADFU+vtQriOtTh5NWx8OI4AEJAql8WCGsG9ua2biGP28c8AW2/AfISygwgWG9Y4lS1TJuDPKrtbo3w==
X-Received: by 2002:a05:620a:2046:: with SMTP id d6mr16916869qka.174.1583787596313;
        Mon, 09 Mar 2020 13:59:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4078])
        by smtp.gmail.com with ESMTPSA id b8sm16198526qte.52.2020.03.09.13.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:59:55 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, mmullins@fb.com, josef@toxicpanda.com,
        Jes Sorensen <jsorensen@fb.com>
Subject: [PATCH 5/7] blk-mq: Only allocate request stat data when it is enabled
Date:   Mon,  9 Mar 2020 16:59:29 -0400
Message-Id: <20200309205931.24256-6-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
References: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

This reduces the data used for request stats to two pointers in
struct request_queue, when this is not enabled.

Signed-off-by: Jes Sorensen <jsorensen@fb.com>
---
 block/blk-mq.c         | 20 ++++++++++----------
 block/blk-stat.h       |  2 ++
 block/blk-sysfs.c      | 36 ++++++++++++++++++++++++++++++++----
 include/linux/blkdev.h |  2 +-
 4 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4aff0903546c..04652e59b0e9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -63,7 +63,7 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
 /*
  * 8 buckets for each of read, write, and discard
  */
-static int blk_req_stats_bkt(const struct request *rq)
+int blk_req_stats_bkt(const struct request *rq)
 {
 	int grp, bucket;
 
@@ -82,7 +82,7 @@ static int blk_req_stats_bkt(const struct request *rq)
 /*
  * Copy out the stats to their official location
  */
-static void blk_req_stats_cb(struct blk_stat_callback *cb)
+void blk_req_stats_cb(struct blk_stat_callback *cb)
 {
 	struct request_queue *q = cb->data;
 	int bucket;
@@ -102,8 +102,14 @@ static void blk_req_stats_cb(struct blk_stat_callback *cb)
 
 void blk_req_stats_free(struct request_queue *q)
 {
-	blk_stat_remove_callback(q, q->reqstat_cb);
-	blk_stat_free_callback(q->reqstat_cb);
+	if (test_bit(QUEUE_FLAG_REQSTATS, &q->queue_flags)) {
+		blk_stat_remove_callback(q, q->reqstat_cb);
+		blk_queue_flag_clear(QUEUE_FLAG_REQSTATS, q);
+		blk_stat_free_callback(q->reqstat_cb);
+		q->reqstat_cb = NULL;
+		kfree(q->req_stat);
+		q->req_stat = NULL;
+	}
 }
 
 /*
@@ -2956,12 +2962,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
 
-	q->reqstat_cb = blk_stat_alloc_callback(blk_req_stats_cb,
-						blk_req_stats_bkt,
-						BLK_REQ_STATS_BKTS, q);
-	if (!q->reqstat_cb)
-		goto err_hctxs;
-
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
diff --git a/block/blk-stat.h b/block/blk-stat.h
index e592bbf50d38..d23090b53e12 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -168,5 +168,7 @@ void blk_rq_stat_add(struct blk_rq_stat *, u64, u64);
 void blk_rq_stat_sum(struct blk_rq_stat *, struct blk_rq_stat *);
 void blk_rq_stat_init(struct blk_rq_stat *);
 
+int blk_req_stats_bkt(const struct request *rq);
+void blk_req_stats_cb(struct blk_stat_callback *cb);
 void blk_req_stats_free(struct request_queue *q);
 #endif
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index aeb69c57ffb7..b1469b3ce511 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -16,6 +16,7 @@
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
 #include "blk-wbt.h"
+#include "blk-stat.h"
 
 struct queue_sysfs_entry {
 	struct attribute attr;
@@ -534,6 +535,9 @@ static ssize_t queue_stat_show(struct request_queue *q, char *p)
 	char name[3][8] = {"read", "write", "discard"};
 	int bkt, off, i;
 
+	if (!q->req_stat)
+		return -ENODEV;
+
 	off = 0;
 	for (i = 0; i < 3; i++) {
 		off += sprintf(p + off, "%s: ", name[i]);
@@ -571,18 +575,42 @@ static ssize_t queue_reqstat_store(struct request_queue *q, const char *page,
 		return ret;
 
 	if (reqstat_on) {
+		if (!q->req_stat) {
+			q->req_stat = kcalloc(BLK_REQ_STATS_BKTS,
+					      sizeof(struct blk_rq_stat),
+					      GFP_KERNEL);
+			if (!q->req_stat) {
+				ret = -ENOMEM;
+				goto err_out;
+			}
+			q->reqstat_cb =
+				blk_stat_alloc_callback(blk_req_stats_cb,
+							blk_req_stats_bkt,
+							BLK_REQ_STATS_BKTS,
+							q);
+			if (!q->reqstat_cb) {
+				ret = -ENOMEM;
+				goto err_out;
+			}
+		}
 		if (!blk_queue_flag_test_and_set(QUEUE_FLAG_REQSTATS, q))
 			blk_stat_add_callback(q, q->reqstat_cb);
 		if (!blk_stat_is_active(q->reqstat_cb))
 			blk_stat_activate_msecs(q->reqstat_cb, 100);
 	} else {
-		if (test_bit(QUEUE_FLAG_REQSTATS, &q->queue_flags)) {
-			blk_stat_remove_callback(q, q->reqstat_cb);
-			blk_queue_flag_clear(QUEUE_FLAG_REQSTATS, q);
-		}
+		blk_req_stats_free(q);
 	}
 
+ out:
 	return ret;
+ err_out:
+	if (q->reqstat_cb) {
+		blk_stat_free_callback(q->reqstat_cb);
+		q->reqstat_cb = NULL;
+	}
+	kfree(q->req_stat);
+	q->req_stat = NULL;
+	goto out;
 }
 
 static struct queue_sysfs_entry queue_requests_entry = {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 58abab51ed9f..1731c4ec4d34 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -484,7 +484,7 @@ struct request_queue {
 	struct blk_rq_stat	poll_stat[BLK_MQ_POLL_STATS_BKTS];
 
 	struct blk_stat_callback	*reqstat_cb;
-	struct blk_rq_stat	req_stat[BLK_REQ_STATS_BKTS];
+	struct blk_rq_stat	*req_stat;
 
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
-- 
2.17.1

