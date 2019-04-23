Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B33AC10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CF02077C
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfDWHQE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:16:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfDWHQE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:16:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EE283092661;
        Tue, 23 Apr 2019 07:16:04 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EC861001DD2;
        Tue, 23 Apr 2019 07:16:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] block: integrity: enable multi-page bvec for bio integrity
Date:   Tue, 23 Apr 2019 15:15:49 +0800
Message-Id: <20190423071550.20806-2-ming.lei@redhat.com>
In-Reply-To: <20190423071550.20806-1-ming.lei@redhat.com>
References: <20190423071550.20806-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 23 Apr 2019 07:16:04 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio integrity's bvec is same with the normal bvec, and it is pretty
straight-forward to enable multi-page bvec for bio integrity because
bio_for_each_integrity_vec() is based on for_each_bvec() which can
handle multi-page bvec well.

The integrity buffer can't be very big, for example, the max sectors
for one bio is 2560, one sector may take at most 8bytes for integrity
info, so the max size of integrity buffer is just 20k(<=5 pages). So
not like normal multi-page bvec convertion, this patch doesn't switch
blk_rq_map_integrity_sg() to iterate over multi-page bvec.

Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio-integrity.c | 18 ++++++++++++------
 block/bio.c           | 25 -------------------------
 block/blk.h           | 26 ++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 1b633a3526d4..ba9d145315ed 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -143,18 +143,24 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 		return 0;
 	}
 
-	iv = bip->bip_vec + bip->bip_vcnt;
+	if (bip->bip_vcnt) {
+		iv = bip->bip_vec + bip->bip_vcnt - 1;
 
-	if (bip->bip_vcnt &&
-	    bvec_gap_to_prev(bio->bi_disk->queue,
-			     &bip->bip_vec[bip->bip_vcnt - 1], offset))
-		return 0;
+		if (bvec_gap_to_prev(bio->bi_disk->queue, iv, offset))
+			return 0;
 
+		if (page_is_mergeable(iv, page, len, offset, false)) {
+			iv->bv_len += len;
+			goto done;
+		}
+	}
+
+	iv = bip->bip_vec + bip->bip_vcnt;
 	iv->bv_page = page;
 	iv->bv_len = len;
 	iv->bv_offset = offset;
 	bip->bip_vcnt++;
-
+ done:
 	return len;
 }
 EXPORT_SYMBOL(bio_integrity_add_page);
diff --git a/block/bio.c b/block/bio.c
index c81ed2dfee53..89d1aa119a33 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -647,31 +647,6 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 }
 EXPORT_SYMBOL(bio_clone_fast);
 
-static inline bool page_is_mergeable(const struct bio_vec *bv,
-		struct page *page, unsigned int len, unsigned int off,
-		bool same_page)
-{
-	phys_addr_t vec_end_addr = page_to_phys(bv->bv_page) +
-		bv->bv_offset + bv->bv_len - 1;
-	phys_addr_t page_addr = page_to_phys(page);
-
-	if (vec_end_addr + 1 != page_addr + off)
-		return false;
-	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
-		return false;
-
-	if ((vec_end_addr & PAGE_MASK) != page_addr) {
-		if (same_page)
-			return false;
-		if (pfn_to_page(PFN_DOWN(vec_end_addr)) + 1 != page)
-			return false;
-	}
-
-	WARN_ON_ONCE(same_page && (len + off) > PAGE_SIZE);
-
-	return true;
-}
-
 /*
  * Check if the @page can be added to the current segment(@bv), and make
  * sure to call it only if page_is_mergeable(@bv, @page) is true
diff --git a/block/blk.h b/block/blk.h
index e27fd1512e4b..1df54fa04edf 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -324,4 +324,30 @@ void blk_queue_free_zone_bitmaps(struct request_queue *q);
 static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
 #endif
 
+static inline bool page_is_mergeable(const struct bio_vec *bv,
+		struct page *page, unsigned int len, unsigned int off,
+		bool same_page)
+{
+	phys_addr_t vec_end_addr = page_to_phys(bv->bv_page) +
+		bv->bv_offset + bv->bv_len - 1;
+	phys_addr_t page_addr = page_to_phys(page);
+
+	if (vec_end_addr + 1 != page_addr + off)
+		return false;
+	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
+		return false;
+
+	if ((vec_end_addr & PAGE_MASK) != page_addr) {
+		if (same_page)
+			return false;
+		if (pfn_to_page(PFN_DOWN(vec_end_addr)) + 1 != page)
+			return false;
+	}
+
+	WARN_ON_ONCE(same_page && (len + off) > PAGE_SIZE);
+
+	return true;
+}
+
+
 #endif /* BLK_INTERNAL_H */
-- 
2.9.5

