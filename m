Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38662 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753265AbcKROoD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 09:44:03 -0500
Received: by mail-wm0-f54.google.com with SMTP id f82so41999229wmf.1
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 06:44:03 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 07/20] lightnvm: cleanup unused target operations
Date: Fri, 18 Nov 2016 15:43:29 +0100
Message-Id: <1479480222-18790-8-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
References: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Cleanup definition leftovers from old gennvm interface

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 include/linux/lightnvm.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 6b26a32..e598308 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -477,9 +477,6 @@ typedef int (nvmm_remove_tgt_fn)(struct nvm_dev *, struct nvm_ioctl_remove *);
 typedef struct nvm_block *(nvmm_get_blk_fn)(struct nvm_dev *,
 					      struct nvm_lun *, unsigned long);
 typedef void (nvmm_put_blk_fn)(struct nvm_dev *, struct nvm_block *);
-typedef int (nvmm_open_blk_fn)(struct nvm_dev *, struct nvm_block *);
-typedef int (nvmm_close_blk_fn)(struct nvm_dev *, struct nvm_block *);
-typedef void (nvmm_flush_blk_fn)(struct nvm_dev *, struct nvm_block *);
 typedef int (nvmm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
 typedef int (nvmm_erase_blk_fn)(struct nvm_dev *, struct nvm_block *, int);
 typedef void (nvmm_mark_blk_fn)(struct nvm_dev *, struct ppa_addr, int);
@@ -504,9 +501,6 @@ struct nvmm_type {
 	/* Block administration callbacks */
 	nvmm_get_blk_fn *get_blk;
 	nvmm_put_blk_fn *put_blk;
-	nvmm_open_blk_fn *open_blk;
-	nvmm_close_blk_fn *close_blk;
-	nvmm_flush_blk_fn *flush_blk;
 
 	nvmm_submit_io_fn *submit_io;
 	nvmm_erase_blk_fn *erase_blk;
-- 
2.7.4

