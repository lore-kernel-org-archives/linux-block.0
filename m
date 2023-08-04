Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1563CC04A94
	for <linux-block@archiver.kernel.org>; Fri,  4 Aug 2023 11:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjHDLqY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Aug 2023 07:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjHDLqV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Aug 2023 07:46:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC226128
        for <linux-block@vger.kernel.org>; Fri,  4 Aug 2023 04:46:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c1f6f3884so278069066b.0
        for <linux-block@vger.kernel.org>; Fri, 04 Aug 2023 04:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1691149572; x=1691754372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngj/h6FVXWzaXcOU3qKFEOyCMSzua1y3RfSgTGuGcj4=;
        b=Gci5XiM2gbNQ3sH2Aw1TjX010iTrsiC/9UcDBGlVhKReHYHeXVQ3O6luHDQJe79H5T
         ipRqhTHQhdcmmWh7ySeumvysj3Dbmf/O04dTS6GIIN+7BfpLceEQKMSVuXE9zkrWfmlT
         znTpxK+OzdbsY0bt2WBs0Y2TTm+mw6rHGTnpHPaH66qjA2zmHAr1cJYNp/pOM5+SaGAY
         8HAWPUFC/NsL9SI81AKtAd5c2LE2VkUGLHVGEvQCRxJU/TJ/UK2MfVkBlsYI5qIaDW8i
         mOWKzUywKPx3MY9fQ7lsc9Z3XAHwRDgCiBTtPgH+yGSoRqZc/+X+TXMtvYWEJYogvyn/
         9aCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691149572; x=1691754372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngj/h6FVXWzaXcOU3qKFEOyCMSzua1y3RfSgTGuGcj4=;
        b=cRRw29LZ7uBF52HcbrdHjIqGoxD6vrSumz4V4L2uzogDuXBSYgqn0KGs6AeCYm1o6y
         oKBbdX/jBVGVh13Dk+pwj2jKZRozVZ9Og2PsrYG8Qw/k6St4BPkFMAvExXm66Imi6+YO
         hKutO8yfCRCHEZzJEDL0z85w21YvbDu3XPzuaAd95/yj0gNFkkytF8M6Iiu5gJ2WoaGj
         gYZUa0C014TI/OG7WmkghWnyPIkkdc1ddjXqFvQT0TTmgNHtswmqIWkHK+2kNlNYUr6f
         4ICcEY/izYQX+LJY3X2ysY0aYq6GX3R+ppG012WBCINJMh0CsWNaDLNK6VCBhWpHVEGX
         Vryw==
X-Gm-Message-State: AOJu0YxsqsKTFLh+ZTDMghP3XDr+hMOHffYYfYzxOQe+egtErARxZtm0
        H2AH0dQPFPaQ0TV8wk/LKIlYtQ==
X-Google-Smtp-Source: AGHT+IHf3HUqYYDZViZxN8vB0sfZlkzyKgL8xLPzD659WQUbP5cV61iKjQUcyGDitHeIcwaDzOrffw==
X-Received: by 2002:a17:906:2ca:b0:99c:9e69:6a19 with SMTP id 10-20020a17090602ca00b0099c9e696a19mr1528787ejk.18.1691149572527;
        Fri, 04 Aug 2023 04:46:12 -0700 (PDT)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id gt7-20020a170906f20700b00988b86d6c7csm1189295ejb.132.2023.08.04.04.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 04:46:12 -0700 (PDT)
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v11 1/3] ublk: add helper to check if device supports user copy
Date:   Fri,  4 Aug 2023 13:46:08 +0200
Message-ID: <20230804114610.179530-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804114610.179530-1-nmi@metaspace.dk>
References: <20230804114610.179530-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

This will be used by ublk zoned storage support.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/ublk_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 21d2e71c5514..db3523e281a6 100644
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
 
@@ -2038,7 +2043,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		UBLK_F_URING_CMD_COMP_IN_TASK;
 
 	/* GET_DATA isn't needed any more with USER_COPY */
-	if (ub->dev_info.flags & UBLK_F_USER_COPY)
+	if (ublk_dev_is_user_copy(ub))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
 	/* We are not ready to support zero copy */
-- 
2.41.0

