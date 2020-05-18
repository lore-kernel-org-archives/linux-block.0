Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F3BC433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 06:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB53720787
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 06:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YV0jCNTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgERGkD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 02:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgERGkD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 02:40:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B6BC061A0C
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 23:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Nt0ZDAZf0BiOXAcgakNNsE1fNj4v1jpeofDbfhRTuvM=; b=YV0jCNTR+dMdaE9HQjbEiw/cQS
        V+a/wOHiMPmlpU4n35IL5s8ostTl03m8+QSFVBHAmIsPSNKzfi73RNinQUcQOxANxgekcvzxzc446
        GVpmD5UCqDgIouKfWKfxkjp1HQSr5P8bVt4zAZoWn3Iofx0N2RvH10A5kmI7gKBOZlWfJtajlYBH1
        vOZtELrfhDFyMKyCii3aNsGPW/oJ+Oz8s/niAUyc48RkNI/vMG53UyJlQMJ8/WF28kvfcDtdYMbx5
        HuepEAB7uHg6GrAoR7Aqwk9RB49/5G1wwfuJ/7mGrxW2PcNKvoDzQcXbTamODcDyTXZpGUE7Gzha4
        my0m17HA==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaZRS-0001zt-Kx; Mon, 18 May 2020 06:40:03 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 8/9] blk-mq: add blk_mq_all_tag_iter
Date:   Mon, 18 May 2020 08:39:36 +0200
Message-Id: <20200518063937.757218-9-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518063937.757218-1-hch@lst.de>
References: <20200518063937.757218-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Add one new function of blk_mq_all_tag_iter so that we can iterate every
allocated request from either io scheduler tags or driver tags, and this
way is more flexible since it allows the callers to do whatever they want
on allocated request.

It will be used to implement draining allocated requests on specified
hctx in this patchset.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-tag.c | 33 +++++++++++++++++++++++++++++----
 block/blk-mq-tag.h |  2 ++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 0cc38883618b9..b4b8d4e8e6e20 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -295,6 +295,7 @@ struct bt_tags_iter_data {
 	busy_tag_iter_fn *fn;
 	void *data;
 	bool reserved;
+	bool iterate_all;
 };
 
 static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
@@ -312,7 +313,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * test and set the bit before assining ->rqs[].
 	 */
 	rq = tags->rqs[bitnr];
-	if (rq && blk_mq_request_started(rq))
+	if (rq && (iter_data->iterate_all || blk_mq_request_started(rq)))
 		return iter_data->fn(rq, iter_data->data, reserved);
 
 	return true;
@@ -332,13 +333,15 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		bitmap_tags member of struct blk_mq_tags.
  */
 static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
-			     busy_tag_iter_fn *fn, void *data, bool reserved)
+			     busy_tag_iter_fn *fn, void *data, bool reserved,
+			     bool iterate_all)
 {
 	struct bt_tags_iter_data iter_data = {
 		.tags = tags,
 		.fn = fn,
 		.data = data,
 		.reserved = reserved,
+		.iterate_all = iterate_all,
 	};
 
 	if (tags->rqs)
@@ -359,8 +362,30 @@ static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
 		busy_tag_iter_fn *fn, void *priv)
 {
 	if (tags->nr_reserved_tags)
-		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
-	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
+		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true,
+				 false);
+	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false, false);
+}
+
+/**
+ * blk_mq_all_tag_iter - iterate over all requests in a tag map
+ * @tags:	Tag map to iterate over.
+ * @fn:		Pointer to the function that will be called for each
+ *		request. @fn will be called as follows: @fn(rq, @priv,
+ *		reserved) where rq is a pointer to a request. 'reserved'
+ *		indicates whether or not @rq is a reserved request. Return
+ *		true to continue iterating tags, false to stop.
+ * @priv:	Will be passed as second argument to @fn.
+ *
+ * It is the caller's responsibility to check rq's state in @fn.
+ */
+void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+		void *priv)
+{
+	if (tags->nr_reserved_tags)
+		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true,
+				 true);
+	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false, true);
 }
 
 /**
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index c2ad3ed637106..6465478b69a6e 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -42,6 +42,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
+void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
+		void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)
-- 
2.26.2

