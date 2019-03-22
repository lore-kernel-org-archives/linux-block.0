Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530ABC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D81520883
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfCVOwu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:52:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:5341 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbfCVOwu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:52:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 07:52:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="216593452"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2019 07:52:46 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 12/16] lightnvm: pblk: do not read OOB from emeta region
Date:   Fri, 22 Mar 2019 15:48:39 +0100
Message-Id: <20190322144843.9602-13-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190322144843.9602-1-igor.j.konopko@intel.com>
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Emeta does not have corresponding OOB metadata mapping valid, so there
is no need to try to recover L2P mapping from it.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-recovery.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 4e8f382..74e5b17 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -479,6 +479,15 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 		goto retry_rq;
 	}
 
+	if (paddr >= line->emeta_ssec) {
+		/*
+		 * We reach emeta region and we don't want
+		 * to recover oob from emeta region.
+		 */
+		bio_put(bio);
+		goto completed;
+	}
+
 	pblk_get_packed_meta(pblk, rqd);
 	bio_put(bio);
 
@@ -499,6 +508,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	if (left_ppas > 0)
 		goto next_rq;
 
+completed:
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	WARN_ON(padded && !pblk_line_is_full(line));
 #endif
-- 
2.9.5

