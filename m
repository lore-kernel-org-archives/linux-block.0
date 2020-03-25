Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EBDC1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 15:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367E12073E
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 15:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gZc4nvnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgCYPtB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:49:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgCYPtA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 11:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7h7Vfxjyhdggp3Bds0/FcKA873p19DC35MTxQoqiTpo=; b=gZc4nvnDbcEMrcLvbOQBgChxf6
        lG3GRZQ1FIAM32KbKfyW/Ww5Tx79ohBMwQ0pZkkqVMs/5Yl8PPbm8yyw4zLcdUWucDoUjLCQGmWum
        3Ou7x0uR9CkpH0CwDjqeCiSisgPZ9Jcnv8Fn7+hi2VbR1rJ8VVoisJjjJKPfyho+/Q6CeGGgD9/HO
        huvqRj7gEn94hVG1UXt6o2ILyYn94SvNDdsjZdph37Gwk29hM6hCdz5CQRWaX/ngMSt8p4JDtBK1J
        KCV0iGNBW/AJ+ZEtxsHLR8+nnRARIXeOQp+Dg6RDoIiRGbO+M/wsLUOwZw6tEyt4ccuMgnCQdwn3X
        N2ceivPg==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH8H6-0005IZ-5Z; Wed, 25 Mar 2020 15:49:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] block: move guard_bio_eod to bio.c
Date:   Wed, 25 Mar 2020 16:48:40 +0100
Message-Id: <20200325154843.1349040-7-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325154843.1349040-1-hch@lst.de>
References: <20200325154843.1349040-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is bio layer functionality and not related to buffer heads.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 fs/buffer.c         | 43 -------------------------------------------
 fs/internal.h       |  1 -
 include/linux/bio.h |  1 +
 4 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index bc9152977bf0..11e6aac35092 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -588,6 +588,49 @@ void bio_truncate(struct bio *bio, unsigned new_size)
 	bio->bi_iter.bi_size = new_size;
 }
 
+/**
+ * guard_bio_eod - truncate a BIO to fit the block device
+ * @bio:	bio to truncate
+ *
+ * This allows us to do IO even on the odd last sectors of a device, even if the
+ * block size is some multiple of the physical sector size.
+ *
+ * We'll just truncate the bio to the size of the device, and clear the end of
+ * the buffer head manually.  Truly out-of-range accesses will turn into actual
+ * I/O errors, this only handles the "we need to be able to do I/O at the final
+ * sector" case.
+ */
+void guard_bio_eod(struct bio *bio)
+{
+	sector_t maxsector;
+	struct hd_struct *part;
+
+	rcu_read_lock();
+	part = __disk_get_part(bio->bi_disk, bio->bi_partno);
+	if (part)
+		maxsector = part_nr_sects_read(part);
+	else
+		maxsector = get_capacity(bio->bi_disk);
+	rcu_read_unlock();
+
+	if (!maxsector)
+		return;
+
+	/*
+	 * If the *whole* IO is past the end of the device,
+	 * let it through, and the IO layer will turn it into
+	 * an EIO.
+	 */
+	if (unlikely(bio->bi_iter.bi_sector >= maxsector))
+		return;
+
+	maxsector -= bio->bi_iter.bi_sector;
+	if (likely((bio->bi_iter.bi_size >> 9) <= maxsector))
+		return;
+
+	bio_truncate(bio, maxsector << 9);
+}
+
 /**
  * bio_put - release a reference to a bio
  * @bio:   bio to release reference to
diff --git a/fs/buffer.c b/fs/buffer.c
index b8d28370cfd7..3f5758e01e40 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3019,49 +3019,6 @@ static void end_bio_bh_io_sync(struct bio *bio)
 	bio_put(bio);
 }
 
-/*
- * This allows us to do IO even on the odd last sectors
- * of a device, even if the block size is some multiple
- * of the physical sector size.
- *
- * We'll just truncate the bio to the size of the device,
- * and clear the end of the buffer head manually.
- *
- * Truly out-of-range accesses will turn into actual IO
- * errors, this only handles the "we need to be able to
- * do IO at the final sector" case.
- */
-void guard_bio_eod(struct bio *bio)
-{
-	sector_t maxsector;
-	struct hd_struct *part;
-
-	rcu_read_lock();
-	part = __disk_get_part(bio->bi_disk, bio->bi_partno);
-	if (part)
-		maxsector = part_nr_sects_read(part);
-	else
-		maxsector = get_capacity(bio->bi_disk);
-	rcu_read_unlock();
-
-	if (!maxsector)
-		return;
-
-	/*
-	 * If the *whole* IO is past the end of the device,
-	 * let it through, and the IO layer will turn it into
-	 * an EIO.
-	 */
-	if (unlikely(bio->bi_iter.bi_sector >= maxsector))
-		return;
-
-	maxsector -= bio->bi_iter.bi_sector;
-	if (likely((bio->bi_iter.bi_size >> 9) <= maxsector))
-		return;
-
-	bio_truncate(bio, maxsector << 9);
-}
-
 static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 			 enum rw_hint write_hint, struct writeback_control *wbc)
 {
diff --git a/fs/internal.h b/fs/internal.h
index f3f280b952a3..4d37912a5587 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -38,7 +38,6 @@ static inline int __sync_blockdev(struct block_device *bdev, int wait)
 /*
  * buffer.c
  */
-extern void guard_bio_eod(struct bio *bio);
 extern int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
 		get_block_t *get_block, struct iomap *iomap);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 853d92ceee64..a430e9c1c2d2 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -471,6 +471,7 @@ extern struct bio *bio_copy_user_iov(struct request_queue *,
 extern int bio_uncopy_user(struct bio *);
 void zero_fill_bio_iter(struct bio *bio, struct bvec_iter iter);
 void bio_truncate(struct bio *bio, unsigned new_size);
+void guard_bio_eod(struct bio *bio);
 
 static inline void zero_fill_bio(struct bio *bio)
 {
-- 
2.25.1

