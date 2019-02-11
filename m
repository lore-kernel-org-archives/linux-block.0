Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D0BC169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 12:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A022075B
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 12:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="tNVuQrmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfBKMZs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:25:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45703 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfBKMZd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 07:25:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so7553595lfa.12
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 04:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8V6tAD6ianDzVJV9jLJWZ3zCHF2Gv41r5hfwz3shMqg=;
        b=tNVuQrmcOX9opYuNSkmd2cHthVde2CNQLD1Nz9ouyMyZuF4l0axH/ecLCeC8U2QYb6
         FXh16jdx8F0F2KWMmOHDZ0oYURAMVU2RC0acvMSD1Y2zDVMgsm7sd1J3LVNqPqv2wuG9
         tDgzlv1W2Dr+6l9OU6bBPaWgUP69BH+Jzh34xIoqU/yxSt6sU1PhF3p/PdrQK5fU9tdM
         xTIQEX3sc2LhYsSrEqHd157OhaETG6cTZtSHsUo/+XR6SicJEyKjcD1JjNRPrp5XmAFF
         0ymahKfDaQkGoiAr5t6lvY2d3B+d2XdlMEc75C4V38BS5iiZ1FMJ0tkQlbe+3twYZlg+
         DODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8V6tAD6ianDzVJV9jLJWZ3zCHF2Gv41r5hfwz3shMqg=;
        b=lgGLN/wSsk6xD25DuZHbgRhVPkKUqL+ZxOpakG7B+DM+7VSQtX5X3XDYmwle+Pw79R
         dEldcLiHkquSbnw228Ck1LaiUqT27/ybP7ZN1jULh+ot7Bags/mihZsHzAMW2yDMPHHk
         mONqFz4sP2WzZUyOGXPoLaLYf6RTcC/k6iP2rmpBugwUDfhnQIBT8vFhJmMBEegDs510
         rTJCBWE8m5v7jr6TjxX4p3uGMXwdXCJ3OKbF5nx8D+V7LSq39cfja9gnslg9VmwQe8bK
         LrQknSvOEdp0TQrYFbDLcEE9AdA/WTN5gqUDlfCzVQX8qwNvCROujyA3+Zcl/cGyEhVD
         sduA==
X-Gm-Message-State: AHQUAubko8reTXft1mEbsA8UcZhj1R9CjiK8HXyBGDIuE5t+Q7fkgQK2
        IpCVf7ISAQpCkHdvl0JuFN91MA==
X-Google-Smtp-Source: AHgI3IZbPjmbsyg6LgZObXJHFaFiGAkIyErZ8bk/8BCvzRYONOMO/bUfFKP09S5CeJJIPdP891bZUQ==
X-Received: by 2002:a19:2242:: with SMTP id i63mr6828146lfi.39.1549887930167;
        Mon, 11 Feb 2019 04:25:30 -0800 (PST)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id d70sm2278481lfe.14.2019.02.11.04.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:25:29 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 7/8] lightnvm: pblk: prevent stall due to wb threshold
Date:   Mon, 11 Feb 2019 13:25:08 +0100
Message-Id: <20190211122509.19910-8-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190211122509.19910-1-mb@lightnvm.io>
References: <20190211122509.19910-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

In order to respect mw_cuinits, pblk's write buffer maintains a
backpointer to protect data not yet persisted; when writing to the write
buffer, this backpointer defines a threshold that pblk's rate-limiter
enforces.

On small PU configurations, the following scenarios might take place: (i)
the threshold is larger than the write buffer and (ii) the threshold is
smaller than the write buffer, but larger than the maximun allowed
split bio - 256KB at this moment (Note that writes are not always
split - we only do this when we the size of the buffer is smaller
than the buffer). In both cases, pblk's rate-limiter prevents the I/O to
be written to the buffer, thus stalling.

This patch fixes the original backpointer implementation by considering
the threshold both on buffer creation and on the rate-limiters path,
when bio_split is triggered (case (ii) above).

