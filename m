Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35329 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426672AbdDUXdE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 19:33:04 -0400
Received: by mail-wm0-f54.google.com with SMTP id w64so25874876wma.0
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2017 16:33:04 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 4/5] lightnvm: pblk: free metadata on line alloc failure
Date: Sat, 22 Apr 2017 01:32:48 +0200
Message-Id: <1492817569-13532-5-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
References: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When a line allocation fails, for example, due to having too many bad
blocks, free its metadata correctly.

Fixes: a4bd217b4326 "lightnvm: physical block device (pblk) target"

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 7eb62ec..ac3742b 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1127,6 +1127,7 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
 	spin_lock(&l_mg->free_lock);
 	retry_line = pblk_line_get(pblk);
 	if (!retry_line) {
+		l_mg->data_line = NULL;
 		spin_unlock(&l_mg->free_lock);
 		return NULL;
 	}
@@ -1134,18 +1135,17 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
 	retry_line->smeta = line->smeta;
 	retry_line->emeta = line->emeta;
 	retry_line->meta_line = line->meta_line;
-	retry_line->map_bitmap = line->map_bitmap;
-	retry_line->invalid_bitmap = line->invalid_bitmap;
 
-	line->map_bitmap = NULL;
-	line->invalid_bitmap = NULL;
-	line->smeta = NULL;
-	line->emeta = NULL;
+	pblk_line_free(pblk, line);
 	l_mg->data_line = retry_line;
 	spin_unlock(&l_mg->free_lock);
 
-	if (pblk_line_erase(pblk, retry_line))
+	if (pblk_line_erase(pblk, retry_line)) {
+		spin_lock(&l_mg->free_lock);
+		l_mg->data_line = NULL;
+		spin_unlock(&l_mg->free_lock);
 		return NULL;
+	}
 
 	pblk_rl_free_lines_dec(&pblk->rl, retry_line);
 
@@ -1299,6 +1299,8 @@ void pblk_line_free(struct pblk *pblk, struct pblk_line *line)
 
 	line->map_bitmap = NULL;
 	line->invalid_bitmap = NULL;
+	line->smeta = NULL;
+	line->emeta = NULL;
 }
 
 void pblk_line_put(struct kref *ref)
-- 
2.7.4
