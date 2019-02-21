Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A0C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAAB2084D
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfBUPnw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:43:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfBUPnw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 10:43:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6DCE821E2;
        Thu, 21 Feb 2019 15:43:51 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC27B60BE6;
        Thu, 21 Feb 2019 15:43:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH] block: bounce: make sure that bvec table is updated
Date:   Thu, 21 Feb 2019 23:43:36 +0800
Message-Id: <20190221154336.25037-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 21 Feb 2019 15:43:52 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Block bounce needs to allocate new page for doing IO, and the
new page has to be updated to bvec table.

Commit 6dc4f100c switches __blk_queue_bounce() to use the new
bio_for_each_segment_all() interface. Unfortunately the new
bio_for_each_segment_all() can't be used to update bvec table.

This patch fixes this issue by retrieving bvec from the table
directly, then the new allocated page can be updated to the bio.
This way is safe because the cloned bio is single page bvec.

Fixes: 6dc4f100c ("block: allow bio_for_each_segment_all() to iterate over multi-page bvec")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bounce.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index add085e28b1d..47eb7e936e22 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -295,7 +295,6 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 	bool bounce = false;
 	int sectors = 0;
 	bool passthrough = bio_is_passthrough(*bio_orig);
-	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment(from, *bio_orig, iter) {
 		if (i++ < BIO_MAX_PAGES)
@@ -315,7 +314,12 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 	bio = bounce_clone_bio(*bio_orig, GFP_NOIO, passthrough ? NULL :
 			&bounce_bio_set);
 
-	bio_for_each_segment_all(to, bio, i, iter_all) {
+	/*
+	 * Bvec table can't be updated by bio_for_each_segment_all(),
+	 * so retrieve bvec from the table directly. This way is safe
+	 * because the 'bio' is single-page bvec.
+	 */
+	for (i = 0, to = bio->bi_io_vec; i < bio->bi_vcnt; to++, i++) {
 		struct page *page = to->bv_page;
 
 		if (page_to_pfn(page) <= q->limits.bounce_pfn)
-- 
2.9.5

