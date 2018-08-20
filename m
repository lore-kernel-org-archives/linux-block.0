Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33841 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeHTO64 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Aug 2018 10:58:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id g9-v6so5418069lfh.1
        for <linux-block@vger.kernel.org>; Mon, 20 Aug 2018 04:43:38 -0700 (PDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: refactor put line fn on read completion
Date: Mon, 20 Aug 2018 13:43:20 +0200
Message-Id: <20180820114320.3764-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The read completion path uses the put_line variable to decide whether
the reference on a line should be released. The function name used for
that is pblk_read_put_rqd_kref, which could lead one to believe that it
is the rqd that is releasing the reference, while it is the line
reference that is put.

Rename and also split the function in two to account for either rqd or
single ppa callers.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index cd2f61eed6a0..16858eaf694a 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -165,20 +165,23 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 	WARN_ONCE(j != rqd->nr_ppas, "pblk: corrupted random request\n");
 }
 
-static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq *rqd)
+static void __pblk_read_put_line(struct pblk *pblk, struct ppa_addr ppa)
 {
-	struct ppa_addr *ppa_list;
-	int i;
-
-	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
-
-	for (i = 0; i < rqd->nr_ppas; i++) {
-		struct ppa_addr ppa = ppa_list[i];
 		struct pblk_line *line;
 
 		line = &pblk->lines[pblk_ppa_to_line(ppa)];
 		kref_put(&line->ref, pblk_line_put_wq);
-	}
+}
+
+static void pblk_read_put_line(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct ppa_addr *ppa_list;
+	int i;
+
+	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+
+	for (i = 0; i < rqd->nr_ppas; i++)
+		__pblk_read_put_line(pblk, ppa_list[i]);
 }
 
 static void pblk_end_user_read(struct bio *bio)
@@ -208,7 +211,7 @@ static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
 		bio_put(int_bio);
 
 	if (put_line)
-		pblk_read_put_rqd_kref(pblk, rqd);
+		pblk_read_put_line(pblk, rqd);
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	atomic_long_add(rqd->nr_ppas, &pblk->sync_reads);
-- 
2.11.0
