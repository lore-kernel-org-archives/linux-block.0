Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34634 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeFAOoC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 10:44:02 -0400
Received: by mail-lf0-f68.google.com with SMTP id o9-v6so15205381lfk.1
        for <linux-block@vger.kernel.org>; Fri, 01 Jun 2018 07:44:01 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 06/10] lightnvm: pblk: add possibility to set write buffer size manually
Date: Fri,  1 Jun 2018 16:41:10 +0200
Message-Id: <20180601144114.17490-7-mb@lightnvm.io>
In-Reply-To: <20180601144114.17490-1-mb@lightnvm.io>
References: <20180601144114.17490-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Marcin Dziegielewski <marcin.dziegielewski@intel.com>

In some cases, users can want set write buffer size manually, e.g. to
adjust it to specific workload. This patch provides the possibility
to set write buffer size via module parameter feature.

Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 783887b891b7..ce561f5d48ce 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -20,6 +20,11 @@
 
 #include "pblk.h"
 
+unsigned int write_buffer_size;
+
+module_param(write_buffer_size, uint, 0644);
+MODULE_PARM_DESC(write_buffer_size, "number of entries in a write buffer");
+
 static struct kmem_cache *pblk_ws_cache, *pblk_rec_cache, *pblk_g_rq_cache,
 				*pblk_w_rq_cache;
 static DECLARE_RWSEM(pblk_lock);
@@ -172,10 +177,15 @@ static int pblk_rwb_init(struct pblk *pblk)
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_rb_entry *entries;
-	unsigned long nr_entries;
+	unsigned long nr_entries, buffer_size;
 	unsigned int power_size, power_seg_sz;
 
-	nr_entries = pblk_rb_calculate_size(pblk->pgs_in_buffer);
+	if (write_buffer_size && (write_buffer_size > pblk->pgs_in_buffer))
+		buffer_size = write_buffer_size;
+	else
+		buffer_size = pblk->pgs_in_buffer;
+
+	nr_entries = pblk_rb_calculate_size(buffer_size);
 
 	entries = vzalloc(nr_entries * sizeof(struct pblk_rb_entry));
 	if (!entries)
-- 
2.11.0
