Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9500EC10F00
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684BD2173C
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b5DUZZrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfCRTs3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:48:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfCRTs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HUYEO5ur+32RD/K2a2FafWDPVSUmsO63N6kkWm9XTiw=; b=b5DUZZrLtWb1JD2Yc93oX0+TH
        cyE4yKK2jCA7f5Wsz9WsjyK2HUC5KSdOsBIJ0FoTMP9x56ntJwShbq6fDElwYn02GAJqE+IPn0lKi
        gJMnjpj23a6lOjIxKFGcHtvREAWjSvozL82KLrc/Gcl/DYjdRMiHw9dt2E/7kBwnP6b40EhUmnx+e
        IZdFNKBwTMgzHvHIPd+VD0R+Gpl702hzYY3mEo2wa26MgkZRsUC/7v0e9QOXu3FMXxcrUWnOPMfiR
        CbFw+8/1DvXrSHXCvtRt5WGGVoehOS9zlJZoH2zmiypKOv44LrKiiOMtyQB8scXHe3owKo6wqazIl
        S4PsHB8QQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5yFI-0000vW-Ee; Mon, 18 Mar 2019 19:48:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 05/14] blk-ioc: Remove ioc's icq_list
Date:   Mon, 18 Mar 2019 12:48:12 -0700
Message-Id: <20190318194821.3470-6-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190318194821.3470-1-willy@infradead.org>
References: <20190318194821.3470-1-willy@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the XArray's iterator instead of this hlist.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 block/blk-ioc.c           | 15 ++++++---------
 include/linux/iocontext.h | 16 +++++-----------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 1db53c371b14..53da5bf9cdc2 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -66,7 +66,6 @@ static void ioc_destroy_icq(struct io_cq *icq)
 	lockdep_assert_held(&ioc->lock);
 
 	xa_erase(&ioc->icq_array, icq->q->id);
-	hlist_del_init(&icq->ioc_node);
 	list_del_init(&icq->q_node);
 
 	/*
@@ -96,6 +95,8 @@ static void ioc_release_fn(struct work_struct *work)
 	struct io_context *ioc = container_of(work, struct io_context,
 					      release_work);
 	unsigned long flags;
+	unsigned long index;
+	struct io_cq *icq;
 
 	/*
 	 * Exiting icq may call into put_io_context() through elevator
@@ -105,9 +106,7 @@ static void ioc_release_fn(struct work_struct *work)
 	 */
 	spin_lock_irqsave_nested(&ioc->lock, flags, 1);
 
-	while (!hlist_empty(&ioc->icq_list)) {
-		struct io_cq *icq = hlist_entry(ioc->icq_list.first,
-						struct io_cq, ioc_node);
+	xa_for_each(&ioc->icq_array, index, icq) {
 		struct request_queue *q = icq->q;
 
 		if (spin_trylock(&q->queue_lock)) {
@@ -148,7 +147,7 @@ void put_io_context(struct io_context *ioc)
 	 */
 	if (atomic_long_dec_and_test(&ioc->refcount)) {
 		spin_lock_irqsave(&ioc->lock, flags);
-		if (!hlist_empty(&ioc->icq_list))
+		if (!xa_empty(&ioc->icq_array))
 			queue_work(system_power_efficient_wq,
 					&ioc->release_work);
 		else
@@ -170,6 +169,7 @@ void put_io_context(struct io_context *ioc)
 void put_io_context_active(struct io_context *ioc)
 {
 	unsigned long flags;
+	unsigned long index;
 	struct io_cq *icq;
 
 	if (!atomic_dec_and_test(&ioc->active_ref)) {
@@ -183,7 +183,7 @@ void put_io_context_active(struct io_context *ioc)
 	 * explanation on the nested locking annotation.
 	 */
 	spin_lock_irqsave_nested(&ioc->lock, flags, 1);
-	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node) {
+	xa_for_each(&ioc->icq_array, index, icq) {
 		if (icq->flags & ICQ_EXITED)
 			continue;
 
@@ -256,7 +256,6 @@ int create_task_io_context(struct task_struct *task, gfp_t gfp_flags, int node)
 	atomic_set(&ioc->active_ref, 1);
 	spin_lock_init(&ioc->lock);
 	xa_init_flags(&ioc->icq_array, XA_FLAGS_LOCK_IRQ);
-	INIT_HLIST_HEAD(&ioc->icq_list);
 	INIT_WORK(&ioc->release_work, ioc_release_fn);
 
 	/*
@@ -386,7 +385,6 @@ struct io_cq *ioc_create_icq(struct io_context *ioc, struct request_queue *q,
 	icq->ioc = ioc;
 	icq->q = q;
 	INIT_LIST_HEAD(&icq->q_node);
-	INIT_HLIST_NODE(&icq->ioc_node);
 
 	/* lock both q and ioc and try to link @icq */
 	spin_lock_irq(&q->queue_lock);
@@ -395,7 +393,6 @@ struct io_cq *ioc_create_icq(struct io_context *ioc, struct request_queue *q,
 	curr = xa_cmpxchg(&ioc->icq_array, q->id, XA_ZERO_ENTRY, icq,
 			GFP_ATOMIC);
 	if (likely(!curr)) {
-		hlist_add_head(&icq->ioc_node, &ioc->icq_list);
 		list_add(&icq->q_node, &q->icq_list);
 		if (et->ops.init_icq)
 			et->ops.init_icq(icq);
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index e16224f70084..bc054ab9b273 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -53,8 +53,7 @@ enum {
  *
  * - ioc lock nests inside q lock.
  *
- * - ioc->icq_list and icq->ioc_node are protected by ioc lock.
- *   q->icq_list and icq->q_node by q lock.
+ * - q->icq_list and icq->q_node are protected by q lock.
  *
  * - ioc->icq_array and ioc->icq_hint are protected by ioc lock, while icq
  *   itself is protected by q lock.  However, both the indexes and icq
@@ -74,19 +73,15 @@ struct io_cq {
 	struct io_context	*ioc;
 
 	/*
-	 * q_node and ioc_node link io_cq through icq_list of q and ioc
-	 * respectively.  Both fields are unused once ioc_exit_icq() is
-	 * called and shared with __rcu_icq_cache and __rcu_head which are
-	 * used for RCU free of io_cq.
+	 * q_node links io_cq through the icq_list of q.
+	 * It is unused once ioc_exit_icq() is called so it is shared with
+	 * __rcu_icq_cache which is used for RCU free of io_cq.
 	 */
 	union {
 		struct list_head	q_node;
 		struct kmem_cache	*__rcu_icq_cache;
 	};
-	union {
-		struct hlist_node	ioc_node;
-		struct rcu_head		__rcu_head;
-	};
+	struct rcu_head		__rcu_head;
 
 	unsigned int		flags;
 };
@@ -113,7 +108,6 @@ struct io_context {
 
 	struct xarray		icq_array;
 	struct io_cq __rcu	*icq_hint;
-	struct hlist_head	icq_list;
 
 	struct work_struct release_work;
 };
-- 
2.20.1

