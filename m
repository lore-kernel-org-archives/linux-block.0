Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33151 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752058AbeC2WG7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Mar 2018 18:06:59 -0400
Received: by mail-lf0-f65.google.com with SMTP id x70-v6so3501071lfa.0
        for <linux-block@vger.kernel.org>; Thu, 29 Mar 2018 15:06:58 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 03/37] lightnvm: pblk: handle bad sectors in the emeta area correctly
Date: Fri, 30 Mar 2018 00:04:50 +0200
Message-Id: <20180329220524.30363-4-mb@lightnvm.io>
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Unless we check if there are bad sectors in the entire emeta-area
we risk ending up with valid bitmap / available sector count inconsistency.
This results in lines with a bad chunk at the last LUN marked as bad,
so go through the whole emeta area and mark up the invalid sectors.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
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
2.11.0
