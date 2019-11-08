Return-Path: <SRS0=T+5Q=ZA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE0AC17441
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 23:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF8D20865
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 23:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfKHXJw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 18:09:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:14359 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKHXJw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Nov 2019 18:09:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 15:09:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,283,1569308400"; 
   d="scan'208";a="193327493"
Received: from unknown (HELO revanth.lm.intel.com) ([10.232.116.114])
  by orsmga007.jf.intel.com with ESMTP; 08 Nov 2019 15:09:50 -0800
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Scott Bauer <sbauer@plzdonthack.me>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH] block: sed-opal: Introduce SUM_SET_LIST parameter and append it using 'add_token_u64'
Date:   Fri,  8 Nov 2019 16:09:04 -0700
Message-Id: <20191108230904.7932-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In function 'activate_lsp', rather than hard-coding the
short atom header(0x83), we need to let the function
'add_short_atom_header' append the header based on the
parameter being appended.

The paramete has been defined in Section 3.1.2.1 of
https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage-Opal_Feature_Set_Single_User_Mode_v1-00_r1-00-Final.pdf

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 block/opal_proto.h | 4 ++++
 block/sed-opal.c   | 6 +-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index 736e67c3e7c5..325cbba2465f 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -205,6 +205,10 @@ enum opal_lockingstate {
 	OPAL_LOCKING_LOCKED = 0x03,
 };
 
+enum opal_parameter {
+	OPAL_SUM_SET_LIST = 0x060000,
+};
+
 /* Packets derived from:
  * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
  * Secion: 3.2.3 ComPackets, Packets & Subpackets
diff --git a/block/sed-opal.c b/block/sed-opal.c
index b2cacc9ddd11..880cc57a5f6b 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1886,7 +1886,6 @@ static int activate_lsp(struct opal_dev *dev, void *data)
 {
 	struct opal_lr_act *opal_act = data;
 	u8 user_lr[OPAL_UID_LENGTH];
-	u8 uint_3 = 0x83;
 	int err, i;
 
 	err = cmd_start(dev, opaluid[OPAL_LOCKINGSP_UID],
@@ -1899,10 +1898,7 @@ static int activate_lsp(struct opal_dev *dev, void *data)
 			return err;
 
 		add_token_u8(&err, dev, OPAL_STARTNAME);
-		add_token_u8(&err, dev, uint_3);
-		add_token_u8(&err, dev, 6);
-		add_token_u8(&err, dev, 0);
-		add_token_u8(&err, dev, 0);
+		add_token_u64(&err, dev, OPAL_SUM_SET_LIST);
 
 		add_token_u8(&err, dev, OPAL_STARTLIST);
 		add_token_bytestring(&err, dev, user_lr, OPAL_UID_LENGTH);
-- 
2.17.1

