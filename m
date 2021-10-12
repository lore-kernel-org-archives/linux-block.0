Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA8C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC121610A2
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhJLQW4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhJLQWv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:22:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B82C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KRCOR9HDWz6GZpWNOlzUOWD0YxBV6P7XAePg5SdNoDY=; b=RcbrgHIkWMm+16UsiGUvBp+XdY
        v0847lUGaFMLCA+fSl0Jz+2qvQ3gPItlMbr7VYAIeERwo9cCuKf7msDMoO/yXIKBjzxMr2n4UK+yC
        g62RRNBp8wHzcEAHYk/CwfPpPsqGGeNyosOnZcM9fM+8pxBnMtdydg8EMIhLw965ktVhKsI1iWrp9
        SLU4VFmXlHvKMVVPHiE+bJxjfZTQ1UPnClgvyWbdpuAnxON5v3QdEpdCVHV6PuZAw0Vm4S/+wLWbB
        RZff5Owqj0xfqhM80LruYc2OCqH/xpCpJ7syQIzL6/VPYLPTRHu+9BWLHO6cu1PYYOThN0iwnORn1
        /WIHDmkA==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maKV5-006e0g-CR; Tue, 12 Oct 2021 16:19:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/8] block: remove BIO_BUG_ON
Date:   Tue, 12 Oct 2021 18:17:57 +0200
Message-Id: <20211012161804.991559-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012161804.991559-1-hch@lst.de>
References: <20211012161804.991559-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BIO_DEBUG is always defined, so just switch the two instances to use
BUG_ON directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 4 ++--
 include/linux/bio.h | 8 --------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a6fb6a0b42955..35b875563c8ba 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -156,7 +156,7 @@ static void bio_put_slab(struct bio_set *bs)
 
 void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned short nr_vecs)
 {
-	BIO_BUG_ON(nr_vecs > BIO_MAX_VECS);
+	BUG_ON(nr_vecs > BIO_MAX_VECS);
 
 	if (nr_vecs == BIO_MAX_VECS)
 		mempool_free(bv, pool);
@@ -677,7 +677,7 @@ static void bio_alloc_cache_destroy(struct bio_set *bs)
 void bio_put(struct bio *bio)
 {
 	if (unlikely(bio_flagged(bio, BIO_REFFED))) {
-		BIO_BUG_ON(!atomic_read(&bio->__bi_cnt));
+		BUG_ON(!atomic_read(&bio->__bi_cnt));
 		if (!atomic_dec_and_test(&bio->__bi_cnt))
 			return;
 	}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 00952e92eae1b..65a356fa71109 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -11,14 +11,6 @@
 #include <linux/blk_types.h>
 #include <linux/uio.h>
 
-#define BIO_DEBUG
-
-#ifdef BIO_DEBUG
-#define BIO_BUG_ON	BUG_ON
-#else
-#define BIO_BUG_ON
-#endif
-
 #define BIO_MAX_VECS		256U
 
 static inline unsigned int bio_max_segs(unsigned int nr_segs)
-- 
2.30.2

