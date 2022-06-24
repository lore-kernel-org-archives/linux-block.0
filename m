Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C69C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 05:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiFXFZo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 01:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiFXFZn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 01:25:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3386802C
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 22:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dY9v9Mc52ontn9o3oPV9UuW9aIS4flo6PBUUvhWcYC0=; b=3mz+ODIIFwz34pjYyRpRKguLd2
        KNG+rEi0Py1f+OiF6Mt/gAxROfTnij5ZfZba8mTIF3ERux7uVJ3255Hq4rTh5qVXvoMwbn7yLly7Q
        /1zfFjubzCMw4D1ASZ8XjIzZADwyleSxQ94LKXM4HfDGJSi+RGREH85yXJIIcJ2Ey9TamBUKWDtje
        YQkTtIO4A2bcMMHfST3rjbUS9ynKGejT8ibfVyONYhe+593hhey+luZsP+iTQwkxzAo9REf5gdLD9
        g+OybUoxrhn2kh+SnV0cl5aH6iVzYbst9Na/S4JE39sgQdbQX9X369tLJqMak11QF0m1c7rlMeCkb
        1V61fJOQ==;
Received: from [2001:4bb8:189:7251:508b:56d3:aa35:3dd8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4bou-000cEs-9U; Fri, 24 Jun 2022 05:25:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 6/6] blk-mq: cleanup disk sysfs registration
Date:   Fri, 24 Jun 2022 07:25:10 +0200
Message-Id: <20220624052510.3996673-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220624052510.3996673-1-hch@lst.de>
References: <20220624052510.3996673-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass a gendisk to the sysfs register/unregister functions and give
them descriptive names.  Also move the unregistration helper next
to the one doing the registration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sysfs.c   | 39 ++++++++++++++++++++-------------------
 block/blk-mq.h         |  3 ++-
 block/blk-sysfs.c      |  9 ++++-----
 include/linux/blk-mq.h |  1 -
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index ee6efe2b250d2..93997d297d427 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -203,22 +203,6 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
 	return ret;
 }
 
-void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
-{
-	struct blk_mq_hw_ctx *hctx;
-	unsigned long i;
-
-	lockdep_assert_held(&q->sysfs_dir_lock);
-
-	queue_for_each_hw_ctx(q, hctx, i)
-		blk_mq_unregister_hctx(hctx);
-
-	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
-	kobject_del(q->mq_kobj);
-
-	q->mq_sysfs_init_done = false;
-}
-
 void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
 {
 	kobject_init(&hctx->kobj, &blk_mq_hw_ktype);
@@ -251,16 +235,16 @@ void blk_mq_sysfs_init(struct request_queue *q)
 	}
 }
 
-int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
+int blk_mq_sysfs_register(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i, j;
 	int ret;
 
-	WARN_ON_ONCE(!q->kobj.parent);
 	lockdep_assert_held(&q->sysfs_dir_lock);
 
-	ret = kobject_add(q->mq_kobj, &dev->kobj, "%s", "mq");
+	ret = kobject_add(q->mq_kobj, &disk_to_dev(disk)->kobj, "mq");
 	if (ret < 0)
 		goto out;
 
@@ -288,6 +272,23 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	return ret;
 }
 
+void blk_mq_sysfs_unregister(struct gendisk *disk)
+{
+	struct request_queue *q = disk->queue;
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
+
+	lockdep_assert_held(&q->sysfs_dir_lock);
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_unregister_hctx(hctx);
+
+	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
+	kobject_del(q->mq_kobj);
+
+	q->mq_sysfs_init_done = false;
+}
+
 void blk_mq_sysfs_unregister_hctxs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index bed34061c3a0b..7145c10932b91 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -118,7 +118,8 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
  */
 extern void blk_mq_sysfs_init(struct request_queue *q);
 extern void blk_mq_sysfs_deinit(struct request_queue *q);
-extern int __blk_mq_register_dev(struct device *dev, struct request_queue *q);
+int blk_mq_sysfs_register(struct gendisk *disk);
+void blk_mq_sysfs_unregister(struct gendisk *disk);
 int blk_mq_sysfs_register_hctxs(struct request_queue *q);
 void blk_mq_sysfs_unregister_hctxs(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 80f506411f92f..0415722a4625f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -805,18 +805,17 @@ struct kobj_type blk_queue_ktype = {
  */
 int blk_register_queue(struct gendisk *disk)
 {
-	int ret;
-	struct device *dev = disk_to_dev(disk);
 	struct request_queue *q = disk->queue;
+	int ret;
 
 	mutex_lock(&q->sysfs_dir_lock);
 
-	ret = kobject_add(&q->kobj, &dev->kobj, "%s", "queue");
+	ret = kobject_add(&q->kobj, &disk_to_dev(disk)->kobj, "queue");
 	if (ret < 0)
 		goto unlock;
 
 	if (queue_is_mq(q))
-		__blk_mq_register_dev(dev, q);
+		blk_mq_sysfs_register(disk);
 	mutex_lock(&q->sysfs_lock);
 
 	mutex_lock(&q->debugfs_mutex);
@@ -912,7 +911,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	 * structures that can be modified through sysfs.
 	 */
 	if (queue_is_mq(q))
-		blk_mq_unregister_dev(disk_to_dev(disk), q);
+		blk_mq_sysfs_unregister(disk);
 	blk_crypto_sysfs_unregister(q);
 
 	mutex_lock(&q->sysfs_lock);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0fd96e92c6c65..43aad0da3305d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -691,7 +691,6 @@ struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q);
-void blk_mq_unregister_dev(struct device *, struct request_queue *);
 void blk_mq_destroy_queue(struct request_queue *);
 
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
-- 
2.30.2

