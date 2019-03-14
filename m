Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB723C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D50C2184C
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfCNQHw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:07:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:23562 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfCNQHv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:07:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="134072921"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 09:07:49 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 05/18] lightnvm: pblk: propagate errors when reading meta
Date:   Thu, 14 Mar 2019 17:04:15 +0100
Message-Id: <20190314160428.3559-6-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190314160428.3559-1-igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently when smeta/emeta/oob is read errors are not always propagated
correctly. This patch changes that behaviour and propagates all the
error codes except of high ecc read warning status.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-core.c     | 9 +++++++--
 drivers/lightnvm/pblk-recovery.c | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 39280c1..38e26fe 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -761,8 +761,10 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
 
 	atomic_dec(&pblk->inflight_io);
 
-	if (rqd.error)
+	if (rqd.error && rqd.error != NVM_RSP_WARN_HIGHECC) {
 		pblk_log_read_err(pblk, &rqd);
+		ret = -EIO;
+	}
 
 clear_rqd:
 	pblk_free_rqd_meta(pblk, &rqd);
@@ -916,8 +918,11 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 
 	atomic_dec(&pblk->inflight_io);
 
-	if (rqd.error)
+	if (rqd.error && rqd.error != NVM_RSP_WARN_HIGHECC) {
 		pblk_log_read_err(pblk, &rqd);
+		ret = -EIO;
+		goto free_rqd_dma;
+	}
 
 	emeta_buf += rq_len;
 	left_ppas -= rq_ppas;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index bcd3633..688fdeb 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -450,7 +450,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	atomic_dec(&pblk->inflight_io);
 
 	/* If a read fails, do a best effort by padding the line and retrying */
-	if (rqd->error) {
+	if (rqd->error && rqd->error != NVM_RSP_WARN_HIGHECC) {
 		int pad_distance, ret;
 
 		if (padded) {
-- 
2.9.5

