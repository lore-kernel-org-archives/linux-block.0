Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B045C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 10:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0810B60E8F
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 10:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhJYKZG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 06:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhJYKZF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 06:25:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6379DC061745;
        Mon, 25 Oct 2021 03:22:43 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b133-20020a1c808b000000b0032ca4d18aebso8777735wmd.2;
        Mon, 25 Oct 2021 03:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/v3aTmY6XrV92INgsrvwzQWFGFwQpZ9HQPph277prA=;
        b=GYbWWMsnURkXGGp1PoFpID23yf8F1x8RfVvLfmWS7PueS46dzy4x4eufuCidSEPh98
         JqWj+4oW5EmDqxli9KZNc14lH1Pmi4kkhbrbGeH5x6177Y2jvYzWvhehjV8FqBSqsUMt
         etpUGnrPj3oGC7jN1xq7TQA8adA0hXosEAVfyAUXfsoqxSb0wRxJQV64qmMKt7ajirQI
         aRyGEZ4OfXUW+BTT3styhnyL/duVNPNWKG4yxu9ZZV1yuU16rAm3jtnHwJN/6AeuEgi1
         7vU/SfFPORMJANBlUlZ54BWMOK/HNRsEiJ+DEDse9+NaMTMAI4UlIExhSheCb6Pj29qk
         zmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/v3aTmY6XrV92INgsrvwzQWFGFwQpZ9HQPph277prA=;
        b=LBtciz6Q8FbvgBSo+zFyj2S6VfesEB0m2YRCUubGR8at+xh9c+4J7/fvckL64IfsvG
         i9eejNvotxTzP4WCtEUYSLlFsERwdyg5ql/utM9xLl8xb2x0x2V9V4M5iFgCNM1OX026
         WOMqvOPGGKR2+6S3w9RoEf9mAp/Ckex/BiRhk5zmnVTqqLdy/3d95yQBaKM4JBABZj23
         AqTFjXDHFk03v1u8/TxePrURgwl1jhybCHVG+0xeSefYgd6BVefj35EZFcM4t1b8r6E4
         1Eam/5bIuD+vwHFaGPEl5vkTv2RCuFAUebzKiOH9toISmAYy2Jzd9AGx/9R0pGekFiE0
         EvoQ==
X-Gm-Message-State: AOAM530JK8vHOqL4T9uTHWc67RfO6hGba+U5wD85OZzQ0aPSkBla8WsJ
        kaClzv3TfvTTjQPFn4G1PBxazumbSg==
X-Google-Smtp-Source: ABdhPJyWcwT5Ev78vLpfF86xc/1OXdyC8ApSJb261oiBgz+BRZ1m0IVEHDWS+kdw/Rox9wetyG1E6Q==
X-Received: by 2002:a7b:c31a:: with SMTP id k26mr32243577wmj.187.1635157362026;
        Mon, 25 Oct 2021 03:22:42 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id s3sm17020493wmh.30.2021.10.25.03.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 03:22:41 -0700 (PDT)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] virtio_blk: Fix spelling mistake: "advertisted" -> "advertised"
Date:   Mon, 25 Oct 2021 11:22:40 +0100
Message-Id: <20211025102240.22801-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a spelling mistake in a dev_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c336d9bb9105..9dd0099d2bd2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -560,7 +560,7 @@ static int init_vq(struct virtio_blk *vblk)
 	if (err)
 		num_vqs = 1;
 	if (!err && !num_vqs) {
-		dev_err(&vdev->dev, "MQ advertisted but zero queues reported\n");
+		dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
 		return -EINVAL;
 	}
 
-- 
2.32.0

