Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23971C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12B42184E
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfCNQIh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:08:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:25320 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfCNQIg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:08:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:08:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="134073177"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 09:08:34 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 11/18] lightnvm: pblk: fix update line wp in OOB recovery
Date:   Thu, 14 Mar 2019 17:04:21 +0100
Message-Id: <20190314160428.3559-12-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190314160428.3559-1-igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of OOB recovery, we can hit the scenario when all the data in
line were written and some part of emeta was written too. In such
a case pblk_update_line_wp() function will call pblk_alloc_page()
function which will case to set left_msecs to value below zero
(since this field does not track emeta region) and thus will lead to
multiple kernel warnings. This patch fixes that issue.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-recovery.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 73d5ead..4764596 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -93,10 +93,24 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
 static void pblk_update_line_wp(struct pblk *pblk, struct pblk_line *line,
 				u64 written_secs)
 {
-	int i;
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+	int i = 0;
 
-	for (i = 0; i < written_secs; i += pblk->min_write_pgs)
-		pblk_alloc_page(pblk, line, pblk->min_write_pgs);
+	for (; i < written_secs; i += pblk->min_write_pgs)
+		__pblk_alloc_page(pblk, line, pblk->min_write_pgs);
+
+	spin_lock(&l_mg->free_lock);
+	if (written_secs > line->left_msecs) {
+		/*
+		 * We have all data sectors written
+		 * and some emeta sectors written too.
+		 */
+		line->left_msecs = 0;
+	} else {
+		/* We have only some data sectors written. */
+		line->left_msecs -= written_secs;
+	}
+	spin_unlock(&l_mg->free_lock);
 }
 
 static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
-- 
2.9.5

