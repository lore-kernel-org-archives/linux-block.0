Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F85CC433E2
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648B261A4C
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 21:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhCYV1d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 17:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhCYV1L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695B9C06175F
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v6so7538957ybk.9
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rUphNMT0sm87MpzUiuuClzpcMsplrJctbX+7T7BgcBI=;
        b=Z31KaBaf0F337eZVWuVD1HT4Uu9KPoH0PgSCulKvd0aw1lTRFmeEoIvqKRdGQlpyJc
         SLuEh9pdLGtSpPxur46IC4+LS7M9Q7wee5WpMQRBGYkwc6nV9Q1GZsnByKYAabF+jL1/
         JLAj3p8JSxlCOcKbzqJdczpXcGH3dtgVD+waeRvSCaiKXMeapuNi/XaBwSLLSLJ5pzXb
         qF0hzvaRThCKTBQ5T51EPvZGzDjfrscM9URatMIoj3CPBmomNb63SniIDZLtzW3FHVTP
         mgtkrjGzTQ+B4PgLCPy3OlY81rzufDO8KFrcYyB9ZxWC6U4GyyzGj4UECEGmLtlSUm7T
         CC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rUphNMT0sm87MpzUiuuClzpcMsplrJctbX+7T7BgcBI=;
        b=Zf0qqtivE1uBx8+7sLfBXwUjUPYvDmePFsgQn9EE4PGJ8WNG7BY+aKnV5Gp0d6EBrs
         oYNVJYDrOKuXEjGmFA+FvTMm8T9ukqVL9Kk0yTNV0XVK5cApNvFe63NbMsvLGCGTvFq3
         YZJYc7pOQE7TxWhqZcn9dWhEOZPF34VNUEYSskFchzj+PGBK/unqcMYAfFhgb3N27YFX
         5sQHbLtbwmrhdPK2yFDoS3+5MdEfIMXo2bycjB2KWSUVlnE3Owbg6asGp7GxE9ci1PJp
         qYuvCH/LXWdtWLcyiaexwq5+QFlHGnpcSFS3F95hD31by5CWH5xirEf8AkN4OcYtMjDN
         cZ9g==
X-Gm-Message-State: AOAM533wJGXzGKgRByVJOwzGw8905PU7iuWkmlKQyuggVuyWayZmG/Yy
        AzLDMCVArkPfpVKb0kTJbN7Tazv31RnlUyZ7ELYqwoJvomFOS4BP/Bj76HOuaUDzAwYRI4PAZBP
        ycuLPPvXm5QZFEH+IAsuLDUxGAOYyWxizqS3LWJZkdGPgSLesWYxNrAMhnoWMtD4+DFeE
X-Google-Smtp-Source: ABdhPJxSUh4OHNl49f7VKbtAYjTnF/4KPwbp5X+5mw42hAO4X6wZpuWATUzKmo0HV+mNi0+WWXp4fnPoamM=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:d451:: with SMTP id m78mr8877781ybf.105.1616707630557;
 Thu, 25 Mar 2021 14:27:10 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:02 +0000
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Message-Id: <20210325212609.492188-2-satyat@google.com>
Mime-Version: 1.0
References: <20210325212609.492188-1-satyat@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 1/8] block: introduce blk_ksm_is_empty()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function checks if a given keyslot manager supports any encryption
mode/data unit size combination (and returns true if there is no such
supported combination). Helps clean up code a little.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/keyslot-manager.c         | 13 +++++++++++++
 drivers/md/dm-table.c           | 11 +----------
 include/linux/keyslot-manager.h |  2 ++
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 2c4a55bea6ca..2a2b1a9785d2 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -437,6 +437,19 @@ void blk_ksm_destroy(struct blk_keyslot_manager *ksm)
 }
 EXPORT_SYMBOL_GPL(blk_ksm_destroy);
 
+bool blk_ksm_is_empty(struct blk_keyslot_manager *ksm)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
+		if (ksm->crypto_modes_supported[i])
+			return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_ksm_is_empty);
+
 bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q)
 {
 	if (blk_integrity_queue_supports_integrity(q)) {
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 95391f78b8d5..db18a58adad7 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1313,7 +1313,6 @@ static int dm_table_construct_keyslot_manager(struct dm_table *t)
 	struct blk_keyslot_manager *ksm;
 	struct dm_target *ti;
 	unsigned int i;
-	bool ksm_is_empty = true;
 
 	dksm = kmalloc(sizeof(*dksm), GFP_KERNEL);
 	if (!dksm)
@@ -1350,15 +1349,7 @@ static int dm_table_construct_keyslot_manager(struct dm_table *t)
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
index a27605e2f826..5bf0cea20c81 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -117,4 +117,6 @@ bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
 void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
 				 struct blk_keyslot_manager *reference_ksm);
 
+bool blk_ksm_is_empty(struct blk_keyslot_manager *ksm);
+
 #endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.31.0.291.g576ba9dcdaf-goog

