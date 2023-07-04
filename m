Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50064EB64D9
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 16:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjGDQwZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjGDQwX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 12:52:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A8210D3
        for <linux-block@vger.kernel.org>; Tue,  4 Jul 2023 09:52:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99317e738e8so423100766b.1
        for <linux-block@vger.kernel.org>; Tue, 04 Jul 2023 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688489539; x=1691081539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kerXQTH1dAySlTElaGBSfiCF85mcj9UpEbZgolqgBfs=;
        b=P8TZLt+1iMw/L7r0tZACsMST9Y8BUHGj1lAZtCsqY0Npj4VwghEArRmx/9vTR+lx3H
         Zmsn906MCbl2K6oAIhjvpUvDL6XsbJkD0xd6p10uPhZnTj0H/waRssXsK2kafcMK3Jpr
         eC1rtmCHpjyxOhkOW7YE6ZwY6CIpn/MGxh2dOjqlTntRiWoEO3fhoT+3AEC8B8e97rdd
         SrgxFbfzEqnQfsd0Qdss1xyLs2chavG2Tskkds/qxENIaeB17c6rNwj5c6TYf1Jy6/Bw
         Tby0JvFq/Jc7Mwaf6JrmJ/2aSHgw52LABuLY+aQi/X2YmLIUlmBTdml3y2P4zaDhluBc
         9kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688489539; x=1691081539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kerXQTH1dAySlTElaGBSfiCF85mcj9UpEbZgolqgBfs=;
        b=PdlOCJ8/v0xMofz50jgEOI7sDxJVizNAgqV/f/3GFW3GwcdgE0M3XrCSzjA+nWGVYR
         aIz4m8YcVYSQBrsL441E/nFvHXs/6iY8QDEH4T8WlsChdDFE8YXOQ0UxARH1gwSn77ds
         QL+4b1CHM3T5r6jiPtnUIj36CwJNUmklZHCUVlg5UYyWb/e8ZjW1btM3hx4L2tOQokoh
         VQBiXvK6hRgLmDQ9UiE2DtAHekqa/dLx5A7f9iWOH4/qUlDp8uQ34h7E0o8na0Znsi+B
         5mU3eJ2jpCKFCLcVXo7bqaBFaewg7q7laL9UiivXYhrdeV0svQpQxfdqM+18ZjlM35Tu
         yecA==
X-Gm-Message-State: ABy/qLb3MM/TrqJvATzm0eNu942UHbTIs+UJhwmm4jB9q1biz31XzpWV
        q2oZAtjDJbT34D6svhJtUNOkTg==
X-Google-Smtp-Source: APBJJlFI7gAqcEeYgrbTmRKYDrczv1ojU9Jc/Lxt56yA70uOvk8Lnb0sQKLLuAhZOG5Bo2wFmVWN+A==
X-Received: by 2002:a17:907:2ce6:b0:965:6075:d0e1 with SMTP id hz6-20020a1709072ce600b009656075d0e1mr12305216ejc.72.1688489539778;
        Tue, 04 Jul 2023 09:52:19 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id k12-20020a1709063e0c00b0098e2eaec394sm12378270eji.101.2023.07.04.09.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:52:19 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org (open list),
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>, gost.dev@samsung.com,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v5 4/5] ublk: add helper to check if device supports user copy
Date:   Tue,  4 Jul 2023 18:52:08 +0200
Message-ID: <20230704165209.514591-5-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704165209.514591-1-nmi@metaspace.dk>
References: <20230704165209.514591-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

This will be used by ublk zoned storage support.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/ublk.c | 2 +-
 drivers/block/ublk.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk.c b/drivers/block/ublk.c
index a0453619bf67..0b1ec102aaae 100644
--- a/drivers/block/ublk.c
+++ b/drivers/block/ublk.c
@@ -1947,7 +1947,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		UBLK_F_URING_CMD_COMP_IN_TASK;
 
 	/* GET_DATA isn't needed any more with USER_COPY */
-	if (ub->dev_info.flags & UBLK_F_USER_COPY)
+	if (ublk_dev_is_user_copy(ub))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
 	/* We are not ready to support zero copy */
diff --git a/drivers/block/ublk.h b/drivers/block/ublk.h
index 2a4ab721d513..fcbcc6b02aa0 100644
--- a/drivers/block/ublk.h
+++ b/drivers/block/ublk.h
@@ -100,4 +100,9 @@ struct ublk_io {
 	struct io_uring_cmd *cmd;
 };
 
+static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_USER_COPY;
+}
+
 #endif
-- 
2.41.0

