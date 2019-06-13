Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB6DC31E4A
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBC5206BB
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbfFMPgN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:36:13 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:38042 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727431AbfFMKUm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 06:20:42 -0400
X-IronPort-AV: E=Sophos;i="5.62,369,1554735600"; 
   d="scan'208";a="18380808"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Jun 2019 19:20:37 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id CE64F4274BC5;
        Thu, 13 Jun 2019 19:20:37 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     joro@8bytes.org, axboe@kernel.dk, ulf.hansson@linaro.org,
        wsa+renesas@sang-engineering.com
Cc:     hch@lst.de, iommu@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [RFC PATCH v6 3/5] block: add a helper function to merge the segments by an IOMMU
Date:   Thu, 13 Jun 2019 19:20:13 +0900
Message-Id: <1560421215-10750-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds a helper function whether a queue can merge
the segments by an IOMMU.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 block/blk-settings.c   | 28 ++++++++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 45f2c52..4e4e13e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -4,9 +4,11 @@
  */
 #include <linux/bio.h>
 #include <linux/blkdev.h>
+#include <linux/device.h>
 #include <linux/gcd.h>
 #include <linux/gfp.h>
 #include <linux/init.h>
+#include <linux/iommu.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/lcm.h>
@@ -831,6 +833,32 @@ void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
 }
 EXPORT_SYMBOL_GPL(blk_queue_write_cache);
 
+/**
+ * blk_queue_can_use_iommu_merging - configure queue for merging segments.
+ * @q:		the request queue for the device
+ * @dev:	the device pointer for dma
+ *
+ * Tell the block layer about the iommu merging of @q.
+ */
+bool blk_queue_can_use_iommu_merging(struct request_queue *q,
+				     struct device *dev)
+{
+	struct iommu_domain *domain;
+
+	/*
+	 * If the device DMA is translated by an IOMMU, we can assume
+	 * the device can merge the segments.
+	 */
+	if (!device_iommu_mapped(dev))
+		return false;
+
+	domain = iommu_get_domain_for_dev(dev);
+	/* No need to update max_segment_size. see blk_queue_virt_boundary() */
+	blk_queue_virt_boundary(q, iommu_get_minimum_page_size(domain) - 1);
+
+	return true;
+}
+
 static int __init blk_settings_init(void)
 {
 	blk_max_low_pfn = max_low_pfn - 1;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 592669b..4d1f7dc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1091,6 +1091,8 @@ extern void blk_queue_dma_alignment(struct request_queue *, int);
 extern void blk_queue_update_dma_alignment(struct request_queue *, int);
 extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
 extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
+extern bool blk_queue_can_use_iommu_merging(struct request_queue *q,
+					    struct device *dev);
 
 /*
  * Number of physical segments as sent to the device.
-- 
2.7.4

