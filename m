Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116AFC43219
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9EE2084B
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="M8V5zNal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfEDSiu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:38:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41161 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfEDSit (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so7841697lja.8
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+fz1WBqtK2kshIyR2Qy2A/qLzLIFsJppqbJhNx1/P8=;
        b=M8V5zNaljhWtxtuBXTuGFbRujWTkkl+eL3w+btFLXlpdgIjs+q26bnsdOMjfToBVCg
         d4yi+E+NMqveeS6UtgqtBcJ3Zfcr1JnZOmsF0H32CptT7vES/32m0D6cPBKz6y1xOcvt
         3ULkose2yX3f69iZJG6Lh1MIbyvnNR21LgwqqkH5PHtsbgBNY2K3k7rJ42mQ14JfBgjF
         iOfW47dPj68OFnjVwwQxwJ++hjOfA0wZqy/J77EC1wUl5bqEEeCdx8Rci6jqTmf2CZUY
         9ZesZmhYYKSioxLPseE6HI2hTVP7RaS4SfHzJxzEjwZR+hYUGvnJwMWwcKGkg/GW0NeH
         4t/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+fz1WBqtK2kshIyR2Qy2A/qLzLIFsJppqbJhNx1/P8=;
        b=YexuiOlG1nmuTvRxkmy49WRgNntN9dOrRpmxqpTBLR3Ks0w3N8aUpt7yp7jwlMhirr
         oAkWAcNfzbM8g7tB1VKFmT94nA6QyEu/JzEX2yPjn0nHZXr6CYfUPsm/yunrJ+SjAoE0
         omeMqoMYqlYhDRdme2ROQNlT3AJRqCeDkjX6dwxMEnyo/JzSgjESdqZRZ6AactwwPk3D
         19C0ZTTktTOghUrPU+C03b+VGfPe2Pnk9UrfvTCKXZecpj/ThvYhSjuPuWnuY37nvawC
         dxt90niwPqEwkVS/A4ZMndGIOJ4p0IoEqwc2A2aQZqPZz8j90lQH5igSCsJFeioE+18I
         OeXQ==
X-Gm-Message-State: APjAAAV72fVY+GjBDWTsz7DTm2tOtWZpFDJF69oiHQou/tjl5jQWudud
        bfQNrbYRi2H0e4amBgX2O2HuLA==
X-Google-Smtp-Source: APXvYqz6+scUOvddMrxW01qgQr7UjSKqJt2M+QK1LDZpjb4fXjjPrktddlJsPVaWD/KO+raAHg0cYw==
X-Received: by 2002:a2e:86c5:: with SMTP id n5mr9000107ljj.184.1556995127544;
        Sat, 04 May 2019 11:38:47 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:47 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 21/26] lightnvm: pblk: IO path reorganization
Date:   Sat,  4 May 2019 20:38:06 +0200
Message-Id: <20190504183811.18725-22-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

This patch is made in order to prepare read path for new approach to
partial read handling, which is simpler in compare with previous one.

The most important change is to move the handling of completed and
failed bio from the pblk_make_rq() to particular read and write
functions. This is needed, since after partial read path changes,
sometimes completed/failed bio will be different from original one, so
we cannot do this any longer in pblk_make_rq().

Other changes are small read path refactor in order to reduce the size
of the following patch with partial read changes.

Generally the goal of this patch is not to change the functionality,
but just to prepare the code for the following changes.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-cache.c |  8 +++-
 drivers/lightnvm/pblk-init.c  | 14 +-----
 drivers/lightnvm/pblk-read.c  | 83 ++++++++++++++++-------------------
 drivers/lightnvm/pblk.h       |  4 +-
 4 files changed, 48 insertions(+), 61 deletions(-)

diff --git a/drivers/lightnvm/pblk-cache.c b/drivers/lightnvm/pblk-cache.c
index c9fa26f95659..5c1034c22197 100644
--- a/drivers/lightnvm/pblk-cache.c
+++ b/drivers/lightnvm/pblk-cache.c
@@ -18,7 +18,8 @@
 
 #include "pblk.h"
 
