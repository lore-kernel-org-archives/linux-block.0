Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3204CC4646B
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 06:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6082086D
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 06:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N5GdcqSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfFZGym (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:54:42 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6026 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfFZGym (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 02:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561532082; x=1593068082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xd9/oVcSDaCiRyP6ZSQav/uWxyPwJP1u1o/XVGvEjuE=;
  b=N5GdcqSjcARB50Wr6O4NdifLdKhChQ429X6gYAuDqTkLapE666j2MerK
   elE1Vmz2yzuJ4T0kS/SUG9f8Ti46rxKnvXXm1iUQwJekO923ItLexpVGg
   iSsyTHn3F1aQVMWPy5TBhVyTR67qajnmxsg6o1nfp0Np7l4OE9e7oWBRA
   lVTtETARLJJ48qUDcbZvBhLB+9liWIunFTnXWu63OyQLdnyMousTOmZuP
   WmzLBv+V3gHzLm8LrScoMLNzbCd9bvzN9oSxYXjQ/X/IX9rqmP56+JsT6
   vdBfgfadW5xyyb/m1TTT9WzeCR3uO6qWu5E0zkOZko03ePUktfUXQog+9
   w==;
X-IronPort-AV: E=Sophos;i="5.63,418,1557158400"; 
   d="scan'208";a="113191697"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 14:54:41 +0800
IronPort-SDR: hn6+WOC5hjv1X9OIbrN8lRZ/3Jn51W1MjOBK764Kq1REBTrRqepo8cy3PEbChCwkRWF5M5UNr8
 AC+pssxYzTVuWYlXys+8ATkmKwTMlK9m5pRKKl7el6wgVAtDljEip29HZ+mBWDVfDbuxXwm93l
 ePxgZBiPq+zi7wsnfUbaPlZbtvYnob82ALYv6ZHGsF4jr12cBTdT8um+heEdHvqrt3LJwLVOeR
 3od4uHBvRHNFpSxkZeVokuxajxMtOkl1IONhRBdOQX4LtrAn5Y2PViQl3SILwS091OTVl+8LTY
 b7PTIWlySmi+67/hysSoYZM/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 25 Jun 2019 23:53:57 -0700
IronPort-SDR: JPum1+LkLPWvK7CKjhfcSpwN4F4482rU1BehgFVXoBjg93bCr7BFVYcKoJHY+6y1qKizECvAjW
 AedHaQIxy2l1rxWPTFHEYC/CUtB5ACZuzwYz5EIcnJ2lzuo6fCRYuyIgrTz2nqhYngKthZPM6m
 ewsLL8bYuhoZC/oz3CLukeV7WyKaOMkRXhAqDEyTjFUBKzgJ5byEMxV5FN5zP97zYvvT/fvBfP
 +uL4q9hUOTzA2bggcEONBytAds+QRNjcZPQP+AORHSwtEJwk4DMC4CFobYpNd4iN6xQH0h1q67
 +vw=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2019 23:54:40 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V3 1/3] block: Allow mapping of vmalloc-ed buffers
Date:   Wed, 26 Jun 2019 15:54:36 +0900
Message-Id: <20190626065438.19307-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626065438.19307-1-damien.lemoal@wdc.com>
References: <20190626065438.19307-1-damien.lemoal@wdc.com>
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

