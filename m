Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3409DC00454
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 18:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048972077B
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 18:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7erjCGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbfLKSK5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:10:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37595 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKSK5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 13:10:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so1730094plz.4;
        Wed, 11 Dec 2019 10:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DC1lDQTVGWiZyc47Vd2HTq0B83lbDHqEnIy5EBZ8fmk=;
        b=p7erjCGJxie+gsJ5gNv6yyP8UEGIYUryfLkT29PiTkBlTy7xUvH/z4836TdtoFqPq6
         0kOWqjKUKyWnLANLIGaOHzDqbrdrWlOmRopA+hPWSbLHxR2eGdkmQCCOTkoFtbYDtOH4
         bJplBxvgrKhTSHyhjWkW7YpCMQ3fRG3/9l2OX7+94y3Jx+vwERpZNctRhm74MclskxZL
         gvEb1jhOflVXMbmRLWEua5gQukz1S+5ZzpF32hTXB58kY0e0e/zWIPSO2ZSi39JzYJ2g
         cSg7TMCr64sRse8S0sDD6tvApA/BUFO50Op3h/HKX359SzJPJco26MfKBSaDllzz0K5u
         tlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DC1lDQTVGWiZyc47Vd2HTq0B83lbDHqEnIy5EBZ8fmk=;
        b=rCj1jp/DLjKRzU1vEhbSU6l1Q7qffWWs7aMa8q53KOBH3+btqWtoMWoO00/xAMLFTg
         AD5EPx3PJvsq7hz/3yzJDlrH9HkmS90d9yJ7DaNfllzWNTLbvEpnPut//xw/IfubkCLf
         jTrw0RIVFPQRdHhzD2ablptrbjmg4XU2IRG7aTwV0rphK0/iAgUiu1VXabJwgzGNSI3H
         DiMUhNdS02jW5h3eJl5xiKRxJ3WHyRLh8Y4Er0HUwQ3qV0++sh8EHWhKQGCbJv8a/skB
         8sxXZQB6ZithtN2CUnQGqIpMOoA1svZnNqo2sknHF8MINDNwN5j2dfcQxDLnDSnwm4uU
         7YlQ==
X-Gm-Message-State: APjAAAW837VGV43UP6GZELhfjwQVnDFNzcLDpjJs5Brr7tCKA6rzZ+XJ
        GvxQzh+OsnBA74Spsogyfcs=
X-Google-Smtp-Source: APXvYqzKPe/LoYUjpZuEEK8kE1cO8ArSTwWZ2pZ6pRISRy4Kk7cykjY8qZRi1VdlMlV9HSKs3WQKqw==
X-Received: by 2002:a17:902:6bc3:: with SMTP id m3mr4555759plt.185.1576087856306;
        Wed, 11 Dec 2019 10:10:56 -0800 (PST)
Received: from localhost.localdomain (campus-094-212.ucdavis.edu. [168.150.94.212])
        by smtp.gmail.com with ESMTPSA id x33sm3552651pga.86.2019.12.11.10.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 10:10:55 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/3] xen/blkback: Remove unnecessary static variable name prefixes
Date:   Wed, 11 Dec 2019 18:10:16 +0000
Message-Id: <20191211181016.14366-4-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211181016.14366-1-sjpark@amazon.de>
References: <20191211181016.14366-1-sjpark@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A few of static variables in blkback have 'xen_blkif_' prefix, though it
is unnecessary for static variables.  This commit removes such prefixes.

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/block/xen-blkback/blkback.c | 37 +++++++++++++----------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 98823d150905..f41c698dd854 100644
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
 
 /* Once a memory pressure is detected, squeeze free page pools for a while. */
@@ -249,7 +248,7 @@ static int add_persistent_gnt(struct xen_blkif_ring *ring,
 	struct persistent_gnt *this;
 	struct xen_blkif *blkif = ring->blkif;
 
-	if (ring->persistent_gnt_c >= xen_blkif_max_pgrants) {
+	if (ring->persistent_gnt_c >= max_pgrants) {
 		if (!blkif->vbd.overflow_max_grants)
 			blkif->vbd.overflow_max_grants = 1;
 		return -EBUSY;
@@ -412,14 +411,13 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
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
@@ -614,8 +612,7 @@ static void print_stats(struct xen_blkif_ring *ring)
 		 current->comm, ring->st_oo_req,
 		 ring->st_rd_req, ring->st_wr_req,
 		 ring->st_f_req, ring->st_ds_req,
-		 ring->persistent_gnt_c,
-		 xen_blkif_max_pgrants);
+		 ring->persistent_gnt_c, max_pgrants);
 	ring->st_print = jiffies + msecs_to_jiffies(10 * 1000);
 	ring->st_rd_req = 0;
 	ring->st_wr_req = 0;
@@ -675,7 +672,7 @@ int xen_blkif_schedule(void *arg)
 		if (time_before(jiffies, buffer_squeeze_end))
 			shrink_free_pagepool(ring, 0);
 		else
-			shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
+			shrink_free_pagepool(ring, max_buffer_pages);
 
 		if (log_stats && time_after(jiffies, ring->st_print))
 			print_stats(ring);
@@ -902,7 +899,7 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 			continue;
 		}
 		if (use_persistent_gnts &&
-		    ring->persistent_gnt_c < xen_blkif_max_pgrants) {
+		    ring->persistent_gnt_c < max_pgrants) {
 			/*
 			 * We are using persistent grants, the grant is
 			 * not mapped but we might have room for it.
@@ -929,7 +926,7 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
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

