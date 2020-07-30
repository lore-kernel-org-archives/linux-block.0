Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56794C433E3
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 09:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D70A20809
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 09:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Hx/w5aIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgG3JOK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgG3JOJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 05:14:09 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D3BC0619D4
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 02:14:08 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f24so6730540ejx.6
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 02:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sXkOA+BkwA5OHnpvqUuJaktKTRqEyjklZL4P/+oYloE=;
        b=Hx/w5aIrZSrntkNVwdEObpNy+exzvawRdGzm3iL7BtOCGg82IyHzYnsbgSUMGg6R1l
         yxMy5QFvFLiAKp2iSW2LL7DrIL7dJ2efxSDlXid1FLMP1dHxO6zYaZh0/7qVBiPOC2Xd
         SOpSzjgQ8QY1fG7hAG9GEy+PxaP1FkfIKNTwi4VCvrecLHYfon7TvXHoN5GeRvp8F86p
         LbGlPiLsJiTuTj3q8Ro3lWc8+Q4eUV8d79ryW0Nd9EV46Wk3UVT/XOq5hi/ZPduzfyOn
         CPBiv5OGGVIcnG99KyK71qj/wanpmeIUYkLmjV+IBY/I8i/6bVYMQ1kDZ69HURR0RXGg
         bPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sXkOA+BkwA5OHnpvqUuJaktKTRqEyjklZL4P/+oYloE=;
        b=d2hHKgtLGY8FJ3Ukk9FtFIcLLee3j7FsOpmmWYJDqjKgflQchFECIBOMoE5wPxW3xP
         l5YftNlKHXPfGzLwiF8OIoE+vRr1qVwxXbX958Ynqey46vtujfZXmz1ORv6P0sf72OBW
         avLf14jfp22d3+JBXn0daGwXVtH9HOwxMdKfj3my+gu1yWLsQ0v/4y1iIsX9Ks/GWs7+
         dc9Ur17VpEvDrf2BoIRl45nXAVoIVRVv1Y1DuC3sivjj2CiA3YoLcu6k6kjDC021kOAr
         S8+j2/Y1EpV3Fc4ZgtO6V2z2vR/x6UEDqM1bL+su3AxjRwQkprKEUR+SiqjJbJts9fuY
         3/tQ==
X-Gm-Message-State: AOAM533VrgO0cbYCULCUiAHJTmCxKMVl/9p1lKGvi/3CNCmy4yEibrdQ
        7tj4ehHi+wLrqHg/JgYqizlDhA==
X-Google-Smtp-Source: ABdhPJxDpNAR0m5VWPjGw6ZcPPnKWT4pHNCRy+RReNQO7qFChoivVK6F7Zv6W3DIfVH+xMPPVlE1tA==
X-Received: by 2002:a17:906:2451:: with SMTP id a17mr1610302ejb.274.1596100447174;
        Thu, 30 Jul 2020 02:14:07 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b189:874e:eb6c:1105])
        by smtp.gmail.com with ESMTPSA id c7sm5002955ejr.77.2020.07.30.02.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:14:06 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 2/2] rnbd: no need to set bi_end_io in rnbd_bio_map_kern
Date:   Thu, 30 Jul 2020 11:13:58 +0200
Message-Id: <20200730091358.9481-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200730091358.9481-1-guoqing.jiang@cloud.ionos.com>
References: <20200730091358.9481-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since we always set bi_end_io after call rnbd_bio_map_kern, so the
setting in rnbd_bio_map_kern is redundant.

Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-srv-dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
index 49c62b506c9b..b241a099aeae 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.c
+++ b/drivers/block/rnbd/rnbd-srv-dev.c
@@ -99,6 +99,5 @@ struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
 		offset = 0;
 	}
 
-	bio->bi_end_io = bio_put;
 	return bio;
 }
-- 
2.17.1

