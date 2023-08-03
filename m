Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A218C04FE0
	for <linux-block@archiver.kernel.org>; Thu,  3 Aug 2023 14:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbjHCOJM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Aug 2023 10:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjHCOHj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Aug 2023 10:07:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2573D1981
        for <linux-block@vger.kernel.org>; Thu,  3 Aug 2023 07:07:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so10266265e9.0
        for <linux-block@vger.kernel.org>; Thu, 03 Aug 2023 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1691071623; x=1691676423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydP3wnsF1pXfr8UcrivUcEsOvukWSLMo7a415cMrAHs=;
        b=OjtJM/nkriW9jx50qLggedJ+U1aQRSLZyEGsiGSnvEfeE5QZQyIzzSsC2k/epCIE/o
         idc1C4rRKbMJqyvBEnauXWdgXYMFQVOphMhCbCrNcFQQ4T1IAGTNJle1GQpvzg2nopde
         wsAcyKHbbWu3mTB43z7E3aVUeSo3V/quADfX6prtI1NQDwMr6Mzmm3LKJmoLr+C7nBSl
         8cDUxeRroI7FIXdzz6i88afLO+zOiJ7eYpMWeV1+10wVP4T446Ta1kpaNSiIc7MPXj+q
         ITEO2ctuvBjhdRC7ocip47GtHNHag4yKuR4WF/18X4Yo5Xhndy598klglTrcKfyIMC05
         lSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071623; x=1691676423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydP3wnsF1pXfr8UcrivUcEsOvukWSLMo7a415cMrAHs=;
        b=ibnv3m3m4OA7HHWlrCYujYeqkrnECMMwqKvlBA6aaGlgZGV3ibMVHDJQ9ynqmJ/Lz1
         4QqCvpqG4wfhtKrA+jrWTaAnFasYpHX/Iksi3y3ylvIpEFJZFlB7j9iPRB+GT+U5h4BQ
         CR/02ReQAc8zVzpzNlSt07kaPmEw8w5dqCQ2myfWSmiGcovbgKQ6IrruyPhQgnBpaq8c
         gd+zHtVbrFv+FTN6SvA8Tzw794BryfeGCmMIt9Js8Rolce4yCzhPqO87xcUs5LmyOPq7
         YHJ7vkiW+Xn/HOAeJVi4sd5pGopa+WA11gwvFTlbW0eHUkup+O/Oo2ryAWEoCHfV4lOy
         u3sQ==
X-Gm-Message-State: ABy/qLZ/2YcSf7BkgxpG276pxjxezIU5gOygyN7nY5kWOQdDSkYOctng
        JMKOlmK3lDUO7yHgGNxDx0fWeA==
X-Google-Smtp-Source: APBJJlE3kMUOStkt+hZLijiQt1myR7ouXu6xsDqBbkPdSSoOlgHgEmT7GMfkpaOnTZWdBhm4TLhTcg==
X-Received: by 2002:a05:600c:20cb:b0:3f8:2777:15e with SMTP id y11-20020a05600c20cb00b003f82777015emr6971357wmm.31.1691071623450;
        Thu, 03 Aug 2023 07:07:03 -0700 (PDT)
Received: from localhost ([147.161.155.117])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c210600b003fbc0a49b57sm24351wml.6.2023.08.03.07.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:07:03 -0700 (PDT)
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 1/3] ublk: add helper to check if device supports user copy
Date:   Thu,  3 Aug 2023 16:06:59 +0200
Message-ID: <20230803140701.18515-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803140701.18515-1-nmi@metaspace.dk>
References: <20230803140701.18515-1-nmi@metaspace.dk>
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

