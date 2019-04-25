Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A97C10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 05:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B6F2077C
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 05:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="aLBIYh3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfDYFV7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:21:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45572 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbfDYFV7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 01:21:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so10549803pgk.12
        for <linux-block@vger.kernel.org>; Wed, 24 Apr 2019 22:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=from:to:cc:subject:date:message-id;
        bh=zn9cc6ZiibH0Aqnap2SV5VOG5RiLPWeFHuYYK/lEfEk=;
        b=aLBIYh3mGKEBxohjeussvPaSp6YRBu/U+5nDdphy/a6h6BxDF1FDQFouqxRRach2Wm
         TEHMe/XRB5P1OcBQEura40nmImB1NYHpZojpKsspHsfCAFqSKn45+1XVkTwAWVaNs6NG
         maPw+aHiK8Walb5E7IgbbPdJQRA8GrvxRVIVFVProi95inTIPfaDg5bJrerM2bbvEUD7
         r86RsBno0WCRB8rZG+i8b48pqUfgLKVCLv8+q/qRTaBRleCurOtVPcd2ATz4PiwBBeoV
         OJI4CtQyiISRiaTLUgGkHjK/PUyG3CzLbFcD9HezrcFewvDpF4QyMXkV939Y+U3b4tY3
         OnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zn9cc6ZiibH0Aqnap2SV5VOG5RiLPWeFHuYYK/lEfEk=;
        b=kGrRtnZSRdai3+6yU4khKPxXl+GSOozKM4T0+KHyCQYq7pnZ17ziH/PIs/oRonYa/W
         XunXEz4Iw3iBLpBv9Da75dPSB33rqBK7o6Cb/BOJleLEGVziuc79fVsAAEqJE6nWQUDJ
         A+XaR6XGiFShXqnC8evuspzRJXvulkhxSH5s8p7bI9FJBDMRvo+Dhr0VKVz7h9XIGqPJ
         FwcaDl6OoFBV7IvTh3sKGnLicjHcY0xcqQxmzJJmzTQR+VGc7tqJd9jeED2HePGaUJjV
         GxpnDX/4Y0OjQJggTaAQj0oVIJ7kgYBtp7uLTRDWw7lCPa5aGPcEmJeuew+05jwkCfpa
         eu4g==
X-Gm-Message-State: APjAAAVGKikNGhZI/Ng9UqqXN+Sd5EcZk0aPbMPVzzQiEz/zW+ahtvrJ
        2beDm51Q5/fM0jIjK5t287q3Pg==
X-Google-Smtp-Source: APXvYqwhgnt9YcyTad82uPpG26cq4kZjz6CvGzNDrK7DImCo5M1BZF46DtAIWDFSeLKoR8/agszgGQ==
X-Received: by 2002:a63:c104:: with SMTP id w4mr34525762pgf.409.1556169717855;
        Wed, 24 Apr 2019 22:21:57 -0700 (PDT)
Received: from bohr1.soe.ucsc.edu (bohr1.soe.ucsc.edu. [128.114.52.184])
        by smtp.gmail.com with ESMTPSA id p26sm43995369pfa.49.2019.04.24.22.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 22:21:57 -0700 (PDT)
From:   Heiner Litz <hlitz@ucsc.edu>
To:     mb@lightnvm.io
Cc:     javier@javigon.com, hans.holmberg@cnexlabs.com,
        igor.j.konopko@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiner Litz <hlitz@ucsc.edu>
Subject: [PATCH] lightnvm: pblk: Introduce hot-cold data separation
Date:   Wed, 24 Apr 2019 22:21:52 -0700
Message-Id: <20190425052152.6571-1-hlitz@ucsc.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the capability to manage multiple open lines. Maintain one line
for user writes (hot) and a second line for gc writes (cold). As user and
gc writes still utilize a shared ring buffer, in rare cases a multi-sector
write will contain both gc and user data. This is acceptable, as on a
tested SSD with minimum write size of 64KB, less than 1% of all writes
contain both hot and cold sectors.

