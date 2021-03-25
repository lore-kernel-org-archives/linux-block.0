Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8389C433F4
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96AD861A42
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhCYPah (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhCYPaF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:30:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E396C06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kt15so3555912ejb.12
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0w1fRI368Vhqwr68IvgBQDB9m3lTg5l6TH+c+9pCq5Y=;
        b=X26JgmxU0/mTKLWHlHEKbRxMF7YkaLg89ogJXlvDRC/Mn5PjWVy/f4uA/RsXU2pkNb
         DJShuGxGj7FFkiqz+AAYAZMV1W2d3FR+oO1NjC7r2M7XkjoJ8iwbqUDIPmJH4maULt/J
         FWuzpCKMObi4wNb2YMEb4aVLBL7/VHOQXsOfXfBfRL1nt2yFuQ1i7lQy90m/v31RQt00
         D2bDJj5IPkwqW9BweSZ9nVXhrvfBdsRUmXfQqwpjf5yezCqK+KCihP2m0w3gj9nMGKgB
         +V9zTE7UVEmjMA91oUKOv+/dhlI2SP3yjERGegMpa36Mjhc9aIEygAOSMs4pyFL1Dq9Q
         r6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0w1fRI368Vhqwr68IvgBQDB9m3lTg5l6TH+c+9pCq5Y=;
        b=kaDm407MEAhDeHq1YB79Ok27QXU4YDNqwCx/8gd5OEFoYrMk8K2NVAoZlwk+Vtp+AY
         AUNtQ2mHoDrUc/F6pmwy/tI7HjvnbreWKWHDHidVDEPZFvStg/nNqdNHMhsvZv8bGgqC
         Y3kwRnzrlCKVmxRkvRfQkumps3Flt1M/vmSX34KgX9owR8Ty9WlsOfnaNRsxE4h8s9xI
         fSfHC0cB3IYdLK5pz8erKLuJLgsyqlTZxYC83R1IjfCN9xVG811q5hWflFCdvCbQDq64
         1/7hQzk/L8J1O+GxVhlMacMYszAwnDCulgG7G1/v/ST/vqLndOdLAoanPFs/LwuipgVh
         TZNg==
X-Gm-Message-State: AOAM533o5ZzOGwFvBFQl88pmqABTRahMD2wCwCDUkSPZ4Tq+JY1+Dcj3
        AXY4vcwp7eCRu5E1MfZ21Ei8fDB5m2vmtkaA
X-Google-Smtp-Source: ABdhPJwIteApUoE0ElIlRWxnyKYviyGxpNVqKdiiwyEiqld/BjL3cyg2t0HJNVYLRgAPIF2l3VwOPw==
X-Received: by 2002:a17:907:3d87:: with SMTP id he7mr3159446ejc.26.1616686203921;
        Thu, 25 Mar 2021 08:30:03 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:30:03 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-rc 17/24] block/rnbd-clt: Fix missing a memory free when unloading the module
Date:   Thu, 25 Mar 2021 16:29:04 +0100
Message-Id: <20210325152911.1213627-18-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
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
index 2452eb67547c..885074f2f734 100644
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

