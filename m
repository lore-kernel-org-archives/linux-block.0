Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3027AC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D002184E
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfCNQJM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:09:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:11618 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQJM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:09:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 09:09:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="134073314"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 09:09:10 -0700
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 15/18] lightnvm: pblk: fix in case of lack of lines
Date:   Thu, 14 Mar 2019 17:04:25 +0100
Message-Id: <20190314160428.3559-16-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190314160428.3559-1-igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case when mapping fails (called from writer thread) due to lack of
lines, currently we are calling pblk_pipeline_stop(), which waits
for pending write IOs, so it will lead to the deadlock. Switching
to __pblk_pipeline_stop() in that case instead will fix that.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 5408e32..afc10306 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -46,7 +46,7 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
 		pblk_line_close_meta(pblk, prev_line);
 
 		if (!line) {
-			pblk_pipeline_stop(pblk);
+			__pblk_pipeline_stop(pblk);
 			return -ENOSPC;
 		}
 
-- 
2.9.5