For a zipfian random distribution of LBA writes with theta-zipf of 1.2,
this patch reduces write amplification from 2.5 to 1.3 and increases user
write IOPS by 2.1x.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
---
 drivers/lightnvm/pblk-core.c     | 157 +++++++++++++++++++++++--------
 drivers/lightnvm/pblk-init.c     |   9 +-
 drivers/lightnvm/pblk-map.c      |  29 +++---
 drivers/lightnvm/pblk-recovery.c |  43 ++++++---
 drivers/lightnvm/pblk-write.c    |  37 +++++---
 drivers/lightnvm/pblk.h          |  28 ++++--
 6 files changed, 213 insertions(+), 90 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 73be3a0311ff..bbb216788bc8 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1294,7 +1294,7 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
 	int ret;
 
 	spin_lock(&l_mg->free_lock);
-	l_mg->data_line = line;
+	pblk_line_set_data_line(pblk, PBLK_LINETYPE_DATA, line);
 	list_del(&line->list);
 
 	ret = pblk_line_prepare(pblk, line);
@@ -1410,7 +1410,7 @@ struct pblk_line *pblk_line_get(struct pblk *pblk)
 }
 
 static struct pblk_line *pblk_line_retry(struct pblk *pblk,
-					 struct pblk_line *line)
+					 struct pblk_line *line, int type)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line *retry_line;
@@ -1419,7 +1419,7 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
 	spin_lock(&l_mg->free_lock);
 	retry_line = pblk_line_get(pblk);
 	if (!retry_line) {
-		l_mg->data_line = NULL;
+		pblk_line_set_data_line(pblk, type, NULL);
 		spin_unlock(&l_mg->free_lock);
 		return NULL;
 	}
@@ -1432,7 +1432,7 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
 
 	pblk_line_reinit(line);
 
-	l_mg->data_line = retry_line;
+	pblk_line_set_data_line(pblk, type, retry_line);
 	spin_unlock(&l_mg->free_lock);
 
 	pblk_rl_free_lines_dec(&pblk->rl, line, false);
@@ -1450,37 +1450,29 @@ static void pblk_set_space_limit(struct pblk *pblk)
 	atomic_set(&rl->rb_space, 0);
 }
 
-struct pblk_line *pblk_line_get_first_data(struct pblk *pblk)
+struct pblk_line *pblk_line_get_first_data(struct pblk *pblk, int type)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line *line;
 
 	spin_lock(&l_mg->free_lock);
-	line = pblk_line_get(pblk);
+	line = pblk_line_init_data_line(pblk, type);
 	if (!line) {
 		spin_unlock(&l_mg->free_lock);
 		return NULL;
 	}
 
-	line->seq_nr = l_mg->d_seq_nr++;
-	line->type = PBLK_LINETYPE_DATA;
-	l_mg->data_line = line;
-
 	pblk_line_setup_metadata(line, l_mg, &pblk->lm);
 
 	/* Allocate next line for preparation */
