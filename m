Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4909C32751
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 09:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925572089E
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 09:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="w5A9WS7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfGaJmU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:42:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39061 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfGaJmU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 05:42:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id v85so46929975lfa.6
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ruGLS7qlWMQ2x0nF7R27l+9sEyn5zr5g4bSB5JJD5E8=;
        b=w5A9WS7JZTV1AwMxJtkiM8y3lQz+Ic3KOzFHMizjLEmKkoce+WbU3TLR7oLJ3QMcds
         +FkCYpxRbm27ytBUYqJxHePK7uLEQ0ZmtagJpjlB0BfZaPlN8s7q//7lHc7ZzPqPJNbV
         XRv1kUyyxda8FxC0TSWPxcNv4iFnTq5JT3aYfZOEXc8xMheIIXMuV5emNBtGLOYOBS45
         KlrQ2SOh6JA5dlcKBRF3V0bkeZRyU+bYF/RTC4eFrDq9d86mfwjvUHZcdvc6sczevsDB
         SySuUG1Kj9Rv/xGwBvplkdVXDN6HxXospm3JGlSfAr1lE9S3uxaP+J9mimRFEsnawsID
         Gbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ruGLS7qlWMQ2x0nF7R27l+9sEyn5zr5g4bSB5JJD5E8=;
        b=LUtjIFlFVzsrQc6HWD9F5ZUPY57rrCgldLPNKbE/BFuccoytolLnxo6/gF6Yq2qi0k
         7j6vXipR6uY0jOJpl/3XNxyx/ckMAfYOLYs2al1X4kn/Q/c+ojf3vtRXde0lLDAxcAlR
         mjIJLVrmXqCwWZEoeP3gx6Y3cRHIQ2fLxs7hZFOq3/BnSlG5wIMtDB7TMpXpWUo03uqs
         m3axu3sM2Io2LGsRE8zN+zKYdfjGn6i5ZuZ/79mdax6J7jqewCR7cpLHXhp1qsHvIdRT
         IPXpnJymePofOHMwu4S/FsfzcyO+gothLKsNbHOsxFAjpWUfv7xhwjAcuK8QF2MJY9OY
         Plzw==
X-Gm-Message-State: APjAAAXI8uwzejksdCPeeIdY2wXyY7JQXTj//d+iW80d+87zC+z7I9lz
        y3qmRRpej02YJ8QZzfOXzZA=
X-Google-Smtp-Source: APXvYqx1b9nmoDTCR6aOEby82ARJ8uYbuEyVCUwBwnrKkb3uR8jAO2YsHbHUhEMmFFFHiMd2vUOQxw==
X-Received: by 2002:a19:641a:: with SMTP id y26mr55770553lfb.29.1564566137275;
        Wed, 31 Jul 2019 02:42:17 -0700 (PDT)
Received: from titan.lan (90-230-197-193-no86.tbcn.telia.com. [90.230.197.193])
        by smtp.gmail.com with ESMTPSA id t4sm15408200ljh.9.2019.07.31.02.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 02:42:16 -0700 (PDT)
From:   Hans Holmberg <hans@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans@owltronix.com>
Subject: [PATCH 3/4] lightnvm: pblk: use kvmalloc for metadata
Date:   Wed, 31 Jul 2019 11:41:35 +0200
Message-Id: <1564566096-28756-4-git-send-email-hans@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564566096-28756-1-git-send-email-hans@owltronix.com>
References: <1564566096-28756-1-git-send-email-hans@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no reason now not to use kvmalloc, so
so replace the internal metadata allocation scheme.

Signed-off-by: Hans Holmberg <hans@owltronix.com>
---
 drivers/lightnvm/pblk-core.c |  3 +--
 drivers/lightnvm/pblk-gc.c   | 19 ++++++++-----------
 drivers/lightnvm/pblk-init.c | 38 ++++++++++----------------------------
 drivers/lightnvm/pblk.h      | 23 -----------------------
 4 files changed, 19 insertions(+), 64 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a58d3c84a3f2..b413bafe93fd 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1839,8 +1839,7 @@ static void pblk_save_lba_list(struct pblk *pblk, struct pblk_line *line)
 	struct pblk_w_err_gc *w_err_gc = line->w_err_gc;
 	struct pblk_emeta *emeta = line->emeta;
 
