Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDE3C3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 15:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080E322CE3
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 15:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfHTP3F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:29:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:61432 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTP3F (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 11:29:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 08:29:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="202710960"
Received: from unknown (HELO revanth-X299-AORUS-Gaming-3-Pro.lm.intel.com) ([10.232.116.91])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2019 08:29:04 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH v3 3/3] block: sed-opal: Removed duplicate OPAL_METHOD_LENGTH definition
Date:   Tue, 20 Aug 2019 09:30:51 -0600
Message-Id: <20190820153051.24704-4-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820153051.24704-1-revanth.rajashekar@intel.com>
References: <20190820153051.24704-1-revanth.rajashekar@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/opal_proto.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index 562b78f40824..5532412d567c 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -119,8 +119,6 @@ enum opal_uid {
 	OPAL_UID_HEXFF,
 };

-#define OPAL_METHOD_LENGTH 8
-
 /* Enum for indexing the OPALMETHOD array */
 enum opal_method {
 	OPAL_PROPERTIES,
--
2.17.1

