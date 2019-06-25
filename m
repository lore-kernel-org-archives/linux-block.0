Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42675C4646C
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 02:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6EB206DD
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 02:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="miWAThwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfFYCqb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 22:46:31 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51033 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbfFYCq3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 22:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561430789; x=1592966789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GKv1oj6zY/ZraVIoPcbsLc1hDCrrNULySwbCBOwMDQo=;
  b=miWAThwjLCuiPsURfbARDqIfB603tHFMr1MTTTvbu09Pk1mEjoTb9e2K
   GPxZxZ5xyy4IdkvlxOcoT1SCYBe5QllU2+rbiTfEc/PrDCf8GXOj1u4Qz
   4YDzBLXs1KMf0OW+8jsbC7XfgW4fgpZmzpjRJIzk3rStS273BVb/btss1
   UgYRrYjzBgVcB9ndyqtdQidcgGmjIHpq8MTJEhePU3SJaULp1rVre6hYe
   VmDIumBZh3/DVQ1uqr8yQy1nw+2xT/SHiycJe3p+rOo5YUe12UZqgBb5V
   8NX1GMlphTjNwlj6hzCPTZ7zTHMoyhqe6GKiq4ADbt2iF+aCQhjjvMBRk
   A==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; 
   d="scan'208";a="112654038"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 10:46:29 +0800
IronPort-SDR: FceNXFyC7htLRgz+MdnIoI1ybTh9LoyY8taTfQM8Q2cjornt9Sw8zIOICNmtKhrA+dbXX+EEN1
 /kcLRxV2gxZWA8lvXaCSo6NCyvUU6ccRUhiUpgAgJpGx8BROJZYh81S06PQPNWfn0FgG6R5jJb
 3XwbNbVciR3M3ZgjxEeRG5Hr1qCrzJdk/AorawV/cEZwqJpOGLo3D260BihggQC0SdxBIRDzom
 GidzSk6dgpjdLa2f+iA2M/ykhbn3Iy0cuaFXlFwMYLQQMiqpKz1ha0Ae5CaSRKxHL+8ZL60DiH
 v6sQa9YjVvX9LP4IbnO9bEdj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 24 Jun 2019 19:45:46 -0700
IronPort-SDR: b2CxkUa2nyEevIeLM6jKLSJsF8Qrt4EKMo0hNdxM6RJ9Ig1M9Bl+2LV8o/d79yIIFvWKUnO0HE
 IhoLB6bvJCS+KQNfVuLXFooboJxk+hP1hjYEglHDoV4LfEltM9YsAgo4u8nrs+fOWpVjr9b3UC
 lhzdjUuA8xCHk+0Zq3Hj+cYO8GzRNaxMjxQd8BORcyHtl50I8+rdCSIuNTknYtxk5TXEOay9bC
 3i1yd7NCd7DvCSsaBFQ+INU2DtPXaP3SUWG7dpVASeqkI278RV+EkikLQtD1EcrfERxOQU1Dwm
 ivI=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jun 2019 19:46:27 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/3] block: Allow mapping of vmalloc-ed buffers
Date:   Tue, 25 Jun 2019 11:46:23 +0900
Message-Id: <20190625024625.23976-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625024625.23976-1-damien.lemoal@wdc.com>
References: <20190625024625.23976-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To allow the SCSI subsystem scsi_execute_req() function to issue
requests using large buffers that are better allocated with vmalloc()
rather than kmalloc(), modify bio_map_kern() to allow passing a buffer
allocated with the vmalloc() function. To do so, simply test the buffer
address using is_vmalloc_addr() and use vmalloc_to_page() instead of
virt_to_page() to obtain the pages of vmalloc-ed buffers.

Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation")
Fixes: e76239a3748c ("block: add a report_zones method")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/bio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index ce797d73bb43..05afcaf655f3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1501,6 +1501,8 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned long start = kaddr >> PAGE_SHIFT;
 	const int nr_pages = end - start;
+	bool is_vmalloc = is_vmalloc_addr(data);
+	struct page *page;
 	int offset, i;
 	struct bio *bio;
 
@@ -1518,7 +1520,11 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 		if (bytes > len)
 			bytes = len;
 
-		if (bio_add_pc_page(q, bio, virt_to_page(data), bytes,
+		if (is_vmalloc)
+			page = vmalloc_to_page(data);
+		else
+			page = virt_to_page(data);
+		if (bio_add_pc_page(q, bio, page, bytes,
 				    offset) < bytes) {
 			/* we don't support partial mappings */
 			bio_put(bio);
-- 
2.21.0

