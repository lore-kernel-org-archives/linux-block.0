Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45261 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeHQRem (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Aug 2018 13:34:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id w16-v6so6517488ljh.12
        for <linux-block@vger.kernel.org>; Fri, 17 Aug 2018 07:31:05 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: unify vector max req constants
Date: Fri, 17 Aug 2018 16:30:55 +0200
Message-Id: <20180817143055.26032-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Both NVM_MAX_VLBA and PBLK_MAX_REQ_ADDRS define how many LBAs that
are available in a vector command. pblk uses them interchangeably
in its implementation. Use NVM_MAX_VLBA as the main one and remove
usages of PBLK_MAX_REQ_ADDRS.

Also remove the power representation that only has one user, and
instead calculate it at runtime.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c |  6 ------
 drivers/lightnvm/pblk-read.c |  6 +++---
 drivers/lightnvm/pblk-rl.c   |  4 ++--
 drivers/lightnvm/pblk.h      | 10 ++++------
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 53bd52114aee..9119c64d6f62 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -376,12 +376,6 @@ static int pblk_core_init(struct pblk *pblk)
 	pblk->max_write_pgs = min_t(int, max_write_ppas, NVM_MAX_VLBA);
 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
 
-	if (pblk->max_write_pgs > PBLK_MAX_REQ_ADDRS) {
-		pblk_err(pblk, "vector list too big(%u > %u)\n",
-				pblk->max_write_pgs, PBLK_MAX_REQ_ADDRS);
-		return -EINVAL;
-	}
-
 	pblk->pad_dist = kcalloc(pblk->min_write_pgs - 1, sizeof(atomic64_t),
 								GFP_KERNEL);
 	if (!pblk->pad_dist)
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 48739f6c0417..cd2f61eed6a0 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -43,7 +43,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 				 unsigned long *read_bitmap)
 {
 	struct pblk_sec_meta *meta_list = rqd->meta_list;
-	struct ppa_addr ppas[PBLK_MAX_REQ_ADDRS];
+	struct ppa_addr ppas[NVM_MAX_VLBA];
 	int nr_secs = rqd->nr_ppas;
 	bool advanced_bio = false;
 	int i, j = 0;
@@ -450,7 +450,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	int ret = NVM_IO_ERR;
 
 	/* logic error: lba out-of-bounds. Ignore read request */
-	if (blba >= pblk->rl.nr_secs || nr_secs > PBLK_MAX_REQ_ADDRS) {
+	if (blba >= pblk->rl.nr_secs || nr_secs > NVM_MAX_VLBA) {
 		WARN(1, "pblk: read lba out of bounds (lba:%llu, nr:%d)\n",
 					(unsigned long long)blba, nr_secs);
 		return NVM_IO_ERR;
@@ -546,7 +546,7 @@ static int read_ppalist_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
 			      struct pblk_line *line, u64 *lba_list,
 			      u64 *paddr_list_gc, unsigned int nr_secs)
 {
-	struct ppa_addr ppa_list_l2p[PBLK_MAX_REQ_ADDRS];
+	struct ppa_addr ppa_list_l2p[NVM_MAX_VLBA];
 	struct ppa_addr ppa_gc;
 	int valid_secs = 0;
 	int i;
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index 6a0616a6fcaf..a32790f7b7fc 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -127,7 +127,7 @@ static void __pblk_rl_update_rates(struct pblk_rl *rl,
 	} else if (free_blocks < rl->high) {
 		int shift = rl->high_pw - rl->rb_windows_pw;
 		int user_windows = free_blocks >> shift;
-		int user_max = user_windows << PBLK_MAX_REQ_ADDRS_PW;
+		int user_max = user_windows << ilog2(NVM_MAX_VLBA);
 
 		rl->rb_user_max = user_max;
 		rl->rb_gc_max = max - user_max;
@@ -228,7 +228,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	rl->rsv_blocks = min_blocks;
 
 	/* This will always be a power-of-2 */
-	rb_windows = budget / PBLK_MAX_REQ_ADDRS;
+	rb_windows = budget / NVM_MAX_VLBA;
 	rl->rb_windows_pw = get_count_order(rb_windows);
 
 	/* To start with, all buffer is available to user I/O writers */
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 579b4ea9716c..64ae0c7ed3bb 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -37,8 +37,6 @@
 
 #define PBLK_SECTOR (512)
 #define PBLK_EXPOSED_PAGE_SIZE (4096)
-#define PBLK_MAX_REQ_ADDRS (64)
-#define PBLK_MAX_REQ_ADDRS_PW (6)
 
 #define PBLK_NR_CLOSE_JOBS (4)
 
@@ -99,8 +97,8 @@ enum {
 	PBLK_RL_LOW = 4
 };
 
-#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * PBLK_MAX_REQ_ADDRS)
-#define pblk_dma_ppa_size (sizeof(u64) * PBLK_MAX_REQ_ADDRS)
+#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * NVM_MAX_VLBA)
+#define pblk_dma_ppa_size (sizeof(u64) * NVM_MAX_VLBA)
 
 /* write buffer completion context */
 struct pblk_c_ctx {
@@ -218,8 +216,8 @@ struct pblk_lun {
 struct pblk_gc_rq {
 	struct pblk_line *line;
 	void *data;
-	u64 paddr_list[PBLK_MAX_REQ_ADDRS];
-	u64 lba_list[PBLK_MAX_REQ_ADDRS];
+	u64 paddr_list[NVM_MAX_VLBA];
+	u64 lba_list[NVM_MAX_VLBA];
 	int nr_secs;
 	int secs_to_gc;
 	struct list_head list;
-- 
2.11.0
