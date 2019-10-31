Return-Path: <SRS0=XfYF=YY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3753CA9ECF
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 16:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6A720873
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 16:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfJaQKj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:10:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:11861 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJaQKi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Oct 2019 12:10:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 09:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,252,1569308400"; 
   d="scan'208";a="190675633"
Received: from revanth.lm.intel.com ([10.232.116.91])
  by orsmga007.jf.intel.com with ESMTP; 31 Oct 2019 09:10:38 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Jonas Rabenstine <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH v3 3/3] block: sed-opal: Introduce Opal Datastore UID
Date:   Thu, 31 Oct 2019 10:13:22 -0600
Message-Id: <20191031161322.16624-4-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031161322.16624-1-revanth.rajashekar@intel.com>
References: <20191031161322.16624-1-revanth.rajashekar@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch introduces Opal Datastore UID.
The generic read/write table ioctl can use this UID
to access the Opal Datastore.

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 block/opal_proto.h | 1 +
 block/sed-opal.c   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index 710911864e1d..736e67c3e7c5 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -107,6 +107,7 @@ enum opal_uid {
 	OPAL_C_PIN_TABLE,
 	OPAL_LOCKING_INFO_TABLE,
 	OPAL_ENTERPRISE_LOCKING_INFO_TABLE,
+	OPAL_DATASTORE,
 	/* C_PIN_TABLE object ID's */
 	OPAL_C_PIN_MSID,
 	OPAL_C_PIN_SID,
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 1d5afaaf0826..b2cacc9ddd11 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -149,6 +149,8 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
 		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x01 },
 	[OPAL_ENTERPRISE_LOCKING_INFO_TABLE] =
 		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00 },
+	[OPAL_DATASTORE] =
+		{ 0x00, 0x00, 0x10, 0x01, 0x00, 0x00, 0x00, 0x00 },
 
 	/* C_PIN_TABLE object ID's */
 	[OPAL_C_PIN_MSID] =
-- 
2.17.1

