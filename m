Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BEBC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 12:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE8620449
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 12:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfC0MmB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:42:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:33640 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfC0MmB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 08:42:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 05:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,276,1549958400"; 
   d="scan'208";a="137680433"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2019 05:41:59 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v3 05/10] lightnvm: pblk: wait for inflight IOs in recovery
Date:   Wed, 27 Mar 2019 13:38:56 +0100
Message-Id: <20190327123901.12323-6-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190327123901.12323-1-igor.j.konopko@intel.com>
References: <20190327123901.12323-1-igor.j.konopko@intel.com>
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

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-recovery.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 9318f7a..6765d7c 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -208,7 +208,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
 	if (rq_ppas < pblk->min_write_pgs) {
 		pblk_err(pblk, "corrupted pad line %d\n", line->id);
-		goto fail_free_pad;
+		goto fail_complete;
 	}
 
 	rq_len = rq_ppas * geo->csecs;
@@ -217,7 +217,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 						PBLK_VMALLOC_META, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
-		goto fail_free_pad;
+		goto fail_complete;
 	}
 
 	bio->bi_iter.bi_sector = 0; /* internal bio */
@@ -226,8 +226,11 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
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
@@ -274,7 +277,10 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
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
@@ -282,6 +288,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 	if (left_ppas && left_line_ppas)
 		goto next_pad_rq;
 
+fail_complete:
 	kref_put(&pad_rq->ref, pblk_recov_complete);
 
 	if (!wait_for_completion_io_timeout(&pad_rq->wait,
@@ -297,14 +304,6 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
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

