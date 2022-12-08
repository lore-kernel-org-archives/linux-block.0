Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8459C4332F
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 20:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiLHUGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 15:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiLHUGL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 15:06:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F3B71273
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 12:06:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b17-20020a25b851000000b006e32b877068so2621873ybm.16
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 12:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OGhmujOQ3LHvhNffWWxTOz03eJmhoP8dH26JUxPiv9A=;
        b=U6aDPl2myrZIIKIGUJ0avQLION3uqVvN8qwo9PUj5t2mD90pfGol56QdSn6YYroxDh
         t9FUxWiOr9zloTUfJNztvnYW7pRZ2CbnxhPrKdKzFuV5vKw2In92C3B+xCCythGGi3VX
         PFG+MJC8f4laeAiOzw4PLyjHupuxq5yRXj9CtRnHJMlMqxNWEFjI/+SntJP1Nlt15GuR
         4vFqrHv6DZiF6fLoexqgLAWgHnpxs0UueVtgqiQkG/Fa/7R7UBLmBl+DVh7Ps44P3ptV
         6akvXSA7VYTpGYyFTfNPmcXyEFPXUs73ERML+KZu+M91SpXPUP7Xk6aittYoztRa5Q0O
         B36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OGhmujOQ3LHvhNffWWxTOz03eJmhoP8dH26JUxPiv9A=;
        b=ow8g8C+Wh8l6ph7by7pyvrx/mYdOm9FL5JO4fJ4cbJlbqngr/6ZqIsgNFUIkHp2Jl3
         5z9dKaVJvfpD/D+ARnFXlHqwTGqSiEn4ZBeZ6geehXVB9B82jW+ndM2j1fE6cmrHjQdw
         KtkkPafCUxV2s27mOW3WtuPaj5SdMvp5K+/GWW9yCVgLbJ24LOgSfyXA11hD85f600FR
         ieK7QggpQcyVJ61aGDkEMupxM/AF9gVXkaGYwMHojgaJECCj93TtKrpAhFlomJxkQrOb
         Ldl5OeuzUUj7TImLHJtyckWKu3+IbXmlDjV/cceZxM7ItF5Oylf/3hh+k+LRs88ryFel
         HwbQ==
X-Gm-Message-State: ANoB5pklBF2BkTaySdkTNy5/YYV2Sufm+v/XKNhb8L4ov69DMvwdx/me
        EAb54yQCdSEVDK8C1OrJ6g7hVP9oe0efhAW4cVgoEA==
X-Google-Smtp-Source: AA0mqf5eG4ukM9Gke/9q7x+rfDkZT4u/r6tSFxm6BIumuvsskw9y53vKp2UZkaB752/pmAS1J4CLp+yGVarG50Ub0viBGw==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:c924:bf6:54d9:20e9])
 (user=isaacmanjarres job=sendgmr) by 2002:a05:690c:909:b0:368:70a8:9791 with
 SMTP id cb9-20020a05690c090900b0036870a89791mr15417509ywb.197.1670529968666;
 Thu, 08 Dec 2022 12:06:08 -0800 (PST)
Date:   Thu,  8 Dec 2022 12:06:04 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221208200605.756287-1-isaacmanjarres@google.com>
Subject: [PATCH v1] loop: Fix the max_loop commandline argument treatment when
 it is set to 0
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ken Chen <kenchen@google.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        stable@vger.knernel.org, kernel-team@android.com,
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
Cc: stable@vger.knernel.org
Cc: Ken Chen <kenchen@google.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/block/loop.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

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

