Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B8EC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2582A214C1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2582A214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbeLFPva (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:51:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:54119 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeLFPva (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 10:51:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 07:51:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,322,1539673200"; 
   d="scan'208";a="301597181"
Received: from gklab-106-154.igk.intel.com ([10.102.106.154])
  by fmsmga005.fm.intel.com with ESMTP; 06 Dec 2018 07:51:28 -0800
From:   Igor Konopko <igor.j.konopko@intel.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        hans.holmberg@cnexlabs.com, igor.j.konopko@intel.com
Subject: [PATCH 1/2] lightnvm: pblk: Do not overwrite ppa list with meta list
Date:   Thu,  6 Dec 2018 16:45:58 +0100
Message-Id: <20181206154559.5642-1-igor.j.konopko@intel.com>
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

Reported-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
---
 drivers/lightnvm/pblk.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index bc40b1381ff6..e5c9ff2bf0da 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1393,7 +1393,8 @@ static inline struct pblk_sec_meta *pblk_get_meta(struct pblk *pblk,
 
 static inline int pblk_dma_meta_size(struct pblk *pblk)
 {
-	return pblk->oob_meta_size * NVM_MAX_VLBA;
+	return max_t(int, sizeof(struct pblk_sec_meta), pblk->oob_meta_size)
+		* NVM_MAX_VLBA;
 }
 
 static inline int pblk_is_oob_meta_supported(struct pblk *pblk)
-- 
2.17.1