-int pblk_write_to_cache(struct pblk *pblk, struct bio *bio, unsigned long flags)
+void pblk_write_to_cache(struct pblk *pblk, struct bio *bio,
+				unsigned long flags)
 {
 	struct request_queue *q = pblk->dev->q;
 	struct pblk_w_ctx w_ctx;
@@ -43,6 +44,7 @@ int pblk_write_to_cache(struct pblk *pblk, struct bio *bio, unsigned long flags)
 		goto retry;
 	case NVM_IO_ERR:
 		pblk_pipeline_stop(pblk);
+		bio_io_error(bio);
 		goto out;
 	}
 
@@ -79,7 +81,9 @@ int pblk_write_to_cache(struct pblk *pblk, struct bio *bio, unsigned long flags)
 out:
 	generic_end_io_acct(q, REQ_OP_WRITE, &pblk->disk->part0, start_time);
 	pblk_write_should_kick(pblk);
-	return ret;
+
+	if (ret == NVM_IO_DONE)
+		bio_endio(bio);
 }
 
 /*
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 1e227a08e54a..b351c7f002de 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -50,7 +50,6 @@ struct bio_set pblk_bio_set;
 static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
 {
 	struct pblk *pblk = q->queuedata;
-	int ret;
 
 	if (bio_op(bio) == REQ_OP_DISCARD) {
 		pblk_discard(pblk, bio);
@@ -65,7 +64,7 @@ static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
 	 */
 	if (bio_data_dir(bio) == READ) {
 		blk_queue_split(q, &bio);
-		ret = pblk_submit_read(pblk, bio);
+		pblk_submit_read(pblk, bio);
 	} else {
 		/* Prevent deadlock in the case of a modest LUN configuration
 		 * and large user I/Os. Unless stalled, the rate limiter
@@ -74,16 +73,7 @@ static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
 		if (pblk_get_secs(bio) > pblk_rl_max_io(&pblk->rl))
 			blk_queue_split(q, &bio);
 
-		ret = pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
-	}
-
-	switch (ret) {
-	case NVM_IO_ERR:
-		bio_io_error(bio);
-		break;
-	case NVM_IO_DONE:
-		bio_endio(bio);
-		break;
+		pblk_write_to_cache(pblk, bio, PBLK_IOTYPE_USER);
 	}
 
 	return BLK_QC_T_NONE;
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 27f8a76d8bd8..f5f155d540e2 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -179,7 +179,8 @@ static void pblk_end_user_read(struct bio *bio, int error)
 {
 	if (error && error != NVM_RSP_WARN_HIGHECC)
 		bio_io_error(bio);
-	bio_endio(bio);
+	else
+		bio_endio(bio);
 }
 
 static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
@@ -389,7 +390,6 @@ static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
 
 	/* Free allocated pages in new bio */
 	pblk_bio_free_pages(pblk, rqd->bio, 0, rqd->bio->bi_vcnt);
-	__pblk_end_io_read(pblk, rqd, false);
 	return NVM_IO_ERR;
 }
 
@@ -434,7 +434,7 @@ static void pblk_read_rq(struct pblk *pblk, struct nvm_rq *rqd, struct bio *bio,
 	}
 }
 
-int pblk_submit_read(struct pblk *pblk, struct bio *bio)
+void pblk_submit_read(struct pblk *pblk, struct bio *bio)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct request_queue *q = dev->q;
@@ -442,9 +442,9 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	unsigned int nr_secs = pblk_get_secs(bio);
 	struct pblk_g_ctx *r_ctx;
 	struct nvm_rq *rqd;
+	struct bio *int_bio;
 	unsigned int bio_init_idx;
 	DECLARE_BITMAP(read_bitmap, NVM_MAX_VLBA);
-	int ret = NVM_IO_ERR;
 
 	generic_start_io_acct(q, REQ_OP_READ, bio_sectors(bio),
 			      &pblk->disk->part0);
@@ -455,74 +455,67 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 
 	rqd->opcode = NVM_OP_PREAD;
 	rqd->nr_ppas = nr_secs;
-	rqd->bio = NULL; /* cloned bio if needed */
 	rqd->private = pblk;
 	rqd->end_io = pblk_end_io_read;
 
 	r_ctx = nvm_rq_to_pdu(rqd);
 	r_ctx->start_time = jiffies;
 	r_ctx->lba = blba;
-	r_ctx->private = bio; /* original bio */
 
 	/* Save the index for this bio's start. This is needed in case
 	 * we need to fill a partial read.
 	 */
 	bio_init_idx = pblk_get_bi_idx(bio);
 
