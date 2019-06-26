Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A7FC48BD5
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 01:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A881D2133F
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 01:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CpzzV1Nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfFZBsE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:48:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15693 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFZBsD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 21:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561513684; x=1593049684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/B+Zmi2zc/HDhqm84fUS/9k0x548ev4KQjTeX4Nu7jw=;
  b=CpzzV1NuMZgaN+62vQ397SJT9TwhZULXEUjy2NN89uI0NEi0sK3J4L0k
   dcJ8fAbNAUXBtkdTfCrEvF6fP9a/xFxxjQxCOauJZ0L5U+W32iTUavxEy
   w20nfwlodBkq0wRRHnQPt4OCqfwaxuNTNOhWn3erpuaaBoDyNXqL58txa
   DzUXb4bHwr7ABfW2cEYed0Hov3q2PTNra6ifxU+gO89AZlpBfN2WVcyW3
   XAROI+oXMDiSIDdDaaOk4+k/Wb+rH1JQCvZ2Wx4YLMWQ6UWsFZWwnoY0i
   LYscX1qf91DoUqaUxwWBEL6olbt2mEaJ9bvJYJ+GOOzLFnk1v7kQXYy5x
   w==;
X-IronPort-AV: E=Sophos;i="5.63,418,1557158400"; 
   d="scan'208";a="116422525"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 09:48:03 +0800
IronPort-SDR: 0cSChulNqOn6BNfU8nEWCUdm88MmG3Ns5J0Il/qT8Qosb8DMh8gU83MWBrm0DiZ8iCuBGoB3F6
 loAiKewXLV9toUYgU2qA/dYe280RopEu5ECe6k8bKhhv2gG4dvB2pzIupmh9ofl5NBBHDeeqIm
 eS28nO+srpacS7v1j3CEjDifuTVjAX7pX/D+sq0CD2ORCXF189kFdtaxi1Tq3voi6TncqmjVIO
 EPch+miGdkPVatHXTYrPfy7Tj3itrrz4qA+JMnXRlCzqf8Ki66J5fvpMxsHfBr210gKDLbTPVl
 gNqKjKHZyBN+l943V/Um+XbC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 25 Jun 2019 18:47:12 -0700
IronPort-SDR: WDidXsHmYvzTMG7hN8S5ZVTY7o5ENppZIv+CLVZLt0BT2osrRg2NfDHuZV5uG674/U6otglYcZ
 2VqbN4Xo+tJ8CPnOrKsQtopCquJ4La+Cw8KXzCwVBvAphxo/u0Xws+Fx/rMZjMHXdculL/KeTN
 kBd0UGTkvGZdvzbbh8l1JTsJuDnhmMm8wKglEVm6K9HjHpkpmrk3JDf5ZxWo3YQpziyiCDDoyS
 corgGmgAN5UJIjuhvwK5OU6BOblaYdTbjP2HUZXHZ/iU1p8DtYC14DIMvUJCqyidpcgbsQBsin
 IT8=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2019 18:48:01 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V2 1/3] block: Allow mapping of vmalloc-ed buffers
Date:   Wed, 26 Jun 2019 10:47:57 +0900
Message-Id: <20190626014759.15285-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626014759.15285-1-damien.lemoal@wdc.com>
References: <20190626014759.15285-1-damien.lemoal@wdc.com>
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
 block/bio.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index ce797d73bb43..46e0b970e287 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -16,6 +16,7 @@
 #include <linux/workqueue.h>
 #include <linux/cgroup.h>
 #include <linux/blk-cgroup.h>
+#include <linux/highmem.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -1501,9 +1502,14 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned long start = kaddr >> PAGE_SHIFT;
 	const int nr_pages = end - start;
+	bool is_vmalloc = is_vmalloc_addr(data);
+	struct page *page;
 	int offset, i;
 	struct bio *bio;
 
+	if (is_vmalloc)
+		invalidate_kernel_vmap_range(data, len);
+
 	bio = bio_kmalloc(gfp_mask, nr_pages);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
@@ -1518,7 +1524,11 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
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