-	l_mg->data_next = pblk_line_get(pblk);
-	if (!l_mg->data_next) {
+	if (!pblk_line_init_next_line(pblk, type)) {
 		/* If we cannot get a new line, we need to stop the pipeline.
 		 * Only allow as many writes in as we can store safely and then
 		 * fail gracefully
 		 */
 		pblk_set_space_limit(pblk);
 
-		l_mg->data_next = NULL;
-	} else {
-		l_mg->data_next->seq_nr = l_mg->d_seq_nr++;
-		l_mg->data_next->type = PBLK_LINETYPE_DATA;
+		pblk_line_set_next_line(pblk, type, NULL);
 	}
 	spin_unlock(&l_mg->free_lock);
 
@@ -1488,14 +1480,14 @@ struct pblk_line *pblk_line_get_first_data(struct pblk *pblk)
 		return NULL;
 
 	if (pblk_line_erase(pblk, line)) {
-		line = pblk_line_retry(pblk, line);
+		line = pblk_line_retry(pblk, line, type);
 		if (!line)
 			return NULL;
 	}
 
 retry_setup:
 	if (!pblk_line_init_metadata(pblk, line, NULL)) {
-		line = pblk_line_retry(pblk, line);
+		line = pblk_line_retry(pblk, line, type);
 		if (!line)
 			return NULL;
 
@@ -1503,7 +1495,7 @@ struct pblk_line *pblk_line_get_first_data(struct pblk *pblk)
 	}
 
 	if (!pblk_line_init_bb(pblk, line, 1)) {
-		line = pblk_line_retry(pblk, line);
+		line = pblk_line_retry(pblk, line, type);
 		if (!line)
 			return NULL;
 
@@ -1596,12 +1588,18 @@ void __pblk_pipeline_flush(struct pblk *pblk)
 	pblk_flush_writer(pblk);
 	pblk_wait_for_meta(pblk);
 
-	ret = pblk_recov_pad(pblk);
+	ret = pblk_recov_pad(pblk, PBLK_LINETYPE_DATA);
 	if (ret) {
 		pblk_err(pblk, "could not close data on teardown(%d)\n", ret);
 		return;
 	}
 
+	ret = pblk_recov_pad(pblk, PBLK_LINETYPE_GC);
+	if (ret) {
+		pblk_err(pblk, "could not close gc on teardown(%d)\n", ret);
+		return;
+	}
+
 	flush_workqueue(pblk->bb_wq);
 	pblk_line_close_meta_sync(pblk);
 }
@@ -1613,8 +1611,10 @@ void __pblk_pipeline_stop(struct pblk *pblk)
 	spin_lock(&l_mg->free_lock);
 	pblk->state = PBLK_STATE_STOPPED;
 	trace_pblk_state(pblk_disk_name(pblk), pblk->state);
-	l_mg->data_line = NULL;
-	l_mg->data_next = NULL;
+	pblk_line_set_data_line(pblk, PBLK_LINETYPE_DATA, NULL);
+	pblk_line_set_data_line(pblk, PBLK_LINETYPE_GC, NULL);
+	pblk_line_set_next_line(pblk, PBLK_LINETYPE_DATA, NULL);
+	pblk_line_set_next_line(pblk, PBLK_LINETYPE_GC, NULL);
 	spin_unlock(&l_mg->free_lock);
 }
 
@@ -1624,19 +1624,20 @@ void pblk_pipeline_stop(struct pblk *pblk)
 	__pblk_pipeline_stop(pblk);
 }
 
-struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
+struct pblk_line *pblk_line_replace_data(struct pblk *pblk, int type)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line *cur, *new = NULL;
 	unsigned int left_seblks;
 
-	new = l_mg->data_next;
+	new = pblk_line_get_next_line(pblk, type);
 	if (!new)
 		goto out;
 
 	spin_lock(&l_mg->free_lock);
-	cur = l_mg->data_line;
-	l_mg->data_line = new;
+
+	cur = pblk_line_get_data_line(pblk, type); 
+	pblk_line_set_data_line(pblk, type, new);
 
 	pblk_line_setup_metadata(new, l_mg, &pblk->lm);
 	spin_unlock(&l_mg->free_lock);
