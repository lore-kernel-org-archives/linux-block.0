Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E6FC63777
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 17:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54F92073C
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 17:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqVyZimw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbgK3RSz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 12:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387420AbgK3RSy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 12:18:54 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC10AC0613CF
        for <linux-block@vger.kernel.org>; Mon, 30 Nov 2020 09:18:08 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 1so10189006qka.0
        for <linux-block@vger.kernel.org>; Mon, 30 Nov 2020 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=eopvHkHgFi7txMRG0JsShqxJBrxyoLD4siq5oMAfwmA=;
        b=iqVyZimwVx7ei2bRE+HlrBe2JQpodZILoYsNjb6DwHF4FwBfThcgRScrnS/388/mXh
         XEbGu9Bwvm/5QOaIrH5mxyle/YLpQ+7rJK8MgRKbMdtlgWYDmfBa6iUbAZDEkoQywLgB
         BAnK7qXzTA36Utl3KB2LB/8TQVyuPHdn0+qeud08SlFVz9KJhaNVLuuMTgCGL2mpQUDu
         w6lBNqFnLY5/p4LgxMVSk8P++x/RqjlXz/YuHml80HKcXF3vMrGT2qWubefPxlrYKlmp
         CquUjzEvXQV6ND7zfnSttqG0p+E/UaFs7MWSthLn7qX4Kug3gVvQSfDzfZqyd9qz25tx
         Vgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=eopvHkHgFi7txMRG0JsShqxJBrxyoLD4siq5oMAfwmA=;
        b=e5MnKtdAdYBiTPgPGxUkxe4d0OUDkn8UiPOj6cNFtYiAq3jsv1ugXrpzhn3UQHXjfL
         4wMbI7XOQCHfPUu1xdHcXwzyeJoimJeLprpr+kHJC/99A8NnIzRXisFmB5bD4dBPdwKF
         +kBBMwh4A768xtweX54BOwjgvaqSdiisSBR+tno3QxWIXnGJrsrdUNgwq15MwtElaYgH
         iQDa8zEccJ2mdOLFhYy3YmFDGQiucJDBkeZSXXUEigOQiwkb8gZgOF24EibHi0zILMMi
         FEBC0nyqJaVpfnfrXOah1MLTwBmbmrkB8YzaYKl8y+HBUB95vAXCZ3PZ6Ywkb2RCl8qi
         G6QA==
X-Gm-Message-State: AOAM530zk22ZL8yuJFOzWdUyDKFSm9ak5hM3RLYGjoPhgHPE1tRA2Bbs
        P0C970s97tyMqYdevd3QUpj1Nbg3vY8=
X-Google-Smtp-Source: ABdhPJyT0JR+r4IdN1HDWZkIkAJ3zWPo9AyvbM2QcZs8QmdiSIdOxosGmwfe2PpeLVhCs5Y2xH7z/g==
X-Received: by 2002:a05:620a:887:: with SMTP id b7mr23988892qka.270.1606756687623;
        Mon, 30 Nov 2020 09:18:07 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id o4sm6738419qta.26.2020.11.30.09.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 09:18:06 -0800 (PST)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     dm-devel@redhat.com, jdorminy@redhat.com, bjohnsto@redhat.com
Subject: [PATCH] block: revert to using min_not_zero() when stacking chunk_sectors
Date:   Mon, 30 Nov 2020 12:18:05 -0500
Message-Id: <20201130171805.77712-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

chunk_sectors must reflect the most limited of all devices in the IO
stack.

Otherwise malformed IO may result. E.g.: prior to this fix,
->chunk_sectors = lcm_not_zero(8, 128) would result in
blk_max_size_offset() splitting IO at 128 sectors rather than the
required more restrictive 8 sectors.

Fixes: 22ada802ede8 ("block: use lcm_not_zero() when stacking chunk_sectors")
Cc: stable@vger.kernel.org
Reported-by: John Dorminy <jdorminy@redhat.com>
Reported-by: Bruce Johnston <bjohnsto@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-settings.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9741d1d83e98..1d9decd4646e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -547,7 +547,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 	t->io_min = max(t->io_min, b->io_min);
 	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
-	t->chunk_sectors = lcm_not_zero(t->chunk_sectors, b->chunk_sectors);
+
+	if (b->chunk_sectors)
+		t->chunk_sectors = min_not_zero(t->chunk_sectors,
+						b->chunk_sectors);
 
 	/* Physical block size a multiple of the logical block size? */
 	if (t->physical_block_size & (t->logical_block_size - 1)) {
-- 
2.15.0

