Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9839DC433ED
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 01:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678D961107
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 01:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbhD0Brj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 21:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232295AbhD0Bri (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 21:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619488015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oAYkGvtkaN1kMLNZ/luxoR5e4ZT72nAUtlylEv+9dFQ=;
        b=Lx53k4FiTCWN2bBr+ZbXCGStunb+xJzGbUEiKK4O2Jk6kxiGEKa/0KTZDgsO1syjV/yE+A
        1c2775GI9RbQarusqd2m68Jg9fbAWZSfbvBYbfr9YYEXyzXOYK1/slndgdwS7DRJB+qP7V
        MYFVm4X/nZtzTi3D5m6FmMHOAQYSfAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-R1c4ROD3MHae8qCza8Q1pA-1; Mon, 26 Apr 2021 21:46:51 -0400
X-MC-Unique: R1c4ROD3MHae8qCza8Q1pA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C702C1098242;
        Tue, 27 Apr 2021 01:46:16 +0000 (UTC)
Received: from localhost (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A806C19D7D;
        Tue, 27 Apr 2021 01:46:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/3] blk-mq: clear stale request in tags->rq[] before freeing one request pool
Date:   Tue, 27 Apr 2021 09:45:40 +0800
Message-Id: <20210427014540.2747282-4-ming.lei@redhat.com>
In-Reply-To: <20210427014540.2747282-1-ming.lei@redhat.com>
References: <20210427014540.2747282-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

refcount_inc_not_zero() in bt_tags_iter() still may read one freed
request.

Fix the issue by the following approach:

1) hold a per-tags spinlock when reading ->rqs[tag] and calling
refcount_inc_not_zero in bt_tags_iter()

2) clearing stale request referred via ->rqs[tag] before freeing
request pool, the per-tags spinlock is held for clearing stale
->rq[tag]

So after we cleared stale requests, bt_tags_iter() won't observe
freed request any more, also the clearing will wait for pending
request reference.

The idea of clearing ->rqs[] is borrowed from John Garry's previous
patch and one recent David's patch.

Cc: John Garry <john.garry@huawei.com>
Cc: David Jeffery <djeffery@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c |  9 ++++++++-
 block/blk-mq-tag.h |  3 +++
 block/blk-mq.c     | 39 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 773aea4db90c..219bf2b10b14 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -277,9 +277,15 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	if (iter_static_rqs)
 		rq = tags->static_rqs[bitnr];
 	else {
+		unsigned long flags;
+
+		spin_lock_irqsave(&tags->lock, flags);
 		rq = tags->rqs[bitnr];
-		if (!rq || !refcount_inc_not_zero(&rq->ref))
+		if (!rq || !refcount_inc_not_zero(&rq->ref)) {
+			spin_unlock_irqrestore(&tags->lock, flags);
 			return true;
+		}
+		spin_unlock_irqrestore(&tags->lock, flags);
 	}
 	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
 	    !blk_mq_request_started(rq))
@@ -530,6 +536,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
+	spin_lock_init(&tags->lock);
 
 	if (blk_mq_is_sbitmap_shared(flags))
 		return tags;
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 7d3e6b333a4a..f942a601b5ef 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -20,6 +20,9 @@ struct blk_mq_tags {
 	struct request **rqs;
 	struct request **static_rqs;
 	struct list_head page_list;
+
+	/* used to clear rqs[] before one request pool is freed */
+	spinlock_t lock;
 };
 
 extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae06e5b3f215..418145da1740 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2299,6 +2299,38 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	return BLK_QC_T_NONE;
 }
 
+static size_t order_to_size(unsigned int order)
+{
+	return (size_t)PAGE_SIZE << order;
+}
+
+/* called before freeing request pool in @tags */
+static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
+		struct blk_mq_tags *tags, unsigned int hctx_idx)
+{
+	struct blk_mq_tags *drv_tags = set->tags[hctx_idx];
+	struct page *page;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv_tags->lock, flags);
+	list_for_each_entry(page, &tags->page_list, lru) {
+		unsigned long start = (unsigned long)page_address(page);
+		unsigned long end = start + order_to_size(page->private);
+		int i;
+
+		for (i = 0; i < set->queue_depth; i++) {
+			struct request *rq = drv_tags->rqs[i];
+			unsigned long rq_addr = (unsigned long)rq;
+
+			if (rq_addr >= start && rq_addr < end) {
+				WARN_ON_ONCE(refcount_read(&rq->ref) != 0);
+				cmpxchg(&drv_tags->rqs[i], rq, NULL);
+			}
+		}
+	}
+	spin_unlock_irqrestore(&drv_tags->lock, flags);
+}
+
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx)
 {
@@ -2317,6 +2349,8 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		}
 	}
 
+	blk_mq_clear_rq_mapping(set, tags, hctx_idx);
+
 	while (!list_empty(&tags->page_list)) {
 		page = list_first_entry(&tags->page_list, struct page, lru);
 		list_del_init(&page->lru);
@@ -2376,11 +2410,6 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
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
-- 
2.29.2

