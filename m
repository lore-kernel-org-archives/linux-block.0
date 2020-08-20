Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893D2C433DF
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 18:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68ABC20758
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 18:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EobNO1R+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHTSEO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:04:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23113 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726858AbgHTSEJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 14:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597946647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ac8F25PYSqJNC3mib8HdWVEUAXFTxNd8kR9bvEu3Ix8=;
        b=EobNO1R+pg1O94Gs9oWaC/isX2hvCJrGsJq0dluMwV8VVL20u92O1UPRYCQFdZxXsH7uKT
        dVAD16bgBVkBzGr7QdLAM6aBTd5iBchOetMo517BRTVDsC+bcoF/QFccAZcPu0GgpNBSUB
        njSHCoj7VGFOB6Q+krrV1odHkn4gXhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-Mp8j5Eb2PKq7kFekKyNp-A-1; Thu, 20 Aug 2020 14:04:05 -0400
X-MC-Unique: Mp8j5Eb2PKq7kFekKyNp-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAD531074649;
        Thu, 20 Aug 2020 18:04:03 +0000 (UTC)
Received: from localhost (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BD4710027AB;
        Thu, 20 Aug 2020 18:04:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/5] blk-mq: add helpers for allocating/freeing pages of request pool
Date:   Fri, 21 Aug 2020 02:03:33 +0800
Message-Id: <20200820180335.3109216-4-ming.lei@redhat.com>
In-Reply-To: <20200820180335.3109216-1-ming.lei@redhat.com>
References: <20200820180335.3109216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add two helpers for allocating and freeing pages of request pool.

No function change.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 81 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5019d21e7ff8..65f73b8db477 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2275,6 +2275,53 @@ static int blk_mq_get_hw_queue_node(struct blk_mq_tag_set *set,
 	return node;
 }
 
+static size_t order_to_size(unsigned int order)
+{
+	return (size_t)PAGE_SIZE << order;
+}
+
+static struct page *blk_mq_alloc_rqs_page(int node, unsigned order,
+		unsigned min_size)
+{
+	struct page *page;
+	unsigned this_order = order;
+
+	do {
+		page = alloc_pages_node(node,
+			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO,
+			this_order);
+		if (page)
+			break;
+		if (!this_order--)
+			break;
+		if (order_to_size(this_order) < min_size)
+			break;
+	} while (1);
+
+	if (!page)
+		return NULL;
+
+	page->private = this_order;
+
+	/*
+	 * Allow kmemleak to scan these pages as they contain pointers
+	 * to additional allocations like via ops->init_request().
+	 */
+	kmemleak_alloc(page_address(page), order_to_size(this_order), 1, GFP_NOIO);
+
+	return page;
+}
+
+static void blk_mq_free_rqs_page(struct page *page)
+{
+	/*
+	 * Remove kmemleak object previously allocated in
+	 * blk_mq_alloc_rqs().
+	 */
+	kmemleak_free(page_address(page));
+	__free_pages(page, page->private);
+}
+
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx)
 {
@@ -2296,12 +2343,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	while (!list_empty(&tags->page_list)) {
 		page = list_first_entry(&tags->page_list, struct page, lru);
 		list_del_init(&page->lru);
-		/*
-		 * Remove kmemleak object previously allocated in
-		 * blk_mq_alloc_rqs().
-		 */
-		kmemleak_free(page_address(page));
-		__free_pages(page, page->private);
+		blk_mq_free_rqs_page(page);
 	}
 }
 
@@ -2348,11 +2390,6 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 	return tags;
 }
 
-static size_t order_to_size(unsigned int order)
-{
-	return (size_t)PAGE_SIZE << order;
-}
-
 static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 			       unsigned int hctx_idx, int node)
 {
@@ -2396,30 +2433,14 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		while (this_order && left < order_to_size(this_order - 1))
 			this_order--;
 
-		do {
-			page = alloc_pages_node(node,
-				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO,
-				this_order);
-			if (page)
-				break;
-			if (!this_order--)
-				break;
-			if (order_to_size(this_order) < rq_size)
-				break;
-		} while (1);
-
+		page = blk_mq_alloc_rqs_page(node, this_order, rq_size);
 		if (!page)
 			goto fail;
 
-		page->private = this_order;
+		this_order = (int)page->private;
 		list_add_tail(&page->lru, &tags->page_list);
-
 		p = page_address(page);
-		/*
-		 * Allow kmemleak to scan these pages as they contain pointers
-		 * to additional allocations like via ops->init_request().
-		 */
-		kmemleak_alloc(p, order_to_size(this_order), 1, GFP_NOIO);
+
 		entries_per_page = order_to_size(this_order) / rq_size;
 		to_do = min(entries_per_page, depth - i);
 		left -= to_do * rq_size;
-- 
2.25.2

