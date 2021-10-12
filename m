Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBF7C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDB061050
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhJLQ1A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhJLQ07 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:26:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7559C061745
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jjIS9ynWbHJcexOFKtsUiSm14Ic3eW+OQ0CfDK4MiO0=; b=sDabltb8lSGs4BdEODnnPjPtUX
        7NFjZfUUzGdJflK0ZwFR0X89kaah8vImF6rTJwAU88Ywy20FSU+f8/JMdi/29ItLifs8UNbWUGn2w
        nbTpcqQLgiwooLxeodnaVy7/FZEjV0+RhmtTJ+2BPcAjrR+IAYu+EjXeTvnKRMTjI2rv6tEurbhAK
        35E/EdJyGW2QOpBSpSNoC028EITVr1hCuHHZ4DZyeiI5KXLpifir1TVA/ucqpqHalORz3MZC2Jq/5
        IVufAuJ7Ed8X4u6NptcihVAJxARwQk32EgyvHiC6Acg+5aIhRZbrrmCDSR7jJ24wbHzqhS6tQ9Kx5
        TpiqtOpw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maKZQ-006eE3-Dw; Tue, 12 Oct 2021 16:24:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 5/8] block: move bio_full out of bio.h
Date:   Tue, 12 Oct 2021 18:18:01 +0200
Message-Id: <20211012161804.991559-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012161804.991559-1-hch@lst.de>
References: <20211012161804.991559-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_full is only used in bio.c, so move it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 17 +++++++++++++++++
 include/linux/bio.h | 19 -------------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 35b875563c8ba..7e2899071de26 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -772,6 +772,23 @@ const char *bio_devname(struct bio *bio, char *buf)
 }
 EXPORT_SYMBOL(bio_devname);
 
+/**
+ * bio_full - check if the bio is full
+ * @bio:	bio to check
+ * @len:	length of one segment to be added
+ *
+ * Return true if @bio is full and one segment with @len bytes can't be
+ * added to the bio, otherwise return false
+ */
+static inline bool bio_full(struct bio *bio, unsigned len)
+{
+	if (bio->bi_vcnt >= bio->bi_max_vecs)
+		return true;
+	if (bio->bi_iter.bi_size > UINT_MAX - len)
+		return true;
+	return false;
+}
+
 static inline bool page_is_mergeable(const struct bio_vec *bv,
 		struct page *page, unsigned int len, unsigned int off,
 		bool *same_page)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index cffd5eba401ed..2ffc7c768091c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -77,25 +77,6 @@ static inline void *bio_data(struct bio *bio)
 	return NULL;
 }
 
-/**
- * bio_full - check if the bio is full
- * @bio:	bio to check
- * @len:	length of one segment to be added
- *
- * Return true if @bio is full and one segment with @len bytes can't be
- * added to the bio, otherwise return false
- */
-static inline bool bio_full(struct bio *bio, unsigned len)
-{
-	if (bio->bi_vcnt >= bio->bi_max_vecs)
-		return true;
-
-	if (bio->bi_iter.bi_size > UINT_MAX - len)
-		return true;
-
-	return false;
-}
-
 static inline bool bio_next_segment(const struct bio *bio,
 				    struct bvec_iter_all *iter)
 {
-- 
2.30.2

