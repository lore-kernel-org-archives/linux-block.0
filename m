Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610CBC433B4
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 00:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2498D613CA
	for <linux-block@archiver.kernel.org>; Thu, 13 May 2021 00:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhEMAPg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 20:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349493AbhEMANK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 20:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620864681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=27LjNOkqy8rW9bMRzRUnCxI4Ut4jaKu7TmMHUowmhqk=;
        b=XSrMlR+g+EbXLmYAJnVVA40JiXsP1RGMNaksAglD1sNrRRqbO30IQPkvdlO9oBkOY6PsU6
        vckZn0ps4W2yz6ERK6zEDMd0QMS4cat2t6Pdn6jdJ3v858t1y8PH7xQyC4uKrPF+8e3qiS
        iAp154PY3sj8dUmogW6fSq6scZCkNW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-JXA3Y9xfMvu5Ee867RbmqQ-1; Wed, 12 May 2021 20:11:19 -0400
X-MC-Unique: JXA3Y9xfMvu5Ee867RbmqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B22B80293C;
        Thu, 13 May 2021 00:11:18 +0000 (UTC)
Received: from T590 (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E20045D9D7;
        Thu, 13 May 2021 00:11:11 +0000 (UTC)
Date:   Thu, 13 May 2021 08:11:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, Gulam Mohamed <gulam.mohamed@oracle.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: prevent block device lookups at the beginning
 of del_gendisk
Message-ID: <YJxumkhqBTsDc9np@T590>
References: <20210512165050.628550-1-hch@lst.de>
 <20210512165050.628550-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512165050.628550-2-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 12, 2021 at 06:50:49PM +0200, Christoph Hellwig wrote:
> As an aritfact of how gendisk lookup used to work in earlier kernels,
> GENHD_FL_UP is only cleared very late in del_gendisk, and instead a
> global lock is used to prevent opens from actually succeeding.  Clear
> the flag, and remove the bdev inode from the inode hash earlier to
> ensure lookups fail from the very beginning of del_gendisk, and remove
> the now not needed bdev_lookup_sem.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c         | 19 ++-----------------
>  fs/block_dev.c        |  9 +--------
>  include/linux/genhd.h |  2 --
>  3 files changed, 3 insertions(+), 27 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 39ca97b0edc6..1693e520ec7d 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -29,8 +29,6 @@
>  
>  static struct kobject *block_depr;
>  
> -DECLARE_RWSEM(bdev_lookup_sem);
> -
>  /* for extended dynamic devt allocation, currently only one major is used */
>  #define NR_EXT_DEVT		(1 << MINORBITS)
>  static DEFINE_IDA(ext_devt_ida);
> @@ -609,28 +607,15 @@ void del_gendisk(struct gendisk *disk)
>  	blk_integrity_del(disk);
>  	disk_del_events(disk);
>  
> -	/*
> -	 * Block lookups of the disk until all bdevs are unhashed and the
> -	 * disk is marked as dead (GENHD_FL_UP cleared).
> -	 */
> -	down_write(&bdev_lookup_sem);
> -
>  	mutex_lock(&disk->part0->bd_mutex);
> +	disk->flags &= ~GENHD_FL_UP;
> +	remove_inode_hash(disk->part0->bd_inode);
>  	blk_drop_partitions(disk);
>  	mutex_unlock(&disk->part0->bd_mutex);

Both bdget() and checking FL_UP is done without holding ->bd_mutex, so
del_gendisk() may be run after checking FL_UP is completed in blkdev_get_no_open(),
then new opener is still allowed even after the bdev is invalidated.

Given this patch is for 5.13, I'd suggest to not move remove_inode_hash()
inside the lock block, which isn't necessary, and it is enough to move
clearing FL_UP with the following change together:

diff --git a/fs/block_dev.c b/fs/block_dev.c
index b8abccd03e5d..31a6d54edf6d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1298,6 +1298,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 	struct gendisk *disk = bdev->bd_disk;
 	int ret = 0;
 
+	if (!(disk->flags & GENHD_FL_UP))
+		return -ENXIO;
+
 	if (!bdev->bd_openers) {
 		if (!bdev_is_partition(bdev)) {
 			ret = 0;
@@ -1332,8 +1335,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode)
 			whole->bd_part_count++;
 			mutex_unlock(&whole->bd_mutex);
 
-			if (!(disk->flags & GENHD_FL_UP) ||
-			    !bdev_nr_sectors(bdev)) {
+			if (!bdev_nr_sectors(bdev)) {
 				__blkdev_put(whole, mode, 1);
 				bdput(whole);
 				return -ENXIO;


Thanks,
Ming

