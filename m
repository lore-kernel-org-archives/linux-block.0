Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A163C433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 20:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbiDFUuW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiDFUuL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 16:50:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A2D3C43A6
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 12:05:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k23so6254093ejd.3
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WBo84nT6kplZvgHB/vdnS5/ZWvTiH4Rb4kDlRvn9tbE=;
        b=dCGktYBy5F1Zx0GypibmKeIOPcSKF5c1cY/Ymuk0WBP7hPMGCDgjNRpbJMaQmdUOcr
         gYSZr4Xhd5VbpijEI6kF2oECiMU2X6ZhLOtNRD8gJAwspNro6z6CEGPcE2dgt9XRiIkC
         wc/rLKlbEyJFdPr5AQHhwjk5wu39+KKg9427rtjmOLKqwEvjkX7pMAL6+nV2iEtorSWX
         QFP2g5iOxpD+6UCmitRVP30PgKOdhyq37ownMQEIANHhWgmGXh4+02nZFUFFjYzZhkm0
         +qi0Vs00ytlIggtFPN3+Qo5e9UzGuCw2MtSPOYYY3lYKpQwCtfO6cInsqiDo+9v+dmy3
         MWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WBo84nT6kplZvgHB/vdnS5/ZWvTiH4Rb4kDlRvn9tbE=;
        b=pEYOOvRNwl1vbQCtnfaKoLjHofWJXZGMRyZDNQzw1upKqMvANjbYGifc9t23BzPGee
         mwQDftssag86ljpdu/3oGVNhaa+I0PhsgmoUW9+XYIKRdAl88EwXU+ULDSbPnXdjpA7K
         7qL2eNbWhgmXJD5SopYWTrw6iDePBQd6X39iHxe4Mp2VjKVBbn+p5evyaeA4hs3l4xxX
         g+DIqKm7B3a/XPM6Hnx6wkaFU/guyaHt/7tADCpG2Q1lSNSClg3WHhvKUEl61OOfbKDP
         Rs8/cwr8sX6Ta8pGRm8w0hYdqn758ap0N2EOqulIVlgvOe7GL/qVxkh7UFqhPse3lC1w
         sdMQ==
X-Gm-Message-State: AOAM5317D+ry4SOofAYPsjtgYyNvd82os9Ylr5cTytAmUm5gKN90DKty
        TKe2KF6U8ZhFa/rHx43Mawua9A==
X-Google-Smtp-Source: ABdhPJyTsMFP8wBllOYfilYBbOCNHenhYc+BnrBSgdiicw0iXsw0UvHmIIMoOuvBBoLpOu2XvVZrfg==
X-Received: by 2002:a17:907:6ea7:b0:6df:c5a2:89ca with SMTP id sh39-20020a1709076ea700b006dfc5a289camr9769965ejc.18.1649271934152;
        Wed, 06 Apr 2022 12:05:34 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id hr38-20020a1709073fa600b006e0280f3bbdsm6914682ejc.110.2022.04.06.12.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:05:33 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph@boehmwalder.at>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 3/3] drbd: set QUEUE_FLAG_STABLE_WRITES
Date:   Wed,  6 Apr 2022 21:04:45 +0200
Message-Id: <20220406190445.1937206-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
References: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Böhmwalder <christoph@boehmwalder.at>

We want our pages not to change while they are being written.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index d6dfa286ddb3..4b0b25cc916e 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2719,6 +2719,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	sprintf(disk->disk_name, "drbd%d", minor);
 	disk->private_data = device;
 
+	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 	blk_queue_write_cache(disk->queue, true, true);
 	/* Setting the max_hw_sectors to an odd value of 8kibyte here
 	   This triggers a max_bio_size message upon first attach or connect */
-- 
2.35.1

