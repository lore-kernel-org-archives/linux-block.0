Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF54C4321E
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 12:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhK3Mun (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 07:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhK3MuZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 07:50:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDEDC061759
        for <linux-block@vger.kernel.org>; Tue, 30 Nov 2021 04:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6awz+KTH6K8Gbow65xcfkEOlvwbnrYcVy3c8n+wdDkM=; b=Iut4JgOFqdqaZSWXcFXoyNibt7
        mUfOtNUS/GfSzx0yF4U+Gk/VeGRtQiRd6UcMDynzrra2fyWlQ/WzKyR4OhNcnAU+PseZcMwu0BpeV
        3SMKJaeuZKY2kKm1U1+ogySjrxYEAtIW8iHZE7SIOovLsFNKEnNgMpamPWSDqY2NVV/tvnK6rh/BN
        v+vzNSsbfdyswmEVd5mdYbJs5g7/jaKmA9xE/Af3Vkf/e2FqSr97X8Eez6HIHyc73F2rRf1tg+Jbe
        /fHCS0B8Rf7kBVFmRLwjjteKfUZgteVxDYV9EgUWXINLzPtXzeJHq+8egaLNJhp+aSJSLi1skJjCC
        cVgj+ZLg==;
Received: from [2001:4bb8:184:4a23:f08:7851:5d49:c683] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms2X5-00CFdf-Rm; Tue, 30 Nov 2021 12:46:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 7/7] block: only build the icq tracking code when needed
Date:   Tue, 30 Nov 2021 13:46:36 +0100
Message-Id: <20211130124636.2505904-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130124636.2505904-1-hch@lst.de>
References: <20211130124636.2505904-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only bfq needs to code to track icq, so make it conditional.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Kconfig             |  3 ++
 block/Kconfig.iosched     |  1 +
 block/blk-ioc.c           | 64 ++++++++++++++++++++++++---------------
 block/blk.h               |  6 ++++
 include/linux/iocontext.h |  6 ++--
 5 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index c6ce41a5e5b27..d5d4197b7ed2d 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -35,6 +35,9 @@ config BLK_CGROUP_RWSTAT
 config BLK_DEV_BSG_COMMON
 	tristate
 
+config BLK_ICQ
+	bool
+
 config BLK_DEV_BSGLIB
 	bool "Block layer SG support v4 helper lib"
 	select BLK_DEV_BSG_COMMON
diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 885fee86dfcae..6155161460862 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -18,6 +18,7 @@ config MQ_IOSCHED_KYBER
 
 config IOSCHED_BFQ
 	tristate "BFQ I/O scheduler"
+	select BLK_ICQ
 	help
 	BFQ I/O scheduler for BLK-MQ. BFQ distributes the bandwidth of
 	of the device among all processes according to their weights,
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 32ae006e1b3e8..5f99b9c833328 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -30,6 +30,7 @@ static void get_io_context(struct io_context *ioc)
 	atomic_long_inc(&ioc->refcount);
 }
 
+#ifdef CONFIG_BLK_ICQ
 static void icq_free_icq_rcu(struct rcu_head *head)
 {
 	struct io_cq *icq = container_of(head, struct io_cq, __rcu_head);
@@ -161,6 +162,40 @@ static bool ioc_delay_free(struct io_context *ioc)
 	return false;
 }
 
