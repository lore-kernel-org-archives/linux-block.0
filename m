Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FC2FA3745
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 15:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJ3Pby (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 11:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJ3Pbx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 11:31:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5E5631C
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NiJnntTQNL/iuGMrxvWwXfMZgNi9d1s0llRGCRimOz4=; b=jOyqM9JD2PM3ouAIgTWkiieguP
        rhIxjjCIvz7pwTr7LK5R8CRILojXvNtI2+L7zzBO9iDuygs0o6aD0yVhZL1rGG068WVL8PLqYT0c5
        nx/CSI4x4P9K5bIWyDRC2fPk4huJDgxSt4izSNKoZT5nYbK762oWSj2PgPdK+IKSj/qU3B58Q+PuL
        uh45/AW94rmTES0KNsEXq+vPgWcSgVRP35DILxmi3KykM1Oz6/w2+egN7N5964vEED28D95MTgyPf
        Ts/RFrL1QzCbKm2srMuKt2hg4yQnlbsekICF6HhDwobb33VRhB2gis6iMrXNBaofwyiLWNucwhfWD
        3FG93BYQ==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opAHq-00HVtq-9o; Sun, 30 Oct 2022 15:31:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 4/7] dm: cleanup close_table_device
Date:   Sun, 30 Oct 2022 16:31:16 +0100
Message-Id: <20221030153120.1045101-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221030153120.1045101-1-hch@lst.de>
References: <20221030153120.1045101-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Take the list unlink and free into close_table_device so that no half
torn down table_devices exist.  Also remove the check for a NULL bdev
as that can't happen - open_table_device never adds a table_device to
the list that does not have a valid block_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 28d7581b6a826..2917700b1e15c 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -774,14 +774,11 @@ static struct table_device *open_table_device(struct mapped_device *md,
  */
 static void close_table_device(struct table_device *td, struct mapped_device *md)
 {
-	if (!td->dm_dev.bdev)
-		return;
-
 	bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
 	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
 	put_dax(td->dm_dev.dax_dev);
-	td->dm_dev.bdev = NULL;
-	td->dm_dev.dax_dev = NULL;
+	list_del(&td->list);
+	kfree(td);
 }
 
 static struct table_device *find_table_device(struct list_head *l, dev_t dev,
@@ -823,11 +820,8 @@ void dm_put_table_device(struct mapped_device *md, struct dm_dev *d)
 	struct table_device *td = container_of(d, struct table_device, dm_dev);
 
 	mutex_lock(&md->table_devices_lock);
-	if (refcount_dec_and_test(&td->count)) {
+	if (refcount_dec_and_test(&td->count))
 		close_table_device(td, md);
-		list_del(&td->list);
-		kfree(td);
-	}
 	mutex_unlock(&md->table_devices_lock);
 }
 
-- 
2.30.2

