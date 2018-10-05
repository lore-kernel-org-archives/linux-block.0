Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:47430 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726073AbeJEHUX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Oct 2018 03:20:23 -0400
From: Zhoujie Wu <zjwu@marvell.com>
To: <mb@lightnvm.io>, <linux-block@vger.kernel.org>
CC: <hongd@marvell.com>, Zhoujie Wu <zjwu@marvell.com>
Subject: [PATCH] lightnvm: consider max hw sectors supported for max_write_pgs
Date: Thu, 4 Oct 2018 17:26:30 -0700
Message-ID: <1538699190-4857-1-git-send-email-zjwu@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When do GC, the number of read/write sectors are determined
by max_write_pgs(see gc_rq preparation in pblk_gc_line_prepare_ws).

Due to max_write_pgs doesn't consider max hw sectors
supported by nvme controller(128K), which leads to GC
tries to read 64 * 4K in one command, and see below error
caused by pblk_bio_map_addr in function pblk_submit_read_gc.

[ 2923.005376] pblk: could not add page to bio
[ 2923.005377] pblk: could not allocate GC bio (18446744073709551604)

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
---
 drivers/lightnvm/pblk-init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index e357388..2e51875 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -393,6 +393,7 @@ static int pblk_core_init(struct pblk *pblk)
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	int ret, max_write_ppas;
+	struct request_queue *bqueue = dev->q;
 
 	atomic64_set(&pblk->user_wa, 0);
 	atomic64_set(&pblk->pad_wa, 0);
@@ -407,6 +408,9 @@ static int pblk_core_init(struct pblk *pblk)
 	pblk->min_write_pgs = geo->ws_opt;
 	max_write_ppas = pblk->min_write_pgs * geo->all_luns;
 	pblk->max_write_pgs = min_t(int, max_write_ppas, NVM_MAX_VLBA);
+	/* consider the max hw sector as well */
+	pblk->max_write_pgs =  min_t(int, pblk->max_write_pgs,
+		queue_max_hw_sectors(bqueue) / (geo->csecs >> 9));
 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
 
 	pblk->pad_dist = kcalloc(pblk->min_write_pgs - 1, sizeof(atomic64_t),
-- 
1.9.1
