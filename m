Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C88C48BD6
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 02:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEAD216E3
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 02:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ckUH2ZtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfF0CtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:49:14 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34994 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfF0CtN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 22:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561603753; x=1593139753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fdbWKlu4/HXQHRMlCeZPeDdMQRlpifpGaqf6BWq4u2U=;
  b=ckUH2ZtKhdN1DcchTfNKLpZCkm5mQj/9GXxb9jNwgPBbMATfGU3mNO/O
   ynw94MQAJrTxGHig3Fm9w7jBiH2WBDYB3T4ZMgs8EslFJc9ktPL/Nzlyr
   /H2ygmLWsOX+FW4oK+I7Day56FmgIzyqXf6pR4axk+ZO4qaWMNCMuhL9o
   FlexMaZRIyOFRI1dHAY5LMQg3vGyYzI6ZAmZqKZAFkndvW62u9yrmeQws
   I2fFH8zodN9lEgkcplAMPn6GCX4iS/vlTq8mIrK0xrX/iyZHAkmte2Rg0
   B45jt2k+9VEMdQKryWeVEc6bEiw93THKd6RHffR7XNDmGoOfFyOZ/bUGw
   A==;
X-IronPort-AV: E=Sophos;i="5.63,422,1557158400"; 
   d="scan'208";a="218022028"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 10:49:13 +0800
IronPort-SDR: VfwpkXnbYzTZa2TrjXrQliDD7z1kVS7cu56BzM4lQasHu0KzGYV5P7FXTmkRs3iuyFxr53+2d/
 5f5wr7cRChvKZjf+6Hja34Ie2vA7zk9CsfGlSmIlb115ZaIl86eYbGcb0uKLDGugfsOtgRWm2F
 iSft2oYbxpqbHMXf0vA/6MiXCCWnsQF+tNvDtbTKIfY8a6ldspoB3NZFNMlcwl6x5NLXYNIylL
 CbFk9lSootYgL2/NUO1VD+NItz3fymWAUwZe2YYe5B/bYru1SFbVciLR8HREMukSJLIaPd2jM7
 zTAOFR1pt/FEB2LvHtZhlmNh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jun 2019 19:48:21 -0700
IronPort-SDR: Osrt+M0ewq+AneBBY4j6p3sLWJx3JP+P7Gp9iXVzgOM9PYv4hvXE6oMWsoo+LQJyBjbI4z2Xz5
 zS+5YKD0RjniCdHWc6+JFeHM873/upA2rBByl+sTpiTVgSESjY5T2kBSeA09dbs7EMPWGSgmcD
 fGodW30GqVb+uSPaz/7mZM43Lhje2pyxk4XeWUjT9kfMXULVOoXEhw6XMgHhrRAIpCDKJrtf9p
 fhS+uYF291Hu9dBQl25fAVfe8QGxnXnl/8TxxB0h66YwMICdk4bbmDG7xIFf7onV69EOaVRj5U
 9U4=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2019 19:49:13 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V4 1/3] block: Allow mapping of vmalloc-ed buffers
Date:   Thu, 27 Jun 2019 11:49:08 +0900
Message-Id: <20190627024910.23987-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627024910.23987-1-damien.lemoal@wdc.com>
References: <20190627024910.23987-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To allow the SCSI subsystem scsi_execute_req() function to issue
requests using large buffers that are better allocated with vmalloc()
rather than kmalloc(), modify bio_map_kern() and bio_copy_kern() to
allow passing a buffer allocated with vmalloc(). To do so, detect
vmalloc-ed buffers using is_vmalloc_addr(). For vmalloc-ed buffers,
flush the buffer using flush_kernel_vmap_range(), use vmalloc_to_page()
instead of virt_to_page() to obtain the pages of the buffer, and
invalidate the buffer addresses with invalidate_kernel_vmap_range() on
completion of read BIOs. This last point is executed using the function
bio_invalidate_vmalloc_pages() which is defined only if the
architecture defines ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE, that is, if the
architecture actually needs the invalidation done.

Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation")
Fixes: e76239a3748c ("block: add a report_zones method")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/bio.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index ce797d73bb43..1c21d1e7f1b8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -16,6 +16,7 @@
 #include <linux/workqueue.h>
 #include <linux/cgroup.h>
 #include <linux/blk-cgroup.h>
