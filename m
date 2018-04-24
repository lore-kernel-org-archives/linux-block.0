Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37606 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755809AbeDXFpw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 01:45:52 -0400
Received: by mail-wr0-f194.google.com with SMTP id c14-v6so6943823wrd.4
        for <linux-block@vger.kernel.org>; Mon, 23 Apr 2018 22:45:52 -0700 (PDT)
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, Javier Gonzales <javier@cnexlabs.com>,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v2 3/3] lightnvm: pblk: fix smeta write error path
Date: Tue, 24 Apr 2018 08:45:32 +0300
Message-Id: <1524548732-4326-4-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1524548732-4326-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1524548732-4326-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Smeta write errors were previously ignored. Skip these
lines instead and throw them back on the free
list, so the chunks will go through a reset cycle
before we attempt to use the line again.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 413cf3b..dec1bb4 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -849,9 +849,10 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 	atomic_dec(&pblk->inflight_io);
 
 	if (rqd.error) {
-		if (dir == PBLK_WRITE)
+		if (dir == PBLK_WRITE) {
 			pblk_log_write_err(pblk, &rqd);
-		else if (dir == PBLK_READ)
+			ret = 1;
+		} else if (dir == PBLK_READ)
 			pblk_log_read_err(pblk, &rqd);
 	}
 
@@ -1120,7 +1121,7 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 
 	if (init && pblk_line_submit_smeta_io(pblk, line, off, PBLK_WRITE)) {
 		pr_debug("pblk: line smeta I/O failed. Retry\n");
-		return 1;
+		return 0;
 	}
 
 	bitmap_copy(line->invalid_bitmap, line->map_bitmap, lm->sec_per_line);
-- 
2.7.4
