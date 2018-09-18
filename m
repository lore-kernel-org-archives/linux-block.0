Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46899 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbeIRNMT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 09:12:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id k14-v6so1027907edr.13
        for <linux-block@vger.kernel.org>; Tue, 18 Sep 2018 00:40:56 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: fix race on sysfs line state
Date: Tue, 18 Sep 2018 09:40:32 +0200
Message-Id: <1537256432-19807-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

pblk exposes a sysfs interface that represents its internal state. Part
of this state is the map bitmap for the current open line, which should
be protected by the line lock to avoid a race when freeing the line
metadata. Currently, it is not.

This patch makes sure that the line state is consistent and NULL
bitmap pointers are not dereferenced.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 5 +++--
 drivers/lightnvm/pblk-sysfs.c | 8 +++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a23e965d32fc..fec0ad68dcd6 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1662,13 +1662,14 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
 	struct pblk_line *cur, *new = NULL;
 	unsigned int left_seblks;
 
-	cur = l_mg->data_line;
 	new = l_mg->data_next;
 	if (!new)
 		goto out;
+
+	spin_lock(&l_mg->free_lock);
+	cur = l_mg->data_line;
 	l_mg->data_line = new;
 
-	spin_lock(&l_mg->free_lock);
 	pblk_line_setup_metadata(new, l_mg, &pblk->lm);
 	spin_unlock(&l_mg->free_lock);
 
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index cba83ac43e62..2d2818155aa8 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -263,8 +263,14 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
 		sec_in_line = l_mg->data_line->sec_in_line;
 		meta_weight = bitmap_weight(&l_mg->meta_bitmap,
 							PBLK_DATA_LINES);
-		map_weight = bitmap_weight(l_mg->data_line->map_bitmap,
+
+		spin_lock(&l_mg->data_line->lock);
+		if (l_mg->data_line->map_bitmap)
+			map_weight = bitmap_weight(l_mg->data_line->map_bitmap,
 							lm->sec_per_line);
+		else
+			map_weight = 0;
+		spin_unlock(&l_mg->data_line->lock);
 	}
 	spin_unlock(&l_mg->free_lock);
 
-- 
2.7.4