@@ -1659,7 +1660,7 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 
 retry_setup:
 	if (!pblk_line_init_metadata(pblk, new, cur)) {
-		new = pblk_line_retry(pblk, new);
+		new = pblk_line_retry(pblk, new, type);
 		if (!new)
 			goto out;
 
@@ -1667,7 +1668,7 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 	}
 
 	if (!pblk_line_init_bb(pblk, new, 1)) {
-		new = pblk_line_retry(pblk, new);
+		new = pblk_line_retry(pblk, new, type);
 		if (!new)
 			goto out;
 
@@ -1678,17 +1679,12 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 
 	/* Allocate next line for preparation */
 	spin_lock(&l_mg->free_lock);
-	l_mg->data_next = pblk_line_get(pblk);
-	if (!l_mg->data_next) {
+	if (!pblk_line_init_next_line(pblk, type)) {
 		/* If we cannot get a new line, we need to stop the pipeline.
 		 * Only allow as many writes in as we can store safely and then
 		 * fail gracefully
 		 */
 		pblk_stop_writes(pblk, new);
-		l_mg->data_next = NULL;
-	} else {
-		l_mg->data_next->seq_nr = l_mg->d_seq_nr++;
-		l_mg->data_next->type = PBLK_LINETYPE_DATA;
 	}
 	spin_unlock(&l_mg->free_lock);
 
@@ -1801,15 +1797,100 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 	return err;
 }
 
-struct pblk_line *pblk_line_get_data(struct pblk *pblk)
+struct pblk_line *pblk_line_get_data_line(struct pblk *pblk, int type)
 {
-	return pblk->l_mg.data_line;
+	switch (type) {
+	case PBLK_LINETYPE_DATA:
+		return pblk->l_mg.data_line;
+	case PBLK_LINETYPE_GC:
+		return pblk->l_mg.gc_line;
+	case PBLK_LINETYPE_LOG:
+		return pblk->l_mg.log_line;
+	default:
+		WARN(1, "Unsupported line type\n");
+		return NULL;
+	}
 }
 
 /* For now, always erase next line */
-struct pblk_line *pblk_line_get_erase(struct pblk *pblk)
+struct pblk_line *pblk_line_get_next_line(struct pblk *pblk, int type)
 {
-	return pblk->l_mg.data_next;
+	switch (type) {
+	case PBLK_LINETYPE_DATA:
+		return pblk->l_mg.data_next;
+	case PBLK_LINETYPE_GC:
+		return pblk->l_mg.gc_next;
+	case PBLK_LINETYPE_LOG:
+		return pblk->l_mg.log_next;
+	default:
+		WARN(1, "Unsupported line type\n");
+		return NULL;
+	}
+}
+
+void pblk_line_set_data_line(struct pblk *pblk, int type, struct pblk_line *line)
+{
+	switch (type) {
+	case PBLK_LINETYPE_DATA:
+		pblk->l_mg.data_line = line;
+		break;
+	case PBLK_LINETYPE_GC:
+		pblk->l_mg.gc_line = line;
+		break;
+	case PBLK_LINETYPE_LOG:
+		pblk->l_mg.log_line = line;
+		break;
+	default:
+		WARN(1, "Unsupported line type\n");
+	}
+}
+
+/* For now, always erase next line */
+void pblk_line_set_next_line(struct pblk *pblk, int type, struct pblk_line *line)
+{
+	switch (type) {
+	case PBLK_LINETYPE_DATA:
+		pblk->l_mg.data_next = line;
+		break;
+	case PBLK_LINETYPE_GC:
+		pblk->l_mg.gc_next = line;
+		break;
+	case PBLK_LINETYPE_LOG:
+		pblk->l_mg.log_next = line;
+		break;
+	default:
+		WARN(1, "Unsupported line type\n");
+	}
+}
+
+struct pblk_line *pblk_line_init_data_line(struct pblk *pblk, int type)
+{
+	struct pblk_line *line = pblk_line_get(pblk);
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+
+	lockdep_assert_held(&l_mg->free_lock);
+
+	if (line) {
+		line->seq_nr = l_mg->d_seq_nr++;
+		line->type = type;
+		pblk_line_set_data_line(pblk, type, line);
+	}
+	return line;
+}
+
+struct pblk_line *pblk_line_init_next_line(struct pblk *pblk, int type)
+{
+	struct pblk_line *line = pblk_line_get(pblk);
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+
+	lockdep_assert_held(&l_mg->free_lock);
+
+	if (line) {
+		line->seq_nr = l_mg->d_seq_nr++;
+		line->type = type;
+		pblk_line_set_next_line(pblk, type, line);
+	}
+	return line;
 }
 
 int pblk_line_is_full(struct pblk_line *line)
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 1e227a08e54a..0d127e32d556 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -139,11 +139,16 @@ static int pblk_l2p_recover(struct pblk *pblk, bool factory_init)
 
 	if (!line) {
 		/* Configure next line for user data */
-		line = pblk_line_get_first_data(pblk);
+		line = pblk_line_get_first_data(pblk, PBLK_LINETYPE_DATA);
 		if (!line)
 			return -EFAULT;
 	}
 
+	/* Configure next line for gc data */
+	line = pblk_line_get_first_data(pblk, PBLK_LINETYPE_GC);
+	if (!line)
+		return -EFAULT;
+
 	return 0;
 }
 
