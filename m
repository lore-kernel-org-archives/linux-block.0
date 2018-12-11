Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00F1C5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D5F2087F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="TtYaJbeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D5F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeLKTRK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:10 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:36745 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeLKTRJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:09 -0500
Received: by mail-lf1-f54.google.com with SMTP id a16so11644968lfg.3
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLaL/hWoaT1VK9QbVXR5Yp5y+BqCoVVv/yiotLcHXJo=;
        b=TtYaJbeDYbjn9npV0FPjFKOJEfC4Q6Yzy/2cH0iHk2T52RzYg9eLYvSRC+SMJrV2j3
         vXSfUl0GMCde9D9Dgj7Xk+pXJrrOWy4cvS8htv2JzaytQjgYLP34AeWCE1Td2FH8hz7T
         td0ihvY7Jq6funxv5LBVo2Sb0qahQgXOK9zE3RpBOe2YliBCNmvJC569mBl89KdPbce7
         mT/jKLxfaiRNpSvVwwYzpOWVOppPhXq0KaFH6peCB8qTS1uZSo+8wARbhHdSziEguoLC
         eKwkZBkOO0cpZE2rdmeUaUSNtI/vrOdXZyb/JaOOKLe7JRP6DFaYvQoIGev1E5k0/wVI
         ScwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLaL/hWoaT1VK9QbVXR5Yp5y+BqCoVVv/yiotLcHXJo=;
        b=BzB5o/ALziBI4KYzAZcnbpLMmEOnvAZ+W1UtNYPIVw2Can0pPV6vPP7TYjQFcVkBNm
         dTnLbUornob2OIswuNrW7pGXxdIe4lXO1ZP0uKgLwI3Q4LTQ6eYzuHoZoiMi1pOjKgNz
         BIuX/ggdgabX40YMu2V4JJXDrPWi7RP/ox7n3GmiQoSuBl+A5gbK1+oO0IVW4aRGNsjs
         SMO3Vfzn4H6kS8jtRj77Yxl7J5Plr2xhcKG1IYYguZY+oI1u95qqN2E+Yl1eCjO7C5M3
         nmQ1aqbxHXcaW69nHndRuZDOD0oVBk2WG4ALJeH0pJkkydT912QBaZWw9Z1hD/VJAX+n
         bNsw==
X-Gm-Message-State: AA+aEWYJel5AWJtw41EAiqbYXI8QA2XSpcCUrDQKjdzoc5yVk15kc4ik
        qoi/LFqSNrBEryVZtGY47+vZYw==
X-Google-Smtp-Source: AFSGD/Xo4uOSYb9y/R8BDdPdaOfGXHmBpdOWpDUX0RuRvBlyUOf7ErLbIc0/g6J4SOHz5qZo05hTDQ==
X-Received: by 2002:a19:280f:: with SMTP id o15mr9838068lfo.0.1544555826691;
        Tue, 11 Dec 2018 11:17:06 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:05 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 06/21] lightnvm: pblk: stop writes gracefully when running out of lines
Date:   Tue, 11 Dec 2018 20:16:12 +0100
Message-Id: <20181211191627.15542-7-mb@lightnvm.io>
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

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

If mapping fails (i.e. when running out of lines), handle the error
and stop writing.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-map.c   | 47 +++++++++++++++++++++--------------
 drivers/lightnvm/pblk-write.c | 30 ++++++++++++++--------
 drivers/lightnvm/pblk.h       |  4 +--
 3 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 6dcbd44e3acb..5a3c28cce8ab 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -33,6 +33,9 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 	int nr_secs = pblk->min_write_pgs;
 	int i;
 
+	if (!line)
+		return -ENOSPC;
+
 	if (pblk_line_is_full(line)) {
 		struct pblk_line *prev_line = line;
 
@@ -42,8 +45,11 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 		line = pblk_line_replace_data(pblk);
 		pblk_line_close_meta(pblk, prev_line);
 
-		if (!line)
-			return -EINTR;
+		if (!line) {
+			pblk_pipeline_stop(pblk);
+			return -ENOSPC;
+		}
+
 	}
 
 	emeta = line->emeta;
@@ -84,7 +90,7 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 	return 0;
 }
 
-void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
+int pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 		 unsigned long *lun_bitmap, unsigned int valid_secs,
 		 unsigned int off)
 {
@@ -93,20 +99,22 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 	unsigned int map_secs;
 	int min = pblk->min_write_pgs;
 	int i;
+	int ret;
 
 	for (i = off; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
-		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs)) {
-			bio_put(rqd->bio);
-			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
-			pblk_pipeline_stop(pblk);
-		}
+
+		ret = pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
+					lun_bitmap, &meta_list[i], map_secs);
+		if (ret)
+			return ret;
 	}
+
+	return 0;
 }
 
 /* only if erase_ppa is set, acquire erase semaphore */
-void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
+int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		       unsigned int sentry, unsigned long *lun_bitmap,
 		       unsigned int valid_secs, struct ppa_addr *erase_ppa)
 {
@@ -119,15 +127,16 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	unsigned int map_secs;
 	int min = pblk->min_write_pgs;
 	int i, erase_lun;
+	int ret;
+
 
 	for (i = 0; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
-		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs)) {
-			bio_put(rqd->bio);
-			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
-			pblk_pipeline_stop(pblk);
-		}
+
+		ret = pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
+					lun_bitmap, &meta_list[i], map_secs);
+		if (ret)
+			return ret;
 
 		erase_lun = pblk_ppa_to_pos(geo, ppa_list[i]);
 
