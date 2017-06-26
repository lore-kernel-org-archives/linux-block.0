Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35692 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbdFZJ6U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 05:58:20 -0400
Received: by mail-wm0-f53.google.com with SMTP id w126so2845662wme.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 02:58:18 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>
Subject: [PATCH 09/20] lightnvm: pblk: delete redundant debug line stat
Date: Mon, 26 Jun 2017 11:57:18 +0200
Message-Id: <1498471049-25505-10-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
References: <1498471049-25505-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Remove a legacy variable that helped verifying the consistency of the
run-time metadata for the free line list. With the new metadata layout,
this check is no longer necessary.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <matias@cnexlabs.com>
---
 drivers/lightnvm/pblk-sysfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 707d1b91bde6..3d9a77646a3d 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -153,7 +153,7 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
 	int free_line_cnt = 0, closed_line_cnt = 0, emeta_line_cnt = 0;
 	int d_line_cnt = 0, l_line_cnt = 0;
 	int gc_full = 0, gc_high = 0, gc_mid = 0, gc_low = 0, gc_empty = 0;
-	int free = 0, bad = 0, cor = 0;
+	int bad = 0, cor = 0;
 	int msecs = 0, ssecs = 0, cur_sec = 0, vsc = 0, sec_in_line = 0;
 	int map_weight = 0, meta_weight = 0;
 
@@ -217,8 +217,6 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
 		gc_empty++;
 	}
 
-	list_for_each_entry(line, &l_mg->free_list, list)
-		free++;
 	list_for_each_entry(line, &l_mg->bad_list, list)
 		bad++;
 	list_for_each_entry(line, &l_mg->corrupt_list, list)
@@ -247,9 +245,9 @@ static ssize_t pblk_sysfs_lines(struct pblk *pblk, char *page)
 		geo->nr_luns, lm->blk_per_line, lm->sec_per_line);
 
 	sz += snprintf(page + sz, PAGE_SIZE - sz,
-		"lines:d:%d,l:%d-f:%d(%d),m:%d,c:%d,b:%d,co:%d(d:%d,l:%d)t:%d\n",
+		"lines:d:%d,l:%d-f:%d,m:%d,c:%d,b:%d,co:%d(d:%d,l:%d)t:%d\n",
 					cur_data, cur_log,
-					free, nr_free_lines, emeta_line_cnt,
+					nr_free_lines, emeta_line_cnt,
 					closed_line_cnt,
 					bad, cor,
 					d_line_cnt, l_line_cnt,
-- 
2.7.4
