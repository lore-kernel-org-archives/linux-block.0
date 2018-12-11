Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA57EC5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977762087F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="mjsmKYQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977762087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeLKTRZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42619 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeLKTRY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so14026387lja.9
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nEAHSa0xPjI3FkvepBe5oNWUXl93oawIyxZZzle0YWM=;
        b=mjsmKYQn3cDLb8CfMdMbsl5/9j+5CJrA8IUFkJkRbqq3XVBEoqr6dN5cF+31P7kH8i
         YUL340lRH1jZZn6xjjoUrAQj9u8412mZ5S8zOpvt52mdUlM2Dyew35TBZ0Z+foWXkvXY
         0wJPA7hhgMB7Y2iExViy0W5HVA0nC+aF9jYgAz6l9MgMaxBoZtEFnqKlnirImlNs8etg
         U5Ep1XPEqLGGaD6QOzfSxtABeJ35iMNyIEr4+I1+hieidq7IaEFNBh9koAWDKlt/qNb5
         WzI8CVfOvoEJztWJvjTFszmYWGWBI7CUH3cu6CfiyU1bD+LvR6mNlz6sWGT73YrggD//
         o6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nEAHSa0xPjI3FkvepBe5oNWUXl93oawIyxZZzle0YWM=;
        b=KSPVfmfGV5nU25CMDzr68yKLq0skVCc8aIxnlpylCLdY38hOJYo7aa6jc1gl/3ZHKe
         uvhP+UHClOGo6W0XC151hxdCJvy7j8VCXm4Bt5gM8C7eBnSd9ftimIQKlptUOR9d79vy
         nQBkp6aYLZybJdDMTEqxpE8igPZDXvCtr+biNSU/0B3kwDSQ1s6m949I8NRt+lSfQV/S
         Gpb0JgNX83yjIfjZEf8whoj4I0kacfOMN+CEXOxY83xfg9GyPfv3aiWYM9+cF3h7nDuV
         FWNPuT5Ui9GL9doadIlG+yV/RPUKjcDc4a7pXEgekmyu3WcI26bXip9K626RIGS3Orrg
         hBDg==
X-Gm-Message-State: AA+aEWYjRA6A948ve9XhwzXCxo4dx2o6UDLoAu5AnQ//I3CvplL/E30s
        E14h8vr1TgglTmXlfITHYScE8w==
X-Google-Smtp-Source: AFSGD/XeOc1ImVQapQ1cN+di3z7C28pZrQsyLoVgdt/RKhX0rlsiIUm8rEMGXpFVoL7baM8bunLcKA==
X-Received: by 2002:a2e:9b15:: with SMTP id u21-v6mr10323002lji.29.1544555841239;
        Tue, 11 Dec 2018 11:17:21 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:20 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 17/21] lightnvm: pblk: add helpers for OOB metadata
Date:   Tue, 11 Dec 2018 20:16:23 +0100
Message-Id: <20181211191627.15542-18-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

pblk currently assumes that size of OOB metadata on drive is always
equal to size of pblk_sec_meta struct. This commit add helpers which will
allow to handle different sizes of OOB metadata on drive in the future.

After this patch only OOB metadata equal to 16 bytes is supported.

Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c     |  5 ++--
 drivers/lightnvm/pblk-init.c     |  6 ++++
 drivers/lightnvm/pblk-map.c      | 20 ++++++++-----
 drivers/lightnvm/pblk-read.c     | 48 +++++++++++++++++++++-----------
 drivers/lightnvm/pblk-recovery.c | 16 +++++++----
 drivers/lightnvm/pblk.h          |  6 ++++
 6 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index f1b411e7c7c9..e732b2d12a23 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -796,10 +796,11 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 	rqd.is_seq = 1;
 
 	for (i = 0; i < lm->smeta_sec; i++, paddr++) {
-		struct pblk_sec_meta *meta_list = rqd.meta_list;
+		struct pblk_sec_meta *meta = pblk_get_meta(pblk,
+							   rqd.meta_list, i);
 
 		rqd.ppa_list[i] = addr_to_gen_ppa(pblk, paddr, line->id);
-		meta_list[i].lba = lba_list[paddr] = addr_empty;
+		meta->lba = lba_list[paddr] = addr_empty;
 	}
 
 	ret = pblk_submit_io_sync_sem(pblk, &rqd);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 72ad3e70318c..33361bfb85c3 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -405,6 +405,12 @@ static int pblk_core_init(struct pblk *pblk)
 		queue_max_hw_sectors(dev->q) / (geo->csecs >> SECTOR_SHIFT));
 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
 
