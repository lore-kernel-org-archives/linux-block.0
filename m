Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A4FC169C4
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 02:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C4720855
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 02:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="OhpGMpE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfBACie (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 21:38:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40898 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfBACid (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 21:38:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so2412600pfo.7
        for <linux-block@vger.kernel.org>; Thu, 31 Jan 2019 18:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=from:to:cc:subject:date:message-id;
        bh=/7m4uGxr/GbIiyAtuzOoZgf8Kr1IJ+5N52+KflAz8Z4=;
        b=OhpGMpE1J/3BFY4B6562yNrzRauhcjcqgTnbbrh8HYt/tUJw1k3wPJYi32MOosGKHj
         mGBl9/E5hEVrXVLqjblKNRA7MOXk5zWrskgQLT8J4znPiSF3mA5DNFWY1c/Nwgjq6A84
         tS6yip93HVMFEULaT0paHPQ0ylS027qUuFMCDJ5kV2QrcUj0j7RXPmld/OZCsLFqyxzH
         0HtBCr61vI+PK30U2yaUChYp9TIEhhOyWyE0NPH34BsnRlrmBZeRS3kxDgEGlxhWALqL
         YspdTXVxRx5MHPU8jQDiupmL68530SXXWyHLAg00NdFC764rgBPVizkPkPHsRT73t3Uz
         NvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/7m4uGxr/GbIiyAtuzOoZgf8Kr1IJ+5N52+KflAz8Z4=;
        b=DS/kmng3pX23KHgOijcef1ZRKbXgZOFJeOJKgJ1US2dnCreOvIupNPaK+lTwbnGm8N
         eomeDrcZ2Kw8bSaszgmsSfio4FpA8Ak5EJx0hX/P+fhqjGuk85ZBUnssTP7EkCd/54HY
         Spd4VJFqhKC4EJivL3rkHlKe3PZMWDq1Mzf4979xf1jtd/THiF+WME6qFr/Wm/tKmlkE
         /uC+A7XbBzgwVDT3CitVwkAoyafQAUwAL6WOwNXUwXfaU8hvhAyQobAYP7oENZlSjdpm
         Cac+Bmm0zwnmtILapr4uJEcDudu0Thc9pseWS5B/BrDUO071cd+eZY1uEYPQghLUgSSI
         +n5Q==
X-Gm-Message-State: AJcUukc5EeNNQD47uWb5hfXi9V0y6lUwPEG0vlAhAQqw/2C8mXyVreCH
        DBkKQgn5ZbnmGOJTHJrUHftnXais3jE=
X-Google-Smtp-Source: ALg8bN6YPsGVmfF3HeGOCLuIiyjdkzqHRhrlP3kJEkN9xne6ySfNeaJdesmtlrvrY3cDlt0VXeaB0A==
X-Received: by 2002:a62:3888:: with SMTP id f130mr36616644pfa.132.1548988712415;
        Thu, 31 Jan 2019 18:38:32 -0800 (PST)
Received: from bohr1.soe.ucsc.edu (bohr1.soe.ucsc.edu. [128.114.52.184])
        by smtp.gmail.com with ESMTPSA id y9sm9709459pfi.74.2019.01.31.18.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 18:38:30 -0800 (PST)
From:   Heiner Litz <hlitz@ucsc.edu>
To:     mb@lightnvm.io
Cc:     javier@javigon.com, hans.holmberg@cnexlabs.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiner Litz <hlitz@ucsc.edu>
Subject: [PATCH V2] lightnvm: pblk: fix race condition on GC
Date:   Thu, 31 Jan 2019 18:38:06 -0800
Message-Id: <20190201023806.39895-1-hlitz@ucsc.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch fixes a race condition where a write is mapped to the last
sectors of a line. The write is synced to the device but the L2P is not
updated yet. When the line is garbage collected before the L2P update is
performed, the sectors are ignored by the GC logic and the line is freed
before all sectors are moved. When the L2P is finally updated, it contains
a mapping to a freed line, subsequent reads of the corresponding LBAs fail.