@@ -163,7 +172,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	 */
 	e_line = pblk_line_get_erase(pblk);
 	if (!e_line)
-		return;
+		return -ENOSPC;
 
 	/* Erase blocks that are bad in this line but might not be in next */
 	if (unlikely(pblk_ppa_empty(*erase_ppa)) &&
@@ -174,7 +183,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		bit = find_next_bit(d_line->blk_bitmap,
 						lm->blk_per_line, bit + 1);
 		if (bit >= lm->blk_per_line)
-			return;
+			return 0;
 
 		spin_lock(&e_line->lock);
 		if (test_bit(bit, e_line->erase_bitmap)) {
@@ -188,4 +197,6 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		*erase_ppa = pblk->luns[bit].bppa; /* set ch and lun */
 		erase_ppa->a.blk = e_line->id;
 	}
+
+	return 0;
 }
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 750f04b8a227..2bf78f81862d 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -334,12 +334,13 @@ static int pblk_setup_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	}
 
 	if (likely(!e_line || !atomic_read(&e_line->left_eblks)))
-		pblk_map_rq(pblk, rqd, c_ctx->sentry, lun_bitmap, valid, 0);
+		ret = pblk_map_rq(pblk, rqd, c_ctx->sentry, lun_bitmap,
+							valid, 0);
 	else
-		pblk_map_erase_rq(pblk, rqd, c_ctx->sentry, lun_bitmap,
+		ret = pblk_map_erase_rq(pblk, rqd, c_ctx->sentry, lun_bitmap,
 							valid, erase_ppa);
 
-	return 0;
+	return ret;
 }
 
 static int pblk_calc_secs_to_sync(struct pblk *pblk, unsigned int secs_avail,
@@ -563,7 +564,7 @@ static void pblk_free_write_rqd(struct pblk *pblk, struct nvm_rq *rqd)
 							c_ctx->nr_padded);
 }
 
-static int pblk_submit_write(struct pblk *pblk)
+static int pblk_submit_write(struct pblk *pblk, int *secs_left)
 {
 	struct bio *bio;
 	struct nvm_rq *rqd;
@@ -572,6 +573,8 @@ static int pblk_submit_write(struct pblk *pblk)
 	unsigned long pos;
 	unsigned int resubmit;
 
+	*secs_left = 0;
+
 	spin_lock(&pblk->resubmit_lock);
 	resubmit = !list_empty(&pblk->resubmit_list);
 	spin_unlock(&pblk->resubmit_lock);
@@ -601,17 +604,17 @@ static int pblk_submit_write(struct pblk *pblk)
 		 */
 		secs_avail = pblk_rb_read_count(&pblk->rwb);
 		if (!secs_avail)
-			return 1;
+			return 0;
 
 		secs_to_flush = pblk_rb_flush_point_count(&pblk->rwb);
 		if (!secs_to_flush && secs_avail < pblk->min_write_pgs)
-			return 1;
+			return 0;
 
 		secs_to_sync = pblk_calc_secs_to_sync(pblk, secs_avail,
 					secs_to_flush);
 		if (secs_to_sync > pblk->max_write_pgs) {
 			pblk_err(pblk, "bad buffer sync calculation\n");
-			return 1;
+			return 0;
 		}
 
 		secs_to_com = (secs_to_sync > secs_avail) ?
@@ -640,6 +643,7 @@ static int pblk_submit_write(struct pblk *pblk)
 	atomic_long_add(secs_to_sync, &pblk->sub_writes);
 #endif
 
+	*secs_left = 1;
 	return 0;
 
 fail_free_bio:
@@ -648,16 +652,22 @@ static int pblk_submit_write(struct pblk *pblk)
 	bio_put(bio);
 	pblk_free_rqd(pblk, rqd, PBLK_WRITE);
 
-	return 1;
+	return -EINTR;
 }
 
 int pblk_write_ts(void *data)
 {
 	struct pblk *pblk = data;
+	int secs_left;
+	int write_failure = 0;
 
 	while (!kthread_should_stop()) {
-		if (!pblk_submit_write(pblk))
-			continue;
+		if (!write_failure) {
+			write_failure = pblk_submit_write(pblk, &secs_left);
+
+			if (secs_left)
+				continue;
+		}
 		set_current_state(TASK_INTERRUPTIBLE);
 		io_schedule();
 	}
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 02bb2e98f8a9..f415aae600c8 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -871,10 +871,10 @@ int pblk_write_gc_to_cache(struct pblk *pblk, struct pblk_gc_rq *gc_rq);
 /*
  * pblk map
  */
-void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
+int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 		       unsigned int sentry, unsigned long *lun_bitmap,
 		       unsigned int valid_secs, struct ppa_addr *erase_ppa);
-void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
+int pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 		 unsigned long *lun_bitmap, unsigned int valid_secs,
 		 unsigned int off);
 
-- 
2.17.1

