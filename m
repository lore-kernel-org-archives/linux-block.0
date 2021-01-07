Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E12C433E0
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 18:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A795C233CF
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 18:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbhAGSSX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jan 2021 13:18:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49871 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbhAGSSW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jan 2021 13:18:22 -0500
Received: from mail-qk1-f199.google.com ([209.85.222.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1kxZqu-00078J-55
        for linux-block@vger.kernel.org; Thu, 07 Jan 2021 18:17:40 +0000
Received: by mail-qk1-f199.google.com with SMTP id x74so6876745qkb.12
        for <linux-block@vger.kernel.org>; Thu, 07 Jan 2021 10:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3X+scLEAwHcaQ88K7i7jawAfpaYGB5qjnrY9nAEImY=;
        b=TmHyRFY7Hmz5sAoNW6xina0AjxZNnKzkbJi5JyEJy6Xc0mi+4BcoE+FDESa02kaQhZ
         eVDUZcxVAr9XDwytkT59NFFE9Z3K2bvtTFcbs2KynKIyYW/vcR/YKvw9DoQ3oaRTpSww
         MlHM5R23gUQbhiJ/qIOA++8/ifcKkCtm4RSiqf0JFuB378qd5Qd4/BIXsIm1NNPPmNfa
         o3yMKYmOky+tlqAsZOMe9ps3aSlV520kpCbGpGJ9s9u15r5eZB/dYLmj2aSD7qkkCdTk
         WpDl2lEnbf5bUsrFF2Bq56pYg4A+W1zfecKt4zjNvZ5eCOuPtVeik+nbE1HFqbxc8Q7R
         kfnA==
X-Gm-Message-State: AOAM5330tdcCVuUxQR6S1o4RhrrdboERdSd/ukEmB8oUgIXv7pHVNXhi
        MsNWvMnFon1rrPu1f3+IU7DAhdqsB3EAq5bNqJ5w+ZheWbT0n6GLbZDY63DzfwKH05mOmHpmwCu
        DeGKXumrdFE9AiO44uPecN01nxVygOiSyNoxwnZx8
X-Received: by 2002:a05:622a:30e:: with SMTP id q14mr9812129qtw.77.1610043459081;
        Thu, 07 Jan 2021 10:17:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7zlnfaZ0ddOx2kBrn4YOzsWrdkIU1OsIRfmP+K3r0udmp2Fhg5iDCceNCs0+/+/0k4WbAqA==
X-Received: by 2002:a05:622a:30e:: with SMTP id q14mr9812112qtw.77.1610043458878;
        Thu, 07 Jan 2021 10:17:38 -0800 (PST)
Received: from localhost.localdomain ([201.82.34.122])
        by smtp.gmail.com with ESMTPSA id z78sm3633361qkb.0.2021.01.07.10.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 10:17:38 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Eric Desrochers <eric.desrochers@canonical.com>
Subject: [PATCH v3] loop: fix I/O error on fsync() in detached loop devices
Date:   Thu,  7 Jan 2021 15:17:34 -0300
Message-Id: <20210107181734.128296-1-mfo@canonical.com>
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

Do so based on the queue flag, not the loop device flag for
read-only (used to enable) as the queue flag can be changed
via sysfs even on read-only loop devices (e.g., losetup -r.)

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
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

v3:
- Disable write cache based on QUEUE_FLAG_WC, not just
  !LO_FLAGS_READ_ONLY, as the former can be enabled in
  sysfs even for LO_FLAGS_READ_ONLY, thus not disabled
  later. Mention that in commit message. (thanks, Ming)
v2:
- Fix ordering of Co-developed-by:/Signed-off-by: tags.
  (thanks, Krisman)
- Add Tested-by: tag. (likewise.)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e5ff328f0917..e94a11dbb5bd 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1212,6 +1212,9 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		goto out_unlock;
 	}
 
+	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
+		blk_queue_write_cache(lo->lo_queue, false, false);
+
 	/* freeze request queue during the transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
-- 
2.27.0

