Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B4BC10F13
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 10:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A79206BA
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 10:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfDPKTg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:19:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:15522 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbfDPKTg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 06:19:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 03:19:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="337927047"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2019 03:19:30 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v4 3/7] lightnvm: pblk: recover only written metadata
Date:   Tue, 16 Apr 2019 12:16:44 +0200
Message-Id: <20190416101648.10045-4-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190416101648.10045-1-igor.j.konopko@intel.com>
References: <20190416101648.10045-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch ensures that smeta was fully written before even
trying to read it based on chunk table state and write pointer.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-recovery.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 865fe31..a9085b0 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -655,10 +655,12 @@ static int pblk_line_was_written(struct pblk_line *line,
 	bppa = pblk->luns[smeta_blk].bppa;
 	chunk = &line->chks[pblk_ppa_to_pos(geo, bppa)];
 
-	if (chunk->state & NVM_CHK_ST_FREE)
-		return 0;
+	if (chunk->state & NVM_CHK_ST_CLOSED ||
+	    (chunk->state & NVM_CHK_ST_OPEN
+	     && chunk->wp >= lm->smeta_sec))
+		return 1;
 
-	return 1;
+	return 0;
 }
 
 static bool pblk_line_is_open(struct pblk *pblk, struct pblk_line *line)
-- 
2.9.5

