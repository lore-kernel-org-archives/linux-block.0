Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55531C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304F320883
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfCVOwn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:52:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:12641 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728733AbfCVOwn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:52:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 07:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="216593446"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2019 07:52:41 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 11/16] lightnvm: pblk: fix update line wp in OOB recovery
Date:   Fri, 22 Mar 2019 15:48:38 +0100
Message-Id: <20190322144843.9602-12-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190322144843.9602-1-igor.j.konopko@intel.com>
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Javier González <javier@javigon.com>
---
 drivers/lightnvm/pblk-recovery.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 65916f0..4e8f382 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -93,10 +93,24 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
 static void pblk_update_line_wp(struct pblk *pblk, struct pblk_line *line,
 				u64 written_secs)
 {
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	int i;
 
 	for (i = 0; i < written_secs; i += pblk->min_write_pgs)
-		pblk_alloc_page(pblk, line, pblk->min_write_pgs);
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