+	pblk->oob_meta_size = geo->sos;
+	if (pblk->oob_meta_size != sizeof(struct pblk_sec_meta)) {
+		pblk_err(pblk, "Unsupported metadata size\n");
+		return -EINVAL;
+	}
+
 	pblk->pad_dist = kcalloc(pblk->min_write_pgs - 1, sizeof(atomic64_t),
 								GFP_KERNEL);
 	if (!pblk->pad_dist)
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 5a3c28cce8ab..81e503ec384e 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -22,7 +22,7 @@
 static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 			      struct ppa_addr *ppa_list,
 			      unsigned long *lun_bitmap,
-			      struct pblk_sec_meta *meta_list,
+			      void *meta_list,
 			      unsigned int valid_secs)
 {
 	struct pblk_line *line = pblk_line_get_data(pblk);
@@ -58,6 +58,7 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 	paddr = pblk_alloc_page(pblk, line, nr_secs);
 
 	for (i = 0; i < nr_secs; i++, paddr++) {
+		struct pblk_sec_meta *meta = pblk_get_meta(pblk, meta_list, i);
 		__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
 
 		/* ppa to be sent to the device */
@@ -74,14 +75,15 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 			kref_get(&line->ref);
 			w_ctx = pblk_rb_w_ctx(&pblk->rwb, sentry + i);
 			w_ctx->ppa = ppa_list[i];
-			meta_list[i].lba = cpu_to_le64(w_ctx->lba);
+			meta->lba = cpu_to_le64(w_ctx->lba);
 			lba_list[paddr] = cpu_to_le64(w_ctx->lba);
 			if (lba_list[paddr] != addr_empty)
 				line->nr_valid_lbas++;
 			else
 				atomic64_inc(&pblk->pad_wa);
 		} else {
-			lba_list[paddr] = meta_list[i].lba = addr_empty;
+			lba_list[paddr] = addr_empty;
+			meta->lba = addr_empty;
 			__pblk_map_invalidate(pblk, line, paddr);
 		}
 	}
@@ -94,7 +96,8 @@ int pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 		 unsigned long *lun_bitmap, unsigned int valid_secs,
 		 unsigned int off)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
+	void *meta_buffer;
 	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	unsigned int map_secs;
 	int min = pblk->min_write_pgs;
@@ -103,9 +106,10 @@ int pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 
 	for (i = off; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
+		meta_buffer = pblk_get_meta(pblk, meta_list, i);
 
 		ret = pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs);
+					lun_bitmap, meta_buffer, map_secs);
 		if (ret)
 			return ret;
 	}
@@ -121,7 +125,8 @@ int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
+	void *meta_buffer;
 	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	struct pblk_line *e_line, *d_line;
 	unsigned int map_secs;
@@ -132,9 +137,10 @@ int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 	for (i = 0; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
+		meta_buffer = pblk_get_meta(pblk, meta_list, i);
 
 		ret = pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs);
+					lun_bitmap, meta_buffer, map_secs);
 		if (ret)
 			return ret;
 
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 19917d3c19b3..6becd85ca4c6 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -43,7 +43,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 				 struct bio *bio, sector_t blba,
 				 unsigned long *read_bitmap)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	struct ppa_addr ppas[NVM_MAX_VLBA];
 	int nr_secs = rqd->nr_ppas;
 	bool advanced_bio = false;
