Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D99AC2D0F8
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 03:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3595E205ED
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 03:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpn4YGSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgEMDtA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 23:49:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35672 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727107AbgEMDtA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 23:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589341739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uLqS0yyxOJBQJd9pqTgMlI3LiIt9PX4rxkrzPTZC2A4=;
        b=bpn4YGSEaLA/kff/pynVdRB8Jxmr/h6WOIEVrQI6XJ0c6+tadgQqWKhXroCh64nczXCKHo
        GokQot/nMoIKDhvl7jsQauI6Z71KiiVvXB7Fm+Gz9SoXt7TOUSF4hXWz5YrtUz2ksI8F1p
        WBKvN14pGJxptG/+aSO/5kvCX5sDULA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-1_4_wLChPti8Q6EeLwDKng-1; Tue, 12 May 2020 23:48:55 -0400
X-MC-Unique: 1_4_wLChPti8Q6EeLwDKng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13CA680183C;
        Wed, 13 May 2020 03:48:54 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E6265D9DD;
        Wed, 13 May 2020 03:48:50 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH V11 05/12] blk-mq: add blk_mq_all_tag_iter
Date:   Wed, 13 May 2020 11:47:56 +0800
Message-Id: <20200513034803.1844579-6-ming.lei@redhat.com>
In-Reply-To: <20200513034803.1844579-1-ming.lei@redhat.com>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now request is thought as in-flight only when its state is updated as
MQ_RQ_IN_FLIGHT, which is done by driver via blk_mq_start_request().

Actually from blk-mq's view, one rq can be thought as in-flight
after its tag is >= 0.

Add one new function of blk_mq_all_tag_iter so that we can iterate
every in-flight request, and this way is more flexible since caller
can decide to handle request according to rq's state.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c | 33 +++++++++++++++++++++++++++++----
 block/blk-mq-tag.h |  2 ++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 586c9d6e904a..c27c6dfc7d36 100644
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
index 2b8321efb682..d19546e8246b 100644
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
2.25.2

