Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE800C433E1
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 18:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA27720758
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 18:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtL9SLht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgHTSEX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:04:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29142 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726823AbgHTSET (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 14:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597946658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eL10uHVyVHoPAiXMn74Rxzn2yLdMaTQyOhdyA9IG3K4=;
        b=dtL9SLhtLAUdxBJKXZ2A5ET1pPLBQKlkfRa+9k0fVte/1vkZOqdRwbkbf8KVC16YVzOWs0
        a0FQE1Pq4IUeO/Jmik/qg3JVgkif0vUjF/A1QVRlq4g0+l8/dTIEeFZc331jr0je9VL7Sx
        LjssgZyDiZSNTvB1l2Ma7w85nKW//kA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-S7Qj0WbtPOeaiCWVUjO1eg-1; Thu, 20 Aug 2020 14:04:14 -0400
X-MC-Unique: S7Qj0WbtPOeaiCWVUjO1eg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E35F801ADD;
        Thu, 20 Aug 2020 18:04:12 +0000 (UTC)
Received: from localhost (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 195265DA30;
        Thu, 20 Aug 2020 18:04:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/5] blk-mq: check and shrink freed request pool page
Date:   Fri, 21 Aug 2020 02:03:35 +0800
Message-Id: <20200820180335.3109216-6-ming.lei@redhat.com>
In-Reply-To: <20200820180335.3109216-1-ming.lei@redhat.com>
References: <20200820180335.3109216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

request pool pages may take a bit more space, and each request queue may
hold one unused request pool at most, so memory waste can be big when
there are lots of request queues.

Schedule a delayed work to check if tags->rqs[] still may refer to
page in freed request pool page. If no any request in tags->rqs[] refers
to the freed request pool page, release the page now. Otherwise,
schedule the delayed work after 10 seconds for check & release the
pages.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 55 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 56 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c644f5cb1549..2865920086ea 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2365,11 +2365,63 @@ static void blk_mq_release_rqs_page(struct page *page)
 	__free_pages(page, blk_mq_rqs_page_order(page));
 }
 
+#define SHRINK_RQS_PAGE_DELAY   (10 * HZ)
+
 static void blk_mq_free_rqs_page(struct blk_mq_tag_set *set, struct page *page)
 {
 	spin_lock(&set->free_page_list_lock);
 	list_add_tail(&page->lru, &set->free_page_list);
 	spin_unlock(&set->free_page_list_lock);
+
+	schedule_delayed_work(&set->rqs_page_shrink, SHRINK_RQS_PAGE_DELAY);
+}
+
+static bool blk_mq_can_shrink_rqs_page(struct blk_mq_tag_set *set,
+               struct page *pg)
+{
+	unsigned hctx_idx = blk_mq_rqs_page_hctx_idx(pg);
+	struct blk_mq_tags *tags = set->tags[hctx_idx];
+	unsigned long start = (unsigned long)page_address(pg);
+	unsigned long end = start + order_to_size(blk_mq_rqs_page_order(pg));
+	int i;
+
+	for (i = 0; i < set->queue_depth; i++) {
+		unsigned long rq_addr = (unsigned long)tags->rqs[i];
+		if (rq_addr >= start && rq_addr < end)
+			return false;
+	}
+	return true;
+}
+
+static void blk_mq_rqs_page_shrink_work(struct work_struct *work)
+{
+	struct blk_mq_tag_set *set =
+		container_of(work, struct blk_mq_tag_set, rqs_page_shrink.work);
+	LIST_HEAD(pg_list);
+	struct page *page, *tmp;
+	bool resched;
+
+	spin_lock(&set->free_page_list_lock);
+	list_splice_init(&set->free_page_list, &pg_list);
+	spin_unlock(&set->free_page_list_lock);
+
+	mutex_lock(&set->tag_list_lock);
+	list_for_each_entry_safe(page, tmp, &pg_list, lru) {
+		if (blk_mq_can_shrink_rqs_page(set, page)) {
+			list_del_init(&page->lru);
+			blk_mq_release_rqs_page(page);
+		}
+	}
+	mutex_unlock(&set->tag_list_lock);
+
+	spin_lock(&set->free_page_list_lock);
+	list_splice_init(&pg_list, &set->free_page_list);
+	resched = !list_empty(&set->free_page_list);
+	spin_unlock(&set->free_page_list_lock);
+
+	if (resched)
+		schedule_delayed_work(&set->rqs_page_shrink,
+				SHRINK_RQS_PAGE_DELAY);
 }
 
 static void blk_mq_release_all_rqs_page(struct blk_mq_tag_set *set)
@@ -2377,6 +2429,8 @@ static void blk_mq_release_all_rqs_page(struct blk_mq_tag_set *set)
 	struct page *page;
 	LIST_HEAD(pg_list);
 
+	cancel_delayed_work_sync(&set->rqs_page_shrink);
+
 	spin_lock(&set->free_page_list_lock);
 	list_splice_init(&set->free_page_list, &pg_list);
 	spin_unlock(&set->free_page_list_lock);
@@ -3527,6 +3581,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 
 	spin_lock_init(&set->free_page_list_lock);
 	INIT_LIST_HEAD(&set->free_page_list);
+	INIT_DELAYED_WORK(&set->rqs_page_shrink, blk_mq_rqs_page_shrink_work);
 
 	ret = blk_mq_alloc_map_and_requests(set);
 	if (ret)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4c2b135dbbe1..b2adf99dbbef 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -250,6 +250,7 @@ struct blk_mq_tag_set {
 
 	spinlock_t		free_page_list_lock;
 	struct list_head	free_page_list;
+	struct delayed_work     rqs_page_shrink;
 };
 
 /**
-- 
2.25.2

