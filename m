Return-Path: <SRS0=iNmo=5T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22E5C43331
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 09:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9C920721
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 09:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbgDCJAj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:00:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:59384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgDCJAj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Apr 2020 05:00:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8972EAEB1;
        Fri,  3 Apr 2020 09:00:37 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Subject: [PATCH] xen/blkfront: fix memory allocation flags in blkfront_setup_indirect()
Date:   Fri,  3 Apr 2020 11:00:34 +0200
Message-Id: <20200403090034.8753-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 1d5c76e664333 ("xen-blkfront: switch kcalloc to kvcalloc for
large array allocation") didn't fix the issue it was meant to, as the
flags for allocating the memory are GFP_NOIO, which will lead the
memory allocation falling back to kmalloc().

So instead of GFP_NOIO use GFP_KERNEL and do all the memory allocation
in blkfront_setup_indirect() in a memalloc_noio_{save,restore} section.

Fixes: 1d5c76e664333 ("xen-blkfront: switch kcalloc to kvcalloc for large array allocation")
Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkfront.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 915cf5b6388c..3b889ea950c2 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -47,6 +47,7 @@
 #include <linux/bitmap.h>
 #include <linux/list.h>
 #include <linux/workqueue.h>
+#include <linux/sched/mm.h>
 
 #include <xen/xen.h>
 #include <xen/xenbus.h>
@@ -2189,10 +2190,12 @@ static void blkfront_setup_discard(struct blkfront_info *info)
 
 static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo)
 {
-	unsigned int psegs, grants;
+	unsigned int psegs, grants, memflags;
 	int err, i;
 	struct blkfront_info *info = rinfo->dev_info;
 
+	memflags = memalloc_noio_save();
+
 	if (info->max_indirect_segments == 0) {
 		if (!HAS_EXTRA_REQ)
 			grants = BLKIF_MAX_SEGMENTS_PER_REQUEST;
@@ -2224,7 +2227,7 @@ static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo)
 
 		BUG_ON(!list_empty(&rinfo->indirect_pages));
 		for (i = 0; i < num; i++) {
-			struct page *indirect_page = alloc_page(GFP_NOIO);
+			struct page *indirect_page = alloc_page(GFP_KERNEL);
 			if (!indirect_page)
 				goto out_of_memory;
 			list_add(&indirect_page->lru, &rinfo->indirect_pages);
@@ -2235,15 +2238,15 @@ static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo)
 		rinfo->shadow[i].grants_used =
 			kvcalloc(grants,
 				 sizeof(rinfo->shadow[i].grants_used[0]),
-				 GFP_NOIO);
+				 GFP_KERNEL);
 		rinfo->shadow[i].sg = kvcalloc(psegs,
 					       sizeof(rinfo->shadow[i].sg[0]),
-					       GFP_NOIO);
+					       GFP_KERNEL);
 		if (info->max_indirect_segments)
 			rinfo->shadow[i].indirect_grants =
 				kvcalloc(INDIRECT_GREFS(grants),
 					 sizeof(rinfo->shadow[i].indirect_grants[0]),
-					 GFP_NOIO);
+					 GFP_KERNEL);
 		if ((rinfo->shadow[i].grants_used == NULL) ||
 			(rinfo->shadow[i].sg == NULL) ||
 		     (info->max_indirect_segments &&
@@ -2252,6 +2255,7 @@ static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo)
 		sg_init_table(rinfo->shadow[i].sg, psegs);
 	}
 
+	memalloc_noio_restore(memflags);
 
 	return 0;
 
@@ -2271,6 +2275,9 @@ static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo)
 			__free_page(indirect_page);
 		}
 	}
+
+	memalloc_noio_restore(memflags);
+
 	return -ENOMEM;
 }
 
-- 
2.16.4

