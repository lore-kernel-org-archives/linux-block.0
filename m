Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:43527 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbdJCV50 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 17:57:26 -0400
Received: by mail-pf0-f174.google.com with SMTP id d2so2064048pfh.0
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 14:57:26 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH] blk-mq-debugfs: fix device sched directory for default scheduler
Date: Tue,  3 Oct 2017 14:57:16 -0700
Message-Id: <602ca75f1201b062f4f05b79f3c693e30e8bd6b9.1507067772.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In blk_mq_debugfs_register(), I remembered to set up the per-hctx sched
directories if a default scheduler was already configured by
blk_mq_sched_init() from blk_mq_init_allocated_queue(), but I didn't do
the same for the device-wide sched directory. Fix it.

Fixes: d332ce091813 ("blk-mq-debugfs: allow schedulers to register debugfs attributes")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Based on v4.14-rc3.

 block/blk-mq-debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 980e73095643..de294d775acf 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -815,10 +815,14 @@ int blk_mq_debugfs_register(struct request_queue *q)
 		goto err;
 
 	/*
-	 * blk_mq_init_hctx() attempted to do this already, but q->debugfs_dir
+	 * blk_mq_init_sched() attempted to do this already, but q->debugfs_dir
 	 * didn't exist yet (because we don't know what to name the directory
 	 * until the queue is registered to a gendisk).
 	 */
+	if (q->elevator && !q->sched_debugfs_dir)
+		blk_mq_debugfs_register_sched(q);
+
+	/* Similarly, blk_mq_init_hctx() couldn't do this previously. */
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->debugfs_dir && blk_mq_debugfs_register_hctx(q, hctx))
 			goto err;
-- 
2.14.2
