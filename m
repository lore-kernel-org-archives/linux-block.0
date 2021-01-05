Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347D0C433E0
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 13:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F338822AAE
	for <linux-block@archiver.kernel.org>; Tue,  5 Jan 2021 13:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbhAENzI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:55:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57470 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbhAENzI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 08:55:08 -0500
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1kwmn3-0000mw-Dj
        for linux-block@vger.kernel.org; Tue, 05 Jan 2021 13:54:25 +0000
Received: by mail-qk1-f198.google.com with SMTP id p13so25617083qki.14
        for <linux-block@vger.kernel.org>; Tue, 05 Jan 2021 05:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6bkVcoH66dTJHKJaimaUfYJ4BpIDTUExJd9+x2x7P4=;
        b=nimOYznLsAs0NXRf18Z0wVSDbCf13dCJmevRWpvEOsvU2+jg41DI/+7yVfPIpab3dT
         E0T2XOFCWvpDrY/qTtFKvhvJxD3s4OvMY4CckiAqXwjqLU3Jckp/A29N9ggWelCLoHYw
         uBRvWQ+t6gNOG1/l/rh9EE4ky8M5QSZ32Y6dgzCYYw2U4g7ohHi2DzWCVyjUMWHAV8u1
         rjz6Pu+FXyWbvgujqtidM+WsLjvBSefHq4aJljRqWCb2f2fYPbR3aiTGB9qhZ4R70tBf
         dvsCeB/Z1qY19cQNFfpR26oPV2vA3qyOwrnpyqEdn0c/ibZNXqqw//zasSLZG3zplhcI
         os0Q==
X-Gm-Message-State: AOAM5311BgmEAcjSs7eM5VozmTa8KdtLmPQ2o/I2ag/YzCxR2dfACBXS
        uSaIhfpc7qTvfdY28noKNQR1WYXpNv+FJMCFX/B/Vvl9lfFRgJtfKeIHFdROKNHmqt180rNLUaL
        L2MFygVMT3jFeRNjS/4q5BsCUf1osVlmW/DGDSSD1
X-Received: by 2002:a37:4116:: with SMTP id o22mr59422152qka.236.1609854864142;
        Tue, 05 Jan 2021 05:54:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzDrCN01MAvxktaM9U7etfK+SeoYWuLSizINEg2QENAoBT1ZkgNSkoFQxdAnmm8brcx7zCnQ==
X-Received: by 2002:a37:4116:: with SMTP id o22mr59422141qka.236.1609854863954;
        Tue, 05 Jan 2021 05:54:23 -0800 (PST)
Received: from localhost.localdomain ([201.82.34.122])
        by smtp.gmail.com with ESMTPSA id b78sm34209011qkg.29.2021.01.05.05.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:54:23 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Eric Desrochers <eric.desrochers@canonical.com>
Subject: [PATCH v2] loop: fix I/O error on fsync() in detached loop devices
Date:   Tue,  5 Jan 2021 10:54:19 -0300
Message-Id: <20210105135419.68715-1-mfo@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's an I/O error on fsync() in a detached loop device
if it has been previously attached.

The issue is write cache is enabled in the attach path in
loop_configure() but it isn't disabled in the detach path;
thus it remains enabled in the block device regardless of
whether it is attached or not.

Now fsync() can get an I/O request that will just be failed
later in loop_queue_rq() as device's state is not 'Lo_bound'.

So, disable write cache in the detach path.

Test-case:

    # DEV=/dev/loop7

    # IMG=/tmp/image
    # truncate --size 1M $IMG

    # losetup $DEV $IMG
    # losetup -d $DEV

Before:

    # strace -e fsync parted -s $DEV print 2>&1 | grep fsync
    fsync(3)                                = -1 EIO (Input/output error)
    Warning: Error fsyncing/closing /dev/loop7: Input/output error
    [  982.529929] blk_update_request: I/O error, dev loop7, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0

After:

    # strace -e fsync parted -s $DEV print 2>&1 | grep fsync
    fsync(3)                                = 0

Co-developed-by: Eric Desrochers <eric.desrochers@canonical.com>
Signed-off-by: Eric Desrochers <eric.desrochers@canonical.com>
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Tested-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---

v2:
- Fix ordering of Co-developed-by:/Signed-off-by: tags. (thanks, Krisman)
- Add Tested-by: tag. (likewise.)

 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e5ff328f0917..49517482e061 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1212,6 +1212,9 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		goto out_unlock;
 	}
 
+	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY) && filp->f_op->fsync)
+		blk_queue_write_cache(lo->lo_queue, false, false);
+
 	/* freeze request queue during the transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
-- 
2.27.0