-	if (pblk_alloc_rqd_meta(pblk, rqd))
-		goto fail_rqd_free;
+	if (pblk_alloc_rqd_meta(pblk, rqd)) {
+		bio_io_error(bio);
+		pblk_free_rqd(pblk, rqd, PBLK_READ);
+		return;
+	}
+
+	/* Clone read bio to deal internally with:
+	 * -read errors when reading from drive
+	 * -bio_advance() calls during l2p lookup and cache reads
+	 */
+	int_bio = bio_clone_fast(bio, GFP_KERNEL, &pblk_bio_set);
 
 	if (nr_secs > 1)
 		pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap);
 	else
 		pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
 
+	r_ctx->private = bio; /* original bio */
+	rqd->bio = int_bio; /* internal bio */
+
 	if (bitmap_full(read_bitmap, nr_secs)) {
+		pblk_end_user_read(bio, 0);
 		atomic_inc(&pblk->inflight_io);
 		__pblk_end_io_read(pblk, rqd, false);
-		return NVM_IO_DONE;
+		return;
 	}
 
-	/* All sectors are to be read from the device */
-	if (bitmap_empty(read_bitmap, rqd->nr_ppas)) {
-		struct bio *int_bio = NULL;
-
-		/* Clone read bio to deal with read errors internally */
-		int_bio = bio_clone_fast(bio, GFP_KERNEL, &pblk_bio_set);
-		if (!int_bio) {
-			pblk_err(pblk, "could not clone read bio\n");
-			goto fail_end_io;
-		}
-
-		rqd->bio = int_bio;
-
-		if (pblk_submit_io(pblk, rqd)) {
+	if (!bitmap_empty(read_bitmap, rqd->nr_ppas)) {
+		/* The read bio request could be partially filled by the write
+		 * buffer, but there are some holes that need to be read from
+		 * the drive.
+		 */
+		bio_put(int_bio);
+		rqd->bio = NULL;
+		if (pblk_partial_read_bio(pblk, rqd, bio_init_idx, read_bitmap,
+					    nr_secs)) {
 			pblk_err(pblk, "read IO submission failed\n");
-			ret = NVM_IO_ERR;
-			goto fail_end_io;
+			bio_io_error(bio);
+			__pblk_end_io_read(pblk, rqd, false);
 		}
-
-		return NVM_IO_OK;
+		return;
 	}
 
-	/* The read bio request could be partially filled by the write buffer,
-	 * but there are some holes that need to be read from the drive.
-	 */
-	ret = pblk_partial_read_bio(pblk, rqd, bio_init_idx, read_bitmap,
-				    nr_secs);
-	if (ret)
-		goto fail_meta_free;
-
-	return NVM_IO_OK;
-
-fail_meta_free:
-	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
-fail_rqd_free:
-	pblk_free_rqd(pblk, rqd, PBLK_READ);
-	return ret;
-fail_end_io:
-	__pblk_end_io_read(pblk, rqd, false);
-	return ret;
+	/* All sectors are to be read from the device */
+	if (pblk_submit_io(pblk, rqd)) {
+		pblk_err(pblk, "read IO submission failed\n");
+		bio_io_error(bio);
+		__pblk_end_io_read(pblk, rqd, false);
+	}
 }
 
 static int read_ppalist_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index e304754aaa3c..17ced12db7dd 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -867,7 +867,7 @@ void pblk_get_packed_meta(struct pblk *pblk, struct nvm_rq *rqd);
 /*
  * pblk user I/O write path
  */
-int pblk_write_to_cache(struct pblk *pblk, struct bio *bio,
+void pblk_write_to_cache(struct pblk *pblk, struct bio *bio,
 			unsigned long flags);
 int pblk_write_gc_to_cache(struct pblk *pblk, struct pblk_gc_rq *gc_rq);
 
@@ -893,7 +893,7 @@ void pblk_write_kick(struct pblk *pblk);
  * pblk read path
  */
 extern struct bio_set pblk_bio_set;
-int pblk_submit_read(struct pblk *pblk, struct bio *bio);
+void pblk_submit_read(struct pblk *pblk, struct bio *bio);
 int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq);
 /*
  * pblk recovery
-- 
2.19.1

