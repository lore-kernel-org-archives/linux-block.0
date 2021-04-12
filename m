Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4337C433B4
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 13:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B686128C
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 13:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbhDLNrV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbhDLNrV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 09:47:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EE0C061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 06:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+KPOzbRovCWWdcOVpH+J8XXS1zZ8AMcVTA8H/cCHtuU=; b=iB0qMduX9vFo5z8Rqx6PW86pVg
        WVgA95T35WtvN66KAuiLA80CtMe9rH/nV78GPBcKGa8pNMsr+HHxyf6YhUlPc5dMT7nok9s/pi7k8
        sipsyLfYLMKIzFXMoNybgHs4Iy4P4PgGzJVHGiHWykAP72TczxjkrljxVpUfzBabAKcmD/+iZHo6l
        592ZKAfXEvLvZDLBxkYvOZ6S+S5Wt5GOBU4EcwD7nE4yoTKCAuFPegGfsdbPjG/Z2FRmxq06b3Ywx
        PEyAjzvmqe0mPTxrdyMvuWzKFtjC2QxjZ+YJNBqNRxZEVYet5U8wGL3qUxzlnh7OcU8ogPsnARar6
        0SZ1w2xA==;
Received: from [2001:4bb8:199:e2bd:3218:1918:85d1:2852] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVwu6-006HHm-UW; Mon, 12 Apr 2021 13:47:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: move bio_list_copy_data to pktcdvd
Date:   Mon, 12 Apr 2021 15:46:58 +0200
Message-Id: <20210412134658.2623190-2-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210412134658.2623190-1-hch@lst.de>
References: <20210412134658.2623190-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bio_list_copy_data is only used by pktcdvd, so move it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c             | 37 -------------------------------------
 drivers/block/pktcdvd.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/bio.h     |  1 -
 3 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 0fecb80872c23f..303298996afeb4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1221,43 +1221,6 @@ void bio_copy_data(struct bio *dst, struct bio *src)
 }
 EXPORT_SYMBOL(bio_copy_data);
 
-/**
- * bio_list_copy_data - copy contents of data buffers from one chain of bios to
- * another
- * @src: source bio list
- * @dst: destination bio list
- *
- * Stops when it reaches the end of either the @src list or @dst list - that is,
- * copies min(src->bi_size, dst->bi_size) bytes (or the equivalent for lists of
- * bios).
- */
-void bio_list_copy_data(struct bio *dst, struct bio *src)
-{
-	struct bvec_iter src_iter = src->bi_iter;
-	struct bvec_iter dst_iter = dst->bi_iter;
-
-	while (1) {
-		if (!src_iter.bi_size) {
-			src = src->bi_next;
-			if (!src)
-				break;
-
-			src_iter = src->bi_iter;
-		}
-
-		if (!dst_iter.bi_size) {
-			dst = dst->bi_next;
-			if (!dst)
-				break;
-
-			dst_iter = dst->bi_iter;
-		}
-
-		bio_copy_data_iter(dst, &dst_iter, src, &src_iter);
-	}
-}
-EXPORT_SYMBOL(bio_list_copy_data);
-
 void bio_free_pages(struct bio *bio)
 {
 	struct bio_vec *bvec;
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index fc4b0f1aa86dfb..bd35565851224f 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1199,6 +1199,42 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 	return 1;
 }
 
+/**
+ * bio_list_copy_data - copy contents of data buffers from one chain of bios to
+ * another
+ * @src: source bio list
+ * @dst: destination bio list
+ *
+ * Stops when it reaches the end of either the @src list or @dst list - that is,
+ * copies min(src->bi_size, dst->bi_size) bytes (or the equivalent for lists of
+ * bios).
+ */
+static void bio_list_copy_data(struct bio *dst, struct bio *src)
+{
+	struct bvec_iter src_iter = src->bi_iter;
+	struct bvec_iter dst_iter = dst->bi_iter;
+
+	while (1) {
+		if (!src_iter.bi_size) {
+			src = src->bi_next;
+			if (!src)
+				break;
+
+			src_iter = src->bi_iter;
+		}
+
+		if (!dst_iter.bi_size) {
+			dst = dst->bi_next;
+			if (!dst)
+				break;
+
+			dst_iter = dst->bi_iter;
+		}
+
+		bio_copy_data_iter(dst, &dst_iter, src, &src_iter);
+	}
+}
+
 /*
  * Assemble a bio to write one packet and queue the bio for processing
  * by the underlying block device.
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a8021d79d45d1f..a0b4cfdf62a434 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -483,7 +483,6 @@ extern void bio_check_pages_dirty(struct bio *bio);
 extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 			       struct bio *src, struct bvec_iter *src_iter);
 extern void bio_copy_data(struct bio *dst, struct bio *src);
-extern void bio_list_copy_data(struct bio *dst, struct bio *src);
 extern void bio_free_pages(struct bio *bio);
 void bio_truncate(struct bio *bio, unsigned new_size);
 void guard_bio_eod(struct bio *bio);
-- 
2.30.1

