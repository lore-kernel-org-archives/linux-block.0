Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8641C433FE
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 21:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88299222F9
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 21:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgLCVes (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 16:34:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38827 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgLCVes (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 16:34:48 -0500
Received: from mail-qv1-f72.google.com ([209.85.219.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1kkwEo-0002v3-6c
        for linux-block@vger.kernel.org; Thu, 03 Dec 2020 21:34:06 +0000
Received: by mail-qv1-f72.google.com with SMTP id n5so2805502qvt.14
        for <linux-block@vger.kernel.org>; Thu, 03 Dec 2020 13:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mUOyZmA8+0ywNKV9ZTvHmJjS1Ao4eELDO8pVI2BEuKg=;
        b=HyiD9Pvv45m742Y5eAN2zMG5WwYRV9zPISK7u85Qx+TVoosv2mQdu+zfO3AGijG1Uw
         dlPMP1F2Gkks/fhWPW4d5i2740vof0J97wvgCxkR3M4NiEeyaY0hlzH4a1LeuVEknmap
         bf9+odQBewkhDNyN8ZbQs07xPynlFYN0YRSs40z1RuvifjQfkz/6wFIIqbx2upjZzQCX
         FCsdqFVz3Ga8FzB4SPVJx29m9GTnUTZcU9ldHiXJhBBrkQdoSg7Ebd5TNtStTVeqrTUk
         xpwKhgf1aXnqONBb4GSU1cp0q8L0fOzrdzqButYjUwiUPw8j62k9GiJvHzl90nCEVZx2
         mMxQ==
X-Gm-Message-State: AOAM531Mby7oyYgcig0YhfE2xltHtOeczA7/aBxH6sA86CJG9dOUwbWc
        wp1DwGmcwBFAQgSXA3KHOxMdjVS55OtuiYsNkmyUXEZ3shUa8pQ6f7K1ouZaT4OmUH1I1+C0GbF
        pQ3cewk2FshlP+efUGyZxx5clT476CHgIaPjt1ttn
X-Received: by 2002:a05:622a:cf:: with SMTP id p15mr5388132qtw.168.1607031245114;
        Thu, 03 Dec 2020 13:34:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAiD4J4J1rlZhh1mAaJ1kJkQr5hFv1WpUxFIQf5hlZMmlrR9+9ufHPSjqnxAzXN9N4+MeOmg==
X-Received: by 2002:a05:622a:cf:: with SMTP id p15mr5388117qtw.168.1607031244926;
        Thu, 03 Dec 2020 13:34:04 -0800 (PST)
Received: from localhost.localdomain ([201.82.34.122])
        by smtp.gmail.com with ESMTPSA id h16sm2786046qko.135.2020.12.03.13.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:34:04 -0800 (PST)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     mfo@canonical.com, eric.desrochers@canonical.com,
        linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] loop: disable write cache in __loop_clr_fd()
Date:   Thu,  3 Dec 2020 18:34:00 -0300
Message-Id: <20201203213400.84340-1-mfo@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A detached loop device can hit an I/O error on fsync() if it was
previously associated/attached.

This happens because the write cache is enabled in loop_configure()
in the attach path, but not disabled anywhere in the detach path.

So, disable write cache in the detach path.

Before:

  # losetup /dev/loop7 disk.img
  # losetup -d /dev/loop7
  # strace -e fsync parted -s /dev/loop7 unit s print 2>&1 | grep fsync
  fsync(3)                                = -1 EIO (Input/output error)
  Warning: Error fsyncing/closing /dev/loop7: Input/output error
  [   34.696133] blk_update_request: I/O error, dev loop7, sector 0 op
  0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0

After:

  # losetup /dev/loop7 disk.img
  # losetup -d /dev/loop7
  # strace -e fsync parted -s /dev/loop7 unit s print 2>&1 | grep fsync
  fsync(3)                                = 0

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Co-developed-by: Eric Desrochers <eric.desrochers@canonical.com>
Signed-off-by: Eric Desrochers <eric.desrochers@canonical.com>
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a58084c2ed7c..0e23ab151667 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1223,6 +1223,9 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		goto out_unlock;
 	}
 
+	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY) && filp->f_op->fsync)
+		blk_queue_write_cache(lo->lo_queue, false, false);
+
 	/* freeze request queue during the transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
-- 
2.25.1

