Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA1CC48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 09:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D864E2083B
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 09:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HJ0cx1rG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfF0J3u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:29:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:13113 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0J3s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 05:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561627788; x=1593163788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ptWQf99dhviH+Z9RIreebaUM3APKwpxn4V7neVceyOY=;
  b=HJ0cx1rGGDgkHXX6Rf3Aw7f/TxQRD51ihx7t/k+YRzPtBBSjz5UVcuK4
   txJo3GVlLd9hMAdyk+9kpRoeL8HzAJEb1dVzZvsv+Duia4hiS4WZIIr2g
   CGC6iu3xfW2VhAeEjW75VTr36cl+3C59rUYOIFtl2mhw7WLVbHDvYfWdE
   /1hgtPOrkCMm7hd/o6rzBGtbdRQ7tBBAuyTVKtJdR4oaKKaMiMNdw8qhY
   07EZ+yQ59wxco8p4WQPw5VRNXfQfSddzzfhsbk5BNJ1vHlJkcI8tJYlzV
   W8vwLTICCB2bx7dfPaRCj0fPdy3VGzAx5Tg5xN70LWGBBbJ83vCuUfNhz
   w==;
X-IronPort-AV: E=Sophos;i="5.63,423,1557158400"; 
   d="scan'208";a="116545298"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 17:29:47 +0800
IronPort-SDR: DSO5Nbr35J/vCLNx4IC6cy1tjyqGsMGb0upyD11IoOrdr/zqRhzKTapx/OXtNwcRVA1uTb0jL4
 3kayeAdmy4UNtobEdbxb77BHpFlAiMlFzY3JJnfftQ0Cqphpp3aZHBuN0NFWzIt4vDEtbYSjd9
 xqf0VARRCbaO7owRn6MMSqleWvTbB2oMvBP3z9BbFrysme5DcGrS6lgwcS0teoSS3+mDGkLuNw
 HuJwB6BCGYis+SZ5hhE5iW0A+DGPYXtHw5/FZ/tmNDMruhuQ57JVW6NpjDhQ1qmVtP0nslZRag
 G1jYRPZPZVujHweRi0qq5kAm
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 27 Jun 2019 02:28:55 -0700
IronPort-SDR: sBMvxRS5bIqMp9gWjq3zzXEdD7iA6fQfo8jC5RhzOPI7J2yNh3Mu6f/YSmDNFIt7LhhA/F4mQO
 LKyifiXKA6EvhgHGhchF/QKTMcTYvJ5KFjNtZO8jQ1X1b5gmOSzW3EtsGI+9DJjLMXDvpmONY2
 tXIRTXspSEjpHL2aS/I8rWrR051od/E/zz//JnTbEBjun6LrAXT1izeX+tD1mBdsYQpMrZFvrU
 eSvyGWZw01tGDgfOVDwd96FRd/Yd11vM33v+B1jPIYor/OEE3PnQMkp1bjUAMsG5ddtMMo6dXY
 jHk=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jun 2019 02:29:46 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V5 1/3] block: Allow mapping of vmalloc-ed buffers
Date:   Thu, 27 Jun 2019 18:29:42 +0900
Message-Id: <20190627092944.20957-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627092944.20957-1-damien.lemoal@wdc.com>
References: <20190627092944.20957-1-damien.lemoal@wdc.com>
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
---
 block/bio.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index ce797d73bb43..bbba5f08b2ef 100644
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
@@ -1531,6 +1557,7 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	}
 
 	bio->bi_end_io = bio_map_kern_endio;
+
 	return bio;
 }
 EXPORT_SYMBOL(bio_map_kern);
-- 
2.21.0

