Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45000 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeJISbq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 14:31:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so641225pgu.11
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 04:15:19 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 37/45] lightnvm: pblk: fix race on sysfs line state
Date: Tue,  9 Oct 2018 13:12:07 +0200
Message-Id: <20181009111215.7653-38-mb@lightnvm.io>
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

pblk exposes a sysfs interface that represents its internal state. Part
of this state is the map bitmap for the current open line, which should
be protected by the line lock to avoid a race when freeing the line
metadata. Currently, it is not.

This patch makes sure that the line state is consistent and NULL
bitmap pointers are not dereferenced.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c  | 5 +++--
 drivers/lightnvm/pblk-sysfs.c | 8 +++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 4045a9b1ee74..6944aac43b01 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1611,13 +1611,14 @@ struct pblk_line *pblk_line_replace_data(struct pblk *pblk)
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
2.17.1
