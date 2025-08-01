Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD9236A79
	for <linux-block@vger.kernel.org>; Fri,  1 Aug 2025 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754048712; cv=none; b=SvcptTUFO1pImQSNWycLMovZ3n7aJsDXustpzQ3qHHnebzwg1DTkBskBaOenPxii+qKIqC7+zXo36Av6gJJ12gSSbQMEhnjEya4ohdwhJZXwSn9dCmiA+xOrCSBv6dbVMXOS5krz5C8i2fDzElBnhtt+uW6L1qigvtHyPQorZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754048712; c=relaxed/simple;
	bh=W0GLT7L21pqXsWY3NHFZVgDOcw7L62pcIhguM58ouJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXOrjvj3npfROKw0RMUbTnGAIeII8ajNSi5iwRpvvNMMmTvby2wn27aleXBmFxsQ55dQlAKIjy6FsUkvWQWgwaPT9R2iOEFz9HPZgo+IszsSTdbtdlcehgQOQr285764/tI4FMCAPjFnfBh28BElvdIfcgtkTRGPjoVLAbW23UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UP+zHyzy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP+zHyzy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754048708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5kNCIyngLjYp8ys/0TOOLCDaCqKDJ0ECtt/Qtt/HwU=;
	b=UP+zHyzy/L+Yrvh3z8THbF5Tgw4ahR6poa4QoKoOcjVzizU6RlpPDly58MYGWcXGTMtdSK
	LbIFTo2iFxM/hHhgc/fRbjQWbJMloYfGMP2Zms0u6zlyq59FR/17S3PcwAeQQuvQvDvEVY
	4izhP94v24vHPAmVHBoLyWi3VEmO8dQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-KKdbHwWZNyqGzLFPE2K_uQ-1; Fri,
 01 Aug 2025 07:45:05 -0400
X-MC-Unique: KKdbHwWZNyqGzLFPE2K_uQ-1
X-Mimecast-MFC-AGG-ID: KKdbHwWZNyqGzLFPE2K_uQ_1754048704
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8767318002A5;
	Fri,  1 Aug 2025 11:45:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F9E819373D9;
	Fri,  1 Aug 2025 11:45:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	John Garry <john.garry@huawei.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/5] blk-mq: Defer freeing of tags page_list to SRCU callback
Date: Fri,  1 Aug 2025 19:44:35 +0800
Message-ID: <20250801114440.722286-4-ming.lei@redhat.com>
In-Reply-To: <20250801114440.722286-1-ming.lei@redhat.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Tag iterators can race with the freeing of the request pages(tags->page_list),
potentially leading to use-after-free issues.

Defer the freeing of the page list and the tags structure itself until
after an SRCU grace period has passed. This ensures that any concurrent
tag iterators have completed before the memory is released. With this
way, we can replace the big tags->lock in tags iterator code path with
srcu for solving the issue.

This is achieved by:
- Adding a new `srcu_struct tags_srcu` to `blk_mq_tag_set` to protect
  tag map iteration.
- Adding an `rcu_head` to `struct blk_mq_tags` to be used with
  `call_srcu`.
- Moving the page list freeing logic and the `kfree(tags)` call into a
  new callback function, `blk_mq_free_tags_callback`.
- In `blk_mq_free_tags`, invoking `call_srcu` to schedule the new
  callback for deferred execution.

The read-side protection for the tag iterators will be added in a
subsequent patch.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c     | 24 +++++++++++++++++++++++-
 block/blk-mq.c         | 26 +++++++++++++-------------
 include/linux/blk-mq.h |  2 ++
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 6fce42851f03..6c2f5881e0de 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -8,6 +8,9 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/kmemleak.h>
 
 #include <linux/delay.h>
 #include "blk.h"
@@ -576,11 +579,30 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	return NULL;
 }
 
