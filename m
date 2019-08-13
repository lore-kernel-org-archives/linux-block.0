Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCF0C32750
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 21:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993D0206C2
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 21:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfHMVmI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:42:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:23252 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfHMVmI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 17:42:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:42:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="176328358"
Received: from unknown (HELO revanth-X299-AORUS-Gaming-3-Pro.lm.intel.com) ([10.232.116.91])
  by fmsmga008.fm.intel.com with ESMTP; 13 Aug 2019 14:42:07 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH 3/3] block: sed-opal: OPAL_METHOD_LENGTH defined twice
Date:   Tue, 13 Aug 2019 15:43:40 -0600
Message-Id: <20190813214340.15533-4-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813214340.15533-1-revanth.rajashekar@intel.com>
References: <20190813214340.15533-1-revanth.rajashekar@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
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

