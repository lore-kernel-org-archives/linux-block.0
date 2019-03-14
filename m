Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA8CC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C752184E
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfCNQH1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:07:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:49846 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQH1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:07:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="134072837"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 09:07:25 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 02/18] lightnvm: pblk: warn when there are opened chunks
Date:   Thu, 14 Mar 2019 17:04:12 +0100
Message-Id: <20190314160428.3559-3-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190314160428.3559-1-igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of factory pblk init, we might have a situation when there are
some opened chunks. Based on OCSSD spec we are not allowed to transform
chunks from the open state directly to the free state, so such a reset
can lead to IO error (even that most of the controller will allow for
for such a operation anyway), so we would like to warn users about such
a situation at least.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-init.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 1e227a0..b7845f6 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -712,7 +712,7 @@ static int pblk_set_provision(struct pblk *pblk, int nr_free_chks)
 }
 
 static int pblk_setup_line_meta_chk(struct pblk *pblk, struct pblk_line *line,
-				   struct nvm_chk_meta *meta)
+				   struct nvm_chk_meta *meta, int *opened)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
@@ -748,6 +748,9 @@ static int pblk_setup_line_meta_chk(struct pblk *pblk, struct pblk_line *line,
 			continue;
 		}
 
+		if (chunk->state & NVM_CHK_ST_OPEN)
+			(*opened)++;
+
 		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
 			continue;
 
@@ -759,7 +762,7 @@ static int pblk_setup_line_meta_chk(struct pblk *pblk, struct pblk_line *line,
 }
 
 static long pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
-				 void *chunk_meta, int line_id)
+				 void *chunk_meta, int line_id, int *opened)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
@@ -773,7 +776,7 @@ static long pblk_setup_line_meta(struct pblk *pblk, struct pblk_line *line,
 	line->vsc = &l_mg->vsc_list[line_id];
 	spin_lock_init(&line->lock);
 
-	nr_bad_chks = pblk_setup_line_meta_chk(pblk, line, chunk_meta);
+	nr_bad_chks = pblk_setup_line_meta_chk(pblk, line, chunk_meta, opened);
 
 	chk_in_line = lm->blk_per_line - nr_bad_chks;
 	if (nr_bad_chks < 0 || nr_bad_chks > lm->blk_per_line ||
@@ -1019,12 +1022,12 @@ static int pblk_line_meta_init(struct pblk *pblk)
 	return 0;
 }
 
-static int pblk_lines_init(struct pblk *pblk)
+static int pblk_lines_init(struct pblk *pblk, bool factory)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line *line;
 	void *chunk_meta;
-	int nr_free_chks = 0;
+	int nr_free_chks = 0, nr_opened_chks = 0;
 	int i, ret;
 
 	ret = pblk_line_meta_init(pblk);
@@ -1059,7 +1062,8 @@ static int pblk_lines_init(struct pblk *pblk)
 		if (ret)
 			goto fail_free_lines;
 
-		nr_free_chks += pblk_setup_line_meta(pblk, line, chunk_meta, i);
+		nr_free_chks += pblk_setup_line_meta(pblk, line, chunk_meta, i,
+							&nr_opened_chks);
 
 		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
 								line->state);
@@ -1071,6 +1075,11 @@ static int pblk_lines_init(struct pblk *pblk)
 		goto fail_free_lines;
 	}
 
+	if (factory && nr_opened_chks) {
+		pblk_warn(pblk, "%d opened chunks during factory creation\n",
+				nr_opened_chks);
+	}
+
 	ret = pblk_set_provision(pblk, nr_free_chks);
 	if (ret)
 		goto fail_free_lines;
@@ -1235,7 +1244,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 		goto fail;
 	}
 
-	ret = pblk_lines_init(pblk);
+	ret = pblk_lines_init(pblk, flags & NVM_TARGET_FACTORY);
 	if (ret) {
 		pblk_err(pblk, "could not initialize lines\n");
 		goto fail_free_core;
-- 
2.9.5