@@ -832,7 +837,7 @@ static int pblk_line_mg_init(struct pblk *pblk)
 	int i, bb_distance;
 
 	l_mg->nr_lines = geo->num_chk;
-	l_mg->log_line = l_mg->data_line = NULL;
+	l_mg->log_line = l_mg->data_line = l_mg->gc_line = NULL;
 	l_mg->l_seq_nr = l_mg->d_seq_nr = 0;
 	l_mg->nr_free_lines = 0;
 	bitmap_zero(&l_mg->meta_bitmap, PBLK_DATA_LINES);
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 5408e32b2f13..9b0539137df0 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -23,9 +23,9 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 			      struct ppa_addr *ppa_list,
 			      unsigned long *lun_bitmap,
 			      void *meta_list,
-			      unsigned int valid_secs)
+			      unsigned int valid_secs, int type)
 {
-	struct pblk_line *line = pblk_line_get_data(pblk);
+	struct pblk_line *line = pblk_line_get_data_line(pblk, type);
 	struct pblk_emeta *emeta;
 	struct pblk_w_ctx *w_ctx;
 	__le64 *lba_list;
@@ -42,7 +42,7 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 		/* If we cannot allocate a new line, make sure to store metadata
 		 * on current line and then fail
 		 */
-		line = pblk_line_replace_data(pblk);
+		line = pblk_line_replace_data(pblk, type);
 		pblk_line_close_meta(pblk, prev_line);
 
 		if (!line) {
@@ -94,8 +94,8 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 }
 
 int pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
-		 unsigned long *lun_bitmap, unsigned int valid_secs,
-		 unsigned int off)
+		unsigned long *lun_bitmap, unsigned int valid_secs,
+		unsigned int off, int type)
 {
 	void *meta_list = pblk_get_meta_for_writes(pblk, rqd);
 	void *meta_buffer;
@@ -110,7 +110,7 @@ int pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 		meta_buffer = pblk_get_meta(pblk, meta_list, i);
 
 		ret = pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
-					lun_bitmap, meta_buffer, map_secs);
+					 lun_bitmap, meta_buffer, map_secs, type);
 		if (ret)
 			return ret;
 	}
@@ -120,8 +120,9 @@ int pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 
 /* only if erase_ppa is set, acquire erase semaphore */
 int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
-		       unsigned int sentry, unsigned long *lun_bitmap,
-		       unsigned int valid_secs, struct ppa_addr *erase_ppa)
+		      unsigned int sentry, unsigned long *lun_bitmap,
+		      unsigned int valid_secs, struct ppa_addr *erase_ppa,
+		      int type)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
@@ -141,7 +142,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		meta_buffer = pblk_get_meta(pblk, meta_list, i);
 
 		ret = pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
-					lun_bitmap, meta_buffer, map_secs);
+					 lun_bitmap, meta_buffer, map_secs, type);
 		if (ret)
 			return ret;
 
@@ -150,10 +151,10 @@ int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		/* line can change after page map. We might also be writing the
 		 * last line.
 		 */
-		e_line = pblk_line_get_erase(pblk);
+		e_line = pblk_line_get_next_line(pblk, type);
 		if (!e_line)
 			return pblk_map_rq(pblk, rqd, sentry, lun_bitmap,
-							valid_secs, i + min);
+					   valid_secs, i + min, type);
 
 		spin_lock(&e_line->lock);
 		if (!test_bit(erase_lun, e_line->erase_bitmap)) {
@@ -168,17 +169,17 @@ int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 			/* Avoid evaluating e_line->left_eblks */
 			return pblk_map_rq(pblk, rqd, sentry, lun_bitmap,
-							valid_secs, i + min);
+					   valid_secs, i + min, type);
 		}
 		spin_unlock(&e_line->lock);
 	}
 
-	d_line = pblk_line_get_data(pblk);
+	d_line = pblk_line_get_data_line(pblk, type);
 
 	/* line can change after page map. We might also be writing the
 	 * last line.
 	 */
