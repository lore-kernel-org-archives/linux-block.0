Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9924CCA479
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 17:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiF1RTL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiF1RTI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 13:19:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2C22FFFE
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ddUtJTemLhcj25Hlr1z0czySlK1sNvEvnst3D84Hzm4=; b=NbCgNCi0F7/mlEgc6LAB9TUjUa
        RWI9kwVE8EjqDYKzXQWY2sqI3H+aJ3xuzFo9NMlhC6F2HK6Vu6Or/y6gDUnOFO3hWx+9pMo+rTDm+
        KjCk7REXm1EFR6ycjKOFCbBqgh9Sl+x1TaPtuHjPybNiYHjpoCUXHJ2LyVRaV2Tc5wNTyyISoQAMx
        iIFV37gvFgq8PIRfnqeWwvjmjA6joWEYiQSsxzcpHBtbrkA8NMILojJAl1JMryoiTlo6vZFkLW0iI
        supslbAQJAFICPPJL83EJXpnJTrpuJadFfgHihPUExS4wICFSi4qkFPulVdS8rLhKpxbvU0qzMfQO
        lZvlZGKw==;
Received: from [2001:4bb8:199:3788:e965:1541:b076:2977] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6Eri-007NV2-UO; Tue, 28 Jun 2022 17:19:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 5/6] blk-mq: rename blk_mq_sysfs_{,un}register
Date:   Tue, 28 Jun 2022 19:18:49 +0200
Message-Id: <20220628171850.1313069-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220628171850.1313069-1-hch@lst.de>
References: <20220628171850.1313069-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a _hctx postfix to better describe what the functions do, match
the debugfs equivalents and release the old names for functions that
should be using them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-sysfs.c | 4 ++--
 block/blk-mq.c       | 4 ++--
 block/blk-mq.h       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index f4caaa668e3cf..ee6efe2b250d2 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -288,7 +288,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	return ret;
 }
 
-void blk_mq_sysfs_unregister(struct request_queue *q)
+void blk_mq_sysfs_unregister_hctxs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
@@ -304,7 +304,7 @@ void blk_mq_sysfs_unregister(struct request_queue *q)
 	mutex_unlock(&q->sysfs_dir_lock);
 }
 
-int blk_mq_sysfs_register(struct request_queue *q)
+int blk_mq_sysfs_register_hctxs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b1dbc4b2c2c97..15c7c5c4ad222 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4559,7 +4559,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_debugfs_unregister_hctxs(q);
-		blk_mq_sysfs_unregister(q);
+		blk_mq_sysfs_unregister_hctxs(q);
 	}
 
 	prev_nr_hw_queues = set->nr_hw_queues;
@@ -4590,7 +4590,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 reregister:
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_sysfs_register(q);
+		blk_mq_sysfs_register_hctxs(q);
 		blk_mq_debugfs_register_hctxs(q);
 	}
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e4c6fe2c8ac8f..a92639f2bfd21 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -119,8 +119,8 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 extern void blk_mq_sysfs_init(struct request_queue *q);
 extern void blk_mq_sysfs_deinit(struct request_queue *q);
 extern int __blk_mq_register_dev(struct device *dev, struct request_queue *q);
-extern int blk_mq_sysfs_register(struct request_queue *q);
-extern void blk_mq_sysfs_unregister(struct request_queue *q);
+int blk_mq_sysfs_register_hctxs(struct request_queue *q);
+void blk_mq_sysfs_unregister_hctxs(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 void blk_mq_free_plug_rqs(struct blk_plug *plug);
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule);
-- 
2.30.2

