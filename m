Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B740C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 12:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359A92133D
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 12:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfB0Mkd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:40:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfB0Mkd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 07:40:33 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C16EFA8C0;
        Wed, 27 Feb 2019 12:40:33 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9952919C71;
        Wed, 27 Feb 2019 12:40:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/4] block: introduce bvec_nth_page()
Date:   Wed, 27 Feb 2019 20:40:10 +0800
Message-Id: <20190227124013.4828-2-ming.lei@redhat.com>
In-Reply-To: <20190227124013.4828-1-ming.lei@redhat.com>
References: <20190227124013.4828-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 27 Feb 2019 12:40:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Single-page bvec can often be seen in small BS workloads, so
introduce bvec_nth_page() for avoiding to call nth_page() unnecessarily,
which looks not cheap.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c    |  2 +-
 include/linux/bvec.h | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 066b66430523..c7e8a8273460 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -483,7 +483,7 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
 
 		offset = (total + bvec->bv_offset) % PAGE_SIZE;
 		idx = (total + bvec->bv_offset) / PAGE_SIZE;
-		pg = nth_page(bvec->bv_page, idx);
+		pg = bvec_nth_page(bvec->bv_page, idx);
 
 		sg_set_page(*sg, pg, seg_size, offset);
 
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 30a57b68d017..4376f683c08a 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -51,6 +51,11 @@ struct bvec_iter_all {
 	unsigned	done;
 };
 
+static inline struct page *bvec_nth_page(struct page *page, int idx)
+{
+	return idx == 0 ? page : nth_page(page, idx);
+}
+
 /*
  * various member access, note that bio_data should of course not be used
  * on highmem page vectors
@@ -87,8 +92,8 @@ struct bvec_iter_all {
 	      PAGE_SIZE - bvec_iter_offset((bvec), (iter)))
 
 #define bvec_iter_page(bvec, iter)				\
-	nth_page(mp_bvec_iter_page((bvec), (iter)),		\
-		 mp_bvec_iter_page_idx((bvec), (iter)))
+	bvec_nth_page(mp_bvec_iter_page((bvec), (iter)),		\
+		      mp_bvec_iter_page_idx((bvec), (iter)))
 
 #define bvec_iter_bvec(bvec, iter)				\
 ((struct bio_vec) {						\
@@ -171,7 +176,7 @@ static inline void mp_bvec_last_segment(const struct bio_vec *bvec,
 	unsigned total = bvec->bv_offset + bvec->bv_len;
 	unsigned last_page = (total - 1) / PAGE_SIZE;
 
-	seg->bv_page = nth_page(bvec->bv_page, last_page);
+	seg->bv_page = bvec_nth_page(bvec->bv_page, last_page);
 
 	/* the whole segment is inside the last page */
 	if (bvec->bv_offset >= last_page * PAGE_SIZE) {
-- 
2.9.5

