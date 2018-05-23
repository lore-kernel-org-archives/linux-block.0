Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:63784 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933306AbeEWPRi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 May 2018 11:17:38 -0400
From: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        Igor Konopko <igor.j.konopko@intel.com>
Subject: [PATCH 2/2] lightnvm: pblk: handle case when device expose mw_cunits equal to 0
Date: Wed, 23 May 2018 17:17:20 +0200
Message-Id: <1527088640-13062-3-git-send-email-marcin.dziegielewski@intel.com>
In-Reply-To: <1527088640-13062-1-git-send-email-marcin.dziegielewski@intel.com>
References: <1527088640-13062-1-git-send-email-marcin.dziegielewski@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Some devices can expose mw_cunits equal to 0, it can cause creation of too
small write buffer and in consecuence performance drop on write workloads.

To handle that, in such case we are using default value for MLC and
beacause it covers both 1.2 and 2.0 OC specification, setting up mw_cunits
in nvme_nvm_setup_12 function isn't longer necessary.

Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk-init.c | 10 +++++++++-
 drivers/nvme/host/lightnvm.c |  1 -
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 9a7213e..42190de 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -366,7 +366,15 @@ static int pblk_core_init(struct pblk *pblk)
 	atomic64_set(&pblk->nr_flush, 0);
 	pblk->nr_flush_rst = 0;
 
-	pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
+	if (geo->mw_cunits) {
+		pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
+	} else {
+		pblk->pgs_in_buffer = (geo->ws_opt << 3) * geo->all_luns;
+		/*
+		 * Some devices can expose mw_cunits equal to 0, so let's use
+		 * here default safe value for MLC.
+		 */
+	}
 
 	pblk->min_write_pgs = geo->ws_opt * (geo->csecs / PAGE_SIZE);
 	max_write_ppas = pblk->min_write_pgs * geo->all_luns;
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 41279da..c747792 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -338,7 +338,6 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 
 	geo->ws_min = sec_per_pg;
 	geo->ws_opt = sec_per_pg;
-	geo->mw_cunits = geo->ws_opt << 3;	/* default to MLC safe values */
 
 	/* Do not impose values for maximum number of open blocks as it is
 	 * unspecified in 1.2. Users of 1.2 must be aware of this and eventually
-- 
1.8.3.1
