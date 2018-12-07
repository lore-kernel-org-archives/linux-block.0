Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33499C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 08:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F227620892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 08:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F227620892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeLGIdC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:33:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:54436 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbeLGIdC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Dec 2018 03:33:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 00:32:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="105602416"
Received: from gklab-106-154.igk.intel.com ([10.102.106.154])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2018 00:33:00 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com, igor.j.konopko@intel.com
Subject: [PATCH v2 1/2] lightnvm: pblk: Do not overwrite ppa list with meta list
Date:   Fri,  7 Dec 2018 09:25:49 +0100
Message-Id: <20181207082550.10409-1-igor.j.konopko@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently when using PBLK with 0 sized metadata both ppa list
and meta list points to the same memory since pblk_dma_meta_size()
returns 0 in that case.

This commit fix that issue by ensuring that pblk_dma_meta_size()
always returns space equal to sizeof(struct pblk_sec_meta) and thus
ppa list and meta list points to different memory address.

Even that in that case drive does not really care about meta_list
pointer, this is the easiest way to fix that issue without introducing
changes in many places in the code just for 0 sized metadata case.

The same approach needs to be also done for pblk_get_sec_meta()
since we also cannot point to the same memory address in meta buffer
when we are using it for pblk recovery process

Reported-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index bc40b1381ff6..85e38ed62f85 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1388,12 +1388,15 @@ static inline unsigned int pblk_get_min_chks(struct pblk *pblk)
 static inline struct pblk_sec_meta *pblk_get_meta(struct pblk *pblk,
 							 void *meta, int index)
 {
-	return meta + pblk->oob_meta_size * index;
+	return meta +
+	       max_t(int, sizeof(struct pblk_sec_meta), pblk->oob_meta_size)
+	       * index;
 }
 
 static inline int pblk_dma_meta_size(struct pblk *pblk)
 {
-	return pblk->oob_meta_size * NVM_MAX_VLBA;
+	return max_t(int, sizeof(struct pblk_sec_meta), pblk->oob_meta_size)
+	       * NVM_MAX_VLBA;
 }
 
 static inline int pblk_is_oob_meta_supported(struct pblk *pblk)
-- 
2.17.1

