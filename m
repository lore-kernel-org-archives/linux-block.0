Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CE5EB64DA
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 14:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjGTOb1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 10:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjGTOb0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 10:31:26 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C590F269A
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 07:31:24 -0700 (PDT)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6C2EF3F171
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 14:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689863483;
        bh=9UQpHmiDAHA77STTwc9/XFHaERxXta/i944fVz8C/HE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=d8V/+tS3BeHTFFPktGglJlzSTv7zNXu7/IwnP/1xFTR+I+rK0C3T1O2HMdriwYs7i
         74TtULGwr56NeEO+AXfTcfNDSjU1mG8S24AwDdiTcFMrdLi6h3MjAihJvopncpl3dw
         i1MNYoNNPvd6L+Q7ywWfcjXaghbdODChOmIa8YP3IElGLQmCxilugV2dk+/P5H6unP
         c25mg3SJmFApLKLy7FQ21b4lhG+LVerRqYmyjsDYYFyNHbMCssNvv4mRi67dlDHSpp
         ICEi6KWepnUGlJWk8eHGcf+wEnhn44X2DZYfdsbHNIZgbOBVopuGL6zPOdIO3HOCm1
         MkD2vveBCIxiA==
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-39cdf9f9d10so1441880b6e.3
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 07:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689863482; x=1690468282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UQpHmiDAHA77STTwc9/XFHaERxXta/i944fVz8C/HE=;
        b=HRwwapKKSSnu4XkQZEoqY/us04rbn/OM8/EdV6hhCcI3leqR5OB0ly+wtm1JXdcBsR
         fgYAyGFyB4/DKUzeHNea9CaWTG8RYpnDv1BqCPjTOyWaNlIThAf+gvyRTX9xzcwQ3ZTD
         cFKymLBqEKXf0U7mNoi1u3p9K2BBdO3IQyZxyVgUJ9ZWcM7WQTYCzSO505EXxj3bsR16
         VTmOgZy2lH9cvWi1U1/DfHKdByv7HmOE+P5L70QvWAiPXVctK4or3q734Ti58QCxhQPp
         o+40KwA6izbfJzPCxO6m+MaRXLeS6GQSJCucEUMS6GtYCb1ByWTxsQwc7PHJ9OG4uuuy
         nrgw==
X-Gm-Message-State: ABy/qLZbEm/V+vt1XyLOb5Okz3SDkgsIea3WwFuZPvRw5E66PVtyoV6m
        /ApI4FMlhFw8JTQhXBGbxdowSuasr/lu8dJFIH3GqY9DGUQV0ZUBQjDOnUZ6wJ8vcc3NLhbLemj
        FOoxEKnifKSV+QCJG8X/IOCdeLSDRf1e10VP/bY4w2o3EmhoR
X-Received: by 2002:a05:6808:140b:b0:3a4:2525:1545 with SMTP id w11-20020a056808140b00b003a425251545mr2113917oiv.37.1689863481761;
        Thu, 20 Jul 2023 07:31:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGb0TNDxN2d9/d2YUHxbAul+YwM9vTcA+5A7Fdlb8+nNMTV4NEZhjnZAde6MbRhnR06CoW6Rg==
X-Received: by 2002:a05:6808:140b:b0:3a4:2525:1545 with SMTP id w11-20020a056808140b00b003a425251545mr2113890oiv.37.1689863481506;
        Thu, 20 Jul 2023 07:31:21 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4e1:8296:c121:4d01:95b0:7009])
        by smtp.gmail.com with ESMTPSA id bg28-20020a056808179c00b003a4646e0896sm415543oib.32.2023.07.20.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:31:21 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Subject: [PATCH v2 2/2] loop: do not enforce max_loop hard limit by (new) default
Date:   Thu, 20 Jul 2023 11:30:33 -0300
Message-Id: <20230720143033.841001-3-mfo@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720143033.841001-1-mfo@canonical.com>
References: <20230720143033.841001-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Problem:

The max_loop parameter is used for 2 different purposes:
1) initial number of loop devices to pre-create on init
2) maximum number of loop devices to add on access/open()

Historically, its default value (zero) caused 1) to create
non-zero number of devices (CONFIG_BLK_DEV_LOOP_MIN_COUNT),
and no hard limit on 2) to add devices with autoloading.

However, the default value changed in commit 85c50197716c
("loop: Fix the max_loop commandline argument treatment
when it is set to 0") to CONFIG_BLK_DEV_LOOP_MIN_COUNT,
for max_loop=0 not to pre-create devices.

That does improve 1), but unfortunately it breaks 2), as
the default behavior changed from no-limit to hard-limit.

Example:

