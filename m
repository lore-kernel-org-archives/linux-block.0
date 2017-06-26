Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34535 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbdFZJ6X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 05:58:23 -0400
Received: by mail-wm0-f50.google.com with SMTP id t129so816080wmt.1
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 02:58:23 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 14/20] lightnvm: pblk: choose optimal victim GC line
Date: Mon, 26 Jun 2017 11:57:23 +0200
Message-Id: <1498471049-25505-15-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

At the moment, we separate the closed lines on three different list
based on their number of valid sectors. GC recycles lines from each list
based on capacity. Lines from each list are taken in a FIFO fashion.

Since the number of lines is limited (it corresponds to the number of
blocks in a LUN, which is somewhere between 1000-2000), we can afford
scanning the lists to choose the optimal line to be recycled. This helps
specially in lines with a high number of valid sectors.

If the number of blocks per LUN increases, we will consider a more
efficient policy.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-gc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 2e7fb7a51854..f811e4ca63f4 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -287,6 +287,20 @@ static void pblk_gc_lines(struct pblk *pblk, struct list_head *gc_list)
 	}
 }
 
+static struct pblk_line *pblk_gc_get_victim_line(struct pblk *pblk,
+						 struct list_head *group_list)
+{
+	struct pblk_line *line, *victim;
+
+	victim = list_first_entry(group_list, struct pblk_line, list);
+	list_for_each_entry(line, group_list, list) {
+		if (*line->vsc < *victim->vsc)
+			victim = line;
+	}
+
+	return victim;
+}
+
 /*
  * Lines with no valid sectors will be returned to the free list immediately. If
  * GC is activated - either because the free block count is under the determined
@@ -332,7 +346,7 @@ static void pblk_gc_run(struct pblk *pblk)
 			return;
 		}
 
-		line = list_first_entry(group_list, struct pblk_line, list);
+		line = pblk_gc_get_victim_line(pblk, group_list);
 		nr_blocks_free += atomic_read(&line->blk_in_line);
 
 		spin_lock(&line->lock);
-- 
2.7.4
