Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73011C4320A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51573610FA
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbhHROyA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbhHROx7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:53:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0E5C061764
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=a2JloGblasW5oNsAQ+jctzqgD+TgZmEA/KKcUfVefPw=; b=lMZd7y8qlHKVJojrh5HoBg5Ww9
        EvlM6HYxdCSNxHrKCHyzE5jMYYPPfYSNMa9OGivXlTI3yrO0pQKkjOMBmgQhAFnvp775uXslff7Fr
        WuXW1OOK6DQ7d1pBXZsYA6gFanLUUkUSG9akK1p2donmdnbmw6J8ROQ7exrdzLdRCLlGhmnriWpDP
        GP/WOuQnv953dp/wIayy71Q2sYdGmKXmlCEwFuwlzreBR94HsKNqCGWt2VEXXTqCO5axgJQEEmbSm
        RR3A09q8mBQX7yy6SQdN7Y1oBFbibExLU2cDqDgma60sOaLl+pxNNi+RbX4J6j/ZYLrOcleNYFHrs
        orAaWFeg==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMv0-003wrg-DN; Wed, 18 Aug 2021 14:52:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 06/11] block: call blk_register_queue earlier in device_add_disk
Date:   Wed, 18 Aug 2021 16:45:37 +0200
Message-Id: <20210818144542.19305-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818144542.19305-1-hch@lst.de>
References: <20210818144542.19305-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ensure that all the sysfs bits are set up before bdev_add is called,
as that will make the upcomding error handling much easier.  However
this means the call to disk_update_readahead has to be split as that
requires a bdi.  Also remove various sanity checks that don't make
sense now that blk_register_queue only has a single caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 9 ---------
 block/genhd.c     | 5 +++--
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 7fd99487300c..614d9d47de36 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -856,15 +856,6 @@ int blk_register_queue(struct gendisk *disk)
 	struct device *dev = disk_to_dev(disk);
 	struct request_queue *q = disk->queue;
 
-	if (WARN_ON(!q))
-		return -ENXIO;
-
-	WARN_ONCE(blk_queue_registered(q),
-		  "%s is registering an already registered queue\n",
-		  kobject_name(&dev->kobj));
-
-	disk_update_readahead(disk);
-
 	ret = blk_trace_init_sysfs(dev);
 	if (ret)
 		return ret;
diff --git a/block/genhd.c b/block/genhd.c
index 75d900e4c82f..a54b4849242c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -508,6 +508,8 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 		disk->slave_dir = NULL;
 	}
 
+	blk_register_queue(disk);
+
 	if (disk->flags & GENHD_FL_HIDDEN) {
 		/*
 		 * Don't let hidden disks show up in /proc/partitions,
@@ -537,8 +539,7 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 		disk_uevent(disk, KOBJ_ADD);
 	}
 
-	blk_register_queue(disk);
-
+	disk_update_readahead(disk);
 	disk_add_events(disk);
 }
 EXPORT_SYMBOL(device_add_disk);
-- 
2.30.2

