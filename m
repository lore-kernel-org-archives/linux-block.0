Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCEEC433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 12:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbhLWMh5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 07:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhLWMh5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 07:37:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07BCC061401
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 04:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EeH1KtiLkqiywtyTLNC7CDJ/ofYZfuyjyyPdFOAZ5LQ=; b=kVmNY2FepxlN/qJ3czxYZaV7Yz
        44hdyiv7byzmyXJEJJ8u0aj5W7DDHJ750sUhj9ntqbJllD2JEHVsS7ro/9Sn0fpvBCdww7gni0D7m
        epR4yuXVBGO2But037E+frr8iNvfRIVZWyB+xweejBJHTbJcF3eJ3aDZSr++haKLm7kGQbWF+RYi7
        Cklq6fk9TYsLA9bUB7ihxHtOO4A4DDa5KQh2Wk9ln7HozHYsPvo4YzzFH5jMwqqL+C2prroPDV6Mk
        rUZkwBx5GYl4zSP7EjtVXfrIeDiWfBo6hxa5RsKQ+r8QypLbOx+FufbxkFI7xqxjgVRUfrmrrQOOx
        uA+lTaFQ==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0NM4-00CiIp-9d; Thu, 23 Dec 2021 12:37:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: remove kblockd_mod_delayed_work_on
Date:   Thu, 23 Dec 2021 13:37:50 +0100
Message-Id: <20211223123750.1222349-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211223123750.1222349-1-hch@lst.de>
References: <20211223123750.1222349-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just open code the mod_delayed_work{,_on} calls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       |  9 +--------
 block/blk-mq.c         | 15 ++++++++-------
 block/blk.h            |  1 +
 include/linux/blkdev.h |  1 -
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 10619fd83c1bc..0978ec0a7dcc4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -71,7 +71,7 @@ struct kmem_cache *blk_requestq_srcu_cachep;
 /*
  * Controlling structure to kblockd
  */
-static struct workqueue_struct *kblockd_workqueue;
+struct workqueue_struct *kblockd_workqueue;
 
 /**
  * blk_queue_flag_set - atomically set a queue flag
@@ -1153,13 +1153,6 @@ int kblockd_schedule_work(struct work_struct *work)
 }
 EXPORT_SYMBOL(kblockd_schedule_work);
 
-int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
-				unsigned long delay)
-{
-	return mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
-}
-EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
-
 void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
 {
 	struct task_struct *tsk = current;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 565a0e6897b8f..56d049a7fc67d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1336,15 +1336,15 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 
 void blk_mq_kick_requeue_list(struct request_queue *q)
 {
-	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->requeue_work, 0);
+	mod_delayed_work(kblockd_workqueue, &q->requeue_work, 0);
 }
 EXPORT_SYMBOL(blk_mq_kick_requeue_list);
 
 void blk_mq_delay_kick_requeue_list(struct request_queue *q,
 				    unsigned long msecs)
 {
-	kblockd_mod_delayed_work_on(WORK_CPU_UNBOUND, &q->requeue_work,
-				    msecs_to_jiffies(msecs));
+	mod_delayed_work(kblockd_workqueue, &q->requeue_work,
+			 msecs_to_jiffies(msecs));
 }
 EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
@@ -2035,8 +2035,9 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 {
 	if (unlikely(blk_mq_hctx_stopped(hctx)))
 		return;
-	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
-				    msecs_to_jiffies(msecs));
+
+	mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), kblockd_workqueue,
+			    &hctx->run_work, msecs_to_jiffies(msecs));
 }
 EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
 
@@ -2079,8 +2080,8 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		put_cpu();
 	}
 
-	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
-				    0);
+	mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), kblockd_workqueue,
+			    &hctx->run_work, 0);
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
diff --git a/block/blk.h b/block/blk.h
index 8bd43b3ad33d5..25a5c9fd48114 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -12,6 +12,7 @@ struct elevator_type;
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)
 
+extern struct workqueue_struct *kblockd_workqueue;
 extern struct dentry *blk_debugfs_root;
 
 struct blk_flush_queue {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bb5fb7282e6ee..43512c8ee0972 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1167,7 +1167,6 @@ static inline unsigned int block_size(struct block_device *bdev)
 }
 
 int kblockd_schedule_work(struct work_struct *work);
-int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
 
 #define MODULE_ALIAS_BLOCKDEV(major,minor) \
 	MODULE_ALIAS("block-major-" __stringify(major) "-" __stringify(minor))
-- 
2.30.2

