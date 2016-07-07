Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33397 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756469AbcGGHyj (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2016 03:54:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id n127so997100wme.0
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2016 00:54:39 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 05/17] lightnvm: Make functions not used by ouside static
Date: Thu,  7 Jul 2016 09:54:11 +0200
Message-Id: <1467878063-22919-6-git-send-email-m@bjorling.me>
In-Reply-To: <1467878063-22919-1-git-send-email-m@bjorling.me>
References: <1467878063-22919-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Johannes Thumshirn <jthumshirn@suse.de>

Mark functions not used by ouside of thier implementing file as static.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c   | 2 +-
 drivers/lightnvm/sysblk.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 13993c9..8beb9c0 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -110,7 +110,7 @@ static struct nvmm_type *nvm_find_mgr_type(const char *name)
 	return NULL;
 }
 
-struct nvmm_type *nvm_init_mgr(struct nvm_dev *dev)
+static struct nvmm_type *nvm_init_mgr(struct nvm_dev *dev)
 {
 	struct nvmm_type *mt;
 	int ret;
diff --git a/drivers/lightnvm/sysblk.c b/drivers/lightnvm/sysblk.c
index 994697a..a75bd28 100644
--- a/drivers/lightnvm/sysblk.c
+++ b/drivers/lightnvm/sysblk.c
@@ -39,7 +39,8 @@ static inline int scan_ppa_idx(int row, int blkid)
 	return (row * MAX_BLKS_PR_SYSBLK) + blkid;
 }
 
-void nvm_sysblk_to_cpu(struct nvm_sb_info *info, struct nvm_system_block *sb)
+static void nvm_sysblk_to_cpu(struct nvm_sb_info *info,
+			      struct nvm_system_block *sb)
 {
 	info->seqnr = be32_to_cpu(sb->seqnr);
 	info->erase_cnt = be32_to_cpu(sb->erase_cnt);
@@ -48,7 +49,8 @@ void nvm_sysblk_to_cpu(struct nvm_sb_info *info, struct nvm_system_block *sb)
 	info->fs_ppa.ppa = be64_to_cpu(sb->fs_ppa);
 }
 
-void nvm_cpu_to_sysblk(struct nvm_system_block *sb, struct nvm_sb_info *info)
+static void nvm_cpu_to_sysblk(struct nvm_system_block *sb,
+			      struct nvm_sb_info *info)
 {
 	sb->magic = cpu_to_be32(NVM_SYSBLK_MAGIC);
 	sb->seqnr = cpu_to_be32(info->seqnr);
@@ -86,7 +88,7 @@ static int nvm_setup_sysblks(struct nvm_dev *dev, struct ppa_addr *sysblk_ppas)
 	return nr_rows;
 }
 
-void nvm_setup_sysblk_scan(struct nvm_dev *dev, struct sysblk_scan *s,
+static void nvm_setup_sysblk_scan(struct nvm_dev *dev, struct sysblk_scan *s,
 						struct ppa_addr *sysblk_ppas)
 {
 	memset(s, 0, sizeof(struct sysblk_scan));
-- 
2.1.4

