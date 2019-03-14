Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F36C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BE12184C
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfCNQH7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:07:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:49898 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfCNQH7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:07:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:07:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="134072987"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 09:07:56 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 06/18] lightnvm: pblk: recover only written metadata
Date:   Thu, 14 Mar 2019 17:04:16 +0100
Message-Id: <20190314160428.3559-7-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190314160428.3559-1-igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch ensures that smeta/emeta was written properly before even
trying to read it based on chunk table state and write pointer.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-recovery.c | 43 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 688fdeb..ba1691d 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -653,8 +653,42 @@ static int pblk_line_was_written(struct pblk_line *line,
 	bppa = pblk->luns[smeta_blk].bppa;
 	chunk = &line->chks[pblk_ppa_to_pos(geo, bppa)];
 
-	if (chunk->state & NVM_CHK_ST_FREE)
-		return 0;
+	if (chunk->state & NVM_CHK_ST_CLOSED ||
+	    (chunk->state & NVM_CHK_ST_OPEN
+	     && chunk->wp >= lm->smeta_sec))
+		return 1;
+
+	return 0;
+}
+
+static int pblk_line_was_emeta_written(struct pblk_line *line,
+				       struct pblk *pblk)
+{
+
+	struct pblk_line_meta *lm = &pblk->lm;
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct nvm_chk_meta *chunk;
+	struct ppa_addr ppa;
+	int i, pos;
+	int min = pblk->min_write_pgs;
+	u64 paddr = line->emeta_ssec;
+
+	for (i = 0; i < lm->emeta_sec[0]; i++, paddr++) {
+		ppa = addr_to_gen_ppa(pblk, paddr, line->id);
+		pos = pblk_ppa_to_pos(geo, ppa);
+		while (test_bit(pos, line->blk_bitmap)) {
+			paddr += min;
+			ppa = addr_to_gen_ppa(pblk, paddr, line->id);
+			pos = pblk_ppa_to_pos(geo, ppa);
+		}
+		chunk = &line->chks[pos];
+
+		if (!(chunk->state & NVM_CHK_ST_CLOSED ||
+		    (chunk->state & NVM_CHK_ST_OPEN
+		     && chunk->wp > ppa.m.sec)))
+			return 0;
+	}
 
 	return 1;
 }
@@ -788,6 +822,11 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			goto next;
 		}
 
+		if (!pblk_line_was_emeta_written(line, pblk)) {
+			pblk_recov_l2p_from_oob(pblk, line);
+			goto next;
+		}
+
 		if (pblk_line_emeta_read(pblk, line, line->emeta->buf)) {
 			pblk_recov_l2p_from_oob(pblk, line);
 			goto next;
-- 
2.9.5

