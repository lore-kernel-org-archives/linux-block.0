Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35209 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933230AbcGGHy6 (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2016 03:54:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id a66so3514383wme.2
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2016 00:54:57 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 16/17] lightnvm: make ppa_list const in nvm_set_rqd_list
Date: Thu,  7 Jul 2016 09:54:22 +0200
Message-Id: <1467878063-22919-17-git-send-email-m@bjorling.me>
In-Reply-To: <1467878063-22919-1-git-send-email-m@bjorling.me>
References: <1467878063-22919-1-git-send-email-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The passed by reference ppa list in nvm_set_rqd_list() is updated when
multiple planes are available. In that case, each PPA plane is
incremented when the device side PPA list is created. This prevents the
caller to rely on the PPA list to be unmodified after a call.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/core.c  | 8 +++++---
 include/linux/lightnvm.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index ddc8098..00b64f7 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -237,9 +237,10 @@ void nvm_generic_to_addr_mode(struct nvm_dev *dev, struct nvm_rq *rqd)
 EXPORT_SYMBOL(nvm_generic_to_addr_mode);
 
 int nvm_set_rqd_ppalist(struct nvm_dev *dev, struct nvm_rq *rqd,
-				struct ppa_addr *ppas, int nr_ppas, int vblk)
+			const struct ppa_addr *ppas, int nr_ppas, int vblk)
 {
 	int i, plane_cnt, pl_idx;
+	struct ppa_addr ppa;
 
 	if ((!vblk || dev->plane_mode == NVM_PLANE_SINGLE) && nr_ppas == 1) {
 		rqd->nr_ppas = nr_ppas;
@@ -264,8 +265,9 @@ int nvm_set_rqd_ppalist(struct nvm_dev *dev, struct nvm_rq *rqd,
 
 		for (i = 0; i < nr_ppas; i++) {
 			for (pl_idx = 0; pl_idx < plane_cnt; pl_idx++) {
-				ppas[i].g.pl = pl_idx;
-				rqd->ppa_list[(pl_idx * nr_ppas) + i] = ppas[i];
+				ppa = ppas[i];
+				ppa.g.pl = pl_idx;
+				rqd->ppa_list[(pl_idx * nr_ppas) + i] = ppa;
 			}
 		}
 	}
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index e9836cf..ba78b83 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -534,7 +534,7 @@ extern int nvm_submit_io(struct nvm_dev *, struct nvm_rq *);
 extern void nvm_generic_to_addr_mode(struct nvm_dev *, struct nvm_rq *);
 extern void nvm_addr_to_generic_mode(struct nvm_dev *, struct nvm_rq *);
 extern int nvm_set_rqd_ppalist(struct nvm_dev *, struct nvm_rq *,
-						struct ppa_addr *, int, int);
+					const struct ppa_addr *, int, int);
 extern void nvm_free_rqd_ppalist(struct nvm_dev *, struct nvm_rq *);
 extern int nvm_erase_ppa(struct nvm_dev *, struct ppa_addr *, int);
 extern int nvm_erase_blk(struct nvm_dev *, struct nvm_block *);
-- 
2.1.4

