Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35168 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754073AbcKUMLI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2016 07:11:08 -0500
Received: by mail-wm0-f53.google.com with SMTP id a197so143072766wmd.0
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2016 04:11:08 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/8] lightnvm: remove debug lun statistics from gennvm
Date: Mon, 21 Nov 2016 13:10:32 +0100
Message-Id: <1479730237-20797-4-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1479730237-20797-1-git-send-email-javier@cnexlabs.com>
References: <1479730237-20797-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Since LUNs are managed internally on targets, the media manager has no
access to the free LUN lists. Thus, debug functions that show LUN
information on the device should not be implemented on the media
manager, but rather on the target in itself.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/gennvm.c | 19 -------------------
 include/linux/lightnvm.h  |  5 -----
 2 files changed, 24 deletions(-)

diff --git a/drivers/lightnvm/gennvm.c b/drivers/lightnvm/gennvm.c
index 3cf5d59..dd9afd7 100644
--- a/drivers/lightnvm/gennvm.c
+++ b/drivers/lightnvm/gennvm.c
@@ -613,23 +613,6 @@ static int gen_erase_blk(struct nvm_dev *dev, struct nvm_block *blk, int flags)
 	return nvm_erase_ppa(dev, &addr, 1, flags);
 }
 
-static void gen_lun_info_print(struct nvm_dev *dev)
-{
-	struct gen_dev *gn = dev->mp;
-	struct nvm_lun *lun;
-	unsigned int i;
-
-
-	gen_for_each_lun(gn, lun, i) {
-		spin_lock(&lun->lock);
-
-		pr_info("%s: lun%8u\t%u\n", dev->name, i,
-						lun->nr_free_blocks);
-
-		spin_unlock(&lun->lock);
-	}
-}
-
 static struct nvmm_type gen = {
 	.name			= "gennvm",
 	.version		= {0, 1, 0},
@@ -645,8 +628,6 @@ static struct nvmm_type gen = {
 
 	.mark_blk		= gen_mark_blk,
 
-	.lun_info_print		= gen_lun_info_print,
-
 	.get_area		= gen_get_area,
 	.put_area		= gen_put_area,
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index e56c352..ed04fa6 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -541,8 +541,6 @@ typedef int (nvmm_remove_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_remove *);
 typedef int (nvmm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef int (nvmm_erase_blk_fn)(struct nvm_dev *, struct nvm_block *, int);
 typedef void (nvmm_mark_blk_fn)(struct nvm_dev *, struct ppa_addr, int);
-typedef void (nvmm_lun_info_print_fn)(struct nvm_dev *);
-
 typedef int (nvmm_get_area_fn)(struct nvm_dev *, sector_t *, sector_t);
 typedef void (nvmm_put_area_fn)(struct nvm_dev *, sector_t);
 
@@ -562,9 +560,6 @@ struct nvmm_type {
 	/* Bad block mgmt */
 	nvmm_mark_blk_fn *mark_blk;
 
-	/* Statistics */
-	nvmm_lun_info_print_fn *lun_info_print;
-
 	nvmm_get_area_fn *get_area;
 	nvmm_put_area_fn *put_area;
 
-- 
2.7.4

