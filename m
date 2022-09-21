Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D4AC6FA82
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiIUSFs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiIUSFo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0748169B
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ct9YBB6ZNa7C7mA0S3zBeiOTQow7Ya54oBZzTtW1FNw=; b=L4mnFYl/MiXZU+OxVaVMExOEbW
        BD4qJbjFK70xsyZG8RU8gDCWj0L3xI/ghflzKlLI1OTkq5NuiOcy9jm7VU8gdFOTrpSFmeaU3Qtep
        bxFfbOl+pVbqWt7S1cl0aVyAyET+Sd1pjSO+SzFcfN2LlhzdfPR0kPOXewXHvl4GczNqhSMZ4+Jao
        3A5UAKGVf29DkWIhX4elE7SrVrZcuNwpitLm1PSY+9IaYXq8Byts6cmZGF4lQxn8q5hgpeX15fZQo
        u0f6yQzrtImwarrVX3Wp9pU9jptGG614o7ZORmhCqYwabz141Cf7kWfOc00BLgtAizPqWQCWr05nb
        309jXzcw==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob46L-00CGc6-8G; Wed, 21 Sep 2022 18:05:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 12/17] blk-throttle: pass a gendisk to blk_throtl_init and blk_throtl_exit
Date:   Wed, 21 Sep 2022 20:04:56 +0200
Message-Id: <20220921180501.1539876-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass the gendisk to blk_throtl_init and blk_throtl_exit as part of moving
the blk-cgroup infrastructure to be gendisk based.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c   | 6 +++---
 block/blk-throttle.c | 7 +++++--
 block/blk-throttle.h | 8 ++++----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 82a117ff54de5..3dfd78f1312db 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1261,7 +1261,7 @@ int blkcg_init_disk(struct gendisk *disk)
 	if (ret)
 		goto err_destroy_all;
 
-	ret = blk_throtl_init(q);
+	ret = blk_throtl_init(disk);
 	if (ret)
 		goto err_ioprio_exit;
 
@@ -1272,7 +1272,7 @@ int blkcg_init_disk(struct gendisk *disk)
 	return 0;
 
 err_throtl_exit:
-	blk_throtl_exit(q);
+	blk_throtl_exit(disk);
 err_ioprio_exit:
 	blk_ioprio_exit(disk);
 err_destroy_all:
@@ -1288,7 +1288,7 @@ int blkcg_init_disk(struct gendisk *disk)
 void blkcg_exit_disk(struct gendisk *disk)
 {
 	blkg_destroy_all(disk->queue);
-	blk_throtl_exit(disk->queue);
+	blk_throtl_exit(disk);
 }
 
 static void blkcg_bind(struct cgroup_subsys_state *root_css)
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 55f2d985cfbbd..9ca8ae0ae6683 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2358,8 +2358,9 @@ void blk_throtl_bio_endio(struct bio *bio)
 }
 #endif
 
-int blk_throtl_init(struct request_queue *q)
+int blk_throtl_init(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct throtl_data *td;
 	int ret;
 
@@ -2401,8 +2402,10 @@ int blk_throtl_init(struct request_queue *q)
 	return ret;
 }
 
-void blk_throtl_exit(struct request_queue *q)
+void blk_throtl_exit(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
+
 	BUG_ON(!q->td);
 	del_timer_sync(&q->td->service_queue.pending_timer);
 	throtl_shutdown_wq(q);
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 66b4292b1b92a..f75852a4e5337 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -168,14 +168,14 @@ static inline struct throtl_grp *blkg_to_tg(struct blkcg_gq *blkg)
  * Internal throttling interface
  */
 #ifndef CONFIG_BLK_DEV_THROTTLING
-static inline int blk_throtl_init(struct request_queue *q) { return 0; }
-static inline void blk_throtl_exit(struct request_queue *q) { }
+static inline int blk_throtl_init(struct gendisk *disk) { return 0; }
+static inline void blk_throtl_exit(struct gendisk *disk) { }
 static inline void blk_throtl_register_queue(struct request_queue *q) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
 static inline void blk_throtl_cancel_bios(struct request_queue *q) { }
 #else /* CONFIG_BLK_DEV_THROTTLING */
-int blk_throtl_init(struct request_queue *q);
-void blk_throtl_exit(struct request_queue *q);
+int blk_throtl_init(struct gendisk *disk);
+void blk_throtl_exit(struct gendisk *disk);
 void blk_throtl_register_queue(struct request_queue *q);
 bool __blk_throtl_bio(struct bio *bio);
 void blk_throtl_cancel_bios(struct request_queue *q);
-- 
2.30.2

