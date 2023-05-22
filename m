Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C7EC77B75
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 22:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjEVW0O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 18:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjEVW0J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 18:26:09 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B418E
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:04 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso4251261b3a.0
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 15:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684794364; x=1687386364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCqJseb0m0XvA7gWsuQ36HbZaoAzmwodpfk/lIUzTjM=;
        b=b91xli42AArb+KqB4kpe1R+IJyKRA7sabr6VVTRx7Q+dUhV5NA3g+yraZ0j/U9itJJ
         lLd0WvnLiVDscP9ct7yftwbzz7molYKHxtXhjcHbpLuXL01KkuPf2JdCZcHMtRysmKd0
         3sIQJhoNKOGS6m1qcdSt214hHfRfpOTD0+JIuO38KZKicpUD+15WFCEhAMKTr0655DSQ
         d4GC/zFJFv4XziuJulNihZ1GeM0lkWXfmEcCHYEI7s8AXpoUyA3cyGHSHKRnjgAuJeL8
         nAfitDNAkfjTxiJmRYhlzgbsfTisjmy3B1oqxAX7aV3pRL8+NcttrcPoTmrOQzN7t/+J
         A/KQ==
X-Gm-Message-State: AC+VfDymK6midJEtgsE5vkbVQCULVTnYtyHuCD87gackrs+OlIkVahmS
        ShRT3GUuskZ0MRtHSrIK7+c=
X-Google-Smtp-Source: ACHHUZ6dPLwIYZxBgpnWYMo4oA70zhlePi6Um+0MMr4vy4lD9d2N9VCXj5pKwcd5WXA0gQfaxqhNiQ==
X-Received: by 2002:a05:6a20:441a:b0:10a:ba2a:1e78 with SMTP id ce26-20020a056a20441a00b0010aba2a1e78mr10587937pzb.57.1684794363783;
        Mon, 22 May 2023 15:26:03 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:642f:e57f:85fb:3794])
        by smtp.gmail.com with ESMTPSA id y8-20020a634b08000000b00520f4ecd71esm4725364pga.93.2023.05.22.15.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:26:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        jyescas@google.com, mcgrof@kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v5 3/9] block: Support configuring limits below the page size
Date:   Mon, 22 May 2023 15:25:35 -0700
Message-ID: <20230522222554.525229-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230522222554.525229-1-bvanassche@acm.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow block drivers to configure the following:
* Maximum number of hardware sectors values smaller than
  PAGE_SIZE >> SECTOR_SHIFT. For PAGE_SIZE = 4096 this means that values
  below 8 become supported.
* A maximum segment size below the page size. This is most useful
  for page sizes above 4096 bytes.

The blk_sub_page_segments static branch will be used in later patches to
prevent that performance of block drivers that support segments >=
PAGE_SIZE and max_hw_sectors >= PAGE_SIZE >> SECTOR_SHIFT would be affected.

