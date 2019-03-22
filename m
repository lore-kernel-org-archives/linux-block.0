Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8959C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A931020883
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfCVOvv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:51:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:54170 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbfCVOvv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:51:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 07:51:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="216593223"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2019 07:51:48 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 04/16] lightnvm: pblk: OOB recovery for closed chunks fix
Date:   Fri, 22 Mar 2019 15:48:31 +0100
Message-Id: <20190322144843.9602-5-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190322144843.9602-1-igor.j.konopko@intel.com>
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of OOB recovery, when some of the chunks are in closed state,
we are calculating number of written sectors in line incorrectly,
because we are always counting chunk WP, which for closed chunks
does not longer reflects written sectors in particular chunk. Based on
OCSSD 2.0 spec WP for closed chunks is equal to SLBA + NLB and here we
need only NLB (clba in code) value for calculation. This patch for such
a chunks takes clba field instead.

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

