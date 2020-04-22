Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2992EC55185
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 13:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0233E206EC
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 13:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgDVNGQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:06:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:10807 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVNGQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 09:06:16 -0400
IronPort-SDR: D2Kl4tFbkX1RXI0HSoHVvvXYNRpHCGcI5QeVwsazuOHjM8NLsc05nCi2ggtlab3hfj6jh2yObZ
 rh8xBaRxmgVw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 06:06:14 -0700
IronPort-SDR: DWq/Q3Ht8JZ9wQBodTrUwrT/I2MTlPLlKGj8Fv3FaaeYvXvQWmvN7NYLRUs0UpJkwgFvwiepNw
 BLt24loOt++g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="300913677"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Apr 2020 06:06:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DC6AF58F; Wed, 22 Apr 2020 16:06:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] lightnvm: pblk: Replace guid_copy() with export_guid()/import_guid()
Date:   Wed, 22 Apr 2020 16:06:11 +0300
Message-Id: <20200422130611.45698-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a specific API to treat raw data as GUID, i.e. export_guid()
and import_guid(). Use them instead of guid_copy() with explicit casting.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/lightnvm/pblk-core.c     | 5 ++---
 drivers/lightnvm/pblk-recovery.c | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index b413bafe93fdd..6d4523dbf2dbb 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -988,7 +988,7 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
 	bitmap_set(line->lun_bitmap, 0, lm->lun_bitmap_len);
 
 	smeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
-	guid_copy((guid_t *)&smeta_buf->header.uuid, &pblk->instance_uuid);
+	export_guid(smeta_buf->header.uuid, &pblk->instance_uuid);
 	smeta_buf->header.id = cpu_to_le32(line->id);
 	smeta_buf->header.type = cpu_to_le16(line->type);
 	smeta_buf->header.version_major = SMETA_VERSION_MAJOR;
@@ -1803,8 +1803,7 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
 
 	if (le32_to_cpu(emeta_buf->header.identifier) != PBLK_MAGIC) {
 		emeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
-		guid_copy((guid_t *)&emeta_buf->header.uuid,
-							&pblk->instance_uuid);
+		export_guid(emeta_buf->header.uuid, &pblk->instance_uuid);
 		emeta_buf->header.id = cpu_to_le32(line->id);
 		emeta_buf->header.type = cpu_to_le16(line->type);
 		emeta_buf->header.version_major = EMETA_VERSION_MAJOR;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 299ef47a17b22..0e6f0c76e9302 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -706,8 +706,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 
 		/* The first valid instance uuid is used for initialization */
 		if (!valid_uuid) {
-			guid_copy(&pblk->instance_uuid,
-				  (guid_t *)&smeta_buf->header.uuid);
+			import_guid(&pblk->instance_uuid, smeta_buf->header.uuid);
 			valid_uuid = 1;
 		}
 
-- 
2.26.1

