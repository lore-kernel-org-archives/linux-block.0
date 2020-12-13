Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129F8C433FE
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FBF2312D
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgLMFve (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Dec 2020 00:51:34 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51958 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbgLMFve (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Dec 2020 00:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607839497; x=1639375497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UfKvG3DF5+e1xbSx0w/6Rpv8SlZKd4h4pbL+RDgW3Js=;
  b=pueUe7sT9IGQ++BwrHntdVZMthLoUJGiqr/ty8C6bfv7TAyIHaBRMxhn
   diP4wWYCqprsm8NRDD3zW/06JW6jEtfMNy39UoNQ5Bhl2kFarIb8EQDb2
   qvOX/dmDEd1+BO7IfBj9VQuBHmiv1ku83lXdJy4RYgL6qfjwfztkCT1st
   ToWBaWncl6zsp/rIrG4FdcGetHdOtEtiENn42IdJmnNQxcKvOi4SSNbeX
   vOb554MzIg72smD2wQEcQaZPrwFnaYXJdnYDVYSQE71S/jyU5oRvL4yHl
   jcnizSZv0nP9fxlcu7qWh+HtqiNj0fDrVHltCX4VOek6v1TOEIckRRkTh
   w==;
IronPort-SDR: 9H2OnUf+yRw0BrWKO9JxVg5eiaFUzJs18vH/1qz4M67iId1WoyMR2JRvAPGiHF6+qJ8OIISuoj
 nzTi6qd9gfNwvbYZpICs/LV93s/ErW+bk3dbyZbe64Ig0Ly6eODeiKD0qngT35Q3UF5Sg6fsL6
 fEKjkWz7EIvBMNp/lvpFcmxmMe7p9MR8glAax8quJLV7n92FGSrJQoyAGccKGUqD+fl7ZOW0WC
 1Q/zg76Cc96UL/il7+zfAGUrqpVaqroNKGKVPXudLB9EXGXpWqRZw9xOmZHbSKVIHmTiRFq2fs
 baQ=
X-IronPort-AV: E=Sophos;i="5.78,415,1599494400"; 
   d="scan'208";a="258770345"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2020 14:03:18 +0800
IronPort-SDR: 5RzE2Q1lt5fGkkI2LjqWxa7hFl0M9X7x1bAkNa20ExBoSFZt3hc/qx4bNA6acKMDw7h7ot7WCd
 uIhBF87NZOAUvptQF3n6bj/Zf1MA4sLpwzE31it7szFUee24AliL1/uMKJ+Iub0oUINocTp0Cl
 6YfMOvPx3QEFXlYcNVRiXL8foYlYSax1fKsgCy9Rv7n9v6Z6Uf6rIggRaJ1ihuxQdSeBCOXwQY
 1JCDbAWaqLjmBOVvP3ZrrCrRHMRVteon+RU9o4BPCXV6jxmD5Ifkk65YPTxn6KvjbT6tQW7tuv
 xqJTjVJk57iLZe9sKT2q2Wux
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 21:34:17 -0800
IronPort-SDR: ohj9NsNmuMQLzfYUIUh2nT/CRG9S+5u6OxzAE7/lgGoo5dGPUv5E5WxW8Y2+UbMKSt4nByGjX3
 VXpgVSNqq08wYox7b+su32+oCh8F1ngqXdsjnm4+YjDwzn7pNBfEucn2i97vqkOQAxMdAHx4rg
 jxPrA8zT8sz1ZT4nGUcEUC24R+wAB1wNNXWuTVddzOX1aQR9iqAkETwcTVNfe23cCzsReUw2Bw
 2QfhY2AbubFs0HssdNbtLiEx8lYyovYByqA2O17gBd3QiTSo1ANDzmFOwtYF+xJa7SQE59BAwb
 36g=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2020 21:50:28 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V6 1/6] block: export bio_add_hw_pages()
Date:   Sat, 12 Dec 2020 21:50:12 -0800
Message-Id: <20201213055017.7141-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
References: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To implement the NVMe Zone Append command on the NVMeOF target side for
generic Zoned Block Devices with NVMe Zoned Namespaces interface, we
need to build the bios with hardware limitations, i.e. we use
bio_add_hw_page() with queue_max_zone_append_sectors() instead of
bio_add_page().

Without this API being exported NVMeOF target will require to use
bio_add_hw_page() caller bio_iov_iter_get_pages(). That results in
extra work which is inefficient.

Export the API so that NVMeOF ZBD over ZNS backend can use it to build
Zone Append bios.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c            | 1 +
 block/blk.h            | 4 ----
 include/linux/blkdev.h | 4 ++++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index fa01bef35bb1..eafd97c6c7fd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -826,6 +826,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	bio->bi_iter.bi_size += len;
 	return len;
 }
+EXPORT_SYMBOL(bio_add_hw_page);
 
 /**
  * bio_add_pc_page	- attempt to add page to passthrough bio
diff --git a/block/blk.h b/block/blk.h
index e05507a8d1e3..1fdb8d5d8590 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -428,8 +428,4 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 #endif
 }
 
-int bio_add_hw_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset,
-		unsigned int max_sectors, bool *same_page);
-
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 05b346a68c2e..2bdaa7cacfa3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2023,4 +2023,8 @@ int fsync_bdev(struct block_device *bdev);
 struct super_block *freeze_bdev(struct block_device *bdev);
 int thaw_bdev(struct block_device *bdev, struct super_block *sb);
 
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned int len, unsigned int offset,
+		unsigned int max_sectors, bool *same_page);
+
 #endif /* _LINUX_BLKDEV_H */
-- 
2.22.1

