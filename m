Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8033FC43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 10:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE952085A
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 10:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfCQKBn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:01:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfCQKBn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 06:01:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1BCE30A1877;
        Sun, 17 Mar 2019 10:01:43 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0E065DA2A;
        Sun, 17 Mar 2019 10:01:40 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 04/10] block: cleanup bio_add_pc_page
Date:   Sun, 17 Mar 2019 18:01:06 +0800
Message-Id: <20190317100112.8106-5-ming.lei@redhat.com>
In-Reply-To: <20190317100112.8106-1-ming.lei@redhat.com>
References: <20190317100112.8106-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 17 Mar 2019 10:01:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

REQ_PC is out of date, so replace it with passthrough IO.

Also remove the local variable of 'prev' since we can reuse
the top local variable of 'bvec'.

No function change.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d8f48188937c..c94a3d30bc85 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -648,7 +648,7 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 EXPORT_SYMBOL(bio_clone_fast);
 
 /**
- *	bio_add_pc_page	-	attempt to add page to bio
+ *	bio_add_pc_page	-	attempt to add page to passthrough bio
  *	@q: the target queue
  *	@bio: destination bio
  *	@page: page to add
@@ -660,7 +660,7 @@ EXPORT_SYMBOL(bio_clone_fast);
  *	limitations. The target block device must allow bio's up to PAGE_SIZE,
  *	so it is always possible to add a single page to an empty bio.
  *
- *	This should only be used by REQ_PC bios.
+ *	This should only be used by passthrough bios.
  */
 int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
 		    *page, unsigned int len, unsigned int offset)
@@ -683,11 +683,11 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
 	 * a consecutive offset.  Optimize this special case.
 	 */
 	if (bio->bi_vcnt > 0) {
-		struct bio_vec *prev = &bio->bi_io_vec[bio->bi_vcnt - 1];
+		bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
-		if (page == prev->bv_page &&
-		    offset == prev->bv_offset + prev->bv_len) {
-			prev->bv_len += len;
+		if (page == bvec->bv_page &&
+		    offset == bvec->bv_offset + bvec->bv_len) {
+			bvec->bv_len += len;
 			bio->bi_iter.bi_size += len;
 			goto done;
 		}
@@ -696,7 +696,7 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
 		 */
-		if (bvec_gap_to_prev(q, prev, offset))
+		if (bvec_gap_to_prev(q, bvec, offset))
 			return 0;
 	}
 
-- 
2.9.5