+static void blk_mq_free_tags_callback(struct rcu_head *head)
+{
+	struct blk_mq_tags *tags = container_of(head, struct blk_mq_tags,
+						rcu_head);
+	struct page *page;
+
+	while (!list_empty(&tags->page_list)) {
+		page = list_first_entry(&tags->page_list, struct page, lru);
+		list_del_init(&page->lru);
+		/*
+		 * Remove kmemleak object previously allocated in
+		 * blk_mq_alloc_rqs().
+		 */
+		kmemleak_free(page_address(page));
+		__free_pages(page, page->private);
+	}
+	kfree(tags);
+}
+
 void blk_mq_free_tags(struct blk_mq_tag_set *set, struct blk_mq_tags *tags)
 {
 	sbitmap_queue_free(&tags->bitmap_tags);
 	sbitmap_queue_free(&tags->breserved_tags);
-	kfree(tags);
+	call_srcu(&set->tags_srcu, &tags->rcu_head, blk_mq_free_tags_callback);
 }
 
 int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 673cb534bc62..f14aa0a19ef0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3454,7 +3454,6 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx)
 {
 	struct blk_mq_tags *drv_tags;
-	struct page *page;
 
 	if (list_empty(&tags->page_list))
 		return;
@@ -3478,17 +3477,10 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	}
 
 	blk_mq_clear_rq_mapping(drv_tags, tags);
-
-	while (!list_empty(&tags->page_list)) {
-		page = list_first_entry(&tags->page_list, struct page, lru);
-		list_del_init(&page->lru);
-		/*
-		 * Remove kmemleak object previously allocated in
-		 * blk_mq_alloc_rqs().
-		 */
-		kmemleak_free(page_address(page));
-		__free_pages(page, page->private);
-	}
+	/*
+	 * Free request pages in SRCU callback, which is called from
+	 * blk_mq_free_tags().
+	 */
 }
 
 void blk_mq_free_rq_map(struct blk_mq_tag_set *set, struct blk_mq_tags *tags)
@@ -4834,6 +4826,9 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 		if (ret)
 			goto out_free_srcu;
 	}
+	ret = init_srcu_struct(&set->tags_srcu);
+	if (ret)
+		goto out_cleanup_srcu;
 
 	init_rwsem(&set->update_nr_hwq_lock);
 
@@ -4842,7 +4837,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 				 sizeof(struct blk_mq_tags *), GFP_KERNEL,
 				 set->numa_node);
 	if (!set->tags)
-		goto out_cleanup_srcu;
+		goto out_cleanup_tags_srcu;
 
 	for (i = 0; i < set->nr_maps; i++) {
 		set->map[i].mq_map = kcalloc_node(nr_cpu_ids,
@@ -4871,6 +4866,8 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	}
 	kfree(set->tags);
 	set->tags = NULL;
+out_cleanup_tags_srcu:
+	cleanup_srcu_struct(&set->tags_srcu);
 out_cleanup_srcu:
 	if (set->flags & BLK_MQ_F_BLOCKING)
 		cleanup_srcu_struct(set->srcu);
@@ -4916,6 +4913,9 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 
 	kfree(set->tags);
 	set->tags = NULL;
+
+	srcu_barrier(&set->tags_srcu);
+	cleanup_srcu_struct(&set->tags_srcu);
 	if (set->flags & BLK_MQ_F_BLOCKING) {
 		cleanup_srcu_struct(set->srcu);
 		kfree(set->srcu);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2a5a828f19a0..1325ceeb743a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -531,6 +531,7 @@ struct blk_mq_tag_set {
 	struct mutex		tag_list_lock;
 	struct list_head	tag_list;
 	struct srcu_struct	*srcu;
+	struct srcu_struct	tags_srcu;
 
 	struct rw_semaphore	update_nr_hwq_lock;
 };
@@ -767,6 +768,7 @@ struct blk_mq_tags {
 	 * request pool
 	 */
 	spinlock_t lock;
+	struct rcu_head rcu_head;
 };
 
 static inline struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags,
-- 
2.47.0

