Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF95C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 07:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354806AbiFNHsq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 03:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354365AbiFNHso (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 03:48:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B0F3E5C6
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 00:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=85JS4vCbKSlOYX6WpnxU/wepRjAlmk1RcZT8l/j9Frs=; b=ZHFVydRmnI/+S3CJ0N24OOue18
        vuJkL1LO9YZkLS7sSsp+58pInkdzBKOzE4SMetIVsdPBtD4Ehi/kZNMwpRpvFaMYcoReBXezHwXNZ
        IFe3XLmxqVTtcU3h6+cDEOsFXsBZ6JGsWoMTkolPUo52Ha1Xlr8G2Xt1oJCs/DVrKSZeScm5wbSY3
        hHE/+3koigVMbMHz4zPadBarJNjRrML5AjrU/YqYwX/5mv5+mQJx9/s2tSFT/WvScZ+WJeUz7DmM4
        ltCkUvtBpf0Ck2+BKAiS3MErZfpaVBjcNtRbBBrsBTyK30dRTWb7dA2HnFErYzkcvzLHdWxef6pFp
        sK+6sNng==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o11Hz-0082kQ-5w; Tue, 14 Jun 2022 07:48:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 3/4] block: remove per-disk debugfs files in blk_unregister_queue
Date:   Tue, 14 Jun 2022 09:48:26 +0200
Message-Id: <20220614074827.458955-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614074827.458955-1-hch@lst.de>
References: <20220614074827.458955-1-hch@lst.de>
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
 block/blk-rq-qos.c     |  4 ----
 block/blk-sysfs.c      | 16 ++++++++--------
 4 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f0fcfe1387cbc..4d1ce9ef43187 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -840,14 +840,6 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
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
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 249a6f05dd3bd..d3a75693adbf4 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -294,10 +294,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 
 void rq_qos_exit(struct request_queue *q)
 {
-	mutex_lock(&q->debugfs_mutex);
-	blk_mq_debugfs_unregister_queue_rqos(q);
-	mutex_unlock(&q->debugfs_mutex);
-
 	while (q->rq_qos) {
 		struct rq_qos *rqos = q->rq_qos;
 		q->rq_qos = rqos->next;
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
-- 
2.30.2

