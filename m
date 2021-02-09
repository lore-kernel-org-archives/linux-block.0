Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4946C43381
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 16:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C45064EBE
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 16:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhBIQqB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:46:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:57059 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233097AbhBIQoL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Feb 2021 11:44:11 -0500
IronPort-SDR: sIMJIRUviSBFkyp+MMW4d3jguMrSdf2vl5XcrniIDPN5RMMNndL5kKPEzPJ9sUXiya5/5t0q8n
 4Fex8gM+NsqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="200990899"
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="200990899"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 08:42:22 -0800
IronPort-SDR: OS31wxu51AWt/+jBvQK1mkAiLpkbd1pBywbpQLoA6uAT10LGHdINSyblaNHJlomlONIRMyjt5L
 eP9uv3mYWG4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="398835806"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 09 Feb 2021 08:42:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2434D1C7; Tue,  9 Feb 2021 18:42:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] lightnvm: pblk: Replace guid_copy() with export_guid()/import_guid()
Date:   Tue,  9 Feb 2021 18:42:19 +0200
Message-Id: <20210209164219.53849-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 1dddba11e721..33d39d3dd343 100644
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
index 299ef47a17b2..0e6f0c76e930 100644
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
2.30.0

