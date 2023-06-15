Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EACEB64D8
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 01:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbjFOBbd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbjFOBbc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 21:31:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624C8212A
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 18:31:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b4fef08c71so10811605ad.0
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 18:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686792691; x=1689384691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hx/F41WmoagRHV/54mU3GIZ0Rr4r8+ldlSacsREhph0=;
        b=RlbJpt/LYH+6wShImnDyT/vnic79PMh24HXKnIOo2SBShDTz6PgzaEV8qDJwyuSSwv
         Kv/C+msLxEQjsxmv+SScprcnneAD/ul0vJaLDiffndK/A1oVu5zvrrSRBVlcIeygc9It
         aEwsENZb0IstuPWrUi5VWjzEhHz1syRUYcrq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686792691; x=1689384691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hx/F41WmoagRHV/54mU3GIZ0Rr4r8+ldlSacsREhph0=;
        b=jdDJxc9RxaJjGJx/pvb8zPXVXuBxqUbuN1kZXun6a684mki9BRegzxaFOTAVV3bTuF
         ZH1yH4u9g8yU9Hqj3RL27VzEtA34x+rKPUJ4AuryLgYNFcw/LGQkFIIXcCX60xj/mJaG
         Du9jA2e6qVIoGMb8AUr025NEIvd3/zMoqemqcjRzflkmDiHC21p7P5tJhO5vdebabunK
         F1n0cpzB9erY36I1MD24x16EGI+6ZsBUH2NdTU6+MtzsgdQBRYDh1T0A6EtynqkxXfG6
         O7ciEPXG52ZNXvCeetoA42Yb/nrwAwT0jNCx1+gNx+OuJR/M6+0AmyOicQDGaZY4eiyI
         ABug==
X-Gm-Message-State: AC+VfDwLiHulTFpUqeCZ4ZSE81lnBTzK0EgWc2uaGME0mECJZLocGIAk
        6XVN8hEd2lHiHZw1AYrEfqr5Qg==
X-Google-Smtp-Source: ACHHUZ6imJV4tdkMAZGbqKKz9yGtfgME6SpsoWFSbHJHRTkI03u6IBqYRU7NSiIC5O+8Kpr8vFtBSQ==
X-Received: by 2002:a17:903:32c7:b0:1b0:4c32:5d6d with SMTP id i7-20020a17090332c700b001b04c325d6dmr18495150plr.31.1686792690899;
        Wed, 14 Jun 2023 18:31:30 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:e1a3:812:fed0:eeab])
        by smtp.gmail.com with ESMTPSA id w22-20020a170902d71600b001a64851087bsm3925829ply.272.2023.06.14.18.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 18:31:30 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brian Geffon <bgeffon@google.com>
Subject: [PATCHv2] zram: further limit recompression threshold
Date:   Thu, 15 Jun 2023 10:30:20 +0900
Message-ID: <20230615013122.3564479-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Recompression threshold should be below huge-size-class watermark.
Any object larger than huge-size-class is a "huge object" and
occupies a whole physical page on the zsmalloc side, in other
words it's incompressible, as far as zsmalloc is concerned.

Suggested-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1867f378b319..5676e6dd5b16 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1753,7 +1753,7 @@ static ssize_t recompress_store(struct device *dev,
 		}
 	}
 
-	if (threshold >= PAGE_SIZE)
+	if (threshold >= huge_class_size)
 		return -EINVAL;
 
 	down_read(&zram->init_lock);
-- 
2.41.0.162.gfafddb0af9-goog

