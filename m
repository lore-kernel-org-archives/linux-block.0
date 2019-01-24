Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9080BC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 14:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631C5218AE
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 14:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfAXObn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:31:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:20048 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbfAXObn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 09:31:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 06:31:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,516,1539673200"; 
   d="scan'208";a="128556334"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 24 Jan 2019 06:31:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 839AF12A; Thu, 24 Jan 2019 16:31:38 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] lightnvm: pblk: Switch to use new generic UUID API
Date:   Thu, 24 Jan 2019 16:31:37 +0200
Message-Id: <20190124143137.13880-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are new types and helpers that are supposed to be used in new code.

As a preparation to get rid of legacy types and API functions do
the conversion here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2:
- convert instance_uuid to guid_t and get rid of pblk_setup_uuid()
- fix subject line to show subsystem

 drivers/lightnvm/pblk-core.c     |  4 ++--
 drivers/lightnvm/pblk-init.c     |  2 +-
 drivers/lightnvm/pblk-recovery.c |  8 +++++---
 drivers/lightnvm/pblk.h          | 10 +---------
 4 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 1ff165351180..189339965957 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1065,7 +1065,7 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
 	bitmap_set(line->lun_bitmap, 0, lm->lun_bitmap_len);
 
 	smeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
-	memcpy(smeta_buf->header.uuid, pblk->instance_uuid, 16);
+	guid_copy((guid_t *)&smeta_buf->header.uuid, &pblk->instance_uuid);
 	smeta_buf->header.id = cpu_to_le32(line->id);
 	smeta_buf->header.type = cpu_to_le16(line->type);
 	smeta_buf->header.version_major = SMETA_VERSION_MAJOR;
@@ -1874,7 +1874,7 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
 
 	if (le32_to_cpu(emeta_buf->header.identifier) != PBLK_MAGIC) {
 		emeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
-		memcpy(emeta_buf->header.uuid, pblk->instance_uuid, 16);
+		guid_copy((guid_t *)&emeta_buf->header.uuid, &pblk->instance_uuid);
 		emeta_buf->header.id = cpu_to_le32(line->id);
 		emeta_buf->header.type = cpu_to_le16(line->type);
 		emeta_buf->header.version_major = EMETA_VERSION_MAJOR;
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index f9a3e47b6a93..5768333d103f 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -130,7 +130,7 @@ static int pblk_l2p_recover(struct pblk *pblk, bool factory_init)
 	struct pblk_line *line = NULL;
 
 	if (factory_init) {
-		pblk_setup_uuid(pblk);
+		guid_gen(&pblk->instance_uuid);
 	} else {
 		line = pblk_recov_l2p(pblk);
 		if (IS_ERR(line)) {
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 5ee20da7bdb3..6761d2afa4d0 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -703,11 +703,13 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 
 		/* The first valid instance uuid is used for initialization */
 		if (!valid_uuid) {
-			memcpy(pblk->instance_uuid, smeta_buf->header.uuid, 16);
+			guid_copy(&pblk->instance_uuid,
+				  (guid_t *)&smeta_buf->header.uuid);
 			valid_uuid = 1;
 		}
 
-		if (memcmp(pblk->instance_uuid, smeta_buf->header.uuid, 16)) {
+		if (!guid_equal(&pblk->instance_uuid,
+				(guid_t *)&smeta_buf->header.uuid)) {
 			pblk_debug(pblk, "ignore line %u due to uuid mismatch\n",
 					i);
 			continue;
@@ -737,7 +739,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 	}
 
 	if (!found_lines) {
-		pblk_setup_uuid(pblk);
+		guid_gen(&pblk->instance_uuid);
 
 		spin_lock(&l_mg->free_lock);
 		WARN_ON_ONCE(!test_and_clear_bit(meta_line,
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 85e38ed62f85..12bf02df4204 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -646,7 +646,7 @@ struct pblk {
 
 	int sec_per_write;
 
-	unsigned char instance_uuid[16];
+	guid_t instance_uuid;
 
 	/* Persistent write amplification counters, 4kb sector I/Os */
 	atomic64_t user_wa;		/* Sectors written by user */
@@ -1360,14 +1360,6 @@ static inline unsigned int pblk_get_secs(struct bio *bio)
 	return  bio->bi_iter.bi_size / PBLK_EXPOSED_PAGE_SIZE;
 }
 
-static inline void pblk_setup_uuid(struct pblk *pblk)
-{
-	uuid_le uuid;
-
-	uuid_le_gen(&uuid);
-	memcpy(pblk->instance_uuid, uuid.b, 16);
-}
-
 static inline char *pblk_disk_name(struct pblk *pblk)
 {
 	struct gendisk *disk = pblk->disk;
-- 
2.20.1

