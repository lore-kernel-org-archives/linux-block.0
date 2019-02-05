Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F55BC282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 06:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026CF20811
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 06:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="FccsyZpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfBEGvF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:51:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43167 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfBEGvF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Feb 2019 01:51:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so1929867eds.10
        for <linux-block@vger.kernel.org>; Mon, 04 Feb 2019 22:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ks4AwJ/Lz9NEgmjjMHvrTbw6PiCAExsaDyxJoWgUXXw=;
        b=FccsyZpaVox0twCOf2Z3MNd7xpwja+GDWVEL4EbPEM7bsRm+3F16HsDzhWgZv1MsJO
         ts9BoAEJy6+fQ6hQBXgDaTWFC/CFLefdLBhuZ83ARGu6Bac60b5YaRCuz4GgKg+zCMYz
         f5FQB8kp8n+jNAPh+k5AjBehXijeukbxNvqhHbrHv+tj5bToAeWua8ujIbJ1g6N6ys2H
         jycuM9R/zxtUMMo55HPCE3Vuk7N6vfjk5ND60SN7JnYcpSahs321MjCUndVMQdeqzlui
         jTI9LpeOlNb9kpdWNQofhSon3Bc6qoVGvfbQ92NXlXZ9DDuOsMaAVTTEhmlx4YGCUXDR
         GO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ks4AwJ/Lz9NEgmjjMHvrTbw6PiCAExsaDyxJoWgUXXw=;
        b=IoCMeYIXjSLxDGwbB9plUqNSMRtxKi1Bhhl3ZswbbNdnV+FNBIM4V2jmw3YsyjwlN1
         pNPh+qbWUxylaaJXQEeAAv84oMmP4J58kgWi98lewe77a2FY2Jgv4y+niDj2Fb5S5zc/
         9u+H/egGr4VTe0m6T+ofpyrc+KPi7vnTxvLuDnvSrwLgvBfXdg/1DyzahVo6CdWnIJAO
         LZaaV1bjm7e86RnGbRqCNw58MaGbsPvEH5sJEwUPhWEaZOO0B/693Q1VqrLNJfgi+EpA
         tZ+1DlDvqe5B/mmnpHQ6/A7ZL65mH/Ang82KZmlHH3Mu10yoruBTVFQhFgdBvCjRj0q1
         V7+Q==
X-Gm-Message-State: AHQUAub2chTqA4FTFIX+vAMj/lAzkEoyy3oqKhW68/3hqVfz8PhzE7uP
        wOMAm99GcjEVN8XFbrsFgaUAQg==
X-Google-Smtp-Source: AHgI3IZJjRcvmzwAhmhGE3rzcaYustbUSHG1oU3RQEz6aV0p62NpGbYiazyGdw+C4cRjImBVDwxDiQ==
X-Received: by 2002:aa7:d394:: with SMTP id x20mr2602346edq.193.1549349463183;
        Mon, 04 Feb 2019 22:51:03 -0800 (PST)
Received: from ch-wrk-javier.cnexlabs.com (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id z40sm4847371edz.86.2019.02.04.22.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 22:51:02 -0800 (PST)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     mb@lightnvm.io
Cc:     hans.holmberg@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
Subject: [PATCH V3] lightnvm: pblk: prevent stall due to wb threshold
Date:   Tue,  5 Feb 2019 07:50:42 +0100
Message-Id: <20190205065042.6727-1-javier@javigon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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
---

 Changes since V1:
   - Fix a bad arithmetinc on the rate-limiter max_io calculation (from
     Hans)
 Changes since V2:
   - Address case where mw_cunits = 0 in the new math

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
2.17.1

