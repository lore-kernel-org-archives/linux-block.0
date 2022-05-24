Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E361C433EF
	for <linux-block@archiver.kernel.org>; Tue, 24 May 2022 08:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiEXIds (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 04:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiEXIdp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 04:33:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C5962CFE
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=DHzjy4nlr3rU1c0puAjR9fgBzvqfsgceh6JQVYv47vk=; b=itdNfsSeV38TnERcF9MZagiRgC
        2Zbpam7qRGc7xH/KqZjWbLhCvTYlffk5cZMg3IYotsZ+5f2uNFZBBAHL2yryubUFpMfzzrZYUhmcU
        51vYiHaZVBDiRRGuMxEcdEM0xlCJ6C1BP56tTO3pQ9Du26PsMZqTuzf2iGt8gVC4h8BCJoPQ6Qnrr
        QclJQhXvOyPqAlFQb4Piohq3CQ8lJc/5b0r+5O7/bCOl0mjnm9YnBi0hiEz2fsFige1aoFPe3F7Ai
        iInJhanXtNzud/MiPx1d0lSpSoeHWzC8nMHFBEV66ucj/4voHiFtfUHjdbErSx6FBZIq54Xh1RPDR
        qQRgPY1w==;
Received: from [2001:4bb8:18c:7298:31fd:9579:b449:3c3a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntPyp-007Emb-T8; Tue, 24 May 2022 08:33:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH] block: remove per-disk debugfs files in blk_unregister_queue
Date:   Tue, 24 May 2022 10:33:25 +0200
Message-Id: <20220524083325.833981-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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
 block/blk-mq-debugfs.c  |  8 ++------
 block/blk-mq-debugfs.h  |  5 -----
 block/blk-rq-qos.c      |  2 --
 block/blk-sysfs.c       | 15 +++++++--------
 kernel/trace/blktrace.c |  3 ---
 5 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7e4136a60e1cc..f7eaa5405e4b5 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -713,6 +713,8 @@ void blk_mq_debugfs_register(struct request_queue *q)
 
 void blk_mq_debugfs_unregister(struct request_queue *q)
 {
+	/* all entries were removed by the caller */
+	q->rqos_debugfs_dir = NULL;
 	q->sched_debugfs_dir = NULL;
 }
 
@@ -833,12 +835,6 @@ void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
 	debugfs_create_files(rqos->debugfs_dir, rqos, rqos->ops->debugfs_attrs);
 }
 
-void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q)
-{
-	debugfs_remove_recursive(q->rqos_debugfs_dir);
-	q->rqos_debugfs_dir = NULL;
-}
-
 void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
 					struct blk_mq_hw_ctx *hctx)
 {
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 69918f4170d69..401e9e9da640b 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -36,7 +36,6 @@ void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
 void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
-void blk_mq_debugfs_unregister_queue_rqos(struct request_queue *q);
 #else
 static inline void blk_mq_debugfs_register(struct request_queue *q)
 {
@@ -87,10 +86,6 @@ static inline void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
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
index e83af7bc75919..d3a75693adbf4 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -294,8 +294,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 
 void rq_qos_exit(struct request_queue *q)
 {
-	blk_mq_debugfs_unregister_queue_rqos(q);
-
 	while (q->rq_qos) {
 		struct rq_qos *rqos = q->rq_qos;
 		q->rq_qos = rqos->next;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 88bd41d4cb593..c02fec8e9a3f6 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -779,14 +779,6 @@ static void blk_release_queue(struct kobject *kobj)
 	if (queue_is_mq(q))
 		blk_mq_release(q);
 
-	blk_trace_shutdown(q);
-	mutex_lock(&q->debugfs_mutex);
-	debugfs_remove_recursive(q->debugfs_dir);
-	mutex_unlock(&q->debugfs_mutex);
-
-	if (queue_is_mq(q))
-		blk_mq_debugfs_unregister(q);
-
 	bioset_exit(&q->bio_split);
 
 	if (blk_queue_has_srcu(q))
@@ -951,5 +943,12 @@ void blk_unregister_queue(struct gendisk *disk)
 
 	mutex_unlock(&q->sysfs_dir_lock);
 
+	mutex_lock(&q->debugfs_mutex);
+	blk_trace_shutdown(q);
+	debugfs_remove_recursive(q->debugfs_dir);
+	if (queue_is_mq(q))
+		blk_mq_debugfs_unregister(q);
+	mutex_unlock(&q->debugfs_mutex);
+
 	kobject_put(&disk_to_dev(disk)->kobj);
 }
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 10a32b0f2deb6..fe04c6f96ca5d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -770,14 +770,11 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
  **/
 void blk_trace_shutdown(struct request_queue *q)
 {
-	mutex_lock(&q->debugfs_mutex);
 	if (rcu_dereference_protected(q->blk_trace,
 				      lockdep_is_held(&q->debugfs_mutex))) {
 		__blk_trace_startstop(q, 0);
 		__blk_trace_remove(q);
 	}
-
-	mutex_unlock(&q->debugfs_mutex);
 }
 
 #ifdef CONFIG_BLK_CGROUP
-- 
2.30.2

