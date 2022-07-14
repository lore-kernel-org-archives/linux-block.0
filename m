Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8AEC43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbiGNSIJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbiGNSIH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:07 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F066872E
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:06 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id 5so1116111plk.9
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFlsbWSyv4GPZ9FafXSmAxwJE/x2EnPq8m3hs6DZcJk=;
        b=CYQOSmN7ES+J0X2IP8B35cdnA/mCVh9phyRx2AVzWYYeVlOi2OF60RVyE6mv7wwuIJ
         2jRYrFLtYVISnZEyik3okgHgv3hkCXTn3ibfK9+TGxHuSNbazdbATI0i7BREdfETyKW2
         qWGP6j3aNJLTM3epA9S/gNvUbU4gFc8rvQU/ReJucC81Ni6YdwmOz2+3KjaUAUkrzTLW
         8NTq8qsr+ydSwH3XkhGG2aP/Pc5EWu9wvcREhUuu7K8M6/EeSVTmLSyovhboeSz5arFY
         HlVpp3jMlarmhCfA5xJngFN3gWZKyx3NxQn29B54f/H4lAYx6TvWh2vXHfvO+S6n/gvx
         tpYg==
X-Gm-Message-State: AJIora+aChBlUkYJWwMtbSTvijK0wyWlcYwe8hyCDDmORDOFtecjLQ4y
        ukYVyXbVNVUdnCh8/MThAYA=
X-Google-Smtp-Source: AGRyM1tF17lYBEiYZjfUF5BdLKznqe0DAl5glD3tw3Kd8qcSYf3SPjdPrCSBJbYmOxVGOUqnI39e5A==
X-Received: by 2002:a17:902:c641:b0:16b:dd82:c04 with SMTP id s1-20020a170902c64100b0016bdd820c04mr9408768pls.144.1657822085545;
        Thu, 14 Jul 2022 11:08:05 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:04 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 18/63] block/zram: Use enum req_op where appropriate
Date:   Thu, 14 Jul 2022 11:06:44 -0700
Message-Id: <20220714180729.1065367-19-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type where
appropriate.

Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a35b86c58aa2..4abeb261b833 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1523,7 +1523,7 @@ static void zram_bio_discard(struct zram *zram, u32 index,
  * Returns 1 if IO request was successfully submitted.
  */
 static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
-			int offset, unsigned int op, struct bio *bio)
+			int offset, enum req_op op, struct bio *bio)
 {
 	int ret;
 