For example, this userspace code broke for N >= CONFIG,
if the user relied on the default value 0 for max_loop:

    mknod("/dev/loopN");
    open("/dev/loopN");  // now fails with ENXIO

Though affected users may "fix" it with (loop.)max_loop=0,
this means to require a kernel parameter change on stable
kernel update (that commit Fixes: an old commit in stable).

Solution:

The original semantics for the default value in 2) can be
applied if the parameter is not set (ie, default behavior).

This still keeps the intended function in 1) and 2) if set,
and that commit's intended improvement in 1) if max_loop=0.

Before 85c50197716c:
  - default:     1) CONFIG devices   2) no limit
  - max_loop=0:  1) CONFIG devices   2) no limit
  - max_loop=X:  1) X devices        2) X limit

After 85c50197716c:
  - default:     1) CONFIG devices   2) CONFIG limit (*)
  - max_loop=0:  1) 0 devices (*)    2) no limit
  - max_loop=X:  1) X devices        2) X limit

This commit:
  - default:     1) CONFIG devices   2) no limit (*)
  - max_loop=0:  1) 0 devices        2) no limit
  - max_loop=X:  1) X devices        2) X limit

Future:

The issue/regression from that commit only affects code
under the CONFIG_BLOCK_LEGACY_AUTOLOAD deprecation guard,
thus the fix too is contained under it.

Once that deprecated functionality/code is removed, the
purpose 2) of max_loop (hard limit) is no longer in use,
so the module parameter description can be changed then.

Tests:

Linux 6.4-rc7
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLOCK_LEGACY_AUTOLOAD=y

- default (original)

	# ls -1 /dev/loop*
	/dev/loop-control
	/dev/loop0
	...
	/dev/loop7

	# ./test-loop
	open: /dev/loop8: No such device or address

- default (patched)

	# ls -1 /dev/loop*
	/dev/loop-control
	/dev/loop0
	...
	/dev/loop7

	# ./test-loop
	#

- max_loop=0 (original & patched):

	# ls -1 /dev/loop*
	/dev/loop-control

	# ./test-loop
	#

- max_loop=8 (original & patched):

	# ls -1 /dev/loop*
	/dev/loop-control
	/dev/loop0
	...
	/dev/loop7

	# ./test-loop
	open: /dev/loop8: No such device or address

- max_loop=0 (patched; CONFIG_BLOCK_LEGACY_AUTOLOAD is not set)

	# ls -1 /dev/loop*
	/dev/loop-control

	# ./test-loop
	open: /dev/loop8: No such device or address

Fixes: 85c50197716c ("loop: Fix the max_loop commandline argument treatment when it is set to 0")
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>

---
v2:
 - add Reviewed-by: Christoph Hellwig <hch@lst.de>

 drivers/block/loop.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6e56c3faacac..637c5bda2387 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1775,14 +1775,43 @@ static const struct block_device_operations lo_fops = {
 /*
  * If max_loop is specified, create that many devices upfront.
  * This also becomes a hard limit. If max_loop is not specified,
+ * the default isn't a hard limit (as before commit 85c50197716c
+ * changed the default value from 0 for max_loop=0 reasons), just
  * create CONFIG_BLK_DEV_LOOP_MIN_COUNT loop devices at module
  * init time. Loop devices can be requested on-demand with the
  * /dev/loop-control interface, or be instantiated by accessing
  * a 'dead' device node.
  */
 static int max_loop = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
-module_param(max_loop, int, 0444);
+
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
+static bool max_loop_specified;
+
+static int max_loop_param_set_int(const char *val,
+				  const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_int(val, kp);
+	if (ret < 0)
+		return ret;
+
+	max_loop_specified = true;
+	return 0;
+}
+
+static const struct kernel_param_ops max_loop_param_ops = {
+	.set = max_loop_param_set_int,
+	.get = param_get_int,
+};
+
+module_param_cb(max_loop, &max_loop_param_ops, &max_loop, 0444);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
+#else
+module_param(max_loop, int, 0444);
+MODULE_PARM_DESC(max_loop, "Initial number of loop devices");
+#endif
+
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
 
@@ -2098,7 +2127,7 @@ static void loop_probe(dev_t dev)
 {
 	int idx = MINOR(dev) >> part_shift;
 
-	if (max_loop && idx >= max_loop)
+	if (max_loop_specified && max_loop && idx >= max_loop)
 		return;
 	loop_add(idx);
 }
@@ -2285,6 +2314,9 @@ module_exit(loop_exit);
 static int __init max_loop_setup(char *str)
 {
 	max_loop = simple_strtol(str, NULL, 0);
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
+	max_loop_specified = true;
+#endif
 	return 1;
 }
 
-- 
2.39.2

