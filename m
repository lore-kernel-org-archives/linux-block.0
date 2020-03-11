Return-Path: <SRS0=mBf9=44=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D9BC10F25
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 07:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316F02146E
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 07:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgCKHon (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:44:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:49156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHon (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 03:44:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 94553AE59;
        Wed, 11 Mar 2020 07:44:40 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] lightnvm: pblk: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:44:39 +0100
Message-Id: <20200311074439.8191-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/lightnvm/pblk-sysfs.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 7d8958df9472..6387302b03f2 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -37,7 +37,7 @@ static ssize_t pblk_sysfs_luns_show(struct pblk *pblk, char *page)
 			active = 0;
 			up(&rlun->wr_sem);
 		}
-		sz += snprintf(page + sz, PAGE_SIZE - sz,
+		sz += scnprintf(page + sz, PAGE_SIZE - sz,
 				"pblk: pos:%d, ch:%d, lun:%d - %d\n",
 					i,
 					rlun->bppa.a.ch,
@@ -120,7 +120,7 @@ static ssize_t pblk_sysfs_ppaf(struct pblk *pblk, char *page)
 		struct nvm_addrf_12 *ppaf = (struct nvm_addrf_12 *)&pblk->addrf;
 		struct nvm_addrf_12 *gppaf = (struct nvm_addrf_12 *)&geo->addrf;
 
-		sz = snprintf(page, PAGE_SIZE,
+		sz = scnprintf(page, PAGE_SIZE,
 			"g:(b:%d)blk:%d/%d,pg:%d/%d,lun:%d/%d,ch:%d/%d,pl:%d/%d,sec:%d/%d\n",
 			pblk->addrf_len,
 			ppaf->blk_offset, ppaf->blk_len,
@@ -130,7 +130,7 @@ static ssize_t pblk_sysfs_ppaf(struct pblk *pblk, char *page)
 			ppaf->pln_offset, ppaf->pln_len,
 			ppaf->sec_offset, ppaf->sec_len);
 
-		sz += snprintf(page + sz, PAGE_SIZE - sz,
+		sz += scnprintf(page + sz, PAGE_SIZE - sz,
 			"d:blk:%d/%d,pg:%d/%d,lun:%d/%d,ch:%d/%d,pl:%d/%d,sec:%d/%d\n",
 			gppaf->blk_offset, gppaf->blk_len,
 			gppaf->pg_offset, gppaf->pg_len,
@@ -142,7 +142,7 @@ static ssize_t pblk_sysfs_ppaf(struct pblk *pblk, char *page)
 		struct nvm_addrf *ppaf = &pblk->addrf;
 		struct nvm_addrf *gppaf = &geo->addrf;
 
-		sz = snprintf(page, PAGE_SIZE,
+		sz = scnprintf(page, PAGE_SIZE,
 			"pblk:(s:%d)ch:%d/%d,lun:%d/%d,chk:%d/%d/sec:%d/%d\n",
 			pblk->addrf_len,
 			ppaf->ch_offset, ppaf->ch_len,
@@ -150,7 +150,7 @@ static ssize_t pblk_sysfs_ppaf(struct pblk *pblk, char *page)
 			ppaf->chk_offset, ppaf->chk_len,
 			ppaf->sec_offset, ppaf->sec_len);
 
-		sz += snprintf(page + sz, PAGE_SIZE - sz,
+		sz += scnprintf(page + sz, PAGE_SIZE - sz,
 			"device:ch:%d/%d,lun:%d/%d,chk:%d/%d,sec:%d/%d\n",
 			gppaf->ch_offset, gppaf->ch_len,
 			gppaf->lun_offset, gppaf->lun_len,
@@ -278,11 +278,11 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
 		pblk_err(pblk, "corrupted free line list:%d/%d\n",
 						nr_free_lines, free_line_cnt);
 
-	sz = snprintf(page, PAGE_SIZE - sz,
+	sz = scnprintf(page, PAGE_SIZE - sz,
 		"line: nluns:%d, nblks:%d, nsecs:%d\n",
 		geo->all_luns, lm->blk_per_line, lm->sec_per_line);
 
-	sz += snprintf(page + sz, PAGE_SIZE - sz,
+	sz += scnprintf(page + sz, PAGE_SIZE - sz,
 		"lines:d:%d,l:%d-f:%d,m:%d/%d,c:%d,b:%d,co:%d(d:%d,l:%d)t:%d\n",
 					cur_data, cur_log,
 					nr_free_lines,
@@ -292,12 +292,12 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
 					d_line_cnt, l_line_cnt,
 					l_mg->nr_lines);
 
-	sz += snprintf(page + sz, PAGE_SIZE - sz,
+	sz += scnprintf(page + sz, PAGE_SIZE - sz,
 		"GC: full:%d, high:%d, mid:%d, low:%d, empty:%d, werr: %d, queue:%d\n",
 			gc_full, gc_high, gc_mid, gc_low, gc_empty, gc_werr,
 			atomic_read(&pblk->gc.read_inflight_gc));
 
-	sz += snprintf(page + sz, PAGE_SIZE - sz,
+	sz += scnprintf(page + sz, PAGE_SIZE - sz,
 		"data (%d) cur:%d, left:%d, vsc:%d, s:%d, map:%d/%d (%d)\n",
 			cur_data, cur_sec, msecs, vsc, sec_in_line,
 			map_weight, lm->sec_per_line,
@@ -313,19 +313,19 @@ static ssize_t pblk_sysfs_lines_info(struct pblk *pblk, char *page)
 	struct pblk_line_meta *lm = &pblk->lm;
 	ssize_t sz = 0;
 
-	sz = snprintf(page, PAGE_SIZE - sz,
+	sz = scnprintf(page, PAGE_SIZE - sz,
 				"smeta - len:%d, secs:%d\n",
 					lm->smeta_len, lm->smeta_sec);
-	sz += snprintf(page + sz, PAGE_SIZE - sz,
+	sz += scnprintf(page + sz, PAGE_SIZE - sz,
 				"emeta - len:%d, sec:%d, bb_start:%d\n",
 					lm->emeta_len[0], lm->emeta_sec[0],
 					lm->emeta_bb);
-	sz += snprintf(page + sz, PAGE_SIZE - sz,
+	sz += scnprintf(page + sz, PAGE_SIZE - sz,
 				"bitmap lengths: sec:%d, blk:%d, lun:%d\n",
 					lm->sec_bitmap_len,
 					lm->blk_bitmap_len,
 					lm->lun_bitmap_len);
-	sz += snprintf(page + sz, PAGE_SIZE - sz,
+	sz += scnprintf(page + sz, PAGE_SIZE - sz,
 				"blk_line:%d, sec_line:%d, sec_blk:%d\n",
 					lm->blk_per_line,
 					lm->sec_per_line,
@@ -344,12 +344,12 @@ static ssize_t pblk_get_write_amp(u64 user, u64 gc, u64 pad,
 {
 	int sz;
 
-	sz = snprintf(page, PAGE_SIZE,
+	sz = scnprintf(page, PAGE_SIZE,
 			"user:%lld gc:%lld pad:%lld WA:",
 			user, gc, pad);
 
 	if (!user) {
-		sz += snprintf(page + sz, PAGE_SIZE - sz, "NaN\n");
+		sz += scnprintf(page + sz, PAGE_SIZE - sz, "NaN\n");
 	} else {
 		u64 wa_int;
 		u32 wa_frac;
@@ -358,7 +358,7 @@ static ssize_t pblk_get_write_amp(u64 user, u64 gc, u64 pad,
 		wa_int = div64_u64(wa_int, user);
 		wa_int = div_u64_rem(wa_int, 100000, &wa_frac);
 
-		sz += snprintf(page + sz, PAGE_SIZE - sz, "%llu.%05u\n",
+		sz += scnprintf(page + sz, PAGE_SIZE - sz, "%llu.%05u\n",
 							wa_int, wa_frac);
 	}
 
@@ -401,9 +401,9 @@ static ssize_t pblk_sysfs_get_padding_dist(struct pblk *pblk, char *page)
 	total = atomic64_read(&pblk->nr_flush) - pblk->nr_flush_rst;
 	if (!total) {
 		for (i = 0; i < (buckets + 1); i++)
-			sz += snprintf(page + sz, PAGE_SIZE - sz,
+			sz += scnprintf(page + sz, PAGE_SIZE - sz,
 				"%d:0 ", i);
-		sz += snprintf(page + sz, PAGE_SIZE - sz, "\n");
+		sz += scnprintf(page + sz, PAGE_SIZE - sz, "\n");
 
 		return sz;
 	}
@@ -411,7 +411,7 @@ static ssize_t pblk_sysfs_get_padding_dist(struct pblk *pblk, char *page)
 	for (i = 0; i < buckets; i++)
 		total_buckets += atomic64_read(&pblk->pad_dist[i]);
 
-	sz += snprintf(page + sz, PAGE_SIZE - sz, "0:%lld%% ",
+	sz += scnprintf(page + sz, PAGE_SIZE - sz, "0:%lld%% ",
 		bucket_percentage(total - total_buckets, total));
 
 	for (i = 0; i < buckets; i++) {
@@ -419,10 +419,10 @@ static ssize_t pblk_sysfs_get_padding_dist(struct pblk *pblk, char *page)
 
 		p = bucket_percentage(atomic64_read(&pblk->pad_dist[i]),
 					  total);
-		sz += snprintf(page + sz, PAGE_SIZE - sz, "%d:%lld%% ",
+		sz += scnprintf(page + sz, PAGE_SIZE - sz, "%d:%lld%% ",
 				i + 1, p);
 	}
-	sz += snprintf(page + sz, PAGE_SIZE - sz, "\n");
+	sz += scnprintf(page + sz, PAGE_SIZE - sz, "\n");
 
 	return sz;
 }
-- 
2.16.4

