Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F007C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 13:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D550206A1
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 13:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qj+dJ1xe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgE2Nxi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 09:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgE2Nxi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 09:53:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65842C03E969
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=n3z5MKZysiyzCKBDq/4GL+288P4VjBjN0mO282hG2jU=; b=qj+dJ1xe+LnIAoqD5bN9FMmDz/
        VVLwdzMPH9fwnWOcZ+tpg3HTf+A4iWeE9t6ObehuGpmOvLdCIBxo0kEBEjzec3D6fETP2777xL+1l
        nPd7ZEB1CAaz0/NRNMzc+jitoik+p0K/3vgncYa/Hpb3Frfi95TlHNpwpe1I36GpT5AGhn5KPFc97
        DbBZ5GQOv6Rnnh+bCOn+HylKsDSzc3PzMGs7uIedmOJE62gt+o0wPOMWyVxCfFtdTrZqCnuIvg9dR
        2KfdLZ4BNklCcjOdpBKtzo6sT4JZgqaCvObc+NWKqBimimyO9BKpWBdP1nWKoBqnW3tttR07xCfd7
        RWFn9iFw==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jefS4-0000qc-Ih; Fri, 29 May 2020 13:53:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 7/8] blk-mq: add blk_mq_all_tag_iter
Date:   Fri, 29 May 2020 15:53:14 +0200
Message-Id: <20200529135315.199230-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529135315.199230-1-hch@lst.de>
References: <20200529135315.199230-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Add a new blk_mq_all_tag_iter function to iterate over all allocated
scheduler tags and driver tags.  This is more flexible than the existing
blk_mq_all_tag_busy_iter function as it allows the callers to do whatever
they want on allocated request instead of being limited to started
requests.

It will be used to implement draining allocated requests on specified
hctx in this patchset.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
[hch: switch from the two booleans to a more readable flags field and
 consolidate the tags iter functions]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 block/blk-mq-tag.c | 50 +++++++++++++++++++++++++++++-----------------
 block/blk-mq-tag.h |  2 ++
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 597ff9c27cf63..762198b62088c 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -256,14 +256,17 @@ struct bt_tags_iter_data {
 	struct blk_mq_tags *tags;
 	busy_tag_iter_fn *fn;
 	void *data;
-	bool reserved;
+	unsigned int flags;
 };
 
+#define BT_TAG_ITER_RESERVED		(1 << 0)
+#define BT_TAG_ITER_STARTED		(1 << 1)
+
 static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
 	struct bt_tags_iter_data *iter_data = data;
 	struct blk_mq_tags *tags = iter_data->tags;
-	bool reserved = iter_data->reserved;
+	bool reserved = iter_data->flags & BT_TAG_ITER_RESERVED;
 	struct request *rq;
 
 	if (!reserved)
@@ -274,10 +277,12 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * test and set the bit before assining ->rqs[].
 	 */
 	rq = tags->rqs[bitnr];
-	if (rq && blk_mq_request_started(rq))
-		return iter_data->fn(rq, iter_data->data, reserved);
-
-	return true;
+	if (!rq)
+		return true;
+	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
+	    !blk_mq_request_started(rq))
+		return true;
+	return iter_data->fn(rq, iter_data->data, reserved);
 }
 
 /**
@@ -290,39 +295,47 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		@reserved) where rq is a pointer to a request. Return true
  *		to continue iterating tags, false to stop.
  * @data:	Will be passed as second argument to @fn.
- * @reserved:	Indicates whether @bt is the breserved_tags member or the
- *		bitmap_tags member of struct blk_mq_tags.
+ * @flags:	BT_TAG_ITER_*
  */
 static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
-			     busy_tag_iter_fn *fn, void *data, bool reserved)
+			     busy_tag_iter_fn *fn, void *data, unsigned int flags)
 {
 	struct bt_tags_iter_data iter_data = {
 		.tags = tags,
 		.fn = fn,
 		.data = data,
-		.reserved = reserved,
+		.flags = flags,
 	};
 
 	if (tags->rqs)
 		sbitmap_for_each_set(&bt->sb, bt_tags_iter, &iter_data);
 }
 
+static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
+		busy_tag_iter_fn *fn, void *priv, unsigned int flags)
+{
+	WARN_ON_ONCE(flags & BT_TAG_ITER_RESERVED);
+
+	if (tags->nr_reserved_tags)
+		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv,
+				 flags | BT_TAG_ITER_RESERVED);
+	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, flags);
+}
+
 /**
- * blk_mq_all_tag_busy_iter - iterate over all started requests in a tag map
+ * blk_mq_all_tag_iter - iterate over all requests in a tag map
  * @tags:	Tag map to iterate over.
- * @fn:		Pointer to the function that will be called for each started
+ * @fn:		Pointer to the function that will be called for each
  *		request. @fn will be called as follows: @fn(rq, @priv,
  *		reserved) where rq is a pointer to a request. 'reserved'
  *		indicates whether or not @rq is a reserved request. Return
  *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
  */
-static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
-		busy_tag_iter_fn *fn, void *priv)
+void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+		void *priv)
 {
-	if (tags->nr_reserved_tags)
-		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
-	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
+	return __blk_mq_all_tag_iter(tags, fn, priv, 0);
 }
 
 /**
@@ -342,7 +355,8 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 
 	for (i = 0; i < tagset->nr_hw_queues; i++) {
 		if (tagset->tags && tagset->tags[i])
-			blk_mq_all_tag_busy_iter(tagset->tags[i], fn, priv);
+			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
+					      BT_TAG_ITER_STARTED);
 	}
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 8a741752af8b9..d38e48f2a0a4a 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -34,6 +34,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
+void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+		void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)
-- 
2.26.2