-	e_line = pblk_line_get_erase(pblk);
+	e_line = pblk_line_get_next_line(pblk, type);
 	if (!e_line)
 		return -ENOSPC;
 
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 865fe310cab4..38bf7b28e73f 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -677,12 +677,12 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
-	struct pblk_line *line, *tline, *data_line = NULL;
+	struct pblk_line *line, *tline, *data_line = NULL, *gc_line = NULL;
 	struct pblk_smeta *smeta;
 	struct pblk_emeta *emeta;
 	struct line_smeta *smeta_buf;
 	int found_lines = 0, recovered_lines = 0, open_lines = 0;
-	int is_next = 0;
+	int is_data_next = 0, is_gc_next = 0;
 	int meta_line;
 	int i, valid_uuid = 0;
 	LIST_HEAD(recov_list);
@@ -838,7 +838,11 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			trace_pblk_line_state(pblk_disk_name(pblk), line->id,
 					line->state);
 
-			data_line = line;
+			if (line->type == PBLK_LINETYPE_DATA)
+				data_line = line;
+			else if (line->type == PBLK_LINETYPE_GC)
+				gc_line = line;
+
 			line->meta_line = meta_line;
 
 			open_lines++;
@@ -852,19 +856,30 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		spin_unlock(&l_mg->free_lock);
 	} else {
 		spin_lock(&l_mg->free_lock);
-		l_mg->data_line = data_line;
-		/* Allocate next line for preparation */
-		l_mg->data_next = pblk_line_get(pblk);
-		if (l_mg->data_next) {
-			l_mg->data_next->seq_nr = l_mg->d_seq_nr++;
-			l_mg->data_next->type = PBLK_LINETYPE_DATA;
-			is_next = 1;
+		if (data_line) {
+			pblk_line_set_data_line(pblk, PBLK_LINETYPE_DATA,
+						data_line);
+			/* Allocate next line for preparation */
+			if (pblk_line_init_next_line(pblk, PBLK_LINETYPE_DATA))
+				is_data_next = 1;
+		}
+		if (gc_line) {
+			pblk_line_set_data_line(pblk, PBLK_LINETYPE_GC,
+						gc_line);
+			/* Allocate next line for preparation */
+			if (pblk_line_init_next_line(pblk, PBLK_LINETYPE_GC))
+				is_gc_next = 1;
 		}
+
 		spin_unlock(&l_mg->free_lock);
 	}
 
-	if (is_next)
-		pblk_line_erase(pblk, l_mg->data_next);
+	if (is_data_next)
+		pblk_line_erase(pblk, pblk_line_get_next_line(pblk,
+							   PBLK_LINETYPE_DATA));
+	if (is_gc_next)
+		pblk_line_erase(pblk, pblk_line_get_next_line(pblk,
+							   PBLK_LINETYPE_GC));
 
 out:
 	if (found_lines != recovered_lines)
@@ -877,7 +892,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 /*
  * Pad current line
  */
-int pblk_recov_pad(struct pblk *pblk)
+int pblk_recov_pad(struct pblk *pblk, int type)
 {
 	struct pblk_line *line;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
@@ -885,7 +900,7 @@ int pblk_recov_pad(struct pblk *pblk)
 	int ret = 0;
 
 	spin_lock(&l_mg->free_lock);
-	line = l_mg->data_line;
+	line = pblk_line_get_data_line(pblk, type);
 	left_msecs = line->left_msecs;
 	spin_unlock(&l_mg->free_lock);
 
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 4e63f9b5954c..1e38adc63800 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -313,10 +313,10 @@ static int pblk_alloc_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
 }
 
 static int pblk_setup_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
-			   struct ppa_addr *erase_ppa)
+			   struct ppa_addr *erase_ppa, int type)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
-	struct pblk_line *e_line = pblk_line_get_erase(pblk);
+	struct pblk_line *e_line = pblk_line_get_next_line(pblk, type);
 	struct pblk_c_ctx *c_ctx = nvm_rq_to_pdu(rqd);
 	unsigned int valid = c_ctx->nr_valid;
 	unsigned int padded = c_ctx->nr_padded;