Fixes: 766c8ceb16fc ("lightnvm: pblk: guarantee that backpointer is respected on writer stall")
Signed-off-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-rb.c | 25 +++++++++++++++++++------
 drivers/lightnvm/pblk-rl.c |  5 ++---
 drivers/lightnvm/pblk.h    |  2 +-
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index d4ca8c64ee0f..a6133b50ed9c 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -45,10 +45,23 @@ void pblk_rb_free(struct pblk_rb *rb)
 /*
  * pblk_rb_calculate_size -- calculate the size of the write buffer
  */
-static unsigned int pblk_rb_calculate_size(unsigned int nr_entries)
+static unsigned int pblk_rb_calculate_size(unsigned int nr_entries,
+					   unsigned int threshold)
 {
-	/* Alloc a write buffer that can at least fit 128 entries */
-	return (1 << max(get_count_order(nr_entries), 7));
+	unsigned int thr_sz = 1 << (get_count_order(threshold + NVM_MAX_VLBA));
+	unsigned int max_sz = max(thr_sz, nr_entries);
+	unsigned int max_io;
+
+	/* Alloc a write buffer that can (i) fit at least two split bios
+	 * (considering max I/O size NVM_MAX_VLBA, and (ii) guarantee that the
+	 * threshold will be respected
+	 */
+	max_io = (1 << max((int)(get_count_order(max_sz)),
+				(int)(get_count_order(NVM_MAX_VLBA << 1))));
+	if ((threshold + NVM_MAX_VLBA) >= max_io)
+		max_io <<= 1;
+
+	return max_io;
 }
 
 /*
@@ -67,12 +80,12 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
 	unsigned int alloc_order, order, iter;
 	unsigned int nr_entries;
 
-	nr_entries = pblk_rb_calculate_size(size);
+	nr_entries = pblk_rb_calculate_size(size, threshold);
 	entries = vzalloc(array_size(nr_entries, sizeof(struct pblk_rb_entry)));
 	if (!entries)
 		return -ENOMEM;
 
-	power_size = get_count_order(size);
+	power_size = get_count_order(nr_entries);
 	power_seg_sz = get_count_order(seg_size);
 
 	down_write(&pblk_rb_lock);
@@ -149,7 +162,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int threshold,
 	 * Initialize rate-limiter, which controls access to the write buffer
 	 * by user and GC I/O
 	 */
-	pblk_rl_init(&pblk->rl, rb->nr_entries);
+	pblk_rl_init(&pblk->rl, rb->nr_entries, threshold);
 
 	return 0;
 }
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index 76116d5f78e4..b014957dde0b 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -207,7 +207,7 @@ void pblk_rl_free(struct pblk_rl *rl)
 	del_timer(&rl->u_timer);
 }
 
-void pblk_rl_init(struct pblk_rl *rl, int budget)
+void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold)
 {
 	struct pblk *pblk = container_of(rl, struct pblk, rl);
 	struct nvm_tgt_dev *dev = pblk->dev;
@@ -217,7 +217,6 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	int sec_meta, blk_meta;
 	unsigned int rb_windows;
 
-
 	/* Consider sectors used for metadata */
 	sec_meta = (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_lines;
 	blk_meta = DIV_ROUND_UP(sec_meta, geo->clba);
@@ -234,7 +233,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	/* To start with, all buffer is available to user I/O writers */
 	rl->rb_budget = budget;
 	rl->rb_user_max = budget;
-	rl->rb_max_io = budget >> 1;
+	rl->rb_max_io = threshold ? (budget - threshold) : (budget - 1);
 	rl->rb_gc_max = 0;
 	rl->rb_state = PBLK_RL_HIGH;
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 72ae8755764e..a6386d5acd73 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -924,7 +924,7 @@ int pblk_gc_sysfs_force(struct pblk *pblk, int force);
 /*
  * pblk rate limiter
  */
-void pblk_rl_init(struct pblk_rl *rl, int budget);
+void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold);
 void pblk_rl_free(struct pblk_rl *rl);
 void pblk_rl_update_rates(struct pblk_rl *rl);
 int pblk_rl_high_thrs(struct pblk_rl *rl);
-- 
2.19.1

