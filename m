Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5A2C47082
	for <linux-block@archiver.kernel.org>; Sat,  5 Jun 2021 14:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30CE7613F4
	for <linux-block@archiver.kernel.org>; Sat,  5 Jun 2021 14:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhFEOLp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Jun 2021 10:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFEOLp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Jun 2021 10:11:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426F3C061766
        for <linux-block@vger.kernel.org>; Sat,  5 Jun 2021 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=W2cvlP/bg118gx4k3rfPskoyQ/zGhT6bmYWqx5nQy+E=; b=ZthSnnZvuz9r5UgaZ8ZTgEA/ff
        pLyUxqixzifHXowClIJh4VOami/F0+/1CbcVzDQYmfgIAlPFUQvdgL+7ZuNg3rZftWBZI5Z0A8GTQ
        hAKqGd/6LWT4wdl+pWp8wG9dWFjqZfuBtvVWB4Y0UTCCZ2O7mBxRlse+UKxQ0X6s/kbVgP1sW+6Ks
        Wk8HVd4/M00ZRnybOvlyAv6fK1+pMvh61LB3+bJGDoXD7joTzUgrgTSlg0fifds+2W0VrN+qxHoej
        TZoWdgQR90COEz54ieU1M8F5yTy276HBRYzkH+/GG/L4wcJldXykucYkn08aORtOWyDZ7v6wGMhra
        2z0R76gQ==;
Received: from [2001:4bb8:192:ff5f:391a:de7d:b6e9:977e] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpWzo-00Gew8-K7; Sat, 05 Jun 2021 14:09:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, pasha.tatashin@soleen.com,
        linux-block@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH] block: loop: fix deadlock between open and remove
Date:   Sat,  5 Jun 2021 17:09:50 +0300
Message-Id: <20210605140950.5800-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit c76f48eb5c08 ("block: take bd_mutex around delete_partitions in
del_gendisk") adds disk->part0->bd_mutex in del_gendisk(), this way
causes the following AB/BA deadlock between removing loop and opening
loop:

 1) loop_control_ioctl(LOOP_CTL_REMOVE)
     -> mutex_lock(&loop_ctl_mutex)
     -> del_gendisk
         -> mutex_lock(&disk->part0->bd_mutex)

 2) blkdev_get_by_dev
     -> mutex_lock(&disk->part0->bd_mutex)
     -> lo_open
         -> mutex_lock(&loop_ctl_mutex)

Add a new Lo_deleting state to remove the need for clearing
->private_data and thus holding loop_ctl_mutex in the ioctl
LOOP_CTL_REMOVE path.

Based on an analysis and earlier patch from
Ming Lei <ming.lei@redhat.com>.

Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: c76f48eb5c08 ("block: take bd_mutex around delete_partitions in del_gendisk")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 25 +++++++------------------
 drivers/block/loop.h |  1 +
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d58d68f3c7cd..76e12f3482a9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1879,29 +1879,18 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
-	struct loop_device *lo;
+	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
-	/*
-	 * take loop_ctl_mutex to protect lo pointer from race with
-	 * loop_control_ioctl(LOOP_CTL_REMOVE), however, to reduce contention
-	 * release it prior to updating lo->lo_refcnt.
-	 */
-	err = mutex_lock_killable(&loop_ctl_mutex);
-	if (err)
-		return err;
-	lo = bdev->bd_disk->private_data;
-	if (!lo) {
-		mutex_unlock(&loop_ctl_mutex);
-		return -ENXIO;
-	}
 	err = mutex_lock_killable(&lo->lo_mutex);
-	mutex_unlock(&loop_ctl_mutex);
 	if (err)
 		return err;
-	atomic_inc(&lo->lo_refcnt);
+	if (lo->lo_state == Lo_deleting)
+		err = -ENXIO;
+	else
+		atomic_inc(&lo->lo_refcnt);
 	mutex_unlock(&lo->lo_mutex);
-	return 0;
+	return err;
 }
 
 static void lo_release(struct gendisk *disk, fmode_t mode)
@@ -2285,7 +2274,7 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			mutex_unlock(&lo->lo_mutex);
 			break;
 		}
-		lo->lo_disk->private_data = NULL;
+		lo->lo_state = Lo_deleting;
 		mutex_unlock(&lo->lo_mutex);
 		idr_remove(&loop_index_idr, lo->lo_number);
 		loop_remove(lo);
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index a3c04f310672..5beb959b94d3 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -22,6 +22,7 @@ enum {
 	Lo_unbound,
 	Lo_bound,
 	Lo_rundown,
+	Lo_deleting,
 };
 
 struct loop_func_table;
-- 
2.30.2