@@ -337,10 +337,10 @@ static int pblk_setup_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 	if (likely(!e_line || !atomic_read(&e_line->left_eblks)))
 		ret = pblk_map_rq(pblk, rqd, c_ctx->sentry, lun_bitmap,
-							valid, 0);
+				  valid, 0, type);
 	else
 		ret = pblk_map_erase_rq(pblk, rqd, c_ctx->sentry, lun_bitmap,
-							valid, erase_ppa);
+					valid, erase_ppa, type);
 
 	return ret;
 }
@@ -446,12 +446,13 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 
 static inline bool pblk_valid_meta_ppa(struct pblk *pblk,
 				       struct pblk_line *meta_line,
-				       struct nvm_rq *data_rqd)
+				       struct nvm_rq *data_rqd,
+				       int type)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_c_ctx *data_c_ctx = nvm_rq_to_pdu(data_rqd);
-	struct pblk_line *data_line = pblk_line_get_data(pblk);
+	struct pblk_line *data_line = pblk_line_get_data_line(pblk, type);
 	struct ppa_addr ppa, ppa_opt;
 	u64 paddr;
 	int pos_opt;
@@ -481,7 +482,8 @@ static inline bool pblk_valid_meta_ppa(struct pblk *pblk,
 }
 
 static struct pblk_line *pblk_should_submit_meta_io(struct pblk *pblk,
-						    struct nvm_rq *data_rqd)
+						    struct nvm_rq *data_rqd,
+						    int type)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
@@ -499,13 +501,13 @@ static struct pblk_line *pblk_should_submit_meta_io(struct pblk *pblk,
 	}
 	spin_unlock(&l_mg->close_lock);
 
-	if (!pblk_valid_meta_ppa(pblk, meta_line, data_rqd))
+	if (!pblk_valid_meta_ppa(pblk, meta_line, data_rqd, type))
 		return NULL;
 
 	return meta_line;
 }
 
