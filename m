Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34334 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753746AbeD3JKY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Apr 2018 05:10:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id a137so9303616wme.1
        for <linux-block@vger.kernel.org>; Mon, 30 Apr 2018 02:10:24 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 08/11] lightnvm: pblk: remove unnecessary argument
Date: Mon, 30 Apr 2018 11:10:06 +0200
Message-Id: <1525079409-6588-9-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
References: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Remove unnecessary argument on pblk_line_free()

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 6 +++---
 drivers/lightnvm/pblk-init.c | 2 +-
 drivers/lightnvm/pblk.h      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6bc0c7f61aac..1b871441d816 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1337,7 +1337,7 @@ static struct pblk_line *pblk_line_retry(struct pblk *pblk,
 	retry_line->emeta = line->emeta;
 	retry_line->meta_line = line->meta_line;
 
-	pblk_line_free(pblk, line);
+	pblk_line_free(line);
 	l_mg->data_line = retry_line;
 	spin_unlock(&l_mg->free_lock);
 
@@ -1562,7 +1562,7 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 	return new;
 }
 
-void pblk_line_free(struct pblk *pblk, struct pblk_line *line)
+void pblk_line_free(struct pblk_line *line)
 {
 	kfree(line->map_bitmap);
 	kfree(line->invalid_bitmap);
@@ -1584,7 +1584,7 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
 	WARN_ON(line->state != PBLK_LINESTATE_GC);
 	line->state = PBLK_LINESTATE_FREE;
 	line->gc_group = PBLK_LINEGC_NONE;
-	pblk_line_free(pblk, line);
+	pblk_line_free(line);
 	spin_unlock(&line->lock);
 
 	atomic_dec(&gc->pipeline_gc);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8f8c9abd14fc..b52855f9336b 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -509,7 +509,7 @@ static void pblk_lines_free(struct pblk *pblk)
 	for (i = 0; i < l_mg->nr_lines; i++) {
 		line = &pblk->lines[i];
 
-		pblk_line_free(pblk, line);
+		pblk_line_free(line);
 		pblk_line_meta_free(line);
 	}
 	spin_unlock(&l_mg->free_lock);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 856ac41e1201..ff0e5e6421dd 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -766,7 +766,7 @@ struct pblk_line *pblk_line_get_data(struct pblk *pblk);
 struct pblk_line *pblk_line_get_erase(struct pblk *pblk);
 int pblk_line_erase(struct pblk *pblk, struct pblk_line *line);
 int pblk_line_is_full(struct pblk_line *line);
-void pblk_line_free(struct pblk *pblk, struct pblk_line *line);
+void pblk_line_free(struct pblk_line *line);
 void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line);
 void pblk_line_close(struct pblk *pblk, struct pblk_line *line);
 void pblk_line_close_ws(struct work_struct *work);
-- 
2.7.4
