Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A885AEB64DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 07:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGKHYJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 03:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGKHYI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 03:24:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC992E6F
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 00:24:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso8575816e87.0
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 00:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1689060244; x=1691652244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLXkkNKLC2QFI1E0y4rm62aHVfDJbTTFbFsFl9CT7J4=;
        b=Ftypam7peF0jzVg1jOvJGykz+ctIhQtlZw9llhkyUUbT5jfcOz2NmfqvHqqQjxymx/
         TSBs8G4zUCEPFFMORMYNJwU2gf8PWgaF8fm/Lmw1+asDemT/L7Q6Fqqq5nsD6sxNLcFQ
         CLKrsWdjxq79XTDMdsaRq0x1ebYoMl7MexdqdAVHxW8Hwm9TXzjuEu+4+UZwJspiN0kX
         7IdFVFoqRNEtTjp9HvhUiGZ/RjY0ZHscDP6tI0iaWjm0ti26N/85za5ra+bn3FIkK/vq
         OSnVg+RccPykMBoVKEVz7gro2oKGkkGjcF8JOeyeYrHiK/UjVaOogzXhNJ5k/DF52qp6
         DyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689060244; x=1691652244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLXkkNKLC2QFI1E0y4rm62aHVfDJbTTFbFsFl9CT7J4=;
        b=Q3RB+WWYTJsW6AIGTyX6n4htdDb9H7atKLJ1lnEVgOxMuZGdHZcUofDA3FeVt46Rj+
         An3X0A+9SKAmP0uEMnb5PE4L/LAokJ4rsmLJeAvMpsp6tL2EzcGPjJrXdekNC+qQg9Nc
         2nYw+1qaH2sjiG257ahXPWm2Xd4LaZX4o/1hJrDZIjNWR4mY40Uh4P0fycMaZxj7+Xov
         xM5/87kfY8CndVyVjPEoDgFAlxUmxGvPodROwjsu2DcUYqJiHxenQeduHWSrQS+G6EGF
         8Aqin27x/YJwLpzMEgBKPIgi1hZPNSyG3qiibKNwq/F0QXfQaRzQfbQ0DtTV7kfii71A
         5eKQ==
X-Gm-Message-State: ABy/qLYwKe0VSJuUg7ZhrBnpE9dfxXCo8eiwgIRBaTB3pm5frRdADswr
        hr8WookS5rfArd4OUYo++YOmIg==
X-Google-Smtp-Source: APBJJlFJITQ7e41WIb3Lta+hpyz2Vn/KTvN5favGapGXaEAY7o32K29tdoLFTHK4aD4iWSgWczXDvw==
X-Received: by 2002:a19:645e:0:b0:4fb:8948:2b2b with SMTP id b30-20020a19645e000000b004fb89482b2bmr10837808lfj.48.1689060244068;
        Tue, 11 Jul 2023 00:24:04 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id b24-20020ac247f8000000b004fbb0ccbc9csm206562lfp.83.2023.07.11.00.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 00:24:03 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org (open list),
        Andreas Hindborg <a.hindborg@samsung.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v8 1/2] ublk: add helper to check if device supports user copy
Date:   Tue, 11 Jul 2023 09:23:52 +0200
Message-ID: <20230711072353.200873-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711072353.200873-1-nmi@metaspace.dk>
References: <20230711072353.200873-1-nmi@metaspace.dk>
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

