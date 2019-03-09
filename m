Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62783C43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 01:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301C420857
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 01:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfCIBiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:38:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfCIBiE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 20:38:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DA173087BAF;
        Sat,  9 Mar 2019 01:38:04 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCA77608CC;
        Sat,  9 Mar 2019 01:38:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/6] block: check if page is mergeable in one helper
Date:   Sat,  9 Mar 2019 09:37:34 +0800
Message-Id: <20190309013737.27741-4-ming.lei@redhat.com>
In-Reply-To: <20190309013737.27741-1-ming.lei@redhat.com>
References: <20190309013737.27741-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sat, 09 Mar 2019 01:38:04 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now the check for deciding if one page is mergeable to current bvec
becomes a bit complicated, and we need to reuse the code before
adding pc page.

So move the check in one dedicated helper.

No function change.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d8f48188937c..62411877224c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -647,6 +647,24 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 }
 EXPORT_SYMBOL(bio_clone_fast);
 
+static inline bool
+page_is_mergeable(const struct bio_vec *bv, struct page *page,
+		unsigned int len, unsigned int off, bool same_page)
+{
+	phys_addr_t vec_end_addr = page_to_phys(bv->bv_page) +
+		bv->bv_offset + bv->bv_len - 1;
+	phys_addr_t page_addr = page_to_phys(page);
+
+	if (vec_end_addr + 1 != page_addr + off)
+		return false;
+	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
+		return false;
+	if (same_page && (vec_end_addr & PAGE_MASK) != page_addr)
+		return false;
+
+	return true;
+}
+
 /**
  *	bio_add_pc_page	-	attempt to add page to bio
  *	@q: the target queue
@@ -770,20 +788,12 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 
 	if (bio->bi_vcnt > 0) {
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
-		phys_addr_t vec_end_addr = page_to_phys(bv->bv_page) +
-			bv->bv_offset + bv->bv_len - 1;
-		phys_addr_t page_addr = page_to_phys(page);
-
-		if (vec_end_addr + 1 != page_addr + off)
-			return false;
-		if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
-			return false;
-		if (same_page && (vec_end_addr & PAGE_MASK) != page_addr)
-			return false;
-
-		bv->bv_len += len;
-		bio->bi_iter.bi_size += len;
-		return true;
+
+		if (page_is_mergeable(bv, page, len, off, same_page)) {
+			bv->bv_len += len;
+			bio->bi_iter.bi_size += len;
+			return true;
+		}
 	}
 	return false;
 }
-- 
2.9.5

