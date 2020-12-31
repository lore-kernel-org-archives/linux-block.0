Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D58C433E0
	for <linux-block@archiver.kernel.org>; Thu, 31 Dec 2020 16:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69CD1223E0
	for <linux-block@archiver.kernel.org>; Thu, 31 Dec 2020 16:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbgLaQ3d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Dec 2020 11:29:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35395 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgLaQ3d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Dec 2020 11:29:33 -0500
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1kv0ol-0007F8-KT
        for linux-block@vger.kernel.org; Thu, 31 Dec 2020 16:28:51 +0000
Received: by mail-qk1-f197.google.com with SMTP id p21so14902425qke.6
        for <linux-block@vger.kernel.org>; Thu, 31 Dec 2020 08:28:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LC15KHp3+IKj1GNX+EAQR0lktZ2fCbra0Gw7Q4HqdPc=;
        b=ayedqpQX3f0fq37rlpwPLfkyidhf1hw5RO4CCjFqpO9bPeDfr780PQB7EHH+iyy2zG
         loMCKIKk9iP485ZkfEACr591thpM0FzJFIB5D8doswsZ50WbSWYBO3D5jcYKUm3BeuHB
         GNBXWiy4lDVGSxXUbeBtdewaRKC3grA7ujuB/0eWo7l8iIcjMUBnxTgxeNra6MfGrv9f
         fqHolYqrY6eCzu9lRbr9nIgmI4QBUmcawTqgkbe8Od798Awq6dkHgWemJ5YT7hAQPiRz
         TgzEDlAddmJLsHGT9W5mCoAikvoTqF1iTKFI6gbabF7KCxXbkgMI+Yapk39D0ftET9BT
         b98Q==
X-Gm-Message-State: AOAM533jRrXjt13097JNZXn471WnV8zQdkw0Y4L33ntC8us39FqLK+3i
        DDbE7j0YFkWSM8NA4kGdPh3BAxmExuqdXi9wZ4NRhMskknbggn1kVvfFj4EkXaYCeT1+z79Vtev
        710taOcsAOmUvL6rLsNfJA2RPjFGaTIA305A+dXt5
X-Received: by 2002:a37:e504:: with SMTP id e4mr60302733qkg.201.1609432130524;
        Thu, 31 Dec 2020 08:28:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7ha4/x40h9YZS51HZ85CqYZmKhDeWDnBOuH0K8FRFJH0wUAhEO74nxnAGjWSygnFd93keCA==
X-Received: by 2002:a37:e504:: with SMTP id e4mr60302725qkg.201.1609432130315;
        Thu, 31 Dec 2020 08:28:50 -0800 (PST)
Received: from localhost.localdomain ([201.82.34.122])
        by smtp.gmail.com with ESMTPSA id p23sm31302772qtu.53.2020.12.31.08.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 08:28:49 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] loop: fix I/O error on fsync() in detached loop devices
Date:   Thu, 31 Dec 2020 13:28:45 -0300
Message-Id: <20201231162845.1853347-1-mfo@canonical.com>
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

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Co-developed-by: Eric Desrochers <eric.desrochers@canonical.com>
Signed-off-by: Eric Desrochers <eric.desrochers@canonical.com>
---
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
2.25.1

