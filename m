Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD06C433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 17:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B602070A
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 17:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fjhemfic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgETRGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 13:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgETRGu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 13:06:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50487C061A0E
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YOgPLnxi0trF2T27ttWajBoiSMUtdFP04sDh8AIhUME=; b=fjhemficTJGHahUUcXnAZ4JQy8
        suwhPeJJwPT++IWs0WrBZFvbkhAqWehoOBB9TpsZ50zKCoJoHAoh57yng1Tmo7TDBWHUFJOZwMQga
        JAiSNrhKh00/ax4APPzziOoNm456sutLq+Q3H2Sk+CNgMyHp4gGmLquO+100kOjRrOFgUJK8fT5Qa
        KFqPCxFSk0XTNkONWHw9FlZFXbNkNDfTalbluZ7hrQ85xlOSmpAOOFibSKCxhRuAbPJ//kjZl3ziy
        J1OOuHDCxNHgTJDD1beydDlVdf51DUf1M7k5LusWPqw+dd2SFaV/RDPMk4F4fSUI0GL3wFXu0ybJa
        04g5P6OA==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbSB7-00038L-F2; Wed, 20 May 2020 17:06:49 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/6] blk-mq: add blk_mq_all_tag_iter
Date:   Wed, 20 May 2020 19:06:34 +0200
Message-Id: <20200520170635.2094101-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520170635.2094101-1-hch@lst.de>
References: <20200520170635.2094101-1-hch@lst.de>
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
index 586c9d6e904ab..c27c6dfc7d36e 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -257,6 +257,7 @@ struct bt_tags_iter_data {
 	busy_tag_iter_fn *fn;
 	void *data;
 	bool reserved;
+	bool iterate_all;
 };
 
 static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
@@ -274,7 +275,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * test and set the bit before assining ->rqs[].
 	 */
 	rq = tags->rqs[bitnr];
-	if (rq && blk_mq_request_started(rq))
+	if (rq && (iter_data->iterate_all || blk_mq_request_started(rq)))
 		return iter_data->fn(rq, iter_data->data, reserved);
 
 	return true;
@@ -294,13 +295,15 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
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
@@ -321,8 +324,30 @@ static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
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
index 2b8321efb6820..d19546e8246b7 100644
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

