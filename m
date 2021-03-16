Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCC9C433E9
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 03:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF156502E
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 03:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhCPDS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Mar 2021 23:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231309AbhCPDS0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Mar 2021 23:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615864705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v2A/PMV03yGjSXb6zLcTex0eodeOpfhdbFj6ScnnbhQ=;
        b=UCrAm5Ywj8YNmxbOBv2hbPYexWvsRXiWIHXJDpjgilvxy0Tcm8LilfJ2aEno4ldED6yx95
        v7GVN4GeKM3scTFUpfJ9dKoAN2HH6sIGoYyr5x8mNkulRQtOtZbBKj1/5mGL1XO3PeIlAl
        etmEslZHc6j+KrgTZx0DBVhNBSeisuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-0f0lJ0WBOWK-84C9rIT1fw-1; Mon, 15 Mar 2021 23:18:23 -0400
X-MC-Unique: 0f0lJ0WBOWK-84C9rIT1fw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3183680006E;
        Tue, 16 Mar 2021 03:18:22 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8401E1B472;
        Tue, 16 Mar 2021 03:18:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 05/11] block: add req flag of REQ_TAG
Date:   Tue, 16 Mar 2021 11:15:17 +0800
Message-Id: <20210316031523.864506-6-ming.lei@redhat.com>
In-Reply-To: <20210316031523.864506-1-ming.lei@redhat.com>
References: <20210316031523.864506-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one req flag REQ_TAG which will be used in the following patch for
supporting bio based IO polling.

Exactly this flag can help us to do:

1) request flag is cloned in bio_fast_clone(), so if we mark one FS bio
as REQ_TAG, all bios cloned from this FS bio will be marked as REQ_TAG.

2)create per-task io polling context if the bio based queue supports polling
and the submitted bio is HIPRI. This per-task io polling context will be
created during submit_bio() before marking this HIPRI bio as REQ_TAG. Then
we can avoid to create such io polling context if one cloned bio with REQ_TAG
is submitted from another kernel context.

3) for supporting bio based io polling, we need to poll IOs from all
underlying queues of bio device/driver, this way help us to recognize which
IOs need to polled in bio based style, which will be implemented in next
patch.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c          | 29 +++++++++++++++++++++++++++--
 include/linux/blk_types.h |  4 ++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7c7b0dba4f5c..a082bbc856fb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -828,11 +828,30 @@ void bio_poll_ctx_alloc(struct io_context *ioc)
 static inline void blk_bio_poll_preprocess(struct request_queue *q,
 		struct bio *bio)
 {
+	bool mq;
+
 	if (!(bio->bi_opf & REQ_HIPRI))
 		return;
 
-	if (!blk_queue_poll(q) || (!queue_is_mq(q) && !blk_get_bio_poll_ctx()))
+	/*
+	 * Can't support bio based IO poll without per-task poll queue
+	 *
+	 * Now we have created per-task io poll context, and mark this
+	 * bio as REQ_TAG, so: 1) if any cloned bio from this bio is
+	 * submitted from another kernel context, we won't create bio
+	 * poll context for it, so that bio will be completed by IRQ;
+	 * 2) If such bio is submitted from current context, we will
+	 * complete it via blk_poll(); 3) If driver knows that one
+	 * underlying bio allocated from driver is for FS bio, meantime
+	 * it is submitted in current context, driver can mark such bio
+	 * as REQ_TAG manually, so the bio can be completed via blk_poll
+	 * too.
+	 */
+	mq = queue_is_mq(q);
+	if (!blk_queue_poll(q) || (!mq && !blk_get_bio_poll_ctx()))
 		bio->bi_opf &= ~REQ_HIPRI;
+	else if (!mq)
+		bio->bi_opf |= REQ_TAG;
 }
 
 static noinline_for_stack bool submit_bio_checks(struct bio *bio)
@@ -881,9 +900,15 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 
 	/*
 	 * Created per-task io poll queue if we supports bio polling
-	 * and it is one HIPRI bio.
+	 * and it is one HIPRI bio, and this HIPRI bio has to be from
+	 * FS. If REQ_TAG isn't set for HIPRI bio, we think it originated
+	 * from FS.
+	 *
+	 * Driver may allocated bio by itself and REQ_TAG is set, but they
+	 * won't be marked as HIPRI.
 	 */
 	blk_create_io_context(q, blk_queue_support_bio_poll(q) &&
+			!(bio->bi_opf & REQ_TAG) &&
 			(bio->bi_opf & REQ_HIPRI));
 
 	blk_bio_poll_preprocess(q, bio);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..a1bcade4bcc3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -394,6 +394,9 @@ enum req_flag_bits {
 
 	__REQ_HIPRI,
 
+	/* for marking IOs originated from same FS bio in same context */
+	__REQ_TAG,
+
 	/* for driver use */
 	__REQ_DRV,
 	__REQ_SWAP,		/* swapping request. */
@@ -418,6 +421,7 @@ enum req_flag_bits {
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
+#define REQ_TAG			(1ULL << __REQ_TAG)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
-- 
2.29.2

