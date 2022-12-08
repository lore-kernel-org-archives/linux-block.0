Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F33C001B2
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 21:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiLHV3H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 16:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLHV3H (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 16:29:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5F784265
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 13:29:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a5-20020a25af05000000b006e450a5e507so2855520ybh.22
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 13:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1/7SmmzO1fjUhk6gqNU1IGSXCaBrn6wr7PS0uHHL0Y4=;
        b=LqiYpvieBDCbLQwkb+CSQO3e5kvlO9YkgEAx+uj4dvnOMSYSbFp+eB6H7weFJnTz89
         8MDyvy5lu8E6NOlVICNsMMIWd2RXsQrhEHP/T+ym9fr0388elXolqAQVV5XMtGyPc7hB
         mh47hi5HEFtu4bMGkuw7sLC+CgMhhQDK3rFxEm+R8vsaFvB3a8j6j2zQv0P+wJGMQLDy
         6qYqDgN4YpiZmvCgZNbe6NfpIeJGuTrFf6M+9a2bJ+nkDnbJl61wH4k79YmSG333Qxbj
         9U7xGHcetB4fBU33IHmW5ZSKzsib8LREKjD5mpb4io1ayunr/o9VMJFRteWlgb2E3MvY
         WTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/7SmmzO1fjUhk6gqNU1IGSXCaBrn6wr7PS0uHHL0Y4=;
        b=OZCx8j+u9hcWM92BeDiXclWnUG7zwEFxtfKIlEmeGWMYjz/xL07A4jOBJPQOvqqn3t
         Px/T46ZvLMN/oy63PCBlvjNBgZ3vFhcsiPtEGaSI8gDsWJbpeSRmG4A4mfLOCvxGyU5H
         EeSuRyScDH6//+D9Hk3LlAHHvHlnjhg0ijB7ulOXrD6ZTs6NqYBTYrcpRKaEHG7Os6mZ
         FhXiNN6aGI2ZmTx6VEqCCVfujOuqTP3lEqDbeQ4yARvmGLriO4gHvlyratCxPLpEjV8B
         ozZETcujae995psljq4OJxQBTbIvt3HsG7yjRQOzDFZ+YPHaLrdoZ72/Y01ZlKGoSuDr
         Mlhw==
X-Gm-Message-State: ANoB5pnh/5ruQ6prjIhzaO/dol1IWPkDSVm9uozEGKavKGrIfEIsTAXD
        grfgV6JnVTAb7KVJkzXL+jFuP4dmFc+bEDp5z+kiIA==
X-Google-Smtp-Source: AA0mqf5uSOfyS4zTT3VGBQCIxUQ4g9tCxEa+73pikowJ78eitpwdyfLrX+kPJHU3xsZsUmGtzI1+a4VpVYAb7VSEbSE1OQ==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:c924:bf6:54d9:20e9])
 (user=isaacmanjarres job=sendgmr) by 2002:a05:690c:902:b0:3f6:489a:a06f with
 SMTP id cb2-20020a05690c090200b003f6489aa06fmr10039866ywb.470.1670534945529;
 Thu, 08 Dec 2022 13:29:05 -0800 (PST)
Date:   Thu,  8 Dec 2022 13:29:01 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221208212902.765781-1-isaacmanjarres@google.com>
Subject: [PATCH RESEND v1] loop: Fix the max_loop commandline argument
 treatment when it is set to 0
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ken Chen <kenchen@google.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        stable@vger.kernel.org, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, the max_loop commandline argument can be used to specify how
many loop block devices are created at init time. If it is not
specified on the commandline, CONFIG_BLK_DEV_LOOP_MIN_COUNT loop block
devices will be created.

The max_loop commandline argument can be used to override the value of
CONFIG_BLK_DEV_LOOP_MIN_COUNT. However, when max_loop is set to 0
through the commandline, the current logic treats it as if it had not
been set, and creates CONFIG_BLK_DEV_LOOP_MIN_COUNT devices anyway.

Fix this by starting max_loop off as set to CONFIG_BLK_DEV_LOOP_MIN_COUNT.
This preserves the intended behavior of creating
CONFIG_BLK_DEV_LOOP_MIN_COUNT loop block devices if the max_loop
commandline parameter is not specified, and allowing max_loop to
be respected for all values, including 0.

This allows environments that can create all of their required loop
block devices on demand to not have to unnecessarily preallocate loop
block devices.

Fixes: 732850827450 ("remove artificial software max_loop limit")
Cc: stable@vger.kernel.org
Cc: Ken Chen <kenchen@google.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/block/loop.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

This is a resend because I misspelled the address for
stable@vger.kernel.org the first time.

--Isaac

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ad92192c7d61..d12d3d171ec4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1773,7 +1773,16 @@ static const struct block_device_operations lo_fops = {
 /*
  * And now the modules code and kernel interface.
  */
-static int max_loop;
+
+/*
+ * If max_loop is specified, create that many devices upfront.
+ * This also becomes a hard limit. If max_loop is not specified,
+ * create CONFIG_BLK_DEV_LOOP_MIN_COUNT loop devices at module
+ * init time. Loop devices can be requested on-demand with the
+ * /dev/loop-control interface, or be instantiated by accessing
+ * a 'dead' device node.
+ */
+static int max_loop = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
 module_param(max_loop, int, 0444);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
 module_param(max_part, int, 0444);
@@ -2181,7 +2190,7 @@ MODULE_ALIAS("devname:loop-control");
 
 static int __init loop_init(void)
 {
-	int i, nr;
+	int i;
 	int err;
 
 	part_shift = 0;
@@ -2209,19 +2218,6 @@ static int __init loop_init(void)
 		goto err_out;
 	}
 
-	/*
-	 * If max_loop is specified, create that many devices upfront.
-	 * This also becomes a hard limit. If max_loop is not specified,
-	 * create CONFIG_BLK_DEV_LOOP_MIN_COUNT loop devices at module
-	 * init time. Loop devices can be requested on-demand with the
-	 * /dev/loop-control interface, or be instantiated by accessing
-	 * a 'dead' device node.
-	 */
-	if (max_loop)
-		nr = max_loop;
-	else
-		nr = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
-
 	err = misc_register(&loop_misc);
 	if (err < 0)
 		goto err_out;
@@ -2233,7 +2229,7 @@ static int __init loop_init(void)
 	}
 
 	/* pre-create number of devices given by config or max_loop */
-	for (i = 0; i < nr; i++)
+	for (i = 0; i < max_loop; i++)
 		loop_add(i);
 
 	printk(KERN_INFO "loop: module loaded\n");
-- 
2.39.0.rc1.256.g54fd8350bd-goog

