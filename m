Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6427C433E0
	for <linux-block@archiver.kernel.org>; Sat,  6 Feb 2021 03:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A399664E3D
	for <linux-block@archiver.kernel.org>; Sat,  6 Feb 2021 03:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhBFDDQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhBFCxQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Feb 2021 21:53:16 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15459C033276;
        Fri,  5 Feb 2021 17:27:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g10so11266325eds.2;
        Fri, 05 Feb 2021 17:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2a5auNcC8hyslH3hMRT43LwrNwewdveLVCD1Z1iz3VQ=;
        b=lsWbhcymtcbL/BLa6TT/WHUzveis/tlVJMaaObL8Synt8ipPKown2EzD8YJr/cfUia
         9HMRDO0Unln6GuDAbf6FiEsFWtbFh3VDMXFfV/ou7oZ8iVhSiEED2NAW/doXsrb/aQ8m
         cw3fc93mfyk3nFIgsTJ1iqvyVxfp5uRl7cahCsvZjVHbEDQNgc60E+FWMuV2rBFsh6gz
         iMb+a8JGzFG0DjQpE5MyQfJLAofnbAlqFJj8VwX0SotwHLaCtKbk9XiTyf+RVmG5weoV
         YXchZMgupnPCsKHfH1W+VMfNExgGisygIl81Ix2OtY/qG+zAVPuuuQNm6/puLejxmkUY
         3okw==
X-Gm-Message-State: AOAM531c/t6Id8VVvWbQeXInSa4AgtXe2CFzV8fpUWb/vykThv+Jk1xl
        7FaDIRHK5eUY3khjKxZtClkT6GP6+nU=
X-Google-Smtp-Source: ABdhPJz02VPiKSDbNqNSupklBs5AR5sMy4zhBnnX/8eU+1FMui9VP3nQp/lkaeT+QmVJnxDmaDusyA==
X-Received: by 2002:adf:fc88:: with SMTP id g8mr7336711wrr.259.1612570358934;
        Fri, 05 Feb 2021 16:12:38 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-37-182-2-234.cust.vodafonedsl.it. [37.182.2.234])
        by smtp.gmail.com with ESMTPSA id d3sm14566390wrp.79.2021.02.05.16.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 16:12:38 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3/5] block: refactor sysfs code
Date:   Sat,  6 Feb 2021 01:09:01 +0100
Message-Id: <20210206000903.215028-4-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210206000903.215028-1-mcroce@linux.microsoft.com>
References: <20210206000903.215028-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Move the sysfs register code from a function named disk_add_events() to
a new function named disk_add_sysfs(). Also, rename the attribute list
with a more generic name than disk_events_attrs.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 block/genhd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 4dbf589e1610..a59a35cf452c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -41,6 +41,7 @@ static void disk_alloc_events(struct gendisk *disk);
 static void disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
+static void disk_add_sysfs(struct gendisk *disk);
 
 void set_capacity(struct gendisk *disk, sector_t sectors)
 {
@@ -760,6 +761,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 */
 	WARN_ON_ONCE(!blk_get_queue(disk->queue));
 
+	disk_add_sysfs(disk);
 	disk_add_events(disk);
 	blk_integrity_add(disk);
 }
@@ -2049,7 +2051,7 @@ static const DEVICE_ATTR(events_poll_msecs, 0644,
 			 disk_events_poll_msecs_show,
 			 disk_events_poll_msecs_store);
 
-static const struct attribute *disk_events_attrs[] = {
+static const struct attribute *disk_sysfs_attrs[] = {
 	&dev_attr_events.attr,
 	&dev_attr_events_async.attr,
 	&dev_attr_events_poll_msecs.attr,
@@ -2120,13 +2122,16 @@ static void disk_alloc_events(struct gendisk *disk)
 	disk->ev = ev;
 }
 
-static void disk_add_events(struct gendisk *disk)
+static void disk_add_sysfs(struct gendisk *disk)
 {
 	/* FIXME: error handling */
-	if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs) < 0)
+	if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_sysfs_attrs) < 0)
 		pr_warn("%s: failed to create sysfs files for events\n",
 			disk->disk_name);
+}
 
+static void disk_add_events(struct gendisk *disk)
+{
 	if (!disk->ev)
 		return;
 
@@ -2151,7 +2156,7 @@ static void disk_del_events(struct gendisk *disk)
 		mutex_unlock(&disk_events_mutex);
 	}
 
-	sysfs_remove_files(&disk_to_dev(disk)->kobj, disk_events_attrs);
+	sysfs_remove_files(&disk_to_dev(disk)->kobj, disk_sysfs_attrs);
 }
 
 static void disk_release_events(struct gendisk *disk)
-- 
2.29.2

