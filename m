Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF83C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E7B2184E
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCNQIG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:08:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:11391 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfCNQIG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:08:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:08:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="134073017"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 09:08:04 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 07/18] lightnvm: pblk: wait for inflight IOs in recovery
Date:   Thu, 14 Mar 2019 17:04:17 +0100
Message-Id: <20190314160428.3559-8-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190314160428.3559-1-igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch changes the behaviour of recovery padding in order to
support a case, when some IOs were already submitted to the drive and
some next one are not submitted due to error returned.

Currently in case of errors we simply exit the pad function without
waiting for inflight IOs, which leads to panic on inflight IOs
completion.

After the changes we always wait for all the inflight IOs before
exiting the function.

Also, since NVMe has an internal timeout per IO, there is no need to
introduce additonal one here.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-recovery.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index ba1691d..73d5ead 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -200,7 +200,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
 	if (rq_ppas < pblk->min_write_pgs) {
 		pblk_err(pblk, "corrupted pad line %d\n", line->id);
-		goto fail_free_pad;
+		goto fail_complete;
 	}
 
 	rq_len = rq_ppas * geo->csecs;
@@ -209,7 +209,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 						PBLK_VMALLOC_META, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
-		goto fail_free_pad;
+		goto fail_complete;
 	}
 
 	bio->bi_iter.bi_sector = 0; /* internal bio */
@@ -218,8 +218,11 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	rqd = pblk_alloc_rqd(pblk, PBLK_WRITE_INT);
 
 	ret = pblk_alloc_rqd_meta(pblk, rqd);
-	if (ret)
-		goto fail_free_rqd;
+	if (ret) {
+		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
+		bio_put(bio);
+		goto fail_complete;
+	}
 
 	rqd->bio = bio;
 	rqd->opcode = NVM_OP_PWRITE;
@@ -266,7 +269,10 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	if (ret) {
 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
 		pblk_up_chunk(pblk, rqd->ppa_list[0]);
-		goto fail_free_rqd;
+		kref_put(&pad_rq->ref, pblk_recov_complete);
+		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
+		bio_put(bio);
+		goto fail_complete;
 	}
 
 	left_line_ppas -= rq_ppas;
@@ -274,13 +280,9 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	if (left_ppas && left_line_ppas)
 		goto next_pad_rq;
 
+fail_complete:
 	kref_put(&pad_rq->ref, pblk_recov_complete);
-
-	if (!wait_for_completion_io_timeout(&pad_rq->wait,
-				msecs_to_jiffies(PBLK_COMMAND_TIMEOUT_MS))) {
-		pblk_err(pblk, "pad write timed out\n");
-		ret = -ETIME;
-	}
+	wait_for_completion(&pad_rq->wait);
 
 	if (!pblk_line_is_full(line))
 		pblk_err(pblk, "corrupted padded line: %d\n", line->id);
@@ -289,14 +291,6 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 free_rq:
 	kfree(pad_rq);
 	return ret;
-
-fail_free_rqd:
-	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
-	bio_put(bio);
-fail_free_pad:
-	kfree(pad_rq);
-	vfree(data);
-	return ret;
 }
 
 static int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
-- 
2.9.5

