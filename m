Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:44121 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeFANEp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jun 2018 09:04:45 -0400
Received: by mail-lf0-f42.google.com with SMTP id 36-v6so12791518lfr.11
        for <linux-block@vger.kernel.org>; Fri, 01 Jun 2018 06:04:45 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 01/18] lightnvm: pblk: fail gracefully on line alloc. failure
Date: Fri,  1 Jun 2018 15:04:15 +0200
Message-Id: <20180601130432.30866-2-mb@lightnvm.io>
In-Reply-To: <20180601130432.30866-1-mb@lightnvm.io>
References: <20180601130432.30866-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <javier@javigon.com>

In the event of a line failing to allocate, fail gracefully and stop the
pipeline to avoid more write failing in the same place.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c |  5 +++++
 drivers/lightnvm/pblk-map.c  | 33 ++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 91a5bc2556a3..dee64f91227d 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1047,6 +1047,11 @@ static int pblk_lines_init(struct pblk *pblk)
 		nr_free_chks += pblk_setup_line_meta(pblk, line, chunk_meta, i);
 	}
 
+	if (!nr_free_chks) {
+		pr_err("pblk: too many bad blocks prevent for sane instance\n");
+		return -EINTR;
+	}
+
 	pblk_set_provision(pblk, nr_free_chks);
 
 	kfree(chunk_meta);
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 20dbaa89c9df..953ca31dda68 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -18,11 +18,11 @@
 
 #include "pblk.h"
 
-static void pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
-			       struct ppa_addr *ppa_list,
-			       unsigned long *lun_bitmap,
-			       struct pblk_sec_meta *meta_list,
-			       unsigned int valid_secs)
+static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
+			      struct ppa_addr *ppa_list,
+			      unsigned long *lun_bitmap,
+			      struct pblk_sec_meta *meta_list,
+			      unsigned int valid_secs)
 {
 	struct pblk_line *line = pblk_line_get_data(pblk);
 	struct pblk_emeta *emeta;
@@ -35,8 +35,14 @@ static void pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 	if (pblk_line_is_full(line)) {
 		struct pblk_line *prev_line = line;
 
+		/* If we cannot allocate a new line, make sure to store metadata
+		 * on current line and then fail
+		 */
 		line = pblk_line_replace_data(pblk);
 		pblk_line_close_meta(pblk, prev_line);
+
+		if (!line)
+			return -EINTR;
 	}
 
 	emeta = line->emeta;
@@ -74,6 +80,7 @@ static void pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 	}
 
 	pblk_down_rq(pblk, ppa_list, nr_secs, lun_bitmap);
+	return 0;
 }
 
 void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
@@ -87,8 +94,12 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 
 	for (i = off; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
-		pblk_map_page_data(pblk, sentry + i, &rqd->ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs);
+		if (pblk_map_page_data(pblk, sentry + i, &rqd->ppa_list[i],
+					lun_bitmap, &meta_list[i], map_secs)) {
+			bio_put(rqd->bio);
+			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
+			pblk_pipeline_stop(pblk);
+		}
 	}
 }
 
@@ -108,8 +119,12 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 	for (i = 0; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
-		pblk_map_page_data(pblk, sentry + i, &rqd->ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs);
+		if (pblk_map_page_data(pblk, sentry + i, &rqd->ppa_list[i],
+					lun_bitmap, &meta_list[i], map_secs)) {
+			bio_put(rqd->bio);
+			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
+			pblk_pipeline_stop(pblk);
+		}
 
 		erase_lun = pblk_ppa_to_pos(geo, rqd->ppa_list[i]);
 
-- 
2.11.0
