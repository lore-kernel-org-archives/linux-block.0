Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF8AEB64DC
	for <linux-block@archiver.kernel.org>; Mon, 17 Jul 2023 19:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjGQTRW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jul 2023 15:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjGQTRU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jul 2023 15:17:20 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CE718D
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 12:17:18 -0700 (PDT)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DFE593FA6F
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 19:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689621436;
        bh=u90FxgX1yv9gfjmxHkjVHsDrQncPonwjdxAUHkNeqGM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=It9Hnv8SZ6iDSmGLQUgzVg/gpXB5m6u+4myx2oao6DvKYvMq39ybKixJAgziyYgS/
         LF9i1WyDgycYcroshmPhzybvgHjVbYx2rJVLNXHOnScN54qQ6/RFtDNzKzOd5D71D9
         R0lw+G/hB4jhmt9xFW9RHh1YuPMByh0GKng7G+GoH0qFWUX4tPt+bzn71/XgqNWWje
         SXGI3KM3LCMjBsgngpPyl1uSBdNzQ+rRioA/9Bt59ZDHJecOmcVaTefRIsG7SWQBBq
         WG7o3JbDD5IF0mlbQ1LPbPYZkUsqJiVAJzgoC/N1+185VbRFItBeHd4vIU4ZirUHLh
         z6TK7E3fh0BbA==
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b9c82f64b7so2431399a34.3
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 12:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689621436; x=1692213436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u90FxgX1yv9gfjmxHkjVHsDrQncPonwjdxAUHkNeqGM=;
        b=kjSyNJ7ZgLfd3MQCU7spI5aKUJbowOXpizkUI4MJKsPb2K+rW61PS+so5S72aN9bBW
         boYBs4Ee/NBSZLMxpzwQe7t8fasF08a5HaNdbA3guseUxzP3URSwrRWlefQgYOqjsKg/
         YBFkHlCgyILJ/UzxBtq8iM9eN8V/SrI6dp+c7fh82s8f4sYCObiW7Vfg+ievQddUALMj
         /ZN3pojuS8CMCDNFMF//Z2/LfD1CuMLaiU/WBh87RXjEYQRzJgOGtHRCVlVT5W052SAs
         RXZVm6lNfIW6q3GGATVvIvaQFv9PF4iwhv/wRHMvnQuQQGiabW0BlL/NKPngN71tWWcu
         QFiw==
X-Gm-Message-State: ABy/qLbhJOSCapPlBAogoEbWfC+94QizPUGB5WcLf8IHWURJu5ITskRO
        +1GodFaTi+YHmrwLjDfLzG2tGShy+8YAxhz2uJXHiNQCXw6jCIIhsYwM//raElTcPTEL2O+cJMB
        kRNhxEJTwyuVoEH8f5cAkDkW05wi9ZBVsIEfSY/DX
X-Received: by 2002:a9d:6841:0:b0:6b8:6e6c:6b5a with SMTP id c1-20020a9d6841000000b006b86e6c6b5amr10676812oto.21.1689621435814;
        Mon, 17 Jul 2023 12:17:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE7H3xUNfmtwy4zRM3pLTyYhJAe3kTuHwZ/ChSjVVtlRh5jzj9ZalMTYYn+b8DcucfIYnBMjg==
X-Received: by 2002:a9d:6841:0:b0:6b8:6e6c:6b5a with SMTP id c1-20020a9d6841000000b006b86e6c6b5amr10676797oto.21.1689621435547;
        Mon, 17 Jul 2023 12:17:15 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4e1:8296:70bd:5663:a6f8:b245])
        by smtp.gmail.com with ESMTPSA id y8-20020a056830108800b006b71deb7809sm223087oto.14.2023.07.17.12.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:17:15 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Subject: [PATCH RESEND 2/2] loop: do not enforce max_loop hard limit by (new) default
Date:   Mon, 17 Jul 2023 16:16:28 -0300
Message-Id: <20230717191628.582363-3-mfo@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717191628.582363-1-mfo@canonical.com>
References: <20230717191628.582363-1-mfo@canonical.com>
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
and _no_ hard limit on 2) to add devices with autoloading.

However, the default value changed in commit 85c50197716c
("loop: Fix the max_loop commandline argument treatment
when it is set to 0") to CONFIG_BLK_DEV_LOOP_MIN_COUNT,
so that max_loop=0 does not pre-create devices at all.

That does improve 1), but unfortunately _breaks_ 2), as
default behavior *changed* from no-limit to hard-limit.

Example:

For example, this userspace code broke for N >= CONFIG,
if the user relied on the default value 0 for max_loop:

    mknod("/dev/loopN")
    open("/dev/loopN")  // now fails with ENXIO

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

Linux 6.5-rc2
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
---
 drivers/block/loop.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7268ff71c92c..310e21889086 100644
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
@@ -2286,6 +2315,9 @@ module_exit(loop_exit);
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

