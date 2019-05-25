Return-Path: <SRS0=ocky=TZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B73C07542
	for <linux-block@archiver.kernel.org>; Sat, 25 May 2019 13:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F3D2133D
	for <linux-block@archiver.kernel.org>; Sat, 25 May 2019 13:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0UZ0sRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfEYNnS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 May 2019 09:43:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43794 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfEYNnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 May 2019 09:43:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id u27so9062414lfg.10;
        Sat, 25 May 2019 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a/Y318CkZymzIlMzWgGzv6jyPfrfZdPfCWw3//kk9h0=;
        b=P0UZ0sRfKkURFbJafh4VfNm4wTZHFvuFsFAhxdu9kM5Z/hDr8Y2VWBPLFCKgcPDGNb
         /mj6ajHJAvi6XmSdtLA/DIUW6E0bwGv60t7FXoEUVxe0JEFcdA36bflI6osJYmkCu9rW
         tI+Ba318TjLUDF4WhKEBD+FjYDcAriASfwjCXtLCeDBX4M2N93zbSRZSe4gu7490NSOK
         8H0akJdpzijEAm7aG38qWomnIhiC35NUp6Rd7kzLs+PkX9BT61sL3JNlyvsmTNxT1K9+
         RJOWAVbfWAQrEAaJ38sYqXVOV7lw0Ax7iarD/scIIB7BeaaMeUHysn/UsCnEjOJbWOj3
         HYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a/Y318CkZymzIlMzWgGzv6jyPfrfZdPfCWw3//kk9h0=;
        b=RuYstMCOC8ZqLVUh/CUpIG8SUmbTeRafBnVw6KQhSU7fv2T70AA9WcRSBax5Tcz28t
         6uNfu2nehaWoy3+7BdEhYMKcjNm1J+mvlznFm9ujqm8McCwbLjfVAe5WqHru0rDuc66L
         i8O3DXAHzX2ZCmcjROOS6a44smRX+R1GLIZOQgh4mS51ChRQ5r8RD0U25rOQniJIYFRT
         voz52nGbtEOj9Oqj8tcrQ2Pr5neajBVBnkjsmXRFcs+sDHdA1cjb36hUI+XEI2aMiPKW
         87HqqiDc8xvXG7yysH0zPEHzAm+AWu0NuMsl8xmbbwja/hVsFx5dvRK0JiuiuXTYm93B
         OOmA==
X-Gm-Message-State: APjAAAWcQWV5SgHMIOUUwLS0JPQyCIBWyWYO6WYuw7lF9l/TVv91VBrD
        RREpqBvPw0nh4yvACTRVAwl/zi3OX6o=
X-Google-Smtp-Source: APXvYqzPUc0ouvF+qmwhW5IiL+vLlOIhqBUjjAp6ROLUduNWaAL5RQsxo/F0GDUsscgn7Ksvy9Xn5A==
X-Received: by 2002:a19:ca0e:: with SMTP id a14mr16654695lfg.3.1558791795689;
        Sat, 25 May 2019 06:43:15 -0700 (PDT)
Received: from localhost.localdomain (mm-78-96-44-37.mgts.dynamic.pppoe.byfly.by. [37.44.96.78])
        by smtp.gmail.com with ESMTPSA id e6sm1107077ljg.65.2019.05.25.06.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 06:43:14 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     osandov@fb.com, ming.lei@redhat.com, Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/1] blk-mq: Fix disabled hybrid polling
