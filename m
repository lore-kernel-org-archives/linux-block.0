Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8910C0650F
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 05:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EF92089F
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 05:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CH1tgKjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfGAFJX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:09:23 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:62457 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfGAFJX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 01:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561957763; x=1593493763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eKp5BWbm2czEOH0r/etBmUeYCDH36g7dJVTVIL5yAqs=;
  b=CH1tgKjY8QwHDMj2cl6xow7I0Ya8hQ405rg3WzXO8yAfdCjZWcSHnXXR
   r/Hg45neImyjIBZ5/07ex30+OI2KWo+KgA9jhJhS94EGViw1tre9NH+Fg
   diW4tFYlXeHSAY7vr2Gv+la05bIHKhFTyErQYxv9qeFTg8ze11Oa+b8V1
   lZtXQaH7xnNVoY0YmjmY0n41Do5qoIOSR+43Q3YIjXzuJmDOh2THdP+/G
   xPgjc5CjwuoPWVksbpMAfs3vBhwPgZzN/RPbGzLLhO5lr03DUllXtM/1e
   tlaVh3gySSbL75coSzDwIBQRmJOi+j/Z9VClQUMGQDwtzfJKNvdFTzAxD
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,437,1557158400"; 
   d="scan'208";a="116777207"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2019 13:09:23 +0800
IronPort-SDR: iznZYviORmOd7JyYJbxWbzqBK2tolVsi31I/Hmp6FzE1bV0bt2eSRn0mUEwWNKUw8yyVUGTzWV
 bsgmrPm2wLzuWV0hUCq4fxLLCpWFxzvRrdADeDK8vTKeQjlf7s4INnjM3wctuOSuQaOGBj8Or+
 +WaK1wceLX16lq/akSTsR5AWK3KQRZm5wpPVdk+jaRPubQWGfG6xQocRMIoTtiSJsRf1lsYGTS
 ToouYjmnDVIyjzOmAO0DNAYpBSEXcPjZCkfvMNnqZya+QuOzEYfJyUpS7vH073halysnJcmlyR
 IiAz2DUu6ERWEnlvEjTdR4TO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Jun 2019 22:08:26 -0700
IronPort-SDR: d3MFX2II8ZNJ3WoQ6jf1YRJkftAnMXltUI6f3zNTDR7smaUTcGCaiVMXkff/WYVUpF5UXvSQ9E
 a/Xx9pkPY8Jll6aM0CCdWyyGcpxCah3A3NHprd3rphkQd1CVLYFz3SJ4VZlHfz3GmRoipQ3kO+
 oc120j1L4eJ7aNYk3dvXqJHvKObKVAvUZclqkYqVqKLlhx3GUQQyj+6qnhsAy5uUrMsHbJqLOI
 voUuUVTHXJ+yJm+BqQVdNBq7PlvJ67HHN91n+aWBuLnVH8Xk791uWDw+5cl2pfqQAVtZhqfX6r
 t2w=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jun 2019 22:09:21 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V6 1/4] block: Allow mapping of vmalloc-ed buffers
Date:   Mon,  1 Jul 2019 14:09:15 +0900
Message-Id: <20190701050918.27511-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701050918.27511-1-damien.lemoal@wdc.com>
References: <20190701050918.27511-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To allow the SCSI subsystem scsi_execute_req() function to issue
requests using large buffers that are better allocated with vmalloc()
rather than kmalloc(), modify bio_map_kern() to allow passing a buffer
allocated with vmalloc().

To do so, detect vmalloc-ed buffers using is_vmalloc_addr(). For
vmalloc-ed buffers, flush the buffer using flush_kernel_vmap_range(),
use vmalloc_to_page() instead of virt_to_page() to obtain the pages of
the buffer, and invalidate the buffer addresses with
invalidate_kernel_vmap_range() on completion of read BIOs. This last
point is executed using the function bio_invalidate_vmalloc_pages()
which is defined only if the architecture defines
ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE, that is, if the architecture
actually needs the invalidation done.

Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation")
Fixes: e76239a3748c ("block: add a report_zones method")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 2050bb4aacb5..3b6e35f73fd7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -16,6 +16,7 @@
 #include <linux/workqueue.h>
 #include <linux/cgroup.h>
 #include <linux/blk-cgroup.h>
+#include <linux/highmem.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -1479,8 +1480,22 @@ void bio_unmap_user(struct bio *bio)
 	bio_put(bio);
 }
 
+static void bio_invalidate_vmalloc_pages(struct bio *bio)
+{
+#ifdef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+	if (bio->bi_private && !op_is_write(bio_op(bio))) {
+		unsigned long i, len = 0;
+
+		for (i = 0; i < bio->bi_vcnt; i++)
+			len += bio->bi_io_vec[i].bv_len;
+		invalidate_kernel_vmap_range(bio->bi_private, len);
+	}
+#endif
+}
+
 static void bio_map_kern_endio(struct bio *bio)
 {
+	bio_invalidate_vmalloc_pages(bio);
 	bio_put(bio);
 }
 
@@ -1501,6 +1516,8 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned long start = kaddr >> PAGE_SHIFT;
 	const int nr_pages = end - start;
+	bool is_vmalloc = is_vmalloc_addr(data);
+	struct page *page;
 	int offset, i;
 	struct bio *bio;
 
@@ -1508,6 +1525,11 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
 
+	if (is_vmalloc) {
+		flush_kernel_vmap_range(data, len);
+		bio->bi_private = data;
+	}
+
 	offset = offset_in_page(kaddr);
 	for (i = 0; i < nr_pages; i++) {
 		unsigned int bytes = PAGE_SIZE - offset;
@@ -1518,7 +1540,11 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
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
-- 
2.21.0

