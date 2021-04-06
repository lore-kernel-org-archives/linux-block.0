Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE52C433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF69613BE
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbhDFHHi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244170AbhDFHHh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:07:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9098BC06175F
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:07:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z1so15214116edb.8
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kudgbHD2vmKiyqxiiVxPOr/XbfnTQZ5BaCjcZ6vN5kA=;
        b=RFeCc/9/aDukrj2fM0mnC2EFO9TrTjpt0jbKUUOrTu/KNoWgD/OlhkXz8v3J6Ssx9/
         HePYOS7059u958LZEViz4vYNfFg/1cS+Hdh/1+enNDwfPKMSRKE4I5aSW6ICrlh6cFlO
         ew7yfOjldJrqq0/VaoPkClOa0lIoT/2Hnq8iPWXDXXqVNdzjyIFUeJ8QMN1crgPnYWe2
         K5Ki3iNuxyFujIGAXeEkPHKE3iFtm/2mal0Iyx6FlXnE0nBmG+JYyIu3ZaRvT7ED4IZC
         HS9Vh3NrDmbPrG8/HplDXSgqPPwHMTI0zEjzHNN/rhZsL5GiqXJ+nc/85xWUwJAH+4Cy
         0G/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kudgbHD2vmKiyqxiiVxPOr/XbfnTQZ5BaCjcZ6vN5kA=;
        b=cXbOWFdWzoMOQ0QkI5Jowmdcm5dmeNueUKYyBrV17VKKuxCtcNWmaANJCc9EH2BmuJ
         t+fosF/TSGOEc63bcm1+TcJUCC8v/ZK8Aktph28auPLXakOiZJBUS7w38F6AEhNH/OPp
         BBcNzQcsuJ2ozOR8tkFDWgg0tuxuc21TT98aJDxu3qngu3ciX2EnIG2CHnYKMR/upPHH
         rwhPsTkeQ2pYJw6/XZOh6BiGaRphmNqiTdPcFCs63ALpv1wQCjsplj2ChGNcd8j7eUTX
         mj320BR81mjrKDRhxG9ma5ZxTU2Sa3IbGoMcqNSHLnXWWaWx5r0NJAlkkkUoYJse2K2A
         U85w==
X-Gm-Message-State: AOAM530tkoUp/wXMWUWC5DUs1oGjes7iliI0aGqHNtt2b5+rzEbD7HAM
        X8CxpNNeYFAybQu67tDHRSZoNI299BoXQLb4
X-Google-Smtp-Source: ABdhPJyiWdE5tWgmO1d9FtkMzYRkR97x2zW4bcmIuef+YR4nlsvi99kD+PZz6uSQ5cFaZVBurXNRLw==
X-Received: by 2002:aa7:cd07:: with SMTP id b7mr7106862edw.293.1617692848246;
        Tue, 06 Apr 2021 00:07:28 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:28 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 12/19] block/rnbd-clt: Fix missing a memory free when unloading the module
Date:   Tue,  6 Apr 2021 09:07:09 +0200
Message-Id: <20210406070716.168541-13-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
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

