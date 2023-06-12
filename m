Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6F3C88CB5
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 20:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbjFLUd0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 16:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjFLUdZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 16:33:25 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA13E57
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:23 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1b3c0c476d1so16104945ad.1
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 13:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602003; x=1689194003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGT3esQWRf5e91YtXev0us55UEaQ38pPW1j92RLY91M=;
        b=PL3u5X5x0ZQn8T3QDDDLKOvUh04lnwrA/3ipW++yp6GZVLyy0xl56xcHX/34WOtYxr
         7MsgRysOcOLl+UBrKKuGDOMXbb1CxgCEbmQVeNkny1ZaAmf3lE+fR4Xgz9nhzyaJGXi9
         zKCadjZ30mB1Wwbo2WFS9BqJFYL5qBRrVaF4FT9IkfILixxfzmEXTIB5j3MTvK5axz5k
         y9sqlUIWGcXJ4xuhA/trsBUh0AD5e7jzB7VBFMqIFlwjiIji2ObBWMV44QifOewcc60d
         itKmkey+bo+JHG1BSxhpCC0mvu+MwJH7DALdQycO6Ze8kC++2nYGnlOHoNBtK7SDJ2hc
         +1Nw==
X-Gm-Message-State: AC+VfDzae6ELJT4FJAub0PZyYps/wYuzSgk7bBzav01YGFUSaznzpgc0
        N32V3RMtHfKh1SeRICxZvZsZxpZ8QyUSvw==
X-Google-Smtp-Source: ACHHUZ6jKyVfUYKfCXTbRR2Jfp22c+n2AG8q0eVobbZ2L7T37kiJZLtlog36nunXHBxTsE46hKXhdA==
X-Received: by 2002:a17:902:8642:b0:1b0:348:2498 with SMTP id y2-20020a170902864200b001b003482498mr7000659plt.2.1686602002990;
        Mon, 12 Jun 2023 13:33:22 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001b016313b1dsm3324767plb.86.2023.06.12.13.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:33:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v6 3/8] block: Support configuring limits below the page size
Date:   Mon, 12 Jun 2023 13:33:09 -0700
Message-Id: <20230612203314.17820-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612203314.17820-1-bvanassche@acm.org>
References: <20230612203314.17820-1-bvanassche@acm.org>
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

Tested-by: Sandeep Dhavale <dhavale@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c       |  2 ++
 block/blk-settings.c   | 60 ++++++++++++++++++++++++++++++++++++++++++
 block/blk.h            |  9 +++++++
 include/linux/blkdev.h |  2 ++
 4 files changed, 73 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2ae22bebeb3e..73b8b547ecb9 100644
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
index 95d6e836c4a7..607f21b99f3c 100644
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
@@ -101,6 +107,50 @@ void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce bounce)
 }
 EXPORT_SYMBOL(blk_queue_bounce_limit);
 
+/**
+ * blk_enable_sub_page_limits - enable support for limits below the page size
+ * @lim: request queue limits for which to enable support of these features.
+ *
+ * Enable support for max_segment_size values smaller than PAGE_SIZE and for
+ * max_hw_sectors values below PAGE_SIZE >> SECTOR_SHIFT. Support for these
+ * features is not enabled all the time because of the runtime overhead of these
+ * features.
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
+ * blk_disable_sub_page_limits - disable support for limits below the page size
+ * @lim: request queue limits for which to enable support of these features.
+ *
+ * max_segment_size values smaller than PAGE_SIZE and for max_hw_sectors values
+ * below PAGE_SIZE >> SECTOR_SHIFT. Support for these features is not enabled
+ * all the time because of the runtime overhead of these features.
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
@@ -126,6 +176,11 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
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
@@ -284,6 +339,11 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
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
index 768852a84fef..d37ec737e05e 100644
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
index ed44a997f629..54360ef85109 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -324,6 +324,8 @@ struct queue_limits {
 	 * due to possible offsets.
 	 */
 	unsigned int		dma_alignment;
+
+	bool			sub_page_limits;
 };
 
 typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
