Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42174 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629AbcFCOKW (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 3 Jun 2016 10:10:22 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] lightnvm: Make functions not used by ouside static
Date: Fri,  3 Jun 2016 16:10:06 +0200
Message-Id: <1464963006-22721-1-git-send-email-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Mark functions not used by ouside of thier implementing file as static.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/lightnvm/core.c   | 2 +-
 drivers/lightnvm/sysblk.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 0dc9a80..19577df 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -98,7 +98,7 @@ static struct nvmm_type *nvm_find_mgr_type(const char *name)
 	return NULL;
 }
 
-struct nvmm_type *nvm_init_mgr(struct nvm_dev *dev)
+static struct nvmm_type *nvm_init_mgr(struct nvm_dev *dev)
 {
 	struct nvmm_type *mt;
 	int ret;
diff --git a/drivers/lightnvm/sysblk.c b/drivers/lightnvm/sysblk.c
index b1e1404..ba2afe9 100644
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
1.8.5.6

