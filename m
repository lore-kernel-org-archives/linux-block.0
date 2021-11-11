Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D719C433EF
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 10:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4E961247
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 10:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhKKKkQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 05:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhKKKkQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 05:40:16 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903C6C061766;
        Thu, 11 Nov 2021 02:37:27 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id n85so5224995pfd.10;
        Thu, 11 Nov 2021 02:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TsdgksjzIgtw7/d4jST9JcU2EdYuVW+gAM2jdZ5dk8s=;
        b=eFm/kf4UZg9lOvY/C8KDN/+7dL/ps+IYCMQtb2bn7Ap29kRo8Uz08oWe/3kTOjpnfA
         zmxj1ks5z4EA0kWOy0b0rlj/GeXAZg8Q03oELBpfzoOR7i/PPcKCBh5BRkYms3NtkNgP
         l7jVQAVPfTxUB/NIKCuPQomC1EALGVDp9jZqlYMvEywAYFaXVRn5HsTOf7LC4eGBojLE
         rNnTwbiGdiIJkw4BVeC/26P8Mhl1MtYqS/5BUvImF/DMHvdWtPI9Ri2V/8Bm2c0AXR2v
         yeVtIQNLq5cFhD4A++ZLUZOHVZr78fvXMMQrkZYNGoocU0hggv33+h+fFhiYGRlYV0w0
         R0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TsdgksjzIgtw7/d4jST9JcU2EdYuVW+gAM2jdZ5dk8s=;
        b=8MOKYk/IQ7oGCid4CxleWYMiy7znMwxeQ+SA1m8F2u4PWr96wYfMZKpIXaADeAjTp5
         8VTVKO0s6tuIuHrz6fJzes8xIt41mf3c3KFblWeaYCKEP/C3X2fDExinueHm9vKxTgHA
         Jl5iDeeSFRbBUafeIFDB2pA3mGYXHfWk+RQb6XOUjh/c2YFv9MiVuFlnsCMcphIgsgyD
         0rBvF11seTL8/eAEIqK3AzGVNcJqE2xkQgOOqnWcT74K8s01h03Vgq0lwl7TIF8I94+Q
         7lNfqgkEx4LZkTBPHdDwtl7N8lNdxTj+8boRLQ970xjDgOvyoYeKCXez2HOgZG3lL+iu
         oZZQ==
X-Gm-Message-State: AOAM530gHH8mSkvr8UO/CSanRrz+CjQ45kc9Ju8pxo28CMkucv9BvH1R
        46UWXS+x49wph58pANgQuZkJbFtuKAw=
X-Google-Smtp-Source: ABdhPJwe54+KwEJg+g2Q3mweAMYeskRKlDhb9UiTQmH2gRWCxHZi9DuqngGwgRjh6sKgT3gh4I2+PA==
X-Received: by 2002:a63:6747:: with SMTP id b68mr3784340pgc.371.1636627047223;
        Thu, 11 Nov 2021 02:37:27 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p2sm2072018pja.55.2021.11.11.02.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 02:37:26 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] blk-mq:Use BUG_ON instead of if condition followed by BUG.
Date:   Thu, 11 Nov 2021 10:37:22 +0000
Message-Id: <20211111103722.1650-1-zhang.mingyu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Zhang Mingyu <zhang.mingyu@zte.com.cn>

This issue was detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
---
 block/blk-mq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7c5c8a26c8fc..05bffbc6b8ff 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -818,8 +818,7 @@ EXPORT_SYMBOL(__blk_mq_end_request);
 
 void blk_mq_end_request(struct request *rq, blk_status_t error)
 {
-	if (blk_update_request(rq, error, blk_rq_bytes(rq)))
-		BUG();
+	BUG_ON(blk_update_request(rq, error, blk_rq_bytes(rq)));
 	__blk_mq_end_request(rq, error);
 }
 EXPORT_SYMBOL(blk_mq_end_request);
-- 
2.25.1

