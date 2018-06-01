Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40755 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbeFANFM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 09:05:12 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so14743644lfc.7
        for <linux-block@vger.kernel.org>; Fri, 01 Jun 2018 06:05:11 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 14/18] lightnvm: pblk: fix smeta write error path
Date: Fri,  1 Jun 2018 15:04:28 +0200
Message-Id: <20180601130432.30866-15-mb@lightnvm.io>
In-Reply-To: <20180601130432.30866-1-mb@lightnvm.io>
References: <20180601130432.30866-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Smeta write errors were previously ignored. Skip these
lines instead and throw them back on the free
list, so the chunks will go through a reset cycle
before we attempt to use the line again.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 263da2e43567..e43093e27084 100644
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
 
@@ -1101,7 +1102,7 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 
 	if (init && pblk_line_submit_smeta_io(pblk, line, off, PBLK_WRITE)) {
 		pr_debug("pblk: line smeta I/O failed. Retry\n");
-		return 1;
+		return 0;
 	}
 
 	bitmap_copy(line->invalid_bitmap, line->map_bitmap, lm->sec_per_line);
-- 
2.11.0
