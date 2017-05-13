Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35295 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdEMEaG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2017 00:30:06 -0400
Received: by mail-wm0-f51.google.com with SMTP id b84so35952360wmh.0
        for <linux-block@vger.kernel.org>; Fri, 12 May 2017 21:30:06 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: fix bad free seq. on error path
Date: Sat, 13 May 2017 06:29:55 +0200
Message-Id: <1494649795-569-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Braces around the error patch for metadata pre-allocation are wrongly
placed. This causes a memory leak in case of a memory allocation
failure. Fix it

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index ae8cd6d5af8b..a2ee875aede3 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -604,12 +604,12 @@ static int pblk_lines_init(struct pblk *pblk)
 	l_mg->smeta_alloc_type = PBLK_KMALLOC_META;
 	for (i = 0; i < PBLK_DATA_LINES; i++) {
 		l_mg->sline_meta[i].meta = kmalloc(lm->smeta_len, GFP_KERNEL);
-		if (!l_mg->sline_meta[i].meta)
-			while (--i >= 0) {
+		if (!l_mg->sline_meta[i].meta) {
+			while (--i >= 0)
 				kfree(l_mg->sline_meta[i].meta);
-				ret = -ENOMEM;
-				goto fail;
-			}
+			ret = -ENOMEM;
+			goto fail;
+		}
 	}
 
 	if (lm->emeta_len > KMALLOC_MAX_CACHE_SIZE) {
@@ -617,12 +617,12 @@ static int pblk_lines_init(struct pblk *pblk)
 
 		for (i = 0; i < PBLK_DATA_LINES; i++) {
 			l_mg->eline_meta[i].meta = vmalloc(lm->emeta_len);
-			if (!l_mg->eline_meta[i].meta)
-				while (--i >= 0) {
+			if (!l_mg->eline_meta[i].meta) {
+				while (--i >= 0)
 					vfree(l_mg->eline_meta[i].meta);
-					ret = -ENOMEM;
-					goto fail;
-				}
+				ret = -ENOMEM;
+				goto fail_free_meta;
+			}
 		}
 	} else {
 		l_mg->emeta_alloc_type = PBLK_KMALLOC_META;
@@ -630,12 +630,12 @@ static int pblk_lines_init(struct pblk *pblk)
 		for (i = 0; i < PBLK_DATA_LINES; i++) {
 			l_mg->eline_meta[i].meta =
 					kmalloc(lm->emeta_len, GFP_KERNEL);
-			if (!l_mg->eline_meta[i].meta)
-				while (--i >= 0) {
+			if (!l_mg->eline_meta[i].meta) {
+				while (--i >= 0)
 					kfree(l_mg->eline_meta[i].meta);
-					ret = -ENOMEM;
-					goto fail;
-				}
+				ret = -ENOMEM;
+				goto fail_free_meta;
+			}
 		}
 	}
 
-- 
2.7.4
