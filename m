Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3ECC4363F
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177FB61166
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbhDSHi3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbhDSHi3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 03:38:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0461C061760
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o20so13142697edc.7
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kudgbHD2vmKiyqxiiVxPOr/XbfnTQZ5BaCjcZ6vN5kA=;
        b=cAEMqMoFRRxpYABu7CT6sZywZZzoCwlm11yelZns/FpQ4KTs1FaxNIOZtyURy3Qa4A
         dc2p5yparElIgfCYC+F867aLypZ/vM1V/tUCpo3kXYLqrEk6XEn7cPRKynBmWHnlEar7
         +/UEOUgsGs1mzjfEq7VttaWlXzVNXzKeIk8HzhB0wtFauNN74XPetX45K/Uj3nuJ1Mkr
         3+yk7tmZEqfwGAbXcOZJEdvnA+9YByVYgoV0BMhw8yavn5XlW1IsHyAUbpTnm9fURKAR
         H90XAijS4edGboSGm1XMK7UfM4rsDS0IJ7BNj7EnQLtmqQmEueXlWRwiMbzGHtiJcyPf
         LqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kudgbHD2vmKiyqxiiVxPOr/XbfnTQZ5BaCjcZ6vN5kA=;
        b=TmhA0QHqXh4lw2oMkIZ9otN8NZn0KJyCEW3SpNbYryCg4/UzHN9Opkh/evvJwQwC1M
         CQnbFy3qkfpDtjiVWRcHsnt5A5tUafNJ5s3PrLBoiGQm8PkDIREBmW8UIJQJAXal3Q4X
         8372hAYiVOWV/+bHWi8mw4gRcWODXv4mu9UpSxJYxCd0MBbQQk+Q2lGfQnz/U2uK/TBF
         TRYT1tkQKUN/LJr5hRlZEgMG1vtUlp8qSz9zgY4JccUSsakrqtaAclNO/JeHQ1ck+n2h
         k2xmHW9e/7V0raFnpuiYCWaZIU4GowYmeklA34QFZHTyM2XqBLOKpi+DtjymKbGyvqL5
         VoeA==
X-Gm-Message-State: AOAM531M5JvA8aMK7tiN1wozLonglKIJoXeH6VoaktP02JTSHblmRhjZ
        a4jrxsnNUIYlwm8Rr541BZrHQA9p1d6WQcbq
X-Google-Smtp-Source: ABdhPJwTR00kqaO1TnkeeWVWRbaGdbptxVLaJJA68SypwcteftRyqTU0tVhdYBOLFQb7fN6WzK/Uaw==
X-Received: by 2002:aa7:c7c5:: with SMTP id o5mr23756133eds.31.1618817878464;
        Mon, 19 Apr 2021 00:37:58 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id g22sm8701833ejz.46.2021.04.19.00.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:37:58 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv5 for-next 12/19] block/rnbd-clt: Fix missing a memory free when unloading the module
Date:   Mon, 19 Apr 2021 09:37:15 +0200
Message-Id: <20210419073722.15351-13-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073722.15351-1-gi-oh.kim@ionos.com>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

When unloading the rnbd-clt module, it does not free a memory
including the filename of the symbolic link to /sys/block/rnbdX.

It is found by kmemleak as below.

unreferenced object 0xffff9f1a83d3c740 (size 16):
  comm "bash", pid 736, jiffies 4295179665 (age 9841.310s)
  hex dump (first 16 bytes):
    21 64 65 76 21 6e 75 6c 6c 62 30 40 62 6c 61 00  !dev!nullb0@bla.
  backtrace:
    [<0000000039f0c55e>] 0xffffffffc0456c24
    [<000000001aab9513>] kernfs_fop_write+0xcf/0x1c0
    [<00000000db5aa4b3>] vfs_write+0xdb/0x1d0
    [<000000007a2e2207>] ksys_write+0x65/0xe0
    [<00000000055e280a>] do_syscall_64+0x50/0x1b0
    [<00000000c2b51831>] entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 58c2cc0725b6..49015f428e67 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -432,10 +432,14 @@ void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev)
 	 * i.e. rnbd_clt_unmap_dev_store() leading to a sysfs warning because
 	 * of sysfs link already was removed already.
 	 */
-	if (dev->blk_symlink_name && try_module_get(THIS_MODULE)) {
-		sysfs_remove_link(rnbd_devs_kobj, dev->blk_symlink_name);
+	if (dev->blk_symlink_name) {
+		if (try_module_get(THIS_MODULE)) {
+			sysfs_remove_link(rnbd_devs_kobj, dev->blk_symlink_name);
+			module_put(THIS_MODULE);
+		}
+		/* It should be freed always. */
 		kfree(dev->blk_symlink_name);
-		module_put(THIS_MODULE);
+		dev->blk_symlink_name = NULL;
 	}
 }
 
-- 
2.25.1

