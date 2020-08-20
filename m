Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA305C433E3
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 18:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9792220758
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 18:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ty3XH/wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHTSEN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:04:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29233 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726896AbgHTSEM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 14:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597946650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5mNKDz1d5pHiay+d89sspIYQiLMJirre9aMGaiCb24=;
        b=Ty3XH/wkSgGTj/Wq+YXdA/L491/5ZhmYyCTkL2hechK8zHWcEkEGV00W0KfMC2FL9B1JKE
        mumwa0WqrzFSrTMHj/G80JwUrDfHlF4QfrVNeC4pA1A75js4QRSWbnhzghnOSM0xAvFl85
        rZLFRPCAfrctt/4FbQ49pxe+oSEKzno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-h4KVqlJHNTCV70T9uPcSaw-1; Thu, 20 Aug 2020 14:04:08 -0400
X-MC-Unique: h4KVqlJHNTCV70T9uPcSaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D4D71074649;
        Thu, 20 Aug 2020 18:04:07 +0000 (UTC)
Received: from localhost (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B9F374E08;
        Thu, 20 Aug 2020 18:04:05 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/5] blk-mq: cache freed request pool pages
Date:   Fri, 21 Aug 2020 02:03:34 +0800
Message-Id: <20200820180335.3109216-5-ming.lei@redhat.com>
In-Reply-To: <20200820180335.3109216-1-ming.lei@redhat.com>
References: <20200820180335.3109216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_queue_tag_busy_iter() and blk_mq_tagset_busy_iter() may iterate
request via driver tag. However, driver tag allocation and updating
tags->rqs[tag] can't be done atomically, meantime we don't clear
tags->rqs[tag] before releasing the driver tag in fast path. So the
two iterator functions may see stale request via tags->rq[tag], and the
stale request may have been freed via blk_mq_update_nr_requests() or
elevator switch, then use-after-free warning is triggered.

Fix this issue by caching freed request pool pages in one dedicated
per-tagset list, and always try to allocate request pool pages first from
the cached pages.

Memory waste may be caused, and at most one request pool pages is wasted
for each request queue when request queue elevator is switched to none
from real io sched.

The following patch will add one simple mechanism for reclaiming these
unused pages for allocating request pool.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 98 ++++++++++++++++++++++++++++++++++++------
 include/linux/blk-mq.h |  3 ++
 2 files changed, 87 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 65f73b8db477..c644f5cb1549 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2280,12 +2280,58 @@ static size_t order_to_size(unsigned int order)
 	return (size_t)PAGE_SIZE << order;
 }
 
