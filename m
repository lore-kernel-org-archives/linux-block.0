Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:32916 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeGMJCw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jul 2018 05:02:52 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so11919134plb.0
        for <linux-block@vger.kernel.org>; Fri, 13 Jul 2018 01:49:12 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 01/10] lightnvm: pblk: handle case when mw_cunits equals to 0
Date: Fri, 13 Jul 2018 10:48:36 +0200
Message-Id: <20180713084845.19511-2-mb@lightnvm.io>
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
References: <20180713084845.19511-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Marcin Dziegielewski <marcin.dziegielewski@intel.com>

Some devices can expose mw_cunits equal to 0, it can cause the
creation of too small write buffer and cause performance to drop
on write workloads.

Additionally, write buffer size must cover write data requirements,
such as WS_MIN and MW_CUNITS - it must be greater than or equal to
the larger one multiplied by the number of PUs. However, for
performance reasons, use the WS_OPT value to calculation instead of
WS_MIN.

Because the place where buffer size is calculated was changed, this
patch also removes pgs_in_buffer filed in pblk structure.

Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 9 +++++----
 drivers/lightnvm/pblk.h      | 3 ---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index b57f764d6a16..ef8d8dea7b6b 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -179,11 +179,14 @@ static int pblk_rwb_init(struct pblk *pblk)
 	struct pblk_rb_entry *entries;
 	unsigned long nr_entries, buffer_size;
 	unsigned int power_size, power_seg_sz;
+	int pgs_in_buffer;
 
-	if (write_buffer_size && (write_buffer_size > pblk->pgs_in_buffer))
+	pgs_in_buffer = max(geo->mw_cunits, geo->ws_opt) * geo->all_luns;
+
+	if (write_buffer_size && (write_buffer_size > pgs_in_buffer))
 		buffer_size = write_buffer_size;
 	else
-		buffer_size = pblk->pgs_in_buffer;
+		buffer_size = pgs_in_buffer;
 
 	nr_entries = pblk_rb_calculate_size(buffer_size);
 
@@ -366,8 +369,6 @@ static int pblk_core_init(struct pblk *pblk)
 	atomic64_set(&pblk->nr_flush, 0);
 	pblk->nr_flush_rst = 0;
 
-	pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
-
 	pblk->min_write_pgs = geo->ws_opt * (geo->csecs / PAGE_SIZE);
 	max_write_ppas = pblk->min_write_pgs * geo->all_luns;
 	pblk->max_write_pgs = min_t(int, max_write_ppas, NVM_MAX_VLBA);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 34cc1d64a9d4..9d1a0e86e082 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -608,9 +608,6 @@ struct pblk {
 
 	int min_write_pgs; /* Minimum amount of pages required by controller */
 	int max_write_pgs; /* Maximum amount of pages supported by controller */
-	int pgs_in_buffer; /* Number of pages that need to be held in buffer to
-			    * guarantee successful reads.
-			    */
 
 	sector_t capacity; /* Device capacity when bad blocks are subtracted */
 
-- 
2.11.0
