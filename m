Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4831BC43461
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BAD6188B
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhELHD2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 03:03:28 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:42774 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhELHDX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 03:03:23 -0400
Received: by mail-pl1-f170.google.com with SMTP id v13so12031643ple.9;
        Wed, 12 May 2021 00:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZ0IxpSh8xr9wyrM4RrrmQ6WXGElKACchuNszgGoCn4=;
        b=lfmbfksBJfeAlNhjpA6FF7BRwboC2vUXfbe8Q5csFRHXKlY/pzvfCjpnkm52JZ9NNI
         fK/SP4E92c8EpelXikZ/I7D2pHUi9ENOgANuh1avXaLGYn4lCH810apzHnlx4eIR7Hcn
         q7xek+WQgjaiW0vcDY64wnWP8bQV9yS8t3a1nq7j9HgzqTPxNKLT26oFBGEh+3U5P6IH
         ayZjx0IhQ8jwZFlUPUzsRPFOOewO66PnMLDSA1WY2j70/voxxSHDeLl2f+gcJXK2Yk/k
         I7Fo0/pLJWiS00YiaPTJyN+tHzI2YMXO0xGGU7ZiCXfvoiAJdFiMQtWaVjENMuvHi0LE
         JkqA==
X-Gm-Message-State: AOAM530TBFfp3nsKq+WbwBwc3i208Bs7ua1LUttW8eUFKqOZfxDjMM0H
        XH0PhtduD18UCkEPb8WWJpo=
X-Google-Smtp-Source: ABdhPJwsKbtoRfqGHYdcSWWrPu+ZoFirhquWVeu9aUGVwLwodrsB9FMX2qIiap+52tAfiyLMqkv6qA==
X-Received: by 2002:a17:902:f203:b029:ee:af8f:8e4b with SMTP id m3-20020a170902f203b02900eeaf8f8e4bmr33054652plc.23.1620802934281;
        Wed, 12 May 2021 00:02:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y3sm13095443pfl.153.2021.05.12.00.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:02:04 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 28161423BF; Wed, 12 May 2021 06:46:35 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v1 2/8] block: move disk announce work from register_disk() to a helper
Date:   Wed, 12 May 2021 06:46:23 +0000
Message-Id: <20210512064629.13899-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210512064629.13899-1-mcgrof@kernel.org>
References: <20210512064629.13899-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This moves quite a bit of code which does one thing into a helper.
We currently do not check for errors but we may decide that might
be desirable later.

This also makes the code easier to read.

This change has no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 51dff87c4756..484cda981b4e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -429,6 +429,15 @@ static void disk_scan_partitions(struct gendisk *disk)
 		blkdev_put(bdev, FMODE_READ);
 }
 
+static void disk_announce(struct gendisk *disk)
+{
+	struct device *ddev = disk_to_dev(disk);
+
+	/* announce the disk and partitions after all partitions are created */
+	dev_set_uevent_suppress(ddev, 0);
+	disk_uevent(disk, KOBJ_ADD);
+}
+
 static void register_disk(struct device *parent, struct gendisk *disk,
 			  const struct attribute_group **groups)
 {
@@ -472,10 +481,7 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 		return;
 
 	disk_scan_partitions(disk);
-
-	/* announce the disk and partitions after all partitions are created */
-	dev_set_uevent_suppress(ddev, 0);
-	disk_uevent(disk, KOBJ_ADD);
+	disk_announce(disk);
 
 	if (disk->queue->backing_dev_info->dev) {
 		err = sysfs_create_link(&ddev->kobj,
-- 
2.30.2