+/**
+ * ioc_clear_queue - break any ioc association with the specified queue
+ * @q: request_queue being cleared
+ *
+ * Walk @q->icq_list and exit all io_cq's.
+ */
+void ioc_clear_queue(struct request_queue *q)
+{
+	LIST_HEAD(icq_list);
+
+	spin_lock_irq(&q->queue_lock);
+	list_splice_init(&q->icq_list, &icq_list);
+	spin_unlock_irq(&q->queue_lock);
+
+	while (!list_empty(&icq_list)) {
+		struct io_cq *icq =
+			list_entry(icq_list.next, struct io_cq, q_node);
+
+		spin_lock_irq(&icq->ioc->lock);
+		if (!(icq->flags & ICQ_DESTROYED))
+			ioc_destroy_icq(icq);
+		spin_unlock_irq(&icq->ioc->lock);
+	}
+}
+#else /* CONFIG_BLK_ICQ */
+static inline void ioc_exit_icqs(struct io_context *ioc)
+{
+}
+static inline bool ioc_delay_free(struct io_context *ioc)
+{
+	return false;
+}
+#endif /* CONFIG_BLK_ICQ */
+
 /**
  * put_io_context - put a reference of io_context
  * @ioc: io_context to put
@@ -192,31 +227,6 @@ void exit_io_context(struct task_struct *task)
 	}
 }
 
-/**
- * ioc_clear_queue - break any ioc association with the specified queue
- * @q: request_queue being cleared
- *
- * Walk @q->icq_list and exit all io_cq's.
- */
-void ioc_clear_queue(struct request_queue *q)
-{
-	LIST_HEAD(icq_list);
-
-	spin_lock_irq(&q->queue_lock);
-	list_splice_init(&q->icq_list, &icq_list);
-	spin_unlock_irq(&q->queue_lock);
-
-	while (!list_empty(&icq_list)) {
-		struct io_cq *icq =
-			list_entry(icq_list.next, struct io_cq, q_node);
-
-		spin_lock_irq(&icq->ioc->lock);
-		if (!(icq->flags & ICQ_DESTROYED))
-			ioc_destroy_icq(icq);
-		spin_unlock_irq(&icq->ioc->lock);
-	}
-}
-
 static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
 {
 	struct io_context *ioc;
@@ -228,10 +238,12 @@ static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
 
 	atomic_long_set(&ioc->refcount, 1);
 	atomic_set(&ioc->active_ref, 1);
+#ifdef CONFIG_BLK_ICQ
 	spin_lock_init(&ioc->lock);
 	INIT_RADIX_TREE(&ioc->icq_tree, GFP_ATOMIC);
 	INIT_HLIST_HEAD(&ioc->icq_list);
 	INIT_WORK(&ioc->release_work, ioc_release_fn);
+#endif
 	return ioc;
 }
 
@@ -316,6 +328,7 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
+#ifdef CONFIG_BLK_ICQ
 /**
  * ioc_lookup_icq - lookup io_cq from ioc
  * @q: the associated request_queue
@@ -441,3 +454,4 @@ static int __init blk_ioc_init(void)
 	return 0;
 }
 subsys_initcall(blk_ioc_init);
+#endif /* CONFIG_BLK_ICQ */
diff --git a/block/blk.h b/block/blk.h
index a55d82c3d1c21..39e822537d1a8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -365,7 +365,13 @@ static inline unsigned int bio_aligned_discard_max_sectors(
  */
 struct io_cq *ioc_find_get_icq(struct request_queue *q);
 struct io_cq *ioc_lookup_icq(struct request_queue *q);
+#ifdef CONFIG_BLK_ICQ
 void ioc_clear_queue(struct request_queue *q);
+#else
+static inline void ioc_clear_queue(struct request_queue *q)
+{
+}
+#endif /* CONFIG_BLK_ICQ */
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index 82c7f4f5f4f59..ef98a994b7b2e 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -100,16 +100,18 @@ struct io_context {
 	atomic_long_t refcount;
 	atomic_t active_ref;
 
+	unsigned short ioprio;
+
+#ifdef CONFIG_BLK_ICQ
 	/* all the fields below are protected by this lock */
 	spinlock_t lock;
 
-	unsigned short ioprio;
-
 	struct radix_tree_root	icq_tree;
 	struct io_cq __rcu	*icq_hint;
 	struct hlist_head	icq_list;
 
 	struct work_struct release_work;
+#endif /* CONFIG_BLK_ICQ */
 };
 
 struct task_struct;
-- 
2.30.2

