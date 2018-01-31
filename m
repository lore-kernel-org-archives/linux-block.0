Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40370 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeAaCHC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jan 2018 21:07:02 -0500
Received: by mail-wm0-f67.google.com with SMTP id v123so4861553wmd.5
        for <linux-block@vger.kernel.org>; Tue, 30 Jan 2018 18:07:01 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 1/5] lightnvm: pblk: handle bad sectors in the emeta area correctly
Date: Wed, 31 Jan 2018 03:06:47 +0100
Message-Id: <1517364411-22386-1-git-send-email-javier@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Unless we check if there are bad sectors in the entire emeta-area
we risk ending up with valid bitmap / available sector count inconsistency.
This results in lines with a bad chunk at the last LUN marked as bad,
so go through the whole emeta area and mark up the invalid sectors.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 0487b9340c1d..9027cf2ed1d8 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1021,6 +1021,7 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	int nr_bb = 0;
 	u64 off;
 	int bit = -1;
+	int emeta_secs;
 
 	line->sec_in_line = lm->sec_per_line;
 
@@ -1055,18 +1056,18 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 	/* Mark emeta metadata sectors as bad sectors. We need to consider bad
 	 * blocks to make sure that there are enough sectors to store emeta
 	 */
-	off = lm->sec_per_line - lm->emeta_sec[0];
-	bitmap_set(line->invalid_bitmap, off, lm->emeta_sec[0]);
-	while (nr_bb) {
+	emeta_secs = lm->emeta_sec[0];
+	off = lm->sec_per_line;
+	while (emeta_secs) {
 		off -= geo->sec_per_pl;
 		if (!test_bit(off, line->invalid_bitmap)) {
 			bitmap_set(line->invalid_bitmap, off, geo->sec_per_pl);
-			nr_bb--;
+			emeta_secs -= geo->sec_per_pl;
 		}
 	}
 
-	line->sec_in_line -= lm->emeta_sec[0];
 	line->emeta_ssec = off;
+	line->sec_in_line -= lm->emeta_sec[0];
 	line->nr_valid_lbas = 0;
 	line->left_msecs = line->sec_in_line;
 	*line->vsc = cpu_to_le32(line->sec_in_line);
-- 
2.7.4
