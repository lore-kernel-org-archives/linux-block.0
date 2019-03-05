Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCC1C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB8F20848
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 13:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfCENyY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:54:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:64693 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfCENyX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Mar 2019 08:54:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 05:54:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="129161567"
Received: from gklab-107-059.igk.intel.com ([10.102.107.59])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2019 05:54:22 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io, javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
Subject: [PATCH v2 5/8] lightnvm: pblk: Cleanly fail when there is not enough memory
Date:   Tue,  5 Mar 2019 14:51:17 +0100
Message-Id: <20190305135120.29284-6-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190305135120.29284-1-igor.j.konopko@intel.com>
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

L2P table can be huge in many cases, since it typically requires 1GB
of DRAM for 1TB of drive. When there is not enough memory available,
OOM killer turns on and kills random processes, which can be very
annoying for users.

This patch changes the flag for L2P table allocation on order to handle
this situation in more user friendly way.

GFP_KERNEL and __GPF_HIGHMEM are default flags used in parameterless
vmalloc() calls, so they are also keeped in that patch. Additionally
__GFP_NOWARN flag is added in order to hide very long dmesg warn in
case of the allocation failures. The most important flag introduced
in that patch is __GFP_RETRY_MAYFAIL, which would cause allocator
to try use free memory and if not available to drop caches, but not
to run OOM killer.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
---
 drivers/lightnvm/pblk-init.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index f4b6d8f2..97b4c6e 100644
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
2.9.5

