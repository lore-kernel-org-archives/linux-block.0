Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157FDC433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 16:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbhLUQS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 11:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbhLUQS5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 11:18:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF72DC061574
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 08:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=yll7nt3nRnHgj0EuNAl5ZlNUl1Z5RGGx2f/PYKT7y28=; b=lT12ktL00QzNJYgpKQBB42eA8d
        VDoVAkvtR/S7JY+8its3K43fXbt1GoqxxFPqP2zueU/HR4zQ5lxXfHBRM3bWlDp3zviKfpNdOf8eo
        Q2uqNkvLOUbznGD88YvySm2DEEC7Ey28oad8Mtw6peGoN0P3CMh392V1lXscKdWN4/ikTNnvQ8sYM
        rgjPNIsw/EbD8WyeMuA7CF3/1GsQv6oopogFLRnz5nb2oonUxcmYoP/iP5W+xzWkfLgxGs9IwPl3B
        vC86a7anhAAniZp/rQivYcmcFbf+PM9kKh2bwl32Tgl/gTH8ggXbYabCObTZdJFhKMKWuebxJEmfY
        fZ/xqzzg==;
Received: from [2001:4bb8:188:3825:7066:8068:a6be:a483] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzhqn-002cbi-7J; Tue, 21 Dec 2021 16:18:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        syzbot <syzbot+28a66a9fbc621c939000@syzkaller.appspotmail.com>
Subject: [PATCH] block: fix error unwinding in device_add_disk
Date:   Tue, 21 Dec 2021 17:18:51 +0100
Message-Id: <20211221161851.788424-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

One device_add is called disk->ev will be freed by disk_release, so we
should free it twice.  Fix this by allocating disk->ev after device_add
so that the extra local unwinding can be removed entirely.

Based on an earlier patch from Tetsuo Handa.

Reported-by: syzbot <syzbot+28a66a9fbc621c939000@syzkaller.appspotmail.com>
Tested-by: syzbot <syzbot+28a66a9fbc621c939000@syzkaller.appspotmail.com>
Fixes: 83cbce9574462c6b ("block: add error handling for device_add_disk / add_disk")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 3c139a1b6f049..603db5d6f10c0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -442,10 +442,6 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		disk->first_minor = ret;
 	}
 
-	ret = disk_alloc_events(disk);
-	if (ret)
-		goto out_free_ext_minor;
-
 	/* delay uevents, until we scanned partition table */
 	dev_set_uevent_suppress(ddev, 1);
 
@@ -456,7 +452,12 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		ddev->devt = MKDEV(disk->major, disk->first_minor);
 	ret = device_add(ddev);
 	if (ret)
-		goto out_disk_release_events;
+		goto out_free_ext_minor;
+
+	ret = disk_alloc_events(disk);
+	if (ret)
+		goto out_device_del;
+
 	if (!sysfs_deprecated) {
 		ret = sysfs_create_link(block_depr, &ddev->kobj,
 					kobject_name(&ddev->kobj));
@@ -538,8 +539,6 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		sysfs_remove_link(block_depr, dev_name(ddev));
 out_device_del:
 	device_del(ddev);
-out_disk_release_events:
-	disk_release_events(disk);
 out_free_ext_minor:
 	if (disk->major == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(disk->first_minor);
-- 
2.30.2