@@ -53,12 +53,15 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 	for (i = 0; i < nr_secs; i++) {
 		struct ppa_addr p = ppas[i];
+		struct pblk_sec_meta *meta = pblk_get_meta(pblk, meta_list, i);
 		sector_t lba = blba + i;
 
 retry:
 		if (pblk_ppa_empty(p)) {
+			__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
+
 			WARN_ON(test_and_set_bit(i, read_bitmap));
-			meta_list[i].lba = cpu_to_le64(ADDR_EMPTY);
+			meta->lba = addr_empty;
 
 			if (unlikely(!advanced_bio)) {
 				bio_advance(bio, (i) * PBLK_EXPOSED_PAGE_SIZE);
@@ -78,7 +81,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 				goto retry;
 			}
 			WARN_ON(test_and_set_bit(i, read_bitmap));
-			meta_list[i].lba = cpu_to_le64(lba);
+			meta->lba = cpu_to_le64(lba);
 			advanced_bio = true;
 #ifdef CONFIG_NVM_PBLK_DEBUG
 			atomic_long_inc(&pblk->cache_reads);
@@ -105,12 +108,13 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
 				sector_t blba)
 {
-	struct pblk_sec_meta *meta_lba_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	int nr_lbas = rqd->nr_ppas;
 	int i;
 
 	for (i = 0; i < nr_lbas; i++) {
-		u64 lba = le64_to_cpu(meta_lba_list[i].lba);
+		struct pblk_sec_meta *meta = pblk_get_meta(pblk, meta_list, i);
+		u64 lba = le64_to_cpu(meta->lba);
 
 		if (lba == ADDR_EMPTY)
 			continue;
@@ -134,17 +138,19 @@ static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
 static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 				 u64 *lba_list, int nr_lbas)
 {
-	struct pblk_sec_meta *meta_lba_list = rqd->meta_list;
+	void *meta_lba_list = rqd->meta_list;
 	int i, j;
 
 	for (i = 0, j = 0; i < nr_lbas; i++) {
+		struct pblk_sec_meta *meta = pblk_get_meta(pblk,
+							   meta_lba_list, j);
 		u64 lba = lba_list[i];
 		u64 meta_lba;
 
 		if (lba == ADDR_EMPTY)
 			continue;
 
-		meta_lba = le64_to_cpu(meta_lba_list[j].lba);
+		meta_lba = le64_to_cpu(meta->lba);
 
 		if (lba != meta_lba) {
 #ifdef CONFIG_NVM_PBLK_DEBUG
@@ -216,10 +222,11 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 	struct pblk *pblk = rqd->private;
 	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
 	struct pblk_pr_ctx *pr_ctx = r_ctx->private;
+	struct pblk_sec_meta *meta;
 	struct bio *new_bio = rqd->bio;
 	struct bio *bio = pr_ctx->orig_bio;
 	struct bio_vec src_bv, dst_bv;
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	int bio_init_idx = pr_ctx->bio_init_idx;
 	unsigned long *read_bitmap = pr_ctx->bitmap;
 	int nr_secs = pr_ctx->orig_nr_secs;
@@ -237,8 +244,9 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 	}
 
 	for (i = 0; i < nr_secs; i++) {
-		pr_ctx->lba_list_media[i] = meta_list[i].lba;
-		meta_list[i].lba = pr_ctx->lba_list_mem[i];
+		meta = pblk_get_meta(pblk, meta_list, i);
+		pr_ctx->lba_list_media[i] = le64_to_cpu(meta->lba);
+		meta->lba = cpu_to_le64(pr_ctx->lba_list_mem[i]);
 	}
 
 	/* Fill the holes in the original bio */
@@ -250,7 +258,8 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
 		line = pblk_ppa_to_line(pblk, rqd->ppa_list[i]);
 		kref_put(&line->ref, pblk_line_put);
 
-		meta_list[hole].lba = pr_ctx->lba_list_media[i];
+		meta = pblk_get_meta(pblk, meta_list, hole);
+		meta->lba = cpu_to_le64(pr_ctx->lba_list_media[i]);
 
 		src_bv = new_bio->bi_io_vec[i++];
 		dst_bv = bio->bi_io_vec[bio_init_idx + hole];
@@ -286,7 +295,7 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 			    unsigned long *read_bitmap,
 			    int nr_holes)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	void *meta_list = rqd->meta_list;
 	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
 	struct pblk_pr_ctx *pr_ctx;
 	struct bio *new_bio, *bio = r_ctx->private;
@@ -307,8 +316,11 @@ static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 	if (!pr_ctx)
 		goto fail_free_pages;
 
-	for (i = 0; i < nr_secs; i++)
-		pr_ctx->lba_list_mem[i] = meta_list[i].lba;
+	for (i = 0; i < nr_secs; i++) {
+		struct pblk_sec_meta *meta = pblk_get_meta(pblk, meta_list, i);
+
+		pr_ctx->lba_list_mem[i] = le64_to_cpu(meta->lba);
+	}
 
 	new_bio->bi_iter.bi_sector = 0; /* internal bio */
 	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
@@ -373,7 +385,7 @@ static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 			 sector_t lba, unsigned long *read_bitmap)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	struct pblk_sec_meta *meta = pblk_get_meta(pblk, rqd->meta_list, 0);
 	struct ppa_addr ppa;
 
 	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
@@ -384,8 +396,10 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 
 retry:
 	if (pblk_ppa_empty(ppa)) {
+		__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
+
 		WARN_ON(test_and_set_bit(0, read_bitmap));
-		meta_list[0].lba = cpu_to_le64(ADDR_EMPTY);
+		meta->lba = addr_empty;
 		return;
 	}
 
@@ -399,7 +413,7 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 		}
 
 		WARN_ON(test_and_set_bit(0, read_bitmap));
-		meta_list[0].lba = cpu_to_le64(lba);
+		meta->lba = cpu_to_le64(lba);
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 		atomic_long_inc(&pblk->cache_reads);
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 4c726506a831..e4dd634ba05f 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -127,7 +127,7 @@ static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
 
 struct pblk_recov_alloc {
 	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct nvm_rq *rqd;
 	void *data;
 	dma_addr_t dma_ppa_list;
@@ -161,7 +161,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct pblk_pad_rq *pad_rq;
 	struct nvm_rq *rqd;
 	struct bio *bio;
@@ -240,12 +240,15 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 
 		for (j = 0; j < pblk->min_write_pgs; j++, i++, w_ptr++) {
 			struct ppa_addr dev_ppa;
+			struct pblk_sec_meta *meta;
 			__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
 
 			dev_ppa = addr_to_gen_ppa(pblk, w_ptr, line->id);
 
 			pblk_map_invalidate(pblk, dev_ppa);
-			lba_list[w_ptr] = meta_list[i].lba = addr_empty;
+			lba_list[w_ptr] = addr_empty;
+			meta = pblk_get_meta(pblk, meta_list, i);
+			meta->lba = addr_empty;
 			rqd->ppa_list[i] = dev_ppa;
 		}
 	}
@@ -340,7 +343,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct nvm_rq *rqd;
 	struct bio *bio;
 	void *data;
@@ -438,7 +441,8 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	}
 
 	for (i = 0; i < rqd->nr_ppas; i++) {
-		u64 lba = le64_to_cpu(meta_list[i].lba);
+		struct pblk_sec_meta *meta = pblk_get_meta(pblk, meta_list, i);
+		u64 lba = le64_to_cpu(meta->lba);
 
 		lba_list[paddr++] = cpu_to_le64(lba);
 
@@ -467,7 +471,7 @@ static int pblk_recov_l2p_from_oob(struct pblk *pblk, struct pblk_line *line)
 	struct nvm_geo *geo = &dev->geo;
 	struct nvm_rq *rqd;
 	struct ppa_addr *ppa_list;
-	struct pblk_sec_meta *meta_list;
+	void *meta_list;
 	struct pblk_recov_alloc p;
 	void *data;
 	dma_addr_t dma_ppa_list, dma_meta_list;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 0e9d3960ac4c..80f356688803 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -634,6 +634,7 @@ struct pblk {
 
 	int min_write_pgs; /* Minimum amount of pages required by controller */
 	int max_write_pgs; /* Maximum amount of pages supported by controller */
+	int oob_meta_size; /* Size of OOB sector metadata */
 
 	sector_t capacity; /* Device capacity when bad blocks are subtracted */
 
@@ -1380,6 +1381,11 @@ static inline unsigned int pblk_get_min_chks(struct pblk *pblk)
 	 */
 
 	return DIV_ROUND_UP(100, pblk->op) * lm->blk_per_line;
+}
 
+static inline struct pblk_sec_meta *pblk_get_meta(struct pblk *pblk,
+							 void *meta, int index)
+{
+	return meta + pblk->oob_meta_size * index;
 }
 #endif /* PBLK_H_ */
-- 
2.17.1

