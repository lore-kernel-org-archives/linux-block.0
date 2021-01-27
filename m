Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A53C433E6
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 14:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278E920799
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 14:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhA0OQ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 09:16:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35267 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhA0OPT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 09:15:19 -0500
Received: from mail-qk1-f199.google.com ([209.85.222.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1l4lab-00029X-Sf
        for linux-block@vger.kernel.org; Wed, 27 Jan 2021 14:14:34 +0000
Received: by mail-qk1-f199.google.com with SMTP id u66so1570545qkd.13
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 06:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vrhpPKzimuceCgC93oDFemcstTw5fQ1szdLIsIshKp8=;
        b=By18+2Ehcg3bvJBdgN11MsGtJ/UXN+dd01Qhzp/unrFx7pI7LtzDUeSBrkSJNAnNW9
         KQslbItglk1YK7T7rJEZ9jb95Ah7ntrsHQPRZs0ZjF2tdvG0O2zPWWZgqnqgNDVuhrmJ
         iV0rOl3qivcej2jnmx7JDEcGPzHx5Ga090C42KwaKNIoumLN0qdXgOovRGxHDQrAzMBy
         +xJWHS6bTYSc0IC0/EMBe1TYGWmXeQe5V+6eGqRVriin+spqU4xFAPLvkH3ONuFBli2n
         D68vuBdeJMRg99sLDqgpI7fyQIUDYShcXbG1Er0IkgKRNQbC9rqxY0PF5jS4JRXgQjWU
         jt1w==
X-Gm-Message-State: AOAM530aAVrAw6UW2M6HTFSgqldN1GRlj2G/kiXN/1/ffI/Sag74M05d
        mYY2r7PsmndeAq8z6ltmuhiSLFhADJ47J0Cmt40tBwoaJY+SrbD+dADCrMK/0PSPDyMlCXikn9+
        Npa6g+Tkk+Q6CJBLSi5Leb5eLmPAM66wYGWRu4xUq
X-Received: by 2002:a37:4905:: with SMTP id w5mr10850293qka.332.1611756872996;
        Wed, 27 Jan 2021 06:14:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUeePvPDPNGMz+iGAOFVhsjP35n3mbJzhPj6o/1utO4zUP1A3AdcTrH391GHpFK+Uc/fl4nw==
X-Received: by 2002:a37:4905:: with SMTP id w5mr10850271qka.332.1611756872720;
        Wed, 27 Jan 2021 06:14:32 -0800 (PST)
Received: from localhost.localdomain ([201.82.34.122])
        by smtp.gmail.com with ESMTPSA id i16sm1329145qtm.3.2021.01.27.06.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:14:32 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, krisman@collabora.com,
        eric.desrochers@canonical.com, ming.lei@redhat.com
Subject: [PATCH RESEND v4] loop: fix I/O error on fsync() in detached loop devices
Date:   Wed, 27 Jan 2021 11:14:27 -0300
Message-Id: <20210127141427.435751-1-mfo@canonical.com>
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