This patch may change the behavior of existing block drivers from not
working into working. If a block driver calls
blk_queue_max_hw_sectors() or blk_queue_max_segment_size(), this is
usually done to configure the maximum supported limits. An attempt to
configure a limit below what is supported by the block layer causes the
block layer to select a larger value. If that value is not supported by
the block driver, this may cause other data to be transferred than
requested, a kernel crash or other undesirable behavior.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c       |  2 ++
 block/blk-settings.c   | 57 ++++++++++++++++++++++++++++++++++++++++++
 block/blk.h            |  9 +++++++
 include/linux/blkdev.h |  2 ++
 4 files changed, 70 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 00c74330fa92..814bfb9c9489 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -264,6 +264,8 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 static void blk_free_queue(struct request_queue *q)
 {
 	blk_free_queue_stats(q->stats);
+	blk_disable_sub_page_limits(&q->limits);
+
 	if (queue_is_mq(q))
 		blk_mq_release(q);
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 95d6e836c4a7..a4ef1dfeef76 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -19,6 +19,11 @@
 #include "blk-rq-qos.h"
 #include "blk-wbt.h"
 
+/* Protects blk_nr_sub_page_limit_queues and blk_sub_page_limits changes. */
+static DEFINE_MUTEX(blk_sub_page_limit_lock);
+static uint32_t blk_nr_sub_page_limit_queues;
+DEFINE_STATIC_KEY_FALSE(blk_sub_page_limits);
+
 void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
 {
 	q->rq_timeout = timeout;
@@ -59,6 +64,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->zoned = BLK_ZONED_NONE;
 	lim->zone_write_granularity = 0;
 	lim->dma_alignment = 511;
+	lim->sub_page_limits = false;
 }
 
 /**
@@ -101,6 +107,47 @@ void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce bounce)
 }
 EXPORT_SYMBOL(blk_queue_bounce_limit);
 
+/**
+ * blk_enable_sub_page_limits - enable support for max_segment_size values smaller than PAGE_SIZE and for max_hw_sectors values below PAGE_SIZE >> SECTOR_SHIFT
+ * @lim: request queue limits for which to enable support of these features.
+ *
+ * Support for these features is not enabled all the time because of the
+ * runtime overhead of these features.
+ */
+static void blk_enable_sub_page_limits(struct queue_limits *lim)
+{
+	if (lim->sub_page_limits)
+		return;
+
+	lim->sub_page_limits = true;
+
+	mutex_lock(&blk_sub_page_limit_lock);
+	if (++blk_nr_sub_page_limit_queues == 1)
+		static_branch_enable(&blk_sub_page_limits);
+	mutex_unlock(&blk_sub_page_limit_lock);
+}
+
+/**
+ * blk_disable_sub_page_limits - disable support for max_segment_size values smaller than PAGE_SIZE and for max_hw_sectors values below PAGE_SIZE >> SECTOR_SHIFT
+ * @lim: request queue limits for which to enable support of these features.
+ *
+ * Support for these features is not enabled all the time because of the
+ * runtime overhead of these features.
+ */
+void blk_disable_sub_page_limits(struct queue_limits *lim)
+{
+	if (!lim->sub_page_limits)
+		return;
+
+	lim->sub_page_limits = false;
+
+	mutex_lock(&blk_sub_page_limit_lock);
+	WARN_ON_ONCE(blk_nr_sub_page_limit_queues <= 0);
+	if (--blk_nr_sub_page_limit_queues == 0)
+		static_branch_disable(&blk_sub_page_limits);
+	mutex_unlock(&blk_sub_page_limit_lock);
+}
+
 /**
  * blk_queue_max_hw_sectors - set max sectors for a request for this queue
  * @q:  the request queue for the device
@@ -126,6 +173,11 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 	unsigned int min_max_hw_sectors = PAGE_SIZE >> SECTOR_SHIFT;
 	unsigned int max_sectors;
 
+	if (max_hw_sectors < min_max_hw_sectors) {
+		blk_enable_sub_page_limits(limits);
+		min_max_hw_sectors = 1;
+	}
+
 	if (max_hw_sectors < min_max_hw_sectors) {
 		max_hw_sectors = min_max_hw_sectors;
 		pr_info("%s: set to minimum %u\n", __func__, max_hw_sectors);
@@ -284,6 +336,11 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
 {
 	unsigned int min_max_segment_size = PAGE_SIZE;
 
+	if (max_size < min_max_segment_size) {
+		blk_enable_sub_page_limits(&q->limits);
+		min_max_segment_size = SECTOR_SIZE;
+	}
+
 	if (max_size < min_max_segment_size) {
 		max_size = min_max_segment_size;
 		pr_info("%s: set to minimum %u\n", __func__, max_size);
diff --git a/block/blk.h b/block/blk.h
index 9f171b8f1e34..49526127ea08 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -13,6 +13,7 @@ struct elevator_type;
 #define BLK_MAX_TIMEOUT		(5 * HZ)
 
 extern struct dentry *blk_debugfs_root;
+DECLARE_STATIC_KEY_FALSE(blk_sub_page_limits);
 
 struct blk_flush_queue {
 	unsigned int		flush_pending_idx:1;
@@ -32,6 +33,14 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 					      gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
+static inline bool blk_queue_sub_page_limits(const struct queue_limits *lim)
+{
+	return static_branch_unlikely(&blk_sub_page_limits) &&
+		lim->sub_page_limits;
+}
+
+void blk_disable_sub_page_limits(struct queue_limits *q);
+
 void blk_freeze_queue(struct request_queue *q);
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fe99948688df..e54fbb124efb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -310,6 +310,8 @@ struct queue_limits {
 	 * due to possible offsets.
 	 */
 	unsigned int		dma_alignment;
+
+	bool			sub_page_limits;
 };
 
 typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
