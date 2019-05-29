Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B02C28CC0
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 22:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9AEF2075B
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 22:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSC1wzE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfE2WHs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 18:07:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32888 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfE2WHs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 18:07:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id p18so2600553qkk.0
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 15:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qrus7QZ35WA+MxFTB0AjMZCycakXn4RQRxL/2BhJBT8=;
        b=OSC1wzE3v04f0GsI20XJ0iK9qjMrYbreifGSlhGSi5DCvqwBda4vi+Ayuxg9bsBQm8
         MHVyXm4hm8wf2enutb3FLSehlcDuqSJPpF5v2NcK9Ht3HYh3j1ZtYK626q/HFH4evkda
         KNbrpiAmEWgOqTgu8XQTs1UCV1fJD/YauTwu0+rzHgN/D0fuST1pglRTiDQHmU108mzg
         VMqWxeEJJbP5Sa+Ul8gmGNk7pxzRPY/ijXVGWj75suu9R1QYQh6U5vMOn0OS2W3SZAVV
         jl9PsapQ0xcaZRD0siI0fCU88c63kPBxiw1eRT/tX6BgCczi11ws0vSox2bALgExv82S
         MX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qrus7QZ35WA+MxFTB0AjMZCycakXn4RQRxL/2BhJBT8=;
        b=QFWGPJkIZXbUa3lPSlC9+l9uo36D8cvodNT2VWEsj00JdWFIxbS3Lp2otTk4wZWPpU
         srcWdMNqp9EskK2+JfUZ+DjDSMEj/CTDrKthCT3ucwewgZr/4hOB3/xaQOVwNWrG61sQ
         PLOjQfGel9PNd8ZlGlcJZkQLO/sTzgU0vZoSF/ljYKlsBM0+i0tZKu8Ks8spF4agkMkt
         24FHWQTB9RA78QG2pmDWWjkPFZH9rMNNDDzUorEnxEZ9ozXArsHBvC6fYiAzkEH6ArWf
         ctqrslPM/Id6tCrpT6Rf/vuBUG2UY0QBmCPRvECJ9M11c7C/lxMdczG2XdlL3U9Mmv/2
         ikrg==
X-Gm-Message-State: APjAAAXDvCB7G19IhthhzlcFsMns8SpZIccBrvdTzijjTHyWmna9TOj1
        U+PVnt8fbpWvmQPpItjdycMFM5xk
X-Google-Smtp-Source: APXvYqxKYtNDe5qiu9clmCeX989A0zXbECRRt1+QSgQcavvQTgNGU1iAtiZcrvEI6PUHS/F3aGJxeQ==
X-Received: by 2002:a37:9b01:: with SMTP id d1mr173529qke.46.1559167666202;
        Wed, 29 May 2019 15:07:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:60e4])
        by smtp.gmail.com with ESMTPSA id w48sm380095qtb.91.2019.05.29.15.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 15:07:45 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, jbacik@toxicpanda.com, kernel-team@fb.com
Subject: [PATCH 2/5] block: keep track of per-device io sizes in stats
Date:   Wed, 29 May 2019 18:07:27 -0400
Message-Id: <20190529220730.28014-3-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529220730.28014-1-Jes.Sorensen@gmail.com>
References: <20190529220730.28014-1-Jes.Sorensen@gmail.com>
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
index d22e61bced86..51cb82c07912 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -219,7 +219,7 @@ static inline void latency_stat_record_time(struct iolatency_grp *iolat,
 			stat->ps.missed++;
 		stat->ps.total++;
 	} else
-		blk_rq_stat_add(&stat->rqs, req_time);
+		blk_rq_stat_add(&stat->rqs, req_time, 0);
 	put_cpu_ptr(stat);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ce0f5f4ede70..8a59bc0410a6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -679,9 +679,7 @@ void blk_mq_start_request(struct request *rq)
 
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
index 1529f22044bd..0c6942f8b141 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -22,7 +22,7 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
 {
 	stat->min = -1ULL;
 	stat->max = stat->nr_samples = stat->mean = 0;
-	stat->time = 0;
+	stat->size = stat->time = 0;
 }
 
 /* src is a per-cpu stat, mean isn't initialized */
@@ -38,13 +38,15 @@ void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
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
 
@@ -70,7 +72,7 @@ void blk_stat_add(struct request *rq, u64 now)
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
index 6406430c517a..b85b27eb52b4 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -443,6 +443,7 @@ struct blk_rq_stat {
 	u64 max;
 	u32 nr_samples;
 	u64 time;
+	u64 size;
 };
 
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 592669bcc536..2716f239b56d 100644
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

