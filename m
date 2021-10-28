Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC40C433FE
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 11:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4E5610FC
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 11:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhJ1L1A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 07:27:00 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:57620 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230059AbhJ1L07 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 07:26:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C5B9346135;
        Thu, 28 Oct 2021 11:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1635420270; x=1637234671; bh=4B/rAEPYo20jGjPuCtJGk6mJajIKKxoTdjg
        Phu043iM=; b=S11n9AOD/LgO3xmohaHzbDWv1HMcSmYa1ucAL7/tshKE9tzNvSL
        LFr2Ax4lVVpddmZ0YF50UMSCB8qbaf7GTwk9cwBnpBbr4RkgZwv9t9Zzo0sCIi9j
        VLCdd+jOaUwKi5f/mDbDRErD+NFbhXCoJUJBae+S86EO6mJUzf/9/8uA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id af87XvTwx6ZC; Thu, 28 Oct 2021 14:24:30 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 6132046108;
        Thu, 28 Oct 2021 14:24:30 +0300 (MSK)
Received: from localhost.localdomain (10.199.10.99) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 28 Oct 2021 14:24:29 +0300
From:   "Alexander V. Buev" <a.buev@yadro.com>
To:     <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikhail Malygin <m.malygin@yadro.com>, <linux@yadro.com>,
        "Alexander V. Buev" <a.buev@yadro.com>
Subject: [PATCH 1/3] block: bio-integrity: add PI iovec to bio
Date:   Thu, 28 Oct 2021 14:24:04 +0300
Message-ID: <20211028112406.101314-2-a.buev@yadro.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211028112406.101314-1-a.buev@yadro.com>
References: <20211028112406.101314-1-a.buev@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.10.99]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Added functions to attach user PI iovec pages to bio
and release this pages via bio_integrity_free.

Signed-off-by: Alexander V. Buev <a.buev@yadro.com>
---
 block/bio-integrity.c | 124 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/bio.h   |   8 +++
 2 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6b47cddbbca1..3e12cfa806ff 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -5,11 +5,11 @@
  * Copyright (C) 2007, 2008, 2009 Oracle Corporation
  * Written by: Martin K. Petersen <martin.petersen@oracle.com>
  */
-
 #include <linux/blkdev.h>
 #include <linux/mempool.h>
 #include <linux/export.h>
 #include <linux/bio.h>
+#include <linux/uio.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 #include "blk.h"
@@ -91,6 +91,17 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 }
 EXPORT_SYMBOL(bio_integrity_alloc);
 
