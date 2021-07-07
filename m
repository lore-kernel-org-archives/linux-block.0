Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16047C07E95
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D9761CB0
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhGGFcd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 01:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhGGFcd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 01:32:33 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB76AC06175F;
        Tue,  6 Jul 2021 22:29:53 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w74so2064179oiw.8;
        Tue, 06 Jul 2021 22:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9mcFTax0Fd19qehKUtPE/0XWl2NOU79bLU08anZC7Q=;
        b=GcpqxZNgsKZXPvBh4QygZBHJcRG1eADTf6M5IiMAd+7ZDDA64emuPexrPM4Sidd7/F
         qiG/v7yvB7Uod0Nt6FDT6w720dRnj7szlICfbsXzIDwDWnuBIK78Dste03mn68NnXY7w
         OfVKPH5bfNFmZ6+d+xNDZ40gcCK+YjZmYlQ3WotmjWzikQ9btm+RcaFb+9v7kkIaXCM2
         0w+LlW/jbBSU6+AhvAy2EJYbOmryHIJ+aAw+sZaYI/+8sGdWGZv3vEtksFMIXbfhTkC9
         k6FPlvU7Fl5saSSpcriHsadvao5zW/CQqVaUOHc/fhilM0FIuS6vIqc8efw+NWrH1QbA
         KvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9mcFTax0Fd19qehKUtPE/0XWl2NOU79bLU08anZC7Q=;
        b=hWFaXDJr8xwuNwaaniDgg+IzhtRm1DEuJcTxZmTSXvAqNG3vUKs5QpIie8kAKQjx2q
         C0zPEbMoqNTJcQmttAkhUG0qUXMFsSOUKf+71jIhGbgsjABArDjslrrEayph8cm24xt9
         Vpx0cVrI4J/gOj6kzmX6eHlXPfnzgzKufaDcHWvUDPwGFyE8k3vWs2vswxncNl7RRZ1R
         cjKfibqtnjJT3bq/L3BnCafx01YPgTVkNmFmUWlEF9EDD2A/czlEB7VXwWR6m1TEnsx2
         qeZ73awA0KnruK1A6TSlYjrD0D0m/eW8xvjZ8EOnhTikhjVmvfpSn4h5Fmpa27wVNzt+
         1zHw==
X-Gm-Message-State: AOAM530KqZertcQQA4kcD2KxOoTASVpM4XiGK6bRbKG90ZUFuqbWZc+3
        Hhr0CItb4j9j00cl50qtOk9q+tSIdeM=
X-Google-Smtp-Source: ABdhPJyRrbiJ+SMsGuKW7rM9XoiFiS6FbbtKxjQfdqqCWJLeTg520lSmWwulWzi2uuVIJJ1AENiAvg==
X-Received: by 2002:aca:4fce:: with SMTP id d197mr10972346oib.16.1625635793068;
        Tue, 06 Jul 2021 22:29:53 -0700 (PDT)
Received: from fractal.attlocal.net ([2600:1700:1151:2380:3ec5:124:b596:7a55])
        by smtp.googlemail.com with ESMTPSA id l11sm3284843oou.0.2021.07.06.22.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 22:29:52 -0700 (PDT)
From:   Satya Tangirala <satyaprateek2357@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v4 1/9] block: introduce blk_ksm_is_empty()
Date:   Tue,  6 Jul 2021 22:29:35 -0700
Message-Id: <20210707052943.3960-2-satyaprateek2357@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707052943.3960-1-satyaprateek2357@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Satya Tangirala <satyat@google.com>

This function checks if a given keyslot manager supports any encryption
mode/data unit size combination (and returns true if there is no such
supported combination). Helps clean up code a little.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/keyslot-manager.c         | 31 +++++++++++++++++++++++++++++++
 drivers/md/dm-table.c           | 11 +----------
 include/linux/keyslot-manager.h |  2 ++
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 2c4a55bea6ca..4d0794506d43 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -437,6 +437,37 @@ void blk_ksm_destroy(struct blk_keyslot_manager *ksm)
 }
 EXPORT_SYMBOL_GPL(blk_ksm_destroy);
 
+/*
+ * Returns true iff @ksm doesn't support any crypto capabilities if
+ * @dus_allowed_mask were applied to each crypto mode of @ksm.
+ */
+static inline bool blk_ksm_is_empty_mask(struct blk_keyslot_manager *ksm,
+					 unsigned long dus_allowed_mask)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
+		if (ksm->crypto_modes_supported[i] & dus_allowed_mask)
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * blk_ksm_is_empty() - Checks if the keyslot manager has any crypto
+ *			capabilities at all.
+ * @ksm: The input keyslot manager to check
+ *
+ * Return: true if @ksm doesn't have any crypto capabilities at all, and
+ *	   false otherwise.
+ */
+bool blk_ksm_is_empty(struct blk_keyslot_manager *ksm)
+{
+	return blk_ksm_is_empty_mask(ksm, ~0);
+}
+EXPORT_SYMBOL_GPL(blk_ksm_is_empty);
+
 bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q)
 {
 	if (blk_integrity_queue_supports_integrity(q)) {
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index ee47a332b462..29cbfc3e3c4b 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1295,7 +1295,6 @@ static int dm_table_construct_keyslot_manager(struct dm_table *t)
 	struct blk_keyslot_manager *ksm;
 	struct dm_target *ti;
 	unsigned int i;
-	bool ksm_is_empty = true;
 
 	dksm = kmalloc(sizeof(*dksm), GFP_KERNEL);
 	if (!dksm)
@@ -1332,15 +1331,7 @@ static int dm_table_construct_keyslot_manager(struct dm_table *t)
 	 * If the new KSM doesn't actually support any crypto modes, we may as
 	 * well represent it with a NULL ksm.
 	 */
-	ksm_is_empty = true;
-	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
-		if (ksm->crypto_modes_supported[i]) {
-			ksm_is_empty = false;
-			break;
-		}
-	}
-
-	if (ksm_is_empty) {
+	if (blk_ksm_is_empty(ksm)) {
 		dm_destroy_keyslot_manager(ksm);
 		ksm = NULL;
 	}
diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
index a27605e2f826..0f09b4f310f7 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -106,6 +106,8 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm);
 
 void blk_ksm_destroy(struct blk_keyslot_manager *ksm);
 
+bool blk_ksm_is_empty(struct blk_keyslot_manager *ksm);
+
 void blk_ksm_intersect_modes(struct blk_keyslot_manager *parent,
 			     const struct blk_keyslot_manager *child);
 
-- 
2.25.1

