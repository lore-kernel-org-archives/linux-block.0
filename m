Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF62C433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 09:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E866522E
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 09:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhCIJSV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 04:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCIJSV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 04:18:21 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCB7C06174A;
        Tue,  9 Mar 2021 01:18:21 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id ba1so6275051plb.1;
        Tue, 09 Mar 2021 01:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T7tvGncTtXaZiXPJeP/WnIyayFcG7/f+OFJGrJ7Xumk=;
        b=uvQw0vLiqx48lmV6cVQH+HLh0Gwn/Hkca6R/O1ggPozFZzSQg8XmLXr4bw1wrv73Pt
         CRU+kyi+NfV/I6wCYzqHW7uhDBjkEIkejy+lHznNfnlaaOFeA1YDx61N0F4FV1Y7yzc2
         0DsmplHkf8x0+sQU4cWlHh42Lv0Q+7EStsofROh+4m3VEnoIC/o+uJ52a0XsBL/GyFu3
         nBjC2Ok6TgojmjSUyLubqZYR+tHEqRtU4TiOJNlVyuA0W3t/IYoOh1Qq9O7j7zR4VDia
         6Qn/aX8F0IL9XEzwfyh951lA7rCp6EEXNO26/JsLL8B3yl34JtnsJ1sGjn//S5KbsoAH
         Q6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T7tvGncTtXaZiXPJeP/WnIyayFcG7/f+OFJGrJ7Xumk=;
        b=GFbCjvG1zsahfaeji8G7ba+3jtbqhqu3kLOPfWhkg5XsD8F153fzAhqYUxxI/iHs5o
         j7X9Cst9kgP0AJc9Xv1NZ+gd4J/IzB0cYUjocK+/gM22jwu5Sa+OX5nGr+mcKaRuaSPL
         fSc+dvoD9yOrRDsxVgL63ccpbodJbNsf0cGCvmCm2IU3x3tiY5oFV0koVAwuIpxAjGCC
         DM7pJ9wvz6ku4HOH7dk+V3KQApCZDeHhpBr7vRiT9RSrXspiyl7aAy8JIdPO2hzNwNQV
         Q7w69PVM5GvsXUTYsZXQ6ecPvVExDJSPr/OOFERsoRfwCxvea96k1WsH03INMVBQ3hxR
         5pCw==
X-Gm-Message-State: AOAM531V/w8DMk0zY8gL3bz7LyjtK86G7koD8lOwxa4ZOWFJOSi70yHV
        CE1NNg7A3PQhpGu8CrxP51EL99NrkYbO68/y
X-Google-Smtp-Source: ABdhPJwwWbc/0MWYXaNzyQXeZRPQ1ffVUHWVEUgqElCZ+boMPYTtlTkdJtZZmhB8BR04J9mHvUSoew==
X-Received: by 2002:a17:902:b589:b029:e6:2875:aa4c with SMTP id a9-20020a170902b589b02900e62875aa4cmr8512086pls.71.1615281500789;
        Tue, 09 Mar 2021 01:18:20 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.97])
        by smtp.gmail.com with ESMTPSA id z24sm11109341pge.71.2021.03.09.01.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 01:18:20 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] block: keyslot-manager: fix error return code of blk_ksm_evict_key()
Date:   Tue,  9 Mar 2021 01:18:12 -0800
Message-Id: <20210309091812.26029-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When blk_ksm_find_keyslot() returns NULL to slot, no error return code
of blk_ksm_evict_key() is assigned.
To fix this bug, err is assigned with -ENOENT in this case.

Fixes: 1b2628397058 ("block: Keyslot Manager for Inline Encryption")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 block/keyslot-manager.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 2c4a55bea6ca..4dd5da0645bc 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -375,8 +375,10 @@ int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
 
 	blk_ksm_hw_enter(ksm);
 	slot = blk_ksm_find_keyslot(ksm, key);
-	if (!slot)
+	if (!slot) {
+		err = -ENOENT;
 		goto out_unlock;
+	}
 
 	if (WARN_ON_ONCE(atomic_read(&slot->slot_refs) != 0)) {
 		err = -EBUSY;
-- 
2.17.1

