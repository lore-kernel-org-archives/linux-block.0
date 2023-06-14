Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71613EB64D8
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 14:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbjFNONt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245455AbjFNONs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 10:13:48 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD1BCD
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 07:13:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b3ce6607cbso28372225ad.2
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686752027; x=1689344027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=atkhLsJk4kYIR051jZUJsqhyVSqD17cKG1dfd3E+c04=;
        b=QtPPdAz8+r7dt+3azArNI+jobqYcT5F/K5n1989N0B9h/dF9O0THNdPrbOgk401sv3
         5J4d7liK3gdJtZ9cdamd5TvGz8tspTsfmQzlUei3suVhQyLyrh3DkFHy4rVZlSHdPsr5
         YEErmKXQc4bgS24oNRScFjmmHUyABKOtOISkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686752027; x=1689344027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atkhLsJk4kYIR051jZUJsqhyVSqD17cKG1dfd3E+c04=;
        b=O3hdyKMIFvnLGM6MJ45DBLy/f0fI+6cx5H+dT5EMc5n4Wj41heL4cz4f0gFIlCR2P3
         aTwUfwdOwdM1Pxs/W3dKqv5HVtFl7rbbpeYsPx3n1atbWeFrhL6sgpSs87RrcORmjWHd
         Ll0c0Ji9OZH5tn2ozKBrEqvbjytVQ4eHQBQVJe89o/tOpZSlQ9XoIL6/vlzZdt0NcVmM
         TflyBr3fRXpPHKb+pwOAUvwot3oK8P0Ylkv63q/jFGHo9W4tK4xMeKLmE7nDLqxRJwbO
         fNF5NdHgGLBYsanvD49ZX7D9kd0T7ZlcGxWZVd1ivXMYPmChJVtOT1sFgWWm/g7gizkO
         rulw==
X-Gm-Message-State: AC+VfDxrTKnPJq3m+Kg1h8AvO//GlD14wyw1hRX7AvsNgjNZ/6pr+HEy
        baCZbu2PI9v2bloh+px7u5UK6h2CjnoHlss8zYQ=
X-Google-Smtp-Source: ACHHUZ7c5hnOfemkMscvWj+eorrnWGExlzE2F7LXwlInsGAGaYBz8d88ceGN6cOoTGXRuvmWq7tQGg==
X-Received: by 2002:a17:903:124d:b0:1ac:aba5:7885 with SMTP id u13-20020a170903124d00b001acaba57885mr14900116plh.47.1686752027301;
        Wed, 14 Jun 2023 07:13:47 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:e1a3:812:fed0:eeab])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f55200b001b042c0939fsm12226648plf.99.2023.06.14.07.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:13:46 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brian Geffon <bgeffon@google.com>
Subject: [PATCH] zram: further limit recompression threshold
Date:   Wed, 14 Jun 2023 23:13:12 +0900
Message-ID: <20230614141338.3480029-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Recompression threshold should be below huge-size-class
watermark.

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

