Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFD1C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979EA20848
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfCENyE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:54:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:62720 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfCENyD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Mar 2019 08:54:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 05:54:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="129161519"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2019 05:54:02 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 1/8] lightnvm: pblk: Gracefully handle GC vmalloc fail
Date:   Tue,  5 Mar 2019 14:51:13 +0100
Message-Id: <20190305135120.29284-2-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190305135120.29284-1-igor.j.konopko@intel.com>
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently when we fail on gc rq data allocation we simply skip the data
which we wanted to move and finally move the line to free state and
lose that data due to that. This patch move the data allocation to some
earlier phase of GC, where we can still fail gracefully by moving line
back to closed state.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
---
 drivers/lightnvm/pblk-gc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 65692e6..ea9f392 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -84,8 +84,6 @@ static void pblk_gc_line_ws(struct work_struct *work)
 	struct pblk_line_ws *gc_rq_ws = container_of(work,
 						struct pblk_line_ws, ws);
 	struct pblk *pblk = gc_rq_ws->pblk;
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
 	struct pblk_gc *gc = &pblk->gc;
 	struct pblk_line *line = gc_rq_ws->line;
 	struct pblk_gc_rq *gc_rq = gc_rq_ws->priv;
@@ -93,13 +91,6 @@ static void pblk_gc_line_ws(struct work_struct *work)
 
 	up(&gc->gc_sem);
 
-	gc_rq->data = vmalloc(array_size(gc_rq->nr_secs, geo->csecs));
-	if (!gc_rq->data) {
-		pblk_err(pblk, "could not GC line:%d (%d/%d)\n",
-					line->id, *line->vsc, gc_rq->nr_secs);
-		goto out;
-	}
-
 	/* Read from GC victim block */
 	ret = pblk_submit_read_gc(pblk, gc_rq);
 	if (ret) {
@@ -189,6 +180,8 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 	struct pblk_line *line = line_ws->line;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
 	struct pblk_gc *gc = &pblk->gc;
 	struct pblk_line_ws *gc_rq_ws;
 	struct pblk_gc_rq *gc_rq;
@@ -247,9 +240,13 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 	gc_rq->nr_secs = nr_secs;
 	gc_rq->line = line;
 
+	gc_rq->data = vmalloc(array_size(gc_rq->nr_secs, geo->csecs));
+	if (!gc_rq->data)
+		goto fail_free_gc_rq;
+
 	gc_rq_ws = kmalloc(sizeof(struct pblk_line_ws), GFP_KERNEL);
 	if (!gc_rq_ws)
-		goto fail_free_gc_rq;
+		goto fail_free_gc_data;
 
 	gc_rq_ws->pblk = pblk;
 	gc_rq_ws->line = line;
@@ -281,6 +278,8 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
 
 	return;
 
+fail_free_gc_data:
+	vfree(gc_rq->data);
 fail_free_gc_rq:
 	kfree(gc_rq);
 fail_free_lba_list:
-- 
2.9.5

