Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34114 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755574AbcK1Vjq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:39:46 -0500
Received: by mail-wj0-f195.google.com with SMTP id xy5so15802357wjc.1
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:45 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 09/23] lightnvm: cleanup unused target operations
Date: Mon, 28 Nov 2016 22:39:00 +0100
Message-Id: <20161128213914.12516-10-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

Cleanup definition leftovers from old gennvm interface

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
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
2.9.3

