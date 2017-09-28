Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.mpynet.fi ([82.197.21.84]:14698 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752357AbdI1OlR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Sep 2017 10:41:17 -0400
Date: Thu, 28 Sep 2017 17:40:42 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: fix changing GC group list for a line
Message-ID: <20170928143828.GA7645@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

pblk_line_gc_list seems to had a bug since the introduction of pblk in
getting GC list for a line.  In b20ba1bc7 while redesigning GC
algorithm it was not fixed correctly.  The problem is that even if
valid sector count (vsc) is less that mid_thrs (threshold for GC mid
list) it would always satisfy 'vsc < high_thrs' as high_thrs >
mid_thrs always.

Fixes: a4bd217b4("lightnvm: physical block device (pblk) target")
Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/pblk-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 8150164..93a58ed 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -295,16 +295,16 @@ struct list_head *pblk_line_gc_list(struct pblk *pblk, struct pblk_line *line)
 			line->gc_group = PBLK_LINEGC_FULL;
 			move_list = &l_mg->gc_full_list;
 		}
-	} else if (vsc < lm->high_thrs) {
-		if (line->gc_group != PBLK_LINEGC_HIGH) {
-			line->gc_group = PBLK_LINEGC_HIGH;
-			move_list = &l_mg->gc_high_list;
-		}
 	} else if (vsc < lm->mid_thrs) {
 		if (line->gc_group != PBLK_LINEGC_MID) {
 			line->gc_group = PBLK_LINEGC_MID;
 			move_list = &l_mg->gc_mid_list;
 		}
+	} else if (vsc < lm->high_thrs) {
+		if (line->gc_group != PBLK_LINEGC_HIGH) {
+			line->gc_group = PBLK_LINEGC_HIGH;
+			move_list = &l_mg->gc_high_list;
+		}
 	} else if (vsc < line->sec_in_line) {
 		if (line->gc_group != PBLK_LINEGC_LOW) {
 			line->gc_group = PBLK_LINEGC_LOW;
-- 
2.9.3