+void bio_integrity_payload_release_pages(struct bio_integrity_payload *bip)
+{
+	unsigned short i;
+	struct bio_vec *bv;
+
+	for (i = 0; i < bip->bip_vcnt; ++i) {
+		bv = bip->bip_vec + i;
+		put_page(bv->bv_page);
+	}
+}
+
 /**
  * bio_integrity_free - Free bio integrity payload
  * @bio:	bio containing bip to be freed
@@ -105,6 +116,10 @@ void bio_integrity_free(struct bio *bio)
 
 	if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
 		kfree(bvec_virt(bip->bip_vec));
+	else
+		if (bip->bip_flags & BIP_RELEASE_PAGES) {
+			bio_integrity_payload_release_pages(bip);
+		}
 
 	__bio_integrity_free(bs, bip);
 	bio->bi_integrity = NULL;
@@ -377,6 +392,113 @@ void bio_integrity_advance(struct bio *bio, unsigned int bytes_done)
 	bvec_iter_advance(bip->bip_vec, &bip->bip_iter, bytes);
 }
 
+#define __MAX_ONSTACK_PI_PAGES (8)
+/**
+ * bio_integrity_add_pi_iovec - Add PI io vector
+ * @bio:	bio whose integrity vector to update
+ * @pi_iov:	iovec added to @bio's integrity
+ *
+ * Description: Pins pages for *pi_iov and appends them to @bio's integrity.
+ */
+int bio_integrity_add_pi_iovec(struct bio *bio, struct iovec *pi_iov)
+{
+	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
+	struct bio_integrity_payload *bip;
+	struct page *pi_pages[__MAX_ONSTACK_PI_PAGES];
+	struct page **pi_page = pi_pages;
+	struct iov_iter pi_iter;
+	int nr_vec_page = 0;
+	int ret = 0, intervals = 0;
+	bool is_write = op_is_write(bio_op(bio));
+	ssize_t size, pg_num;
+	size_t offset;
+	size_t len;
+
+	if (unlikely(!bi)) {
+		pr_err("The disk is not integrity capable");
+		return -EINVAL;
+	}
+
+	nr_vec_page = (pi_iov->iov_len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	nr_vec_page += 1; // we need this die to data of size N pages can be pinned to N+1 page
+
+	if (unlikely(nr_vec_page > __MAX_ONSTACK_PI_PAGES)) {
+		pi_page = kcalloc(nr_vec_page, sizeof(struct pi_page *), GFP_NOIO);
+		if (!pi_page)
+			return -ENOMEM;
+	}
+
+	intervals = bio_integrity_intervals(bi, bio_sectors(bio));
+	if (unlikely(intervals * bi->tuple_size < pi_iov->iov_len)) {
+		pr_err("Interval number is wrong, intervals=%d, bi->tuple_size=%d, pi_iov->iov_len=%u",
+			(int)intervals, (int)bi->tuple_size,
+			(unsigned int)pi_iov->iov_len);
+
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	bip = bio_integrity_alloc(bio, GFP_NOIO, nr_vec_page);
+	if (IS_ERR(bip)) {
+		ret = PTR_ERR(bip);
+		goto exit;
+	}
+
+	bip->bip_iter.bi_size = pi_iov->iov_len;
+	bip->bio_iter = bio->bi_iter;
+	bip_set_seed(bip, bio->bi_iter.bi_sector);
+
+	if (bi->flags & BLK_INTEGRITY_IP_CHECKSUM)
+		bip->bip_flags |= BIP_IP_CHECKSUM;
+
+	iov_iter_init(&pi_iter, is_write ?  WRITE : READ, pi_iov, 1, pi_iov->iov_len);
+
+	// pin user data to pages
+	size = iov_iter_get_pages(&pi_iter, pi_page, LONG_MAX, nr_vec_page, &offset);
+	if (unlikely(size < 0)) {
+		pr_err("Failed to pin PI buffer to page");
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	// calc count of pined pages
+	if (size > (PAGE_SIZE-offset)) {
+		size = DIV_ROUND_UP(size - (PAGE_SIZE-offset), PAGE_SIZE)+1;
+	} else
+		size = 1;
+
+	// fill bio integrity biovecs the given pages
+	len = pi_iov->iov_len;
+	for (pg_num = 0; pg_num < size; ++pg_num) {
+		size_t sz;
+
+		offset = (pg_num)?0:offset;
+		sz = PAGE_SIZE-offset;
+		if (sz > len)
+			sz = len;
+		ret = bio_integrity_add_page(bio, pi_page[pg_num], sz, offset);
+		if (unlikely(ret != sz)) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+		len -= sz;
+		bip->bip_flags |= BIP_RELEASE_PAGES;
+	}
+
+	ret = 0;
+
+exit:
+
+	if (ret && bip->bip_flags & BIP_RELEASE_PAGES)
+		bio_integrity_payload_release_pages(bip);
+
+	if (pi_page != pi_pages)
+		kfree(pi_page);
+
+	return ret;
+}
+EXPORT_SYMBOL(bio_integrity_add_pi_iovec);
+
 /**
  * bio_integrity_trim - Trim integrity vector
  * @bio:	bio whose integrity vector to update
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 00952e92eae1..57a4dd0b81ff 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -319,6 +319,7 @@ enum bip_flags {
 	BIP_CTRL_NOCHECK	= 1 << 2, /* disable HBA integrity checking */
 	BIP_DISK_NOCHECK	= 1 << 3, /* disable disk integrity checking */
 	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
+	BIP_RELEASE_PAGES	= 1 << 5, /* release pages after io completion */
 };
 
 /*
@@ -706,6 +707,7 @@ extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, gfp_t, un
 extern int bio_integrity_add_page(struct bio *, struct page *, unsigned int, unsigned int);
 extern bool bio_integrity_prep(struct bio *);
 extern void bio_integrity_advance(struct bio *, unsigned int);
+extern int bio_integrity_add_pi_iovec(struct bio *bio, struct iovec *pi_iov);
 extern void bio_integrity_trim(struct bio *);
 extern int bio_integrity_clone(struct bio *, struct bio *, gfp_t);
 extern int bioset_integrity_create(struct bio_set *, int);
@@ -746,6 +748,12 @@ static inline void bio_integrity_advance(struct bio *bio,
 	return;
 }
 
+static inline int bio_integrity_add_pi_iovec(struct bio *bio,
+					struct iovec *pi_iov)
+{
+	return 0;
+}
+
 static inline void bio_integrity_trim(struct bio *bio)
 {
 	return;
-- 
2.33.0