-	w_err_gc->lba_list = pblk_malloc(lba_list_size,
-					 l_mg->emeta_alloc_type, GFP_KERNEL);
+	w_err_gc->lba_list = kvmalloc(lba_list_size, GFP_KERNEL);
 	memcpy(w_err_gc->lba_list, emeta_to_lbas(pblk, emeta->buf),
 				lba_list_size);
 }
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 63ee205b41c4..2581eebcfc41 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -132,14 +132,12 @@ static __le64 *get_lba_list_from_emeta(struct pblk *pblk,
 				       struct pblk_line *line)
 {
 	struct line_emeta *emeta_buf;
-	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
 	unsigned int lba_list_size = lm->emeta_len[2];
 	__le64 *lba_list;
 	int ret;
 
-	emeta_buf = pblk_malloc(lm->emeta_len[0],
-				l_mg->emeta_alloc_type, GFP_KERNEL);
+	emeta_buf = kvmalloc(lm->emeta_len[0], GFP_KERNEL);
 	if (!emeta_buf)
 		return NULL;
 
@@ -147,7 +145,7 @@ static __le64 *get_lba_list_from_emeta(struct pblk *pblk,
 	if (ret) {
 		pblk_err(pblk, "line %d read emeta failed (%d)\n",
 				line->id, ret);
-		pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
+		kvfree(emeta_buf);
 		return NULL;
 	}
 
@@ -161,16 +159,16 @@ static __le64 *get_lba_list_from_emeta(struct pblk *pblk,
 	if (ret) {
 		pblk_err(pblk, "inconsistent emeta (line %d)\n",
 				line->id);
-		pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
+		kvfree(emeta_buf);
 		return NULL;
 	}
 
-	lba_list = pblk_malloc(lba_list_size,
-			       l_mg->emeta_alloc_type, GFP_KERNEL);
+	lba_list = kvmalloc(lba_list_size, GFP_KERNEL);
+
 	if (lba_list)
 		memcpy(lba_list, emeta_to_lbas(pblk, emeta_buf), lba_list_size);
 
-	pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
+	kvfree(emeta_buf);
 
 	return lba_list;
 }
@@ -181,7 +179,6 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 									ws);
 	struct pblk *pblk = line_ws->pblk;
 	struct pblk_line *line = line_ws->line;
-	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
@@ -272,7 +269,7 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 		goto next_rq;
 
 out:
-	pblk_mfree(lba_list, l_mg->emeta_alloc_type);
+	kvfree(lba_list);
 	kfree(line_ws);
 	kfree(invalid_bitmap);
 
@@ -286,7 +283,7 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 fail_free_gc_rq:
 	kfree(gc_rq);
 fail_free_lba_list:
-	pblk_mfree(lba_list, l_mg->emeta_alloc_type);
+	kvfree(lba_list);
 fail_free_invalid_bitmap:
 	kfree(invalid_bitmap);
 fail_free_ws:
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index b351c7f002de..9a967a2e83dd 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -543,7 +543,7 @@ static void pblk_line_mg_free(struct pblk *pblk)
 
 	for (i = 0; i < PBLK_DATA_LINES; i++) {
 		kfree(l_mg->sline_meta[i]);
-		pblk_mfree(l_mg->eline_meta[i]->buf, l_mg->emeta_alloc_type);
+		kvfree(l_mg->eline_meta[i]->buf);
 		kfree(l_mg->eline_meta[i]);
 	}
 
@@ -560,7 +560,7 @@ static void pblk_line_meta_free(struct pblk_line_mgmt *l_mg,
 	kfree(line->erase_bitmap);
 	kfree(line->chks);
 
-	pblk_mfree(w_err_gc->lba_list, l_mg->emeta_alloc_type);
+	kvfree(w_err_gc->lba_list);
 	kfree(w_err_gc);
 }
 
@@ -890,29 +890,14 @@ static int pblk_line_mg_init(struct pblk *pblk)
 		if (!emeta)
 			goto fail_free_emeta;
 
-		if (lm->emeta_len[0] > KMALLOC_MAX_CACHE_SIZE) {
-			l_mg->emeta_alloc_type = PBLK_VMALLOC_META;
-
-			emeta->buf = vmalloc(lm->emeta_len[0]);
-			if (!emeta->buf) {
-				kfree(emeta);
-				goto fail_free_emeta;
-			}
-
-			emeta->nr_entries = lm->emeta_sec[0];
-			l_mg->eline_meta[i] = emeta;
-		} else {
-			l_mg->emeta_alloc_type = PBLK_KMALLOC_META;
-
-			emeta->buf = kmalloc(lm->emeta_len[0], GFP_KERNEL);
-			if (!emeta->buf) {
-				kfree(emeta);
-				goto fail_free_emeta;
-			}
-
-			emeta->nr_entries = lm->emeta_sec[0];
-			l_mg->eline_meta[i] = emeta;
+		emeta->buf = kvmalloc(lm->emeta_len[0], GFP_KERNEL);
+		if (!emeta->buf) {
+			kfree(emeta);
+			goto fail_free_emeta;
 		}
+
+		emeta->nr_entries = lm->emeta_sec[0];
+		l_mg->eline_meta[i] = emeta;
 	}
 
 	for (i = 0; i < l_mg->nr_lines; i++)
@@ -926,10 +911,7 @@ static int pblk_line_mg_init(struct pblk *pblk)
 
 fail_free_emeta:
 	while (--i >= 0) {
-		if (l_mg->emeta_alloc_type == PBLK_VMALLOC_META)
-			vfree(l_mg->eline_meta[i]->buf);
-		else
-			kfree(l_mg->eline_meta[i]->buf);
+		kvfree(l_mg->eline_meta[i]->buf);
 		kfree(l_mg->eline_meta[i]);
 	}
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index d515d3409a74..86ffa875bfe1 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -482,11 +482,6 @@ struct pblk_line {
 #define PBLK_DATA_LINES 4
 
 enum {
-	PBLK_KMALLOC_META = 1,
-	PBLK_VMALLOC_META = 2,
-};
-
-enum {
 	PBLK_EMETA_TYPE_HEADER = 1,	/* struct line_emeta first sector */
 	PBLK_EMETA_TYPE_LLBA = 2,	/* lba list - type: __le64 */
 	PBLK_EMETA_TYPE_VSC = 3,	/* vsc list - type: __le32 */
@@ -521,9 +516,6 @@ struct pblk_line_mgmt {
 
 	__le32 *vsc_list;		/* Valid sector counts for all lines */
 
-	/* Metadata allocation type: VMALLOC | KMALLOC */
-	int emeta_alloc_type;
-
 	/* Pre-allocated metadata for data lines */
 	struct pblk_smeta *sline_meta[PBLK_DATA_LINES];
 	struct pblk_emeta *eline_meta[PBLK_DATA_LINES];
@@ -934,21 +926,6 @@ void pblk_rl_werr_line_out(struct pblk_rl *rl);
 int pblk_sysfs_init(struct gendisk *tdisk);
 void pblk_sysfs_exit(struct gendisk *tdisk);
 
-static inline void *pblk_malloc(size_t size, int type, gfp_t flags)
-{
-	if (type == PBLK_KMALLOC_META)
-		return kmalloc(size, flags);
-	return vmalloc(size);
-}
-
-static inline void pblk_mfree(void *ptr, int type)
-{
-	if (type == PBLK_KMALLOC_META)
-		kfree(ptr);
-	else
-		vfree(ptr);
-}
-
 static inline struct nvm_rq *nvm_rq_from_c_ctx(void *c_ctx)
 {
 	return c_ctx - sizeof(struct nvm_rq);
-- 
2.7.4

