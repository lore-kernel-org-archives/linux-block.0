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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12035C11F6D
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C2761CB9
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 05:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhGGFct (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 01:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhGGFcj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 01:32:39 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F212C061574;
        Tue,  6 Jul 2021 22:29:59 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id l26so2067908oic.7;
        Tue, 06 Jul 2021 22:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0kBLecPZK5QtbM0U77Eywo9FlxxXRh7xQR4HDT08aZo=;
        b=SamZDdnOrH4+J+enbltH6FME7U0uU8TAO+8WWpcNzJi319tNB8PASsyLzhr9e3hsEI
         4R4v7oRlwQygp7jmveRONCXIHiXtdory+QmSQuQOrZr0pV0UcPSSCylaoDK/It2ODGN7
         DuTlWzNpW27CUw8Y8qxItPTdUl4/0UWFpzhSTLoqckOA8/5MLj61io3hrRWtCFocEbzS
         jn5v10k0seZYWQEYWKFz4o4umRpsYzQAihPGwDJWFjfuRQ7GuN38ulXv7KphCB/E6Mmk
         AWWJgOLvwuPcWKp78hc+ydVBcM3Agdm2E4eVjOOSdGnVGfNUbLIsSfbZ1sDtqpAkMDw5
         zroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0kBLecPZK5QtbM0U77Eywo9FlxxXRh7xQR4HDT08aZo=;
        b=G5zf/9/iG9T6OfyhBvzpINU2cyC/5kzzj85cAU52ANCfacSp1qT1lZsa5x6caq0nSF
         9PsZ4Ta6ye8vnckdRmuR3O1pYmArTGweD2YUWFiPfPWf/sWiCKwTF1tNSIYh7KA2RU7m
         w5lY1/SXuXpNVWkDJmF/OIPHn74quv22yBHazOxhXvv/h+gbgOuL3Mn22pnIDSSKKWnk
         jFipMDxIhMx8AHPcQp0Ri86RYUxKzf/Iv9uTrTw8eB0b+wYieWpT9CnDUBrwgqgSCSNz
         EQrD0M4VxEPTXt1Ua7YVOFQO0RLlQ0SdxlbLiVOFBtfm2ZNMqWjTJMh+A110vcncOrhy
         8ylA==
X-Gm-Message-State: AOAM5339mU6UjsueTHApavddUmE+O5gKvOsrSxLCYNBC9Q1OO2VfKl2z
        TAfj5rt0zG/xG+COWYrw+3glSvNqZQM=
X-Google-Smtp-Source: ABdhPJzVCiQVEjkVHrQ76SFBKEHFxORI6TkyhAmQlIUb+ze3MLLokC3X15tGnfhW0ZxOJU1XzuoaMg==
X-Received: by 2002:a05:6808:651:: with SMTP id z17mr655312oih.15.1625635798577;
        Tue, 06 Jul 2021 22:29:58 -0700 (PDT)
Received: from fractal.attlocal.net ([2600:1700:1151:2380:3ec5:124:b596:7a55])
        by smtp.googlemail.com with ESMTPSA id l11sm3284843oou.0.2021.07.06.22.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 22:29:58 -0700 (PDT)
From:   Satya Tangirala <satyaprateek2357@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v4 7/9] dm: handle error from blk_ksm_register()
Date:   Tue,  6 Jul 2021 22:29:41 -0700
Message-Id: <20210707052943.3960-8-satyaprateek2357@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707052943.3960-1-satyaprateek2357@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Satya Tangirala <satyat@google.com>

Handle any error from blk_ksm_register() in the callers. Previously,
the callers ignored the return value because blk_ksm_register() wouldn't
fail as long as the request_queue didn't have integrity support too, but
as this is no longer the case, it's safer for the callers to just handle
the return value appropriately.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/md/dm-table.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 29cbfc3e3c4b..c79c0fbe80dd 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1343,6 +1343,20 @@ static int dm_table_construct_keyslot_manager(struct dm_table *t)
 	 */
 	t->ksm = ksm;
 
+	/*
+	 * At this point, t->ksm is either NULL or *not* empty (i.e. will support
+	 * at least 1 crypto capability), the request queue doesn't support
+	 * integrity, and it also satisfies all the block layer constraints
+	 * "sufficiently" (as in the constraints of the DM device's request queue
+	 * won't preclude any of the intersection of the supported capabilities
+	 * of the underlying devices, since if some capability were precluded by
+	 * the DM device's request queue's constraints, that capability would
+	 * also have been precluded by one of the child device's request queues).
+	 *
+	 * Hence any future attempt to call blk_ksm_register() on t->ksm (if it's
+	 * not NULL) will succeed.
+	 */
+
 	return 0;
 }
 
@@ -1354,7 +1368,8 @@ static void dm_update_keyslot_manager(struct request_queue *q,
 
 	/* Make the ksm less restrictive */
 	if (!q->ksm) {
-		blk_ksm_register(t->ksm, q);
+		if (WARN_ON(!blk_ksm_register(t->ksm, q)))
+			dm_destroy_keyslot_manager(t->ksm);
 	} else {
 		blk_ksm_update_capabilities(q->ksm, t->ksm);
 		dm_destroy_keyslot_manager(t->ksm);
-- 
2.25.1