Date:   Sat, 25 May 2019 16:42:11 +0300
Message-Id: <dd30f4d94aa19956ad4500b1177741fd071ec37f.1558791181.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Commit 4bc6339a583cec650b05 ("block: move blk_stat_add() to
__blk_mq_end_request()") moved blk_stat_add(), so now it's called after
blk_update_request(), which zeroes rq->__data_len. Without length,
blk_stat_add() can't calculate stat bucket and returns error,
effectively disabling hybrid polling.

__blk_mq_end_request() is a right place to call blk_stat_add(), as it's
guaranteed to be called for each request. Yet, calculating time there
won't provide sufficient accuracy/precision for finer tuned hybrid
polling, because a path from __blk_mq_complete_request() to
__blk_mq_end_request() adds unpredictable overhead.

Add io_end_time_ns field in struct request, save time as soon as
possible (at __blk_mq_complete_request()) and reuse later.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c         | 13 ++++++++++---
 block/blk-stat.c       |  4 ++--
 block/blk-stat.h       |  2 +-
 include/linux/blkdev.h | 11 +++++++++++
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32b8ad3d341b..8f6b6bfe0ccb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -330,6 +330,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	else
 		rq->start_time_ns = 0;
 	rq->io_start_time_ns = 0;
+	rq->io_end_time_ns = 0;
 	rq->nr_phys_segments = 0;
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 	rq->nr_integrity_segments = 0;
@@ -532,14 +533,17 @@ EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
-	u64 now = 0;
+	u64 now = rq->io_end_time_ns;
 
-	if (blk_mq_need_time_stamp(rq))
+	/* called directly bypassing __blk_mq_complete_request */
+	if (blk_mq_need_time_stamp(rq) && !now) {
 		now = ktime_get_ns();
+		rq->io_end_time_ns = now;
+	}
 
 	if (rq->rq_flags & RQF_STATS) {
 		blk_mq_poll_stats_start(rq->q);
-		blk_stat_add(rq, now);
+		blk_stat_add(rq);
 	}
 
 	if (rq->internal_tag != -1)
@@ -579,6 +583,9 @@ static void __blk_mq_complete_request(struct request *rq)
 	bool shared = false;
 	int cpu;
 
+	if (blk_mq_need_time_stamp(rq))
+		rq->io_end_time_ns = ktime_get_ns();
+
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 	/*
 	 * Most of single queue controllers, there is only one irq vector
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 940f15d600f8..9b9b30927ea8 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -48,7 +48,7 @@ void blk_rq_stat_add(struct blk_rq_stat *stat, u64 value)
 	stat->nr_samples++;
 }
 
-void blk_stat_add(struct request *rq, u64 now)
+void blk_stat_add(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	struct blk_stat_callback *cb;
@@ -56,7 +56,7 @@ void blk_stat_add(struct request *rq, u64 now)
 	int bucket;
 	u64 value;
 
-	value = (now >= rq->io_start_time_ns) ? now - rq->io_start_time_ns : 0;
+	value = blk_rq_io_time(rq);
 
 	blk_throtl_stat_add(rq, value);
 
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 17b47a86eefb..2653818cee36 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -65,7 +65,7 @@ struct blk_stat_callback {
 struct blk_queue_stats *blk_alloc_queue_stats(void);
 void blk_free_queue_stats(struct blk_queue_stats *);
 
-void blk_stat_add(struct request *rq, u64 now);
+void blk_stat_add(struct request *rq);
 
 /* record time/size info in request but not add a callback */
 void blk_stat_enable_accounting(struct request_queue *q);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 592669bcc536..2a8d4b68d707 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -198,6 +198,9 @@ struct request {
 	u64 start_time_ns;
 	/* Time that I/O was submitted to the device. */
 	u64 io_start_time_ns;
+	/* Time that I/O was reported completed by the device. */
+	u64 io_end_time_ns;
+
 
 #ifdef CONFIG_BLK_WBT
 	unsigned short wbt_flags;
@@ -385,6 +388,14 @@ static inline int blkdev_reset_zones_ioctl(struct block_device *bdev,
 
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+static inline u64 blk_rq_io_time(struct request *rq)
+{
+	u64 start = rq->io_start_time_ns;
+	u64 end = rq->io_end_time_ns;
+
+	return (end - start) ? end - start : 0;
+}
+
 struct request_queue {
 	/*
 	 * Together with queue_head for cacheline sharing
-- 
2.21.0

