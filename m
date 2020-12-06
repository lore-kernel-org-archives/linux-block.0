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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A77C4167B
	for <linux-block@archiver.kernel.org>; Sun,  6 Dec 2020 14:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D1F2313B
	for <linux-block@archiver.kernel.org>; Sun,  6 Dec 2020 14:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgLFOIq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Dec 2020 09:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgLFOIq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Dec 2020 09:08:46 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB9BC0613D1
        for <linux-block@vger.kernel.org>; Sun,  6 Dec 2020 06:08:05 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m5so483032wrx.9
        for <linux-block@vger.kernel.org>; Sun, 06 Dec 2020 06:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O811b7dIBsfJ4z6gVCFgZMaE6NwPbA7DJHDA7p0gDg4=;
        b=jqWbQQVrkM4VWmKjrTibOxltfGq7RFNuw21XKbeKYhUb9hXZhvZmeK/XJ8M96FgrUS
         2F/KLGKO0QS1YP/p0e14LusqJRxD9XnqQekokiSdOHSA6xYAO8NnyWVgLu7ZewqOot+p
         rP78NdG1S+Wy4dwHJ4csOYe88mRuMYD2sNjs1MoVJfVnA6Mcx3NXWtM5rmViGWtDAsyP
         IKEJG7ssgdEDnWYVn1f1HgvjAxJwD1FQytBYA35R6buubb4sOUhwT8CBfdlC4+x3BRBo
         +LWX8j3cQdgB3UPnBi+NgTwRyc3QOutCo7ylaitZrLnNUxwIi9TP4qDFFSEw1xKXImGA
         TBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O811b7dIBsfJ4z6gVCFgZMaE6NwPbA7DJHDA7p0gDg4=;
        b=Px1c5SCRq1+RDu1lVpatRqNBxKqihNOL8sq5TDu9J9y9+qcHkUAzZQkqR6WS+E+sPQ
         vYnrMuWIR1xh1eMka6NTMflnFtFngyfKd8UQGZzJDmvMwi99GnYDiPMhIXMsed/qaNTr
         D2Dd5rNpp9Hm2oV5PwKmC8g8hsX+sH5LQ3fjiK7BiVLT7wdIfli2XGv+PF+phLW1iFbo
         pRLKM9kHaJLhtmTurGhc6qr+b2fujods/tm9WX2ueF+BjKpuWfxgCjccybOHoewezNKH
         0zunDxhIivcCsae9gaDIXvZUQlWoh4xiaS+TOIWNa5gZO+Irta+RCmO5Xq9aAriDLvH7
         OX9g==
X-Gm-Message-State: AOAM532D9IVI568fm7t1gD198GE4aVUhltE3ivmUFbsbzwBcu6pY98fA
        A12dawtE8UiipITRMbpm4iF3AQj1IRoCHA==
X-Google-Smtp-Source: ABdhPJz3axUZnUIwjijwY8AkGK7yEEt9Hmbpfpbs8h8NOWrRqxF2bYU8JjBnq5LC2UEdQnmr1idAaQ==
X-Received: by 2002:a05:6000:c9:: with SMTP id q9mr820309wrx.259.1607263684360;
        Sun, 06 Dec 2020 06:08:04 -0800 (PST)
Received: from localhost.localdomain ([185.69.145.45])
        by smtp.gmail.com with ESMTPSA id n123sm10608363wmn.7.2020.12.06.06.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 06:08:03 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH v3] blk-mq: skip hybrid polling if iopoll doesn't spin
Date:   Sun,  6 Dec 2020 14:04:39 +0000
Message-Id: <d5c7dbf6f10efa44271dcb36a178f9566fe76c19.1607263384.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If blk_poll() is not going to spin (i.e. @spin=false), it also must not
sleep in hybrid polling, otherwise it might be pretty suprising for
users trying to do a quick check and expecting no-wait behaviour.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

v2: inverse invalid spin check
v3: add comments, reword and resend

 block/blk-mq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e9799fed98c7..8d81fe0d8fbc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3865,9 +3865,10 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 	 * the state. Like for the other success return cases, the
 	 * caller is responsible for checking if the IO completed. If
 	 * the IO isn't complete, we'll get called again and will go
-	 * straight to the busy poll loop.
+	 * straight to the busy poll loop. If specified not to spin,
+	 * we also should not sleep.
 	 */
-	if (blk_mq_poll_hybrid(q, hctx, cookie))
+	if (spin && blk_mq_poll_hybrid(q, hctx, cookie))
 		return 1;
 
 	hctx->poll_considered++;
-- 
2.24.0

