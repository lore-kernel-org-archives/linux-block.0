Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B890C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2869161050
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhJLQ3A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLQ25 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:28:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C9BC061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=V/tW/JMBZnFxiUxNvC36u/viV5qoKIhZ2JdTHPrLISE=; b=N1MpdoJcb2pEqpax1c+pDs+kv7
        VzuOaVTbqgXfZt+eeXlOrpscI0mKrp3bRzkGsNkLbCVrK1z0qCp/CisZ1ICV2oYqK6azAiJW0cRHP
        ApUzkWNIjryK6rjde6KSMdIEb5V/KOGjWfX+jUH4Gce9MIdUXShD2d1bo0VjYgzNYi2TfXk/Wz21Q
        0z5UayRIQVI/yULI0FGdYQEJfa1WpGtEIhGv0bngZRvw7p+92XyMnM9ODQV0hpwMsLDue6UOasEtX
        ED4k6Uxoc0lcHpLr6zNC8cu+5AzVmzkbiU0Sg4mNYX8C9Zv78IVPCefDbkUmrvGFEOAqKV3z7BvTg
        KKMUfkXw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maKbI-006eHz-QF; Tue, 12 Oct 2021 16:26:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 7/8] block: move bio_get_{first,last}_bvec out of bio.h
Date:   Tue, 12 Oct 2021 18:18:03 +0200
Message-Id: <20211012161804.991559-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012161804.991559-1-hch@lst.de>
References: <20211012161804.991559-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_get_first_bvec and bio_get_last_bvec are only used in blk-merge.c,
so move them there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c   | 31 +++++++++++++++++++++++++++++++
 include/linux/bio.h | 31 -------------------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index bf7aedaad8f8e..14ce19607cd8a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -15,6 +15,37 @@
 #include "blk-rq-qos.h"
 #include "blk-throttle.h"
 
+static inline void bio_get_first_bvec(struct bio *bio, struct bio_vec *bv)
+{
+	*bv = mp_bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
+}
+
+static inline void bio_get_last_bvec(struct bio *bio, struct bio_vec *bv)
+{
+	struct bvec_iter iter = bio->bi_iter;
+	int idx;
+
+	bio_get_first_bvec(bio, bv);
+	if (bv->bv_len == bio->bi_iter.bi_size)
+		return;		/* this bio only has a single bvec */
+
+	bio_advance_iter(bio, &iter, iter.bi_size);
+
+	if (!iter.bi_bvec_done)
+		idx = iter.bi_idx - 1;
+	else	/* in the middle of bvec */
+		idx = iter.bi_idx;
+
+	*bv = bio->bi_io_vec[idx];
+
+	/*
+	 * iter.bi_bvec_done records actual length of the last bvec
+	 * if this bio ends in the middle of one io vector
+	 */
+	if (iter.bi_bvec_done)
+		bv->bv_len = iter.bi_bvec_done;
+}
+
 static inline bool bio_will_gap(struct request_queue *q,
 		struct request *prev_rq, struct bio *prev, struct bio *next)
 {
diff --git a/include/linux/bio.h b/include/linux/bio.h
index faa0a2fabaf08..4c5106f2ed57e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -221,37 +221,6 @@ static inline void bio_clear_flag(struct bio *bio, unsigned int bit)
 	bio->bi_flags &= ~(1U << bit);
 }
 
-static inline void bio_get_first_bvec(struct bio *bio, struct bio_vec *bv)
-{
-	*bv = mp_bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
-}
-
-static inline void bio_get_last_bvec(struct bio *bio, struct bio_vec *bv)
-{
-	struct bvec_iter iter = bio->bi_iter;
-	int idx;
-
-	bio_get_first_bvec(bio, bv);
-	if (bv->bv_len == bio->bi_iter.bi_size)
-		return;		/* this bio only has a single bvec */
-
-	bio_advance_iter(bio, &iter, iter.bi_size);
-
-	if (!iter.bi_bvec_done)
-		idx = iter.bi_idx - 1;
-	else	/* in the middle of bvec */
-		idx = iter.bi_idx;
-
-	*bv = bio->bi_io_vec[idx];
-
-	/*
-	 * iter.bi_bvec_done records actual length of the last bvec
-	 * if this bio ends in the middle of one io vector
-	 */
-	if (iter.bi_bvec_done)
-		bv->bv_len = iter.bi_bvec_done;
-}
-
 static inline struct bio_vec *bio_first_bvec_all(struct bio *bio)
 {
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
-- 
2.30.2

