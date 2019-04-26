Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889D1C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5532920878
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlpxipRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfDZAVW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:21:22 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36393 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfDZAVW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 20:21:22 -0400
Received: by mail-yb1-f196.google.com with SMTP id e76so675359ybc.3
        for <linux-block@vger.kernel.org>; Thu, 25 Apr 2019 17:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VnJO5Y4pDdKSbJZjy4lN6QclYi9c5ZuXMxvcyYdIjs=;
        b=OlpxipRwi1+2ScB4jzV3bi07wBHuQhPzlnPv6M3G5EmoxC5Wj06yV6Eo7ixlKUATPx
         C5zXX7xPKsjwnI2PCPRWWA+ZA28R8A8J0zq1GHRSzR3Mzmqaz70qgpImH+fI50PKoV6J
         hEQh635htBhquqTApNrBsCXjxlyxcy7zIaGuufgzqZphVjVHJCpbJtynwj5WgOE7YSpr
         0qiZZSKBTWJHt6a7YMQZHut4JUmtXa2GD6MKCAtr3OFnULApGBjd5wpqFdjK3xuvsrVL
         6YH5WOphUbL8HMEU3qQlP0AQUa+ZH0lLrkEe0HYstSddVwDqfnSBKcfitBR1r/cafoQa
         4kGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VnJO5Y4pDdKSbJZjy4lN6QclYi9c5ZuXMxvcyYdIjs=;
        b=TxiYRbUAGfgB8M+LKT9ptIdWl0Ry1VmrynAfc1ascQLUTysktZ6WySwb6jmfhq+xBv
         /VNbR31RIfTwgotbjOUrQkP4IS0B8rriAR3hw1A1hp8BAdDI8ZGo8rODc+KPr1HWtko7
         oTQHjYonJbj1GmB3iqYjhQVS+77E9BioD3HA112sE7oGZN1gEA8dE36UlJe3xi1kZi+g
         8mtz7fo2+eQI5QVHcJQakn5BGLANHs9fpZe9nwKmBRH1MYTQDHUWQppbMWN/jdGbhQwV
         OO+7U0Mk5T4s3u6K+PPI60kNQP5W1erFT2ds4fkO2JeZzVMm0V8JJNrOxkYfnO7a3nZ/
         nOIw==
X-Gm-Message-State: APjAAAUJIPBelVzbUw2VmdyJk0RK9iAOCMUwG7BYIBqh46jUfXQD4CtB
        nIoOghYQHcvXaT6QBV7Z2rUChqJm
X-Google-Smtp-Source: APXvYqwtXtNX6vRnIE271WgyOLzGrVmEEnuqupirymIbrnD3S+wsIIN/FJooScAaNkykDpJq8XQ+fw==
X-Received: by 2002:a25:3554:: with SMTP id c81mr33447317yba.498.1556238080606;
        Thu, 25 Apr 2019 17:21:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::5484])
        by smtp.gmail.com with ESMTPSA id h204sm25964134ywh.110.2019.04.25.17.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 17:21:20 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     josef@toxicpanda.com, kernel-team@fb.com
Subject: [PATCH 2/5] block: keep track of per-device io sizes in stats
Date:   Thu, 25 Apr 2019 20:20:47 -0400
Message-Id: <20190426002050.15499-3-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426002050.15499-1-Jes.Sorensen@gmail.com>
References: <20190426002050.15499-1-Jes.Sorensen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

In order to track things like bw we need to know the number of bytes
done per device.  Add a io_bytes field to the struct request and
populate this at start time.  Add a field to the blk_rq_stat to hold
this information so that consumers of the blk_rq_stat stuff can use it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c     |  2 +-
 block/blk-mq.c            |  4 +---
 block/blk-stat.c          | 14 ++++++++------
 block/blk-stat.h          |  2 +-
 block/blk-throttle.c      |  3 ++-
 include/linux/blk_types.h |  1 +
 include/linux/blkdev.h    |  5 ++---
 7 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 507212d75ee2..8e547958cc1b 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -218,7 +218,7 @@ static inline void latency_stat_record_time(struct iolatency_grp *iolat,
 			stat->ps.missed++;
 		stat->ps.total++;
 	} else
