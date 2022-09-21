Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8D9C6FA82
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiIUSF0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIUSFY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B25271BF7
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mhVVHbgFlWjaq3Dg67A72O125Cy8t9PZ8FeUf53TLFs=; b=sYt40p4yIENH1GYSYutaalX++S
        y+28+R/iJEW5rLZfCS6I/F/G88ESxH6tcY+KS1n/LrPabiQ2h8YfXhFQvO/iPdp04bHsaXshKfPmN
        EQJHeEtL0zBWcRDLlf8uXQx5ah+MLCes5xHJe/ovO5h1zDf6p64GKy3Ftenl3c0WyLPFm+MN8TIc+
        yEwHKAfxgE4PoiAXK4WqK55KVAIK9z2jYYdnlgQuLiHPtaZLnpEyrcgoGV9Owybi/DLiCqM1TRxNz
        DVcNbd9PBOhPmBV67zdp0l05YJ7svg/oA26wIVpgILkIjlvqC0dDOd+wB8B/vVpl5iyngfmpMjYpd
        TMn9XIFA==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob464-00CGYr-1t; Wed, 21 Sep 2022 18:05:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 07/17] blk-ioprio: pass a gendisk to blk_ioprio_init and blk_ioprio_exit
Date:   Wed, 21 Sep 2022 20:04:51 +0200
Message-Id: <20220921180501.1539876-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass the gendisk to blk_ioprio_init and blk_ioprio_exit as part of moving
the blk-cgroup infrastructure to be gendisk based.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 4 ++--
 block/blk-ioprio.c | 8 ++++----
 block/blk-ioprio.h | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 4ca6933a7c3f5..89974fd0db3da 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1257,7 +1257,7 @@ int blkcg_init_disk(struct gendisk *disk)
 	if (preloaded)
 		radix_tree_preload_end();
 
-	ret = blk_ioprio_init(q);
+	ret = blk_ioprio_init(disk);
 	if (ret)
 		goto err_destroy_all;
 
@@ -1274,7 +1274,7 @@ int blkcg_init_disk(struct gendisk *disk)
 err_throtl_exit:
 	blk_throtl_exit(q);
 err_ioprio_exit:
-	blk_ioprio_exit(q);
+	blk_ioprio_exit(disk);
 err_destroy_all:
 	blkg_destroy_all(q);
 	return ret;
diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index c00060a02c6ef..8bb6b8eba4cee 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -202,14 +202,14 @@ void blkcg_set_ioprio(struct bio *bio)
 		bio->bi_ioprio = prio;
 }
 
-void blk_ioprio_exit(struct request_queue *q)
+void blk_ioprio_exit(struct gendisk *disk)
 {
-	blkcg_deactivate_policy(q, &ioprio_policy);
+	blkcg_deactivate_policy(disk->queue, &ioprio_policy);
 }
 
-int blk_ioprio_init(struct request_queue *q)
+int blk_ioprio_init(struct gendisk *disk)
 {
-	return blkcg_activate_policy(q, &ioprio_policy);
+	return blkcg_activate_policy(disk->queue, &ioprio_policy);
 }
 
 static int __init ioprio_init(void)
diff --git a/block/blk-ioprio.h b/block/blk-ioprio.h
index 5a1eb550e178c..b6afb8e80de05 100644
--- a/block/blk-ioprio.h
+++ b/block/blk-ioprio.h
@@ -9,15 +9,15 @@ struct request_queue;
 struct bio;
 
 #ifdef CONFIG_BLK_CGROUP_IOPRIO
-int blk_ioprio_init(struct request_queue *q);
-void blk_ioprio_exit(struct request_queue *q);
+int blk_ioprio_init(struct gendisk *disk);
+void blk_ioprio_exit(struct gendisk *disk);
 void blkcg_set_ioprio(struct bio *bio);
 #else
-static inline int blk_ioprio_init(struct request_queue *q)
+static inline int blk_ioprio_init(struct gendisk *disk)
 {
 	return 0;
 }
-static inline void blk_ioprio_exit(struct request_queue *q)
+static inline void blk_ioprio_exit(struct gendisk *disk)
 {
 }
 static inline void blkcg_set_ioprio(struct bio *bio)
-- 
2.30.2

