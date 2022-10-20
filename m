Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88647C43219
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 16:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJTQrS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 12:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJTQrR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 12:47:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E505A1DB273
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Frr/jgafOwZasG/6Q0XqnzmxbSChTXY6HZeyCw7KFlo=; b=u4kAU0WNCzmnkuVjCkT8zOnPCe
        Fhvvilb8BidGnbsPTylq7vuDeJEDcrS+5nlqcymBgNnkLaqvLMuAkJM4UFqUk+ZyuM5/whJ5O/eIN
        /yUMqZiqQbynJxHh1KQDCM05eHwJHm6E/Wp86N68gMrDtFt9NLYIdekJoOPwNZxuP9+MKmT/Qbc4Q
        0jZeUejjjYsCU2yueG8WPQhvdeWcPEiCt5j/mWp/kvu75xM8mUdX5nePMYF1FnrT41zRAC72L4kgO
        1L8zBI2jJsBS8RqZiiWWvUIZzojwrld5/IemXllbXWP/vE5mz6Q36bA8Bh3iAIo5epJLyG9B2CzDK
        rFHkJ8sQ==;
Received: from [205.220.129.26] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olYhF-000Wij-B9; Thu, 20 Oct 2022 16:47:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 5/6] dm: track per-add_disk holder relations in DM
Date:   Thu, 20 Oct 2022 09:46:04 -0700
Message-Id: <20221020164605.1764830-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020164605.1764830-1-hch@lst.de>
References: <20221020164605.1764830-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dm is a bit special in that it opens the underlying devices.  Commit
89f871af1b26 ("dm: delay registering the gendisk") tried to accomodate
that by allowing to add the holder to the list before add_gendisk and
then just add them to sysfs once add_disk is called.  But that leads to
really odd lifetime problems and error handling problems as we can't
know the state of the kobjects and don't unwind properly.  To fix this
switch to just registering all existing table_devices with the holder
code right after add_disk, and remove them before calling del_gendisk.

Fixes: 89f871af1b26 ("dm: delay registering the gendisk")
Reported-by: Yu Kuai <yukuai1@huaweicloud.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f592d34bd20ed..a9c750abd5365 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -751,9 +751,16 @@ static struct table_device *open_table_device(struct mapped_device *md,
 		goto out_free_td;
 	}
 
-	r = bd_link_disk_holder(bdev, dm_disk(md));
-	if (r)
-		goto out_blkdev_put;
+	/*
+	 * We can be called before the dm disk is added.  In that case we can't
+	 * register the holder relation here.  It will be done once add_disk was
+	 * called.
+	 */
+	if (md->disk->slave_dir) {
+		r = bd_link_disk_holder(bdev, md->disk);
+		if (r)
+			goto out_blkdev_put;
+	}
 
 	td->dm_dev.mode = mode;
 	td->dm_dev.bdev = bdev;
@@ -774,7 +781,8 @@ static struct table_device *open_table_device(struct mapped_device *md,
  */
 static void close_table_device(struct table_device *td, struct mapped_device *md)
 {
-	bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
+	if (md->disk->slave_dir)
+		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
 	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
 	put_dax(td->dm_dev.dax_dev);
 	list_del(&td->list);
@@ -1951,7 +1959,13 @@ static void cleanup_mapped_device(struct mapped_device *md)
 		md->disk->private_data = NULL;
 		spin_unlock(&_minor_lock);
 		if (dm_get_md_type(md) != DM_TYPE_NONE) {
+			struct table_device *td;
+
 			dm_sysfs_exit(md);
+			list_for_each_entry(td, &md->table_devices, list) {
+				bd_unlink_disk_holder(td->dm_dev.bdev,
+						      md->disk);
+			}
 			del_gendisk(md->disk);
 		}
 		dm_queue_destroy_crypto_profile(md->queue);
@@ -2285,6 +2299,7 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 {
 	enum dm_queue_mode type = dm_table_get_type(t);
 	struct queue_limits limits;
+	struct table_device *td;
 	int r;
 
 	switch (type) {
@@ -2317,13 +2332,27 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 	if (r)
 		return r;
 
-	r = dm_sysfs_init(md);
-	if (r) {
-		del_gendisk(md->disk);
-		return r;
+	/*
+	 * Register the holder relationship for devices added before the disk
+	 * was live.
+	 */
+	list_for_each_entry(td, &md->table_devices, list) {
+		r = bd_link_disk_holder(td->dm_dev.bdev, md->disk);
+		if (r)
+			goto out_undo_holders;
 	}
+
+	r = dm_sysfs_init(md);
+	if (r)
+		goto out_undo_holders;
 	md->type = type;
 	return 0;
+
+out_undo_holders:
+	list_for_each_entry_continue_reverse(td, &md->table_devices, list)
+		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
+	del_gendisk(md->disk);
+	return r;
 }
 
 struct mapped_device *dm_get_md(dev_t dev)
-- 
2.30.2

