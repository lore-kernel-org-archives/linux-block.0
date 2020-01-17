Return-Path: <SRS0=x5xE=3G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2740AC33CB1
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 14:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0204822525
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 14:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgAQOkB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:40:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:58472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgAQOkA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 09:40:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 59B93B17A;
        Fri, 17 Jan 2020 14:39:58 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] xen/blkfront: limit allocated memory size to actual use case
Date:   Fri, 17 Jan 2020 15:39:55 +0100
Message-Id: <20200117143955.18892-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Today the Xen blkfront driver allocates memory for one struct
blkfront_ring_info for each communication ring. This structure is
statically sized for the maximum supported configuration resulting
in a size of more than 90 kB.

As the main size contributor is one array inside the struct, the
memory allocation can easily be limited by moving this array to be
the last structure element and to allocate only the memory for the
actually needed array size.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkfront.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index c02be06c5299..61491167da19 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -151,9 +151,6 @@ MODULE_PARM_DESC(max_ring_page_order, "Maximum order of pages to be used for the
 #define BLK_RING_SIZE(info)	\
 	__CONST_RING_SIZE(blkif, XEN_PAGE_SIZE * (info)->nr_ring_pages)
 
-#define BLK_MAX_RING_SIZE	\
-	__CONST_RING_SIZE(blkif, XEN_PAGE_SIZE * XENBUS_MAX_RING_GRANTS)
-
 /*
  * ring-ref%u i=(-1UL) would take 11 characters + 'ring-ref' is 8, so 19
  * characters are enough. Define to 20 to keep consistent with backend.
@@ -177,12 +174,12 @@ struct blkfront_ring_info {
 	unsigned int evtchn, irq;
 	struct work_struct work;
 	struct gnttab_free_callback callback;
-	struct blk_shadow shadow[BLK_MAX_RING_SIZE];
 	struct list_head indirect_pages;
 	struct list_head grants;
 	unsigned int persistent_gnts_c;
 	unsigned long shadow_free;
 	struct blkfront_info *dev_info;
+	struct blk_shadow shadow[];
 };
 
 /*
@@ -1915,7 +1912,8 @@ static int negotiate_mq(struct blkfront_info *info)
 		info->nr_rings = 1;
 
 	info->rinfo = kvcalloc(info->nr_rings,
-			       sizeof(struct blkfront_ring_info),
+			       struct_size(info->rinfo, shadow,
+					   BLK_RING_SIZE(info)),
 			       GFP_KERNEL);
 	if (!info->rinfo) {
 		xenbus_dev_fatal(info->xbdev, -ENOMEM, "allocating ring_info structure");
-- 
2.16.4

