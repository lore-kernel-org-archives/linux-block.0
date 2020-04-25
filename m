Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCBEC55191
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B8D20728
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OEmdRsxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDYRJ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726157AbgDYRJ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 13:09:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310C4C09B04D
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wEDQHP2IWIjYIDB9jHFz/71TL1KqU5yLJOlWMxSkbqo=; b=OEmdRsxGgQLFRllmoq73GyPX51
        r034sv6aFz8UWXFCb3keemxMTzwXRoe/sGz4v4YON9U2B5YNT25bTDL8rsaAR7EYayMR7p6Fqk4y7
        RIE2i3QGgFi4I7slh3hIpwK2ebLSWxmMPp2xe2RMcDgVY8RNe+/nzKSck3uwetqjjwvUdt5WfBo4w
        qYYWJ4FN49XwAI8pXA3BYp5eMD3B4UjqV9L0eJkHTghgbyf8darmriIIQpCwpithWx09uGKeMexzE
        rmtskP2VRY8lbePiNHkKJVPsbeV2u6OONMb4YW4mnN2jSKCYABXbgKXUBCkWP2oWH+Le7xTW+v6Zq
        AVI8Scqw==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSOJS-0001kb-JO; Sat, 25 Apr 2020 17:09:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 05/11] block: refactor generic_make_request
Date:   Sat, 25 Apr 2020 19:09:38 +0200
Message-Id: <20200425170944.968861-6-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200425170944.968861-1-hch@lst.de>
References: <20200425170944.968861-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split the recursion prevention loop into its own little helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 160 ++++++++++++++++++++++++++---------------------
 1 file changed, 88 insertions(+), 72 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7f11560bfddbb..732d5b8d3cd25 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1008,6 +1008,85 @@ generic_make_request_checks(struct bio *bio)
 	return false;
 }
 
