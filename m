Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A0EC34359
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5D924741
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPQK3qsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLMNC5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:02:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42296 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfLMNC5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 08:02:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so1437694pfz.9;
        Fri, 13 Dec 2019 05:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uEiwYwG2ib2Yeq5P9ACEefY7MIinaV0AW/8h9n1+N1Q=;
        b=gPQK3qskrW2gOr2veuLvf3gAx9ng3L/VHZJ7mjG7Sk5Snik2Gdpm4PiVQRTPy8jyMD
         0pn0MpgBCOy4m0xbDoG3lG2ws4voo87ZmXeWEIWxdrnmdf+h6UdUexqPOHE27GIYfOu7
         dYbRwrNRkbApSAfXC5UtRr5A8euEdeWOOGWTGgdpDhLF1hWuwNJISZwaEz/x3lRZmpqr
         OQ9bnyjBNR5dYnu2g2t8hsQ3gST0M32svalZmf8VLJWyccpz52Dh1H5GzWBP0zzN+r5L
         2FCClYGdKGhx8BvcHCa/yvk3Kenf83R6/UT+CsgF5v04H3sCb9iUkphjcrAqHEkpfb7h
         13nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEiwYwG2ib2Yeq5P9ACEefY7MIinaV0AW/8h9n1+N1Q=;
        b=Dk28sXf3AYMCkPa9weGBqI5U8ZDZDouZ9oDaqOd6+NXuF+ztR7YPISuinvHPlmR310
         kbceA90wfsAGkWSnJS5K0lfmSfWP8cXfsdtb2LJDxP1ELb3yQ/oNw5wEOrd1J4xLcM8m
         AotPV4X5JBBNJZDtiNwIJR2msZp2EpHdWwdq2UxQKoX8k7MeUf40ca99+uKxXI736XrX
         q2AOPa3PqYSZ5sRZ38xCHMUhlaNKGkIWoaGhvZM9Ky9fzca62FsXUPlnO8R482BM85zy
         PiqF4BnZeFABDf0vkwk4g+gx/5HnJoU2Sf69CKTFh1DxHK4b43HgSuG0ghG1kdC0WSpV
         lP8g==
X-Gm-Message-State: APjAAAXBb1jtsTRzzmsRr3Ai/Gq1GBGE0ynGM9l972J2kYQcOZUQU+oh
        TY883rN1yfRbbEu+kamitTI=
X-Google-Smtp-Source: APXvYqweIDheQHOiqrv3fPYFpeQWsnwFO9Q+ZKi9VcsDSHxaFOZMz0N8weNLFTTFp6v9m/m8d0pPvw==
X-Received: by 2002:a63:1e5c:: with SMTP id p28mr17037963pgm.235.1576242176233;
        Fri, 13 Dec 2019 05:02:56 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id k3sm10872278pgc.3.2019.12.13.05.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 05:02:55 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/3] xen/blkback: Remove unnecessary static variable name prefixes
Date:   Fri, 13 Dec 2019 13:02:11 +0000
Message-Id: <20191213130211.24011-4-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213130211.24011-1-sjpark@amazon.de>
References: <20191213130211.24011-1-sjpark@amazon.de>
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
index 26606c4896fd..85ff629a7546 100644
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

