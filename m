Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56357 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932368AbdJMMr4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 08:47:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id l68so21514260wmd.5
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 05:47:55 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [GIT PULL 51/58] lightnvm: pblk: add l2p crc debug printouts
Date: Fri, 13 Oct 2017 14:46:40 +0200
Message-Id: <20171013124647.32668-52-m@bjorling.me>
In-Reply-To: <20171013124647.32668-1-m@bjorling.me>
References: <20171013124647.32668-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Print the CRC of the logical-to-physical mapping during exit and
after recovering the L2P table to facilitate detection of meta
data corruption/recovery issues.

The CRC printed after recovery should match the CRC printed during
the previous exit - if it doesn't this indicates that either the meta
data written to the disk is corrupt or recovery failed.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/pblk-init.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index ad9f014..52c85f4 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -76,6 +76,28 @@ static blk_qc_t pblk_make_rq(struct request_queue *q, struct bio *bio)
 	return BLK_QC_T_NONE;
 }
 
+static size_t pblk_trans_map_size(struct pblk *pblk)
+{
+	int entry_size = 8;
+
+	if (pblk->ppaf_bitsize < 32)
+		entry_size = 4;
+
+	return entry_size * pblk->rl.nr_secs;
+}
+
+#ifdef CONFIG_NVM_DEBUG
+static u32 pblk_l2p_crc(struct pblk *pblk)
+{
+	size_t map_size;
+	u32 crc = ~(u32)0;
+
+	map_size = pblk_trans_map_size(pblk);
+	crc = crc32_le(crc, pblk->trans_map, map_size);
+	return crc;
+}
+#endif
+
 static void pblk_l2p_free(struct pblk *pblk)
 {
 	vfree(pblk->trans_map);
@@ -85,12 +107,10 @@ static int pblk_l2p_init(struct pblk *pblk)
 {
 	sector_t i;
 	struct ppa_addr ppa;
-	int entry_size = 8;
+	size_t map_size;
 
-	if (pblk->ppaf_bitsize < 32)
-		entry_size = 4;
-
-	pblk->trans_map = vmalloc(entry_size * pblk->rl.nr_secs);
+	map_size = pblk_trans_map_size(pblk);
+	pblk->trans_map = vmalloc(map_size);
 	if (!pblk->trans_map)
 		return -ENOMEM;
 
@@ -508,6 +528,10 @@ static int pblk_lines_configure(struct pblk *pblk, int flags)
 		}
 	}
 
+#ifdef CONFIG_NVM_DEBUG
+	pr_info("pblk init: L2P CRC: %x\n", pblk_l2p_crc(pblk));
+#endif
+
 	/* Free full lines directly as GC has not been started yet */
 	pblk_gc_free_full_lines(pblk);
 
@@ -901,6 +925,11 @@ static void pblk_exit(void *private)
 	down_write(&pblk_lock);
 	pblk_gc_exit(pblk);
 	pblk_tear_down(pblk);
+
+#ifdef CONFIG_NVM_DEBUG
+	pr_info("pblk exit: L2P CRC: %x\n", pblk_l2p_crc(pblk));
+#endif
+
 	pblk_free(pblk);
 	up_write(&pblk_lock);
 }
-- 
2.9.3
