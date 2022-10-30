Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B6EECAAA1
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 15:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJ3PcK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJ3PcG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 11:32:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3DAB1DA
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=26EtRfRL6phUjf0F1YzPlLYas95/IR0DO2Dipx+s5No=; b=gbcVDyBrRl6xv782lwm8J23+hg
        SCUSCdCT7vXg77JP1rK5w7xXmkl2RKwMMl+I7VTOBJSbd5YlBHeYcbDlFnfqS410kArwxflfK6tnZ
        0/k1iXZPxoDPrvON1UQWzeT44O88Po57sTQoWXkRmRUa8o9ELTgnWchHahd/2hFxewH8+B/7j/Uwp
        v11DSSyex3qqwEcM3Zq7IKNFWigV+SZqjKdfK7T5L2PUr8TpM00q5uBj8qY/YnNlXzmbq74KwX6dF
        iGeT26QJ2A2K591fhAsxRVN818Ijav2PfqXdAvRXSUK5qchMX0qiZO2cxsZPBSInRGwBdgx6CuxXG
        JiZPt1vw==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opAHz-00HW4C-54; Sun, 30 Oct 2022 15:31:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 7/7] block: store the holder kobject in bd_holder_disk
Date:   Sun, 30 Oct 2022 16:31:19 +0100
Message-Id: <20221030153120.1045101-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221030153120.1045101-1-hch@lst.de>
References: <20221030153120.1045101-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We hold a reference to the holder kobject for each bd_holder_disk,
so to make the code a bit more robust, use a reference to it instead
of the block_device.  As long as no one clears ->bd_holder_dir in
before freeing the disk, this isn't strictly required, but it does
make the code more clear and more robust.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/holder.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/block/holder.c b/block/holder.c
index dd9327b43ce05..a8c355b9d0806 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -4,7 +4,7 @@
 
 struct bd_holder_disk {
 	struct list_head	list;
-	struct block_device	*bdev;
+	struct kobject		*holder_dir;
 	int			refcnt;
 };
 
@@ -14,7 +14,7 @@ static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
 	struct bd_holder_disk *holder;
 
 	list_for_each_entry(holder, &disk->slave_bdevs, list)
-		if (holder->bdev == bdev)
+		if (holder->holder_dir == bdev->bd_holder_dir)
 			return holder;
 	return NULL;
 }
@@ -82,27 +82,24 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	}
 
 	INIT_LIST_HEAD(&holder->list);
-	holder->bdev = bdev;
 	holder->refcnt = 1;
+	holder->holder_dir = kobject_get(bdev->bd_holder_dir);
+
 	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
 	if (ret)
-		goto out_free_holder;
-	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
+		goto out_put_holder_dir;
+	ret = add_symlink(holder->holder_dir, &disk_to_dev(disk)->kobj);
 	if (ret)
 		goto out_del_symlink;
 	list_add(&holder->list, &disk->slave_bdevs);
 
-	/*
-	 * del_gendisk drops the initial reference to bd_holder_dir, so we need
-	 * to keep our own here to allow for cleanup past that point.
-	 */
-	kobject_get(bdev->bd_holder_dir);
 	mutex_unlock(&disk->open_mutex);
 	return 0;
 
 out_del_symlink:
 	del_symlink(disk->slave_dir, bdev_kobj(bdev));
-out_free_holder:
+out_put_holder_dir:
+	kobject_put(holder->holder_dir);
 	kfree(holder);
 out_unlock:
 	mutex_unlock(&disk->open_mutex);
@@ -131,8 +128,8 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	holder = bd_find_holder_disk(bdev, disk);
 	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
 		del_symlink(disk->slave_dir, bdev_kobj(bdev));
-		del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
-		kobject_put(bdev->bd_holder_dir);
+		del_symlink(holder->holder_dir, &disk_to_dev(disk)->kobj);
+		kobject_put(holder->holder_dir);
 		list_del_init(&holder->list);
 		kfree(holder);
 	}
-- 
2.30.2