-static struct page *blk_mq_alloc_rqs_page(int node, unsigned order,
-		unsigned min_size)
+#define MAX_RQS_PAGE_ORDER 4
+
+static void blk_mq_mark_rqs_page(struct page *page, unsigned order,
+		unsigned hctx_idx)
+{
+	WARN_ON_ONCE(order > MAX_RQS_PAGE_ORDER);
+	WARN_ON_ONCE(hctx_idx > (ULONG_MAX >> fls(MAX_RQS_PAGE_ORDER)));
+
+	page->private = (hctx_idx << fls(MAX_RQS_PAGE_ORDER)) | order;
+}
+
+static unsigned blk_mq_rqs_page_order(struct page *page)
+{
+	return page->private & ((1 << fls(MAX_RQS_PAGE_ORDER)) - 1);
+}
+
+static unsigned blk_mq_rqs_page_hctx_idx(struct page *page)
+{
+	return page->private >> fls(MAX_RQS_PAGE_ORDER);
+}
+
+static struct page *blk_mq_alloc_rqs_page_from_cache(
+		struct blk_mq_tag_set *set, unsigned hctx_idx)
+{
+	struct page *page = NULL, *tmp;
+
+	spin_lock(&set->free_page_list_lock);
+	list_for_each_entry(tmp, &set->free_page_list, lru) {
+		if (blk_mq_rqs_page_hctx_idx(tmp) == hctx_idx) {
+			page = tmp;
+			break;
+		}
+	}
+	if (page)
+		list_del_init(&page->lru);
+	spin_unlock(&set->free_page_list_lock);
+
+	return page;
+}
+
+static struct page *blk_mq_alloc_rqs_page(struct blk_mq_tag_set *set,
+		unsigned hctx_idx, unsigned order, unsigned min_size)
 {
 	struct page *page;
 	unsigned this_order = order;
+	int node;
+
+	page = blk_mq_alloc_rqs_page_from_cache(set, hctx_idx);
+	if (page)
+		return page;
 
+	node = blk_mq_get_hw_queue_node(set, hctx_idx);
 	do {
 		page = alloc_pages_node(node,
 			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO,
@@ -2301,7 +2347,7 @@ static struct page *blk_mq_alloc_rqs_page(int node, unsigned order,
 	if (!page)
 		return NULL;
 
-	page->private = this_order;
+	blk_mq_mark_rqs_page(page, this_order, hctx_idx);
 
 	/*
 	 * Allow kmemleak to scan these pages as they contain pointers
@@ -2312,14 +2358,34 @@ static struct page *blk_mq_alloc_rqs_page(int node, unsigned order,
 	return page;
 }
 
-static void blk_mq_free_rqs_page(struct page *page)
+static void blk_mq_release_rqs_page(struct page *page)
 {
-	/*
-	 * Remove kmemleak object previously allocated in
-	 * blk_mq_alloc_rqs().
-	 */
+	/* Remove kmemleak object previously allocated in blk_mq_alloc_rqs() */
 	kmemleak_free(page_address(page));
-	__free_pages(page, page->private);
+	__free_pages(page, blk_mq_rqs_page_order(page));
+}
+
+static void blk_mq_free_rqs_page(struct blk_mq_tag_set *set, struct page *page)
+{
+	spin_lock(&set->free_page_list_lock);
+	list_add_tail(&page->lru, &set->free_page_list);
+	spin_unlock(&set->free_page_list_lock);
+}
+
+static void blk_mq_release_all_rqs_page(struct blk_mq_tag_set *set)
+{
+	struct page *page;
+	LIST_HEAD(pg_list);
+
+	spin_lock(&set->free_page_list_lock);
+	list_splice_init(&set->free_page_list, &pg_list);
+	spin_unlock(&set->free_page_list_lock);
+
+	while (!list_empty(&pg_list)) {
+		page = list_first_entry(&pg_list, struct page, lru);
+		list_del_init(&page->lru);
+		blk_mq_release_rqs_page(page);
+	}
 }
 
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
@@ -2343,7 +2409,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	while (!list_empty(&tags->page_list)) {
 		page = list_first_entry(&tags->page_list, struct page, lru);
 		list_del_init(&page->lru);
-		blk_mq_free_rqs_page(page);
+		blk_mq_free_rqs_page(set, page);
 	}
 }
 
@@ -2405,8 +2471,6 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	return 0;
 }
 
-#define MAX_RQS_PAGE_ORDER 4
-
 int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx, unsigned int depth)
 {
@@ -2433,11 +2497,12 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		while (this_order && left < order_to_size(this_order - 1))
 			this_order--;
 
-		page = blk_mq_alloc_rqs_page(node, this_order, rq_size);
+		page = blk_mq_alloc_rqs_page(set, hctx_idx, this_order,
+				rq_size);
 		if (!page)
 			goto fail;
 
-		this_order = (int)page->private;
+		this_order = blk_mq_rqs_page_order(page);
 		list_add_tail(&page->lru, &tags->page_list);
 		p = page_address(page);
 
@@ -3460,6 +3525,9 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (ret)
 		goto out_free_mq_map;
 
+	spin_lock_init(&set->free_page_list_lock);
+	INIT_LIST_HEAD(&set->free_page_list);
+
 	ret = blk_mq_alloc_map_and_requests(set);
 	if (ret)
 		goto out_free_mq_map;
@@ -3492,6 +3560,8 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 		set->map[j].mq_map = NULL;
 	}
 
+	blk_mq_release_all_rqs_page(set);
+
 	kfree(set->tags);
 	set->tags = NULL;
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ea3461298de5..4c2b135dbbe1 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -247,6 +247,9 @@ struct blk_mq_tag_set {
 
 	struct mutex		tag_list_lock;
 	struct list_head	tag_list;
+
+	spinlock_t		free_page_list_lock;
+	struct list_head	free_page_list;
 };
 
 /**
-- 
2.25.2

