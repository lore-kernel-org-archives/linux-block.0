Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C61C433ED
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77130610E8
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbhDNMYp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350871AbhDNMYn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69F9C061574
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l4so31062976ejc.10
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kudgbHD2vmKiyqxiiVxPOr/XbfnTQZ5BaCjcZ6vN5kA=;
        b=cpbCVYxXeypB8JuBaj98AsjRy4gpHnkwRMLhA0wAQzk+Jrqaua9JRhXp4fkZjJ9PRL
         k3n0DCkC1hsvTpk1I7uy7dvHQ0mkxMpHdibgr30LrgtPwJS7feABOOEsV0sx7rBF46A1
         O1lJ9QoSt4MP2CaEUYn/aoHBaGiGhgG3sVscG7uvTQVHUK8DydqykUN6UlNMRFEdueXy
         HmhJS+M8y3ig3NrwoNubcbXtkrtQ/NNQdk6d+CqQWMgFjuFu3fHnA0InDbU0lDJOYB0Q
         hOlaPjRDrX5e/xTyCVE8hUlpls5IGxUe9J/x4ew3jvnycbwveBtmPk+jUUclWKJLfz0Z
         +jlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kudgbHD2vmKiyqxiiVxPOr/XbfnTQZ5BaCjcZ6vN5kA=;
        b=ZNDuCaG2SXNfDufevixmT31tJsvfDIo5eVfaQlgswlMabjcwd0HuNZx+JtusW3w87J
         kG4xJQcA3GmHtz1VLvy54Lo+PWJe7iq6hU4dOlMy3V1oDunIiRZPtW/b0dCJRgWlfweh
         +NdtFg1VWTAdUGqnzdvqxSFyBLOW40+g/5o9UhV2IywJneqSRNfPUXSFpOyfexP383gk
         y00LayLNp1lswbPd90G++k0CoWUG6eNvHpvk6EtgkEL5jqo1/vT1KUaezfknI44rWe50
         f1ecsVFyteRFNhWFwTa7OrS0oF6w59cBcvHcmza14FywukbxHtKVABakN9F42NQbpy3F
         8Zgw==
X-Gm-Message-State: AOAM53174ETqoRSbdR32BDaLYGBSn04XEv4+Z//uobx6Zo4ddg4IJTyz
        k1zFBqwSS7SWCwJJ3VXtFz3wnm1/p8CoUKYa
X-Google-Smtp-Source: ABdhPJw8GJsY5Ek+Vvw7KTUqZwY86shWdptkekuvFl3xZX76ce4z5fqWgegRY1JyPvD4qR1kd3ze4w==
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr9422011ejz.259.1618403059518;
        Wed, 14 Apr 2021 05:24:19 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:19 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv4 for-next 12/19] block/rnbd-clt: Fix missing a memory free when unloading the module
Date:   Wed, 14 Apr 2021 14:23:55 +0200
Message-Id: <20210414122402.203388-13-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
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