-		blk_rq_stat_add(&stat->rqs, req_time);
+		blk_rq_stat_add(&stat->rqs, req_time, 0);
 	put_cpu_ptr(stat);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 65f628652b1e..e8cd2028745a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -677,9 +677,7 @@ void blk_mq_start_request(struct request *rq)
 
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
 		rq->io_start_time_ns = ktime_get_ns();
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-		rq->throtl_size = blk_rq_sectors(rq);
-#endif
+		rq->io_bytes = blk_rq_bytes(rq);
 		rq->rq_flags |= RQF_STATS;
 		rq_qos_issue(q, rq);
 	}
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 8a40ac719ba7..d718983bed5c 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -21,7 +21,7 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
 {
 	stat->min = -1ULL;
 	stat->max = stat->nr_samples = stat->mean = 0;
-	stat->time = 0;
+	stat->size = stat->time = 0;
 }
 
 /* src is a per-cpu stat, mean isn't initialized */
@@ -37,13 +37,15 @@ void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 				dst->nr_samples + src->nr_samples);
 
 	dst->nr_samples += src->nr_samples;
+	dst->size += src->size;
 }
 
-void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
+void blk_rq_stat_add(struct blk_rq_stat *stat, u64 time, u64 size)
 {
-	stat->min = min(stat->min, value);
-	stat->max = max(stat->max, value);
-	stat->time += value;
+	stat->min = min(stat->min, time);
+	stat->max = max(stat->max, time);
+	stat->time += time;
+	stat->size += size;
 	stat->nr_samples++;
 }
 
@@ -69,7 +71,7 @@ void blk_stat_add(struct request *rq, u64 now)
 			continue;
 
 		stat = &get_cpu_ptr(cb->cpu_stat)[bucket];
-		blk_rq_stat_add(stat, value);
+		blk_rq_stat_add(stat, value, rq->io_bytes);
 		put_cpu_ptr(cb->cpu_stat);
 	}
 	rcu_read_unlock();
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 17b47a86eefb..ea893c4a9af1 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -164,7 +164,7 @@ static inline void blk_stat_activate_msecs(struct blk_stat_callback *cb,
 	mod_timer(&cb->timer, jiffies + msecs_to_jiffies(msecs));
 }
 
-void blk_rq_stat_add(struct blk_rq_stat *, u64);
+void blk_rq_stat_add(struct blk_rq_stat *, u64, u64);
 void blk_rq_stat_sum(struct blk_rq_stat *, struct blk_rq_stat *);
 void blk_rq_stat_init(struct blk_rq_stat *);
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 1b97a73d2fb1..b07e5feda553 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2248,8 +2248,9 @@ void blk_throtl_stat_add(struct request *rq, u64 time_ns)
 {
 	struct request_queue *q = rq->q;
 	struct throtl_data *td = q->td;
+	sector_t size = rq->io_bytes >> SECTOR_SHIFT;
 
-	throtl_track_latency(td, rq->throtl_size, req_op(rq), time_ns >> 10);
+	throtl_track_latency(td, size, req_op(rq), time_ns >> 10);
 }
 
 void blk_throtl_bio_endio(struct bio *bio)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index df24baf455c2..eb64361bc2a5 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -447,6 +447,7 @@ struct blk_rq_stat {
 	u64 max;
 	u32 nr_samples;
 	u64 time;
+	u64 size;
 };
 
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 317ab30d2904..a2291b1d1cb0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -198,13 +198,12 @@ struct request {
 	u64 start_time_ns;
 	/* Time that I/O was submitted to the device. */
 	u64 io_start_time_ns;
+	/* Bytes submitted to the device. */
+	unsigned int io_bytes;
 
 #ifdef CONFIG_BLK_WBT
 	unsigned short wbt_flags;
 #endif
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	unsigned short throtl_size;
-#endif
 
 	/*
 	 * Number of scatter-gather DMA addr+len pairs after
-- 
2.17.1

