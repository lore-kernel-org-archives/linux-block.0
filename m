Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34BEC43217
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 08:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiBIIVg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 03:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbiBIIVf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 03:21:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B16C05CB82;
        Wed,  9 Feb 2022 00:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ilg8MRKs3UhBiK+Mujp47+wrzj58nCf6OMRjMHqSUG8=; b=0HfqCHi/cYkXl1l44ziZ7rH0fD
        Q4o5faCZ0mTKlDobx/Mos2uvSD+rwL7LJ2xFjtWXRf4W+6pPSdvlC2PJEYSvKrtizdXZk8HrRgGpo
        9LOMTBrvWN6yoWxB/zbA460GhB9azcRUyKtqhGbIy3dSQOK5ezCLIgzA+dYahk2wQM2G05CiSviyO
        6O9LAWp7c+aheeQqmb41PV4X3J40wdXWHw4zGoGBInziqgjXfZ9z8zd05pl7Nmw257SFvE6jR+993
        WDtmBeiNVtWuHiXMGNWgXkT0zpHq0LG0pdszYL7njlonHr4rShgsi+vIqXeLPh32IDFvbPqP7o1f/
        wtCQJgKw==;
Received: from [2001:4bb8:188:3efc:ea2:7599:7eeb:4b5a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHiEE-00GbB7-5O; Wed, 09 Feb 2022 08:21:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 2/5] memstick/ms_block: simplify refcounting
Date:   Wed,  9 Feb 2022 09:21:17 +0100
Message-Id: <20220209082121.2628452-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209082121.2628452-1-hch@lst.de>
References: <20220209082121.2628452-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Implement the ->free_disk method to free the msb_data structure only once
the last gendisk reference goes away instead of keeping a local refcount.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/memstick/core/ms_block.c | 64 ++++++++------------------------
 drivers/memstick/core/ms_block.h |  1 -
 2 files changed, 15 insertions(+), 50 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 0cda6c6baefc3..3993bdd4b519c 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1943,22 +1943,6 @@ static void msb_io_work(struct work_struct *work)
 static DEFINE_IDR(msb_disk_idr); /*set of used disk numbers */
 static DEFINE_MUTEX(msb_disk_lock); /* protects against races in open/release */
 
-static int msb_bd_open(struct block_device *bdev, fmode_t mode)
-{
-	struct gendisk *disk = bdev->bd_disk;
-	struct msb_data *msb = disk->private_data;
-
-	dbg_verbose("block device open");
-
-	mutex_lock(&msb_disk_lock);
-
-	if (msb && msb->card)
-		msb->usage_count++;
-
-	mutex_unlock(&msb_disk_lock);
-	return 0;
-}
-
 static void msb_data_clear(struct msb_data *msb)
 {
 	kfree(msb->boot_page);
@@ -1968,33 +1952,6 @@ static void msb_data_clear(struct msb_data *msb)
 	msb->card = NULL;
 }
 
-static int msb_disk_release(struct gendisk *disk)
-{
-	struct msb_data *msb = disk->private_data;
-
-	dbg_verbose("block device release");
-	mutex_lock(&msb_disk_lock);
-
-	if (msb) {
-		if (msb->usage_count)
-			msb->usage_count--;
-
-		if (!msb->usage_count) {
-			disk->private_data = NULL;
-			idr_remove(&msb_disk_idr, msb->disk_id);
-			put_disk(disk);
-			kfree(msb);
-		}
-	}
-	mutex_unlock(&msb_disk_lock);
-	return 0;
-}
-
-static void msb_bd_release(struct gendisk *disk, fmode_t mode)
-{
-	msb_disk_release(disk);
-}
-
 static int msb_bd_getgeo(struct block_device *bdev,
 				 struct hd_geometry *geo)
 {
@@ -2003,6 +1960,17 @@ static int msb_bd_getgeo(struct block_device *bdev,
 	return 0;
 }
 
+static void msb_bd_free_disk(struct gendisk *disk)
+{
+	struct msb_data *msb = disk->private_data;
+
+	mutex_lock(&msb_disk_lock);
+	idr_remove(&msb_disk_idr, msb->disk_id);
+	mutex_unlock(&msb_disk_lock);
+
+	kfree(msb);
+}
+
 static blk_status_t msb_queue_rq(struct blk_mq_hw_ctx *hctx,
 				 const struct blk_mq_queue_data *bd)
 {
@@ -2096,10 +2064,9 @@ static void msb_start(struct memstick_dev *card)
 }
 
 static const struct block_device_operations msb_bdops = {
-	.open    = msb_bd_open,
-	.release = msb_bd_release,
-	.getgeo  = msb_bd_getgeo,
-	.owner   = THIS_MODULE
+	.owner		= THIS_MODULE,
+	.getgeo		= msb_bd_getgeo,
+	.free_disk	= msb_bd_free_disk, 
 };
 
 static const struct blk_mq_ops msb_mq_ops = {
@@ -2147,7 +2114,6 @@ static int msb_init_disk(struct memstick_dev *card)
 	set_capacity(msb->disk, capacity);
 	dbg("Set total disk size to %lu sectors", capacity);
 
-	msb->usage_count = 1;
 	msb->io_queue = alloc_ordered_workqueue("ms_block", WQ_MEM_RECLAIM);
 	INIT_WORK(&msb->io_work, msb_io_work);
 	sg_init_table(msb->prealloc_sg, MS_BLOCK_MAX_SEGS+1);
@@ -2229,7 +2195,7 @@ static void msb_remove(struct memstick_dev *card)
 	msb_data_clear(msb);
 	mutex_unlock(&msb_disk_lock);
 
-	msb_disk_release(msb->disk);
+	put_disk(msb->disk);
 	memstick_set_drvdata(card, NULL);
 }
 
diff --git a/drivers/memstick/core/ms_block.h b/drivers/memstick/core/ms_block.h
index 122e1a8a8bd5b..7058f9aefeb92 100644
--- a/drivers/memstick/core/ms_block.h
+++ b/drivers/memstick/core/ms_block.h
@@ -143,7 +143,6 @@ struct ms_boot_page {
 } __packed;
 
 struct msb_data {
-	unsigned int			usage_count;
 	struct memstick_dev		*card;
 	struct gendisk			*disk;
 	struct request_queue		*queue;
-- 
2.30.2

