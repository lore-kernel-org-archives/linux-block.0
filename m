Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F79AC433E4
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 07:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7E32075F
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 07:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="XiM1CmmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgHYHSg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbgHYHSf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 03:18:35 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79107C061574
        for <linux-block@vger.kernel.org>; Tue, 25 Aug 2020 00:18:35 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l63so7248671edl.9
        for <linux-block@vger.kernel.org>; Tue, 25 Aug 2020 00:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kKlSBk6UiQgMI+Rnct1nYh1yKg5EX7/XZKqh6p+9CAI=;
        b=XiM1CmmY8uQ3dV3kT2166Mi5jMHX+VYaeYoIO3AWBpQphlKYOWHWAyvQ0aW1+x1Hm/
         3WEF77GCswed1iTxCE7Qp/OEPvdccSg0+lO9c9AamQPaNjrYmJyg2afDTnf6X7udZV6o
         Nhg648wFjKS6gV661vVbATYVpVuXUEycEtAf/zMJNRc09gPYEaYlSE2SkSPeAuXeC+ia
         Zi79ptZBalLYn4V6whkGN6UrAEuP6SRmmPInJBfXxG3+m6RJrR4YkgxP7KkKIvGzDwlj
         au7A+vAO7ynpVV7vjCYt0hNZlCmjRtg52fo91IPTn/8mouOANCHq9Iz/DpTLKVe6NK1w
         Pt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kKlSBk6UiQgMI+Rnct1nYh1yKg5EX7/XZKqh6p+9CAI=;
        b=HwykUEnepE/KpPOCwdRqAfl/CSiHE87rOeAcMPuLwIu8fGltyD+VmaczRtAGP6Z5nO
         1sQYQ4BPnHbBqQOwRM93KOrDhsxCeV7N5oTfpBy0SaO6JXYEH3HD3YqBlyCtJ5x9KEML
         NCY+tyMj7G/My0Z2c0RBTC3jCPRwVHzum1XZw9b4OYfgHQYKZCqj/1XC4A4Y7tUCp6RT
         8qI1N+jNYsN+C/efZbqvtOzN/Eual8Mnv9ozrX/hnvLLpguUGSgeMzp9K26Srju6BnX5
         MH6U1CVw37OticyJV8B4ZvHKo4VOdqtQyNjhQKe4cq+DfaXEITlqzW05ynCLVhziceOT
         rw1w==
X-Gm-Message-State: AOAM530QLbqPjyygpmP8bVvtzPXM9/N+kT7kSFxYHmRDpvGbhuvWL+Ml
        TRHLPujKLFMI8GVZWTdMbNyjknQJh3czJvo5
X-Google-Smtp-Source: ABdhPJw3GRVazP/wm9caIXKNG2lX9Dwsyq9ZjwtipqJFaUe6tpHD9aDQ0H6DAqLlyMWfVaam3J675g==
X-Received: by 2002:a05:6402:456:: with SMTP id p22mr8677468edw.177.1598339914070;
        Tue, 25 Aug 2020 00:18:34 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id n17sm7079559edo.46.2020.08.25.00.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 00:18:33 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     mzxreary@0pointer.de, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hch@lst.de,
        xuyang2018.jy@cn.fujitsu.com, Martijn Coenen <maco@android.com>
Subject: [PATCH] loop: Set correct device size when using LOOP_CONFIGURE
Date:   Tue, 25 Aug 2020 09:18:29 +0200
Message-Id: <20200825071829.1396235-1-maco@android.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The device size calculation was done before processing the loop
configuration, which meant that the we set the size on the underlying
block device incorrectly in case lo_offset/lo_sizelimit were set in the
configuration. Delay computing the size until we've setup the device
parameters correctly.

Fixes: 3448914e8cc5("loop: Add LOOP_CONFIGURE ioctl")
Reported-by: Lennart Poettering <mzxreary@0pointer.de>
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2f137d6ce169..fbda14840d8e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1111,8 +1111,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	mapping = file->f_mapping;
 	inode = mapping->host;
 
-	size = get_loop_size(lo, file);
-
 	if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) != 0) {
 		error = -EINVAL;
 		goto out_unlock;
@@ -1162,6 +1160,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
+
+	size = get_loop_size(lo, file);
 	loop_set_size(lo, size);
 
 	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
-- 
2.28.0.297.g1956fa8f8d-goog

