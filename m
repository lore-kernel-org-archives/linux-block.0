Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E73CC433F2
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180CD619BB
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhC3Him (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhC3HiM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAE5C0613DA
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l4so23295360ejc.10
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0w1fRI368Vhqwr68IvgBQDB9m3lTg5l6TH+c+9pCq5Y=;
        b=TzfF9wG+Gt/9vMietHhE+uWl1uTo56lFxouA7vW3f/gT3TEU0lZCxf4MFSpUDJGBmx
         1PAT/2XsSDEhGOe1/hfBQrJTyugtfwq/+EMUjou1UHdd5uv9zo4obxLkXO67yWDpRolg
         cXMwiyjgjD0PTvT5+t8+UqkhutQ4w74+imTedPF2N1JAVpxsUhbOsE8WMbj8N143ojMY
         NrdToT++S9aeYgP6hiSXSAwZSKVC311Ta4/7E6U6AXkXgTJtRPavOpSIALqTVaZH/I+m
         dYrnj2WHzvt4+QYhiL9M6NjZmKgU+hvypH5SDZ9bH7g7/YNJn9A+VDCGiW1h5uphd+FL
         xRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0w1fRI368Vhqwr68IvgBQDB9m3lTg5l6TH+c+9pCq5Y=;
        b=Bm3woTQ9/qRwB//6jhdXCMGR90bN+HqNMHh7P3bUZ2NAeKFoNj3IzxiabNtSnBSlEY
         gnRtnlqtdq53HQYiS8+9W5rnLAkLXsID4Jdou585v6hQWqG1+deSZYacQSfwlqyVx1mJ
         vyJA12w/gOLFIDDb81Rcn9BSp/TyD3DKqVZPFgxK8VTumjZyaC9YE+nU7/1EjAAM+Wxv
         s7e7ikXjh3LPSxw1ualY/dmXQ4JrNXNKDKB7Ujn3pKwgQsXe6n/lnS7Tg9+rJzGBNyOj
         H6fNq+OnmeMP1YSl96YZVvwBUkBvaCQvNsS0ROQe0bV/NceSyyDd/UZlEpuRIhEkvgW0
         nzQQ==
X-Gm-Message-State: AOAM532vuVJrmeRtwbMpOlts0dEIgUHoVg1e1gkdtHSTQ0N5VbuzCy6R
        UIjeqvoovuK1+zk+4gSZfUR0TM2OMkX3PFZB
X-Google-Smtp-Source: ABdhPJyCMLea2iRENozdOiYsl5e18pR+YACobOvhcrvugszO8g4rRrBp6lfXpG2S6Clf8kPiQ1xv6Q==
X-Received: by 2002:a17:907:a06b:: with SMTP id ia11mr31661080ejc.294.1617089890631;
        Tue, 30 Mar 2021 00:38:10 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:10 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 17/24] block/rnbd-clt: Fix missing a memory free when unloading the module
Date:   Tue, 30 Mar 2021 09:37:45 +0200
Message-Id: <20210330073752.1465613-18-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
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

