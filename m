Return-Path: <SRS0=l7do=2G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB7BC43603
	for <linux-block@archiver.kernel.org>; Mon, 16 Dec 2019 12:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDDB20726
	for <linux-block@archiver.kernel.org>; Mon, 16 Dec 2019 12:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="T1nInr/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfLPMq0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:46:26 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:28934 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfLPMqZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Dec 2019 07:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576500386; x=1608036386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X93izDi+OFRUN5FGBE4eNUsCd4hh4S1nRuspQbSs7oM=;
  b=T1nInr/j0HN0E8vrZSkJ4tMvFx9nqzGg8BYUaukXum4wKhoLnmAKNMpo
   WuCPveosO8INVEQwWuSOMqRQjq+Rz9lzJXvwBu7fTCBOzZ44cbXkIXFG2
   s+Gm1OsGLKxhYvnLMvs/MUsYV2FahPdTUeII6i3WXtEFNOVAwqL4NT/42
   Y=;
IronPort-SDR: ZY+fQIt1OSySzUcVKYvmESLZ7chuZTvxInEudZ+Kl9R3rARWRm3W8vRzgsXJNu2PVSOXh/dtig
 KRfEHnDzQoOA==
X-IronPort-AV: E=Sophos;i="5.69,321,1571702400"; 
   d="scan'208";a="5354829"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 16 Dec 2019 12:46:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id 1CBCBA24CE;
        Mon, 16 Dec 2019 12:46:24 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Dec 2019 12:46:23 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Dec 2019 12:46:18 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.de>, <pdurrant@amazon.com>,
        <sjpark@amazon.com>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 3/4] xen/blkback: Remove unnecessary static variable name prefixes
Date:   Mon, 16 Dec 2019 13:45:26 +0100
Message-ID: <20191216124527.30306-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216124527.30306-1-sjpark@amazon.com>
References: <20191216124527.30306-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D17UWC002.ant.amazon.com (10.43.162.61) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

A few of static variables in blkback have 'xen_blkif_' prefix, though it
is unnecessary for static variables.  This commit removes such prefixes.

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/block/xen-blkback/blkback.c | 37 +++++++++++++----------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 79f677aeb5cc..fbd67f8e4e4e 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -62,8 +62,8 @@
  * IO workloads.
  */
 
-static int xen_blkif_max_buffer_pages = 1024;
-module_param_named(max_buffer_pages, xen_blkif_max_buffer_pages, int, 0644);
+static int max_buffer_pages = 1024;
+module_param_named(max_buffer_pages, max_buffer_pages, int, 0644);
 MODULE_PARM_DESC(max_buffer_pages,
 "Maximum number of free pages to keep in each block backend buffer");
 
@@ -78,8 +78,8 @@ MODULE_PARM_DESC(max_buffer_pages,
  * algorithm.
  */
 
-static int xen_blkif_max_pgrants = 1056;
-module_param_named(max_persistent_grants, xen_blkif_max_pgrants, int, 0644);
+static int max_pgrants = 1056;
+module_param_named(max_persistent_grants, max_pgrants, int, 0644);
 MODULE_PARM_DESC(max_persistent_grants,
                  "Maximum number of grants to map persistently");
 
@@ -88,8 +88,8 @@ MODULE_PARM_DESC(max_persistent_grants,
  * use. The time is in seconds, 0 means indefinitely long.
  */
 
-static unsigned int xen_blkif_pgrant_timeout = 60;
-module_param_named(persistent_grant_unused_seconds, xen_blkif_pgrant_timeout,
+static unsigned int pgrant_timeout = 60;
+module_param_named(persistent_grant_unused_seconds, pgrant_timeout,
 		   uint, 0644);
 MODULE_PARM_DESC(persistent_grant_unused_seconds,
 		 "Time in seconds an unused persistent grant is allowed to "
@@ -137,9 +137,8 @@ module_param(log_stats, int, 0644);
 
 static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
 {
-	return xen_blkif_pgrant_timeout &&
-	       (jiffies - persistent_gnt->last_used >=
-		HZ * xen_blkif_pgrant_timeout);
+	return pgrant_timeout && (jiffies - persistent_gnt->last_used >=
+			HZ * pgrant_timeout);
 }
 
 static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
@@ -234,7 +233,7 @@ static int add_persistent_gnt(struct xen_blkif_ring *ring,
 	struct persistent_gnt *this;
 	struct xen_blkif *blkif = ring->blkif;
 
-	if (ring->persistent_gnt_c >= xen_blkif_max_pgrants) {
+	if (ring->persistent_gnt_c >= max_pgrants) {
 		if (!blkif->vbd.overflow_max_grants)
 			blkif->vbd.overflow_max_grants = 1;
 		return -EBUSY;
@@ -397,14 +396,13 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
 		goto out;
 	}
 
-	if (ring->persistent_gnt_c < xen_blkif_max_pgrants ||
-	    (ring->persistent_gnt_c == xen_blkif_max_pgrants &&
+	if (ring->persistent_gnt_c < max_pgrants ||
+	    (ring->persistent_gnt_c == max_pgrants &&
 	    !ring->blkif->vbd.overflow_max_grants)) {
 		num_clean = 0;
 	} else {
-		num_clean = (xen_blkif_max_pgrants / 100) * LRU_PERCENT_CLEAN;
-		num_clean = ring->persistent_gnt_c - xen_blkif_max_pgrants +
-			    num_clean;
+		num_clean = (max_pgrants / 100) * LRU_PERCENT_CLEAN;
+		num_clean = ring->persistent_gnt_c - max_pgrants + num_clean;
 		num_clean = min(ring->persistent_gnt_c, num_clean);
 		pr_debug("Going to purge at least %u persistent grants\n",
 			 num_clean);
@@ -599,8 +597,7 @@ static void print_stats(struct xen_blkif_ring *ring)
 		 current->comm, ring->st_oo_req,
 		 ring->st_rd_req, ring->st_wr_req,
 		 ring->st_f_req, ring->st_ds_req,
-		 ring->persistent_gnt_c,
-		 xen_blkif_max_pgrants);
+		 ring->persistent_gnt_c, max_pgrants);
 	ring->st_print = jiffies + msecs_to_jiffies(10 * 1000);
 	ring->st_rd_req = 0;
 	ring->st_wr_req = 0;
@@ -660,7 +657,7 @@ int xen_blkif_schedule(void *arg)
 		if (time_before(jiffies, blkif->buffer_squeeze_end))
 			shrink_free_pagepool(ring, 0);
 		else
-			shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
+			shrink_free_pagepool(ring, max_buffer_pages);
 
 		if (log_stats && time_after(jiffies, ring->st_print))
 			print_stats(ring);
@@ -887,7 +884,7 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 			continue;
 		}
 		if (use_persistent_gnts &&
-		    ring->persistent_gnt_c < xen_blkif_max_pgrants) {
+		    ring->persistent_gnt_c < max_pgrants) {
 			/*
 			 * We are using persistent grants, the grant is
 			 * not mapped but we might have room for it.
@@ -914,7 +911,7 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 			pages[seg_idx]->persistent_gnt = persistent_gnt;
 			pr_debug("grant %u added to the tree of persistent grants, using %u/%u\n",
 				 persistent_gnt->gnt, ring->persistent_gnt_c,
-				 xen_blkif_max_pgrants);
+				 max_pgrants);
 			goto next;
 		}
 		if (use_persistent_gnts && !blkif->vbd.overflow_max_grants) {
-- 
2.17.1