This patch introduces a per line counter specifying the number of sectors
that are synced to the device but have not been updated in the L2P. Lines
with a counter of greater than zero will not be selected for GC.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
---

v2: changed according to Javier's comment. Instead of performing check
while holding the trans_lock, add an atomic per line counter

 drivers/lightnvm/pblk-core.c  |  1 +
 drivers/lightnvm/pblk-gc.c    | 20 +++++++++++++-------
 drivers/lightnvm/pblk-map.c   |  1 +
 drivers/lightnvm/pblk-rb.c    |  1 +
 drivers/lightnvm/pblk-write.c |  1 +
 drivers/lightnvm/pblk.h       |  1 +
 6 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index eabcbc119681..b7ed0502abef 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1278,6 +1278,7 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 	spin_unlock(&line->lock);
 
 	kref_init(&line->ref);
+	atomic_set(&line->sec_to_update, 0);
 
 	return 0;
 }
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 2fa118c8eb71..26a52ea7ec45 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -365,16 +365,22 @@ static struct pblk_line *pblk_gc_get_victim_line(struct pblk *pblk,
 						 struct list_head *group_list)
 {
 	struct pblk_line *line, *victim;
-	int line_vsc, victim_vsc;
+	unsigned int line_vsc = ~0x0L, victim_vsc = ~0x0L;
 
 	victim = list_first_entry(group_list, struct pblk_line, list);
+
 	list_for_each_entry(line, group_list, list) {
-		line_vsc = le32_to_cpu(*line->vsc);
-		victim_vsc = le32_to_cpu(*victim->vsc);
-		if (line_vsc < victim_vsc)
+		if (!atomic_read(&line->sec_to_update))
+			line_vsc = le32_to_cpu(*line->vsc);
+		if (line_vsc < victim_vsc) {
 			victim = line;
+			victim_vsc = le32_to_cpu(*victim->vsc);
+		}
 	}
 
+	if (victim_vsc == ~0x0)
+		return NULL;
+
 	return victim;
 }
 
@@ -448,13 +454,13 @@ static void pblk_gc_run(struct pblk *pblk)
 
 	do {
 		spin_lock(&l_mg->gc_lock);
-		if (list_empty(group_list)) {
+
+		line = pblk_gc_get_victim_line(pblk, group_list);
+		if (!line) {
 			spin_unlock(&l_mg->gc_lock);
 			break;
 		}
 
-		line = pblk_gc_get_victim_line(pblk, group_list);
-
 		spin_lock(&line->lock);
 		WARN_ON(line->state != PBLK_LINESTATE_CLOSED);
 		line->state = PBLK_LINESTATE_GC;
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 79df583ea709..7fbc99b60cac 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -73,6 +73,7 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 		 */
 		if (i < valid_secs) {
 			kref_get(&line->ref);
+			atomic_inc(&line->sec_to_update);
 			w_ctx = pblk_rb_w_ctx(&pblk->rwb, sentry + i);
 			w_ctx->ppa = ppa_list[i];
 			meta->lba = cpu_to_le64(w_ctx->lba);
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index a6133b50ed9c..03c241b340ea 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -260,6 +260,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int to_update)
 							entry->cacheline);
 
 		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
+		atomic_dec(&line->sec_to_update);
 		kref_put(&line->ref, pblk_line_put);
 		clean_wctx(w_ctx);
 		rb->l2p_update = pblk_rb_ptr_wrap(rb, rb->l2p_update, 1);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 06d56deb645d..6593deab52da 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -177,6 +177,7 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		 * re-map these entries
 		 */
 		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
+		atomic_dec(&line->sec_to_update);
 		kref_put(&line->ref, pblk_line_put);
 	}
 	spin_unlock(&pblk->trans_lock);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index a6386d5acd73..ac3ab778e976 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -487,6 +487,7 @@ struct pblk_line {
 	__le32 *vsc;			/* Valid sector count in line */
 
 	struct kref ref;		/* Write buffer L2P references */
+	atomic_t sec_to_update;         /* Outstanding L2P updates to ppa */
 
 	struct pblk_w_err_gc *w_err_gc;	/* Write error gc recovery metadata */
 
-- 
2.17.1

