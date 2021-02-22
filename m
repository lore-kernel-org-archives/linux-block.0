Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD82C433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 15:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD5D64E74
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 15:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhBVPmf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:42:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39861 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhBVPm1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 10:42:27 -0500
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1lEDLD-00019c-Cy
        for linux-block@vger.kernel.org; Mon, 22 Feb 2021 15:41:43 +0000
Received: by mail-qk1-f197.google.com with SMTP id r15so9436861qke.5
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 07:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vrhpPKzimuceCgC93oDFemcstTw5fQ1szdLIsIshKp8=;
        b=cyVJFDfMz2KfpcI7+3Fw3BJ+A/YrCteZFjhYMIyah/eYrqjcTDeQrHuswV1072QbLU
         TxXeEbK76AfM38ZDG+667t+6kfVjWA8yItaD3XbCQUL5HOmlOETPGqJP9q2km1pnx7gw
         QZ2PfMS+9z1W2bDle+V/qMlkcgSmGfV5Gkrq1wmf1ObtdwS3kWvvKzpQ7kEYNDX/+NVc
         xkqdPba2CbA1hh+BhZjhHbEWHupo4cgc9pvvSQm9TYUjS9QwevAmb4OpkcXu1J7EIOJb
         tkaP3LCUx1+Z1S0og72P2ISsS3s2lW7TnAZx1Yfxl82SAZoEw/nOoGqNqh1cEXNROcwV
         SJlA==
X-Gm-Message-State: AOAM532rIIvrjZU1eKnFCaWMZO+j32URO0QrdJMXhTVBonEJt+Y8PQTd
        dK2jiYuORF6WMwDV5/esXHcznfnHynftvcTmJ/cVj8ACgCoFRJzbSZwLnSgimq/FreRE1o+ZvOZ
        4ic9ScQtWXpVyh9NDb879B7HacYA9BTqC6rXLX5D/
X-Received: by 2002:ac8:5651:: with SMTP id 17mr7326055qtt.16.1614008502513;
        Mon, 22 Feb 2021 07:41:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLhXaaiCO/evjVkr0RG8kQA1G6hbwR1y4mKbBd/mknD20/5MsrTSVXO4jf0eDsCLl4XtmVbg==
X-Received: by 2002:ac8:5651:: with SMTP id 17mr7326028qtt.16.1614008502247;
        Mon, 22 Feb 2021 07:41:42 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:4e6:9293:753:8a4c:6a34:9239])
        by smtp.gmail.com with ESMTPSA id j2sm12336978qkk.96.2021.02.22.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:41:41 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        krisman@collabora.com, eric.desrochers@canonical.com
Subject: [PATCH RESEND v4] loop: fix I/O error on fsync() in detached loop devices
Date:   Mon, 22 Feb 2021 12:41:23 -0300
Message-Id: <20210222154123.61797-1-mfo@canonical.com>
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>

---
v4:
- Add Reviewed-By: tag (thanks, Ming.)
v3:
- Disable write cache based on QUEUE_FLAG_WC, not just
  !LO_FLAGS_READ_ONLY, as the former can be enabled in
  sysfs even for LO_FLAGS_READ_ONLY, thus not disabled
  later. Mention that in commit message. (thanks, Ming)
v2:
- Fix ordering of Co-developed-by:/Signed-off-by: tags.
  (thanks, Krisman)
- Add Tested-by: tag. (likewise.)

 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

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

