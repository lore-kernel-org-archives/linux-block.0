Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35746 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdFZJ6Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 05:58:25 -0400
Received: by mail-wm0-f51.google.com with SMTP id w126so2847779wme.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 02:58:25 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 16/20] lightnvm: pblk: cleanup unnecessary code
Date: Mon, 26 Jun 2017 11:57:25 +0200
Message-Id: <1498471049-25505-17-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Cleanup unnecessary headers and code lines.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 1 -
 drivers/lightnvm/pblk-write.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index cba7cd78e4a6..d815cdad56b8 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -17,7 +17,6 @@
  */
 
 #include "pblk.h"
-#include <linux/time.h>
 
 static void pblk_mark_bb(struct pblk *pblk, struct pblk_line *line,
 			 struct ppa_addr *ppa)
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 3db2cbe5b788..a50bfbd12c32 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -27,14 +27,8 @@ static unsigned long pblk_end_w_bio(struct pblk *pblk, struct nvm_rq *rqd,
 
 	for (i = 0; i < c_ctx->nr_valid; i++) {
 		struct pblk_w_ctx *w_ctx;
-		struct ppa_addr p;
-		struct pblk_line *line;
 
 		w_ctx = pblk_rb_w_ctx(&pblk->rwb, c_ctx->sentry + i);
-
-		p = rqd->ppa_list[i];
-		line = &pblk->lines[pblk_dev_ppa_to_line(p)];
-
 		while ((original_bio = bio_list_pop(&w_ctx->bios)))
 			bio_endio(original_bio);
 	}
-- 
2.7.4
