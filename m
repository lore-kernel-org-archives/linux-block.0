Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:36028 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdAWMAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 07:00:20 -0500
Received: by mail-wj0-f194.google.com with SMTP id kq3so1730461wjc.3
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 03:59:45 -0800 (PST)
From: "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 2/8] lightnvm: collapse nvm_erase_ppa and nvm_erase_blk
Date: Mon, 23 Jan 2017 12:59:13 +0100
Message-Id: <20170123115919.14339-3-matias@cnexlabs.com>
In-Reply-To: <20170123115919.14339-1-matias@cnexlabs.com>
References: <20170123115919.14339-1-matias@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

After gennvm and core have been merged, there are no more callers to
nvm_erase_ppa. Therefore collapse the device specific and target
specific erase functions.

Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/core.c  | 57 ++++++++++++++++++++++--------------------------
 include/linux/lightnvm.h |  1 -
 2 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index e9a4956..a4e2e3b 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -683,12 +683,34 @@ int nvm_submit_io(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 }
 EXPORT_SYMBOL(nvm_submit_io);
 
-int nvm_erase_blk(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *p, int flags)
+int nvm_erase_blk(struct nvm_tgt_dev *tgt_dev, struct ppa_addr *ppas, int flags)
 {
-	/* Convert address space */
-	nvm_map_to_dev(tgt_dev, p);
+	struct nvm_dev *dev = tgt_dev->parent;
+	struct nvm_rq rqd;
+	int ret;
 
-	return nvm_erase_ppa(tgt_dev->parent, p, 1, flags);
+	if (!dev->ops->erase_block)
+		return 0;
+
+	ret = nvm_map_to_dev(tgt_dev, ppas);
+	if (ret)
+		return ret;
+
+	memset(&rqd, 0, sizeof(struct nvm_rq));
+
+	ret = nvm_set_rqd_ppalist(dev, &rqd, ppas, 1, 1);
+	if (ret)
+		return ret;
+
+	nvm_generic_to_addr_mode(dev, &rqd);
+
+	rqd.flags = flags;
+
+	ret = dev->ops->erase_block(dev, &rqd);
+
+	nvm_free_rqd_ppalist(dev, &rqd);
+
+	return ret;
 }
 EXPORT_SYMBOL(nvm_erase_blk);
 
@@ -847,33 +869,6 @@ void nvm_free_rqd_ppalist(struct nvm_dev *dev, struct nvm_rq *rqd)
 }
 EXPORT_SYMBOL(nvm_free_rqd_ppalist);
 
-int nvm_erase_ppa(struct nvm_dev *dev, struct ppa_addr *ppas, int nr_ppas,
-								int flags)
-{
-	struct nvm_rq rqd;
-	int ret;
-
-	if (!dev->ops->erase_block)
-		return 0;
-
-	memset(&rqd, 0, sizeof(struct nvm_rq));
-
-	ret = nvm_set_rqd_ppalist(dev, &rqd, ppas, nr_ppas, 1);
-	if (ret)
-		return ret;
-
-	nvm_generic_to_addr_mode(dev, &rqd);
-
-	rqd.flags = flags;
-
-	ret = dev->ops->erase_block(dev, &rqd);
-
-	nvm_free_rqd_ppalist(dev, &rqd);
-
-	return ret;
-}
-EXPORT_SYMBOL(nvm_erase_ppa);
-
 void nvm_end_io(struct nvm_rq *rqd, int error)
 {
 	struct nvm_tgt_dev *tgt_dev = rqd->dev;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 84309fe..f2007b2 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -483,7 +483,6 @@ extern void nvm_addr_to_generic_mode(struct nvm_dev *, struct nvm_rq *);
 extern int nvm_set_rqd_ppalist(struct nvm_dev *, struct nvm_rq *,
 					const struct ppa_addr *, int, int);
 extern void nvm_free_rqd_ppalist(struct nvm_dev *, struct nvm_rq *);
-extern int nvm_erase_ppa(struct nvm_dev *, struct ppa_addr *, int, int);
 extern int nvm_erase_blk(struct nvm_tgt_dev *, struct ppa_addr *, int);
 extern int nvm_get_l2p_tbl(struct nvm_tgt_dev *, u64, u32, nvm_l2p_update_fn *,
 			   void *);
-- 
2.7.4

