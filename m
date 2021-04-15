Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CD6C433B4
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 14:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C1E613C0
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 14:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhDOOW4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 10:22:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:63233 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDOOWx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 10:22:53 -0400
IronPort-SDR: mrBXYCiDd6dRUG+e4YQaMDMGc5xu9AxxKezIS0vdHtv7CaCK5GtsnwhT9gz3FxuoNjS4UimBxP
 MuVs5WedLRkw==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194887836"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="194887836"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 07:22:30 -0700
IronPort-SDR: sEfe0e2ntfJe/dGEupn1dyAC04ikRLO/cPwNTV8GqIWdBCXJszRXKVmogNHhHCiePGD0XkO9PB
 lWAdC2KtWtfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="615654923"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 15 Apr 2021 07:22:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BE8E0BA; Thu, 15 Apr 2021 17:22:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matias Bjorling <mb@lightnvm.io>
Subject: [PATCH v1 1/1] lightnvm: pblk: Import GUID before use
Date:   Thu, 15 Apr 2021 17:22:27 +0300
Message-Id: <20210415142227.84408-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Strictly speaking the comparison between guid_t and raw buffer
is not correct. Import GUID to variable of guid_t type and then
compare.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/lightnvm/pblk-recovery.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 0e6f0c76e930..81b1b751d8c4 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -661,6 +661,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 	int meta_line;
 	int i, valid_uuid = 0;
 	LIST_HEAD(recov_list);
+	guid_t guid;
 
 	/* TODO: Implement FTL snapshot */
 
@@ -704,14 +705,15 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			return ERR_PTR(-EINVAL);
 		}
 
+		import_guid(&guid, smeta_buf->header.uuid);
+
 		/* The first valid instance uuid is used for initialization */
 		if (!valid_uuid) {
-			import_guid(&pblk->instance_uuid, smeta_buf->header.uuid);
+			guid_copy(&pblk->instance_uuid, &guid);
 			valid_uuid = 1;
 		}
 
-		if (!guid_equal(&pblk->instance_uuid,
-				(guid_t *)&smeta_buf->header.uuid)) {
+		if (!guid_equal(&pblk->instance_uuid, &guid)) {
 			pblk_debug(pblk, "ignore line %u due to uuid mismatch\n",
 					i);
 			continue;
-- 
2.30.2

