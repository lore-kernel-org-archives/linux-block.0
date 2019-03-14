Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90ABC10F06
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99632184E
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfCNQHw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:07:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:49878 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfCNQHw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:07:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="134072905"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 09:07:41 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 04/18] lightnvm: pblk: OOB recovery for closed chunks fix
Date:   Thu, 14 Mar 2019 17:04:14 +0100
Message-Id: <20190314160428.3559-5-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190314160428.3559-1-igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of OOB recovery, when some of the chunks are in closed state,
we are calculating number of written sectors in line incorrectly,
because we are always counting chunk WP, which for closed chunks
does not longer reflects written sectors in particular chunks. This
patch for such a chunks takes clba field instead.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-recovery.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 83b467b..bcd3633 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -101,6 +101,8 @@ static void pblk_update_line_wp(struct pblk *pblk, struct pblk_line *line,
 
 static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
 {
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
 	int nr_bb = bitmap_weight(line->blk_bitmap, lm->blk_per_line);
 	u64 written_secs = 0;
@@ -113,7 +115,11 @@ static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
 		if (chunk->state & NVM_CHK_ST_OFFLINE)
 			continue;
 
-		written_secs += chunk->wp;
+		if (chunk->state & NVM_CHK_ST_OPEN)
+			written_secs += chunk->wp;
+		else if (chunk->state & NVM_CHK_ST_CLOSED)
+			written_secs += geo->clba;
+
 		valid_chunks++;
 	}
 
-- 
2.9.5