-static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
+static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd, int type)
 {
 	struct ppa_addr erase_ppa;
 	struct pblk_line *meta_line;
@@ -514,13 +516,13 @@ static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
 	pblk_ppa_set_empty(&erase_ppa);
 
 	/* Assign lbas to ppas and populate request structure */
-	err = pblk_setup_w_rq(pblk, rqd, &erase_ppa);
+	err = pblk_setup_w_rq(pblk, rqd, &erase_ppa, type);
 	if (err) {
 		pblk_err(pblk, "could not setup write request: %d\n", err);
 		return NVM_IO_ERR;
 	}
 
-	meta_line = pblk_should_submit_meta_io(pblk, rqd);
+	meta_line = pblk_should_submit_meta_io(pblk, rqd, type);
 
 	/* Submit data write for current data line */
 	err = pblk_submit_io(pblk, rqd);
@@ -532,11 +534,12 @@ static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
 	if (!pblk_ppa_empty(erase_ppa)) {
 		/* Submit erase for next data line */
 		if (pblk_blk_erase_async(pblk, erase_ppa)) {
-			struct pblk_line *e_line = pblk_line_get_erase(pblk);
+			struct pblk_line *e_line;
 			struct nvm_tgt_dev *dev = pblk->dev;
 			struct nvm_geo *geo = &dev->geo;
 			int bit;
 
+			e_line = pblk_line_get_next_line(pblk, type);
 			atomic_inc(&e_line->left_eblks);
 			bit = pblk_ppa_to_pos(geo, erase_ppa);
 			WARN_ON(!test_and_clear_bit(bit, e_line->erase_bitmap));
@@ -574,6 +577,9 @@ static int pblk_submit_write(struct pblk *pblk, int *secs_left)
 	unsigned int secs_to_flush, packed_meta_pgs;
 	unsigned long pos;
 	unsigned int resubmit;
+	int type;
+	struct pblk_w_ctx *w_ctx;
+	struct pblk_rb_entry *entry;
 
 	*secs_left = 0;
 
@@ -633,13 +639,18 @@ static int pblk_submit_write(struct pblk *pblk, int *secs_left)
 	rqd = pblk_alloc_rqd(pblk, PBLK_WRITE);
 	rqd->bio = bio;
 
+	entry = &pblk->rwb.entries[pos];
+	w_ctx = &entry->w_ctx;
+	type = w_ctx->flags & PBLK_IOTYPE_GC ?
+		PBLK_LINETYPE_GC : PBLK_LINETYPE_DATA;
+
 	if (pblk_rb_read_to_bio(&pblk->rwb, rqd, pos, secs_to_sync,
 								secs_avail)) {
 		pblk_err(pblk, "corrupted write bio\n");
 		goto fail_put_bio;
 	}
 
-	if (pblk_submit_io_set(pblk, rqd))
+	if (pblk_submit_io_set(pblk, rqd, type))
 		goto fail_free_bio;
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index e304754aaa3c..93ef5a2bffe6 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -316,6 +316,7 @@ enum {
 	PBLK_LINETYPE_FREE = 0,
 	PBLK_LINETYPE_LOG = 1,
 	PBLK_LINETYPE_DATA = 2,
+	PBLK_LINETYPE_GC = 3,
 
 	/* Line state */
 	PBLK_LINESTATE_NEW = 9,
@@ -526,8 +527,10 @@ struct pblk_line_mgmt {
 
 	struct pblk_line *log_line;	/* Current FTL log line */
 	struct pblk_line *data_line;	/* Current data line */
+	struct pblk_line *gc_line;	/* Current gc line */
 	struct pblk_line *log_next;	/* Next FTL log line */
 	struct pblk_line *data_next;	/* Next data line */
+	struct pblk_line *gc_next;	/* Next gc line */
 
 	struct list_head emeta_list;	/* Lines queued to schedule emeta */
 
@@ -804,14 +807,20 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 			      unsigned int nr_secs, unsigned int len,
 			      int alloc_type, gfp_t gfp_mask);
 struct pblk_line *pblk_line_get(struct pblk *pblk);
-struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
-struct pblk_line *pblk_line_replace_data(struct pblk *pblk);
+struct pblk_line *pblk_line_get_first_data(struct pblk *pblk, int type);
+struct pblk_line *pblk_line_replace_data(struct pblk *pblk, int type);
 void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa);
 void pblk_rq_to_line_put(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line);
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line);
-struct pblk_line *pblk_line_get_data(struct pblk *pblk);
-struct pblk_line *pblk_line_get_erase(struct pblk *pblk);
+struct pblk_line *pblk_line_get_data_line(struct pblk *pblk, int type);
+struct pblk_line *pblk_line_get_next_line(struct pblk *pblk, int type);
+void pblk_line_set_data_line(struct pblk *pblk, int type,
+			     struct pblk_line *line);
+void pblk_line_set_next_line(struct pblk *pblk, int type,
+			     struct pblk_line *line);
+struct pblk_line *pblk_line_init_next_line(struct pblk *pblk, int type);
+struct pblk_line *pblk_line_init_data_line(struct pblk *pblk, int type);
 int pblk_line_erase(struct pblk *pblk, struct pblk_line *line);
 int pblk_line_is_full(struct pblk_line *line);
 void pblk_line_free(struct pblk_line *line);
@@ -875,11 +884,12 @@ int pblk_write_gc_to_cache(struct pblk *pblk, struct pblk_gc_rq *gc_rq);
  * pblk map
  */
 int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
-		       unsigned int sentry, unsigned long *lun_bitmap,
-		       unsigned int valid_secs, struct ppa_addr *erase_ppa);
+		      unsigned int sentry, unsigned long *lun_bitmap,
+		      unsigned int valid_secs, struct ppa_addr *erase_ppa,
+		      int type);
 int pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
-		 unsigned long *lun_bitmap, unsigned int valid_secs,
-		 unsigned int off);
+		unsigned long *lun_bitmap, unsigned int valid_secs,
+		unsigned int off, int type);
 
 /*
  * pblk write thread
@@ -899,7 +909,7 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq);
  * pblk recovery
  */
 struct pblk_line *pblk_recov_l2p(struct pblk *pblk);
-int pblk_recov_pad(struct pblk *pblk);
+int pblk_recov_pad(struct pblk *pblk, int type);
 int pblk_recov_check_emeta(struct pblk *pblk, struct line_emeta *emeta);
 
 /*
-- 
2.17.1

