Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E0BC6FD1F
	for <linux-block@archiver.kernel.org>; Sun, 12 Mar 2023 12:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCLMgW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Mar 2023 08:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCLMgV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Mar 2023 08:36:21 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1269130187
        for <linux-block@vger.kernel.org>; Sun, 12 Mar 2023 05:36:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k2so2260737pll.8
        for <linux-block@vger.kernel.org>; Sun, 12 Mar 2023 05:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678624579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ/oZ2UTxPe8mkUt3Li/iZ+QGKCA6pqiISA8N20XQF4=;
        b=p4GaONQsmqJw7GUBPHDi1KEIY4A+gItWyBYrqM6F6VVCGOAvqFc8xSnRf41UZZly/Z
         K0mubuH8vJB2Oponfi7ltJGjg5BuLO5ypCI/BXW1D+bWzbXhY/yaAobFm7t6UIgkEkg1
         PUuQgWYTJAfxrm2mG2mcAc7PXB/fRDWsnp4fk3dcbJCZiwNt6/Gr3krMRWfwjxLy8xkh
         yWP3fa9sd8RxOzxzk9KXM0+AsxjJWaSl5S+Jkmzh2ZZQ4joozf1KlmttxZ1UddLyqsA5
         Iz1Qmm1KO8sMc+Z671aYrBJCPNU7tbNsXc47RsM17BYqOUt2nnul+hlImyVYkmv1MC8V
         G4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678624579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZ/oZ2UTxPe8mkUt3Li/iZ+QGKCA6pqiISA8N20XQF4=;
        b=ZRlsGlxpwVHQsJNnsFTeo+Ju6fehj9pXaA6h+8Mdv+apAVh9XxqeTL/vslsgoHn7PB
         Wq8fUrwsOL0pSpIAKtf5hEIa6y8LduIHJvza+BC1QI66rQHe+PAzKEd8lT2Y+sQylByT
         KSN7Wh1JNNdlS7jNi5H2rzWFCVnrhbfPo4TWks6aHtoT+VwuyoJsh5kVuLXztX7RFEuf
         ENU4+P+z1YGPyJmhL+zGdg6+j0sBspSojaDsFvADFYHBGQhX/x/qUV1ixZJhdBTQyAoc
         km5mY6kLmKLVchgGAloIsiDG8GxkdP24TQcFqGF89hDt8KlbYMpt/1GxomUmThfIV47F
         F5XQ==
X-Gm-Message-State: AO0yUKUrXWarczRed9VkEYLxPrw0Y0kvjT7e8JAuJo9RlkDkc7u3jpqQ
        OL4+PBoZ9Wwe8vDGEa1lxCKasti5MFI=
X-Google-Smtp-Source: AK7set9hdcAeOcx8F/u9qV4UYr1hkUkgeiLGp1L21JGEKIxH910Fp4ECqY8ka/AF3nYBo+oRFum3TA==
X-Received: by 2002:a17:902:c948:b0:19a:a4f3:6d4c with SMTP id i8-20020a170902c94800b0019aa4f36d4cmr37100476pla.67.1678624578638;
        Sun, 12 Mar 2023 05:36:18 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:f857:74a:5290:8183])
        by smtp.gmail.com with ESMTPSA id kb8-20020a170903338800b001990028c0c9sm2828879plb.68.2023.03.12.05.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 05:36:17 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] null_blk: execute complete callback for fake timeout request
Date:   Sun, 12 Mar 2023 21:35:56 +0900
Message-Id: <20230312123556.12298-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When injecting a fake timeout into the null_blk driver by fail_io_timeout,
the request timeout handler doen't execute blk_mq_complete_request(), so
the complete callback will never be executed for that timed out request.

The null_blk driver also has a driver-specific fake timeout mechanism and
does not have the problem that occur when using the generic one.
Fix the problem by doing similar to what the driver-specific one does.

Fixes: de3510e52b0a ("null_blk: fix command timeout completion handling")
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/block/null_blk/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 4c601ca9552a..69250b3cfecd 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1413,7 +1413,9 @@ static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
 	case NULL_IRQ_SOFTIRQ:
 		switch (cmd->nq->dev->queue_mode) {
 		case NULL_Q_MQ:
-			if (likely(!blk_should_fake_timeout(cmd->rq->q)))
+			if (unlikely(blk_should_fake_timeout(cmd->rq->q)))
+				cmd->fake_timeout = true;
+			else
 				blk_mq_complete_request(cmd->rq);
 			break;
 		case NULL_Q_BIO:
-- 
2.34.1

