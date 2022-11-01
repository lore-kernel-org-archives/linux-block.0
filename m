Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F7FC433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 11:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKALVh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 07:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKALVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 07:21:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DE1112E
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 04:21:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3AD4D6732D; Tue,  1 Nov 2022 12:21:32 +0100 (CET)
Date:   Tue, 1 Nov 2022 12:21:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 7/7] block: store the holder kobject in bd_holder_disk
Message-ID: <20221101112131.GA14379@lst.de>
References: <20221030153120.1045101-1-hch@lst.de> <20221030153120.1045101-8-hch@lst.de> <fd409996-e5e1-d7af-b31d-87db943eaa25@huaweicloud.com> <20221101104927.GA13823@lst.de> <d3f6ec1d-8141-19d1-ce4c-d42710f4a636@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3f6ec1d-8141-19d1-ce4c-d42710f4a636@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 01, 2022 at 07:12:51PM +0800, Yu Kuai wrote:
>> But how could the reference be 0 here?  The driver that calls
>> bd_link_disk_holder must have the block device open and thus hold a
>> reference to it.
>
> Like I said before, the caller of bd_link_disk_holder() get bdev by
> blkdev_get_by_dev(), which do not grab reference of holder_dir, and
> grab disk reference can only prevent disk_release() to be called, not
> del_gendisk() while holder_dir reference is dropped in del_gendisk()
> and can be decreased to 0.

Oh, the bd_holder_dir reference, not the block_device one.  So yes,
I agree.

> If you agree with above explanation, I tried to fix this:
>
> 1) move kobject_put(bd_holder_dir) from del_gendisk to disk_release,
> there seems to be a lot of other dependencies.
>
> 2) protect bd_holder_dir reference by open_mutex.

I think simply switching the kobject_get in bd_link_disk_holder
into a kobject_get_unless_zero and unwinding if there is no reference
should be enough:

diff --git a/block/holder.c b/block/holder.c
index a8c355b9d0806..cd18064f6ff80 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -83,7 +83,11 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 
 	INIT_LIST_HEAD(&holder->list);
 	holder->refcnt = 1;
-	holder->holder_dir = kobject_get(bdev->bd_holder_dir);
+	if (!kobject_get_unless_zero(bdev->bd_holder_dir)) {
+		ret = -EBUSY;
+		goto out_free_holder;
+	}
+	holder->holder_dir = bdev->bd_holder_dir;
 
 	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
 	if (ret)
@@ -100,6 +104,7 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	del_symlink(disk->slave_dir, bdev_kobj(bdev));
 out_put_holder_dir:
 	kobject_put(holder->holder_dir);
+out_free_holder:
 	kfree(holder);
 out_unlock:
 	mutex_unlock(&disk->open_mutex);
