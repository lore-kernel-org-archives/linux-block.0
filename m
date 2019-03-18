Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB41C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1C620872
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfCROiq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:38:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:22183 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfCROip (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 10:38:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP; 18 Mar 2019 07:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="135022075"
Received: from mdziegie-mobl.ger.corp.intel.com (HELO localhost.igk.intel.com) ([10.237.142.141])
  by orsmga003.jf.intel.com with ESMTP; 18 Mar 2019 07:38:43 -0700
From:   Marcin Dziegielewski <marcin.dziegielewski@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, marcin.dziegielewski@intel.com,
        igor.j.konopko@intel.com
Subject: [PATCH] lightnvm: pblk: do not pad line when there are no left_msecs
Date:   Mon, 18 Mar 2019 15:38:37 +0100
Message-Id: <1552919917-12846-1-git-send-email-marcin.dziegielewski@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When there are no left msecs in line, despite it, we are
trying to pad line. In such case, pblk_recov_pad_line function
returns error, we don't write end meta to this line and
in consequence we need to scan whole line on next pblk load.

This patch fixes this issue, now when there is no left_msecs
we skip padding, write end meta and return success.

Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
---
 drivers/lightnvm/pblk-recovery.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 83b467b..b9d7d7f 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -880,10 +880,12 @@ int pblk_recov_pad(struct pblk *pblk)
 	left_msecs = line->left_msecs;
 	spin_unlock(&l_mg->free_lock);
 
-	ret = pblk_recov_pad_line(pblk, line, left_msecs);
-	if (ret) {
-		pblk_err(pblk, "tear down padding failed (%d)\n", ret);
-		return ret;
+	if (left_msecs) {
+		ret = pblk_recov_pad_line(pblk, line, left_msecs);
+		if (ret) {
+			pblk_err(pblk, "tear down padding failed (%d)\n", ret);
+			return ret;
+		}
 	}
 
 	pblk_line_close_meta(pblk, line);
-- 
1.8.3.1

