Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:29553 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933220AbeFGQP2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Jun 2018 12:15:28 -0400
From: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, javier@cnexlabs.com,
        michal.sorn@intel.com,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        Igor Konopko <igor.j.konopko@intel.com>
Subject: [PATCH v2] lightnvm: pblk: handle case when mw_cunits equals to 0
Date: Thu,  7 Jun 2018 18:15:23 +0200
Message-Id: <1528388123-14193-1-git-send-email-marcin.dziegielewski@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Some devices can expose mw_cunits equal to 0, it can cause the creation of too small write buffer and cause performance to drop on write workloads.

Additionally, write buffer size must cover openchannel write data requirements, such as WS_MIN and MW_CUNITS - it must be greater than or equal to the larger one multipled by number of luns. However, for the performance reason, we are using WS_OPT value to calculation instead of WS_MIN.

Because the place where buffer size is calculated was changed, this patch also removes pgs_in_buffer filed in pblk structure.

Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-init.c | 9 +++++----
 drivers/lightnvm/pblk.h      | 3 ---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index a27b28d..2f94832 100644
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
index 7fbdfdc..b62fc3e 100644
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
1.8.3.1
