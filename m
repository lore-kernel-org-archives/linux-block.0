Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7448FC10F14
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 10:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435D2208E3
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 10:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LLoZqKCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfDHKrQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:47:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHKrQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 06:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=caKqIysjwPngf2dEiv7LYGwskh2cfe4iXlPMxcz+BDQ=; b=LLoZqKCjAR3qMmAhJzDsfO3HpU
        j+D8MvbVSFobNucBHI7Vtqg2QRmnSLBOhMqjpatG3MUtN8YwWa0M1NM9xku2DLbfqF4jE/OU9O3MR
        inkhv0D7oRMFaAvQPzxZTzW1NDqwdeAE0a/GrKrMzg05SRCocFh2ht+swcB9IkdLFblExTInHHwsQ
        Xsryc/DgJALm9G8e5BJNvZVAu+vx2awjPt0rX2XDAP8+G67x9QYzof86U9tOaAZJCCG9fUdzboA4E
        kN6Kkom4oZPAN9AFkFCnKxl2O2JilspZDzWSqHQhQdThDjkVzpHncTmg3dOODjUD4VRP4b+ZOdItR
        czjPt99w==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDRo3-0000Sr-Dr; Mon, 08 Apr 2019 10:47:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 5/5] block: only allow contiguous page structs in a bio_vec
Date:   Mon,  8 Apr 2019 12:46:41 +0200
Message-Id: <20190408104641.4905-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408104641.4905-1-hch@lst.de>
References: <20190408104641.4905-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We currently have to call nth_page when iterating over pages inside a
bio_vec.  Jens complained a while ago that this is fairly expensive.
To mitigate this we can check that that the actual page structures
are contiguous when adding them to the bio, and just do check pointer
arithmetics later on.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c          |  9 +++++++--
 include/linux/bvec.h | 13 ++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3f78c114b5e9..110292627575 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -659,8 +659,13 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
 		return false;
-	if (same_page && (vec_end_addr & PAGE_MASK) != page_addr)
-		return false;
+
+	if ((vec_end_addr & PAGE_MASK) != page_addr) {
+		if (same_page)
+			return false;
+		if (pfn_to_page(PFN_DOWN(vec_end_addr)) + 1 != page)
+			return false;
+	}
 
 	return true;
 }
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 307bbda62b7b..44b0f4684190 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -51,11 +51,6 @@ struct bvec_iter_all {
 	unsigned	done;
 };
 
-static inline struct page *bvec_nth_page(struct page *page, int idx)
-{
-	return idx == 0 ? page : nth_page(page, idx);
-}
-
 /*
  * various member access, note that bio_data should of course not be used
  * on highmem page vectors
@@ -92,8 +87,8 @@ static inline struct page *bvec_nth_page(struct page *page, int idx)
 	      PAGE_SIZE - bvec_iter_offset((bvec), (iter)))
 
 #define bvec_iter_page(bvec, iter)				\
-	bvec_nth_page(mp_bvec_iter_page((bvec), (iter)),		\
-		      mp_bvec_iter_page_idx((bvec), (iter)))
+	(mp_bvec_iter_page((bvec), (iter)) +			\
+	 mp_bvec_iter_page_idx((bvec), (iter)))
 
 #define bvec_iter_bvec(bvec, iter)				\
 ((struct bio_vec) {						\
@@ -157,7 +152,7 @@ static inline void mp_bvec_next_segment(const struct bio_vec *bvec,
 	struct bio_vec *bv = &iter_all->bv;
 
 	if (bv->bv_page) {
-		bv->bv_page = nth_page(bv->bv_page, 1);
+		bv->bv_page++;
 		bv->bv_offset = 0;
 	} else {
 		bv->bv_page = bvec->bv_page;
@@ -177,7 +172,7 @@ static inline void mp_bvec_last_segment(const struct bio_vec *bvec,
 	unsigned total = bvec->bv_offset + bvec->bv_len;
 	unsigned last_page = (total - 1) / PAGE_SIZE;
 
-	seg->bv_page = bvec_nth_page(bvec->bv_page, last_page);
+	seg->bv_page = bvec->bv_page + last_page;
 
 	/* the whole segment is inside the last page */
 	if (bvec->bv_offset >= last_page * PAGE_SIZE) {
-- 
2.20.1

