Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14494C4332F
	for <linux-block@archiver.kernel.org>; Mon, 30 May 2022 14:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbiE3OW1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 May 2022 10:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241394AbiE3ORd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 10:17:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5F18FFA8
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tYAZ4k+GwXru8Na3ZQDj488r2l5bpJ+nBHdUlHUpd/s=; b=bsJF458BVqGADbw6b8cYTmZV1g
        hPCtz/Bjf2s+Yg9WmCtnhC/pdrIoBrxSoXIeIrcL+mJOyEbUpokogjEhKHlW4YDukz8bchbAwTi9/
        5hb0t/7nb0zBsw1LSszD1tqdeRoZlKusjE5hgMXwCyzpX+lJ+tTLDk1cvtJEA1k+Zj5G9LpakurtY
        cz6alRNcs/alAjK1xYgiVz22ujP6l1mmSYgyz1JyuDjH9CUuKdQ557CkJCqJahJ18fmBCXcc/0gad
        zsydAi5dRD4/39My2iaV6iyb+FNrkwm1N+EhP5ZZ6wxxyAEjSKlOWYbDsyjDi+P6+1SPoKoEz5NXf
        5fuxhxig==;
Received: from [2001:4bb8:185:a81e:fda9:da32:3b0c:8358] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvfiW-006rOi-Al; Mon, 30 May 2022 13:45:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: remove per-disk debugfs files in blk_unregister_queue
Date:   Mon, 30 May 2022 15:45:47 +0200
Message-Id: <20220530134548.3108185-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220530134548.3108185-1-hch@lst.de>
References: <20220530134548.3108185-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block debugfs files are created in blk_register_queue, which is
called by add_disk and use a naming scheme based on the disk_name.
After del_gendisk returns that name can be reused and thus we must not
leave these debugfs files around, otherwise the kernel is unhappy
and spews messages like:

    Directory XXXXX with parent 'block' already present!

and the newly created devices will not have working debugfs files.

Move the unregistration to blk_unregister_queue instead (which matches
the sysfs unregistration) to make sure the debugfs life time rules match
those of the disk name.

As part of the move also make sure the whole debugfs unregistration is
inside a single debugfs_mutex critical section.

Note that this breaks blktests block/002, which checks that the debugfs
directory has not been removed while blktests is running, but that
particular check should simply be removed from the test case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c |  8 --------
 block/blk-mq-debugfs.h |  5 -----
 block/blk-sysfs.c      | 16 ++++++++--------
 block/genhd.c          |  4 ----
 4 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index bee80fc562052..6bda8dd7a271f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -836,14 +836,6 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
 }
 
-void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
-{
-	lockdep_assert_held(&q->debugfs_mutex);
-
-	debugfs_remove_recursive(q->rqos_debugfs_dir);
-	q->rqos_debugfs_dir = NULL;
-}
-
 void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 					struct blk_mq_hw_ctx *hctx)
 {
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 771d458328788..9c7d4b6117d41 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -35,7 +35,6 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
-void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q);
 #else
 static inline void blk_mq_debugfs_register(struct request_queue *q)
 {
@@ -82,10 +81,6 @@ static inline void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 static inline void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 {
 }
-
-static inline void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
-{
-}
 #endif
 
 #ifdef CONFIG_BLK_DEBUG_FS_ZONED
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6e4801b217a79..9b905e9443e49 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -779,13 +779,6 @@ static void blk_release_queue(struct kobject *kobj)
 	if (queue_is_mq(q))
 		blk_mq_release(q);
 
-	mutex_lock(&q->debugfs_mutex);
-	blk_trace_shutdown(q);
-	debugfs_remove_recursive(q->debugfs_dir);
-	q->debugfs_dir = NULL;
-	q->sched_debugfs_dir = NULL;
-	mutex_unlock(&q->debugfs_mutex);
-
 	bioset_exit(&q->bio_split);
 
 	if (blk_queue_has_srcu(q))
@@ -946,8 +939,15 @@ void blk_unregister_queue(struct gendisk *disk)
 	/* Now that we've deleted all child objects, we can delete the queue. */
 	kobject_uevent(&q->kobj, KOBJ_REMOVE);
 	kobject_del(&q->kobj);
-
 	mutex_unlock(&q->sysfs_dir_lock);
 
+	mutex_lock(&q->debugfs_mutex);
+	blk_trace_shutdown(q);
+	debugfs_remove_recursive(q->debugfs_dir);
+	q->debugfs_dir = NULL;
+	q->sched_debugfs_dir = NULL;
+	q->rqos_debugfs_dir = NULL;
+	mutex_unlock(&q->debugfs_mutex);
+
 	kobject_put(&disk_to_dev(disk)->kobj);
 }
diff --git a/block/genhd.c b/block/genhd.c
index 9f4eb7516df7e..36532b9318419 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1122,10 +1122,6 @@ static void disk_release_mq(struct request_queue *q)
 {
 	blk_mq_cancel_work_sync(q);
 
-	mutex_lock(&q->debugfs_mutex);
-	blk_mq_debugfs_unregister_queue_rqos(q);
-	mutex_unlock(&q->debugfs_mutex);
-
 	/*
 	 * There can't be any non non-passthrough bios in flight here, but
 	 * requests stay around longer, including passthrough ones so we
-- 
2.30.2

