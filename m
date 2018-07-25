Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50234 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728441AbeGYIwh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jul 2018 04:52:37 -0400
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc: konrad.wilk@oracle.com, roger.pau@citrix.com,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] xen/blkfront: remove unused macros
Date: Wed, 25 Jul 2018 09:42:07 +0200
Message-Id: <20180725074207.6808-1-jgross@suse.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Remove some macros not used anywhere.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkfront.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index b5cedccb5d7d..94300dbe358b 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -251,14 +251,9 @@ static DEFINE_SPINLOCK(minor_lock);
 #define GRANTS_PER_INDIRECT_FRAME \
 	(XEN_PAGE_SIZE / sizeof(struct blkif_request_segment))
 
-#define PSEGS_PER_INDIRECT_FRAME	\
-	(GRANTS_INDIRECT_FRAME / GRANTS_PSEGS)
-
 #define INDIRECT_GREFS(_grants)		\
 	DIV_ROUND_UP(_grants, GRANTS_PER_INDIRECT_FRAME)
 
-#define GREFS(_psegs)	((_psegs) * GRANTS_PER_PSEG)
-
 static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo);
 static void blkfront_gather_backend_features(struct blkfront_info *info);
 static int negotiate_mq(struct blkfront_info *info);
-- 
2.13.7
