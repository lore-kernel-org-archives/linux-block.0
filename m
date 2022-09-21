Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F09C6FA8B
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiIUSFV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIUSFU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01B45C95F
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RgcptV7ILzoWJIQfe4ydBXczcFatX3do4ah0BmY+Pek=; b=Hd/0wA+2AhJ8fyzqIdMU3f8OtJ
        YGQ0oAlLhh2wUVTSwd/NbFvY0kbXKWmmvKk1EU2ovQXwnKdnExbRBXtgqjVxqeRct9UTrZFdweKgC
        X+UN4VRH5JU3UCNMtM0W6JD9xDhu8L1UYU3ZNJj6A/Ea4tXb9ceui0dgOsSGhCZFW68XxVJx2zKQh
        EDR8RB+CkxhLTYUAGp4GEFB1CZOlQmSVffOZG6PxuhPLYJRmUsIfIzZsh3krvL3zFVm3NlSgBpJly
        ym6/MY6tp7QSmL6fsedIOnfP2y3FuLMyv6dmeeD3GB/sFvThaGOG1jDD/mwkJDbqpAMTLmLiWf8Uz
        eDwisY7g==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob461-00CGY0-QF; Wed, 21 Sep 2022 18:05:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 06/17] blk-cgroup: pass a gendisk to blkcg_init_queue and blkcg_exit_queue
Date:   Wed, 21 Sep 2022 20:04:50 +0200
Message-Id: <20220921180501.1539876-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass the gendisk to blkcg_init_disk and blkcg_exit_disk as part of moving
the blk-cgroup infrastructure to be gendisk based.  Also remove the
rather pointless kerneldoc comments for these internal functions with a
single caller each.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 25 +++++--------------------
 block/blk-cgroup.h |  8 ++++----
 block/genhd.c      |  5 +++--
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1306112d76486..4ca6933a7c3f5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1230,18 +1230,9 @@ static int blkcg_css_online(struct cgroup_subsys_state *css)
 	return 0;
 }
 
-/**
- * blkcg_init_queue - initialize blkcg part of request queue
- * @q: request_queue to initialize
- *
- * Called from blk_alloc_queue(). Responsible for initializing blkcg
- * part of new request_queue @q.
- *
- * RETURNS:
- * 0 on success, -errno on failure.
- */
-int blkcg_init_queue(struct request_queue *q)
+int blkcg_init_disk(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct blkcg_gq *new_blkg, *blkg;
 	bool preloaded;
 	int ret;
@@ -1294,16 +1285,10 @@ int blkcg_init_queue(struct request_queue *q)
 	return PTR_ERR(blkg);
 }
 
-/**
- * blkcg_exit_queue - exit and release blkcg part of request_queue
- * @q: request_queue being released
- *
- * Called from blk_exit_queue().  Responsible for exiting blkcg part.
- */
-void blkcg_exit_queue(struct request_queue *q)
+void blkcg_exit_disk(struct gendisk *disk)
 {
-	blkg_destroy_all(q);
-	blk_throtl_exit(q);
+	blkg_destroy_all(disk->queue);
+	blk_throtl_exit(disk->queue);
 }
 
 static void blkcg_bind(struct cgroup_subsys_state *root_css)
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 91b7ae0773be6..aa2b286bc825f 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -178,8 +178,8 @@ struct blkcg_policy {
 extern struct blkcg blkcg_root;
 extern bool blkcg_debug_stats;
 
-int blkcg_init_queue(struct request_queue *q);
-void blkcg_exit_queue(struct request_queue *q);
+int blkcg_init_disk(struct gendisk *disk);
+void blkcg_exit_disk(struct gendisk *disk);
 
 /* Blkio controller policy registration */
 int blkcg_policy_register(struct blkcg_policy *pol);
@@ -481,8 +481,8 @@ struct blkcg {
 };
 
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
-static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
-static inline void blkcg_exit_queue(struct request_queue *q) { }
+static inline int blkcg_init_disk(struct gendisk *disk) { return 0; }
+static inline void blkcg_exit_disk(struct gendisk *disk) { }
 static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
 static inline void blkcg_policy_unregister(struct blkcg_policy *pol) { }
 static inline int blkcg_activate_policy(struct request_queue *q,
diff --git a/block/genhd.c b/block/genhd.c
index d36fabf0abc1f..f1af045fac2fe 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1150,7 +1150,8 @@ static void disk_release(struct device *dev)
 	    !test_bit(GD_ADDED, &disk->state))
 		blk_mq_exit_queue(disk->queue);
 
-	blkcg_exit_queue(disk->queue);
+	blkcg_exit_disk(disk);
+
 	bioset_exit(&disk->bio_split);
 
 	disk_release_events(disk);
@@ -1363,7 +1364,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	if (xa_insert(&disk->part_tbl, 0, disk->part0, GFP_KERNEL))
 		goto out_destroy_part_tbl;
 
-	if (blkcg_init_queue(q))
+	if (blkcg_init_disk(disk))
 		goto out_erase_part0;
 
 	rand_initialize_disk(disk);
-- 
2.30.2

