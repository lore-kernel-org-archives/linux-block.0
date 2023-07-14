Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDA3C001B0
	for <linux-block@archiver.kernel.org>; Fri, 14 Jul 2023 07:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbjGNHZa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jul 2023 03:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjGNHZ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2023 03:25:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B12729
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 00:25:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fc8049fd8bso2589275e87.2
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1689319525; x=1689924325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLXkkNKLC2QFI1E0y4rm62aHVfDJbTTFbFsFl9CT7J4=;
        b=3y7lQ5pB6aU5w2NYLHZyCpC3h2fedz/S7KPBC8S0fQKNsW5rbgTRd+0DQxRfoBTe9G
         9Og2eZ1tWDFoLcw2TQvfyA5iZG4NTLc0qYfQag2YCVKrsz1eTcbe98M6lvY5vcUx5Sb1
         k5MH5cszbsJ5Y0ukpV0A4qy9KfNcZBxjM1t+8DVaFTvSpll45Fs7v3LTqVBc74ixo8O3
         cWm2QoOXiDrzA5opBYb1WTZ2AbiuG7Yr0Zyl8XA00SMY8ObqTK/aoX+1XtHwFbckZwSt
         10MJiBoD8701fLM9wrZiMM+EFdh0tzDkEp7toGKqa/1iU2CB9XXDAj63hrQlkASBN0Sx
         4qLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689319525; x=1689924325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLXkkNKLC2QFI1E0y4rm62aHVfDJbTTFbFsFl9CT7J4=;
        b=f11FVzPQzVI4prrF0ZZB1i/71qb2woMmfSzczxUfkYPYD5jnzF+3M4UJwdswbouDM9
         YxA9+SBqb37qDXYNBZq5jBcAwl4G599V3flLDjjt2Tdc8AytbHlt7x8bUu0z4+d8+hnx
         0PR8u9uNJ5rRSmwkKG03kfPbh8c3/nIF7LjI0yz8pwvQNXvUJVBEqOPewcFr5Zn0IXMJ
         Dk0pnt8cxkTjUKPro1RwsWeTQ+Lexvp+xaCLL3jdXQc544fvIANTJ/Ge92WvAaPcmfF4
         GwLwIiMei/aT+7YVqwlC2UXWbVLaipi/UHRvSknPfRFIRpepOFVdZhENM0aGIobT3WxN
         PQLA==
X-Gm-Message-State: ABy/qLaF2kKCFrYggnmRHnjpu3RH+AnN2JnJfv+v9K2sID/KkYbUYORv
        LwwTdW06v4dT3C6j9rrf7kuuew==
X-Google-Smtp-Source: APBJJlHrQmIeIX9a7uT1IBcRZlKrq+GOTUWmTpumXS4QtWb26N7ldSxbruMcFZgevJ2Tq1iZC/JOzw==
X-Received: by 2002:a19:2d53:0:b0:4fb:7be5:4870 with SMTP id t19-20020a192d53000000b004fb7be54870mr2960808lft.46.1689319525103;
        Fri, 14 Jul 2023 00:25:25 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id p12-20020a05651238cc00b004fa4323ec97sm1372952lft.301.2023.07.14.00.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 00:25:24 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Matias Bjorling <Matias.Bjorling@wdc.com>,
        linux-kernel@vger.kernel.org (open list),
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, gost.dev@samsung.com,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v9 1/2] ublk: add helper to check if device supports user copy
Date:   Fri, 14 Jul 2023 09:25:09 +0200
Message-ID: <20230714072510.47770-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714072510.47770-1-nmi@metaspace.dk>
References: <20230714072510.47770-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

This will be used by ublk zoned storage support.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/ublk_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1c823750c95a..8d271901efac 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -185,6 +185,11 @@ struct ublk_params_header {
 	__u32	types;
 };
 
+static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_USER_COPY;
+}
+
 static inline void __ublk_complete_rq(struct request *req);
 static void ublk_complete_rq(struct kref *ref);
 
@@ -2037,7 +2042,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		UBLK_F_URING_CMD_COMP_IN_TASK;
 
 	/* GET_DATA isn't needed any more with USER_COPY */
-	if (ub->dev_info.flags & UBLK_F_USER_COPY)
+	if (ublk_dev_is_user_copy(ub))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
 	/* We are not ready to support zero copy */
-- 
2.41.0