+#include <linux/highmem.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -1479,8 +1480,26 @@ void bio_unmap_user(struct bio *bio)
 	bio_put(bio);
 }
 
+#ifdef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+static void bio_invalidate_vmalloc_pages(struct bio *bio)
+{
+	if (bio->bi_private) {
+		struct bvec_iter_all iter_all;
+		struct bio_vec *bvec;
+		unsigned long len = 0;
+
+		bio_for_each_segment_all(bvec, bio, iter_all)
+			len += bvec->bv_len;
+		invalidate_kernel_vmap_range(bio->bi_private, len);
+	}
+}
+#else
+static void bio_invalidate_vmalloc_pages(struct bio *bio) {}
+#endif
+
 static void bio_map_kern_endio(struct bio *bio)
 {
+	bio_invalidate_vmalloc_pages(bio);
 	bio_put(bio);
 }
 
@@ -1501,6 +1520,8 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned long start = kaddr >> PAGE_SHIFT;
 	const int nr_pages = end - start;
+	bool is_vmalloc = is_vmalloc_addr(data);
+	struct page *page;
 	int offset, i;
 	struct bio *bio;
 
@@ -1508,6 +1529,12 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
 
+	if (is_vmalloc) {
+		flush_kernel_vmap_range(data, len);
+		if ((!op_is_write(bio_op(bio))))
+			bio->bi_private = data;
+	}
+
 	offset = offset_in_page(kaddr);
 	for (i = 0; i < nr_pages; i++) {
 		unsigned int bytes = PAGE_SIZE - offset;
@@ -1518,7 +1545,11 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 		if (bytes > len)
 			bytes = len;
 
-		if (bio_add_pc_page(q, bio, virt_to_page(data), bytes,
+		if (!is_vmalloc)
+			page = virt_to_page(data);
+		else
+			page = vmalloc_to_page(data);
+		if (bio_add_pc_page(q, bio, page, bytes,
 				    offset) < bytes) {
 			/* we don't support partial mappings */
 			bio_put(bio);
@@ -1531,6 +1562,7 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	}
 
 	bio->bi_end_io = bio_map_kern_endio;
+
 	return bio;
 }
 EXPORT_SYMBOL(bio_map_kern);
@@ -1543,6 +1575,7 @@ static void bio_copy_kern_endio(struct bio *bio)
 
 static void bio_copy_kern_endio_read(struct bio *bio)
 {
+	unsigned long len = 0;
 	char *p = bio->bi_private;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
@@ -1550,8 +1583,12 @@ static void bio_copy_kern_endio_read(struct bio *bio)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		memcpy(p, page_address(bvec->bv_page), bvec->bv_len);
 		p += bvec->bv_len;
+		len += bvec->bv_len;
 	}
 
+	if (is_vmalloc_addr(bio->bi_private))
+		invalidate_kernel_vmap_range(bio->bi_private, len);
+
 	bio_copy_kern_endio(bio);
 }
 
@@ -1572,6 +1609,7 @@ struct bio *bio_copy_kern(struct request_queue *q, void *data, unsigned int len,
 	unsigned long kaddr = (unsigned long)data;
 	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned long start = kaddr >> PAGE_SHIFT;
+	bool is_vmalloc = is_vmalloc_addr(data);
 	struct bio *bio;
 	void *p = data;
 	int nr_pages = 0;
@@ -1587,6 +1625,9 @@ struct bio *bio_copy_kern(struct request_queue *q, void *data, unsigned int len,
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
 
+	if (is_vmalloc)
+		flush_kernel_vmap_range(data, len);
+
 	while (len) {
 		struct page *page;
 		unsigned int bytes = PAGE_SIZE;
-- 
2.21.0

