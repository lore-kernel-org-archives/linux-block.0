Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8696CC3F2D1
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 19:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58289208C3
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 19:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgCCTTK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:19:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:62948 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730009AbgCCTTK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Mar 2020 14:19:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 11:19:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="229040957"
Received: from linux-machine.lm.intel.com ([10.232.116.103])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2020 11:19:09 -0800
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        =?UTF-8?q?Andrzej=20Jakowski=C2=BB?= <andrzej.jakowski@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: [PATCH v2] block: sed-opal: Change the check condition for regular session validity
Date:   Tue,  3 Mar 2020 12:17:00 -0700
Message-Id: <20200303191700.66667-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch changes the check condition for the validity/authentication
of the session.

1. The Host Session Number(HSN) in the response should match the HSN for
   the session.
2. The TPER Session Number(TSN) can never be less than 4096 for a regular
   session.

Reference:
Section 3.2.2.1   of https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Opal_SSC_Application_Note_1-00_1-00-Final.pdf
Section 3.3.7.1.1 of https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Architecture_Core_Spec_v2.01_r1.00.pdf

Co-developed-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---

Changes in v2:
	Rename definition RSVD_TPER_SESSION_NUM -> FIRST_TPER_SESSION_NUM

 block/opal_proto.h | 1 +
 block/sed-opal.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index 325cbba2465f..b486b3ec7dc4 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -36,6 +36,7 @@ enum opal_response_token {

 #define DTAERROR_NO_METHOD_STATUS 0x89
 #define GENERIC_HOST_SESSION_NUM 0x41
+#define FIRST_TPER_SESSION_NUM	4096

 #define TPER_SYNC_SUPPORTED 0x01
 #define MBR_ENABLED_MASK 0x10
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 880cc57a5f6b..daafadbb88ca 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1056,7 +1056,7 @@ static int start_opal_session_cont(struct opal_dev *dev)
 	hsn = response_get_u64(&dev->parsed, 4);
 	tsn = response_get_u64(&dev->parsed, 5);

-	if (hsn == 0 && tsn == 0) {
+	if (hsn != GENERIC_HOST_SESSION_NUM || tsn < FIRST_TPER_SESSION_NUM) {
 		pr_debug("Couldn't authenticate session\n");
 		return -EPERM;
 	}
--
2.17.1

