Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AE5C001B0
	for <linux-block@archiver.kernel.org>; Thu,  6 Jul 2023 13:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjGFNJl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jul 2023 09:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjGFNJj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 09:09:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1323D1BF4
        for <linux-block@vger.kernel.org>; Thu,  6 Jul 2023 06:09:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so5631725e9.1
        for <linux-block@vger.kernel.org>; Thu, 06 Jul 2023 06:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688648973; x=1691240973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLXkkNKLC2QFI1E0y4rm62aHVfDJbTTFbFsFl9CT7J4=;
        b=HCaK+PrqspwGk54iH8oYp3wJQ5uxRgIn42NvEuBjDiaeAAgDfTHkpHQsHMbahhGoH1
         RKXlQnPU9osRpZE7aC6KqnUcproBMndzGwFm6CQ36CZSudGdOBUiaUs2WMHz/DEZcEis
         RG53ughv1yul1OJUlwhicAkFdEM0HfLZy9ny5Eq68kSOeMauH4xHljsuZPXmS4IMSK0E
         M2zUkmMh6pI/62DwdUdVYi0dj8hYARngR0uWYLv6vxm+NnwEw9Pirc/525HDwglhYz1P
         QvhxtimiOuEb9U0siUR4f/66w8t44Meg+vnvFSKM0PEek2yAKri/mbwPlSJwWq1PYgBG
         Kp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688648973; x=1691240973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLXkkNKLC2QFI1E0y4rm62aHVfDJbTTFbFsFl9CT7J4=;
        b=LiqOCBr+uYBj+fHzas7Bmirp0DmAzaqsUICPhmHtOJmaDCKMlLg200NBLG2e31vdXQ
         c+LGYdk4KX4ZsQb5QXGgS48eLagwHLQdmKXb6z3b1+UIvuqWS0bIfMvasLfjMqdx2+mi
         B9gW/1Gys/u4WUcLLdjUWA6nwKZB8TzGHAoY0uJTJ03n0hn9P9PZ8jgS4kDGl7zpErKh
         RxzRZvB/Q9UHNTNvbyo/vduM4PzwcC8/ZdMqA8vt2A41fB+LNCh8oJI/QVtUvfwu0SKx
         ZYYbH2NxDIgwrlJlReJ1RYp5p5gGJDvgamWpcvbMoL5p2UKGbGw/pBL56BieiWGk4TD1
         T93w==
X-Gm-Message-State: ABy/qLb7JXO5Cupzk/YxqWn2aIT4jD+Zhm3QGc7rQRHdKalT1nCX9Q/u
        7eqsEsrEv1vNTRIYWKRplKoI2w==
X-Google-Smtp-Source: APBJJlFB+qpleKgONzSTxXQuqAVtfXTGpYN1gLVi/RnauHtKMpAXou/EH0Py/ipYIWgRvAZM6J/Ftg==
X-Received: by 2002:a05:600c:a6a2:b0:3fa:955a:9291 with SMTP id ip34-20020a05600ca6a200b003fa955a9291mr4923212wmb.9.1688648973370;
        Thu, 06 Jul 2023 06:09:33 -0700 (PDT)
Received: from localhost ([147.161.155.79])
        by smtp.gmail.com with ESMTPSA id h16-20020adff4d0000000b0031134bcdacdsm1869763wrp.42.2023.07.06.06.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:09:33 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org (open list),
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v6 2/3] ublk: add helper to check if device supports user copy
Date:   Thu,  6 Jul 2023 15:09:29 +0200
Message-ID: <20230706130930.64283-3-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706130930.64283-1-nmi@metaspace.dk>
References: <20230706130930.64283-1-nmi@metaspace.dk>
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

