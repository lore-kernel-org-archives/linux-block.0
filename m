Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACE2C433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 13:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C956128B
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 13:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbhDLNrT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbhDLNrT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 09:47:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B685C061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RJwWlUuntGJu9dP/0ZitYZKI+BkhwkgTc5pA0FYErEk=; b=PlAFcpHgWouYIAdSVGdtuqrjPj
        KWAf52KVsf8aJn7vLGHmA3bdXrT2DXp6Rd2imbYo7BLO8RnHHerx/kyfdrqtl48pik7D3l/HAHGE2
        a8wmzDJF8RnuwU/Xo3jtHJgpSbROmRUoMFS6SiouuC/EdOqby1d4h5YEhXbXOKonMWgzmDE3D8i2M
        pMd/joORaSm3pxwW9E4Kx8TxGF+tPlTr3RkJvy5ZZqcs3Oz2zCBY4Jm/rtfwCTwhqSLTcjbVUUJAH
        rkQbe0gWX2C6lFUH7MxHatlg2pWB1cAneYqplbrlIfgVULcmXO7HcCSLUoyMG80wKt9TINYegIst9
        FRLOVRzw==;
Received: from [2001:4bb8:199:e2bd:3218:1918:85d1:2852] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVwu4-006HHi-DN; Mon, 12 Apr 2021 13:47:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: remove zero_fill_bio_iter
Date:   Mon, 12 Apr 2021 15:46:57 +0200
Message-Id: <20210412134658.2623190-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

zero_fill_bio_iter is only used to implement zero_fill_bio, so
remove the indirection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 6 +++---
 include/linux/bio.h | 7 +------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 26b7f721cda88b..0fecb80872c23f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -493,20 +493,20 @@ struct bio *bio_kmalloc(gfp_t gfp_mask, unsigned short nr_iovecs)
 }
 EXPORT_SYMBOL(bio_kmalloc);
 
-void zero_fill_bio_iter(struct bio *bio, struct bvec_iter start)
+void zero_fill_bio(struct bio *bio)
 {
 	unsigned long flags;
 	struct bio_vec bv;
 	struct bvec_iter iter;
 
-	__bio_for_each_segment(bv, bio, iter, start) {
+	bio_for_each_segment(bv, bio, iter) {
 		char *data = bvec_kmap_irq(&bv, &flags);
 		memset(data, 0, bv.bv_len);
 		flush_dcache_page(bv.bv_page);
 		bvec_kunmap_irq(data, &flags);
 	}
 }
-EXPORT_SYMBOL(zero_fill_bio_iter);
+EXPORT_SYMBOL(zero_fill_bio);
 
 /**
  * bio_truncate - truncate the bio to small size of @new_size
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d0246c92a6e865..a8021d79d45d1f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -485,14 +485,9 @@ extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 extern void bio_copy_data(struct bio *dst, struct bio *src);
 extern void bio_list_copy_data(struct bio *dst, struct bio *src);
 extern void bio_free_pages(struct bio *bio);
-void zero_fill_bio_iter(struct bio *bio, struct bvec_iter iter);
 void bio_truncate(struct bio *bio, unsigned new_size);
 void guard_bio_eod(struct bio *bio);
-
-static inline void zero_fill_bio(struct bio *bio)
-{
-	zero_fill_bio_iter(bio, bio->bi_iter);
-}
+void zero_fill_bio(struct bio *bio);
 
 extern const char *bio_devname(struct bio *bio, char *buffer);
 
-- 
2.30.1