+static blk_qc_t do_make_request(struct bio *bio,
+		struct bio_list bio_list_on_stack[2])
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	struct bio_list lower, same;
+	blk_qc_t ret;
+
+	/*
+	 * Create a fresh bio_list for all subordinate requests.
+	 */
+	bio_list_on_stack[1] = bio_list_on_stack[0];
+	bio_list_init(&bio_list_on_stack[0]);
+
+	if (unlikely(bio_queue_enter(bio) != 0))
+		return BLK_QC_T_NONE;
+	if (q->make_request_fn)
+		ret = q->make_request_fn(q, bio);
+	else
+		ret = blk_mq_make_request(q, bio);
+	blk_queue_exit(q);
+
+	/*
+	 * Sort new bios into those for a lower level and those for the same
+	 * level.
+	 */
+	bio_list_init(&lower);
+	bio_list_init(&same);
+	while ((bio = bio_list_pop(&bio_list_on_stack[0])) != NULL)
+		if (q == bio->bi_disk->queue)
+			bio_list_add(&same, bio);
+		else
+			bio_list_add(&lower, bio);
+
+	/*
+	 * Now assemble so we handle the lowest level first.
+	 */
+	bio_list_merge(&bio_list_on_stack[0], &lower);
+	bio_list_merge(&bio_list_on_stack[0], &same);
+	bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
+	return ret;
+}
+
+static blk_qc_t __generic_make_request(struct bio *bio)
+{
+	/*
+	 * bio_list_on_stack[0] contains bios submitted by the current
+	 * make_request_fn.
+	 * bio_list_on_stack[1] contains bios that were submitted before the
+	 * current make_request_fn, but that haven't been processed yet.
+	 */
+	struct bio_list bio_list_on_stack[2];
+	blk_qc_t ret = BLK_QC_T_NONE;
+
+	BUG_ON(bio->bi_next);
+
+	/*
+	 * The following loop may be a bit non-obvious, and so deserves some
+	 * explanation:  Before entering the loop, bio->bi_next is NULL (as all
+	 * callers ensure that) so we have a list with a single bio.  We pretend
+	 * that we have just taken it off a longer list, so we assign bio_list
+	 * to a pointer to the bio_list_on_stack, thus initialising the bio_list
+	 * of new bios to be added.  ->make_request() may indeed add some more
+	 * bios through a recursive call to generic_make_request.  If it did, we
+	 * find a non-NULL value in bio_list and re-enter the loop from the top.
+	 * In this case we really did just take the bio of the top of the list
+	 * (no pretending) and so remove it from bio_list, and call into
+	 * ->make_request() again.
+	 */
+	bio_list_init(&bio_list_on_stack[0]);
+
+	current->bio_list = bio_list_on_stack;
+	do {
+		ret = do_make_request(bio, bio_list_on_stack);
+	} while ((bio = bio_list_pop(&bio_list_on_stack[0])));
+	current->bio_list = NULL; /* deactivate */
+
+	return ret;
+}
+
 /**
  * generic_make_request - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -1019,88 +1098,25 @@ generic_make_request_checks(struct bio *bio)
  */
 blk_qc_t generic_make_request(struct bio *bio)
 {
-	/*
-	 * bio_list_on_stack[0] contains bios submitted by the current
-	 * make_request_fn.
-	 * bio_list_on_stack[1] contains bios that were submitted before
-	 * the current make_request_fn, but that haven't been processed
-	 * yet.
-	 */
-	struct bio_list bio_list_on_stack[2];
-	blk_qc_t ret = BLK_QC_T_NONE;
-
 	if (!generic_make_request_checks(bio))
-		goto out;
+		return BLK_QC_T_NONE;
 
 	/*
 	 * We only want one ->make_request_fn to be active at a time, else
 	 * stack usage with stacked devices could be a problem.  So use
-	 * current->bio_list to keep a list of requests submited by a
-	 * make_request_fn function.  current->bio_list is also used as a
-	 * flag to say if generic_make_request is currently active in this
-	 * task or not.  If it is NULL, then no make_request is active.  If
-	 * it is non-NULL, then a make_request is active, and new requests
-	 * should be added at the tail
+	 * current->bio_list to keep a list of requests submitted by a
+	 * make_request_fn function.  current->bio_list is also used as a flag
+	 * to say if generic_make_request is currently active in this thread or
+	 * not.  If it is NULL, then no make_request is active.  If it is
+	 * non-NULL, then a make_request is active, and new requests should be
+	 * added at the tail
 	 */
 	if (current->bio_list) {
 		bio_list_add(&current->bio_list[0], bio);
-		goto out;
+		return BLK_QC_T_NONE;
 	}
 
-	/* following loop may be a bit non-obvious, and so deserves some
-	 * explanation.
-	 * Before entering the loop, bio->bi_next is NULL (as all callers
-	 * ensure that) so we have a list with a single bio.
-	 * We pretend that we have just taken it off a longer list, so
-	 * we assign bio_list to a pointer to the bio_list_on_stack,
-	 * thus initialising the bio_list of new bios to be
-	 * added.  ->make_request() may indeed add some more bios
-	 * through a recursive call to generic_make_request.  If it
-	 * did, we find a non-NULL value in bio_list and re-enter the loop
-	 * from the top.  In this case we really did just take the bio
-	 * of the top of the list (no pretending) and so remove it from
-	 * bio_list, and call into ->make_request() again.
-	 */
-	BUG_ON(bio->bi_next);
-	bio_list_init(&bio_list_on_stack[0]);
-	current->bio_list = bio_list_on_stack;
-	do {
-		struct request_queue *q = bio->bi_disk->queue;
-
-		if (likely(bio_queue_enter(bio) == 0)) {
-			struct bio_list lower, same;
-
-			/* Create a fresh bio_list for all subordinate requests */
-			bio_list_on_stack[1] = bio_list_on_stack[0];
-			bio_list_init(&bio_list_on_stack[0]);
-			if (q->make_request_fn)
-				ret = q->make_request_fn(q, bio);
-			else
-				ret = blk_mq_make_request(q, bio);
-
-			blk_queue_exit(q);
-
-			/* sort new bios into those for a lower level
-			 * and those for the same level
-			 */
-			bio_list_init(&lower);
-			bio_list_init(&same);
-			while ((bio = bio_list_pop(&bio_list_on_stack[0])) != NULL)
-				if (q == bio->bi_disk->queue)
-					bio_list_add(&same, bio);
-				else
-					bio_list_add(&lower, bio);
-			/* now assemble so we handle the lowest level first */
-			bio_list_merge(&bio_list_on_stack[0], &lower);
-			bio_list_merge(&bio_list_on_stack[0], &same);
-			bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
-		}
-		bio = bio_list_pop(&bio_list_on_stack[0]);
-	} while (bio);
-	current->bio_list = NULL; /* deactivate */
-
-out:
-	return ret;
+	return __generic_make_request(bio);
 }
 EXPORT_SYMBOL(generic_make_request);
 
-- 
2.26.1

