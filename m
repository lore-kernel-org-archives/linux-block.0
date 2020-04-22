Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D7CC5518A
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 10:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341C720774
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 10:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="AGnsBpbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgDVKzu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgDVKGt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 06:06:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E693C03C1A9
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 03:06:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t14so1640500wrw.12
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 03:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=036klsi1gy6LVGjlEiXf5owP/duZTlgIzaFa2SKIQ+E=;
        b=AGnsBpbL1Vv97wQdW5Fl6CpGMUP+uNTbK+GJDqlM0qWbEAKocpTbFy+1IuXyLhL9vi
         TmWwRi5LQEO5YyOpsIzWDbJvLb3LEfMaSZlXkExDzWHUC3QgxUtWRzgNsHU5zwA8LdGj
         ZabDa89WpHCUGMlYOJGVBbicZ0ydSxwBxhmnglFV1YiYSroCuVWrwvocUIvbHktgB7R0
         VodH1uOLUXzAHseEhgDYgGAM30wWlsOP79P4BvWHi7aaiypzyLdnTvmgzfqciYQvYJ4Q
         jRV4+mind6zTplTznFQst8dF88z4c6N5KBCoNdO66ahcc97Ip/HNzklCngM2HCakzjtn
         RjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=036klsi1gy6LVGjlEiXf5owP/duZTlgIzaFa2SKIQ+E=;
        b=AunuGhbHEePXfnH7bsgL8+SBVHVsFe+gJoSNuW4o8r3wioCEPwhJFJXtGJqJAN4s5N
         ibJ5VRtbpSKAXX64ehOwlffiGmamaxCTQMUtkiv2st1IXYto1FQQvFGKiE0XpQKk+hig
         GSGqr/tvtJf3+Dec75it863xu2K/XroX3eEXPKgpiPlrO7Yk8iiC2EILVSJkRFLXfpm7
         keESoE5zVO6YWsKJbYFhoV5OtWJMq2BMnzmHuQQud/a/p5TtY93C1M2knLfpL6Kn74aC
         Y5TS2w1++HWldix70YYInaFx+CNOBIZvASXYJkd23zaKgUrwAZUYKKkbed8Luro3Tgwk
         D5pg==
X-Gm-Message-State: AGi0PubYCoax6P75QP4uwHgJ9qCQhWAqLeWAmZ0mWV3J4cRvpcl5E2ZY
        Zn/Z0u22at4QBCIu94KmbGuwZw==
X-Google-Smtp-Source: APiQypLlDCW6YqrrqBm8HcLF8OPMG3dwPXmFwVPNRqcL0hBDSspSlK+avLUHLixbDTxoHv5uFV5UwQ==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr20639878wrs.311.1587550007842;
        Wed, 22 Apr 2020 03:06:47 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id j13sm7812462wrq.24.2020.04.22.03.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:06:47 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v2 4/5] loop: rework lo_ioctl() __user argument casting
Date:   Wed, 22 Apr 2020 12:06:35 +0200
Message-Id: <20200422100636.46357-5-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200422100636.46357-1-maco@android.com>
References: <20200422100636.46357-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for a new ioctl that needs to copy_from_user(); makes the
code easier to read as well.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f6c6036324bf..b10f1d5306a2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1658,6 +1658,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
+	void __user *argp = (void __user *) arg;
 	int err;
 
 	switch (cmd) {
@@ -1670,21 +1671,19 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_STATUS:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-			err = loop_set_status_old(lo,
-					(struct loop_info __user *)arg);
+			err = loop_set_status_old(lo, argp);
 		}
 		break;
 	case LOOP_GET_STATUS:
-		return loop_get_status_old(lo, (struct loop_info __user *) arg);
+		return loop_get_status_old(lo, argp);
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-			err = loop_set_status64(lo,
-					(struct loop_info64 __user *) arg);
+			err = loop_set_status64(lo, argp);
 		}
 		break;
 	case LOOP_GET_STATUS64:
-		return loop_get_status64(lo, (struct loop_info64 __user *) arg);
+		return loop_get_status64(lo, argp);
 	case LOOP_SET_CAPACITY:
 	case LOOP_SET_DIRECT_IO:
 	case LOOP_SET_BLOCK_SIZE:
-- 
2.26.2.303.gf8c07b1a785-goog

