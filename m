Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8000FC433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514AA22D2A
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbhALE1q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 23:27:46 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6643 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbhALE1p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 23:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610426418; x=1641962418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=88Lp0y2hIyhYG8It0MWl/SOspuKedN/u1kjgeCCanzg=;
  b=ILiOzTBz2Jlf2Fp5mSCpEYLM+MVy2KE4QAhYOkTzgYfsByNbmHUIpojB
   yeGZ2VhvKLXdCuhsddHcZ4RUeyKZa867WN+wo2EgetONj+86aoNB+rJva
   LpWNFOmhKxXvkRT1EoxowikJLXE67eYl4TmhFSjQgcxMjFTLPSLzdPoya
   lcOPzY4yr93m60W5xXeu5T/kX7hBnt+pIVcLBXZF1uQYo1ShEiURkUsEl
   ieyrns6zJKWiXXz6cm1LJXjnDXjVAHNU2P2TG7ZgLaPQ9WLlHAtAgpOgz
   NqrgCj3J9nlTv7Y2ysLPY6wgEIB3wf4HkZphFlJ0aqTN1oS7IaKLvYvON
   w==;
IronPort-SDR: tQZHPldbDQRGUdIFgscvMVgLhzrEqvCPPKrsBmsMkayMSh1Cch69JZKW+MnUYMA7FQmR9uGGsb
 dMdYiBQ024TqlrOuMuTWYMJdy4nlPshKE77u9MbMRF3oBtHu82q/sZrIgHawOn9IK71i/WzdNS
 4K8qou+Z994yWeyYojWJYXzHDCD0Kz5dyKPZU7tEQDy2YOQDaln6JauXHEYHzveJRJFtrHkz1I
 xHSh57uPTIP+58F3Nw6KEiSyd0dDQpRTfQ9NkkX/bViEAv7oXD3gw2poF9zi7wCo8WwOBQSk7k
 GT4=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="261100110"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:38:39 +0800
IronPort-SDR: gdhAheiuG8avzS+OHvGnLsz76Xt9pbnNTGzo2omdKn9hZJ7cocHLK1G0jkqgm5OUzkc+NjnBWR
 zRHRXseqXE/MQBsyiXQfBSCCxg0fQFgCl4F7Tjj2gU7+MJngrvmiK9YFKcYjYjn+jGVs/rW6+g
 MiDUW288gfl4AScS3dNhLchm9X1P3O6EKx8OTrlOX4G2udMfxxU1NngFC8Iv8mQJ2yU1k5hWSi
 xPeMGaRcaBpYkHBzChZqlmwkDOQDOO0pSHUyoDHK/HYkJ6dyrfjAKueo5Quh2QS6+56fe5jCaw
 GOlt5taUuxL2OdmPEfe/9p1e
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 20:09:33 -0800
IronPort-SDR: z9UEULbt+pn4EiVfrtpVYsW4uNE3iQHb/kMaXpXrBGK5OJsYzeRp8/hluQMcJj+0oxxb4BOTbx
 xvXDFYSk7usjy+NsJx+AIjnABMWluqNdvJtxanQhSkRgwFQ4QONUbof8F+2EKSGyu0Mon9pjaa
 0rVURICapY2zI2/O5zVoA830o5l7BDqAfRmxT80F1QnkfY8SsV42ZCfFy+74SA1zsH4m3PCfyM
 0Ng4P/kMJOr7Wet+ZDCOW2Vb7mhGjyrKTrk416ogQExjh1DYMSV4MbHRyVEEMceeb8SkLzH/Lu
 ROk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:26:39 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V9 1/9] block: export bio_add_hw_pages()
Date:   Mon, 11 Jan 2021 20:26:15 -0800
Message-Id: <20210112042623.6316-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
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
index 1f2cc1fbe283..5cbd56b54f98 100644
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
index 7550364c326c..200030b2d74f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -351,8 +351,4 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length);
 int disk_expand_part_tbl(struct gendisk *disk, int target);
 
-int bio_add_hw_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset,
-		unsigned int max_sectors, bool *same_page);
-
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 070de09425ad..028ccc9bdf8d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2005,6 +2005,10 @@ struct block_device *I_BDEV(struct inode *inode);
 struct block_device *bdgrab(struct block_device *bdev);
 void bdput(struct block_device *);
 
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned int len, unsigned int offset,
+		unsigned int max_sectors, bool *same_page);
+
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
 int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
-- 
2.22.1

