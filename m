Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78F8C4360F
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EA82173C
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MRVZN7cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfCRTs2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:48:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfCRTs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PE9NVhdTnO4X7DaQ4s+zXFb8TEgZkxJvR8ZbXjbcyLE=; b=MRVZN7cff6nY05Dc2+fRSaUE8
        l+h4RqTylDYpMedZA8ls33tiv+LszU4hijxHKQcfRBbkC6zAJZ3WNOOfNIHz9npPDmmKf/zaEpwse
        MugaFovorxBactpyyO4nuIOzQFYemuTA5BRj8JM1XSF+bhHQ2XRMv1IMr+wTX8h0xBtrLeiMdjopT
        JKdPeYcS14QqeB8QApKz8v8tE6IDnOdoTgCz1ojeH5gEWdzoTuJ43kRX/OVe0mtQj+t6A9+tHED0e
        zveWyPXg83x25aF+pUgCtA1JRdDqWyy4kSLQtOC3rFYaZ5RvphTndoKTKKFVT7hQAJGCCsnaJCq7i
        IZj5P6RRA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5yFI-0000vO-9G; Mon, 18 Mar 2019 19:48:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 04/14] blk-ioc: Convert to XArray
Date:   Mon, 18 Mar 2019 12:48:11 -0700
Message-Id: <20190318194821.3470-5-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190318194821.3470-1-willy@infradead.org>
References: <20190318194821.3470-1-willy@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use xa_insert_irq() to do the allocation before grabbing the other
locks.  This user appears to be able to race, so use xa_cmpxchg() to
handle the race effectively.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 block/blk-ioc.c           | 23 +++++++++++++----------
 include/linux/iocontext.h |  6 +++---
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 5ed59ac6ae58..1db53c371b14 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -65,7 +65,7 @@ static void ioc_destroy_icq(struct io_cq *icq)
 
 	lockdep_assert_held(&ioc->lock);
 
-	radix_tree_delete(&ioc->icq_tree, icq->q->id);
+	xa_erase(&ioc->icq_array, icq->q->id);
 	hlist_del_init(&icq->ioc_node);
 	list_del_init(&icq->q_node);
 
@@ -255,7 +255,7 @@ int create_task_io_context(struct task_struct *task, gfp_t gfp_flags, int node)
 	atomic_set(&ioc->nr_tasks, 1);
 	atomic_set(&ioc->active_ref, 1);
 	spin_lock_init(&ioc->lock);
-	INIT_RADIX_TREE(&ioc->icq_tree, GFP_ATOMIC);
+	xa_init_flags(&ioc->icq_array, XA_FLAGS_LOCK_IRQ);
 	INIT_HLIST_HEAD(&ioc->icq_list);
 	INIT_WORK(&ioc->release_work, ioc_release_fn);
 
@@ -339,7 +339,7 @@ struct io_cq *ioc_lookup_icq(struct io_context *ioc, struct request_queue *q)
 	if (icq && icq->q == q)
 		goto out;
 
-	icq = radix_tree_lookup(&ioc->icq_tree, q->id);
+	icq = xa_load(&ioc->icq_array, q->id);
 	if (icq && icq->q == q)
 		rcu_assign_pointer(ioc->icq_hint, icq);	/* allowed to race */
 	else
@@ -366,7 +366,7 @@ struct io_cq *ioc_create_icq(struct io_context *ioc, struct request_queue *q,
 			     gfp_t gfp_mask)
 {
 	struct elevator_type *et = q->elevator->type;
-	struct io_cq *icq;
+	struct io_cq *icq, *curr;
 
 	/* allocate stuff */
 	icq = kmem_cache_alloc_node(et->icq_cache, gfp_mask | __GFP_ZERO,
@@ -374,10 +374,14 @@ struct io_cq *ioc_create_icq(struct io_context *ioc, struct request_queue *q,
 	if (!icq)
 		return NULL;
 
-	if (radix_tree_maybe_preload(gfp_mask) < 0) {
+	if (xa_insert_irq(&ioc->icq_array, q->id, NULL, gfp_mask) == -ENOMEM) {
 		kmem_cache_free(et->icq_cache, icq);
 		return NULL;
 	}
+	/*
+	 * If we get -EBUSY, we're racing with another caller; we'll see
+	 * who wins the race below.
+	 */
 
 	icq->ioc = ioc;
 	icq->q = q;
@@ -388,21 +392,20 @@ struct io_cq *ioc_create_icq(struct io_context *ioc, struct request_queue *q,
 	spin_lock_irq(&q->queue_lock);
 	spin_lock(&ioc->lock);
 
-	if (likely(!radix_tree_insert(&ioc->icq_tree, q->id, icq))) {
+	curr = xa_cmpxchg(&ioc->icq_array, q->id, XA_ZERO_ENTRY, icq,
+			GFP_ATOMIC);
+	if (likely(!curr)) {
 		hlist_add_head(&icq->ioc_node, &ioc->icq_list);
 		list_add(&icq->q_node, &q->icq_list);
 		if (et->ops.init_icq)
 			et->ops.init_icq(icq);
 	} else {
 		kmem_cache_free(et->icq_cache, icq);
-		icq = ioc_lookup_icq(ioc, q);
-		if (!icq)
-			printk(KERN_ERR "cfq: icq link failed!\n");
+		icq = curr;
 	}
 
 	spin_unlock(&ioc->lock);
 	spin_unlock_irq(&q->queue_lock);
-	radix_tree_preload_end();
 	return icq;
 }
 
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index dba15ca8e60b..e16224f70084 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -2,9 +2,9 @@
 #ifndef IOCONTEXT_H
 #define IOCONTEXT_H
 
-#include <linux/radix-tree.h>
 #include <linux/rcupdate.h>
 #include <linux/workqueue.h>
+#include <linux/xarray.h>
 
 enum {
 	ICQ_EXITED		= 1 << 2,
@@ -56,7 +56,7 @@ enum {
  * - ioc->icq_list and icq->ioc_node are protected by ioc lock.
  *   q->icq_list and icq->q_node by q lock.
  *
- * - ioc->icq_tree and ioc->icq_hint are protected by ioc lock, while icq
+ * - ioc->icq_array and ioc->icq_hint are protected by ioc lock, while icq
  *   itself is protected by q lock.  However, both the indexes and icq
  *   itself are also RCU managed and lookup can be performed holding only
  *   the q lock.
@@ -111,7 +111,7 @@ struct io_context {
 	int nr_batch_requests;     /* Number of requests left in the batch */
 	unsigned long last_waited; /* Time last woken after wait for request */
 
-	struct radix_tree_root	icq_tree;
+	struct xarray		icq_array;
 	struct io_cq __rcu	*icq_hint;
 	struct hlist_head	icq_list;
 
-- 
2.20.1

