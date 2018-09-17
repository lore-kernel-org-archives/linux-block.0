Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36161 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeIQKzl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Sep 2018 06:55:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so7001762pfo.3
        for <linux-block@vger.kernel.org>; Sun, 16 Sep 2018 22:29:55 -0700 (PDT)
From: Heiner Litz <hlitz@ucsc.edu>
To: linux-block@vger.kernel.org, hlitz@ucsc.edu
Cc: javier@cnexlabs.com, mb@lightnvm.io, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com
Subject: [RFC PATCH 2/6] lightnvm: pblk: Add configurable mapping function
Date: Sun, 16 Sep 2018 22:29:35 -0700
Message-Id: <20180917052939.4776-3-hlitz@ucsc.edu>
In-Reply-To: <20180917052939.4776-1-hlitz@ucsc.edu>
References: <20180917052939.4776-1-hlitz@ucsc.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In prepartion of supporting RAIL, introduce a new function pointer so that
different mapping functions can be used to determine sector placement.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
---
 drivers/lightnvm/pblk-init.c |  2 ++
 drivers/lightnvm/pblk-map.c  | 18 +++++++++---------
 drivers/lightnvm/pblk.h      | 13 +++++++++++++
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index fb66bc84d5ca..2b9c6ebd9fac 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -411,6 +411,8 @@ static int pblk_core_init(struct pblk *pblk)
 	pblk->pad_rst_wa = 0;
 	pblk->gc_rst_wa = 0;
 
+	pblk->map_page = pblk_map_page_data;
+
 	atomic64_set(&pblk->nr_flush, 0);
 	pblk->nr_flush_rst = 0;
 
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index ff677ca6e4e1..9490601de3a5 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -18,11 +18,11 @@
 
 #include "pblk.h"
 
-static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
-			      struct ppa_addr *ppa_list,
-			      unsigned long *lun_bitmap,
-			      struct pblk_sec_meta *meta_list,
-			      unsigned int valid_secs)
+int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
+		       struct ppa_addr *ppa_list,
+		       unsigned long *lun_bitmap,
+		       struct pblk_sec_meta *meta_list,
+		       unsigned int valid_secs)
 {
 	struct pblk_line *line = pblk_line_get_data(pblk);
 	struct pblk_emeta *emeta;
@@ -95,8 +95,8 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 
 	for (i = off; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
-		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs)) {
+		if (pblk->map_page(pblk, sentry + i, &ppa_list[i], lun_bitmap,
+				   &meta_list[i], map_secs)) {
 			bio_put(rqd->bio);
 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
 			pblk_pipeline_stop(pblk);
@@ -121,8 +121,8 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 	for (i = 0; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
-		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
-					lun_bitmap, &meta_list[i], map_secs)) {
+		if (pblk->map_page(pblk, sentry + i, &ppa_list[i], lun_bitmap,
+				   &meta_list[i], map_secs)) {
 			bio_put(rqd->bio);
 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
 			pblk_pipeline_stop(pblk);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index eab50df70ae6..87dc24772dad 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -604,6 +604,12 @@ struct pblk_addrf {
 	int sec_ws_stripe;
 };
 
+typedef int (pblk_map_page_fn)(struct pblk *pblk, unsigned int sentry,
+			       struct ppa_addr *ppa_list,
+			       unsigned long *lun_bitmap,
+			       struct pblk_sec_meta *meta_list,
+			       unsigned int valid_secs);
+
 struct pblk {
 	struct nvm_tgt_dev *dev;
 	struct gendisk *disk;
@@ -709,6 +715,8 @@ struct pblk {
 	struct timer_list wtimer;
 
 	struct pblk_gc gc;
+
+	pblk_map_page_fn *map_page;
 };
 
 struct pblk_line_ws {
@@ -873,6 +881,11 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 		 unsigned long *lun_bitmap, unsigned int valid_secs,
 		 unsigned int off);
+int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
+		       struct ppa_addr *ppa_list,
+		       unsigned long *lun_bitmap,
+		       struct pblk_sec_meta *meta_list,
+		       unsigned int valid_secs);
 
 /*
  * pblk write thread
-- 
2.17.1
