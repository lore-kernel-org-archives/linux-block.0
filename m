Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2E3C282CE
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 12:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BC92075B
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 12:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="OeTqf7vw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfBKMZ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:25:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36852 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfBKMZ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 07:25:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so8601405ljk.3
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 04:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u99sfZGMW+gKwnhlHoCgtcN3E+Mx1BLTxSFc1sUIIAQ=;
        b=OeTqf7vwVFPb4XWTOINv2Nkr1BygqM1y3N6yQWHuu1MSTXIDLvWOsn7ZFiDSeuSar8
         UrNO9siXy9X6UpnwJ9qANneuy9rASLM12VE58revt2WDNfM/ptdR3UM53Dw7+6OH6Sm+
         Rr/zKg2Ah4S50Qg4rLHKbqGbjDnF8M9PO+dvLr1/4+wBG8lAKE1wdz6sVSSxC5BSXTBD
         Kao3MGDgRDBvt/Mekjn2joA5bzJJldp55rJvof4zFT/3NcKRW362UZX1PRVMD5sYB+3L
         hW9R836AL4EQJp7XeZY2CFeAUKjAT9BHyd1HansGVq4kNiGX8sykmr7UZ9r4Z6V2Qalb
         /Vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u99sfZGMW+gKwnhlHoCgtcN3E+Mx1BLTxSFc1sUIIAQ=;
        b=fFVejbtohkMZbaSN0CbkRQn1iqf76gwvIsEeC7xYzOn1Irz8U9EkuxEsmbTnIBJyDB
         vw1IofmoVi756EmJUJpYV+V4m1i2ZWF7qMFYiYAXO2FxxCCUjWAJEMCkC5CyFov6TnUg
         NLhfQaKobVgbZa1YQWsf+LyigRHUpeQNrYdsPcf2V9SwbBgO2Jne2sKouP9nGVghpJ1T
         +FHlQpsCPn48wy+LM8BhI7Jyt5ACmgpOEJAqTcc3B2b75DxHdBmAHXr2A1q7MoqBCyi6
         myei2beFlzVdn0EI5iD0Ig/zMd+QgYocKYX6aDFyYGQOlVQc0Tw9girOaOnJ2t+ulL3j
         nVVg==
X-Gm-Message-State: AHQUAuY/g2L5zxUq9P8oL42r5NMkE/7aPHCsiYMPUZOT5A1xSfCxERKZ
        /NE8Sw0skAvCbliETK1n0A7xOg==
X-Google-Smtp-Source: AHgI3IaI1+WNJ5na+cip9KhRZd9N3GXJsoiKwIpZ9RQUMoZbviUrr9vmJ2+PBClmv+qJyQIG0LFT0A==
X-Received: by 2002:a2e:90ca:: with SMTP id o10-v6mr8403783ljg.134.1549887924179;
        Mon, 11 Feb 2019 04:25:24 -0800 (PST)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id d70sm2278481lfe.14.2019.02.11.04.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:25:22 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 4/8] lightnvm: pblk: Switch to use new generic UUID API
Date:   Mon, 11 Feb 2019 13:25:05 +0100
Message-Id: <20190211122509.19910-5-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190211122509.19910-1-mb@lightnvm.io>
References: <20190211122509.19910-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There are new types and helpers that are supposed to be used in new code.

As a preparation to get rid of legacy types and API functions do
the conversion here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c     |  5 +++--
 drivers/lightnvm/pblk-init.c     |  2 +-
 drivers/lightnvm/pblk-recovery.c |  8 +++++---
 drivers/lightnvm/pblk.h          | 10 +---------
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 1b5ff51faa63..2a9e9facf44f 100644
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
@@ -1874,7 +1874,8 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
 
 	if (le32_to_cpu(emeta_buf->header.identifier) != PBLK_MAGIC) {
 		emeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
-		memcpy(emeta_buf->header.uuid, pblk->instance_uuid, 16);
+		guid_copy((guid_t *)&emeta_buf->header.uuid,
+							&pblk->instance_uuid);
 		emeta_buf->header.id = cpu_to_le32(line->id);
 		emeta_buf->header.type = cpu_to_le16(line->type);
 		emeta_buf->header.version_major = EMETA_VERSION_MAJOR;
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index eb0135c77805..8b643d0bffae 100644
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
index 0dd697ea201e..72ae8755764e 100644
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
2.19.1

