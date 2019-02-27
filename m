Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B350AC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BC12183F
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 17:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfB0RSC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:18:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:25365 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfB0RSB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 12:18:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 09:18:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="129819491"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by orsmga003.jf.intel.com with ESMTP; 27 Feb 2019 09:17:59 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH 07/13] lightnvm: pblk: Cleanly fail when there is not enough memory
Date:   Wed, 27 Feb 2019 18:14:36 +0100
Message-Id: <20190227171442.11853-8-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190227171442.11853-1-igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

L2P table can be huge in many cases, since
it typically requires 1GB of DRAM for 1TB
of drive. When there is not enough memory
available, OOM killer turns on and kills
random processes, which can be very annoying
for users. This patch changes the flag for
L2P table allocation on order to handle this
situation in more user friendly way

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-init.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8b643d0bffae..e553105b7ba1 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -164,9 +164,14 @@ static int pblk_l2p_init(struct pblk *pblk, bool factory_init)
 	int ret = 0;
 
 	map_size = pblk_trans_map_size(pblk);
-	pblk->trans_map = vmalloc(map_size);
-	if (!pblk->trans_map)
+	pblk->trans_map = __vmalloc(map_size, GFP_KERNEL | __GFP_NOWARN
+					| __GFP_RETRY_MAYFAIL | __GFP_HIGHMEM,
+					PAGE_KERNEL);
+	if (!pblk->trans_map) {
+		pblk_err(pblk, "failed to allocate L2P (need %ld of memory)\n",
+				map_size);
 		return -ENOMEM;
+	}
 
 	pblk_ppa_set_empty(&ppa);
 
-- 
2.17.1

